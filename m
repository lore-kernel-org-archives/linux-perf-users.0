Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B93B71AC
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747478; cv=none; b=l2FBMndQiSIiFM4rG38URF873N5vN9hJ4sEcWXE5NaU+WfdPCJVhocCq5yFCzwHTWXtVslK0gV3UJfca3qLljvKr0M3SDGhpA9awdGgfhqHMKfFX5wVyZg6y/drbWkci0HOk5pT+rq2AFpzi8nm+6d4lb6+Vel9WJj2gE9WcD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747478; c=relaxed/simple;
	bh=utJ+sBQX68JoONUFlf4nYR3UIpRqDL5wnJ2dyXL2qYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKwvo7veh3XoYIkxehHowxJinYMh4Yk+5938f06M+StdXE/j9ijll6CQtrykdKavpVJhbD2lkFfizAh+xlp4btmkY59PR22c9k5bshoOsLKhnfxYHS4arDdFm9AsVT0Egw2hnWJNIFY65h+D6lt5txBsxyTIwfbjaD58V/2Wtu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DjThoO88; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DjThoO88"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4955c545a94so1836945e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Aug 2026 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785747475; x=1786352275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QNlWLzOtWY2GfkcJcUqWNM+srtqBUFdfVlqmq0ROfDw=;
        b=DjThoO88WrhzldiVNOgoweCb6k3Dj8b0ROeqHvObtjhjsthVCr+nanD78U+FOxCYBv
         41WAHqcnI5CkRK2KrbUynNRBqEQ7X4rhxTyngmPwKF2UEPB3QOmYpddhh5+3IxJamg6I
         Vs0esr/JVF7BJ+0LNqODzNzlw2UCOkn3kNxHTFZSkUy/7RjKjyCUW1R0W1n4ncjCmxf/
         UMuuINhs/VFG6TuR4UOfUoBV0olGI8MuXLg7IZzwmYfBq45PHlG6Ar7GHvVP/dHQJEpr
         trq4a7jSXblD8UAOhvR+0iawCbDK6q+YGoxLiiFKyvU4A5SdGSoLoJqcqykYxgrkiSWA
         +OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785747475; x=1786352275;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNlWLzOtWY2GfkcJcUqWNM+srtqBUFdfVlqmq0ROfDw=;
        b=Ih62KI48/0tphDkxCa6td5uEhSU8eQol0+PRK7qH/q/gKzcxUNl0kWcgpUQ0AR89ll
         qzQ12pDvSkvR74AA0nVQ+/5czE62bdJ/J+U2A1MJZrAVA4GYTRfPBUC9N8THyFrDtQWJ
         o2cjkpybYx+3kIPEK+Ge06pVihE+85goWOZlL2Fizt+su0BW4bvceTcLluAZXCStmT/v
         j7RTLkmAWuOnUI8SxlknBoC60TCHEO0k52lLWZVbwPfgw7qlR92ymABlwgTTtfJF2eE/
         vnDkh7k0bXN849bG7S6yj/bcdv9HRGfUw6aL6fML8RkOTII8gDUTNQzOW5bcnMdj6YOU
         bF0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpM04nRcf6OKPyf5mS5fh3lyKIAPrd9uB00QADP0T71KddVWjO4kziNiZfdRfzL8Zs+vCelj9JE8C953ljTLmBq@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQ3/KlLOhnjFJvOcPpHFAsnpLKtORyTkmSZcZpYH38TtrU8F3
	forAu01fP0DPQqCbGj7uBQLHVT+EvhM5u0dGh25qKlYTYl4qEOGZ3y2YfFwww5C7uQo=
