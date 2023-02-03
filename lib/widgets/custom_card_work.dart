import 'package:app_invoices/models/login_menu_option.dart';
import 'package:app_invoices/router/work_popup_menu.dart';
import 'package:app_invoices/theme/theme_app.dart';
import 'package:flutter/material.dart';

class CustomCardWork extends StatelessWidget {
  const CustomCardWork({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 8,
        shadowColor: AppTheme.primary.withOpacity(0.6),
        child: Column(
          children: [
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              leading: const Icon(
                Icons.account_circle,
                color: AppTheme.primary,
              ),
              trailing: PopupMenuButton(
                onSelected: (route) {
                  print(route as String);
                  Navigator.pushNamed(context, route);
                },
                itemBuilder: (context) {
                  return WorkPopupMenu.menuOptions
                      .map((LoginMenuOption choice) {
                    return PopupMenuItem(
                      value: choice.route,
                      child: Row(
                        children: [
                          Icon(
                            choice.icon,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(choice.name),
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
              title: const Text('Juan Manuel Cuero Ortega'),
            ),
            const ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: Icon(
                Icons.home,
                color: AppTheme.primary,
              ),
              title: Text('Calle Falsa 123'),
              subtitle: Text('Villavicencio'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 2,
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    leading: Icon(
                      Icons.dynamic_form,
                      color: AppTheme.primary,
                    ),
                    title: Text('8229978128'),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 30.0,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.photo_album,
                          color: AppTheme.primary,
                        ),
                        Text('0')
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
