Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1936C588
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303502; cv=none; b=JK/bpaNlWgSeqhXnqskk5GIED870J+cTgCX5KBQayJ45RjF4H6Hzwk9ojlGpUqZ8/yIvkwtNpXwDvwvoBTF3pGPzbO787M2Xz1qIKskF6HY5/lDI2kWFFH0EN+HE9kJ4dJcmFLOkZnC8ljas4RA5A8cZfYxExWQgUz42ChjfIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303502; c=relaxed/simple;
	bh=G0LQMD1gwDkFu+2A3fwory5Rbbxiac7YFZLMKCoAqyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWOvIgRGtFvMAmDhFnhoLfG4y/zH9+soSQliN2mItBF/JW9SHsWvAnqSxiGsdiVGyy9KheJbVI1EsYmGiECmcD1cnfXrNwBGjO1OdqZGUewfBAwUiit6loDgEAbXlwz1AwKFyeB6h/BDakku8tF96nkCCjs/85Z4UiHIkn30MXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YsFhwZJ+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YsFhwZJ+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-473987fc217so857654f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784303498; x=1784908298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qN8qo5HLDZfVutpj/7D5Up9Ad2jxvpUua4OXmY0wtBg=;
        b=YsFhwZJ+GZyeWScRPiewOrjYvhQlwPU5JIV5ur64r1OAsA07SV0br5j3SsHreGSGJ4
         Hfc1B7gh2w9mIUXPYq/QqCmesC1Fvhp1luc/B89lHy+cmKZbaeRKarYEvNNjeD9yuEpS
         DfIvXTfyiaIQn/+7xnIt8D+H2t6Fbm3zI+fjmF6anRF6D24zrNpO6WsRyfP5ZzG9a3Bz
         ri/Jehe//3LSkoR0lyLWnBxP3jkrV7OH3KeLq79LIdAXcPK7dqnnsSZ4KyY2UY4W6w/v
         h32Zhq4YhqCXxaYJkc7Fi+mGVOMF+R5OznxbgzFPxoCjY3Af6a6QWzMCzvOOttVcBpLf
         riRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303498; x=1784908298;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qN8qo5HLDZfVutpj/7D5Up9Ad2jxvpUua4OXmY0wtBg=;
        b=r78IE9d8NhxAq8Wc3W03vagA7uMyiqVPFZP08i+Shxg5t0nw56osxbVdUPNryZ9hDW
         j2DCSBVroZnC12CI4ML8T13XHjGFct+px07aMS3LJqRqDdPEBC+faYwedFiYCh810Yrg
         4rlv4vXaA6AepIfDtdWJobm6QINFRfdBNbLfBTPen1BexEf13XBHavrQFE9N1A+iYYXX
         LLwTTReYY2z7LOxw39B+kAHHH416N7d3YULS7U0xJS1v0Ou3dx7MavCjQnpJp7MhH0Th
         KV0Qygf3mumqNgcY4FJ4syx7BYsUu2LMBVOmajEN+lzTk89JvnFzHo7z33Aiuk+mMrh8
         7lBA==
X-Forwarded-Encrypted: i=1; AHgh+RpqyTH8zEAht5EPC9HwAfzuJUn3hqt56S8XoRXh7ghS94ayOhXYIgFVCQJxVIZ3OFO7rPHeHMAM6zI+h5tRFdVX@vger.kernel.org
X-Gm-Message-State: AOJu0YwlRUe47+566q3/bihX+xTyhS8Mf6+5mdEsEHYN7nQN1flMRySH
	0ZeHiUCjJpJbqET+KyKsRnYhBrI7ca7T1FnG2QPbApWPuU79ATxOP7u7KNax79KOIDI=
X-Gm-Gg: AfdE7ckQI1ANfZKLhQf2rCwrkOabubUZ91Y9gV1gtG/aGJouVgri23ppReamOtMukiG
	ddZlZMr2fatXzzaXdJSK8LKQLolgbgh80Hlg35/WXL9cRYB25VwaTAbopE/8Wai2jhut0ceTSI1
	Ykw2t10XIlpyk1jBobMNWWjiIaQJsX0cY/To7VQNAUGbkXbhZ8kwG1eyHDRYJommeWckVJmxIM0
	7xIVxyTrYapspzYbswz2BilpRLigcpRcjejsflCow3ypNjolytEhZB4dHY8qIx6jqetCINcMNDM
	iaY1Jb0dNKolEMQHcltAs9HywCdX/qwKmA2EWG0z0K/Hla6gDVsdcZAs3dYxWAdyDRYIrbJFGmz
	kXcNVUXo8hRefDnph4qUsNpupzc/BCr1zFgTuxhgoTSkm/4+8og1crG8xBtKBRVSZBjFzYxWSre
	gEh/6vV8YlTM2L4MGvRBGxW1kTggN7cHZWIa6vYvz2MD3XgK+iE1CRfQ+wpGZYQWwPSm5y0Tjd1
	PMBog==
X-Received: by 2002:a05:6000:4284:b0:47d:2a79:a2eb with SMTP id ffacd0b85a97d-47f62322529mr2342313f8f.5.1784303498047;
        Fri, 17 Jul 2026 08:51:38 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63edd7d3sm4157882f8f.25.2026.07.17.08.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:51:37 -0700 (PDT)
Date: Fri, 17 Jul 2026 17:51:35 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf/x86: Do not read fixed counter control
 register if there is none
