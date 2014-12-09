From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Perf support for interpreted and Just-In-Time translated languages
Date: Tue, 09 Dec 2014 14:01:11 -0800
Message-ID: <87ppbs4h5k.fsf@tassilo.jf.intel.com>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>
	<CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>
	<20141209203419.GI4189@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41055 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbaLIWBe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 9 Dec 2014 17:01:34 -0500
In-Reply-To: <20141209203419.GI4189@kernel.org> (Arnaldo Carvalho de Melo's
	message of "Tue, 9 Dec 2014 17:34:19 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>, Carl Love <cel@us.ibm.com>, Pekka Enberg <penberg@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>
> Humm, I wonder if we could try to attach a 'perf probe' (uprobes) to
> some JVM method that is known to invalidate JITted code -> symtab
> mappings so that we would use it as a PERF_RECORD_MMAP equivalent...
> I.e. we would know that that map overlaps the previous one and that the
> symtab is a new one for that addr range, etc, just like we do for
> executable mmaps coming from the kernel (PERF_RECORD_MMAP).

JAVA already has a API to get all these information. That is
what oprofile, Vtune and Brendan's agent uses.

It just needs a better interface from the agent to perf, to pass all
needed information, including symbols, line numbers, executable code
(for PT decoding and for showing diassembler), and ordering it by time
so that no hacks are needed.

BTW other JITs (LLVM, Mono, V8, ...) have similar interfaces.

Longer term as the kernel gets more JITed (eBPF etc.) it likely needs 
some kind of JIT interface too.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
