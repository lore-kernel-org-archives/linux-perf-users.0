Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879143;
	b=vqG7VluvDV0FdXbEoxpmLhGTolPvejzQLRuxmktvEmFVgdgi4zCN3kEGlttxYlA0vw30
	 FW1rVFTLrdrKN7kf9WIPpcKy7hthHNMLcnxq2qzpJlxBVtgNQPxlD04bDL5WFRZCrogPX
	 S/sVBATscNIRKsmrBM8sSTwHsMyTE5t1J3EbOadsY+o6vrVLQUdgWgRZrjh4xak0L7Ywo
	 bim1Ds01+TYcyWYKPfhhCs+WLs5UbGS68/dMydXESouE91jPTVz80EMU9oa+EHzILL5DN
	 +7zQuoiB1NPptn5MXe3N0zQlV3d7lbPRRlI9jcaojM0SfR6GLY0lTdq6hj7Wjz/Lh3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=6POGoe9GP/LfncNNPmyOb3NHHZhyrYu1RabNz3eag4o=;
	b=d0btcCNQsANuYcr7WliVZqp4XG/iEhdT7XzbHHw98xtppbSo5NF1rvQdQDOVqHBPl+gY
	 f9mgT8hWuu60fcikaCA7GmUMjrNurwh/XaCFiHiuFvm1LxnrZCboJ1lz7Mx8pYHIl46dn
	 cistluuM9sWqN3DOfFVLJL8qz+xEJPsGsYFwmIQUOcaznELGetCDcUnDnGanlK92TK2YR
	 S0MaxFhCvkqUThsXPRX5A4Q0NQp47oKW63ouHLonIRR8qPgIzb9/U0cKmjo3zTtRCKr6S
	 Vft9slJurl9c1IyEc4gt4w6SNmYQEg+1MdqSrL6WM9uz5MKgNvbGdKECDI81rSSBCBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K1gejdb5;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3286074707
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD3286074707
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K1gejdb5
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so6046995e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879141; x=1794483941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6POGoe9GP/LfncNNPmyOb3NHHZhyrYu1RabNz3eag4o=;
        b=K1gejdb51J+Z8oiybieXDjNL9wJxYfNHLd1X4OBM5GNJ3wor+IUnGJXJbBw1ZVJemG
         oiQOLL70ZCPDKxZks4QCtmNbf5n1gYX7h76x5nc2888dG8C8bxvg9qIPbxL7FGuZZ++b
         0scyKGIHjQNGL3ckIenvZab7SOT9iPj+TT9DBFlx1T7hD1seza5NI8CPPEKLUFal7mIj
         PYl0DSB2Z9V4kGKcip1ICMOuHBBgkwWixzjLhug6Xkh/ygxGPiF0v5NBr2sVuMVaEPS1
         fBnHpA9IkZfoH81zrYFaaMCOQqLH27o9yOs1pyPsjgbDtnY7oidT38FFfmGSPh9F6xv6
         LvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879141; x=1794483941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6POGoe9GP/LfncNNPmyOb3NHHZhyrYu1RabNz3eag4o=;
        b=gQIZgjTvvS1GydxtdsF0qncz5MGK7QZVIe3oWNMausLkMtB/IpmIpZJetAaGcK7mq5
         SEgbQ15ZRB6r7Yd2xJbV+867g5DJ1B0edaXfjiS4GJ0W6qsmXJpovgnc1LysedQ62Pq1
         u8L+12MY2ZpqL9DBtxa+cL4W7yzaQIkkzLlplngtoL9pUfLTb9DXXQG2JlUmI1b2JkPm
         tCH9z3DdsVmemziG34fANeAzwqjEn1Of+LafZsolY+aijfsVV32splGOHdq07IvZ+mzA
         /EqIF74ojTltOYJykIrz2MpeRaxeIeaoEYJeJh9gx4mGyY5Kn18x9dagfYHD9y7d5Lku
         c6UA==
