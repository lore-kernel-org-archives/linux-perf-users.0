Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ACD33F8AA
	for <linux-perf-users@vger.kernel.org>; Sun, 10 May 2026 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778449298; cv=none; b=QfwWTvLLgawnRmsOywzCNgx5ZpxEC+wR0/mU569XDRIEsDPRJuVUMV/8FEqMO942FN6AHORKNIFOwKjhIP18IAsK99dIK5ZSnZ1tQUGdbpiyVMO0w8QAVJPN0X5l4CXkdaANAg2bvdSfV77MET1GsKJPvnw0iFvYzZ9Jm+Y9uPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778449298; c=relaxed/simple;
	bh=xpy9AyhUst/uLBO9xlxIdK2zcPLCL9yNJiiQAZ3hkrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQr+6rbF3fbqSJ/hYV4jZFN+g9BvcOt3apn0kEuPWjWgKv13Xv/ouWXqp0mt4kg8VNNU2br2K5PG5RWHAAV35EOai8T4eJmc+QjqsvHqDY5J85cKjofNHWYbx1AmT8OJY46ON+9cTjatPY78IPhaiVzgbkBsD+FTn9T+rZBicCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sv0rEXQ9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv0rEXQ9"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367c26471f5so1023194a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 10 May 2026 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778449297; x=1779054097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IqrHxbDBE+DHYuDSqc/T5P005krzaOCUo3AtLPcUMkM=;
        b=sv0rEXQ9choFpQXhHS8jI3nqoEFuH0/EOvseq503RqWbeyTJ5YWAUD6/BwAzLJZwEK
         iBcedQHrqON6AfSxFAFAUdZIwXZr5Zou0hlTfQ/hn0f25I/WGQ9rnAQKbQSMabJifMGT
         HX6XwSQyQi0C8pfk2rMaIQA1QPICpoUCG8uBDuAxN21gzarn5GJItpT0BYgrcNezCKrs
         DvuE9Q5kmXbpDah7Q8PuD/SNUjCxEYk1apv5U11/ylmYrPkbH442LKV0k85awQjxKJBX
         3SiwbTbWtlDmrvlbzdPhBVRM3oIEKbKhPCfFfMWHMT7sBaj/4G/Oi3DGA71OacdQl/rH
         3LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778449297; x=1779054097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqrHxbDBE+DHYuDSqc/T5P005krzaOCUo3AtLPcUMkM=;
        b=jTYCBKjAH2sDwiN5zSmoAKBODQFe49FyJ/wNVd7slEPIPrnY8Hp+2EZhCkEtwiu6yo
         ZzDWOvXiWTBOo+cg0I3v1oSPawgt6a6zatdD1eW3dR+c5WlW2CzKtDO6gWu5m85IL1iu
         LpjKIt7eVGXw+jnCFYSUqkwCK0R2+wrY8/XhnhhHBIgWh4iAh7jANGUefvCZ9XjOmFUg
         qpAeqFAK8XhnZTw9QYd+si/IkMjPESSVP/Zq5jKkHt8mfjodYm+Rhh/g/2H6W2o4SzZa
         UOCWzyfCsyyplI84HrVcYAIPZJypbuRN4t0C47A935uF+CCBZ9pMxSziYP85aetK2KJf
         0GpA==
X-Forwarded-Encrypted: i=1; AFNElJ8Nlh0LcqRrQCUW9y0SHQtPcMhgVer25C2Rq9IoDAsmSvbSTl5gUIz7anhC9gRoaCID5Mgs3Vr5LyH7D+GU1JXU@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPN039oWLHe9bR5xtHSwqcHv4w256WincK6IPKaVQdiR5RcKm
	H8VXrw1XqNGO5UDeOV6DJXGzsG89XKELCVMozNOzFyeKVnwIfIWuckTP
X-Gm-Gg: Acq92OGlhsALxsszlkqAc5P4QxzqN+wHvLsXlZWmk4Yn3EHSOhnqVbSNV1e8JRGdsqs
	DY0m49Y+UuCiHYzHZZWC8YapVjf5RHas9dKJp+39isUt+wG3GRKwY8d+k4EUFMYqrU8q2eoCp0P
	fm21B6FvUZDaDAOvNRb+WT+qrhXieHfDNnBtja1WovO5uk5qTHpUH76ckMEFQ5wC7qeGaG2Jqnk
	kQZn/9q0WfGiqk4ggCwxAPZSV5B+RUhZW7AHEM5K+AXQhCLgP/qg/XpeVfkplnRbTNIckL0casC
	QGuwVCl9V7IJ6/8OEu3xdcdzYdmBit9h/5PJqW3iZD7xcXJUufI9hKxkC+Eu+RvLbZLnuvuIju1
	VJF8sAv9Wea0dn2QaK3BKl+51Q3mEh3ojhZz9ORoHqCIHkb3lHXGf83VNxRzAwUEJ5C0jrko0jO
	4iJI2rVTL0b/avxvGNmWemfrnrlzfzynPyQtjNqG3o8t5s5/uJLmVQdODtXYGs/U34C7xkiSBkN
	QG4muclFpyf7w5TkoesMExdF/iXs1CODVbczGbl63AVMA==
X-Received: by 2002:a17:902:ea0e:b0:2b2:481b:de68 with SMTP id d9443c01a7336-2ba79c14a7cmr248908885ad.35.1778449296667;
        Sun, 10 May 2026 14:41:36 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e99be6sm78597955ad.68.2026.05.10.14.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 14:41:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org (open list:UPROBES),
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] uprobes: Use flexible array for xol_area bitmap
Date: Sun, 10 May 2026 14:41:18 -0700
Message-ID: <20260510214118.41926-1-rosenp@gmail.com>
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
 kernel/events/uprobes.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4084e926e284..9ef74c2ad390 100644
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
-- 
2.54.0

