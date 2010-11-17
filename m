From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: off-box analysis of perf.data file
Date: Tue, 16 Nov 2010 23:27:25 -0200
Message-ID: <20101117012724.GD4856@ghostprotocols.net>
References: <4CE0B108.8020205@cisco.com>
 <20101116234042.GA4856@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41875 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933908Ab0KQB1c (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Nov 2010 20:27:32 -0500
Received: by gxk23 with SMTP id 23so845552gxk.19
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Nov 2010 17:27:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101116234042.GA4856@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "David S. Ahern" <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org

Em Tue, Nov 16, 2010 at 09:40:42PM -0200, Arnaldo Carvalho de Melo escr=
eveu:
> [root@felicio ~]#
>=20
> To fit your setup you need:
>=20
> . Populate your devel machine ~/.debug build-id database with the uns=
tripped
>   binaries, do that using another perf command, buildid-cache, exampl=
e:

Something I forgot: you can disable the cache populating in the strippe=
d
machine since you have them anyway on the devel machine, that can be ac=
hieved
by what is described in this changeset:

commit a1ac1d3c085420ea8c809ebbee3bb212ed3616bd
Author: Stephane Eranian <eranian@google.com>
Date:   Thu Jun 17 11:39:01 2010 +0200

    perf record: Add option to avoid updating buildid cache
   =20
    There are situations where there is enough information in the perf.=
data
    to process the samples. Updating the buildid cache may add unecessa=
ry
    overhead in terms of disk space and time (copying large elf images)=
=2E
   =20
    A persistent option to do this already exists via the perfconfig fi=
le,
    simply do:
   =20
    [buildid]
    dir =3D /dev/null
   =20
    This patch provides a way to suppress builid cache updates on a per=
-run
    basis.  It addds a new option, -N, to perf record. Buildids are sti=
ll
    generated in the perf.data file.
   =20
    Cc: David S. Miller <davem@davemloft.net>
    Cc: Fr=E9d=E9ric Weisbecker <fweisbec@gmail.com>
    Cc: Ingo Molnar <mingo@elte.hu>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    LKML-Reference: <4c19ef89.93ecd80a.40dc.fffff8e9@mx.google.com>
    Signed-off-by: Stephane Eranian <eranian@google.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

So just use -N and that step will be skipped.


- Arnaldo