X-Forwarded-Encrypted: i=1; AKwUvBxe7fo0zueV2sBHCU3A3WH36Sa+JmHv/CL+cYw0wjT1bBqTg2zlz5/x3rmNPzgQXJj/loqVSHepuA9mQvzGnaip@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZPdF3IuF8LLV6b7/LDuNsBHd8lSR2t2ynPs3ZvB5S+X9qUIeM
	0f6UqS/vjiHPxvGvYlMcTWyFd2exD3mLgnOsGR/E4pSoNetmU3KOK/ivuT5LvOLw52Y=
X-Gm-Gg: AYBFou35afkCB3P10sUVfv0Oz2+NvJX0Cf6O1TIo9X9nTKt8+My7ge5Nw6H+beVdgwy
	7fDFUdT/UL+/QJ9S7gpQcOc2XXv0wrICN+xM3nbRG2/rX1H+ElNOZ9fSajiqod6xSp9Ps0AkSpr
	YXTsNXR5c5KfqlwlA8TpxkL+J/J/BV6HtZ471ccc62WEZcqTqnYOCU68HR+AKKocZQZLVi1Tfle
	3p6VhVwCZhOfnEgamnI5MI+Ubn20MkysSEMcSHpBTjafJHVo7oSCctwNqioH2/xc/Hm/SSJBZms
	Yc1wQ9fzMEILsPjm/V1Q6LY5+156AtCA/YOcWryslqu/mvH4Hqr9Hw+GVsNbRCzjut0mqQZBCgq
	/HJ8xNDFsG9TXW78Hr+f+hk9JVtUx3HJvMFHm2BroxwwmhYGgcX8IugraTfO9AZQUN07uypSGUP
	C3QoZMh9MflgtQE1WuZ/kX5v1gNmj+FNn97Y+zR8gLyhe+MTPSvrV35oeeEKBatfel6/WpI7WRB
	Ixb8gHpwcm4AsnjEesBZa5FzxUGJ4Pgj3iawwXlT3aaMcTbVNOHqIdKu49j5+dH3paNcB0nkk7i
	aeavvHxSBWDH/3oY5dZsZ+Gd8rKH1aORBVI10Ed5Y1WV6jFMcH0x+a8=
X-Received: by 2002:a05:600c:34d2:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4b55e07e6d5mr40258725e9.16.1793879141088;
        Thu, 05 Nov 2026 03:45:41 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:39 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:45:03 +0000
Subject: [PATCH v4 15/19] perf auxtrace: cs-etm: Capture wrapped snapshots
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-15-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

find_snapshot() isn't implemented for Coresight, so when a wrap occurs
we only save from offset 0 to current head, modulo buffer size, rather
than capturing the whole buffer. Coresight drivers currently use a
monotonic head pointer even in snapshot mode, which gives a lot more
information for taking snapshots than a wrapped pointer. It means we
don't need to search for data at the end of the buffer to guess if a
wrap has occurred, and we can go back to saving partial buffers after a
wrap by checking if the next size to take is less than the buffer
size.

The drivers will always be able to generate a monotonic head because
TRBE has a bytes written counter, so even if we stop generating an AUX
record on every overflow, we can check if the counter indicated an
overwrite and offset head by a whole buffer size if it wrapped. This
forces userspace to read the whole buffer rather than between last and
current head. ETR and other sinks use software double buffering, so can
continue as they are.

Add auxtrace_record__monotonic_find_snapshot() and use it for Coresight.
A monotonic head can't be auto-detected in the default find_snapshot()
by checking if head > buffer size, because before the first wrap a
monotonic head looks the same as a wrapped one. The search would then
falsely detect a wrap when head is near the end of the buffer, and the
wrapped pointer fixup moves 'old' and 'head' a whole buffer ahead of the
driver's head. With a wrapped head that doesn't matter because only the
offset within the buffer is used, but with a monotonic head the next
snapshot would either save already saved data again or drop up to a
buffer's worth of new data.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c                  |  1 +
 .../perf/tests/shell/coresight/raw_dump_stress.sh  |  5 -----
 tools/perf/util/auxtrace.c                         | 23 ++++++++++++++++++++++
 tools/perf/util/auxtrace.h                         |  4 ++++
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 5e7d09b7170c..84a5d7392a5f 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -922,6 +922,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	ptr->itr.info_fill		= cs_etm_info_fill;
 	ptr->itr.snapshot_start		= cs_etm_snapshot_start;
 	ptr->itr.snapshot_finish	= cs_etm_snapshot_finish;
