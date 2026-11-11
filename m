Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363980;
	b=LR+HMjsp3IyBFZ+37jHO/cPmrzOHI8mJKLzUQIjrYHalO3O8B4wcmdHXrtT/KOa1M/Ki
	 U1F/88pKMl44KMxGfW7Ulp0WPoeqLvbdeqsP0XlpqX7SrvkaKNVgtDk1DMQ/+7W96u0ni
	 /F+7FYXJzaDILFtvba5pH79USxxVDT9WYJZ+Bj1sZqiiDDfIlKwX2mlJneQmjiBfgB/ff
	 fAr2cFWnJevEGqXVvdE5p5HcWSeQkwctPNN08YPjxQUEmzKz5IeAYjVZJVBDejH5MFoZw
	 EA03zN+spkB2GJ4YsJ2DyzXWORhSMxf0ZqSsNDvx/G0/2dIHTRJYUsFGWX9k7rRbXrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IJhsxR/EvrWZJxL/r/ZQEHhwVLOVGsYzQMsdW4G1Luk=;
	b=r7K2YUV+/pRynrSDNQZ0UJKu5wDr8B60HuPsoUQXcJJA4mSDwT9kCS5rg5IGVwnj99b0
	 6Ozd3vx1mDmSk1PtZcNLJZtVf9kgt4xGseMnyJjwUTRmp1FOk889c3V6JNxjvkoNG7f7x
	 p7qAtK5+svUM9pwFpPkDgziqS1t9xesF7g0trJ1BbyX2bhBgNRwFlVaTX+MlDtExF3dSH
	 IIjD1ZCGx0t333MNTeo54JNaNDgPdp/Y0cRawADWxa3SLKZNC4f5XW4godq5aCAbmJBjX
	 vYem8xy9oavz4Fut5XucGeMaH8PcX4iGj4d2bM0IMBuW9jWni8Fcq2a+6Z+hOeU1vUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DU95D8oe;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23416606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23416606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DU95D8oe
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdd9e925075so287185a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 18:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794363979; x=1794968779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IJhsxR/EvrWZJxL/r/ZQEHhwVLOVGsYzQMsdW4G1Luk=;
        b=DU95D8oeVGyJ7lGm1+klKR5Z6Fk/s7oU4yM7eiBkpTWsH1IxOX1GVxxgHbdKZlUrUs
         OK/irF6YkwDerURylq/X5tipLKhdMTKb9A0rfqQYuB1bsJzkYHMczJBFWuXyDwVnrhCr
         ls1QiHmNodL1l0XfMt6oscEkou/Yk+29qGiLsoGzeWdXwfD3lXhOSFm3kENJ1m/7page
         4Qw0dAFY0rAgncIo46JduGecIsZ8HLMxYD2QlFh4fxFQj4upwWUyhMgt0ARkMvyTuBdX
         NIuwub7SbYcZiS6J8r4wb8getSQbSt4yMSPrBC49uqhFe9n1E+en8lyVpcXBOANajF7c
         qRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794363979; x=1794968779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJhsxR/EvrWZJxL/r/ZQEHhwVLOVGsYzQMsdW4G1Luk=;
        b=Lqz1rgsDSkXdr20QkeuHBJTwoY88LZAfIzTzdtkGGXqh/W4HorQ+SHeBb27FT8YO3k
         yIUyssH9XMB7heF9JMd25pV3vYbk0VBd5ny7AhMhQbc2CJ2PkgST3k/3NOW3fibU0bvw
         NB21zOFo286NHwJSuPpDpB61K0j+2JgKk8hi+Moh77OiD/vWXw69kpl9+n8/kizk3DIr
         XmPBlzwzfW2TLuT6bvkjBFeR14Uk2uliovrqPYVYSyhgh8hX39geX1YGaO4U5T96IZPP
         sZV1mlSykjkqMS8JlhgJPKYAcsloy+xO9iIWGWEWpVN467YBk1JeQSRbC0GfpvFVlH0V
         UdOQ==