Message-ID: <20260717175135.450f2788@mordecai>
In-Reply-To: <20260717151858.8ED701F000E9@smtp.kernel.org>
References: <20260717150315.2868314-1-ptesarik@suse.com>
	<20260717151858.8ED701F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 15:18:58 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Using `x86_pmu.fixedctr` as a capability flag is conceptually flawed and suppresses valid debug output on Zhaoxin.
> 
> Pre-existing issues:
> - [High] Zhaoxin PMU fails to initialize `x86_pmu.fixedctr`, leading to broken fixed counters and unsafe RDMSR accesses.
> - [High] Undefined behavior in `GENMASK_ULL` during Zhaoxin PMU initialization if fixed counters are missing.
> --
> 
> --- Patch [1]: [PATCH 1/1] perf/x86: Do not read fixed counter control register if there is none ---
> commit d0dd53a6709a65141e2d105b19abad4d851825d4
> Author: Petr Tesarik <ptesarik@suse.com>
> 
> perf/x86: Do not read fixed counter control register if there is none
> 
> This patch skips reading the MSR_ARCH_PERFMON_FIXED_CTR_CTRL register
> during perf debug output if fixed counters are not implemented. This avoids
> a #GP on AMD CPUs with PerfMonV2 that do not implement this register.
> 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 576baa9a52c5b..3055d59e0e82f 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1572,13 +1572,16 @@ void perf_event_print_debug(void)
> >  		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
> >  		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
> >  		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
> > -		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
> >  
> >  		pr_info("\n");
> >  		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
> >  		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
> >  		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
> > -		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
> > +
> > +		if (x86_pmu.fixedctr) {  
> 
> [Severity: Medium]
> Is it safe to use x86_pmu.fixedctr as a capability flag here?

Good question. In fact, I thought about it, and yes, introducing a new
flag would be the cleanest solution, but it seemed overkill just for
this debugging output.

AFAIK the MSR offset of the fixed perf counters cannot be zero, because
those MSR addresses have been assigned to other architectural MSRs since
Pentium times...

> The x86_pmu.fixedctr field is an MSR address, not a boolean capability
> flag. While this check works for most architectures, the Zhaoxin PMU driver
> fails to initialize this field, leaving it as 0. Because of this, the check
> evaluates to false and inadvertently suppresses the debug output of
> MSR_ARCH_PERFMON_FIXED_CTR_CTRL on Zhaoxin systems.

I don't know about Zhaoxin. Do these syste have fixed performance
counters and a corresponding global control register?

Adding Tony W Wang to the recipient list...

Petr T

--

> > +			rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL,
> > fixed);
> > +			pr_info("CPU#%d: fixed:      %016llx\n",
> > cpu, fixed);
> > +		}
> >  		if (pebs_constraints) {
> >  			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
> >  			pr_info("CPU#%d: pebs:       %016llx\n",
> > cpu, pebs);  
> [ ... ]
> 
> 
> [Severity: High]
> This is a pre-existing issue and was not introduced by the patch under
> review, but the lack of initialization for x86_pmu.fixedctr causes
> other issues.
> 
> In the Zhaoxin PMU driver setup:
> 
> arch/x86/events/zhaoxin/core.c:zhaoxin_pmu
> static const struct x86_pmu zhaoxin_pmu __initconst = {
>     ...
>     /* missing .fixedctr = MSR_ARCH_PERFMON_FIXED_CTR0 */
> };
> 
> Because this remains 0, x86_pmu_fixed_ctr_addr() returns 0 + idx
> instead of the correct MSR. This causes fixed counter 0 to silently
> return without updating in x86_perf_event_update():
> 
> arch/x86/events/core.c:x86_perf_event_update() {
>     ...
>     if (unlikely(!hwc->event_base))
>         return 0;
>     ...
> }
> 
> It also leads to unsafe MSR reads when iterating over the fixed
> counter mask in perf_event_print_debug():
> 
> arch/x86/events/core.c:perf_event_print_debug() {
>     ...
>     for_each_set_bit(idx, fixed_cntr_mask, X86_PMC_IDX_MAX) {
>         ...
>         rdmsrq(x86_pmu_fixed_ctr_addr(idx), pmc_count);
>         ...
>     }
> }
> 
> Could this lead to reads from arbitrary low MSRs like MSR 0, 1, or 2,
> potentially triggering a system crash if a user programs fixed counter
> events or triggers SysRq-P?
> 
> 
> [Severity: High]
> This is a pre-existing issue and was not introduced by the patch under
> review, but does this bitmask generation in the Zhaoxin PMU
> initialization risk undefined behavior?
> 
> arch/x86/events/zhaoxin/core.c:zhaoxin_pmu_init() {
>     ...
>     x86_pmu.fixed_cntr_mask64 =
> GENMASK_ULL(edx.split.num_counters_fixed - 1, 0); ...
> }
> 
> If a hypervisor configures the CPU to report 0 fixed counters,
> edx.split.num_counters_fixed - 1 wraps to -1. Expanding
> GENMASK_ULL(-1, 0) results in a right-shift by 64, which is undefined
> behavior in C. On x86, this yields ~0ULL, making the kernel assume 64
> fixed counters exist.
> 
> Could this cause the kernel to attempt reading 64 undefined MSRs
> during debug output or event initialization, leading to #GP
> exceptions?
> 