X-Gm-Gg: AR+sD10Aw2wM2orB9CLszJi2LuaFC9MC3TOAVy/rt29bT50i0DUudMnXVvkRACa9fnh
	F+xPe3MgNPayDQAj5bYPzo8Qsfs433m+SSk60p6coaZl2iHtVDevsDGpsQyBrKQYYSnJUb3WmD2
	fV3rK81Up/PGeikafPSvRp2qx1S7lPKWJNMjEQmdwxCHpEwcZnYLe/vem4NyZoJXL5HZN4P0GNY
	5D/aBbtJl9iyOv3HczDaZ37bRFnkua0x69tGJUElvys5QcjjLzEY5ygsS5mBqDIklsCYz1ry7zs
	uu/Z8hfxp3FGDSMl1wQ17AagD58hmnSFXgfyuOtxO3acOH/GaOOGbzQfNxxwER+b6nEocot7gsg
	3xViRUfiqAOSkIwelRq+UjE1/FLBwAEwnvhW/jegVhsVDtqVlczvE/ne33RNDJ7MMh22UuC5336
	MULJJfEhi+9yRxF/Sbdv2Rd0yg2UGbhKGLFkCzWVNpAAPZRuvyv7Slr9YQOBU2fBAEkkuBYbg1/
	QYq8DCwSPZGVnboKokWQhW9IJ6nN0SaK9fbQSynKgRIw1sST2jQpIDhG0r6gXiTrA==
X-Received: by 2002:a05:600c:1d0a:b0:492:7082:92e9 with SMTP id 5b1f17b1804b1-4980c5ec794mr112090505e9.0.1785747474701;
        Mon, 03 Aug 2026 01:57:54 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b2a61asm150614545e9.0.2026.08.03.01.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 01:57:54 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:57:51 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Sandipan Das <sandipan.das@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Thomas
 Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf/x86: Do not read fixed counter control
 register if there is none
Message-ID: <20260803105751.17146a49@mordecai>
In-Reply-To: <82ff3301-13e1-4ebf-9f74-aa4318848cc5@amd.com>
References: <20260717150315.2868314-1-ptesarik@suse.com>
	<82ff3301-13e1-4ebf-9f74-aa4318848cc5@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 14:57:25 +0530
Sandipan Das <sandipan.das@amd.com> wrote:

