Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547793;
	b=mwkrJJyzPBaMZeTNAO+vqsL0M8ORZjLdDioCGVwuvG1MBf2Pr3JgKs0D3RbuMFqtAuQ4
	 SpJWIiTXBZ2u64iVCzUczXQZewx3sKQgygFZZwoiHT1UyVUJhItTNoukGp+DXTIJdvEPP
	 4/czw0WA0MaSnux58MqWeL9FG66KDCQIKRxVyLdgNUqZhbtzNMlq2B9THnXQrI1T5iM8c
	 mmkI1PoiWd89PE5n7KuaxIt930BSH2O+pv4ebSevh84Vl3ZprpENCVqX/jfSNp+mmAeGU
	 Ob55o2k3SzGQv3rOh47jK3HmWPfdk8Nxug4X6rMGTA7uv4KqIu8Xp5N9Yue8SQsh8RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mlE9let+1WH34apTkg1oO0ao602xCJxSBtyBTlH+r18=;
	b=kRBMPW/A32cmUldw2tqzWztaUKVZJx5H5PqkwT0DflYbuGgnXNMo669ElMzWFz6Orf/v
	 kxLEW1PzPYkIjTpPRq2saKDNC/gdXQnzdLCuHrl5PizqaQNa7ERBHx3NwuvFUoG8b6vLu
	 JeSL82GIIr+jTp93ynOZWyP37oDJ5iSx7k1rtl3SVyMW/ZlIt+IpFtSh2EVql/Xei7J0d
	 AaCBhA96E3PZWksir0ZBvl/lcicaAhEKFNwr6505TEAZ1QBCNuFcG24dxCQhbRSXdFtTe
	 JthejBNKLSWjmEf8EqQ+X+Q8+yhkt2UnENAOiJj4sYYkZk8KxD4+hkTIRW79+mOxCHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PTTr5Bwh;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139EC606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 05:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 139EC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PTTr5Bwh
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37198ed3727so1954913eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 21:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794547792; x=1795152592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlE9let+1WH34apTkg1oO0ao602xCJxSBtyBTlH+r18=;
        b=PTTr5BwhmRs2/AFfoHlX1JH2aGlF6UyCg8JCt4429REj5J56HKY0blS17xm0FUl1Fn
         Yjlcc1SkPzH7ARelj2G0DI6MEaQiquUAg476OW579h8IdNP2BHGN8ZpfvUHAavRK6OmE
         nssTGjFiXu+d2qaQVA7sVgnDE0j6AEkl33pUaT9Jy6QnYETF201nnpsOegB26yZXyAQZ
         VAoSGPJdtRPcsBH5VjvpIW8ZKtdNbP4xRtRyukIpadR870cjko8ayzjSZKdU3aLK+Z4g
         3oE5Uxlw5JeDzh7ului9/65e424iwZuQvjFBvJX8hUzROTjucYDhTSHURrOtBUMs2dP1
         eGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547792; x=1795152592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlE9let+1WH34apTkg1oO0ao602xCJxSBtyBTlH+r18=;
        b=AyOB+1WOh1LFH/cRc4lJMYCBwXjNFpMkvmh7EJCkFe+F4YvyK8/9Wj5zvgkB7v2S7j
         FJguK6F1PhPENZQvnC7Spf0EDXChQLIXgIyRJd5JgKuG36JCTj2Nl6egkiAm1CINlSSO
         r+sd2DUec7RgxKKezbO2pWD0e4FAKecsGLNdo893niKdZu6PgdxBgqYSDU1lkPk2qJK2
         nBNitZ+roXhw0wUXGIHUOw8ZpVVrSXKm3R+6jammys3idQR2K8L49xr7aY4dEhcb5CFi
         n9TcoEGm1SmjWx5/8P8Fctd3gBpO2sAFS6KNrJu+C/qYhCRa/PMumSuhtFTcY7lNLKNU
         nABQ==
X-Forwarded-Encrypted: i=1; AL+hErGftGQLO/HhJpqDlgrLlgBcdFm5fV2z9zQMJhw/Wfy/Pm9544haTtIKc50wVpyHHNX4xAqfzy2p+9axFq8gu7yX@vger.kernel.org
X-Gm-Message-State: APuU4Z8+pvn6DNbQMlO8hqtEtYLDZmY/BRvOX41FSDJPh6lc0MMG39ET
	/YAGSnEY9sTfI/jnTZY7GneXkCcsZV5gJEknstRJRlvLuK9r+1AQEA0d
