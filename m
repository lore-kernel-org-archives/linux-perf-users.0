Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21C37F731
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939723; cv=none; b=EJZsPjodm2k/ol7bsfMF07K+chMnSgiWf8gLueag+bn/nzM2iD1lckM/0vkTe5ipblPP+pvcRTcG3vs8KpNCXkNFx3R6QBPdQnQ7mM7bORcSGmBkRwvaKT4/RSnmKME+h9fNx4IKDwauOw/YGD4AmOGyPi9AdAGhcBi5ZA5Wu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939723; c=relaxed/simple;
	bh=av9//se+AwhUf4zjQxY9RW9C/JLGT1M44Wvvl3nQLqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzAJjCspEXB8/WGMjC6JRE3pW2ua9oAOj7v5Xbhuo4iIWL8jTZP8yFEqh+i5OXQHEl1JI13JWw37Kq8I+qQmkLr3+FRZLud7lvuNwZ/Pd0M9WtwqeOcAkBCKh0DB5wXBLtu/El2WdS/vQueQDL12L0AsgeI+w7q3IgKGTsA0ZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WXRA/MOd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WXRA/MOd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495773ee3edso1002025e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785939713; x=1786544513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WySqZqciDSZsTFfgfoBrLL6iuvC2b9KBESQU3V88xEE=;
        b=WXRA/MOdxnjha4MWOruW35NoSVsAXMfulEvo2I8Wy4Y5Y79QMbJiRPZnYnYjlWAzWP
         Rnm+X/C58zap7UQojgbT6JIETGzg2YoU/Scmtd3q1Lm8vTMzRfV7CpJmvuEoXBLGafQp
         Uzk7/H8Mj6qwILx6xqfxzh1kfTEvwNxBenz+Js1+JNILIs2tug8OKZbJqhZovbY7hJS1
         ZgwmMpFLfAHYmAdTCofZZHZi8+kvHQhgwsJmvR64vxqNgeBHdpW38Vh8bedvaNPWmXo1
         BDGl9Fu/3nxH6RGKxh+Qdj3c8KyOO5AIXRCu0M9OUZe2YyBHcTg7AJAertR6PTg/kgoc
         hwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939713; x=1786544513;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WySqZqciDSZsTFfgfoBrLL6iuvC2b9KBESQU3V88xEE=;
        b=p9fI0sM59s3sSwCOclnggNQvlgjeF64nMVNw9bMUuKv2YPzxOLZadqynB7ij0DAe++
         BFhcSqE+gLar5ov0xuh2LS8Ot8tRThtiJGTYOCWfNpcJh7NS7SwUFRGUQ6g8X7ZDwfg+
         CHoPgMMc1oIQWlQJKcS3iy8cjbs+lO4d5LcKIwM9sPBMc0qVDIFl0E/KTW2SpF4LUqNT
         s8iXB+ZzoKHfsq554WK5ugNpxLDx+s5BA96KiZtFg+kHsCjHHJ/ZUABo9XL3NmvnG5m3
         9KZzUuXuOnnSybOk/8sFAWaBrbagC12Whl/06w+/uDoYtPyvMfXns7d2CQhRHrAJAWnn
         69Ig==
X-Forwarded-Encrypted: i=1; AHgh+RpQdIcpqlQaacgo3G+QRyT1/eIIQzEgFlMp8Ur3rB36mPf3laBgJJG31sFTx1UOs8sQVzd/JzZjRkrfdyziNCgI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/e+FGdeIXV/FUgy4KOTSrN7XKklN3/9Zo9+xm5MWTYXWVke7
	4P4ed2yj1nqTzCatfu0rdoghNBQeptASvsz3r6Aagzr5Z0PYkFZayB5LZwEDZbGPM2c=
