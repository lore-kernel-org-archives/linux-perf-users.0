Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F00340A63
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Jan 2026 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731752; cv=none; b=Iy1eb0n9CKz2aYCAO0EHPoEesA3HXeeUkXSSxNZkAKC6++gknws61pcubT15F65ZaQXDo2xJGG2k3wud597cE1drrqkE7JFVxjfDqbC9089trVzrg4n0cSjBRlCDaD8gbjU2pfJvChIaWX5lzlf4h6yWh0UUQeRdzixl6uwBw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731752; c=relaxed/simple;
	bh=Sw9ZsVAw2dBIXrT5662jaBGxj31pAS7nwA/5PmMq42M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LlebY/QA5cMOeGVArTzDBX3e6xhIAgridCxVNL17TF8GLOkA94KoLaamZH9cTRJNuVzj2kFNguQqhiP5x0U4Yzqf9EuopdDKQJcf5+AxJ6r5n6OowIAqrvLrdOMh0wjBOS7uOZtu/0KHct2uw+Xq5Lyorsbyxy55tgwu4nErEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Aa5SSJ0O; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Aa5SSJ0O"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso1108199eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jan 2026 12:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1767731750; x=1768336550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HMrXNeVRa4McHU4PJIt7hXSHEgXBBRdiELEZFy8OpA=;
        b=Aa5SSJ0OvqyLo9XVwG6cAjbHwQr0w14YhiweWMyhvMc5EX/ZnwRvLTQgj779HFvZyB
         oLuPcv1n0Eiozqw80Wwf4317fdiWQrBG30iPnlYCS99gL9M/x5NzTkhcBaymTwsISYo6
         7hwu3c4phh8rMZqQBd8trRIAQtNkY7d0CjEQZHfZTJyCwtP0lfvPOoXS9bFgXcZYd9Rr
         AZezeUHoiNRMxCx/YOF57yoV79cFQb+DpIyPrd9wRxowKsY6vfNZnXz7etk4h3IX5Hb/
         esPNfic59CjfE/x8UYE+/CGYKBZGt4KL/f53/CQRj0uROb6rbZZgW1vPu2EQYRWEpzAC
         NBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767731750; x=1768336550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HMrXNeVRa4McHU4PJIt7hXSHEgXBBRdiELEZFy8OpA=;
        b=u6BDmb1rvRFy36I5CEEzkesOUR9mhcy6S09fGiDC1d1ubBZKu7L3FIy8ECx2qvdZqq
         0vq8vtskZm84bELYIps23uDOQG9c7Nxe1dOQP4IqYGddrIBGuHCTHSroqHIXZwpCOqrr
         NVYvglgUZqWuqKMSj4ViZg8Nqv8lsE1ApeC5/hzp+y0UA1kadH6p8iNusbcDigp9zYC9
         G0WhQhVpbYj6nS8HilC6kw+POO+oGqBXI2RrgnU63Wc05f0EHlvAggKNKd5SV2iIUU1V
         bxotTXOKkS7B2TYinVNmaZzkw8uFoFHD4qElAq0KLlkPUypZ6ED56lDiBaymzbB3RXCS
         5sAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU99hXsaLDrmN910E0LlwA3KGE8vkMD3FE9pkmSV+0DywXts5yJRFQPdJcn/coxRhmqAKpC39pp5WLTZvnZ89jD@vger.kernel.org
X-Gm-Message-State: AOJu0YxFoUzL/QpoCEMljeKHTr1YBbo6t2dcW4dgn7ZcG7xySDht0FNS
	WOr/Agrq9Peemb/ltfedF91Il+d6nHsWjaczbQ3GFCTmUNH6AYxFbus7mqS/SPbWKw==
