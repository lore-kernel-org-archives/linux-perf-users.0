Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793304733;
	b=y02Mr7lH34n0l9XdtbUYFOL2aJDtf569SomCzpJyKLWqP0VaTIaLUTcWefDmOIeCCm/V
	 TNh9SAzFSSbHhe+LBJOOVL3SvUrb7MsMbvVmAXgh31SqJUc82u2lTFIbe4QtBFwwf5h1J
	 rEKCLWeB9p4b5z+zM0sUYY0G8QOprtpBNJnmnqPQsbnZK81gCWew7VYF5LqKDJGanL9CH
	 DUDnP6/kgNbbRFAZVcaaMTqTvQkRH4izRRUpyNdZGBXYD2PwriXYqRXnJ5B+m474TkRqC
	 Uic7OvwJuCu0R9HWRM5IOWKWskecuafUUGvmHkqPl8PzeqflFZEpt/QBzP/j4m1zMQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=I4MkKR6JIP2KDMXQy0atyZipWl/GBl7GkfJx4r11tBk=;
	b=g3YMRhXIf9nV2Y6fztlSuhjvCgmaONPdE1SiidzOleIsiscAvY2u2nvLdnSMmctiGZcM
	 BUKdKokY6yQVkCZ+9L9YRPMHrFaYptFS5FPyOKjYkTIyxRyurVD2/APbUu+QmcQYjHEzr
	 ruXOwVwRyO1xFp1mXv+WsxK9idxZqYUQhNjNwsw9S1QL7+FZNbanBfed6MAdqI0ZTa9nW
	 z6R88ge+4T6j1Hd7wFscWIV39JfHXFaT7oNo5tUz2Sc+CV/HZg85v9w61eNrUDuy4h7Ua
	 Tzz4pMZMkmaK1WfQgI92sPFIBheZ+r8TFhreGe4Ylxorq4eop/m4qg98JAwVKVjg7+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UFwV7/FK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08846606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 20:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08846606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UFwV7/FK
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so1345330a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 13:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793304732; cv=none;
        d=google.com; s=arc-20260327;
        b=K2F+G9wPzKEL/U/fvELhCif45qugMsRv/GnrOSz/+yoN4bF6XPQ/rcl/BPL/kYSRzX
         CIQkUEv1e2ich0PG+Zdykwx0t1pB5tWPrOKq5BXgIMHSYD56Nj/m9rcTkUm1R7VvYbWl
         IaRlHnybU6d/rDuC/dFBRUeSrcbjL5P/SUVdiithDBGOP2uzWylU+PhM9YdkjLI6eR8/
         uH7YGG7OuydqTpCoQO6Q8QPSdOR6dOLbojnJjz3A+QJcc+Q9LBHe75SBV12sZ66K35IR
         8EIfZCjML30dSa9LOkP6jtPZoogoObEHZB7oQqd0GL4CWiiWPjtUXZhtxZtkpqnBLY0l
         lCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I4MkKR6JIP2KDMXQy0atyZipWl/GBl7GkfJx4r11tBk=;
        fh=0/Tm4/0P32CHDyG3uaPqqg6z15rqGh85gOTxjtBhD7Q=;
        b=LdTnlGhGGsYjr56arU5OLlZacTH+IkWQg7D0HXdi263N5kBi27/lz+lgO1XWw+IiWy
         60A5gIi1VqnBsJ0p/KnCOKSZnTe7syov25mhl15Ddy8EeZX+dY1uPimPehjg/0biBNEu
         IAx6tyf4reE9VILkhbfJLzkEoq8JG+B79TPMmmOz9LM5XUKOfrgnpXPcQWBbuqJWMLym
         36wMiJMxR/rcIKMPC5kISvW/qMWHY0drpeuaGXDDaoDTfLBYJfU/YEVLlG1dgjp7v6X1
         5ZYqSKHjsgR01oAkRSbckgGnEf9vjGhU98o5530Y+nMagFfShBIAYOc3RE0leSuRgpI9
         d7uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793304732; x=1793909532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I4MkKR6JIP2KDMXQy0atyZipWl/GBl7GkfJx4r11tBk=;
        b=UFwV7/FKl/rLJt4F063/DU5f1VBHC2QGKLaJqYcvpvIf0z6uEzyITXltH+3AkSOCb0
         ANgAAbay/s/fF46r9m9qjUtcK67KTMp6IfbIClkolwhY7TvfhzKUA4nyKDykKiAIxxMS
         kpJIhOkum+Jk/JP1ELIGskm6cXKoTVBA7lt3PrfcQYwpJ7XDAXeoivLWFc7cAmem9J+z
         NFJ2wgS9fJXPxhFGjEl8Gvvti+mkczGgQN0+RflZOFnQt3e/MOiIjyKActMH8T8EG+is
         vcgFCBGPKHEP6tYcWfiKFPYpijHZkLCL1jvcgmfwz2kA3THg/Mwnrd08Hz+6mhbtU8TO
         x3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793304732; x=1793909532;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I4MkKR6JIP2KDMXQy0atyZipWl/GBl7GkfJx4r11tBk=;
        b=dUOBwGQWOr8AAahxTByxYQFxc0yO4CNgkhhcBiq1WgTJFXy0O5fNOSbFYSDOWkIU3o
         5oNDSdm4Y70k9lLt2dypvmoIWabxOhdbvHSuVyIF2lVRI4ow3y8/TH+Z+WY067LpacDM
         4lXPPRHOXAfYdHqyD392h4N4PLiZ2sUH6BFfrxOpd1a4uUCGF5mWfg7Sn4UvSijYlA+J
         m3hQiuY/DrXH1W+f6wL36DELY+zlEt+BCTLInERk5batnsJnvKb9RlFu8CIUD85/Csx8
         Z86G53StjFvLm8gDbvQDVHVNJQScaKzWBRZrQnlNO44xqMQ7sBz8MPm2OotfFhqxDSn3
         uW0w==
