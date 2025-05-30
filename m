Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61322127D
	for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597647; cv=none; b=pZ1SspwonMHuDIjIXYDxkIMsGjQOAjkaj4GCaFrqyWnnmqUbac4CH+QBkthZ0NlY0edelj9dmYHtmEEn3p0wfgjE7ZwoFTP0NIw1uAmWhWaSzHzzNVMFzrXo67ll4R2BxvEVED0iHsxAxvnyFni0Q0vqZx+ffvXplnl5IMdyRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597647; c=relaxed/simple;
	bh=UOL+ld6kJQ8MITB46M/S3E58D1n58tehOr68tDVTVCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7IoJKCC8x27n/0dKFKyJBobTxPrKI9/elM5pVskzIt/9Mzvw8T6sW215gT7YqF0uM5vVs5HUM0m5CV60BlsWaiXFpj4co7dxudYWgoauRN7WwGlrlHDkefKIoAobfWDo0mIdvu2lUElVFXUEbRbVPfne3AMrpiJKm6MHDCyxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Tl4Miuqq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Tl4Miuqq"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so1703358a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597645; x=1749202445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJCF21JaAHh50QQNMzAFoSnSXgccx/2injFNIwjbQFo=;
        b=Tl4MiuqqrXmkBATq/jgK2TPawTNlYG/h9+Mlq3CjwrjDxBrPcQxTtygGQhLnjVkR9o
         FJ5CFUvXkks9Y0N6XRX65o8H2hJj5Lnm9VpK6W3Qs3daNtEEl99YbLh++fGyyNRHfb2r
         FVIhtgvR/hjYrMqYwujJd+Fj/71j7QLBylWBnJcX2AUOGNWNpdoDJiZ4vIjRJTy8VLRg
         VIAa5VVs3rGdL6m8hzuKCzcs7w95d+QUje+kWxGzQ8fFBSLLUF2GCAXmmGngQlP+S2iK
         gbYIKMWKgctZryn5cAeNWLNnx2WfhUDPYT/q0wC4VklpjUb8b0CCV8pmRXUcz7Nnp16O
         C8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597645; x=1749202445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJCF21JaAHh50QQNMzAFoSnSXgccx/2injFNIwjbQFo=;
        b=KxS/+Uvcfdaj9BlnGrtHVBIC931BllSPO9OOLX+jBRl1kNd0Yqzd2vqvRNiKw2YZoH
         ehOfP7QW/f39aWyAnxwcV/AmpvwPgX/SGHDRkKPwTeGBlLQciwIsLvVm7OzfVrTFbqlP
         Mc6CYsiR9QSZw8t8aGP+//rZs2XSDMtA59hv2pijQQKGeMEMAe390nZ5IjSh6zrOEqI0
         maNPZ2hbbVzA8DQBn360/vh/3Mr/1KfcxmjtkFm4bBouIHZoDVCiqSQ4ZqkONBeZHEF9
         X0sO6MquRjxndoeOb174PYVeNPiNc8o/z7o7ZC89Ua5Y2rEsuyynub0xiN6d1vx2cEir
         TMrw==
X-Forwarded-Encrypted: i=1; AJvYcCXsIHfAbhEy3PiFtaA8A+9HqCStINptPR1qtkC5ZKDxwnxzZU+JIPJ7NYMUGoVcJMzZRDJch28GDEkS+E1+LAUT@vger.kernel.org
X-Gm-Message-State: AOJu0YwWrQNpGA0ypzR6icgNKn+bvTm8Xj3NpNFrqSnTsjfziPkSrweE
	hSF4U7PNWSqXv0TkK2IQNbCud8pedPYsEI8eODvg6bRHSPiS1cjvOb8ufrVOmWJ4VBA=
X-Gm-Gg: ASbGncuNHXO6QeZM9PoK9epZMEljDB+J5Bl12FJ+DM60aQLzY+s+daYJj7BK9QzRCug
	nqY2GJytTcjfAnSnUClEwyZF13brPUCWfx5hFMf4PdBSSLrSzfMufoLJ9gtS+2tZ90HC9IevLWb
	umBElNB0LTqjm7WiVHRzkSaCHqQic0jNan1pu+X8UFvT6O+cqjUtUNDmB2SyVfqW3AoofEQkm7t
	pMhwnYJf7ffJXBGQ7Yw+O5RcjKu+1PPRVWQmBem4RER/BmbUSTdKQucpsFHJIoUYGS3/fT1yM8R
	xGQ64OOxepNSmuhLJw8HzEbwnkZ1Wb3ItE+Vv8IGk3Y6YFxolL+VpJkWRt/h6+kC8S++y5IYLw9
	BWQTZuxOs1A==
