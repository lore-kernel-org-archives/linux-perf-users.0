Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEE4C2B9F7
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 May 2021 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDDF613E5
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 May 2021 16:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhE1QRy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 May 2021 12:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbhE1QRr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 May 2021 12:17:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7813EC06174A
        for <linux-perf-users@vger.kernel.org>; Fri, 28 May 2021 09:16:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g18so3609060pfr.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 May 2021 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/uR6UFjy823T9h1mlTve3racnPLNFNFuE+dPsqOMg0=;
        b=rLZdoGDa22YFMNbVWyy1ldrXjbW2JYyYk4cZBwQOu1kGE/UxQM1uuewC52PpIaskGh
         XH+ueTHtVwVHg53MLkzr6N1ekbvnDY3cgGIN/xQrdHepkPF1L444UxwHfhjjtBnWHG2C
         S7ItZCkTTAopN1RCOTMAqroGu8bghVgOy9XZOhfyQZvAb5303lv3j+T5xyrN2MqMQwWP
         g4h6tadBZBpYfohNEwqrzENLTnZ8++xfmQqpx3sk1mtgA4zZWALsjlsp4K+JMZO8c/TP
         pDU/FMbfoxp1FWCS/Xp90rjkQkeF9yXEQYzE8PFBEMz0ZFcSEiOTZd76U28fZl1JJsdE
         t5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/uR6UFjy823T9h1mlTve3racnPLNFNFuE+dPsqOMg0=;
        b=oCwSg67u7Mh+3yACs15vDd66VmNfb0+hE7uZr+SljbeOuRssTGm0jxOdZ02M+LGUep
         OrpH5xYi30WrlPYZo0J5efZCvrxoLVLIU9hMlSvTaUKW2JU161VbwiMEzj+tWli8Uv7g
         xuxJu9VuBzNG1vxgtqYoVGG4KaWsLvlaYPIfu5YFqM0TidfNBW8mSifYx5U9FPVxXXNK
         lL5d8mhRYhmaW7nkuKdsl1NcgetF1G73oNUZKoLXn91cj5EZv/tFIK4+RumA6O2fQpN5
         uPuqiOiQy8qUyq6/aRr4ALnfhTbgrh04PXAsQZGe78xwkn6gGJstzSMqygcdRLPtlgCe
         vbOg==
X-Gm-Message-State: AOAM530wuFUa/B6h/PuoxUeYK7+lgBSYWrUqCSw89XA0zrwb8T7gmk/R
        f+eHYQP633AOJL6Q5is0/rAQyg==
X-Google-Smtp-Source: ABdhPJxBApn4DIy9lwwZWSS4A3P7mLCvPpxj1osq9Z0K0uNkJ0X+DpKM5inRd7ySKCdXdsiCqRVAxQ==
X-Received: by 2002:a63:d213:: with SMTP id a19mr9803271pgg.28.1622218571827;
        Fri, 28 May 2021 09:16:11 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id k20sm4809997pgl.72.2021.05.28.09.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:16:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/3] perf cs-etm: Remove callback cs_etm_find_snapshot()
Date:   Sat, 29 May 2021 00:15:52 +0800
Message-Id: <20210528161552.654907-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528161552.654907-1-leo.yan@linaro.org>
References: <20210528161552.654907-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The callback cs_etm_find_snapshot() is invoked for snapshot mode, its
main purpose is to find the correct AUX trace data and returns "head"
and "old" (we can call "old" as "old head") to the caller, the caller
__auxtrace_mmap__read() uses these two pointers to decide the AUX trace
data size.

cs_etm_find_snapshot() should be removed with below reasons:

- The first thing in cs_etm_find_snapshot() is to check if the head has
  wrapped around, if it is not, directly bails out.  The checking is
  pointless, this is because the "head" and "old" pointers both are
  monotonical increasing so they never wrap around.

- cs_etm_find_snapshot() adjusts the "head" and "old" pointers and
  assumes the AUX ring buffer is fully filled with the hardware trace
  data, so it always calculates the difference "mm->len" between "head"
  and "old".  Let's imagine the snapshot is taken in very short
  interval, the tracers only fill a small chunk of the trace data into
  the AUX ring buffer, in this case, it's wrongly to copy the whole the
  AUX ring buffer to perf file.

- As the "head" and "old" pointers are monotonically increased, the
  function __auxtrace_mmap__read() handles these two pointers properly.
  It calculates the reminders for these two pointers, and the size is
  clamped to be never more than "snapshot_size".  We can simply reply on
  the function __auxtrace_mmap__read() to calculate the correct result
  for data copying, it's not necessary to add Arm CoreSight specific
  callback.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 133 ------------------------------
 1 file changed, 133 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d942f118d32c..85168d87b2d7 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -38,8 +38,6 @@ struct cs_etm_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu		*cs_etm_pmu;
 	struct evlist		*evlist;
-	int			wrapped_cnt;
-	bool			*wrapped;
 	bool			snapshot_mode;
 	size_t			snapshot_size;
 };