X-Forwarded-Encrypted: i=1; AL+hErGhOF3jBXADaV4+b3TU/cBs/2H7EZ0va1kDDmiHJI6skOWXJcJj3w89LpYGNHqVTuncbd/WUfCX5hij7bvfrczo@vger.kernel.org
X-Gm-Message-State: APuU4Z8xuaOo0umvJjv7mHzaPeg8pmg9UWVjkMk04uvCTCwH7kO7iLV0
	w2XiKMCsPirdEjY1P/myi3sBHMdiQD9BR7dVBww7qhKoDuZuzfeLqBYR
X-Gm-Gg: AYBFou1ClGLtdUL15k6s7QnBkEjGGhWUs4LL95jiu9SVDlDEx3ebzr6wwNSAllP/pu7
	R4MUttgkbr+WpxzUL62IyXzLpE0/fSSmx5evQGPNeYZEv+QGB9XbjoZR0Gdb/sjMJsFO3KZftJg
	lfFBF8eWXWzghOLqajEjbtBWGZpGT8XplmUvqstf4wh/1cSGee+NZmmRgaz/PNSSV0CynciWVTo
	sRcMnCUDH61F7GLGlumM2WvhsGKBDIlrgT3Vx3zvJsx7XFpsggHTFrm4wIbQ0rxFeKvGlq+GMju
	Z6HA79OACwm1t0n4Qdi6DvYTz4/ACbJieiDdPTinrFwPu6N6+NmYzD6VT9bPADCOjT0Nuo13uq6
	xmOkfaa6ECN7bbIW7+8ddOq/B7TGgE19yf001EaXtW1RkqjR+fClcjMPXY+7+ayLCrQpMXHxKvX
	PRwt1Upre/97sHquIiY0iPbmamEYjRHBXbNlY0fq+oVzNmDbodKBfG7h6ae08nSfTCBz8ZMHLOi
	ZmD6diL7N3D7H5WRmF3nTwVK3ggWTJYUuTbfNjRH9SVQtMd4GSbGTIjYmcSCnAgY3krdSAK4Syb
	lNxAfNj2nEAaRxi0IDuJq6ZEaXRDi33jaqQyDqoGINLcpMZSiQKDDBpKj/PnRmGZfMtGnFaCitf
	cEVUe0UqjBJJcCutd/MEjRxOh02GFrSqvuSi4lRa5kQ+0QSVapr8wVpNkPn1y2wFe6abaAzkKUe
	bUDA==
X-Received: by 2002:a17:90b:35cf:b0:3b0:96ce:104f with SMTP id 98e67ed59e1d1-3b182dea718mr974216a91.5.1794363979444;
        Tue, 10 Nov 2026 18:26:19 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db56c7esm2040066a91.8.2026.11.10.18.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:26:18 -0800 (PST)
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
Subject: [PATCH v2] uprobes: Use flexible array for xol_area bitmap
Date: Tue, 10 Nov 2026 18:26:05 -0800
Message-ID: <20261111022605.66010-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Store the bitmap as a flexible array member and allocate it together
with the xol_area using kzalloc_flex().  The bitmap remains
zero-initialized, while the allocation and error handling become
simpler.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 v2: add Acked-by. remove Assisted-by
 kernel/events/uprobes.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 853fc952331c..876c3cfe8031 100644
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
@@ -1760,18 +1760,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
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
@@ -1784,8 +1779,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		return area;
 
 	__free_page(area->page);
- free_bitmap:
-	kfree(area->bitmap);
  free_area:
 	kfree(area);
  out:
@@ -1826,7 +1819,6 @@ void uprobe_clear_state(struct mm_struct *mm)
 		return;
 
 	put_page(area->page);
-	kfree(area->bitmap);
 	kfree(area);
 }
 
-- 
2.56.0

