Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A325CDF1
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763900445; cv=none; b=MbBn3C65bp25vN0/wX5Ec15m2CaJhh/sA6y7LqTtTplDtLnhlF7q1doimkkqJmltpUhoiYZj9ZKdMwdJLOIb0/BCbKkyFB/byFPNCWmSvmAkhdg9G+Y8OCoSa8y8kY8Gj2xR4hYPnOAw5JUaulDeZ+WAl5GVuC6dSLTTzr5mDCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763900445; c=relaxed/simple;
	bh=b4Kl6/Ln3nxjJA5hQViap2LYnXpQaAYZwfl+OVUiJXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROXlMIj7dem7r9OWn1A9cO3z+0cmeNQ3IaG2xCudaBcd48Hz0xwZIx0pKCEDaDl2YgPgFv6FF2f9UGucQ3d4RD0y69Y7NdL3ZMhkBK+kUZ2sqrBNqboV+bvV1B2yY04YTUkigi3pBcOU+idcwfGaQg1z5Mi7vdWU8DUZ25Rau9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzH0OSXG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzH0OSXG"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34361025290so2762691a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763900443; x=1764505243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRiPIYfxAbeDZx56dDO7Yzut633E3UEGddHrba2VO58=;
        b=OzH0OSXGB4ltJkZ5FvPvcSxmkuiB8m6wsfG3Lt9SI8L7jkg5iPNDV161ZWlHsI2SwY
         W67Ec/FxK9w9VavotqjNJasK7XVapr9hcEjww0nFbUiCknCCp+WEyiS9FXcHtha8cY14
         h8S6mTODi6F2RfwyUMbo/vzrC1qUKCpDrcRRfv8r2P88MVpyMmZ+RQ5tGGQigbYuFNPK
         MALsBvZdRdr3QFyCTELOCKXfDwMLmmcPRZQ+Gvz7e1zZi/e1N9LAoxmKPVWv0nE+j8XL
         OgjZtdcvRY5E+XM/RYQHOdlkQ1lqQ0UP16AUG8oLCOnrI55RMK1r/KQAy3rnAvxRio+v
         WYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763900443; x=1764505243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRiPIYfxAbeDZx56dDO7Yzut633E3UEGddHrba2VO58=;
        b=UPBn77y2RUFFNQvnYqSInSSZuIAMfjGvVTMrAiyq5Y4hvP/O+Dw2DxmnQj/Vu7IoCn
         kbJTcQXTDM7n/fnWiSjlFq6X/T++X4n5+El3boa/VzGGxAl+BkID7u46ulvaAGHlzaR6
         6DFpGB0rNY4yAZouI1K/n+FcFGhxB6iYAxV+SO6MtWy+PXGpzsHT8PUfePqyVufOlR2K
         Z3VrLwC3LQVvMh2IDoYrNLRH73JFWqTgM5iJskNZp65sQ470bOHuzLztfl/78o473fTl
         9M/8ktPJDBFo5ycrUh4Ea9smWFKrNyubLRLkmLb2Hrt6Ll0rOsGzhxSb4mJL5fovqAGj
         xmmA==
X-Forwarded-Encrypted: i=1; AJvYcCW+3AqPE0Ag0MDQwXEZNrWOf9RI24rCxv8pRhnpio/EGVI3LA+BQEUegnud6rn2nYCp3lMfVcmx45yT8nVD5SAR@vger.kernel.org
X-Gm-Message-State: AOJu0YwblF7Mn7ZKIp6kTJ9z2pmzhRJcN6Fs4adphWHmN/WPqVBT2H7D
	aocqGic0h6OGq05bGpNgPWhqmwNP62LxHWI0JT4+ZcOxAIyqN/2nGj0O
X-Gm-Gg: ASbGncsGRmKNUDSTxlxWbBphPftPwBZ7whs+F4NpUrx5+OVC9f9ukkmfEGZNXKmSodz
	nVE0HKJUikzi5HJD3LYh0lgfe0gQtU/Jq6BoW5Qs5QLJBrrjpy6dFIAhWUDqCFjcbiX7n7Wl/wK
	cx9y89aMyXXoxoD7VIWwct4yCKOSvdu3qXiG9jXS6Z0bH9NiJdFeOvxubVcgbgAnXt7FIJIH5lL
	ro4RCuV1uD07065L7KkfkPFE4foMO2xE5WiVZj4N2ntWbQqiWIWV6X4w9slo3l31lNVofpEHu7j
	Z8NtJk8GvvY6h5GvExmoJ7qpnv+wwbfQUdi+NajYvh4leMvWxXAJusKGUVJ2UHpQUQelp42P3P8
	sSF3QQEMPPYQIbSjp3JrEzNx1wSvK3Wnru9o88r4rxo71PZFDx18M4YJ7OjhbMSkw1KvyciM7np
	pUx14Lw4+XmyXTzzPPA9ENowxsWsoxQ3x6g/nadQ==
