Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC258296BD3
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Nov 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763219401; cv=none; b=Q+nw/uSWJSntNY+WBM/i7LWsIoIBRJhO5zwZNphVxkEdaVPvdmkj30PlZb5gCw3VG+qD8nJVqtxycvrf61bq1JvlZaFFxJHost3KPk+lUOOIRf8/SRKRwrqgdmvH7pkqndPm19ft+6/T3r+dNHa/iN//9UlnbEnrD3C6tvNQchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763219401; c=relaxed/simple;
	bh=9SA9SEdpJyHPt8tsp4kccmbvrFG5gu2WIbEuJq7mvJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YieQqajqyDPs6LrIkVKi+RqxfNfGkhbOcWIhnazd+8xxK4bkdhb1DXTMHWq7HjcSquoOOn6GefLBRcT1gurd20YHMBufZ57Xz/Jo2NtZjYB3tq9H1k6wO+GEkX7IgAt10zRQr7LfgT+dCVyt8Wf10+5oPgkfpcK/b6ySmzFK4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJbErLXt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJbErLXt"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso3740149b3a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Nov 2025 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763219398; x=1763824198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SA9SEdpJyHPt8tsp4kccmbvrFG5gu2WIbEuJq7mvJw=;
        b=FJbErLXtU8bgqxHLdctt8zbwJon845Uu5fz6ysLb2rJa5T7Ab5Vo8beiZkbvJHFqA7
         zpFdgwr82ImS0hvpgydizMysAfTNyP3fFskBZ/qj1o07UwM4TwkqAtI9+bEb69LNM+Rx
         BwPVySwULjjg7bfakaWVU2koQIa4gF4L7AvxAetvPCJKBIvEvyiXRw2ZY+85JU+tBxOc
         G+NwvS293UzoTEUFt8OD1oEjxJ+yqc2PALzTghq/gNUT/Rq+koMEhfo/1rrM5/adsOcF
         LO+zdTe4in6D/AdRRnqCNP4CWk6x/zFjAutbnv/RJqrP8lFmJMoGd0OvrHw/izY27Vm5
         PwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763219398; x=1763824198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9SA9SEdpJyHPt8tsp4kccmbvrFG5gu2WIbEuJq7mvJw=;
        b=ph2WCjmXK3Z8K8kbpL2Zg/4wH9PDnKq7xJo1l2Mb6Xv68NEb7G+bzpl6egGXLZaEjG
         MySoPNZrR3QEd/mxNzFHmRGTvFD3V5uckRTpcB41G0/s4lhYkoJmAgW5VggIzH4IUxdW
         qsi3hq4yhvwrAw+ufyYjdg9TPgb6Vl0IX4b029oyUdtVhEdOEXGmHw6FqO+qZ/3BENRK
         AT2TfxWyXr7jTPy2JLXTMPssAoXRRkEdOADVz6IP5e6Vy8w7/UKQHYbhrxrX3/bdWKu7
         zwkyb1HUWadrJM/1qcEC98oeKU51UO8BKMdwadyULY9JSxWnnaebNaVdxqbLQd2TuKCM
         kQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI2YgHWMdo1/QWo8ToweccFbffWft9dZWxEAuAGK7DEe3vYRLZzL78JDiUQpsb3j6gGSSUTmaqQFcDRLS8VqCT@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZqc8+kuIe5MZITGmLhlVDvAL00pousmYnj/vFzPYykn/ygIR
	w1Og6wM52BIX9UMtevmjuDARmQ60tRLhz87eMg6R4UJD13ZrLzDLAkNW
