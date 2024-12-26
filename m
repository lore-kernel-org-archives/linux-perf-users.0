Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB9450F2;
	Thu, 26 Dec 2024 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735203383; cv=none; b=ASKkr9PDISD72+R9dvlK/JcAd4IXhDQFXc/iewIVbsIhMeGw72p4I/sg6awgGjpkaTyOlDyjgBuQAY6RiSXHuxNgtT+QeOqpelF8HZ5pYCIPDfmiFjyYXo6IiSQrunTYnX7TKQhCo8kn+i0qRFk1Cqor03Qa7NPo4z367BEcx+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735203383; c=relaxed/simple;
	bh=Gdzkc8YO+AQMkD9HCVotRR6ywl2H7b0Cj3tewfCIt8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXdZIr+7wLcRcYV2N9zJ/M5ATCAdsKJ7z1lSX6UGzEgM2QEiqkXxxeY9zu5YsQvUtZzPqmIfLn0EEMm04qWh5urweK6qIe485E99yEHGBHtBTm+ro3gKBsKub2+OT2FtR/B1z2GCCbDK43nYPsiUjQdmgpJ90euqYLCoEyyBgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt4W/CYS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt4W/CYS"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21654fdd5daso68651325ad.1;
        Thu, 26 Dec 2024 00:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735203381; x=1735808181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7Wvv7dKnyaUeD8bChj8xncjRrQ43eRpR2zwJY0CY0w=;
        b=Kt4W/CYSe4jV+4eJMCLPIqkLM0amE1FbA0rorGWFJb41P8JEXGWjb9Yz8gjjUa8jFS
         SpmXLFWENsFMwL/LdRex2iYLA0L+xDn1uXqzKMoQURdWvvhh96XSUDPHGPTW4rhXVFNg
         pMVYe+w9GS4IHDsvd8MfcrK5xjOTwVRs9N1/hkaw1HrPIqZMgrWcGRFb0k+BwCwyqoVR
         qg6KGnW50vHzAZe8afBp/DXjfjnSUlXzNMt2O2PEZ/j/8VokdB79wr5euEc5n2Lz+GCC
         7hCAd8R7X8trinv+EAt0JLCHc+nk6HvUp7AcbAOSc/yJ8UXuCPtnfgUX3AiQLdqydAub
         9zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735203381; x=1735808181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7Wvv7dKnyaUeD8bChj8xncjRrQ43eRpR2zwJY0CY0w=;
        b=EYLXJKBBnTyAE5ZbaPp4jj1QVxNbf2vkSXbd5lvqZU9Pnts1DOxVW0hOevt4O1Qyty
         BE9KtHM9lqjRqsaHgX+Ird2ihkgZGWxLe2t1+bHFIqlFoojzHxKM2RB4TKh6ZHspLMuj
         U/P1fGVs8Ppxyy7B2q/zR9iy07/agJkpaItPS1/E66bUsN0/KdsKrKWV0Ms7JEZeuGd9
         qpMQj0dOjmNY9bByy8iKu6UgS6eJghu7T5lm6xrV90h7tiaJUaOa9sW9RuC3YJ6EShTq
         mpQXNtmPLL6JuQoQ/1TTmkap+e+Kd9N7b6Jc23ct+RpR0u9hIKCeQC5NkXnWwlA0f9Q2
         FPQA==
X-Gm-Message-State: AOJu0YzUlVAj1eqyyIZ8X6lalnKC9LrUgnxGCvZeHSe+kmV1/8j9WkLV
	PtK77vv2EAFpeRRfRx4fqruUfcLq++F23jbvAcwMkWry29FayoMi2s2AyEdHFMYSuw==
