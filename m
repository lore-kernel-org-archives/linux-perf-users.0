Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E4883F
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788697442; cv=none; b=QYIXV6CqVbnED9HUlJJxFARPJMCyqPS4L7RqJGK9WDsntR66x5+PiYvr7VnNFHyYJdDqZh/S43whhTCYaiBOnDC8Rru17h58k9GW0CqZ7i0AQopkcwEXRaHB47e1BnykaL0fxufL2z6mJZHDwfEm3HpbEwcj/nQuAq/1m4KKHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788697442; c=relaxed/simple;
	bh=i7T5MsATCuxq4jFi1F2opIb+g/TNVwOa5J8EBT+1tg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQY+KRQEMzDnjAraNgMcfDtza2OMLowMeBnRCTPbqXncB7L2TleJvgBNXfsoo1gJXE+lMl9bS23oGiQIEw7WLR/fgJiPL7S9xpNg0UlLhgW31mKGJsaqgwC662Kz/bmBcXcnaNIIeMJehw6hdtsFMDdByBwIiYvvLaY0FZpBCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxlBoVs2; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxlBoVs2"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-396a51b2605so999192a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788697439; x=1789302239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xaszmDPaAaT8VIgwEr8D3B1YhHgs6kESvSxQ+esjaWY=;
        b=IxlBoVs2Kp6Dt4Ma56OwYqWQ24XZ0nH7hrbzoiSZgyMRWdNWrPXd3Yoedt0N/Gr9cZ
         p6OTMS2bMeyM11mH9qtMIaBRGnJIPE5dhYBe0PNJ4gnCVkGyAKxAXXjF6y3Fu5O7aEKm
         ph+fI+VOnzS3igqV7ng3wPUibG6l/6THrgEzKUc6eSRZdN4XeMKZn9ugVlDyDnRqQHq6
         nk9zzG8JZYrWzS+KFeQGdqNpd+mTMiaENhHYzt21z3KHihdk17Yszh6U2ypJZPWPfEaY
         0e4YGh8XzVZ56/M52foFJ/WbRGXvKtnUY07Kje78UTK9zi04Ed9L2OPYm5fajBasUM5i
         6WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788697439; x=1789302239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xaszmDPaAaT8VIgwEr8D3B1YhHgs6kESvSxQ+esjaWY=;
        b=To/83hPONg6rOSREMyiQECJevgF/Em8ALf3sS/zroIYw8pRIFuq7qLRgCMng75SY79
         4vYb8Yc+pWKHf2cLwbwzkOGy4hSJxNTNy1wbrLTCIyePCaayF5i/TtO7g5kxOk9Prb7i
         NXseBC69qlM9z0WvkyOr4nst34Hpg0A/mOtL/VE7BenzkFnNUMaIJ/mRNzkdxvQaPQAx
         3bu5j594UCEkNUF/fW6OVyAVFLuPVpipvGGSIiV4sKSKB+f2SMv5irSCuhwhOG4ey7Vz
         a2xfUAChtXj3QwSiNy7NdXJJHiYJyBMPQA3OxJ0zm8zrU6kMbklUKOfbfAzTFOMmbxv8
         KEWg==
X-Gm-Message-State: AFuF++n07M2Dr1FughK6i/rFJFW71vbSbM5ropq7r1rI+zSe15/P/92z
	e7HvzIDZciiXjjomJPKhiQ5QKr+NFv4XV1N+E53QW7nw7iTryOziWpSJDT/MKQai
X-Gm-Gg: AYBFou0ZyjSUU83AhdW0b86JrhQ9RQZIEUHB1wCdu1vSS5m0DCLVv3Ep9F5BGKg5Rt9
	rTnR5WGzBMc0l0lrgic754M1v/UbHh6bfya0IObSSNJLAM55ECQ0OApJ7thKMe/LgvHELIBr3iJ
	xF/gHAmrNmNgWw6V77t8lvnCBzJaX8MtdKE0H2ULVSzPFjX91OsUbuyB7xvfrBUfJLLev0MqB8Y
	LRcN+guXYbcgdO0SgQTcpCbhZnL04YTy/a4W7Dm+q5Ff3bjzQgz/fLIOKTyFyen+DUqOCalmQAI
	xmgzIhKswGY39j4Yrx+/LlZUxqekaEf3A/F83N1zA5ELy0NT+w5jptGlNaA+3JIzBCOalslRjGG
	9ObYYmODHLGQq5d9BWYpZ4AHJsgztn4ihe6M9vXd/NCFCa333A7wSOz3gzzOWDUcgdAtWKGMBjK
	DPOxUVU7sx29+38BMk7VuPucdKNQfLjU0deL2+KWyIgEk/8kfS8aYsiqmj