X-Gm-Gg: AR+sD10uQsmHYbvRzQQbqIaXep+K+oNqahs1Q7pjTIlwL6Hh5wuKOboXAOVjp5wCaIu
	fEgoyHuo6+PNGJGPcCFlJJIl3MbA/LXBry/6tcq4WIM8FmtppQnp6dBSP+nVR1I8I3+jCiPrcWk
	gLqmAo+XRsA9EtBNcc0bWKtm64vuzoVcp96d4rUUj0ptTchm/UbAgtMGJr5fjmwytF+/Debuy+3
	IbA+/fgPBU/V2w+GifGN+fV7+B1iYb4OKKo6W+Hz++XKuL+OgGGPX1AHb+tULXhdkoli2s52/9U
	nXyNENZYgZ+2Xp1oawUjka9pt9Y/IM3Q4ncoE4xe63RAw3z/uach3+6hp7DXnG6c7qOZfbbcNMd
	oXDADyrXueh8jfcHfv7AD9jPqYF+VMelt2LjgqDKXi9NWEb1q3Oz5hwJD/3xAXrm7pwUchSaDhs
	8ln58wLUueiRq7oask/thDCf9nytW8bJToed+Yhs2b3z6raKrKBTh6TD396Ixn8UJsSi05KD28K
	EOfi4D6wlIsjUU6jXPTM9MhyiBc9yq7S/pBaOcvYgC7y9S4tzkOEA==
X-Received: by 2002:a05:600c:1550:b0:493:ad11:6d5c with SMTP id 5b1f17b1804b1-4994e7cf0dcmr43311805e9.4.1785939713017;
        Wed, 05 Aug 2026 07:21:53 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a100e14sm171170215e9.14.2026.08.05.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:21:52 -0700 (PDT)
Date: Wed, 5 Aug 2026 16:21:49 +0200
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
Message-ID: <20260805162149.55337f22@mordecai>
In-Reply-To: <7284a598-0799-45d9-85ff-739563ddf226@amd.com>
References: <20260717150315.2868314-1-ptesarik@suse.com>
	<82ff3301-13e1-4ebf-9f74-aa4318848cc5@amd.com>
	<20260803105751.17146a49@mordecai>
	<7284a598-0799-45d9-85ff-739563ddf226@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 12:30:36 +0530
Sandipan Das <sandipan.das@amd.com> wrote:

> On 03-08-2026 14:27, Petr Tesarik wrote:
> > On Mon, 20 Jul 2026 14:57:25 +0530
> > Sandipan Das <sandipan.das@amd.com> wrote:
> >   
> >> On 17-07-2026 20:33, Petr Tesarik wrote:  
> >>> [You don't often get email from ptesarik@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> When printing out CPU performance registers for debugging, skip
> >>> MSR_ARCH_PERFMON_FIXED_CTR_CTRL if fixed counters are not implemented.
> >>>
> >>> Since AMD CPUs with PerMonV2 do not implement this register, attempts to
> >>> read it generate a #GP. In particular, SysRq-P logs something like this:
> >>>
> >>> [   14.748144] [   T1118] sysrq: Show Regs
> >>> [   14.748896] [   T1118] unchecked MSR access error: RDMSR from 0x38d at rIP: 0xffffffff937154c6 (native_read_msr+0x6/0x40)
> >>> [   14.750878] [   T1118] Call Trace:
> >>> [   14.751505] [   T1118]  <TASK>
> >>> [   14.752057] [   T1118]  paravirt_read_msr+0x7/0x10
> >>> [   14.752940] [   T1118]  perf_event_print_debug+0x135/0x240
> >>> [   14.753931] [   T1118]  __handle_sysrq.cold+0x9b/0xde
> >>> [   14.754855] [   T1118]  write_sysrq_trigger+0x59/0x80
> >>> [   14.755779] [   T1118]  proc_reg_write+0x5a/0xb0
> >>> [   14.756631] [   T1118]  vfs_write+0xce/0x430
> >>> [   14.757406] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.758322] [   T1118]  ? security_file_fcntl+0x5f/0x120
> >>> [   14.759083] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.759754] [   T1118]  ? __x64_sys_fcntl+0x80/0x110
> >>> [   14.760334] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.761005] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.761676] [   T1118]  ? __ct_user_enter+0x27/0xc0
> >>> [   14.762270] [   T1118]  ksys_write+0x6a/0xe0
> >>> [   14.762776] [   T1118]  do_syscall_64+0xe1/0x610
> >>> [   14.763324] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.763995] [   T1118]  ? __ct_user_enter+0x27/0xc0
> >>> [   14.764564] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.765233] [   T1118]  ? do_syscall_64+0x205/0x610
> >>> [   14.765806] [   T1118]  ? __x64_sys_ioctl+0x97/0xe0
> >>> [   14.766375] [   T1118]  ? __pfx_woken_wake_function+0x10/0x10
> >>> [   14.767048] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.767717] [   T1118]  ? get_close_on_exec+0x34/0x40
> >>> [   14.768311] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.768985] [   T1118]  ? do_fcntl+0x6da/0x8e0
> >>> [   14.769502] [   T1118]  ? do_syscall_64+0x205/0x610
> >>> [   14.770083] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.772321] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.773166] [   T1118]  ? tty_read+0x150/0x220
> >>> [   14.773722] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.774423] [   T1118]  ? filp_flush+0x5b/0x80
> >>> [   14.774966] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.775660] [   T1118]  ? filp_close+0x25/0x40
> >>> [   14.776214] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.776936] [   T1118]  ? do_dup2+0xae/0x140
> >>> [   14.777486] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.778309] [   T1118]  ? ksys_dup3+0x67/0xf0
> >>> [   14.778870] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.779600] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.780310] [   T1118]  ? __ct_user_enter+0x27/0xc0
> >>> [   14.780917] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.781613] [   T1118]  ? do_syscall_64+0x205/0x610
> >>> [   14.782215] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.782907] [   T1118]  ? ksys_read+0x6a/0xe0
> >>> [   14.783429] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.784120] [   T1118]  ? __ct_user_enter+0x27/0xc0
> >>> [   14.784741] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.785431] [   T1118]  ? __ct_user_exit+0x15/0xb0
> >>> [   14.786014] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> >>> [   14.786706] [   T1118]  ? do_syscall_64+0x98/0x610
> >>> [   14.787282] [   T1118]  ? exc_page_fault+0x6d/0x180
> >>> [   14.787873] [   T1118]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>> [   14.788612] [   T1118] RIP: 0033:0x7f70d6497e0a
> >>> [   14.789186] [   T1118] Code: 08 03 00 00 59 5e 48 83 f8 fc 75 1e 83 e2 39 83 fa 08 75 16 e8 05 ff ff ff 0f 1f 80 00 00 00 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
> >>> [   14.791587] [   T1118] RSP: 002b:00007ffc36a93580 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> >>> [   14.792617] [   T1118] RAX: ffffffffffffffda RBX: 00007f70d65f6580 RCX: 00007f70d6497e0a
> >>> [   14.793594] [   T1118] RDX: 0000000000000002 RSI: 0000556f34e41c30 RDI: 0000000000000001
> >>> [   14.794574] [   T1118] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> >>> [   14.795563] [   T1118] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> >>> [   14.796537] [   T1118] R13: 0000556f34e41c30 R14: 0000000000000001 R15: 0000000000000000
> >>> [   14.797514] [   T1118]  </TASK>
> >>>
> >>> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> >>> ---
> >>>  arch/x86/events/core.c | 7 +++++--
> >>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> >>> index d1af33d96d0a3..8310bedfc364f 100644
> >>> --- a/arch/x86/events/core.c
> >>> +++ b/arch/x86/events/core.c
> >>> @@ -1581,13 +1581,16 @@ void perf_event_print_debug(void)
> >>>                 rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
> >>>                 rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
> >>>                 rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);  
> >>
> >> GLOBAL_{CTRL,STATUS,OVF_CTRL} functionality is also provided via different MSRs
> >> for AMD PMU version 2 and I assume that reading the ones above will also raise
> >> #GPs. If they don't, the reported values will surely be incorrect.  
> > 
> > They do not raise #GPs on my Ryzen 7 system, but that's about the only
> > system I have tried.  
> 
> Perhaps it is based on Zen 3 or older where x86_pmu.version is set to 0.
> 
> > 
> > Honetly, I was very unsure about the availability of the feauture(s)
> > and what the appropriate checks would be; that was the reason to
> > include you as a recipient. What is the AMD-recommended method to check
> > whether a CPU supports global perf control MSRs? Does x86.pmu_version
> > even work? If yes, should I then simply make the actual MSR numbers
> > conditional on AMD/Intel?
> > 
> > Any guidance welcome.
> >   
> 
> AMD processors with X86_FEATURE_PERFMON_V2 also set x86_pmu.version to 2.
> I think that it is better to move the parts that require the use of
> vendor-specific MSRs to a new callback implemented in
> arch/x86/events/{intel,amd,zhaoxin}/* instead of making additions to
> perf_event_print_debug().
> 
> I'm also not sure why MSR_CORE_PERF_GLOBAL_OVF_CTRL is read here because
> this as well as its AMD counterpart, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
> are both write-only MSRs.
> 
> Mind if I send a cleanup?

I've absolutely no issue with that. Go ahead and send your better
version! The only thing that has annoyed me is the Oops splat every
time I use SysRq+P on my AMD laptop. ;-)

Cheers
Petr T
