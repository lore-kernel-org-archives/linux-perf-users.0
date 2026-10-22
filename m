Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634242;
	b=XnfBtkztnI/uP0GNJRuONafZ8yLyL2k7oGanlSWvS+lZJ4leT742cH2AwfehORn3f7Sp
	 n5nrbw+a9R/zX1UA0IOPN9PdIXGgdFu9tKtZeiwbj7my+p5H7SVba55fB7VLyfVWjDHfY
	 IrmghFYTr040Exo4oTfRqdO3gJVooTapm8OvgK0tewNNpMFjeyGASddHmnw4x1W66sg65
	 Bm2hNCcVibs9XsOCaEl+uw6QPAHDad2nPIiN1CeE09S8Vew/qmfX4POnavBCuXPQqUHS6
	 1k4r6SgP76945yQGGNi9mQUVzttQCTbcObNQF4RHHKE6cJJsBIBkcrQRguKxOfoyvWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Rrt07MWuBvKNxCUpcIHeF6DdyBR4Zz5NXlnZyJVxMUY=;
	b=p9P0JvOarer2tOr8sZa2JisBJNKWDm4Gy24bOxevOES/XtKoVlqVik+vVpTS3EW4IxFC
	 cDRU7Oc9wMJ4O5xFJ/xDEgl1M4v201eCLbiyWGdxS8znsXDgRepgUAsTop3jYK5EzfVMd
	 qew2b7Fk/wjfS6U9vA+EvhT5HU9WbAsMnxoFZrLPdzeuaKz6ZChmWaeasMP+ilmkZFGSV
	 NLCq+8VJZn/O9UV4exFJpkrRd999sQ55Hmdi0RQnP2Fpg13S7TIjyqCReUkA3a+2V2Jqw
	 J9Pf0mAHGHY3ndJJrgFMt1Pi6rVe+3CZQOQ71sw+ak380aGr96nWXIMwXazyUDRgzWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LVXHlWxb;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92E606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 01:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A92E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LVXHlWxb
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so1387862a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 18:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634241; x=1793239041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rrt07MWuBvKNxCUpcIHeF6DdyBR4Zz5NXlnZyJVxMUY=;
        b=LVXHlWxbt7zTnrfwpRAAKArh0anXhoxyz4LkMwz+U6FjFY5B2RWTV8bC+BeBzModcy
         MK+4H4Ae3Ve+k1MNf0Zf014GvM6J9em3f4qVG+we0Q8zEPfVLgdcaB649f2cQS7nA1XH
         vaosoMUbUzorV4pFiZQNrT1hM//xValQyBYVoQU8m1NDBEK6BIFUexceMPryTDME+2OW
         hpW6xARLpcKaJAY00VViOSCIHdKgEO2VvSCBhgLVvBFgbN1zVf+TeOIHJoBJHkkUbMXZ
         vX7h6qcfbyRFwm9W3KL1J3qhzniEtgZJEwAiSK0p0xosjCrYNJJ2ULGUrUSOtulbnxCy
         3N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634241; x=1793239041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rrt07MWuBvKNxCUpcIHeF6DdyBR4Zz5NXlnZyJVxMUY=;
        b=qQ7P3T4zPGferMs8zV9qBdbmK+HUWh6u3sYujQBIbLFryQfFc/hFgikcC+taZ30S+e
         H1A49lVteVU6nw4z3cSqrN0CbhILiin3UcBlRnpLje6k5VdkzyagevKwDgFuNwByM0mp
         zSCzH8HI9edDHqQy0/b0ZcuCGHvXSLRmT/APTA2XBqSbp5eeSvkRxmTXO/aFFCSz+jQ5
         eUqFNxcpu4kYEdIRMMmnA4jyRswdJA7z0IVjHnT9Vk8e2DfiS/43qZQV6mN6E/JNHOWR
         T6E/4RvbfrGNVcJwhX+taXPkHQL72m5JvUG9QvDDD0/G42s72a2VUKyKhFqLj+QbPyqx
         5m0w==
