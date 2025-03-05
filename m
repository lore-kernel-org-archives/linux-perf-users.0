Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1F13F434;
	Wed,  5 Mar 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182903; cv=none; b=XNPLgMZ+K9XWNsHbgNV+ZDndmw411ZtPTZxYPYyOdg4Ghe5ZXWddjU933ZJLzVAvmCSwe9MRa463NUBI2sKqao8qiqXvV6Wt1uNBK+FmTEj/t0dt3ZF62B4bTRmeiow4Mja8GYCZlqP6zYoyMVQWxEi05ciobpQbOgZ/+ioGegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182903; c=relaxed/simple;
	bh=s6ntod5Uxe0HUgEFr7p/Q6yB288S0syqkDb7BKFgTH8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYV/R0qxy8mPcmIhcJGlzit8Mgy6Gvj17XzMxQKIpxBzkZOv4qCvKZ/kgEmPBnC2LmjQEupXWWToNd+3EjrtoyN23Vx4zPSpq7J+RXt5PVVVJg47b9eJ7s1sedIR43t16YhcnHHyKqJz3mSnZjI2cAWfYgL7d7HgFLXViR4UjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdoUFed+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdoUFed+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390df942558so5349372f8f.2;
        Wed, 05 Mar 2025 05:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741182900; x=1741787700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HnLlSy5Jf0gJwcSKwmIkGAYW/HHT9cmx0jKW67VsAQ=;
        b=NdoUFed+mlBTGqQD0WNMEoBwkaaQ22/M9ARpZnsgGbOrr6Fa9jXfyJn2zhEYR340tl
         CqEEEAfedpJtfhAnfixZ7cCtbVC+qgpKPHFdLje4OV2LEVs6zZLUIfo06Rs3ARlnJNsW
         rxykuHNaRb5oTqs3WnCQs/3db6lOsg1dPQlyMYWlmcWm7Rb8PqGYoPemDj45Z7cfh3hq
         aGAvl9QT0oRhmF0oQr4DKbxxi3H1Wk1ecWQV+B2D5vM7aZvujMjFhRjXy9WGhuOa0Om+
         5T1+/CSEIAjqEmQSr+7xPpSl+n10XtajQrCSx3FUbbgWaqcMPzeSWBT00GrI8uVJIL4o
         Zcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741182900; x=1741787700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HnLlSy5Jf0gJwcSKwmIkGAYW/HHT9cmx0jKW67VsAQ=;
        b=MFZSb99JYjASJkpRKN1jAEXBUVdwWiGFKX9IZ1Bp6lGPTcPsRyetjTy+KB7j8qa94f
         w5BRRC4/1xrBWtoBt2HFtGeG0Bm6r83+43D7wHU/9eyKo3qpWdOhzEk9dV64t0N46XzJ
         L7oYZzintHjNiWuAYTTJBwkPUyNlXpc0dZvQs59/qygjTYVyE3MBHhdZZZr0wDAEheTz
         6UvYpOfdKxDWyTBKXzPqwP+LxedecEj7zMYdXopYFbAfAYmO7pjztXwNYAk3np2muQyC
         67thnJ9vM6/jNPqg7i9G+YnwADHTa4qaJ46xqFJo4zPSSebgkc32GNbXIEUr0UcYz61S
         DFZg==
X-Forwarded-Encrypted: i=1; AJvYcCURi/brZ38Kn3/RQFw5CNHZtcnGV7B1Fyxb/UIr78qjidQoth4r5d//T9xS+li47rrCA9AOQ69PhZK9yio=@vger.kernel.org, AJvYcCVk2TBbeJ1DdjaNlbfItcoGKG6fux1em8v+Syw5WwuWQ1YCRaDnefG6oieHATtFYjplnv5dbSduSnAITLhlwLqBXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1N+gAPmHPSs+duVW8BhCVJ0kNxwW12AxzdGNSWToNNxpc/RFQ
	eF6j5FWwz9VAfqtgyqqDIKY8bbq5zQFHj37BgHjdZi9D2VWI5p4N
X-Gm-Gg: ASbGncsExIf2JSpVVZEPBX0SYnfUW/fqZEcww5DCyEFg99F5q9AOSiQSDGjkxtojGIf
	c2J+NA0SKZx4AWfuODUjG0b/OFFDNg4M4jPyTh0NlAAUD6/AcKxB7y+fvhiWZ8PBR6e6HqRaDn1
	HeY5B/LLqaBKWJgUmEU81NewOs2y1Tx5saqJRvT91Ii9z4Ojhoq/bVW+YwJxv/STLsFSH7JfEY/
	k8XkKKOgKjb3KBI50Z3F8/TH5fABcJ+Cc4IgkvxJQZ8+R5jAZk0LdMQZGmy5Bv2WBAbqil22mhc
	N0PwPCk+RNWNaMvdf/M+msjhRanpJ28=
