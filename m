Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649DE17A303
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330429; cv=none; b=E+/zdYhL6JDG06Zo7rka5d50fYPqSM8lYUqD3ppLhjybu4D76x00GYIU8bE1l5k8ZQEAagoXGJLaHoVby0ucR7vWlE+31ZhY4JUKW1nuNRlBy00/DU47vkREPYUlhKiJoeWzcToGaNURjCjtma6lEM+hIpj7Uvt6qouFunX4R+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330429; c=relaxed/simple;
	bh=KnVSWXbsVK4WkrJooQQj95dw6wW7FkwVG7nPPpnSuYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUMNX7ZUm34d+230srkdQ1QNxX9vXs0hAYR7Fy22/uGhvIodI4HnwNHMUZ1ldbEwbbrqkdtVxcRE8rS/GIPfKiP36vO8hZmB4t2+xSD+z3jnucs2j463ERwFu7UdPJ166TPymmxiUvv1IU8ku3UtR9M5IBmsc4auSybdIvcYgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELlbUbtD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELlbUbtD"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a265a02477so1870179b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761330425; x=1761935225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SAS7HLWyE203ant0NTxx4AzsxmUZdwyOFbiZtXWA1Xo=;
        b=ELlbUbtDsipjl7iUVm/p38Tn569Sn7egwg7NwKYe1h6G8VIJrfgKtP6mXDxCNTL7VB
         d/wvRxL5zcZ2pVlJa0qzaTaXiLsaq1QxzyKEoUrGYEW7tqBXxrxUcnKhefsACtzakPft
         6p97SsJ+yxUq3JVYUuf31sigxEVkVtlrOQ/NpO7Yf7DJAMvMBblhQ6/7y8Bn4hLINEE1
         PGBihrgx+JraZJ8rgLm3JRyDLwK6fiS4XYd//0xl8mcijZCDRGuDopqbaG3xe23hzWMx
         c92eaIMi6cW1xBvu4OMKy8xDOiTEL/zdJdSH2oE9yN/y3+9VD2rvPcazxOiitE2fPMuE
         /ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330425; x=1761935225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAS7HLWyE203ant0NTxx4AzsxmUZdwyOFbiZtXWA1Xo=;
        b=wytwBqkmwF0dnvinvZqcFlYN5LUrJoP2IzycoLuKSEoDg+k7AVIclvXCzi7D+wUBqR
         us2cywc8rmGsLZlBYpKhkgCoTt1mGqwG68ch5H9XCAUWdzZ8Y8AIYPQ+49m652cgyrVE
         18JWJtvOD3+I9cdlTsA853yUaLGHZpFnDmUz2Sx9Zab+4JZKs1ApaBmssPa4hARzOmux
         pMbk+2lJDHNy7emyCulTTA24gXSiDtVszC355mlji58ccMpnkL/yVK4KIFOvmjwxfPxF
         veJCO0xXJ1m1txkxNOVzCG2tJpZHVAIyZmAxKmdTeLXZE2zXXhJVVfwZf5Pw7WsGVj4w
         vjrA==
X-Forwarded-Encrypted: i=1; AJvYcCWR6s60H+s7kCmOsUa6nAp/qyrEVt8g2GUEsGrOPsURYagKUQImPCg2urapYiQdpOZwOV9dqBBW3A5WLrRk5lem@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNcRyU66ECDphp9+Dg8JqhChYQwxdJXaAW+HCX3Q5be7In8Ag
	blLELKndo2dtenhKf+os51mBJLr58Hxx/0wwMT0aSMhFRWIjXKWbI9jM
X-Gm-Gg: ASbGncsUeOC2hqIfGR5n9eaWMrZc6VAPmFgL+3oK4lOkPGnjcCqZOD7RuEiEiiothnx
	2ddpOb4bBl9CI2MrpJ/Nn9a9YCyj3iLoMrYvqS3nHJPwxcg83lP5ZjRyrf2NDXcH1lQkREiFBzD
	tjJcauUMMIBPQfLtxhpYJ1W8a3WoZTAGNn/cqlP3tnKbPjfUtc0TFV9EK+NEqfoXhxrw5EOAvut
	Visx4WujsI2/chm6h8gkgyUVSI3i+QqxraJceXPI124CFVs5PSBlQmw2a1M/9olrIw87H/RtDz2
	A09Bg2dzhCkiRPABiT5NvJofhoy5oG/q1kJ/7wLJhygvx14oP2xeBmyU2qeyB7VGcZbko+j1VE9
	QLetIL6Ue37QXg9Z5w96fPPPYXzDyecEuuzjjFolyJ3dgcaV4olrs25lULW/ijrj2LOALC+11g4
	CTsU1KigDNdFZtKsrrXlXG