+	ptr->itr.find_snapshot		= auxtrace_record__monotonic_find_snapshot;
 	ptr->itr.reference		= cs_etm_reference;
 	ptr->itr.free			= cs_etm_recording_free;
 	ptr->itr.read_finish		= auxtrace_record__read_finish;
diff --git a/tools/perf/tests/shell/coresight/raw_dump_stress.sh b/tools/perf/tests/shell/coresight/raw_dump_stress.sh
index bea70d825596..c9459ded4cbe 100755
--- a/tools/perf/tests/shell/coresight/raw_dump_stress.sh
+++ b/tools/perf/tests/shell/coresight/raw_dump_stress.sh
@@ -48,11 +48,6 @@ read -r size offset last_idx <<< "$(awk '
 # everything was dumped. Allow 48 bytes difference to cover 3 frames: current
 # frame length, a partial frame and a final empty one, all of which aren't
 # dumped.
-#
-# TODO: for a single snapshot, offset should always be zero. However, we
-# currently output AUX records in snapshot mode when we shouldn't, which
-# increments the offset. Allow for that until it's fixed so we can test raw
-# dumping.
 decode_size=$((1 + last_idx - offset))
 if [ "$decode_size" -gt "$((size - 48))" ] && [ "$decode_size" -le "$((size))" ]; then
 	echo "PASS: AUXTRACE buffer length matches dumped packet index"
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c613efd83223..3aabf2f4bd47 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -750,6 +750,29 @@ int auxtrace_record__default_find_snapshot(struct auxtrace_record *itr, int idx,
 	return 0;
 }
 
+/*
+ * auxtrace_record::find_snapshot() implementation for drivers that don't wrap
+ * 'head' in snapshot mode, so it's already monotonic like in full trace mode.
+ * No search is needed, only force a full buffer read if more than a buffer's
+ * worth of data was written since the last read.
+ */
+int auxtrace_record__monotonic_find_snapshot(struct auxtrace_record *itr __maybe_unused,
+					     int idx, struct auxtrace_mmap *mm,
+					     unsigned char *data __maybe_unused,
+					     u64 *head, u64 *old)
+{
+	pr_debug3("%s: mmap index %d old head 0x%"PRIx64" new head 0x%"PRIx64"\n",
+		  __func__, idx, *old, *head);
+
+	if (*head - *old > mm->len) {
+		*old = *head - mm->len;
+		pr_debug3("%s: wrap-around detected, adjusted old head 0x%"PRIx64"\n",
+			  __func__, *old);
+	}
+
+	return 0;
+}
+
 int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct evlist *evlist,
 			     struct record_opts *opts)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 9d86f8366ad7..980acb2dc687 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -607,6 +607,10 @@ int auxtrace_record__default_find_snapshot(struct auxtrace_record *itr, int idx,
 					   struct auxtrace_mmap *mm,
 					   unsigned char *data, u64 *head,
 					   u64 *old);
+int auxtrace_record__monotonic_find_snapshot(struct auxtrace_record *itr,
+					     int idx, struct auxtrace_mmap *mm,
+					     unsigned char *data, u64 *head,
+					     u64 *old);
 void auxtrace_record__snapshot_fixup(struct auxtrace_mmap *mm, bool wrapped,
 				     u64 *head, u64 *old);
 u64 auxtrace_record__reference(struct auxtrace_record *itr);

-- 
2.43.0