X-Google-Smtp-Source: AGHT+IGMWSgY6SmqhEEQxWaGf6EPof0vTWVBzN5VmeAvqvuhcqyCcyogapZfizzvVBgQAZngwajT5Q==
X-Received: by 2002:a05:6000:4185:b0:391:5f:fa4e with SMTP id ffacd0b85a97d-3911f7476b5mr1831848f8f.29.1741182899780;
        Wed, 05 Mar 2025 05:54:59 -0800 (PST)
Received: from krava ([83.148.32.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm21446837f8f.31.2025.03.05.05.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:54:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 5 Mar 2025 14:54:58 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: lirongqing <lirongqing@baidu.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/bts: allocate bts_ctx only if necessary
Message-ID: <Z8hXsvloKEb7ia3V@krava>
References: <20250122074103.3091-1-lirongqing@baidu.com>
 <Z8hV3WYuHxHBNoNV@krava>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8hV3WYuHxHBNoNV@krava>

On Wed, Mar 05, 2025 at 02:47:09PM +0100, Jiri Olsa wrote:
> On Wed, Jan 22, 2025 at 03:41:03PM +0800, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > Avoid unnecessary per-CPU memory allocation on unsupported CPUs,
> > this can save 12K memory for each CPU
> > 
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >  arch/x86/events/intel/bts.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> > index 8f78b0c..8e09319 100644
> > --- a/arch/x86/events/intel/bts.c
> > +++ b/arch/x86/events/intel/bts.c
> > @@ -36,7 +36,7 @@ enum {
> >  	BTS_STATE_ACTIVE,
> >  };
> >  
> > -static DEFINE_PER_CPU(struct bts_ctx, bts_ctx);
> > +static struct bts_ctx __percpu *bts_ctx;
> >  
> >  #define BTS_RECORD_SIZE		24
> >  #define BTS_SAFETY_MARGIN	4080
> > @@ -231,7 +231,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle);
> >  
> >  static void __bts_event_start(struct perf_event *event)
> >  {
> > -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> > +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> >  	struct bts_buffer *buf = perf_get_aux(&bts->handle);
> >  	u64 config = 0;
> >  
> > @@ -260,7 +260,7 @@ static void __bts_event_start(struct perf_event *event)
> >  static void bts_event_start(struct perf_event *event, int flags)
> >  {
> >  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> > +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> >  	struct bts_buffer *buf;
> >  
> >  	buf = perf_aux_output_begin(&bts->handle, event);
> > @@ -290,7 +290,7 @@ static void bts_event_start(struct perf_event *event, int flags)
> >  
> >  static void __bts_event_stop(struct perf_event *event, int state)
> >  {
> > -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> > +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> >  
> >  	/* ACTIVE -> INACTIVE(PMI)/STOPPED(->stop()) */
> >  	WRITE_ONCE(bts->state, state);
> > @@ -305,7 +305,7 @@ static void __bts_event_stop(struct perf_event *event, int state)
> >  static void bts_event_stop(struct perf_event *event, int flags)
> >  {
> >  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> > +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> >  	struct bts_buffer *buf = NULL;
> >  	int state = READ_ONCE(bts->state);
> >  
> > @@ -338,7 +338,7 @@ static void bts_event_stop(struct perf_event *event, int flags)
> >  
> >  void intel_bts_enable_local(void)
> >  {
> > -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> > +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> >  	int state = READ_ONCE(bts->state);
> >  
> >  	/*
> > @@ -358,7 +358,7 @@ void intel_bts_enable_local(void)
> >  
> >  void intel_bts_disable_local(void)
> >  {
> > -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> > +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> 
> hi,
> I'm getting crash below in here
> 
> I think it's because we allocate bts_ctx only if there's X86_FEATURE_PTI,

 ... .if there's not X86_FEATURE_PTI ;-) ...

jirka

> but then intel_bts_disable_local is called unconditionally from
> intel_pmu_handle_irq and exploding on accessing bts_ctx
> 
> there's no crash when this change is reverted
> 
> jirka
> 
> 
> >  
> >  	/*
> >  	 * Here we transition from ACTIVE to INACTIVE;
> > @@ -450,7 +450,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
> >  int intel_bts_interrupt(void)
> >  {
> >  	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
> > -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> > +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> >  	struct perf_event *event = bts->handle.event;
> >  	struct bts_buffer *buf;
> >  	s64 old_head;
> > @@ -518,7 +518,7 @@ static void bts_event_del(struct perf_event *event, int mode)
> >  
> >  static int bts_event_add(struct perf_event *event, int mode)
> >  {
> > -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> > +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
> >  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> >  	struct hw_perf_event *hwc = &event->hw;
> >  
> > @@ -605,6 +605,10 @@ static __init int bts_init(void)
> >  		return -ENODEV;
> >  	}
> >  
> > +	bts_ctx = alloc_percpu(struct bts_ctx);
> > +	if (!bts_ctx)
> > +		return -ENOMEM;
> > +
> >  	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
> >  				  PERF_PMU_CAP_EXCLUSIVE;
> >  	bts_pmu.task_ctx_nr	= perf_sw_context;
> > -- 
> > 2.9.4
> > 
> 
> ---
> 
>   [    9.615480] BUG: unable to handle page fault for address: ffff9eb419247000
>   [    9.615484] #PF: supervisor read access in kernel mode
>   [    9.615485] #PF: error_code(0x0000) - not-present page
>   [    9.615487] PGD ba801067 P4D ba801067 PUD 0
>   [    9.615490] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>   [    9.615492] CPU: 0 UID: 0 PID: 492 Comm: test_maps Not tainted 6.14.0-rc4-g5d70396a7df7-dirty #1
>   [    9.615495] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>   [    9.615497] RIP: 0010:intel_bts_disable_local+0x18/0x50
>   [    9.615501] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 65 48 8b 0d bf 1f 7b 02 48 8b 05 e0 b7 7d 02 <8b> 94 01 00 20 00 00 83 fa 02 75 1f 48 83 3c 08 00 74 18 65 48 8b
>   [    9.615503] RSP: 0018:fffffe71b3e00c78 EFLAGS: 00010002
>   [    9.615504] RAX: 0000000000000000 RBX: fffffe71b3e00ef8 RCX: ffff9eb419245000
>   [    9.615505] RDX: 0000000000000001 RSI: 000000023eb5576c RDI: fffffe71b3e00ef8
>   [    9.615506] RBP: fffffe71b3e00e38 R08: 0000000000000002 R09: 0000000000000002
>   [    9.615507] R10: ffffffffa023f735 R11: ffffffffa020dfe0 R12: fffffe71b3e00ef8
>   [    9.615508] R13: 0000000000000000 R14: ffff9eb419245000 R15: 0000000000000001
>   [    9.615508] FS:  00007f25164ac140(0000) GS:ffff9eb419245000(0000) knlGS:0000000000000000
>   [    9.615510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [    9.615511] CR2: ffff9eb419247000 CR3: 000000010b31c006 CR4: 0000000000770ef0
>   [    9.615514] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [    9.615515] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [    9.615516] PKRU: 55555554
>   [    9.615516] Call Trace:
>   [    9.615518]  <NMI>
>   [    9.615519]  ? __die_body+0x6a/0xb0
>   [    9.615521]  ? page_fault_oops+0x36f/0x400
>   [    9.615525]  ? do_kern_addr_fault+0x9a/0xd0
>   [    9.615526]  ? exc_page_fault+0xab/0xf0
>   [    9.615528]  ? asm_exc_page_fault+0x26/0x30
>   [    9.615531]  ? __pfx_perf_event_nmi_handler+0x10/0x10
>   [    9.615533]  ? nmi_handle+0x55/0x2b0
>   [    9.615536]  ? intel_bts_disable_local+0x18/0x50
>   [    9.615538]  intel_pmu_handle_irq+0x88/0x8b0
>   [    9.615545]  ? look_up_lock_class+0x74/0x150
>   [    9.615546]  ? verify_lock_unused+0xb/0x80
>   [    9.615549]  ? lock_acquire+0x1a0/0x2a0
>   [    9.615551]  ? nmi_handle+0x55/0x2b0
>   [    9.615553]  perf_event_nmi_handler+0x28/0x50
>   [    9.615555]  nmi_handle+0x116/0x2b0
>   [    9.615557]  ? nmi_handle+0x55/0x2b0
>   [    9.615558]  ? _copy_from_user+0x37/0x80
>   [    9.615561]  default_do_nmi+0x41/0x100
>   [    9.615564]  exc_nmi+0xb5/0x110
>   [    9.615566]  end_repeat_nmi+0xf/0x53
>   [    9.615568] RIP: 0010:_copy_from_user+0x37/0x80
>   [    9.615570] Code: 89 f7 49 89 fe 48 c7 c7 19 16 49 a1 be a2 00 00 00 e8 8d 3e cb ff 48 b8 00 f0 ff ff ff 7f 00 00 49 39 c7 4c 0f 47 f8 0f 01 cb <4c> 89 f7 48 89 d9 4c 89 fe e8 fb cd 65 00 48 89 c8 0f 01 ca 48 85
>   [    9.615571] RSP: 0018:ffffa49b403dfdb0 EFLAGS: 00040283
>   [    9.615572] RAX: 00007ffffffff000 RBX: 0000000000000008 RCX: 0000000000000001
>   [    9.615573] RDX: 0000000000000001 RSI: ffff9eb38b2c3950 RDI: ffff9eb389f40b58
>   [    9.615574] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffffffffff
>   [    9.615574] R10: ffff9eb389f40b78 R11: 0000000000000000 R12: ffff9eb382711000
>   [    9.615575] R13: 0000000000000000 R14: ffff9eb3824fd920 R15: 00007ffd584f7268
>   [    9.615578]  ? _copy_from_user+0x37/0x80
>   [    9.615580]  ? _copy_from_user+0x37/0x80
>   [    9.615581]  </NMI>
>   [    9.615582]  <TASK>
>   [    9.615582]  ___bpf_copy_key+0x52/0xb0
>   [    9.615586]  map_update_elem+0xd4/0x280
>   [    9.615589]  __sys_bpf+0x450/0x550
>   [    9.615592]  __x64_sys_bpf+0x1c/0x30
>   [    9.615594]  do_syscall_64+0x79/0x120
>   [    9.615596]  ? clear_bhb_loop+0x35/0x90
>   [    9.615597]  ? clear_bhb_loop+0x35/0x90
>   [    9.615599]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   [    9.615600] RIP: 0033:0x7f251668e25d
>   [    9.615602] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
>   [    9.615603] RSP: 002b:00007ffd584f7128 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
>   [    9.615604] RAX: ffffffffffffffda RBX: 00007ffd584f76b8 RCX: 00007f251668e25d
>   [    9.615605] RDX: 0000000000000020 RSI: 00007ffd584f7170 RDI: 0000000000000002
>   [    9.615606] RBP: 00007ffd584f7150 R08: 0000000000000000 R09: 0000000000000000
>   [    9.615606] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000001
>   [    9.615607] R13: 0000000000000000 R14: 000055bd9b4e01b8 R15: 00007f2516801000
>   [    9.615609]  </TASK>  [    9.615610] Modules linked in:
>   [    9.615611] CR2: ffff9eb419247000
>   [    9.615613] ---[ end trace 0000000000000000 ]---
>   [    9.615614] RIP: 0010:intel_bts_disable_local+0x18/0x50
>   [    9.615615] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 65 48 8b 0d bf 1f 7b 02 48 8b 05 e0 b7 7d 02 <8b> 94 01 00 20 00 00 83 fa 02 75 1f 48 83 3c 08 00 74 18 65 48 8b
>   [    9.615616] RSP: 0018:fffffe71b3e00c78 EFLAGS: 00010002
>   [    9.615617] RAX: 0000000000000000 RBX: fffffe71b3e00ef8 RCX: ffff9eb419245000
>   [    9.615618] RDX: 0000000000000001 RSI: 000000023eb5576c RDI: fffffe71b3e00ef8
>   [    9.615618] RBP: fffffe71b3e00e38 R08: 0000000000000002 R09: 0000000000000002
>   [    9.615619] R10: ffffffffa023f735 R11: ffffffffa020dfe0 R12: fffffe71b3e00ef8
>   [    9.615619] R13: 0000000000000000 R14: ffff9eb419245000 R15: 0000000000000001
>   [    9.615620] FS:  00007f25164ac140(0000) GS:ffff9eb419245000(0000) knlGS:0000000000000000
>   [    9.615621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [    9.615622] CR2: ffff9eb419247000 CR3: 000000010b31c006 CR4: 0000000000770ef0
>   [    9.615622] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [    9.615623] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [    9.615624] PKRU: 55555554
>   [    9.615624] Kernel panic - not syncing: Fatal exception in interrupt
>   [    9.615807] Kernel Offset: 0x1f000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>   Failed to run command