X-Gm-Gg: AYBFou3zFOQ7ejiqx6PsceGMPu5btPVUGus0RD7uASegc5nCQGilV0WZzbEJJW8Rj+a
	8abxU4GND0mhfZtzX7zDZ+p4Jp+XO9ugAeBkaBsaP75OWVD2+dIN7NRq/bi51XIdeIstXQS+1sn
	jbMJKtGVj7cEIYmocpX7+5jFTZl3UEbfU1r674ZaVMHot29XhpWyiuV5jzEwpS/Ia6IzikPlc4M
	EmJfTeeOYWJCzUDjP0SjH8mOwYQguoARVds1kQ1kKfrdJ1RUVvFkc5fFcHvYb1N0KUHexpN6CmE
	8N9qEnf4zmcQ9v36M2o3P6m90zCfjo9lBfQoGc2DWlB8TNbzzQkNinQ0HsE2oWglHTQQIbPqiMp
	Tsi7YbCR1G5dGMGzy/6C7AYbTH863stMO2ug57o4Jaf0fYXdRvXHYrds4PQdFw9Rc6U0vBS48ka
	NrlhWgORODAtyVimyTj0K93PH495YF/IoA3TsI5pi/HzaVd8v32Y2nPzQiIDdEYUIZih6cJSTu2
	JhvSVNOAvWL7viyTERrMr34/R5sMIfXesBQrZPn96wOjcqszbmRsaUiLcMbf7vUTopik9q07CUQ
	Z0+Ko5l5Ecy1aBztAfzsaOJFqcGQG9x7cXZI7XljtAe4x+tfgkTTgAT9jXGvSAeHTWVBC0tZrSz
	c6T9kmfGPp5ia+GYMbNUBaqUn3m86OXdhkqyeaV1NCEjmctuTPtZdpd6swouDR8ctvvZ3mLMSO4
	vISw==
X-Received: by 2002:a05:7301:2783:b0:379:2c7e:7dff with SMTP id 5a478bee46e88-3792c7e7f16mr1623959eec.26.1794547791950;
        Thu, 12 Nov 2026 21:29:51 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378c2fesm3832840eec.1.2026.11.12.21.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:29:50 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3] uprobes: Use flexible array for xol_area bitmap
Date: Thu, 12 Nov 2026 21:29:48 -0800
Message-ID: <20261113052948.2668076-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XOL slot bitmap has the same lifetime as struct xol_area, but it
is currently allocated separately.  That adds another allocation
failure path and a matching cleanup branch without buying any extra
flexibility.

Store the bitmap as a regular array and allocate it together
with the xol_area. The bitmap remains zero-initialized, while the
allocation and error handling become simpler.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 v3: use normal array
 v2: add Acked-by. remove Assisted-by
 kernel/events/uprobes.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..c5c90b53d4cc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -108,7 +108,6 @@ static LIST_HEAD(delayed_uprobe_list);
  */
 struct xol_area {
 	wait_queue_head_t		wq;		/* if all slots are busy */
-	unsigned long			*bitmap;	/* 0 = free slot */
 
 	struct page			*page;
 	/*
@@ -117,6 +116,7 @@ struct xol_area {
 	 * the vma go away, and we must handle that reasonably gracefully.
 	 */
 	unsigned long			vaddr;		/* Page(s) of instruction slots */
+	unsigned long			bitmap[BITS_TO_LONGS(UINSNS_PER_PAGE)];	/* 0 = free slot */
 };
 
 static void uprobe_warn(struct task_struct *t, const char *msg)
@@ -1762,14 +1762,9 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (unlikely(!area))
 		goto out;
 
-	area->bitmap = kcalloc(BITS_TO_LONGS(UINSNS_PER_PAGE), sizeof(long),
-			       GFP_KERNEL);
-	if (!area->bitmap)
-		goto free_area;
-
 	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
 	if (!area->page)
-		goto free_bitmap;
+		goto free_area;
 
 	area->vaddr = vaddr;
 	init_waitqueue_head(&area->wq);
@@ -1782,8 +1777,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		return area;
 
 	__free_page(area->page);
- free_bitmap:
-	kfree(area->bitmap);
  free_area:
 	kfree(area);
  out:
@@ -1824,7 +1817,6 @@ void uprobe_clear_state(struct mm_struct *mm)
 		return;
 
 	put_page(area->page);
-	kfree(area->bitmap);
 	kfree(area);
 }
 
-- 
2.56.1

