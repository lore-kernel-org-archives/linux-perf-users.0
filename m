Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D6322C67
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540226; cv=none; b=A6Ykig4dT1EYFoDRAmF2JNX53QOkm0xM9Ri5NsDgn/F+WOUvu5UceoFjpnCcq+58PGYs4oFgcTuF2E0zSBNtBMWe/7zVn8NJiwD4PANwKZ3rVCfxYD8zpSdatv2nXCZoR64w0qEwplTpgwBzf4RmoPa+HgvmKLyHkLSKWk9dSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540226; c=relaxed/simple;
	bh=s+9oIzVnD/Qb4i+INhtS+QO4GaKbnUimQ56w74A+F4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smsSMr0fsK8RKtYiS6IoYc3Yx6HjCg5c3GqT5YxovxzBgaqmUZUGN3EagifAqa1FmQtBJgDIafNtwfktpxOl1izKG1425XKd9ozyqyTXHCtsvORvx81HjPe3TbdYn2UusQads0oXImFmNFINQyTTYowY/sCJxXVnxm6mzYEqCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F61YNflb; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F61YNflb"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-365eecc5885so4813027a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778540225; x=1779145025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGwkBed7UDDk3zAI8J/n/bBtNTRM3sB7+XcI3xlgnOM=;
        b=F61YNflbll+t1JO8a0H0EbQVDm6gf89AYAIQodErtN7jHwNZFrGfDGDOBV+KtyoTW9
         28FJmE8dy8cGAIH3AMAl2Gh1jaPhkxU/dBDrJRrR+dLvcf4K8hWFpedYc2BuJ4zEpIuh
         X3dQTzvOythIQ3Q6x9y4dZ+x8DO7dxlpyaG1/eZJNNadS+K+hS4vv9WfGc8Z+qbQztQg
         4OmPZ7l0s7P8qdaro3Tw8SYHD1sYB1gEMS4P6Wyfj6wAPVaL3g6MGTCNuJJUQfrxUjZa
         oeOvS9BzLukLinrgq/l4/joF4e2Mg+lcPbhmzmVjbfcyAdAF1Xqr72s3gf2VHed7Xmq0
         2aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778540225; x=1779145025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGwkBed7UDDk3zAI8J/n/bBtNTRM3sB7+XcI3xlgnOM=;
        b=i0QyEL/v2M0gEQnJCmYFrs6viPFiIBYn2LJQIZQ+Csyr6K8mVELE8SQcj/V8Brjq10
         C8LWLc+53MAgWUQLXqA9M1xTsrodd8BKPcLTMg6rerC/ZjPo2bVXs+Z8gUhjWg7eFaS4
         8eicnwt+lNFiAG2uqqXc2LH0anXEqhFRnnQdgoPgejmNQp5tAdrVVuWip1Bsep/3WIRG
         xHProQABfDzYGygrFu13q8PBIhp2f6UUXbtpBixI9whCiEbF7+DS6kskchqZPRaJIqGm
         Tifcn/Guhk4ecoesJavA6GOsnIEqXnMKpIva8bL4MiPjGH73KKhh8if0W6k7tM1Fpwgj
         y7eQ==
X-Forwarded-Encrypted: i=1; AFNElJ9m1XvMf1ERJvteXA1Siqz0Eq7gtsXcViOQFYTqiosAYchbFbYL19elj1KlL941uZIwRF3xByw7IZNNLxp6TUnJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJxpKfKAT8SDbazH3RkNuCKRxIr506NJrexW1TvJGJBeyIlzq
	XFDSbfjAwnXqg9MypmH3MZDRVhrOdO3HM/Y0iqy/wLn+CuQHASFKEjQy
X-Gm-Gg: Acq92OHp5cbF1iL9D70ulNTdzyQwI//rLHjJgZpIQOqpcmhFRnddJPzRvaLhBOOgYEH
	A1SykdzppElIy2IZAbpvPgs//C1tg7jqyWK5BpES6ddk6Ky7Bbi3EMqrg6+UXwmBrPARVofqhm9
	f22puKzZz135HtVeMp//Kw0KjVhIutYw79W/7xld/3FkrukouOJGkiUFSpjglBOuHr9AXTSkUO2
	bNlSZ/4yC0OUqzQqrS+PXQdQ5UI3YWwo7FBykERRoTk5QcjG4+vHMq9NnO5WlFjfeC9ktcIb6m+
	tyNOHnHek0OfFy5VQ6g/Mwul0TwXpI05DkzVYrDHxD2YmJ2YWjI6BVJvtPX0y8gyuHMdXSHiulJ
	3r2UDSjv/zmd2djsXV+OUZLI92d9VwjqCly+tuBg82cdxIyypV1xEkDMv44hXlSnBQbebeMyPFz
	965sFJUoGSCRrOJipdNxzIZRAjnfOJCckFgjk03jb0ADKPyR5Qwh1m9NKjWg/TCun4QDtgUcg/E
	isBa0XBaHzV6RlJITqa7Ok61iSlT4GLVxA=
X-Received: by 2002:a17:90a:d883:b0:359:8de8:1229 with SMTP id 98e67ed59e1d1-367d487d1cbmr13164585a91.21.1778540224836;
        Mon, 11 May 2026 15:57:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d6262349sm8875947a91.6.2026.05.11.15.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:57:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-trace-kernel@vger.kernel.org (open list:UPROBES)
Subject: [PATCHv2] uprobes: Use flexible array for xol_area bitmap
Date: Mon, 11 May 2026 15:56:48 -0700
Message-ID: <20260511225648.27886-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XOL slot bitmap has the same lifetime as struct xol_area, but it
is currently allocated separately.  That adds another allocation
failure path and a matching cleanup branch without buying any extra
flexibility.

Store the bitmap as a flexible array member and allocate it together
with the xol_area using kzalloc_flex().  The bitmap remains
zero-initialized, while the allocation and error handling become
simpler.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add missing kfree
 kernel/events/uprobes.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4084e926e284..eba71700667e 100644
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
+	unsigned long			bitmap[];	/* 0 = free slot */
 };
 
 static void uprobe_warn(struct task_struct *t, const char *msg)
@@ -1755,18 +1755,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	struct xol_area *area;
 	void *insns;
 
-	area = kzalloc_obj(*area);
+	area = kzalloc_flex(*area, bitmap, BITS_TO_LONGS(UINSNS_PER_PAGE));
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
@@ -1779,8 +1774,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		return area;
 
 	__free_page(area->page);
- free_bitmap:
-	kfree(area->bitmap);
  free_area:
 	kfree(area);
  out:
@@ -1831,7 +1824,6 @@ void uprobe_clear_state(struct mm_struct *mm)
 		return;
 
 	put_page(area->page);
-	kfree(area->bitmap);
 	kfree(area);
 }
 
-- 
2.54.0

