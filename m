From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Event not supported
Date: Thu, 20 Feb 2014 09:09:14 +0100
Message-ID: <20140220080914.GB1122@krava.brq.redhat.com>
References: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com>
 <2134935460.926412.1392818899430.JavaMail.zimbra@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514AbaBTIJV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 20 Feb 2014 03:09:21 -0500
Content-Disposition: inline
In-Reply-To: <2134935460.926412.1392818899430.JavaMail.zimbra@inria.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Baptiste Lepers <baptiste.lepers@inria.fr>
Cc: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>, linux-perf-users@vger.kernel.org

On Wed, Feb 19, 2014 at 03:08:19PM +0100, Baptiste Lepers wrote:
> Hi,
>=20
> I think that the format you are using is not correct.
>=20
> To profile event 0xXXX with unit mask YY, the format is rX0000YYXX, s=
o in your case: r1000002e0.
>=20
> Also, beware that the unitmask in the documentation tells you the _bi=
t(s)_ that need to be set.
> So :
>   From Local Node to Node 0 =3D r1000001e0
>   From Local Node to Node 1 =3D r1000002e0
>   From Local Node to Node 2 =3D r1000004e0
>   From Local Node to Node 3 =3D r1000008e0
>   From Local Node to Node 4 =3D r1000010e0
>   From Local Node to Node 0 & 1 & 2 =3D r1000007e0
>   etc.

hi,
never tried on AMD, but AFAIK it exports the event format
terms in sysfs like Intel does:

[root@krava format]# pwd
/sys/bus/event_source/devices/cpu/format
[root@krava format]# ls
any  cmask  edge  event  in_tx  in_tx_cp  inv  ldlat  offcore_rsp  pc  =
umask

and you can use those terms to specify your event more user
friendly that using the r* style, like:

  perf record -e 'cpu/event=3D0x3c,umask=3D.../uk' ..


jirka


>=20
>=20
> Cheers,
> Baptiste.
>=20
> ----- Mail original -----
> > De: "Martin Ichilevici de Oliveira" <martin.i.oliveira@gmail.com>
> > =C0: linux-perf-users@vger.kernel.org
> > Envoy=E9: Mardi 18 F=E9vrier 2014 17:51:46
> > Objet: Event not supported
> >=20
> > Hello,
> >=20
> > I'm still learning perf, so I apologize in advance if my questions =
are
> > too simple and not suited here. I did, however, searched the web an=
d
> > tried to find a solution by myself before posting to this mailing
> > list.
> >=20
> > From my manufacturer's manual, I chose an event I'm interested in
> > monitoring. They also list unit masks, as below:
> >=20
> > UnitMask    Description
> > 7                  From Local node to Node 7
> > 6                  From Local node to Node 6
> > 5                  From Local node to Node 5
> > 4                  From Local node to Node 4
> > 3                  From Local node to Node 3
> > 2                  From Local node to Node 2
> > 1                  From Local node to Node 1
> > 0                  From Local node to Node 0
> >=20
> > The event is "CPU to DRAM Requests to Target Node" (NUMA machine) a=
nd
> > it's number is 0x1E0. As I understood, I should precede the event w=
ith
> > the unit mask. So, for example, if I'm interested in unit mask 2, I
> > should type:
> >=20
> > perf stat -e r21e0 /bin/ls
> >=20
> > However, this results in a <not supported> message. This happened f=
or
> > all events that have a unit mask that I tried. Other events worked
> > fine.
> >=20
> > I'm not sure whether I'm giving the right command or this is a prob=
lem
> > with perf/kernel version. As it turned out, I'm running Ubuntu with
> > kernel 3.11.10-03111002, but the latest available perf version from
> > the repositories is 3.8.0-35, which is the one I'm using.
> >=20
> > Any help is appreciated.
> >=20
> > Thank you,
> > Martin
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-per=
f-users"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