X-Google-Smtp-Source: AGHT+IFGe6oRjXPNPGl24FfDVvabdUA/zgNZ4jI5ptDLqD482exk92jQbNg3NAgkHLmfva10Udnmhw==
X-Received: by 2002:a05:6a00:2d06:b0:781:2272:b704 with SMTP id d2e1a72fcca58-7a286765aacmr3785072b3a.5.1761330424441;
        Fri, 24 Oct 2025 11:27:04 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274ac3158sm6616572b3a.32.2025.10.24.11.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:27:04 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	riel@surriel.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	segher@kernel.crashing.org,
	ryan.roberts@arm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	nysal@linux.ibm.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 0/3] Optimize code generation during context switching
Date: Sat, 25 Oct 2025 02:26:25 +0800
Message-ID: <20251024182628.68921-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of this series of patches is to optimize the performance of
context switching. It does not change the code logic, but only modifies
the inline attributes of some functions.

The original reason for writing this patch is that, when debugging a
schedule performance problem, I discovered that the finish_task_switch
function was not inlined, even in the O2 level optimization. This may
affect performance for the following reasons:
1. It is in the context switching code, and is called frequently.
2. Because of the modern CPU mitigations for vulnerabilities, inside
switch_mm, the instruction pipeline and cache may be cleared, and the
branch and cache miss may increase. finish_task_switch is right after
that, so this may cause greater performance degradation.
3. The __schedule function has __sched attribute, which makes it be
placed in the ".sched.text" section, while finish_task_switch does not,
which causes their distance to be very far in binary, aggravating the
above performance degradation.

I also noticed that on x86, enter_lazy_tlb func is not inlined. It's very
short, and since the cpu_tlbstate and cpu_tlbstate_shared variables are
global, it can be completely inline. In fact, the implementation of this
function on other architectures is inline.

This series of patches mainly does the following things:
1. Change enter_lazy_tlb to inline on x86.
2. Let the finish_task_switch function be called inline during context
switching.
3. Set the subfunctions called by finish_task_switch to be inline:
When finish_task_switch is changed to an inline func, the number of calls
to the subfunctions(which called by finish_task_switch) in this
translation unit increases due to the inline expansion of the
finish_task_switch function.
For example, the finish_lock_switch function originally had only one
calling point in core.o (in finish_task_switch func), but because the
finish_task_switch was inlined, the calling points become two.
Due to compiler optimization strategies,
these subfunctions may transition from inline functions to non inline
functions, which can actually lead to performance degradation.
So I modify some subfunctions of finish_task_stwitch to be always inline
to prevent degradation.
These functions are either very short or are only called once in the
entire kernel, so they do not have a big impact on the size.

This series of patches does not find any impact on the size of the
bzImage image (using Os to build).

Xie Yuanbin (3):
 arch/arm/include/asm/mmu_context.h      |  6 +++++-
 arch/riscv/include/asm/sync_core.h      |  2 +-
 arch/s390/include/asm/mmu_context.h     |  6 +++++-
 arch/sparc/include/asm/mmu_context_64.h |  6 +++++-
 arch/x86/include/asm/mmu_context.h      | 22 +++++++++++++++++++++-
 arch/x86/include/asm/sync_core.h        |  2 +-
 arch/x86/mm/tlb.c                       | 21 ---------------------
 include/linux/perf_event.h              |  2 +-
 include/linux/sched/mm.h                | 10 +++++-----
 include/linux/tick.h                    |  4 ++--
 include/linux/vtime.h                   |  8 ++++----
 kernel/sched/core.c                     | 20 +++++++++++++-------
 12 files changed, 63 insertions(+), 46 deletions(-)

-- 
2.51.0
