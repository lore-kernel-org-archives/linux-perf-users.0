From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Weird instruction profiling
Date: Wed, 18 Feb 2015 10:30:40 -0800
Message-ID: <87zj8bvzqn.fsf@tassilo.jf.intel.com>
References: <CAE40pddnqg-H-YqvyHodw1ME6W9_7et151+=O9y=S7sHB0an7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:33421 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755080AbbBRSam convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Feb 2015 13:30:42 -0500
In-Reply-To: <CAE40pddnqg-H-YqvyHodw1ME6W9_7et151+=O9y=S7sHB0an7w@mail.gmail.com>
	(Brendan Gregg's message of "Wed, 18 Feb 2015 01:57:50 -0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Brendan Gregg <brendan.d.gregg@gmail.com> writes:
>
> Despite millions of samples, many NOPs are never seen. (See the
> Percent column.) I'm not using PEBS, but I suppose I should.

Yes you should. You get better results with :p / :pp (PEBS)
and the best results (but not at the cycles level) with
INST_RETIRED.PREC_DIST / ALL

cycles:upp

       =E2=94=82    0000000000400400 <main>:
  0.05 =E2=94=82 0:   nop
       =E2=94=82      nop
       =E2=94=82      nop
 19.78 =E2=94=82      nop
  0.17 =E2=94=82      nop
       =E2=94=82      nop
       =E2=94=82      nop
 20.16 =E2=94=82      nop
  0.12 =E2=94=82      nop
       =E2=94=82      nop
       =E2=94=82      nop
 20.49 =E2=94=82      nop
  0.07 =E2=94=82      nop
       =E2=94=82      nop
       =E2=94=82      nop
 18.88 =E2=94=82      nop
 20.30 =E2=94=82    =E2=86=91 jmp    0


cpu/event=3D0xc0,umask=3D0x1,name=3Dinst_retired_prec_dist/pp

       =E2=94=82    0000000000400400 <main>:
  6.13 =E2=94=82 0:   nop
       =E2=94=82      nop
  0.02 =E2=94=82      nop
  0.02 =E2=94=82      nop
 23.69 =E2=94=82      nop
       =E2=94=82      nop
       =E2=94=82      nop
  0.02 =E2=94=82      nop
 24.05 =E2=94=82      nop
       =E2=94=82      nop
       =E2=94=82      nop
  0.02 =E2=94=82      nop
 23.60 =E2=94=82      nop
       =E2=94=82      nop
       =E2=94=82      nop
       =E2=94=82      nop
 22.46 =E2=94=82    =E2=86=91 jmp    0


This is nearly as good as you can get here because the machine can
retire four nops per cycle

A common trick is to run PREC_DIST/ALL in parallel with other events
and correlate.

> I think Andi mentioned this to me last year -- that instruction
> profiling was no longer reliable.=20

It never was.

> Is this due to parallel and out-of-order execution? (ie, we're
> sampling the instruction pointer, but that's set to the resumption
> instruction, not the instructions being processed in the backend?).

Most problems are due to 'skid': It takes some time to trigger the
profiling interrupt after the event fired. Without PEBS the skid is
quite high. With PEBS it's a lot better because it writes out=20
the information into the PEBS buffer faster, but also not zero and can
still be noticed. With PREC_DIST/ALL it does some additional tricks
to further reduce it.

There are also other problems, for example an event may not be tied
to an instruction. Some events have inherently large skid.

-Andi

--=20
ak@linux.intel.com -- Speaking for myself only
