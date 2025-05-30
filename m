Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A522D7B0
	for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597678; cv=none; b=Sc9QyTVzQ01p420wt1bVEa+oK56T2zZWK79ddEiq7ti2RbOB+PT0oxthDlaabXuEkGV7DIKSLb5p3+EwVj7XjV4dR+sXAeGk02L3V+28GD+rXCefvYsISa+DjJZDKMaJ1bnEzKRAL+c7lr5HkF/4Hz+z8Dmyri5n7YiliYEbHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597678; c=relaxed/simple;
	bh=AaX4tZdXtUo1twDok859Zwut8WsNeeyIc7hLqSJN5fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9DCZY9384K0Rv4t8xooStYlINT9HyZ49KSS1MHkWinfxpO9OgYnI4SDisowBbZFMhnm0f8UevzCVgIliJVgMUmjgxKEe8hNudPXD2KFA6KCaiYTx9i89s1adn19Sxs4J9clhlW0h4gKsybFudXU9QWOvUIi7Zz1+1xzrdBsSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HZMhmXP+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HZMhmXP+"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b271f3ae786so1307586a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597676; x=1749202476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd4M6twRFQoCr4fYLEaBSZS3XlcwhQLeBelobi/ni6A=;
        b=HZMhmXP+JCNWRJqSd3RPI0w5J/yKoXpICiXXM63dslgXSQCYFZQlNgUy1aj/GGEUZz
         2sJr/bbPYkYApZ2CTjK/3k9WQkwH+Oa9CTbVopfxMhWD0W/NnMWUP3CKq2ges1++vfvB
         bZvHRKYKEp6YotqTTeazXCc1+LrGsG6UpY1theDhxSTnhJCJGiJI93TXuG04TAoJp3Hc
         4dwVBNESqs1+xqcNMoLih6S0pS99gk1XkcFXDniAYBXP4zEcMSFHBlFad/4tI2yEO3QA
         J9cW+JVrLP3HAhCapw1rC/dtLab9bMTkGghearsaGmLnXYtzTxoubOlqkgiSm2OXkZZ2
         +DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597676; x=1749202476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gd4M6twRFQoCr4fYLEaBSZS3XlcwhQLeBelobi/ni6A=;
        b=Qz/FHI92yG5OLMV1Zm24njCKStpnjRy1S/sz8Ivncvd1NFLNqEzTkI7f59/3sBnGGr
         hmBNuUd/+SQVbK7wlmk4Uw0pXQipHDT2o3i1YqcYiHDtdesxiYBKJQYpVMdpBDCMQSDb
         /ng+ouWl/sP6Wu2P1/8EgwUALDywEcO8A1rpueRfLTqz/75nwpw4KThp9jgztC1/hYRc
         yx8wBzKlJnG2ZmiM5SKrAg3s4D175ZVqnqhZSF2O0SrxxXIXWOSobi65WWMm8l3eq5xb
         iLAkjficb1t1SrcOWDTH4kXRgYBgffksQ5i7zRpjkvEfgzNTgzb52RPQ5Y3foDd+VPfV
         +bvA==
X-Forwarded-Encrypted: i=1; AJvYcCWe2QMENPrQ59Wasy0crZzbWmQ4y8x+IcXmcqXr3VGV6fikkLRA/UAAhZIb8VLJ/h+km/8zPVWvogsUa7ZAxf8A@vger.kernel.org
X-Gm-Message-State: AOJu0YxKweVXQIggNyL9YxIDEOmoPC5PID4hmKfc98cXxt2d/No5ekiM
	FEypoZdXeU0ohNo0Saw6ywsrfcG8P6PmWKDWFFjYcOtVHWNgW5Zyv4oVwUX+0faXP6M=
