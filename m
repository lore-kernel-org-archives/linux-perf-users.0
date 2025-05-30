Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3E22068B
	for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597768; cv=none; b=Agx3iTzsmFsCNglqIwZWmLkLOS2Yuy7dvno7Thz1NGxqYXM0XgTY7f/+/4T/tkc8fZlUW1BSdXi2ncQg+APRc4rrskDd/4jUCiMDAqfn5X7pexTeZmj5XegcUGIZWxoi9iIhid6T78GZ+64t/LLdTQhO0bddw+5+3XffKfZXcqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597768; c=relaxed/simple;
	bh=M3ZKzt1i9qkVfxIhwI+P7qiPBgdAVQp1iyJ0A0C1oKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aEfE2jU18D7LTlbzt9A49xBcwfB3N29xVDczvK6c16LHxdogkJBr8/X/SjSPFNbjcE9WUADM6yES1oCUgiPmZ0g1bwCNickbqxl4vPKp1SWQIiFm8/nN4269qVmRfYcb8r8EaftfqhLqRRzIuxSVuQ7ULARHgWh5HRAwTjsdV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=P5v3RIM5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="P5v3RIM5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-312150900afso1782004a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597766; x=1749202566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvVWemooqfdC/iIY99ZRbIRy8Qdtq9pGwXsG45AWib0=;
        b=P5v3RIM52BM+aAtQi9Pl9OO1IkeENABVGz92pzmQn1FFiG8PwrF+QXRI+FsIIMdqjg
         NM4Z4iKAQ/ldpEJyDjLft52PTL2oc7Ulf9GhtnXTqzORYRRPRUM3cH2GqBbaCY4sAsG9
         7Pdz47ziN8ZPYO7H9pbab0qor34/Ezih4X90itfhU5OPGYefwDsAl/Kb6tArsMO8aSee
         aWoHdVuZS7HiYAhPoZ1C/03n4OGIMKLPj/uwG+KQO7WL5CIUl2T+HIclb6/Gv7q8Sdgh
         PD6dN7tLf82F2MEC3RVQeO6sWDT7qK5eokyZ7EQnsPqp2y7WWZDlck/HaerjotN8pXXH
         5E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597766; x=1749202566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvVWemooqfdC/iIY99ZRbIRy8Qdtq9pGwXsG45AWib0=;
        b=MzWh5+MLHroD1GsjAFWm1f13mUq/l2HqHOlL+Ri5ZoBYScTJqFMvTHruksln+8r1xU
         0f/SYIkk8nj9YYEQnQVUEOpUqa2Qq9OFUiv+HO+GxKNbXo6AjY6ADiWvbi9coQ9WKgli
         gDNdPVtu+6GudeQ8OhqEI62pW/oitXk5y8tKhp4/QvEuDtkvJ0CKcwBfbOfyb4r/FWY2
         vFhypc1rD0Py94VkYcrUF0sYGsXaCFcu2XXUntHOn29gfqD3zElH+wVv7UvNk7FvgXBj
         LatI1KuqjStOTJP15g3PqMlk9GmO5fBBZgdaxtzO7DTVaGcWaqcPQakL1Z17BvCTevtQ
         0o/w==
X-Forwarded-Encrypted: i=1; AJvYcCUX3oJRCRkMQf1PvGLay1RcyMFqwpi61jQacDUxT1V9+c57abPw71DJlNQ/nKHIEdVFV/lC9AE07dL+fnuRg3+q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs54AesKkk3VOE9QXXPf8PVs5pNWNdCh4vKScNPUhtIdNncbbw
	H+qGyJzVW2qgT67O5DvxfUUKPMSL6euakplAVifLM2csZNMH8MjCAu+eFNiDA/VPPvU=
X-Gm-Gg: ASbGnctBtg05Zox8J1ldPiTdz15yJfrH6FaT8LalqR+LDys5Ftk/o2SUPh+CjM8sCyV
	panexjUtOtFS3EGZgLAyGWFBxYlHjqEvBFzOXNSRooMIuvaRyN51Chz2DLaG7alzQoBLAM8qb/X
	/EJP0pFg5RJQ8qnnov+PPDOUh/4Yqo1/6FaCWcXvyWLqkFHNs1cblYRBsjDDQ0ok8fDU9fHWpIL
	Bo9Rdghn0q3Lsv75EPhbVA4pkfRQke5Xtz+MWKKyk6CUu9apB0w1xlLWu2phlKGlMGDSteKpqc4
	8JcY7aiRKUIkOEHBWzRNGgWrpDHSANH3xNuohjU6R3ON9vnQWODSX1FSqphbA86pvMKs5CZEgp1
	SDiInAbEeoJtdLEcc52X9
X-Google-Smtp-Source: AGHT+IFWmfD7z+IdT9GMiEVeQTlh62r7ag47hPnuBnpxyTEiSzaUyDKA69VQl5NNKF6zBMdalqyfiA==
X-Received: by 2002:a17:90b:5387:b0:311:e605:f60e with SMTP id 98e67ed59e1d1-31241637ee5mr4240780a91.20.1748597766419;
        Fri, 30 May 2025 02:36:06 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.35.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:36:06 -0700 (PDT)
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
Subject: [RFC v2 30/35] RPAL: fix pkru setup when fork
Date: Fri, 30 May 2025 17:27:58 +0800
Message-Id: <af787730bd27fa506c1e6963bce3da38b23e6358.1748594841.git.libo.gcs85@bytedance.com>
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

When a task performs a fork operation, the PKRU value of the newly forked
task is set to the value read from hardware. At this point, if the service
is executing rpal_pkey_setup(), the newly forked task has not yet been
added to the task list, so PKRU settings cannot be synchronized to the new
task. This results in the new task's PKRU not being set to the correct
value when it is woken up.

This patch addresses this issue by:

- After the newly forked task is added to the task list, further updating
  its PKRU value.
- Acquiring a mutex lock to ensure that the PKRU update occurs either
  before or after the invocation of rpal_pkey_setup(). This avoids race
  conditions with rpal_pkey_setup() and guarantees that the re-updated PKRU
  value is always correct.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 kernel/fork.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 01cd48eadf68..11cba74d07c8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2683,6 +2683,19 @@ __latent_entropy struct task_struct *copy_process(
 	syscall_tracepoint_update(p);
 	write_unlock_irq(&tasklist_lock);
 
+#ifdef CONFIG_RPAL_PKU
+	do {
+		struct rpal_service *cur = rpal_current_service();
+
+		if (cur) {
+			/* ensure we are not in rpal_enable_service() */
+			mutex_lock(&cur->mutex);
+			p->thread.pkru = rdpkru();
+			mutex_unlock(&cur->mutex);
+		}
+	} while (0);
+#endif
+
 	if (pidfile)
 		fd_install(pidfd, pidfile);
 
-- 
2.20.1

