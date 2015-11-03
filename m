From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: perf/runtests: Add runtests.sh shellscript testcases for perf
 probe
Date: Tue, 03 Nov 2015 20:55:57 +0100
Message-ID: <1446580557.15375.24.camel@Rudolf-RHEL-7>
References: <1445468925.12960.117.camel@Rudolf-RHEL-7>
	 <20151022121615.13192.71967.stgit@localhost.localdomain>
	 <1499210318.1567245.1446511429277.JavaMail.zimbra@redhat.com>
	 <50399556C9727B4D88A595C8584AAB37525F9F4E@GSjpTKYDCembx32.service.hitachi.net>
	 <20151103154540.GS21609@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39000 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755707AbbKCT4A (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Nov 2015 14:56:00 -0500
In-Reply-To: <20151103154540.GS21609@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: =?UTF-8?Q?=E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3?= / =?UTF-8?Q?HIRAMATU=EF=BC=8CMASAMI?= <masami.hiramatsu.pt@hitachi.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Tue, 2015-11-03 at 12:45 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 03, 2015 at 03:24:43AM +0000, =E5=B9=B3=E6=9D=BE=E9=9B=85=
=E5=B7=B3 / HIRAMATU=EF=BC=8CMASAMI escreveu:
> > Hi Michael,
> >=20
> > From: Michael Petlan [mailto:mpetlan@redhat.com]
> > >
> > >Hi Masami Hiramatsu,
> > >
> > >I am sorry for responding late, I had a lot of other work.
> > >Thanks for sharing the testsuite, I like it very much, so
> > >I added some of your testcases into my skeleton. There is
> > >still some work to do regarding that.
> > >
> > >I develop the testsuite using my own github repository[1],
> > >if you are interested, you may have look at it, comment...
> >=20
> > Thanks! that helps me a lot.
> > Arnaldo, I think we'd better include this type of blackbox tests
> > what would you think?
>=20
> Sure thing, I'll take a look at it at some point, just letting it bre=
w
> for a while, i.e. for some conversation to take place about how it is
> being structured, how it compares to what people like you have in pla=
ce
> for 'perf probe', etc.
>=20
> - Arnaldo

Any feedback for the testsuite is appreciated. I am still not
satisfied with the coverage, etc. I am just launching an idea
being curious, whether it is able to live and survive or not.
If you have any ideas, recommendations, contributions, surely
come up with them!  Also if anyone has questions why it is as
it is, about the design of the structure, checking mechanism,
etc...

Michael