X-Gm-Gg: ASbGnctxlgIh6NZ+FfSqasa8QabFX+WG2MeUuRTluuSyTcd17Lniwmk2Do/rwhhFZbI
	xkYkSXP1AhMRy7lezOQ+avv6bN7bGOzm0d3yE+Fk4L9UUfW17zX5LS45WSKaYSiC+bkffkspI+a
	vOLCR+e7vBue06Rh7679X1I06lbSUatsfnP9WszFlNFXbtOrsOJJh5+dBGqeyZll/vwMmUSVt8d
	PQZ25kyvKjEUfL4h2k0SrzivTVWX00n5OuSYx3nf1UbSXg238AhOAsHcN+aWCUOyWxkITMu+UzI
	hRxIst/pemkS2ymx0Bk2Iakyl09x/7pLxt2CdnLG8YLkzWBF+ahhfzg6K6FoYq5qWYii2BKlkyW
	lWhij+n/AUg==
X-Google-Smtp-Source: AGHT+IFObkOA1vqgzfl2J7tHJ7MiXmVGrPtynvFE/NiK8PUmWtoYGs6g/wJAuSU3bu11FutgVffcuA==
X-Received: by 2002:a17:90a:d2ce:b0:311:b3e7:fb3c with SMTP id 98e67ed59e1d1-31241e97f30mr3743435a91.31.1748597675528;
        Fri, 30 May 2025 02:34:35 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.34.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:34:35 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 24/35] RPAL: critical section optimization
Date: Fri, 30 May 2025 17:27:52 +0800
Message-Id: <47c919a7d65cb5def07c561e29305d39d9df925f.1748594841.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The critical section is defined as the user mode code segment within the
receiver that executes when control returns from the receiver to the
sender. This code segment, located in the receiver, involves operations
such as switching the fsbase register and changing the stack pointer.
Handling the critical section can be categorized into two scenarios:

- First Scenario: If no lazy switch has occurred prior to the return and
  the fsbase switch is incomplete, a lazy switch is triggered to
  transition the kernel context from the sender to the receiver. After
  the fsbase is updated in user mode, another lazy switch occurs to revert
  the kernel context from the receiver back to the sender. This results in
  two unnecessary lazy switches.

- Second Scenario: If a lazy switch has already occurred during execution
  of the critical section, the lazy switch can be preemptively triggered.
  This avoids re-entering the kernel solely to initiate another lazy
  switch.

The implementation of the critical section involves modifying the fsbase
register in kernel mode and setting the sender's user mode context to a
predefined state. These steps minimize redundant user/kernel transitions
and lazy switches.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/core.c    | 88 ++++++++++++++++++++++++++++++++++++++++-
 arch/x86/rpal/service.c | 12 ++++++
 include/linux/rpal.h    |  6 +++
 3 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index c48df1ce4324..406d54788bac 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -219,14 +219,98 @@ static inline struct task_struct *rpal_misidentify(void)
 	return next;
 }
 