X-Gm-Gg: AY/fxX7fypz5fdqgY+KKMj3vtJFz0+eUYJeFuj/uY8M7bNU92WqoEI3w/5+gk4LwapI
	LUcdbBF9/uDfN1x6Y1kFbd6WjmrYxZQIBj80xLdhSgYUXXED6lq11aP+7fxdiVr8RE6c1FByciY
	vMzknfwb0icPF7giFw3zXOryhiXHOlR6FaEJM3VApwKdDKS65Ght9L7DCr4A6f6A8xHJapF7Kem
	HYr/hgShmLqwdJm25OHwC+dRjKrYJJGbVSm0aKjFU7H2T3wrySS8OWgMP+ULooSkM0ju6+Tj5hr
	Y7F5ggTvAcBFsHI5bQtigHf9OTQDetmV96Ni2X8uCkpT9/osGTI/pSsFyBlvkD7iZgxl5VUG9jm
	CySQ+CRjOTUVeX9Jhi416fpORGE2+/Dav/44M/QiHP3cEQLNtgk+Jp7l4wNtksRsiURtUp1xLsH
	W5go7kVE0UbCcnE7T1S+js4kftl9V7xyc=
X-Google-Smtp-Source: AGHT+IF/kyhC5NGpJANw01FLuXvm3TOrclj3UN/7JZe09J5OirtBHLHRsxGcYY+3HD1Bsh60gv219Q==
X-Received: by 2002:a05:693c:40db:b0:2af:cd0a:ef8c with SMTP id 5a478bee46e88-2b17d2c0ed4mr201763eec.36.1767731750294;
        Tue, 06 Jan 2026 12:35:50 -0800 (PST)
Received: from will-mint.dhcp.asu.edu ([192.145.119.14])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2b170673bc0sm5251698eec.5.2026.01.06.12.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 12:35:49 -0800 (PST)
From: Will Rosenberg <whrosenb@asu.edu>
To: 
Cc: yi1.lai@linux.intel.com,
	Will Rosenberg <whrosenb@asu.edu>,
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
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v3] perf: Fix refcount warning on event->mmap_count increment
Date: Tue,  6 Jan 2026 13:35:46 -0700
Message-Id: <20260106203547.38354-1-whrosenb@asu.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106093431.GA3707837@noisy.programming.kicks-ass.net>
References: <20260106093431.GA3707837@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling refcount_inc(&event->mmap_count) inside perf_mmap_rb(), the
following warning is triggered:

        refcount_t: addition on 0; use-after-free.
        WARNING: lib/refcount.c:25

PoC:

    struct perf_event_attr attr = {0};
    int fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
    mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    int victim = syscall(__NR_perf_event_open, &attr, 0, -1, fd,
                         PERF_FLAG_FD_OUTPUT);
    mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, victim, 0);

This occurs when creating a group member event with the flag
PERF_FLAG_FD_OUTPUT. The group leader should be mmap-ed and then mmap-ing
the event triggers the warning.

Since the event has copied the output_event in perf_event_set_output(),
event->rb is set. As a result, perf_mmap_rb() calls
refcount_inc(&event->mmap_count) when event->mmap_count = 0.

Disallow the case when event->mmap_count = 0. This prevents two
events from updating the same user_page.

Fixes: 448f97fba901 ("perf: Convert mmap() refcounts to refcount_t")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
---

Notes:
    v2 -> v3: Update patch to error out instead of incrementing.
    
    Thank you, this is a much better solution. I was not thinking
    that the mmap itself was unintended.
    
    I believe you are missing a "!" in your patch. After adding
    that, I tested the patch, and it fixed the bug.
    
    Thank you for your help.

 kernel/events/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3c2a491200c6..ac7f12560172 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7273,6 +7273,15 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 		if (data_page_nr(event->rb) != nr_pages)
 			return -EINVAL;
 
+		/*
+		 * If this event doesn't have mmap_count, we're attempting to
+		 * create an alias of another event's mmap(); this would mean
+		 * both events will end up scribbling the same user_page;
+		 * which makes no sense.
+		 */
+		if (!refcount_read(&event->mmap_count))
+			return -EBUSY;
+
 		if (refcount_inc_not_zero(&event->rb->mmap_count)) {
 			/*
 			 * Success -- managed to mmap() the same buffer

base-commit: 5d3b0106245d467fd5ba0bd9a373a13356684f6e
-- 
2.34.1