> On 17-07-2026 20:33, Petr Tesarik wrote:
> > [You don't often get email from ptesarik@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > When printing out CPU performance registers for debugging, skip
> > MSR_ARCH_PERFMON_FIXED_CTR_CTRL if fixed counters are not implemented.
> > 
> > Since AMD CPUs with PerMonV2 do not implement this register, attempts to
> > read it generate a #GP. In particular, SysRq-P logs something like this:
> > 
> > [   14.748144] [   T1118] sysrq: Show Regs
> > [   14.748896] [   T1118] unchecked MSR access error: RDMSR from 0x38d at rIP: 0xffffffff937154c6 (native_read_msr+0x6/0x40)
> > [   14.750878] [   T1118] Call Trace:
> > [   14.751505] [   T1118]  <TASK>
> > [   14.752057] [   T1118]  paravirt_read_msr+0x7/0x10
> > [   14.752940] [   T1118]  perf_event_print_debug+0x135/0x240
> > [   14.753931] [   T1118]  __handle_sysrq.cold+0x9b/0xde
> > [   14.754855] [   T1118]  write_sysrq_trigger+0x59/0x80
> > [   14.755779] [   T1118]  proc_reg_write+0x5a/0xb0
> > [   14.756631] [   T1118]  vfs_write+0xce/0x430
> > [   14.757406] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.758322] [   T1118]  ? security_file_fcntl+0x5f/0x120
> > [   14.759083] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.759754] [   T1118]  ? __x64_sys_fcntl+0x80/0x110
> > [   14.760334] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.761005] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.761676] [   T1118]  ? __ct_user_enter+0x27/0xc0
> > [   14.762270] [   T1118]  ksys_write+0x6a/0xe0
> > [   14.762776] [   T1118]  do_syscall_64+0xe1/0x610
> > [   14.763324] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.763995] [   T1118]  ? __ct_user_enter+0x27/0xc0
> > [   14.764564] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.765233] [   T1118]  ? do_syscall_64+0x205/0x610
> > [   14.765806] [   T1118]  ? __x64_sys_ioctl+0x97/0xe0
> > [   14.766375] [   T1118]  ? __pfx_woken_wake_function+0x10/0x10
> > [   14.767048] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.767717] [   T1118]  ? get_close_on_exec+0x34/0x40
> > [   14.768311] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.768985] [   T1118]  ? do_fcntl+0x6da/0x8e0
> > [   14.769502] [   T1118]  ? do_syscall_64+0x205/0x610
> > [   14.770083] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.772321] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.773166] [   T1118]  ? tty_read+0x150/0x220
> > [   14.773722] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.774423] [   T1118]  ? filp_flush+0x5b/0x80
> > [   14.774966] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.775660] [   T1118]  ? filp_close+0x25/0x40
> > [   14.776214] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.776936] [   T1118]  ? do_dup2+0xae/0x140
> > [   14.777486] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.778309] [   T1118]  ? ksys_dup3+0x67/0xf0
> > [   14.778870] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.779600] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.780310] [   T1118]  ? __ct_user_enter+0x27/0xc0
> > [   14.780917] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.781613] [   T1118]  ? do_syscall_64+0x205/0x610
> > [   14.782215] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.782907] [   T1118]  ? ksys_read+0x6a/0xe0
> > [   14.783429] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.784120] [   T1118]  ? __ct_user_enter+0x27/0xc0
> > [   14.784741] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.785431] [   T1118]  ? __ct_user_exit+0x15/0xb0
> > [   14.786014] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   14.786706] [   T1118]  ? do_syscall_64+0x98/0x610
> > [   14.787282] [   T1118]  ? exc_page_fault+0x6d/0x180
> > [   14.787873] [   T1118]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   14.788612] [   T1118] RIP: 0033:0x7f70d6497e0a
> > [   14.789186] [   T1118] Code: 08 03 00 00 59 5e 48 83 f8 fc 75 1e 83 e2 39 83 fa 08 75 16 e8 05 ff ff ff 0f 1f 80 00 00 00 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
> > [   14.791587] [   T1118] RSP: 002b:00007ffc36a93580 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > [   14.792617] [   T1118] RAX: ffffffffffffffda RBX: 00007f70d65f6580 RCX: 00007f70d6497e0a
> > [   14.793594] [   T1118] RDX: 0000000000000002 RSI: 0000556f34e41c30 RDI: 0000000000000001
> > [   14.794574] [   T1118] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> > [   14.795563] [   T1118] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> > [   14.796537] [   T1118] R13: 0000556f34e41c30 R14: 0000000000000001 R15: 0000000000000000
> > [   14.797514] [   T1118]  </TASK>
> > 
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >  arch/x86/events/core.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index d1af33d96d0a3..8310bedfc364f 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1581,13 +1581,16 @@ void perf_event_print_debug(void)
> >                 rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
> >                 rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
> >                 rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);  
> 
> GLOBAL_{CTRL,STATUS,OVF_CTRL} functionality is also provided via different MSRs
> for AMD PMU version 2 and I assume that reading the ones above will also raise
> #GPs. If they don't, the reported values will surely be incorrect.

They do not raise #GPs on my Ryzen 7 system, but that's about the only
system I have tried. 

Honetly, I was very unsure about the availability of the feauture(s)
and what the appropriate checks would be; that was the reason to
include you as a recipient. What is the AMD-recommended method to check
whether a CPU supports global perf control MSRs? Does x86.pmu_version
even work? If yes, should I then simply make the actual MSR numbers
conditional on AMD/Intel?

Any guidance welcome.

Petr T

> 
> > -               rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
> > 
> >                 pr_info("\n");
> >                 pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
> >                 pr_info("CPU#%d: status:     %016llx\n", cpu, status);
> >                 pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
> > -               pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
> > +
> > +               if (x86_pmu.fixedctr) {
> > +                       rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
> > +                       pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
> > +               }
> >                 if (pebs_constraints) {
> >                         rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
> >                         pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
> > --
> > 2.54.0
> >   
> 