@@ -734,135 +732,6 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	return 0;
 }
 
-static int cs_etm_alloc_wrapped_array(struct cs_etm_recording *ptr, int idx)
-{
-	bool *wrapped;
-	int cnt = ptr->wrapped_cnt;
-
-	/* Make @ptr->wrapped as big as @idx */
-	while (cnt <= idx)
-		cnt++;
-
-	/*
-	 * Free'ed in cs_etm_recording_free().  Using realloc() to avoid
-	 * cross compilation problems where the host's system supports
-	 * reallocarray() but not the target.
-	 */
-	wrapped = realloc(ptr->wrapped, cnt * sizeof(bool));
-	if (!wrapped)
-		return -ENOMEM;
-
-	wrapped[cnt - 1] = false;
-	ptr->wrapped_cnt = cnt;
-	ptr->wrapped = wrapped;
-
-	return 0;
-}
-
-static bool cs_etm_buffer_has_wrapped(unsigned char *buffer,
-				      size_t buffer_size, u64 head)
-{
-	u64 i, watermark;
-	u64 *buf = (u64 *)buffer;
-	size_t buf_size = buffer_size;
-
-	/*
-	 * We want to look the very last 512 byte (chosen arbitrarily) in
-	 * the ring buffer.
-	 */
-	watermark = buf_size - 512;
-
-	/*
-	 * @head is continuously increasing - if its value is equal or greater
-	 * than the size of the ring buffer, it has wrapped around.
-	 */
-	if (head >= buffer_size)
-		return true;
-
-	/*
-	 * The value of @head is somewhere within the size of the ring buffer.
-	 * This can be that there hasn't been enough data to fill the ring
-	 * buffer yet or the trace time was so long that @head has numerically
-	 * wrapped around.  To find we need to check if we have data at the very
-	 * end of the ring buffer.  We can reliably do this because mmap'ed
-	 * pages are zeroed out and there is a fresh mapping with every new
-	 * session.
-	 */
-
-	/* @head is less than 512 byte from the end of the ring buffer */
-	if (head > watermark)
-		watermark = head;
-
-	/*
-	 * Speed things up by using 64 bit transactions (see "u64 *buf" above)
-	 */
-	watermark >>= 3;
-	buf_size >>= 3;
-
-	/*
-	 * If we find trace data at the end of the ring buffer, @head has
-	 * been there and has numerically wrapped around at least once.
-	 */
-	for (i = watermark; i < buf_size; i++)
-		if (buf[i])
-			return true;
-
-	return false;
-}
-
-static int cs_etm_find_snapshot(struct auxtrace_record *itr,
-				int idx, struct auxtrace_mmap *mm,
-				unsigned char *data,
-				u64 *head, u64 *old)
-{
-	int err;
-	bool wrapped;
-	struct cs_etm_recording *ptr =
-			container_of(itr, struct cs_etm_recording, itr);
-
-	/*
-	 * Allocate memory to keep track of wrapping if this is the first
-	 * time we deal with this *mm.
-	 */
-	if (idx >= ptr->wrapped_cnt) {
-		err = cs_etm_alloc_wrapped_array(ptr, idx);
-		if (err)
-			return err;
-	}
-
-	/*
-	 * Check to see if *head has wrapped around.  If it hasn't only the
-	 * amount of data between *head and *old is snapshot'ed to avoid
-	 * bloating the perf.data file with zeros.  But as soon as *head has
-	 * wrapped around the entire size of the AUX ring buffer it taken.
-	 */
-	wrapped = ptr->wrapped[idx];
-	if (!wrapped && cs_etm_buffer_has_wrapped(data, mm->len, *head)) {
-		wrapped = true;
-		ptr->wrapped[idx] = true;
-	}
-
-	pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
-		  __func__, idx, (size_t)*old, (size_t)*head, mm->len);
-
-	/* No wrap has occurred, we can just use *head and *old. */
-	if (!wrapped)
-		return 0;
-
-	/*
-	 * *head has wrapped around - adjust *head and *old to pickup the
-	 * entire content of the AUX buffer.
-	 */
-	if (*head >= mm->len) {
-		*old = *head - mm->len;
-	} else {
-		*head += mm->len;
-		*old = *head - mm->len;
-	}
-
-	return 0;
-}
-
 static int cs_etm_snapshot_start(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
@@ -900,7 +769,6 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
 
-	zfree(&ptr->wrapped);
 	free(ptr);
 }
 
@@ -928,7 +796,6 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	ptr->itr.recording_options	= cs_etm_recording_options;
 	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
 	ptr->itr.info_fill		= cs_etm_info_fill;
-	ptr->itr.find_snapshot		= cs_etm_find_snapshot;
 	ptr->itr.snapshot_start		= cs_etm_snapshot_start;
 	ptr->itr.snapshot_finish	= cs_etm_snapshot_finish;
 	ptr->itr.reference		= cs_etm_reference;
-- 
2.25.1

