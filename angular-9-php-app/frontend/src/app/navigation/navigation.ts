import { FuseNavigation } from '@fuse/types';

export const navigation: FuseNavigation[] = [
    {
        id       : 'applications',
        title    : 'Applications',
        translate: 'NAV.APPLICATIONS',
        type     : 'group',
        children : [
            {
                id       : 'dashboard',
                title    : 'Accueil',
                type     : 'item',
                icon     : 'store',
                url      : '/dashboard',
            },
            {
                id       : 'backoffice',
                title    : 'Arrière boutique',
                type     : 'item',
                icon     : 'settings',
                url      : '/backoffice',
            },
        ]
    }
];
