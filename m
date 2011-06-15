From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] [perf] Add inverted call graph report support.
Date: Wed, 15 Jun 2011 21:40:55 +0200
Message-ID: <20110615194045.GA18403@somewhere.redhat.com>
References: <BANLkTi=svHgWzyKiEHjMc-j5Hq4y5R8Mow@mail.gmail.com>
 <20110610204208.GC13694@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45583 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750Ab1FOTlG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jun 2011 15:41:06 -0400
Content-Disposition: inline
In-Reply-To: <20110610204208.GC13694@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Sam Liao <phyomh@gmail.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arun Sharma <asharma@fb.com>

On Fri, Jun 10, 2011 at 05:42:08PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> Em Thu, Jun 09, 2011 at 02:44:19PM +0800, Sam Liao escreveu:
> > Add "caller/callee" option to support inverted butterfly report,
> > in the inverted report (with caller option), the call graph start
> > from the callee's ancestor. Users can use such view to catch system=
's
> > performance bottleneck from a sysprof like view. Using this option
> > with specified sort order like pid gives us high level view of call
> > graph statistics.
>=20
> Looks OK, haven't had time to test tho.
>=20
> Fr=E9d=E9ric, can you process this one? Tomorrow I'll be off the grid=
,
> vacations!
>=20
> Thanks a lot,
>=20
> - Arnaldo

Yeah, the patch is nice and works well.

I'm applying it.

Thanks.
