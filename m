Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C438334C35
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031229; cv=none; b=SNwF3m0IRqwJyaIXSrD1m4y27Gp4hEqvz3I7uOm4mbbXepqq5Y6ibpJPhoTsIDGxlawx7yxMwAGCQ/kSr6yW7LDhID3safpz/NRUx2ckugzVuvaRl6y9lFD5cXZluzMXEmdCgP+mAC2Mpdy8sGz4ETHE62dcFY5lFDnTXnBhw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031229; c=relaxed/simple;
	bh=we3pQV2EfXmlLrOPSazJFmri5Tg0tS6CcEYQq+waSxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpM8E29qAgPfpP2wtRF0jQcIUGmQ49VbRXU57zmeFWmz9dhRglx8vZu1XP+0Q4oa2QnLOqoIG5olbGz/bJm//BUDDWecjPSzPlzDm1iBqInv0GEVBE+A4M5nRVDdN3zdZ6xcfW+cuqywcxF8MvVeHxVaGibAYyXmqya8hGXbL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMidyy6i; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMidyy6i"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3437ea05540so668291a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 02:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031227; x=1763636027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79H4PCNvjunVFwIbn/0+pzKB83dy0Gioq68+Eu7c2ig=;
        b=KMidyy6i8EOLhJG9h0tKPj1DJDlo1ljr4sYazLkB0ModyJVxodbC/L9ZMBLyctkKEx
         oPlJhmzAYoFbB85vTHcBkC5JOdXIFslkWxLBtG1N0/oUqktbRhc1Pzl8zzuKxSWKwVoR
         IrqKF5bsE1SH11ZOYZDlXt9kapzxlAmxKKlA7WlrcRl8l5QVua1x7PLHAfflSFcqkomc
         TPXKvSH0BEQYZobwVvXvVPb55s+Xlu0+Z5q2V0+yTuNrWo2W6y4dEjtFaJeh1PMzOCVH
         Oq8dv6mjgTxC5jXfO2VRd/MX7BZdrAeXBe6vcjziDOwBFBb3jQddFsPjxQTZpqNyNCmH
         wrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031227; x=1763636027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=79H4PCNvjunVFwIbn/0+pzKB83dy0Gioq68+Eu7c2ig=;
        b=uL0gzETLOpNSjgBVVfv+zhHZMNQVH0IL0iIUlbrtBVaZqFN0KgvQQsg3XrIEc4tFq4
         gUcUZXuJNG6U43zqB1KtW6ccpDwJL+YbVUQwD0wSXyHYo/0qlUS+6R7o7YzPtd5O6xPA
         gc18h7I7wXyOaMn937Yo9qam8rhy22Ol0yDxG1MONofsRW9Av+Iuj4pxp8GMSbBYnkqO
         MCujaGf31RDkNpKI/Tn+CRWiC3Gtgoqr8RQI9TR2xR0datO0ON4aSXWuiNJQDm/bCwY6
         +b9NZg5lqCnVE/j2fA1LN7bHwLwaIFDsqp/EjxoIEtijgkVREuitn6xIIyuWMnJvw7D1
         ApRA==
X-Forwarded-Encrypted: i=1; AJvYcCUPan+9P5IKzqBgUvCs2fdVyGUeguF7+s9b+I3UCmnnSJz+7EX/z2t7cjDXbJZUPAc4DqeLMdndsFO2F6IhzWgb@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuPqJ4jmq/UeKsWi+OqI3fAVFgWoAuTd2icuV8iHKiXzEWgFk
	Ewkvx86SRPtApAr8/DlTXn6F+vm/yQPf2iM0QdVU0VsR0HTL178uCcSR
X-Gm-Gg: ASbGnct8Eeinp7H8ejIOCE9NjzczMKUkGdfO8wM1QLk/ieUjd8uDjmDmuo6Ew9+/+Uy
	BiyAf/0XPzdZWo6ifMVO/mR7JXZffbxwQKrRMO9USzZp6CxKHKBhL3FWawGG7/oO+aCQN8f92Oz
	7RezqxVKLp84d5FWdUhgnyRu3eX3sSizPOIyVSo+Pj58rljbmmLX4AGKBqYfkhIJTwtWn++DeC4
	Y+69UjKpNuMu8f2xdHgf2p8bc4IYdhkzJ8WhPfGugrwsxJIEXlwG08TcAG5HrJJRDUOWwHEAKnn
	eOEfSAQl85s0qCndZd3pD1jyanNz/E3Ms+ZNq0PrxpMkcnVnYI87nIDFhf2gmFwkiGkn6sof+zs
	3Wht8xQm7fCG4OCyLJZud5fDHAw96Yd8TdPaqCvziaZFCtjItTnNRzdpMT/z5RHogA4+pzmLMQu
	1rkEV7jT7yPB+PitPfKsiocIs4
X-Google-Smtp-Source: AGHT+IG67cbPiY5vzZGzQUE0bLFNEQd0Hs0NoyrOMcnJ2e809/8Qsgd+TCKfqsTG/VC1QF5SpkYEpw==
X-Received: by 2002:a17:90b:51ca:b0:343:653d:31c with SMTP id 98e67ed59e1d1-343dddd4253mr7480650a91.5.1763031227339;
        Thu, 13 Nov 2025 02:53:47 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4c939dsm2139616a91.6.2025.11.13.02.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:53:46 -0800 (PST)
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
	will@kernel.org
Subject: [PATCH v3 2/3] Make raw_spin_rq_unlock inline
Date: Thu, 13 Nov 2025 18:52:26 +0800
Message-ID: <20251113105227.57650-3-qq570070308@gmail.com>
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

This function is short, and is called in some critical hot code paths,
such as finish_lock_switch.

Make it inline to optimize performance.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 kernel/sched/core.c  | 5 -----
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81cf8452449a..0e50ef3d819a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -677,11 +677,6 @@ bool raw_spin_rq_trylock(struct rq *rq)
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
index f702fb452eb6..7d305ec10374 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1541,13 +1541,17 @@ static inline void lockdep_assert_rq_held(struct rq *rq)
 
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

