Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256237E0E4;
	Thu,  2 Jan 2025 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847470; cv=none; b=Bkop68TBvD+1ayuaQXciA0PoUSO8XsKScKuEiN8dKtIsHGEB3PCpHyipa0SYH0YGWQI7sJaUWmAN0wqL+N+fYMWiEvEtPmA4rds7hm5oqS9k3jjXaXxwkmvYc3fEh5fXKkr8sEsY0JOWdRU0VPaId619L00KCS+2Kh9qwddCqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847470; c=relaxed/simple;
	bh=mjqMtNDeXK1mslRpi/xgUHhTcK0L2R7SR3ifCujOr7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqYSA+geZJ23x0R+cQf7oQm9CIwX4RKemQL9DnGOjQT0+Q9hSrqmDgJ4PkQTwojqVxFbss814XLzMRF/Kwm3pkAoiGAgVi556efavYZH/waFVmO7JjWckWQg6WT9G48R/FnCj/3hFGpKIEyFS779GReK8wrsa2bGOVNciRshjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdUoeCc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdUoeCc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6D8C4CED0;
	Thu,  2 Jan 2025 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735847469;
	bh=mjqMtNDeXK1mslRpi/xgUHhTcK0L2R7SR3ifCujOr7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdUoeCc6BF8wg7dwFXMeDOOPKaj+FyOug+zj7MWkABfRewrryYPFSwLHvd+0zbD1W
	 SkSKOVs8nOPiChx03QcLWDfraLE6sn6VAr7Bev0ZqpfgBTYbZ6fwT44mXETbcfXs3K
	 6k0cmqaToGt1IWDfc3vLmjMRjYwQuZqTE76oZovlUM7/8M2MzIpXASC35TZT6StAxQ
	 9jPrIcySJ9p7y3n+MvXca2kPahHhJFpzyZbDP+jlT8Jdmfa9FqN1gPHnH/K55nReA3
	 UgqjFfpWokmWFZscQse++wGeYiFjpP+W5cH8Anp0AaeBj4XJqz3lxJNM6OosjYVJNR
	 Q6G0whyF+98Xw==
Date: Thu, 2 Jan 2025 16:51:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf top reports not being able to resolve kernel symbols
Message-ID: <Z3buKhcCsZi3_aGb@x1>
References: <Z3bd2uCdo2EAMSnG@x1>
 <Z3boDyuus0fiGcok@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3boDyuus0fiGcok@x1>

On Thu, Jan 02, 2025 at 04:25:07PM -0300, Arnaldo Carvalho de Melo wrote:
> root@number:~# readelf -sw /lib/modules/6.13.0-rc2/build/vmlinux | grep -B5 -A5 ' 0000000001600'
> 259227: ffffffff8156e290   262 FUNC    GLOBAL DEFAULT    1 zs_free
> 259228: ffffffff8183a4d0   269 FUNC    GLOBAL DEFAULT    1 security_inode_g[...]
> 259229: ffffffff81c8d900   191 FUNC    GLOBAL DEFAULT    1 devres_find
> 259230: ffffffff812e11c0    16 FUNC    GLOBAL DEFAULT    1 __pfx___probestu[...]
> 259231: ffffffff81c985a0    16 FUNC    GLOBAL DEFAULT    1 __pfx_pm_qos_sys[...]
> 259232: 0000000001600000     0 NOTYPE  GLOBAL DEFAULT  ABS text_size
> 259233: ffffffff81487f10   117 FUNC    GLOBAL DEFAULT    1 shmem_read_folio_gfp
> 259234: ffffffff81e08540   155 FUNC    GLOBAL DEFAULT    1 __traceiter_smbu[...]
> 259235: ffffffff811e13a0    16 FUNC    GLOBAL DEFAULT    1 __pfx_thaw_workqueues
> 259236: ffffffff81b04c70   599 FUNC    GLOBAL DEFAULT    1 acpi_install_method
> 259237: ffffffff81de7d40    16 FUNC    GLOBAL DEFAULT    1 __pfx_psmouse_se[...]
> root@number:~#
 
> There it is, that "text_size" symbol stayed with with a prev->end equal
> to prev->start and thus 0x00000000016001c1 stops being resolved, which
> leads us to get to that buggy warning.
 
> I'll put all this into a patch and send it for review,

But looking further, where do those 0x00000000016001c1 addresses coming
from?

(gdb) p /x sample->ip
$10 = 0xffffffffb7401fad
(gdb) p /x al->addr
$11 = 0x1601fad
(gdb) bt
#0  perf_event__process_sample (tool=0x7fffffff9bd0, event=0x1017400, evsel=0xf68860, sample=0x7fff8dffa470, machine=0xf8e818) at builtin-top.c:813
#1  0x0000000000447c5c in deliver_event (qe=0x7fffffff9ee8, qevent=0x1024670) at builtin-top.c:1213
#2  0x0000000000642706 in do_flush (oe=0x7fffffff9ee8, show_progress=false) at util/ordered-events.c:245
#3  0x0000000000642a5d in __ordered_events__flush (oe=0x7fffffff9ee8, how=OE_FLUSH__TOP, timestamp=0) at util/ordered-events.c:324
#4  0x0000000000642b47 in ordered_events__flush (oe=0x7fffffff9ee8, how=OE_FLUSH__TOP) at util/ordered-events.c:342
#5  0x00000000004477e9 in process_thread (arg=0x7fffffff9bd0) at builtin-top.c:1125
#6  0x00007ffff6ea5d97 in start_thread () from /lib64/libc.so.6
#7  0x00007ffff6f29c8c in clone3 () from /lib64/libc.so.6
(gdb)

root@number:~# grep ffffffffb7401f /proc/kallsyms 
ffffffffb7401f09 t repeat_nmi
ffffffffb7401f2e t end_repeat_nmi
ffffffffb7401f81 t nmi_no_fsgsbase
ffffffffb7401f85 t nmi_swapgs
ffffffffb7401f88 t nmi_restore
ffffffffb7401fb0 T entry_SYSCALL32_ignore
ffffffffb7401fd0 T __pfx_clear_bhb_loop
ffffffffb7401fe0 T clear_bhb_loop
root@number:~# 

Looks like nmi_restore...

Which is...

   780: ffffffff82401ee8     0 NOTYPE  LOCAL  DEFAULT    1 nested_nmi_out
   781: ffffffff82401ed0     0 NOTYPE  LOCAL  DEFAULT    1 nested_nmi
   782: ffffffff82401eeb     0 NOTYPE  LOCAL  DEFAULT    1 first_nmi
   783: ffffffff82401f81     0 NOTYPE  LOCAL  DEFAULT    1 nmi_no_fsgsbase
   784: ffffffff82401f88     0 NOTYPE  LOCAL  DEFAULT    1 nmi_restore
   785: ffffffff82401f85     0 NOTYPE  LOCAL  DEFAULT    1 nmi_swapgs
   786: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS syscall_64.c
   787: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS common.c
   788: ffffffff810cc2b0    16 FUNC    LOCAL  DEFAULT    1 ia32_emulation_o[...]
   789: ffffffff821e57f0   241 FUNC    LOCAL  DEFAULT    1 __do_fast_syscall_32

So there are symbols that are not being resolved anymore that were
before your patch, namely:

arch/x86/entry/entry_64.S

nmi_no_fsgsbase:
        /* EBX == 0 -> invoke SWAPGS */
        testl   %ebx, %ebx
        jnz     nmi_restore

nmi_swapgs:
        swapgs

nmi_restore:
        POP_REGS

- Arnaldo