X-Google-Smtp-Source: AGHT+IHRhTQBcA7s5JBEKqc7+0a9k8cenFZsoQhX8jbpv2vo1Ygv4WOD6zUURQ2dI64sy1qmxMzdzQ==
X-Received: by 2002:a17:90a:e7cb:b0:311:b3e7:fb2c with SMTP id 98e67ed59e1d1-312503643c0mr2125489a91.13.1748597644660;
        Fri, 30 May 2025 02:34:04 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.33.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:34:04 -0700 (PDT)
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
Subject: [RFC v2 22/35] RPAL: rebuild receiver state
Date: Fri, 30 May 2025 17:27:50 +0800
Message-Id: <af2895170223142a8dc824c7096d986da57aeb96.1748594841.git.libo.gcs85@bytedance.com>
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

When an RPAL call occurs, the sender modifies the receiver's state. If the
sender exits abnormally after modifying the state or encounters an
unhandled page fault and returns to a recovery point, the receiver's state
will remain as modified by the sender (e.g., in the CALL state). Since the
sender may have exited, the lazy switch will not occur, leaving the
receiver unrecoverable (unable to be woken up via try_to_wake_up()).
Therefore, the kernel must ensure the receiver's state remains valid in
these cases.

This patch addresses this by rebuild receiver's state during unhandled page
faults or sender exits. The kernel detect the fsbase value recorded by
the sender and use the fsbase value to locate the corresponding receiver.
Then kernel checking if the receiver is in the CALL state set by the
sender (using sender_id and service_id carried in the CALL state). If true,
transitioning the receiver from CALL to WAIT state and notifying the
receiver via sender_state that the RPAL call has completed.

This ensures that even if the sender fails, the receiver can recover and
resume normal operation by resetting its state and avoiding permanent
blocking.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/thread.c | 44 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/rpal/thread.c b/arch/x86/rpal/thread.c
index db3b13ff82be..02c1a9c22dd7 100644
--- a/arch/x86/rpal/thread.c
+++ b/arch/x86/rpal/thread.c
@@ -224,6 +224,45 @@ int rpal_unregister_receiver(void)
 	return ret;
 }
 
+/* sender may corrupt receiver's state if unexpectedly exited, rebuild it */
+static void rpal_rebuild_receiver_context_on_exit(void)
+{
+	struct task_struct *receiver = NULL;
+	struct rpal_sender_data *rsd = current->rpal_sd;
+	struct rpal_sender_call_context *scc = rsd->scc;
+	struct rpal_receiver_data *rrd;
+	struct rpal_receiver_call_context *rcc;
+	unsigned long fsbase;
+	int state = rpal_build_call_state(rsd);
+
+	if (scc->ec.magic != RPAL_ERROR_MAGIC)
+		goto out;
+
+	fsbase = scc->ec.fsbase;
+	if (rpal_is_correct_address(rpal_current_service(), fsbase))
+		goto out;
+
+	receiver = rpal_find_next_task(fsbase);
+	if (!receiver)
+		goto out;
+
+	rrd = receiver->rpal_rd;
+	if (!rrd)
+		goto out;
+
+	rcc = rrd->rcc;
+
+	if (atomic_read(&rcc->receiver_state) == state) {
+		atomic_cmpxchg(&rcc->sender_state, RPAL_SENDER_STATE_CALL,
+			       RPAL_SENDER_STATE_KERNEL_RET);
+		atomic_cmpxchg(&rcc->receiver_state, state,
+			       RPAL_RECEIVER_STATE_WAIT);
+	}
+
+out:
+	return;
+}
+
 int rpal_rebuild_sender_context_on_fault(struct pt_regs *regs,
 					 unsigned long addr, int error_code)
 {
@@ -232,6 +271,7 @@ int rpal_rebuild_sender_context_on_fault(struct pt_regs *regs,
 		unsigned long erip, ersp;
 		int magic;
 
+		rpal_rebuild_receiver_context_on_exit();
 		erip = scc->ec.erip;
 		ersp = scc->ec.ersp;
 		magic = scc->ec.magic;
@@ -249,8 +289,10 @@ int rpal_rebuild_sender_context_on_fault(struct pt_regs *regs,
 
 void exit_rpal_thread(void)
 {
-	if (rpal_test_current_thread_flag(RPAL_SENDER_BIT))
+	if (rpal_test_current_thread_flag(RPAL_SENDER_BIT)) {
+		rpal_rebuild_receiver_context_on_exit();
 		rpal_unregister_sender();
+	}
 
 	if (rpal_test_current_thread_flag(RPAL_RECEIVER_BIT))
 		rpal_unregister_receiver();
-- 
2.20.1

