Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63315573D
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724387; cv=none; b=aelq+sA98aRu1kjA8dZXNII90/W/QV+j/Fh4K8csE8I34LBQaB8GwMnnVpHFlAidTbViaVl7bDSRxBsvmDUGN7cOboXoh03ftLJnlvgJBS5s5O5oAVyYbWZZg28KXE/xoe5Wej1aCDmV2oLo5fJtl/pf9hJFwcSZIrG+FUfBViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724387; c=relaxed/simple;
	bh=JtZnLEPSec4mjz1imELKRsKFLR6tGw6MK08BGMHtz4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPnWk7XiJbrKJ7hiJJr9tjLdo/btsk4jsthbgGudORRR+30voaILz7ODQR/lwxUXU4MMCSj4B8Gd+n9afAg0SDTVHPTSbdLzxr5faywiL5/drahlPfujc24gbMlajrBWJWt6LSuSnJkFFEtWLRxPhc36g4wvqYdg1+32luarq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxdcKrBT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxdcKrBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B61C4CECC;
	Wed, 23 Oct 2024 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729724387;
	bh=JtZnLEPSec4mjz1imELKRsKFLR6tGw6MK08BGMHtz4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxdcKrBTrFcoyCregnbiEVk/b9PwzNMY7GnQKJQivC+OFgnGpxztVDhS6q3Da9LOS
	 YZ+v8NcH9FjG6rwFcA9DE3Mj4iawRr5x6gCn1DrzVezR7qYIi/CyyuSCMrUuGZy+MY
	 76Tos5pLrj9ukew6kJOyK21STJLUd0UIMwylg2jtK3NwZVQJ7+GwtBU8C+f9EkbZ39
	 APVJpWuX79d+ZTj3ja8f7CEFpwOunpbAeLoHsvXMv4o68BEsch7T8/Sc6NbdrWAzXV
	 lBEeal9mZ0SUk6vakC9VmBcjCmvsz+yN4cK4QQrd9wyivybBG2Wooe3WnD3JVrquG7
	 IL1s9bxBxphyw==
Date: Wed, 23 Oct 2024 15:59:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-perf-users@vger.kernel.org, x86@kernel.org, ravi.bangoria@amd.com,
	sandipan.das@amd.com
Subject: Re: [bug report] perf top generates kernel "unchecked MSR access
 error: WRMSR"
Message-ID: <Zxl_4TvxWTtmO_e8@google.com>
References: <156a0ee3-18d5-4144-9f86-230a3946940e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156a0ee3-18d5-4144-9f86-230a3946940e@oracle.com>

Adding Ravi and Sandipan to CC.