X-Gm-Gg: ASbGncsSFPMHMYVuru8Q/nZJ7TWDfauJVFKKAs8nPglmZTIt+FFlaQIdHJZ5N1N0p/O
	3dg3J2prdXMyjMV7nEmR8KAIP2URLHFRvPjWoa1TNFYa6j7WqqV5y638YtgRBv6/VhrKtKXMmYP
	ZfGCM0esKxr/gyEcXI2F8j5SlA6Si04AzYNGeoFTCTu/R5jvK5th1+jahXViR+7/meqiP4c6uV2
	qnc4/PJ0AlBuf+oPEFEXIJhjH9KLmrn+4NxFSyGqwnex2qjmN/nT5Y1MJ6KvYyCx15BNVusfU+V
	TxPjUSt6gcuSUpQ6N3crBTipzWganzuLqYm0I1+FTiTY6uv+z7asoG6cKI2lp5H6ifpdwTT3uYS
	IMX3NeAf0z9sOzCTzSaapvzboGSMVjvKT3wLTZ79kysCwg5wzP5l3Kj5V6ZuwyE5JyuCdLDgBy8
	Otu7smyVtWE0Znqd1uiRD/17ObTJIbpUEjZ8A=
X-Google-Smtp-Source: AGHT+IHWcY+GtYxvT2QkvWrdoG6nA29trQIRuLrsD8pNdWPYP/nxv4eW9O/LAvnZtRfQqFwuGVp1RA==
X-Received: by 2002:a05:6a20:a109:b0:34f:c83b:b3f6 with SMTP id adf61e73a8af0-35ba2598aebmr8896833637.43.1763219398046;
        Sat, 15 Nov 2025 07:09:58 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927d1c413sm8266986b3a.69.2025.11.15.07.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 07:09:57 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de
Cc: aalbersh@redhat.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	andrii@kernel.org,
	anna-maria@linutronix.de,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	baolin.wang@linux.alibaba.com,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	brauner@kernel.org,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@kernel.org,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jlayton@kernel.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	llvm@lists.linux.dev,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	oleg@redhat.com,
	osalvador@suse.de,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	qq570070308@gmail.com,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sforshee@kernel.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 3/3] Make finish_task_switch and its subfuncs inline in context switching
Date: Sat, 15 Nov 2025 23:09:28 +0800
Message-ID: <20251115150928.649-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87346gbd04.ffs@tglx>
References: <87346gbd04.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Nov 2025 21:00:43 +0100, Thomas Gleixner wrote:
> What are subfuncs? This is not a SMS service. Use proper words and not
> made up abbreviations.
>
> Again you mark them __always_inline and not inline. Most of them are
> already 'inline'. Can you please precise in your wording?
>
> This really can go into the comment section below the first '---'
> separator. No point in having this in the change log.

Thanks for pointing it out, I will improve it in v4 patch.

>> After `finish_task_switch` is changed to an inline function, the number of
>> calls to the subfunctions (called by `finish_task_switch`) increases in
>> this translation unit due to the inline expansion of `finish_task_switch`.
>> Due to compiler optimization strategies, these functions may transition
>> from inline functions to non inline functions, which can actually lead to
>> performance degradation.
>
> I'm having a hard time to understand this word salad.

I think the description is very important here, because it explains why
it needs to make the subfunctions as __always_inline.
Where is difficult to understand specifically? Please point it out,
and I will improve the description in v4 patch. Thank you very much!

> What means (rdtsc)?

This is a high-precision timestamp acquisition method in x86.
The description here is not sufficient, thanks for pointing it out, I
will improve it in v4 patch.

> So the real benefit is observable when spectre_v2_user mitigations are
> enabled. You completely fail to explain that.

What kind of explanation is needed here?
```txt
When spectre_v2_user mitigation is enabled, kernel is likely to
preform branch prediction hardening inside switch_mm_irq_off, which can
drastically increase the branch prediction misses in subsequently
executed code.

On x86, this mitigation is enabled conditionally by default, but on other
architectures, for example arm32/aarch64, the mitigation may be fully
enabled by default.

`finish_task_switch` is right after `switch_mm_irq_off`, so makeing it
inline can achieve high performance benefits.
```
Is it ok? Thanks very much!

> bzImage size is completely irrelevant. What's interesting is how the
> size of the actual function changes.

I think the bzImage size is meaningful, at least for many embedded
devices. Due to compression algorithms, code size cannot directly reflect
to the compressed size.

Anyway, I will supplement the size of the .text section in the v4 patch.

Thanks very much!

Xie Yuanbin