+static bool in_ret_section(struct rpal_service *rs, unsigned long ip)
+{
+	return ip >= rs->rsm.rcs.ret_begin && ip < rs->rsm.rcs.ret_end;
+}
+
+/*
+ * rpal_update_fsbase - fastpath when RPAL call returns
+ * @regs: pt_regs saved in kernel entry
+ *
+ * If the user is executing rpal call return code and it does
+ * not update fsbase yet, force fsbase update to perform a
+ * lazy switch immediately.
+ */
+static inline void rpal_update_fsbase(struct pt_regs *regs)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct task_struct *sender = current->rpal_rd->sender;
+
+	if (in_ret_section(cur, regs->ip))
+		wrfsbase(sender->thread.fsbase);
+}
+
+/*
+ * rpal_skip_receiver_code - skip rpal call return code
+ * @next: the next task to be lazy switched to.
+ * @regs: pt_regs saved in kernel entry
+ *
+ * If the user is executing rpal call return code and we are about
+ * to perform a lazy switch, skip the remaining return code to
+ * release receiver's stack. This avoids stack conflict when there
+ * are more than one senders calls the receiver.
+ */
+static inline void rpal_skip_receiver_code(struct task_struct *next,
+					   struct pt_regs *regs)
+{
+	rebuild_sender_stack(next->rpal_sd, regs);
+}
+
+/*
+ * rpal_skip_receiver_code - skip lazy switch when rpal call return
+ * @next: the next task to be lazy switched to.
+ * @regs: pt_regs saved in kernel entry
+ *
+ * If the user is executing rpal call return code and we have not
+ * performed a lazy switch, there is no need to perform lazy switch
+ * now. Update fsbase and other states to avoid lazy switch.
+ */
+static inline struct task_struct *
+rpal_skip_lazy_switch(struct task_struct *next, struct pt_regs *regs)
+{
+	struct rpal_service *tgt;
+
+	tgt = next->rpal_rs;
+	if (in_ret_section(tgt, regs->ip)) {
+		wrfsbase(current->thread.fsbase);
+		rebuild_sender_stack(current->rpal_sd, regs);
+		rpal_clear_task_thread_flag(next, RPAL_LAZY_SWITCHED_BIT);
+		next->rpal_rd->sender = NULL;
+		next = NULL;
+	}
+	return next;
+}
+
+static struct task_struct *rpal_fix_critical_section(struct task_struct *next,
+						     struct pt_regs *regs)
+{
+	struct rpal_service *cur = rpal_current_service();
+
+	/* sender->receiver */
+	if (rpal_test_task_thread_flag(next, RPAL_LAZY_SWITCHED_BIT))
+		next = rpal_skip_lazy_switch(next, regs);
+	/* receiver->sender */
+	else if (rpal_is_correct_address(cur, regs->ip))
+		rpal_skip_receiver_code(next, regs);
+
+	return next;
+}
+
 static inline struct task_struct *
 rpal_kernel_context_switch(struct pt_regs *regs)
 {
 	struct task_struct *next = NULL;
 
+	if (rpal_test_current_thread_flag(RPAL_LAZY_SWITCHED_BIT))
+		rpal_update_fsbase(regs);
+
 	next = rpal_misidentify();
-	if (unlikely(next != NULL))
-		next = rpal_do_kernel_context_switch(next, regs);
+	if (unlikely(next != NULL)) {
+		next = rpal_fix_critical_section(next, regs);
+		if (next)
+			next = rpal_do_kernel_context_switch(next, regs);
+	}
 
 	return next;
 }
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index 49458321e7dc..16e94d710445 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -545,6 +545,13 @@ int rpal_release_service(u64 key)
 	return ret;
 }
 
+static bool rpal_check_critical_section(struct rpal_service *rs,
+			     struct rpal_critical_section *rcs)
+{
+	return rpal_is_correct_address(rs, rcs->ret_begin) &&
+	       rpal_is_correct_address(rs, rcs->ret_end);
+}
+
 int rpal_enable_service(unsigned long arg)
 {
 	struct rpal_service *cur = rpal_current_service();
@@ -562,6 +569,11 @@ int rpal_enable_service(unsigned long arg)
 		goto out;
 	}
 
+	if (!rpal_check_critical_section(cur, &rsm.rcs)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	mutex_lock(&cur->mutex);
 	if (!cur->enabled) {
 		cur->rsm = rsm;
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index b24176f3f245..4f1d92053818 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -122,12 +122,18 @@ enum rpal_sender_state {
 	RPAL_SENDER_STATE_KERNEL_RET,
 };
 
+struct rpal_critical_section {
+	unsigned long ret_begin;
+	unsigned long ret_end;
+};
+
 /*
  * user_meta will be sent to other service when requested.
  */
 struct rpal_service_metadata {
 	unsigned long version;
 	void __user *user_meta;
+	struct rpal_critical_section rcs;
 };
 
 struct rpal_request_arg {
-- 
2.20.1

