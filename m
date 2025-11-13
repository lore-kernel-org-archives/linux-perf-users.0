Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0A3376A9
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031206; cv=none; b=dDVGurTDGiJcJIuU747mTkYYs8mmB9MdBRgav8RXvGghKir4X596gIeIdmLTYYRWrw280PfHOGFW766J/kw/is3BpB6YvPDDHDpnn2HQwkpCnMezpQ/zisMVQL2dFiEK3AFhWcjseyCWUF0o0mIYYolJoxOn8KzdFT/CU5mLtrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031206; c=relaxed/simple;
	bh=1E2mId5k7LQtvQtsMUhfWzpkQGYCGnS/GTmR184+ESA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkVYU+BI1yQYC9rAb3nnrUqWnp5POybMjnlfZGrWZoHwj14UJ+bI0bceuUrv0x0SnUXQHncSYtgliamk3rZE7KIwIR5QFyWmGjS/Df4uELXVHB22oACnsiILqiFWTZeHx5krChScWqEI93Q2DjrEI/bFV7MaHpHEP7v9PGlEE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=espvAuQi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="espvAuQi"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3436cbb723fso557782a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031201; x=1763636001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXzDe/lb8LBcXrcioYpdWFUmDINGA7jRuKL/XW2h0KY=;
        b=espvAuQikWN6NSnmwCOum6JjqIfIBu5G9N+yhIlFVJVRUJbJedPBR66aNff5UgCCaM
         D9l/v464MIErTzsjWaPivsY1lLLEew29Tiipuh65h54Ztlz93nLpLmT0lRrQChGj1TTx
         se5ARy7ojP0jc6p8GLMZ+V5G+1xB3xtlS+5wo9K+uc4zhqBRgwcoWzLyL1F/pCVCf7q0
         3yNtFJDGPPqH0HM6bK31553jyf7WNPNBEaT9Xmd8BKywsL8Mx3zcAuLnXmE5eGBibhwU
         QyeKyHG9bvtyVGcha2eCS/ujzXDA0zzL0CrfBwp1qiUHyeF9dK/Nq8VXFQ+Z/8PVhPZN
         sQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031201; x=1763636001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iXzDe/lb8LBcXrcioYpdWFUmDINGA7jRuKL/XW2h0KY=;
        b=u4ypCit+rg8pSdvnSlNl524AqO5LnnYrYJhr+qrPyyqraoXudHOkQvKFeAI1g/3kfa
         l+9ZRMg/ZrY5eHahVWJQJNDjlU4Oh8FZn5nYGfhoqyi+KEwSP2D+PV5oshzhTMGNhNr9
         N+Hwd+3PtqzNC5jxIAnXcgRJgmiwlXmce/AJ/G3qSE0mdswypJwR8fENBGkKk4/5QzRD
         S5KC2tSfJ6H5jJc36uTejaILSUCoRgvmQRwEyckycyPBeSK1sIgmCv8aY688wv3MU/uZ
         CpYs5jb2x417LZ3j8q6crLb3VmBAGxkRAv4exMF9V9IwFsfo7znqMVQV2zIANzUIk0qH
         I6cg==
X-Forwarded-Encrypted: i=1; AJvYcCViLNEvm5IwcvUzEh0lgsSFuNjk5oyW0/1MEjt/IbPl03xT/IJgvDISet906gZ6RpmSTQeWOgoO3mZ7F8T7Gu13@vger.kernel.org
X-Gm-Message-State: AOJu0YxOImEKnaRN9sbUcvNXg8gWR0mDNE5jqUUiEOKIvKpKP5Y2InmK
	rNm3Yw6tuVfYq9325R3HX2fZgBVs2HDZGn5FnaR6osZ1+90CDWrkwpX/
X-Gm-Gg: ASbGncv5KUQ7RJyLPb98ypyJGlptUdYLs0iy47GOR5JXIx64SSEEA4tF36mqRYjL/Jf
	lGymcQaPBNAnE5rEn7X1Ztmz64KIYZAvXsXpDfKAqwQZ5rzWWAu43293X7uySaTLeoEoovbTUw0
	Ixj1lZaVINg82VsbqfwuOJloVvcEjHn3v0LVpgO/6K39T4XVa1GkCfS4NuVGcvosPpA45P7Ocj6
	L+SyKEgJWs9EnfmuDMKJ+AtiIKvD8+yyB4LdCEqEQjRY1fCy5nEsPLsl1F3DYN/tcWml7hPgo3E
	nZDQ2PscGfOnOW15hcNwUectRl38DUYTw8culu9DMBLWvB9nEyYs6bzugerczLz8KA9BIQ5Axcf
	0nYdqcc37srAeFLdLJgkgdnj/R0h9TIWvu8c97oz1i9Rv7ca74j+/3ApL4etr6YdH9CGA6ASwtg
	LD/i5/eHEHcZNy/Ul784q55t0Cu7OZ5Kjo9qw=
X-Google-Smtp-Source: AGHT+IGjc7/BLrmluqoR0wCBX6JW+io2uPlNPbBrwMmM01hCccHJSoZKJTWfi0yRonMDUz3bgaA4Iw==
X-Received: by 2002:a17:90b:4a4d:b0:33e:30e8:81cb with SMTP id 98e67ed59e1d1-343dde14c3bmr7915421a91.13.1763031201314;
        Thu, 13 Nov 2025 02:53:21 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4c939dsm2139616a91.6.2025.11.13.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:53:20 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	riel@surriel.com,
	segher@kernel.crashing.org,
	david@redhat.com,
	peterz@infradead.org,
	hpa@zytor.com,
	osalvador@suse.de,
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
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
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
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	arnd@arndb.de,
	sforshee@kernel.org,
	mhiramat@kernel.org,
	andrii@kernel.org,
	oleg@redhat.com,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/3] Make enter_lazy_tlb inline on x86
Date: Thu, 13 Nov 2025 18:52:25 +0800
Message-ID: <20251113105227.57650-2-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113105227.57650-1-qq570070308@gmail.com>
References: <20251113105227.57650-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is very short, and is called in the context switching,
which is the hot code path.

Change it to inline function on x86 to optimize performance, just like
its code on other architectures.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511091959.kfmo9kPB-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511092219.73aMMES4-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511100042.ZklpqjOY-lkp@intel.com/
---
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
index 5d221709353e..cb715e8e75e4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -970,27 +970,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
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