X-Gm-Message-State: AFq9FYKTTa/Y+kMmBRta3ITONmjLu0oT6C/2sDqYk4WJtxvZ3rMxukzb
	m4I27zEk7z/lEAVyU3FMem+1iYa9MasdYilEh2uQogavW4r41dcDwaqXozaufudzNBJ1K2N+mp+
	hR3UMbEriaR8xYYRb1HDrzF9z82fAPyM=
X-Gm-Gg: AYBFou2koHX+h6Lz6nl6Fmocl9xQsk30EEp1r9jhIPY7RJQ3LgD94W0MIcAni5lRiGf
	K2MuJfpZkmHsu90BzHYacdgLOba2e+3yNFj5SIPQ7UmNtkZ6i1uMGYKBUOjmie1HxVXJVW6DwPe
	CZpL2dX8uMRm4bDkzekMtk1seUYXN3AKiLrUcjcG457niEq37va4DW60qquF/xDlh22xueABPN7
	HUAkFcd1WX4LnzDxR0M1HYaORidTXVMWC4876X6E1czKjnDTTBsg/Kqq/dy9RPZYE+dZEfd0NWS
	YCmIClnIxBcvwobYumlg7h8auZyzcg/BRQEpdQ7Q3QBOVGsm9zW04Ii5v5k4QS9m3hTb41IlGou
	wzNo8OqBYpRP8RJ4SaVx/Dgan3O1Wekn+6gE7XCmyt0bBpXkhfkQe+uhzdmMaXlk8BzvzFb9CV6
	r6fwLYL8Axz9yRYPowRxx2a/ot+tnJ9Qd9LYcEpDNpCUBCyzzquvG2uJ4=
X-Received: by 2002:a17:90b:2891:b0:3ac:7c52:fb04 with SMTP id
 98e67ed59e1d1-3ae897ab44emr53096a91.44.1793304732221; Thu, 29 Oct 2026
 13:12:12 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023124157.75524-1-puranjay@kernel.org>
In-Reply-To: <20261023124157.75524-1-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 13:12:00 -0700
X-Gm-Features: AclHuK8MkbbkbEYYrLZY6y9oQnDFH2cmvw9bwmFuv3G0y6W5whRHgCqUuNX5aMs
Message-ID: <CAEf4Bzb2jEjqpZrmtTk_+YCW3_jU8fcVzk26CBZnxkpYJ8kCbQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel
 branches are recorded
To: Puranjay Mohan <puranjay@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 5:42=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen on
> PMI, so the branch stack ends before the IP and callchain, which are
> taken when the NMI is delivered. IBS rejects branch-stack events, so
> there is no precise alternative.
>
> The freeze only keeps the PMI handler's branches out of the stack, which
> matters only when branches into the kernel are recorded; without it the
> stack fills with the handler's own branches. A user-only filter does not
> record them, and parts without the feature are never frozen (see commit
> 598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")).
>
> Freeze unless the value written to LBR_SELECT, which is shared by all
> events on the CPU, suppresses branches into the kernel.
>
> With perf record -e ex_ret_brn_tkn:u -j any,u on a Zen 5 part running
> CPython, the function of the sampled IP differs from the function of
> LBR[0].to in 84.3% of samples with the freeze and in 0.1% without it.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/x86/events/amd/lbr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index a55646fcb8465..7ec50380ac81d 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -392,7 +392,7 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_con=
text *pmu_ctx,
>  void amd_pmu_lbr_enable_all(void)
>  {
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> -       u64 lbr_select, dbg_ctl, dbg_extn_cfg;
> +       u64 lbr_select =3D 0, dbg_ctl, dbg_extn_cfg;
>
>         if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
>                 return;
> @@ -405,7 +405,12 @@ void amd_pmu_lbr_enable_all(void)
>
>         if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
>                 rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> -               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE=
_LBRS_ON_PMI);
> +               /* Freeze unless the filter suppresses branches into the =
kernel */
> +               if (lbr_select & LBR_KERNEL)

On Intel CPU side, we reset this FREEZE bit in
__intel_pmu_lbr_enable() if is_lbr_call_stack_bit_set(), with the
comment "LBR callstack does not work well with FREEZE_LBRS_ON_PMI.".
So this is not *exactly* what Intel side of things is doing, and I'm
not sure I fully understand the differences, so hopefully someone more
knowledgeable can help.

But what Puranjay is trying to do here is to at least make a
user-mode-only LBR and IP + callstack to be coherent (for PGO data
collection, which we then use for user space app compilation), by
disabling freezing for LBR.

It doesn't seem like there is anything we can do on AMD hardware for
when we want kernel-side LBR and precise IP to be in sync,
unfortunately, but at least for user-space only case it would allow us
to not plain disable freezing altogether at kernel boot time.

Does this approach make sense?


> +                       dbg_ctl &=3D ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +               else
> +                       dbg_ctl |=3D DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>         }
>
>         rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
>
> base-commit: 0f443787a7f6ae907975742680aac2600483eaf1
> --
> 2.53.0-Meta
>
