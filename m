Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43C2D63E5
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804226; cv=none; b=hV3i+72dKsIIrzaUjz+9KlwlA3iLIOtlTh699jMv7zw2PVYa8eLKM+VDW77pK5lIWFqGEbjNOxJtCQa90gpL8nZPdHA/XiGHM+Vqtm13uxY02TkYkMLzraro5lnsgJxh419INQS1LUQs0o5uY/lXqC2/BvVt/sesRUs03On0vwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804226; c=relaxed/simple;
	bh=BM/PVPr4BUoxQ98yubiOVvCOB+UxL8diHIpcrjRnF1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qp4ywkEN3iWpIP183JS3yn6syl3PwwPFI92j9fOQ4FDGOMRhfViVRtWmU/WABvkJx2ZueDb/bMJXG1/Y5ckeMi6JWhgnEGlaD+6a7QeJDirmw/rY5uGHanIM/cHHrHZ6ixg+08gvCsERoCncmLdcZJqLTqZGJyAWrjFVKYBQvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loCxvn4p; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loCxvn4p"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso5191876b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 05:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765804224; x=1766409024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM/PVPr4BUoxQ98yubiOVvCOB+UxL8diHIpcrjRnF1s=;
        b=loCxvn4pp1giegHZGB8fCdyZonBe6RjK89pU1bnxQ6C2Dg3U2MZ8QEBBuUXr6fuGVP
         O8ysMPDkY6cIgArWwKqjvO8OhyLB+myMY7TaiSSujqdOETR2q02gAxg5AFZOnKQhqPri
         z52wlgpRd74s14zGeJUjFCbgib5kV4bZTlJxawaDmpJiVn0/MWNRAGArN4H/OmYwh2ZD
         TxBVUB4ie643IZnMsU2ypXWuA8+urx3QzgF/Tkq/lAlwojVMImCBu2G4GPfOE/ISY1nz
         q+HoEE8GhzvfSd/rM+42L4Q3QRNexxVo6Q7zNKpG6H0CzCDXqfgqz8ZDsjk8w7rnNoLH
         5vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765804224; x=1766409024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BM/PVPr4BUoxQ98yubiOVvCOB+UxL8diHIpcrjRnF1s=;
        b=NswCicRqajBAZcn/pPfGCJzvEHfOSjWcZLzsVDiAdO7LEpaxT44i7T0VU21/UrOjqu
         +X/4WoREWQMN6jFXpwf9InRsG2BRAQ8I0Xtdm2Yq06AqvDkqBTb0fxe6b5kdGBFHGjM3
         GMEdXlRuFadnGBpHVi1UqunSUU2DfK2ixzF3268hqOPL9Qt/lA3ndsJX5yqZ4zOjJrHb
         QmMuATrYcADj83GTLDjQdpC1pi1eySSEmFyjy5lBcyDokzLDe1l+D0KXLmIG3uC3e9F4
         UYoN04T3moOKREOH+vEGt4ejzaC6+XURYok/SVpx8dmIjxogpACgsfUXeio4KQsc2ed0
         lL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3sbojhvhlvzy+Es3TQT5Bft3/hNRmnBsTmE/CWgF5irjFPNLhAFC0oeiQ9qVVXHWvbAOk4bBlf1lREa+OZQvE@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOkCeVv1iqVMMvThYcRSdEr7eeJpLZ9uyigqwf3FYQeh5REXh
	S3aXGSWhKu/ShNmSTrvwTDv6DfIqtkM56f83nrXgO7DGliP8HfSI4pqy
X-Gm-Gg: AY/fxX4nr8R3LrLV6yHqyQJZGkgypRBhikt59Ftr6dpWyHmDCaWIfmKMKUNINerszZW
	34mC/KcEFO5GoTXvWmDlh0cz7hW3ujtFfwitoQ1SickbuzOjD93gYaBwmuYIHKFETcSQYD6tRJq
	okE5lUbGcuT55+qkF+wxHei9Pm7MgkNi4tNGrMK90gxtlkiazWhm1C/lMTbGAwvbA/uDOp7T/be
	BxMdK7Nl5ZOfHGZ5mPe/PYjRgU8xfN9GmJu+anFVdWU0y47LJwaNmV3vi+foIKIuZjFZ45zC4R3
	t1c+ZM0GHdhIPrABvvT8ERZAxGLPwZE2jX0UbEFAWzWxVUxHoSlGAZC1sJkQjz6mdPxJ9WVeorz
	B4ca+fWZHWMB6nNR8QfoxzxiFJwAi9S2rA7xf/k8IxBuJISkJf98P9FSPkcY+0Nbl/wwndB1HFA
	d0hQDy9bDkxtOIJmG2zxxNRzU57ntviYQ=
X-Google-Smtp-Source: AGHT+IG3VwDpkA1WmQaMbo19+RTJgzIpgUIvYpPpKARDCY4wBFScDx5yKp0n9nH8m2HxqssodBKlAQ==
X-Received: by 2002:a05:6a00:b904:b0:7b9:d7c2:fdf6 with SMTP id d2e1a72fcca58-7f6679326b4mr10674588b3a.24.1765804223544;
        Mon, 15 Dec 2025 05:10:23 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c22848a7sm12761222b3a.3.2025.12.15.05.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 05:10:22 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	peterz@infradead.org,
	riel@surriel.com,
	segher@kernel.crashing.org,
	david@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anshuman.khandual@arm.com,
	aou@eecs.berkeley.edu,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v5 0/3] Optimize code generation during context switching
Date: Mon, 15 Dec 2025 21:10:01 +0800
Message-ID: <20251215131001.1021-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214190907.184793-1-qq570070308@gmail.com>
References: <20251214190907.184793-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is some additional testing information that needs to be
supplemented:
1.
On Mon, 15 Dec 2025 03:09:04 +0800, Xie Yuanbin Wrote:
> 2. Testing config:
> x86-64: `make x86_64_defconfig` first, then menuconfig setting:
> CONFIG_HZ=100
> CONFIG_DEBUG_ENTRY=n
> CONFIG_X86_DEBUG_FPU=n
> CONFIG_EXPERT=y
> CONFIG_MODIFY_LDT_SYSCALL=n
> CONFIG_STACKPROTECTOR=n
> CONFIG_BLK_DEV_NVME=y (just for boot)
>
> arm64: `make defconfig` first, then menuconfig setting:
> CONFIG_KVM=n
> CONFIG_HZ=100
> CONFIG_SHADOW_CALL_STACK=y
>
> arm32: `make multi_v7_defconfig` first, then menuconfig setting:
> CONFIG_ARCH_OMAP2PLUS_TYPICAL=n
> CONFIG_HIGHMEM=n

The above is the config for performance test, when testing for size, the
config is: `make x86_64_defconfig` first, then menuconfig setting:
CONFIG_SCHED_CORE=y
CONFIG_NO_HZ_FULL=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y (optional)

Enable CONFIG_SCHED_CORE and CONFIG_NO_HZ_FULL to test the modified code.

2. When testing with Raspberry Pi 3b, in order to make the test result
stable, the CPU frequency should be fixed. In detail, setting in
config.txt:
```config.txt
arm_boost=0
core_freq_fixed=1
arm_freq=1200
gpu_freq=250
sdram_freq=400
arm_freq_min=1200
gpu_freq_min=250
sdram_freq_min=400
```

Thanks!