X-Forwarded-Encrypted: i=1; AKwUvBzYcCiD5ni37VTj0np1WGMzk1VasimjyFmg5bYSRf5Z9aU6nAiFmko4zIPOR8dAGW2dwPL7yTg0LBUvxH1XqRuC@vger.kernel.org
X-Gm-Message-State: AFq9FYK7W+EclnagA7yUFxfRH935jYiKeV5XYHyOhy5qkSosGhJoqmDc
	ridJ4XaemNJMZyhwnclXshMaTdeASP4kegxuINOk4FIbzV+OZgx1QMJa
X-Gm-Gg: AYBFou2Dcmt49OV/IFGtnWlbMRDw6pAo39Ct39ExGdBkUKpbsg+qC8HM2TrKMPSqW3t
	ea+XSTBRHWVmF/VGDYzVblfqlL1BoFtGTPA4DKY+9v6FzN4hPmuN3B3gUDIbZ9Tza/RMzTxrxFn
	Xem9OvGl8bxrmKFIJAPkAJO1c+MNJJnH55VnM+/CZDJVtGrtLZ3kXpQcrBTh1iJtB9bdhX1+oLu
	YYlZevPLtlv+Y+OH8dhTQh1zFnjJw4l8Y+bu0bkEVcIc6vJVQcSVDTjJFfD0dHZbaQyKsocavtA
	gXLbt6iQTIfx9toN37YZM4Wde8FdZV9KqaDYq4EmPn2jMY+7tDpSDas/SCQZUDOedP9/O8U6FZj
	oSkng4QUQ2wZVpicExbNUU/+cpqUIjz2lmuimPoiFaqXaESd8Rp0yrwNsKJoo48bVmy+BF94JJd
	bVGh3hzPDWR1TKNzHuCyTAze+xSxw/gG33UCJlxAM3mzcMjfmAHeTNeyw+9/17rscZZ5zUiyONg
	v8lWSOOv1lTWnzO6h+wfOI4qonSqAB8G7KW7PhKp6isz37etrMHASYui1U2sutEg05S8kVIciCO
	4tCmZwd/1Fm7Clz3BjLlYYjxmCIa5ytNqGmOWvcQ5gt8vC5qDUhMRwl+BRH6+k3ow3AW10rtJue
	Qo2oL1JxyAa3Dv2W5OVf1KZUb
X-Received: by 2002:a17:90b:1801:b0:3a4:b74a:795c with SMTP id 98e67ed59e1d1-3ad86c79098mr3189121a91.16.1792634241278;
        Wed, 21 Oct 2026 18:57:21 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48ed70dsm1701803a91.4.2026.10.21.18.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:20 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/9] mm: Bring back mmap_write_trylock()
Date: Thu, 22 Oct 2026 01:57:04 +0000
Message-ID: <20261022015712.1297331-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Commit cf95e337cb63 ("mm: delete mmap_write_trylock() and
vma_try_start_write()") removed it when khugepaged stopped using it.
uprobes and dup_mmap() are going to use it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/mmap_lock.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index b8a13b8d36a4..e5420b0ce61b 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -566,6 +566,18 @@ static inline int __must_check mmap_write_lock_killable(struct mm_struct *mm)
 	return ret;
 }
 
+static inline bool __must_check mmap_write_trylock(struct mm_struct *mm)
+{
+	bool ret;
+
+	__mmap_lock_trace_start_locking(mm, true);
+	ret = down_write_trylock(&mm->mmap_lock) != 0;
+	if (ret)
+		mm_lock_seqcount_begin(mm);
+	__mmap_lock_trace_acquire_returned(mm, true, ret);
+	return ret;
+}
+
 /*
  * Drop all currently-held per-VMA locks.
  * This is called from the mmap_lock implementation directly before releasing
-- 
2.55.0