X-Gm-Gg: ASbGncu/K31O7Aqei73IsiKAqI1GKwA2hvFA1nq2B8FxNeB8AklYJkKkuYf4LZZrcKX
	F6iWlB2xLSKhY4JaZ9D5ogQDRYRV2QdAJbNKpEhty44rmrB8IVgCXNrmU3X8q2mrzYpUed1ipk8
	53G+vmasua6exRBV+NMttWQs44NVnb4CHoTtIQrreYXNM1zPwDKiUV72T5OVfrSqctFDzoprgBT
	1lQUxc6S1ODe8MmlmMNJD4G2q26e0Pb205p37XyKhBh+Z7RZudCiXIL5MZmqJ8qh5Q3uYpMcSjE
	wBPtYa6ksV0nfDCJic7NqRxaBjse2y60
X-Google-Smtp-Source: AGHT+IFgxUUyF7PackzMfPH022L/+ISgHeLSVxmfpgpyZIHG1egKq1NkwMEK1enqHYGt3reY0AEQSA==
X-Received: by 2002:a05:6a00:1909:b0:725:db34:6a7d with SMTP id d2e1a72fcca58-72abdeb4e6emr34692258b3a.23.1735203380848;
        Thu, 26 Dec 2024 00:56:20 -0800 (PST)
Received: from victoryang00-ASUS-Zenbook-S-14-UX5406SA-UX5406SA.. ([101.87.29.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dba78sm12820405b3a.129.2024.12.26.00.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 00:56:20 -0800 (PST)
From: Yiwei Yang <yangyiwei2000@gmail.com>
X-Google-Original-From: Yiwei Yang <victoryang00@ucsc.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	hpa@zytor.com,
	bp@alien8.de,
	tglx@linutronix.de,
	kan.liang@linux.intel.com,
	adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	Yiwei Yang <victoryang00@ucsc.edu>
Subject: [PATCH] Add support for pebs fmt6(Lunar Lake)
Date: Thu, 26 Dec 2024 16:56:05 +0800
Message-ID: <20241226085605.43208-1-victoryang00@ucsc.edu>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Yiwei Yang <victoryang00@ucsc.edu>

Lunar lake's pebs is not kernel ready. in dmesg I found

victoryang00@victoryang00-ASUS-Zenbook-S-14-UX5406SA-UX5406SA:~$ sudo dmesg|grep PMU
[sudo] password for victoryang00: 
[    0.107418] Performance Events: XSAVE Architectural LBR, no PEBS fmt6+,  AnyThread deprecated, Lunarlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.107418] core: cpu_core PMU driver: 
[    0.107418] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.007380] core: cpu_atom PMU driver: 
[    2.802582] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    2.802585] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    2.802586] RAPL PMU: hw unit of domain package 2^-14 Joules
[    2.802587] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    2.802587] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules

But lunar lake has the pebs extension in lscpu

    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m
                          ca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 s
                          s ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc 
                          art arch_perfmon pebs bts rep_good nopl xtopology nons
                          top_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq 
                          dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma c
                          x16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt t
                          sc_deadline_timer aes xsave avx f16c rdrand lahf_lm ab
                          m 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp i
                          brs_enhanced tpr_shadow flexpriority ept vpid ept_ad f
                          sgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rd
                          t_a rdseed adx smap clflushopt clwb intel_pt sha_ni xs
                          aveopt xsavec xgetbv1 xsaves split_lock_detect avx_vnn
                          i lam wbnoinvd dtherm ida arat pln pts hwp hwp_notify 
                          hwp_act_window hwp_epp hwp_pkg_req hfi vnmi umip pku o
                          spke waitpkg gfni vaes vpclmulqdq rdpid bus_lock_detec
                          t movdiri movdir64b fsrm md_clear serialize pconfig ar
                          ch_lbr ibt flush_l1d arch_capabilities


But I found implementation [1] and [2].

The code in the kernel seems not updated [3].

[1] https://github.com/search?q=repo%3Atorvalds%2Flinux%20MSR_IA32_PMC_V6_FX0_CTR&type=code 
[2] https://lwn.net/ml/all/20240625182256.291914-9-kan.liang@linux.intel.com/
[3] https://elixir.bootlin.com/linux/v6.13-rc3/source/arch/x86/events/intel/ds.c#L2480