On Tue, Oct 22, 2024 at 03:55:05PM +0100, John Garry wrote:
> Hi all,
> 
> On my VM, "perf top" gives this stackframe on v6.12-rc4:
> 
> [  930.527581] unchecked MSR access error: WRMSR to 0xc0010200 (tried to
> write 0x0000020000510076) at rIP: 0xffffffff94ead548
> (native_write_msr+0x8/0x30)
> [  930.531135] Call Trace:
> [  930.531456]  <IRQ>
> [  930.531749]  ? ex_handler_msr+0x138/0x150
> [  930.532285]  ? search_extable+0x26/0x30
> [  930.532780]  ? fixup_exception+0x9c/0x310
> [  930.533405]  ? exc_general_protection+0x10c/0x490
> [  930.534081]  ? asm_exc_general_protection+0x26/0x30
> [  930.534768]  ? native_write_msr+0x8/0x30
> [  930.535357]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  930.535998]  x86_pmu_enable_event+0xa5/0xd0
> [  930.536641]  amd_pmu_enable_all+0x4e/0x80
> [  930.537211]  ctx_resched+0x13b/0x1d0
> [  930.537735]  __perf_install_in_context+0x2a2/0x390
> [  930.538439]  remote_function+0x49/0x60
> [  930.538931]  __flush_smp_call_function_queue+0xdc/0x700
> [  930.539694]  ? __pfx_remote_function+0x10/0x10
> [  930.540480]  __sysvec_call_function_single+0x38/0x140
> [  930.541134]  sysvec_call_function_single+0x6c/0x90
> [  930.541970]  </IRQ>
> [  930.542269]  <TASK>
> [  930.542766]  asm_sysvec_call_function_single+0x1a/0x20
> [  930.543493] RIP: 0010:pv_native_safe_halt+0xf/0x20
> [  930.544195] Code: 22 d7 e9 ff b5 13 00 0f 1f 40 00 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d d3 e3 25 00 fb f4 <e9>
> d7 b5 13 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> [  930.546841] RSP: 0018:ffffffff96a03e68 EFLAGS: 00000206
> [  930.547563] RAX: 0000000000000006 RBX: ffffffff96a269c0 RCX:
> 0000000000000000
> [  930.548579] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffffffff94f53f31
> [  930.549568] RBP: 0000000000000000 R08: 0000000000000001 R09:
> 0000000000000000
> [  930.550529] R10: 0000000000000001 R11: 0000000000000000 R12:
> ffffffff970608e0
> [  930.551582] R13: ffffffff96a269c0 R14: 0000000000000000 R15:
> 0000000000000000
> [  930.552683]  ? do_idle+0x1d1/0x2a0
> [  930.553182]  default_idle+0x9/0x20
> [  930.553670]  default_idle_call+0x7d/0xc0
> [  930.554226]  do_idle+0x1d1/0x2a0
> [  930.554696]  cpu_startup_entry+0x29/0x30
> [  930.555154]  rest_init+0x12e/0x1d0
> [  930.555621]  start_kernel+0x60f/0x6d0
> [  930.556064]  x86_64_start_reservations+0x21/0x40
> [  930.556633]  x86_64_start_kernel+0x91/0xa0
> [  930.557107]  common_startup_64+0x13e/0x141
> [  930.558038]  </TASK>
> [  930.738880] perf: interrupt took too long (2511 > 2500), lowering
> kernel.perf_event_max_sample_rate to 79000
> [  930.772912] perf: interrupt took too long (3414 > 3138), lowering
> kernel.perf_event_max_sample_rate to 58000
> [  930.797764] perf: interrupt took too long (4275 > 4267), lowering
> kernel.perf_event_max_sample_rate to 46000
> [  931.117733] perf: interrupt took too long (5345 > 5343), lowering
> kernel.perf_event_max_sample_rate to 37000
> [  933.862829] perf: interrupt took too long (6765 > 6681), lowering
> kernel.perf_event_max_sample_rate to 29000
> [opc@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 ~]$ ^C
> 
> a known issue?
> 
> more /proc/cpuinfo gives:
> 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 25
> model           : 1
> model name      : AMD EPYC 7J13 64-Core Processor
> stepping        : 1
> microcode       : 0x1000065
> cpu MHz         : 2445.322
> cache size      : 512 KB
> physical id     : 0
> siblings        : 16
> core id         : 0
> cpu cores       : 8
> apicid          : 0
> initial apicid  : 0
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 16
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
> pdpe1gb rdtscp lm rep_good nopl xtopology cpuid extd_apicid tsc_kn
> own_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm cmp_legacy
> svm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw topo
> ext perfctr_core ssbd ibrs ibpb stibp vmmcall fsgsbase tsc_adjust bmi1 avx2
> smep bmi2 erms invpcid rdseed adx smap clflushopt clwb sha_ni xsaveopt
> xsavec xgetbv1 xsaves clzero xsaveerptr wbnoinvd arat npt nrip_sa
> ve umip pku ospke vaes vpclmulqdq rdpid arch_capabilities
> bugs            : sysret_ss_attrs null_seg spectre_v1 spectre_v2
> spec_store_bypass srso ibpb_no_ret
> bogomips        : 4890.64
> TLB size        : 1024 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management:
> 
> Thanks,
> John
