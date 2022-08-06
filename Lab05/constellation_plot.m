if constellation_plot
            if flg_const_plot_create
                flg_const_plot_create = 0;
                fig2 = figure('units','normalized','outerposition',[0 0 1 1]);
                axes2 = axes('parent', fig2,'FontName','Calibri','FontSize',18);
                grid(axes2,'on');
                hold(axes2,'all');
                scatter_hndl = scatter(zeros(size(rx_sym,1),1), zeros(size(rx_sym,1),1));
                axis([-1.5 1.5 -1.5 1.5]);
                axis square
                xlabel('In-phase Amplitude','FontSize',24,'FontName','Calibri')
                ylabel('Quadrature Amplitude','FontSize',24,'FontName','Calibri')
                title(['Constellation of ', num2str(M),upper(modulation) , ' Modulation'],'FontSize',24,'FontName','Calibri')
                grid on
            end
            switch modulation
                case {'psk', 'pam', 'qam'}
                    scatter_hndl.XData = real(rx_sym);
                    scatter_hndl.YData = imag(rx_sym);
                    drawnow limitrate
               
            end
        end