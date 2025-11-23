Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4D1C84CB
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763900501; cv=none; b=V7WzPAvPmfHg0xi10+l+NgGvxNXiKFgkBuoR3mVwGCTpMkTZJLOcdvny/5zZ7mmgdnX6ynmPmkNq53gCZ4WKe6vAq7mOefCG12D0vNfrLZaIvbluE+hxrKWy8VG1d4SsiCT7h2AkB04mEtBCrkfJOVnJoIOfxQg5sJbGtBfrfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763900501; c=relaxed/simple;
	bh=qzv7MNEPESHaBf9knR8U9/ufN8T1/b2k/bwA1Kzg0KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+SuRIEqW0mMx9FT0HDALenRbLPSlysPgcx+gPCMJ12v7JUWy0Koxl4Cvx980YbiDULGbDDtoNeYW5GMDepZJI2iW40JkLy8wTVLZX7+CfwGoZf60LzjfBPw2TIl6dMtJorESV6UpL6UaX9HtyDs0noZ8ZoZVzBp/SgfkTsGKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHxokkws; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHxokkws"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso5342580b3a.2
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 04:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763900499; x=1764505299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gehuDY8hCnCk3Q8zSl7CeP6iDX7lw6Gp8zKZT6EL4m4=;
        b=jHxokkwsFQGSUtVuu/buKveGdUmgfzD28bKymcpr3we2C485xgjDM0JIG0v/mJMLON
         UVqwTJ/jK2iWqMJ64HKdhvSvmKz2PSz8yVH1ezzZ4UYVL3ZyQ1BVRCGbOO/dNvrlRNky
         VZDSMr9v8CzDEJ1zFMhTglCQW3Fbpm/ISCJbARxQnEKM38fFqVR/pYuKMByxEt6+LeRQ
         gC2QJ2wVxFSmLZQ4Wm60fwtDTZwYh3bz4tr4JNuN4Xr3ZYK30XOujQZpGzV9GYdiJBOS
         8kkToWrOhR1DLYLIAT+IgRatJS4amnlO25nJZSdxnjeA+FbpdI0sBxPIutSMkDFVGbSm
         aTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763900499; x=1764505299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gehuDY8hCnCk3Q8zSl7CeP6iDX7lw6Gp8zKZT6EL4m4=;
        b=YYmuov3K2LgwA+3AoYsTICdd7h0Uy3veAIapSXcnURxL4sXrj1nhJRYfZHUQuLQIoC
         KTqOTMicEPcAbogfYB9kUu2URi3Rq6+oY9JJr2huY6FaKOGM6PVtWcdKXhQY+STAoYv1
         yJJV+gCovyhNZHz89ep0p1q8P0UJaUpKjsGYlX/zz+FpJT7PR+o1C2cjmrDcABiAlKLO
         out4Fl6cCwqtzkxKwHf7EvUmrhnofFog/VA3bARA2lLM8zwKh9lgdlPXdinJZ8Mwl4zV
         Gqu070mIw/Aax5lXDi7Rw1qHtSXT+cS4F8sgjtu3QqJqApx8rytA4dBT/4XY0wHlxMhs
         RcJA==
X-Forwarded-Encrypted: i=1; AJvYcCUGppn3f2EAqLrapk86dooRvuG1ss0H5vtkx5hK8CcY20PaLm9FiOJkQ3doj5Ga5peHkNPL86QIYVrsd3K0Cq4T@vger.kernel.org
X-Gm-Message-State: AOJu0YxDB+qmMzQyAhIm70EC88DqrAw0cpgPXjtSbxJmHtvY5j6XFA9Y
	hH/J35L/oXKIIY9V69JyNcDWDNXgRFIvSG8CXGEoTli3CB+MvB8St/yo
X-Gm-Gg: ASbGncv//dALf2iMm0ZgYgeAxHrjmXkymhvpc67zwBP4Ce7+30dPVzBJSlPPnGgy/uH
	JPqa6mnHud7ssxXo3sK0YdDk+eK00CAU8othNV/GNclxBqrtkh0NqDyX4IqbVL7Cj3IbegqJEtV
	sdJ/pzdbAsCKp7jcMSSb9JcEXhbbR6zrPrSb3Yl3CUsGN9rs17iz0qvrqGMzpV61SNXiWEZAQ7p
	W000E525BtH35ABAdtKwM4qqTYUJURngW2J50vQjOk4wC9B9mgjKNG2E/3GomVXXvGIpy9VfsvA
	I4W9zm3dmPTHz0IV3pzW4Qg9KcOn8qXBD6Ncmq3WLp1OlGD7mhLyUSkiEowpa08AVrnX7LKn5rc
	YutbKgz037gO06OBXpy9R7w1ZxnNDqBpTg5hjl2vt7SkONDJe0ps4rChApz+LtOv7wdhKukOOnR
	Z9946wdoRjzT8/i5dqhuVYLaO1Ce73NjFQEr6m1A==
X-Google-Smtp-Source: AGHT+IGKqRo5Rqn/7cYYbwvHMYFh4KwgapmQlfr3dLMTE6/Ihy9Y8y5GgtK/UfE6HYkuLUDpc/O0UQ==
X-Received: by 2002:a05:6a00:22cb:b0:7b9:d7c2:fdf6 with SMTP id d2e1a72fcca58-7c58e601920mr9501764b3a.24.1763900499427;
        Sun, 23 Nov 2025 04:21:39 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([45.121.215.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63aefsm11410178b3a.52.2025.11.23.04.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 04:21:39 -0800 (PST)
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
	Xie Yuanbin <qq570070308@gmail.com>
Subject: [PATCH v4 2/3] sched: Make raw_spin_rq_unlock() inline
Date: Sun, 23 Nov 2025 20:18:26 +0800
Message-ID: <20251123121827.1304-3-qq570070308@gmail.com>
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

raw_spin_rq_unlock() is short, and is called in some hot code paths
such as finish_lock_switch.

Make raw_spin_rq_unlock() inline to optimize performance.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: H. Peter Anvin (Intel) <hpa@zytor.com>
---
V3->V4: https://lore.kernel.org/20251113105227.57650-3-qq570070308@gmail.com
  -- Revise commit message

 kernel/sched/core.c  | 5 -----
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2931af76405..0f9e9f54d0a8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -678,11 +678,6 @@ bool raw_spin_rq_trylock(struct rq *rq)
 	}
 }
 
-void raw_spin_rq_unlock(struct rq *rq)
-{
-	raw_spin_unlock(rq_lockp(rq));
-}
-
 /*
  * double_rq_lock - safely lock two runqueues
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bbf513b3e76c..a60b238cb0f5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1551,13 +1551,17 @@ static inline void lockdep_assert_rq_held(struct rq *rq)
 
 extern void raw_spin_rq_lock_nested(struct rq *rq, int subclass);
 extern bool raw_spin_rq_trylock(struct rq *rq);
-extern void raw_spin_rq_unlock(struct rq *rq);
 
 static inline void raw_spin_rq_lock(struct rq *rq)
 {
 	raw_spin_rq_lock_nested(rq, 0);
 }
 
+static inline void raw_spin_rq_unlock(struct rq *rq)
+{
+	raw_spin_unlock(rq_lockp(rq));
+}
+
 static inline void raw_spin_rq_lock_irq(struct rq *rq)
 {
 	local_irq_disable();
-- 
2.51.0