X-Received: by 2002:a17:90b:5346:b0:395:f0e8:9e13 with SMTP id 98e67ed59e1d1-39b26190fd9mr27161779a91.7.1788697438844;
        Sun, 06 Sep 2026 05:23:58 -0700 (PDT)
Received: from nixos ([122.231.174.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcd243sm21782207a91.5.2026.09.06.05.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 05:23:58 -0700 (PDT)
From: Thaumy Cheng <thaumy.love@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thaumy Cheng <thaumy.love@gmail.com>
Subject: [PATCH] perf/core: Strengthen userpage update ordering
Date: Sun,  6 Sep 2026 20:23:50 +0800
Message-ID: <20260906122350.24305-1-thaumy.love@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf event mmap userpage uses a sequence counter to let userspace
obtain a consistent snapshot of its data. The existing compiler
barriers reflect the original self-monitoring use case, where the
counter was updated and consumed on the same CPU.

Some consumers also use the userpage only for time conversion and may
read it from a CPU other than the one updating the event. For example,
perf_read_tsc_conversion() reads the time conversion fields
without constraining the caller to the event's CPU.

Make the publication ordering explicit for such readers by replacing the
compiler barriers around the userpage payload update with smp_wmb().
Document that cross-CPU readers of the time conversion fields must use
read memory barriers and reject odd or changed sequence values.

This does not change the UAPI layout or the values exposed to
userspace. It strengthens the ordering guarantee for cross-CPU readers
on weakly ordered architectures.

Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>
---
 include/uapi/linux/perf_event.h       | 6 ++++--
 kernel/events/core.c                  | 6 ++++--
 tools/include/uapi/linux/perf_event.h | 6 ++++--
 tools/perf/design.txt                 | 6 ++++--
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index fd10aa8d697f..a7db00b9b455 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -629,8 +629,10 @@ struct perf_event_mmap_page {
 	 *     barrier();
 	 *   } while (pc->lock != seq);
 	 *
-	 * NOTE: for obvious reason this only works on self-monitoring
-	 *       processes.
+	 * NOTE: Reading the hardware counter as shown above only works for
+	 *       self-monitoring processes. A reader on another CPU may snapshot
+	 *       the time conversion fields, but must use rmb() around the field
+	 *       reads and retry if lock is odd or changes.
 	 */
 	__u32	lock;			/* seqlock for synchronization */
 	__u32	index;			/* hardware event identifier */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 89b40e439717..72605776273f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6852,7 +6852,8 @@ void perf_event_update_userpage(struct perf_event *event)
 	userpg = rb->user_page;
 
 	++userpg->lock;
-	barrier();
+	/* Publish the odd lock value before updating the payload. */
+	smp_wmb();
 	userpg->index = perf_event_index(event);
 	userpg->offset = perf_event_count(event, false);
 	if (userpg->index)
@@ -6866,7 +6867,8 @@ void perf_event_update_userpage(struct perf_event *event)
 
 	arch_perf_update_userpage(event, userpg, now);
 
-	barrier();
+	/* Publish the payload before the final lock update. */
+	smp_wmb();
 	++userpg->lock;
 	preempt_enable();
 unlock:
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index fd10aa8d697f..a7db00b9b455 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -629,8 +629,10 @@ struct perf_event_mmap_page {
 	 *     barrier();
 	 *   } while (pc->lock != seq);
 	 *
-	 * NOTE: for obvious reason this only works on self-monitoring
-	 *       processes.
+	 * NOTE: Reading the hardware counter as shown above only works for
+	 *       self-monitoring processes. A reader on another CPU may snapshot
+	 *       the time conversion fields, but must use rmb() around the field
+	 *       reads and retry if lock is odd or changes.
 	 */
 	__u32	lock;			/* seqlock for synchronization */
 	__u32	index;			/* hardware event identifier */
diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index aa8cfeabb743..111afc90c442 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -316,8 +316,10 @@ struct perf_event_mmap_page {
          *     barrier();
          *   } while (pc->lock != seq);
          *
-         * NOTE: for obvious reason this only works on self-monitoring
-         *       processes.
+         * NOTE: Reading the hardware counter as shown above only works for
+         *       self-monitoring processes. A reader on another CPU may snapshot
+         *       the time conversion fields, but must use rmb() around the field
+         *       reads and retry if lock is odd or changes.
          */
         __u32   lock;                   /* seqlock for synchronization */
         __u32   index;                  /* hardware counter identifier */
-- 
2.55.0

