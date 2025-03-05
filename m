Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5C2746A;
	Wed,  5 Mar 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182435; cv=none; b=nv2OmVt5bqRw3bgH8IOHNnIghsYDajoOm/rPqmgur1bULIllv4E8D1v3UtUBPeXL1jPZE8I9jtJNIh+8Ha1/eXw0mpoFNzrdNivooGrNaDX02SROxpqPfX8zG6FgPzmCm2Y+8QUXSb70DlijMFyXwlZLmqTauOnVinqAbyEFZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182435; c=relaxed/simple;
	bh=0wX2Ft3gG5+EHuiPKuFrYvdSg0U86ROLVE8qqQDG4wQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+uiZcpVkBIK8uDDFr+gOsZp4vQfSnl+RTA574ndMmIRKZkqJ50K7L4ISrjFVXrzCtM6vEBWpKMZsDQR5Os88sLkKNa7Gt0vgQVloX6hwXxGc9XTdl3rPO6yShPOkn7srIZpC0CVz9IM+E9tkOZ6Tyoooz2Nrm7dCoRr735J2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKLPYkzf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKLPYkzf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb379so5778493a12.3;
        Wed, 05 Mar 2025 05:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741182432; x=1741787232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JhNlBLhYq1rxzfYtZOUoIo33Rc2I0YHbT2Gb7wKHkNw=;
        b=eKLPYkzf5HI32HCtQf4Ka3tG7T1ne1yQVqm/ruyZIvhoFDTEV3pq98LVzyv707Bjye
         Kd0VluitmCAXUTg2GXqVLkHH/4RDB7yfp4JbHrWVsv0+wtAh4qfCGqUzJ1vWIRJCAhhG
         cXR+NOJ50rf0xHb0KO+6aub1y1yr4yclgL1IGH6z6tbON9dtdHVFi6R2Tc0uhmNEgFSF
         0Y3qSaZyUAJzPUnFPbsKGYRbDjvKErBQRoF1RhS2gwhH8QTpbeAolVfYu4T37tqVfMJx
         Tj9nJ5ngzTYAlK+0Q0ENExWJ95sBqZTUo+OHVXkkYTv/9BiTTfcUsQawbHopGDIKeAKG
         0KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741182432; x=1741787232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhNlBLhYq1rxzfYtZOUoIo33Rc2I0YHbT2Gb7wKHkNw=;
        b=s/b4K+tQeNWt18rLbcRMshDuxj3pZnzBsTn8KUr5wfqX68KUekqVJtNcfwDQ6zPgjj
         AO+3SkBqmFUop6zfnWqi3Vny7lv2+Q3rXNPCc8FIIMMh5IZe4LLcOwWhp/YjjnYShxiZ
         cdMhkip38YfFTfuf7141UQUvOSnPWFBP80ZEgUoMB8Q4qN64H5pacthVFOfSswqBuKeb
         zITFtbyUSmwrELk24aL/HUW1M6288gaTzO8+vk4HTcnXSYqrKfGq3LwkXyrybcaEzOSN
         oZL9Oteyvk7T0iHU7q3+rsDYe3obRm64PuidEkbtZ3M3sMTPGVq8V2SgL4rANdIDwbUt
         kFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX752LQsEK/PbVDqgMkAKjQCIBldvXImAU0xL2DVqnB+p+LOl1/mxVMjQCOB212PZb/81O8oFb1yyA22w=@vger.kernel.org, AJvYcCUXAKiZ+8BQx1ach+4+yYl4yU1X7qMB/IF1DMMYXwTcoPmYzWJpky6rWZ8Q1fddnSXfNAuPxP+ZFC0og3zFNGrbRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDdmEHnZ+3kq0J+xYTaV1nyAMoO7CtAa4O6zlSe6nHyd0UcrQE
	OBSckJrejsoXRPWXrT+YiR8YhZ5bmS1HfC2axdORzzoNqX7qrjwR
