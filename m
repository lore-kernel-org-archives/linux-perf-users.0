From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: Re: perf event "instructions"
Date: Fri, 25 May 2012 09:57:52 -0400
Message-ID: <alpine.DEB.2.00.1205250954260.17420@cl320.icl.utk.edu>
References: <loom.20120525T044121-415@post.gmane.org> <alpine.DEB.2.00.1205242304100.7065@cl320.icl.utk.edu> <139CD8A4-506E-46DF-BB18-6378576A90FC@bu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="614521987-199609940-1337954272=:17420"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:57645
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751227Ab2EYN6A (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 25 May 2012 09:58:00 -0400
In-Reply-To: <139CD8A4-506E-46DF-BB18-6378576A90FC@bu.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Can Hankendi <hankendi@bu.edu>
Cc: linux-perf-users@vger.kernel.org

--614521987-199609940-1337954272=:17420
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

On Thu, 24 May 2012, Can Hankendi wrote:

> Processor is AMD 10H family processor and I'm using this raw event (fro=
m AMD
> Bios and Kernel Developers Guide):
>=20
> EventSelect 0C0h Retired Instructions=A0
>=20
> The number of instructions retired (execution completed and architectur=
al
> state updated). This count includes exceptions and interrupts - each
> exception or interrupt is counted as one instruction.
>=20
> Linux is Ubuntu 12.04, with 3.2.0 kernel.=A0
>=20
> I'm collecting system-wide data with perf stat command. I'm well aware =
about
> the variations in retired instructions. However, I'm collecting the
> "instructions" and raw event 0x0C0h for the same session and ending up =
with
> different results. So I assume it is not about variations, it's more ab=
out
> how the built-in event is configured in perf tool.=A0

so you're saying you are doing something like:
   perf stat -e instructions:u,rc0:u  my_job

and getting different values for the results?
You keep giving not enough info to diagnose this problem.  What's your
*exact* perf command?

The only way to find out what the kernel is using is to check the source.
(I won't comment on how great a feature I think that is).
In arch/x86/kernel/cpu/perf_event_amd.c you can find
  [PERF_COUNT_HW_INSTRUCTIONS]                  =3D 0x00c0,

Vince

--614521987-199609940-1337954272=:17420--
