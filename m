From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf/runtests: Add runtests.sh shellscript testcases for perf
 probe
Date: Tue, 3 Nov 2015 12:45:40 -0300
Message-ID: <20151103154540.GS21609@kernel.org>
References: <1445468925.12960.117.camel@Rudolf-RHEL-7>
 <20151022121615.13192.71967.stgit@localhost.localdomain>
 <1499210318.1567245.1446511429277.JavaMail.zimbra@redhat.com>
 <50399556C9727B4D88A595C8584AAB37525F9F4E@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41569 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755335AbbKCPps (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Nov 2015 10:45:48 -0500
Content-Disposition: inline
In-Reply-To: <50399556C9727B4D88A595C8584AAB37525F9F4E@GSjpTKYDCembx32.service.hitachi.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>
Cc: 'Michael Petlan' <mpetlan@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Tue, Nov 03, 2015 at 03:24:43AM +0000, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=
=B7=B3 / HIRAMATU=EF=BC=8CMASAMI escreveu:
> Hi Michael,
>=20
> From: Michael Petlan [mailto:mpetlan@redhat.com]
> >
> >Hi Masami Hiramatsu,
> >
> >I am sorry for responding late, I had a lot of other work.
> >Thanks for sharing the testsuite, I like it very much, so
> >I added some of your testcases into my skeleton. There is
> >still some work to do regarding that.
> >
> >I develop the testsuite using my own github repository[1],
> >if you are interested, you may have look at it, comment...
>=20
> Thanks! that helps me a lot.
> Arnaldo, I think we'd better include this type of blackbox tests
> what would you think?

Sure thing, I'll take a look at it at some point, just letting it brew
for a while, i.e. for some conversation to take place about how it is
being structured, how it compares to what people like you have in place
for 'perf probe', etc.

- Arnaldo