X-Gm-Gg: ASbGncsDtrOi8z/n+EgQeZk164TcU42/FJ+XByiVpXM3owkal4UD5SPj28IsSZi05Qq
	wFWPyuDmOI6FWb3ojfS96nzX/oP8LNFo3T1dgKioYj4VMQ3myBJChf8neh1XyR3885gfpnP3d0F
	LB/TLlAr3pmx7dkVpNp9Sc3UDzgT3FE3OTT03lvm68QKWKPF/KquXihhOqRd4JTY7MkjPFpQpsa
	IPoORgYfuWb+H7HWIPaJFD+S66N80LXAf2zqf7l8W+Qj9IenBXHf+DeXbkVa2cO+lyb7tNt5BNk
	mSStSu66N1v1rc3xoXXPc80VUwMz1Lk=
X-Google-Smtp-Source: AGHT+IF3GKHP25klsgLzbUcGYg5gwYJvSES2fMzfYHQtNSy4OAsIhShhD7t5QM1rMjNFGC9gYeQRbg==
X-Received: by 2002:a17:906:7315:b0:ac1:dfab:d38e with SMTP id a640c23a62f3a-ac20d8bc960mr326236366b.15.1741182431670;
        Wed, 05 Mar 2025 05:47:11 -0800 (PST)