X-Google-Smtp-Source: AGHT+IE2OipiHB3l7nfaaOZz9AJR/rU+rtGLdqGSFKCc9D1xo2iRoaS3rmxvDNPBZM5K4JE+kKoccw==
X-Received: by 2002:a17:90b:50ce:b0:340:ec8f:82d8 with SMTP id 98e67ed59e1d1-34733e6ccdcmr8778976a91.12.1763900443106;
        Sun, 23 Nov 2025 04:20:43 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([45.121.215.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63aefsm11410178b3a.52.2025.11.23.04.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 04:20:42 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	peterz@infradead.org,
	david@kernel.org,
	riel@surriel.com,
	segher@kernel.crashing.org,
	hpa@zytor.com,
	arnd@arndb.de,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	linux@armlinux.org.uk,
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
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	thuth@redhat.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	anshuman.khandual@arm.com,
	nysal@linux.ibm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	Xie Yuanbin <qq570070308@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4 1/3] x86/mm/tlb: Make enter_lazy_tlb() always inline on x86
Date: Sun, 23 Nov 2025 20:18:25 +0800
Message-ID: <20251123121827.1304-2-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123121827.1304-1-qq570070308@gmail.com>
References: <20251123121827.1304-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

enter_lazy_tlb() on x86 is short enough, and is called in context
switching, which is the hot code path.

Make enter_lazy_tlb() always inline on x86 to optimize performance.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511091959.kfmo9kPB-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511092219.73aMMES4-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511100042.ZklpqjOY-lkp@intel.com/
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
V3->V4: https://lore.kernel.org/20251113105227.57650-2-qq570070308@gmail.com
  - Revise commit message: changing inline to always inline
V2->V3: https://lore.kernel.org/20251108172346.263590-2-qq570070308@gmail.com
  - Add `#ifndef MODULE` to fix build errors

 arch/x86/include/asm/mmu_context.h | 23 ++++++++++++++++++++++-
 arch/x86/mm/tlb.c                  | 21 ---------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 73bf3b1b44e8..ecd134dcfb34 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -136,8 +136,29 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 }
 #endif
 
+/*
+ * Please ignore the name of this function.  It should be called
+ * switch_to_kernel_thread().
+ *
+ * enter_lazy_tlb() is a hint from the scheduler that we are entering a
+ * kernel thread or other context without an mm.  Acceptable implementations
+ * include doing nothing whatsoever, switching to init_mm, or various clever
+ * lazy tricks to try to minimize TLB flushes.
+ *
+ * The scheduler reserves the right to call enter_lazy_tlb() several times
+ * in a row.  It will notify us that we're going back to a real mm by
+ * calling switch_mm_irqs_off().
+ */
 #define enter_lazy_tlb enter_lazy_tlb
-extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
+#ifndef MODULE
+static __always_inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
+		return;
+
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
+}
+#endif
 
 #define mm_init_global_asid mm_init_global_asid
 extern void mm_init_global_asid(struct mm_struct *mm);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f5b93e01e347..71abaf0bdb91 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -971,27 +971,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	}
 }
 
-/*
- * Please ignore the name of this function.  It should be called
- * switch_to_kernel_thread().
- *
- * enter_lazy_tlb() is a hint from the scheduler that we are entering a
- * kernel thread or other context without an mm.  Acceptable implementations
- * include doing nothing whatsoever, switching to init_mm, or various clever
- * lazy tricks to try to minimize TLB flushes.
- *
- * The scheduler reserves the right to call enter_lazy_tlb() several times
- * in a row.  It will notify us that we're going back to a real mm by
- * calling switch_mm_irqs_off().
- */
-void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
-		return;
-
-	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
-}
-
 /*
  * Using a temporary mm allows to set temporary mappings that are not accessible
  * by other CPUs. Such mappings are needed to perform sensitive memory writes
-- 
2.51.0