Received: from krava ([83.148.32.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e5aff06esm384020066b.130.2025.03.05.05.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:47:11 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 5 Mar 2025 14:47:09 +0100
To: lirongqing <lirongqing@baidu.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/bts: allocate bts_ctx only if necessary
Message-ID: <Z8hV3WYuHxHBNoNV@krava>
References: <20250122074103.3091-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122074103.3091-1-lirongqing@baidu.com>

On Wed, Jan 22, 2025 at 03:41:03PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Avoid unnecessary per-CPU memory allocation on unsupported CPUs,
> this can save 12K memory for each CPU
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  arch/x86/events/intel/bts.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 8f78b0c..8e09319 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -36,7 +36,7 @@ enum {
>  	BTS_STATE_ACTIVE,
>  };
>  
> -static DEFINE_PER_CPU(struct bts_ctx, bts_ctx);
> +static struct bts_ctx __percpu *bts_ctx;
>  
>  #define BTS_RECORD_SIZE		24
>  #define BTS_SAFETY_MARGIN	4080
> @@ -231,7 +231,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle);
>  
>  static void __bts_event_start(struct perf_event *event)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct bts_buffer *buf = perf_get_aux(&bts->handle);
>  	u64 config = 0;
>  
> @@ -260,7 +260,7 @@ static void __bts_event_start(struct perf_event *event)
>  static void bts_event_start(struct perf_event *event, int flags)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct bts_buffer *buf;
>  
>  	buf = perf_aux_output_begin(&bts->handle, event);
> @@ -290,7 +290,7 @@ static void bts_event_start(struct perf_event *event, int flags)
>  
>  static void __bts_event_stop(struct perf_event *event, int state)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  
>  	/* ACTIVE -> INACTIVE(PMI)/STOPPED(->stop()) */
>  	WRITE_ONCE(bts->state, state);
> @@ -305,7 +305,7 @@ static void __bts_event_stop(struct perf_event *event, int state)
>  static void bts_event_stop(struct perf_event *event, int flags)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct bts_buffer *buf = NULL;
>  	int state = READ_ONCE(bts->state);
>  
> @@ -338,7 +338,7 @@ static void bts_event_stop(struct perf_event *event, int flags)
>  
>  void intel_bts_enable_local(void)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	int state = READ_ONCE(bts->state);
>  
>  	/*
> @@ -358,7 +358,7 @@ void intel_bts_enable_local(void)
>  
>  void intel_bts_disable_local(void)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);

hi,
I'm getting crash below in here

I think it's because we allocate bts_ctx only if there's X86_FEATURE_PTI,
but then intel_bts_disable_local is called unconditionally from
intel_pmu_handle_irq and exploding on accessing bts_ctx

there's no crash when this change is reverted

jirka


>  
>  	/*
>  	 * Here we transition from ACTIVE to INACTIVE;
> @@ -450,7 +450,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
>  int intel_bts_interrupt(void)
>  {
>  	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct perf_event *event = bts->handle.event;
>  	struct bts_buffer *buf;
>  	s64 old_head;
> @@ -518,7 +518,7 @@ static void bts_event_del(struct perf_event *event, int mode)
>  
>  static int bts_event_add(struct perf_event *event, int mode)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct hw_perf_event *hwc = &event->hw;
>  
> @@ -605,6 +605,10 @@ static __init int bts_init(void)
>  		return -ENODEV;
>  	}
>  
> +	bts_ctx = alloc_percpu(struct bts_ctx);
> +	if (!bts_ctx)
> +		return -ENOMEM;
> +
>  	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
>  				  PERF_PMU_CAP_EXCLUSIVE;
>  	bts_pmu.task_ctx_nr	= perf_sw_context;
> -- 
> 2.9.4
> 

---

  [    9.615480] BUG: unable to handle page fault for address: ffff9eb419247000
  [    9.615484] #PF: supervisor read access in kernel mode
  [    9.615485] #PF: error_code(0x0000) - not-present page
  [    9.615487] PGD ba801067 P4D ba801067 PUD 0
  [    9.615490] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
  [    9.615492] CPU: 0 UID: 0 PID: 492 Comm: test_maps Not tainted 6.14.0-rc4-g5d70396a7df7-dirty #1
  [    9.615495] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  [    9.615497] RIP: 0010:intel_bts_disable_local+0x18/0x50
  [    9.615501] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 65 48 8b 0d bf 1f 7b 02 48 8b 05 e0 b7 7d 02 <8b> 94 01 00 20 00 00 83 fa 02 75 1f 48 83 3c 08 00 74 18 65 48 8b
  [    9.615503] RSP: 0018:fffffe71b3e00c78 EFLAGS: 00010002
  [    9.615504] RAX: 0000000000000000 RBX: fffffe71b3e00ef8 RCX: ffff9eb419245000
  [    9.615505] RDX: 0000000000000001 RSI: 000000023eb5576c RDI: fffffe71b3e00ef8
  [    9.615506] RBP: fffffe71b3e00e38 R08: 0000000000000002 R09: 0000000000000002
  [    9.615507] R10: ffffffffa023f735 R11: ffffffffa020dfe0 R12: fffffe71b3e00ef8
  [    9.615508] R13: 0000000000000000 R14: ffff9eb419245000 R15: 0000000000000001
  [    9.615508] FS:  00007f25164ac140(0000) GS:ffff9eb419245000(0000) knlGS:0000000000000000
  [    9.615510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [    9.615511] CR2: ffff9eb419247000 CR3: 000000010b31c006 CR4: 0000000000770ef0
  [    9.615514] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [    9.615515] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [    9.615516] PKRU: 55555554
  [    9.615516] Call Trace:
  [    9.615518]  <NMI>
  [    9.615519]  ? __die_body+0x6a/0xb0
  [    9.615521]  ? page_fault_oops+0x36f/0x400
  [    9.615525]  ? do_kern_addr_fault+0x9a/0xd0
  [    9.615526]  ? exc_page_fault+0xab/0xf0
  [    9.615528]  ? asm_exc_page_fault+0x26/0x30
  [    9.615531]  ? __pfx_perf_event_nmi_handler+0x10/0x10
  [    9.615533]  ? nmi_handle+0x55/0x2b0
  [    9.615536]  ? intel_bts_disable_local+0x18/0x50
  [    9.615538]  intel_pmu_handle_irq+0x88/0x8b0
  [    9.615545]  ? look_up_lock_class+0x74/0x150
  [    9.615546]  ? verify_lock_unused+0xb/0x80
  [    9.615549]  ? lock_acquire+0x1a0/0x2a0
  [    9.615551]  ? nmi_handle+0x55/0x2b0
  [    9.615553]  perf_event_nmi_handler+0x28/0x50
  [    9.615555]  nmi_handle+0x116/0x2b0
  [    9.615557]  ? nmi_handle+0x55/0x2b0
  [    9.615558]  ? _copy_from_user+0x37/0x80
  [    9.615561]  default_do_nmi+0x41/0x100
  [    9.615564]  exc_nmi+0xb5/0x110
  [    9.615566]  end_repeat_nmi+0xf/0x53
  [    9.615568] RIP: 0010:_copy_from_user+0x37/0x80
  [    9.615570] Code: 89 f7 49 89 fe 48 c7 c7 19 16 49 a1 be a2 00 00 00 e8 8d 3e cb ff 48 b8 00 f0 ff ff ff 7f 00 00 49 39 c7 4c 0f 47 f8 0f 01 cb <4c> 89 f7 48 89 d9 4c 89 fe e8 fb cd 65 00 48 89 c8 0f 01 ca 48 85
  [    9.615571] RSP: 0018:ffffa49b403dfdb0 EFLAGS: 00040283
  [    9.615572] RAX: 00007ffffffff000 RBX: 0000000000000008 RCX: 0000000000000001
  [    9.615573] RDX: 0000000000000001 RSI: ffff9eb38b2c3950 RDI: ffff9eb389f40b58
  [    9.615574] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffffffffff
  [    9.615574] R10: ffff9eb389f40b78 R11: 0000000000000000 R12: ffff9eb382711000
  [    9.615575] R13: 0000000000000000 R14: ffff9eb3824fd920 R15: 00007ffd584f7268
  [    9.615578]  ? _copy_from_user+0x37/0x80
  [    9.615580]  ? _copy_from_user+0x37/0x80
  [    9.615581]  </NMI>
  [    9.615582]  <TASK>
  [    9.615582]  ___bpf_copy_key+0x52/0xb0
  [    9.615586]  map_update_elem+0xd4/0x280
  [    9.615589]  __sys_bpf+0x450/0x550
  [    9.615592]  __x64_sys_bpf+0x1c/0x30
  [    9.615594]  do_syscall_64+0x79/0x120
  [    9.615596]  ? clear_bhb_loop+0x35/0x90
  [    9.615597]  ? clear_bhb_loop+0x35/0x90
  [    9.615599]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [    9.615600] RIP: 0033:0x7f251668e25d
  [    9.615602] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
  [    9.615603] RSP: 002b:00007ffd584f7128 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
  [    9.615604] RAX: ffffffffffffffda RBX: 00007ffd584f76b8 RCX: 00007f251668e25d
  [    9.615605] RDX: 0000000000000020 RSI: 00007ffd584f7170 RDI: 0000000000000002
  [    9.615606] RBP: 00007ffd584f7150 R08: 0000000000000000 R09: 0000000000000000
  [    9.615606] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000001
  [    9.615607] R13: 0000000000000000 R14: 000055bd9b4e01b8 R15: 00007f2516801000
  [    9.615609]  </TASK>  [    9.615610] Modules linked in:
  [    9.615611] CR2: ffff9eb419247000
  [    9.615613] ---[ end trace 0000000000000000 ]---
  [    9.615614] RIP: 0010:intel_bts_disable_local+0x18/0x50
  [    9.615615] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 65 48 8b 0d bf 1f 7b 02 48 8b 05 e0 b7 7d 02 <8b> 94 01 00 20 00 00 83 fa 02 75 1f 48 83 3c 08 00 74 18 65 48 8b
  [    9.615616] RSP: 0018:fffffe71b3e00c78 EFLAGS: 00010002
  [    9.615617] RAX: 0000000000000000 RBX: fffffe71b3e00ef8 RCX: ffff9eb419245000
  [    9.615618] RDX: 0000000000000001 RSI: 000000023eb5576c RDI: fffffe71b3e00ef8
  [    9.615618] RBP: fffffe71b3e00e38 R08: 0000000000000002 R09: 0000000000000002
  [    9.615619] R10: ffffffffa023f735 R11: ffffffffa020dfe0 R12: fffffe71b3e00ef8
  [    9.615619] R13: 0000000000000000 R14: ffff9eb419245000 R15: 0000000000000001
  [    9.615620] FS:  00007f25164ac140(0000) GS:ffff9eb419245000(0000) knlGS:0000000000000000
  [    9.615621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [    9.615622] CR2: ffff9eb419247000 CR3: 000000010b31c006 CR4: 0000000000770ef0
  [    9.615622] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [    9.615623] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [    9.615624] PKRU: 55555554
  [    9.615624] Kernel panic - not syncing: Fatal exception in interrupt
  [    9.615807] Kernel Offset: 0x1f000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
  Failed to run command
