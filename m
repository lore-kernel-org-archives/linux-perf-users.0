Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9F46DFE3
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305788; cv=none; b=jDKwNItotK6CTY5wBPyRjBzGoHhRsQBHW9Y7Mo+CR7zOYNns8UBnFe8NjfQt5z7uMFwg/kp6aLibl0DaWxGzeA/JM+Emt07IcOf8Xq/wqCoSsQREjxBQJ2P6BPSrOclHglZAi56/QGFOXTjP0dmLHknAkFEuXJ0SKl80YMjan4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305788; c=relaxed/simple;
	bh=H5RbpglB3mwc0VATOCqHp3bXAY+cQ8dXfMWjveqvYHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uTTgQVDat1re4Cl59Cst6KwcS2CgkobzpqINFYxsh9KYEnznUbLIHy9Wj3IBV4xKd/XFoAv/JVxA+t06Y9x8ECtJ8O0cuWwTP4jZmFtH5//FM4Q7p/fosNR2NgBZSN5Zi6a8iSzkbCC9zwzFxp5UbdSejjbx839wEKhfvYzeO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xMTTh+Vd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMTTh+Vd"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so569862f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305776; x=1787910576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BqfzZM8zBnaNvy70ESgvPXpjemsAbMaxUvbbfAWEGvA=;
        b=xMTTh+Vd6MDy1VRjERTsDKjGJwve/5mlmm0WFutZSanEmObEyKjA2whplluN4IAcBZ
         ZiSr7be8AeTW4vECforFHzRs1dZ+977tY2mYNfU45UMnMbHTJJNtCsmqP0NVu/NIblrT
         Wa/q4mXgUtvPgG1GGyz5AYeKDNF+JFblRY1d1/XoHUKsbZO6usal3fAwmpYxDUei7K5/
         Cp91flZy7IhvilH5MwIg+MCGhD1oYZL77UPlNXxaJubhPIy+Z++F6jdT3w+gnSKfQVOL
         EiCt+3kvGbhC7XovpprCpSlPFSzlwNIaWOVFCK3vCkvygjPoaz0MIER92sQnMrHchk89
         sALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305776; x=1787910576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BqfzZM8zBnaNvy70ESgvPXpjemsAbMaxUvbbfAWEGvA=;
        b=V++gla6LhwUmnVZngWUSDtL0VdI7BzuXJTgLXev7rqS3+wVclOx7fi+FYi+LNWOk0m
         Qwtbb4yJc+BVME7lDQuuexgRmoIi1/V0AXrjpgFxFwEQP41R/JpCrcDcU6N95Jt3qFLe
         zGVEb1Jc7NMieWPSHVn9A17ssMkSofZjwBUf5KABRHzoN09vuxz8Mj7caF/iFuzpBA+Y
         SbxqsOD11BtktGEmG7ni4dCSHmklcronTT1hXRgDalREHmGnJtkh87ciVFaiUW33yuVe
         fYOtL3A+oifm17vRrWe/p88/4UbifPhw42qgseoN2saDfFRHb+FKpDKy8/MtvJhuFP9y
         oqRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZpgu6bYsberI63KQObm4NuXtPBoAkQKoGrUo84nYkzmXIJoA59awoNA6lY71YV32sz5oO8stBSss71TKiS04p@vger.kernel.org
X-Gm-Message-State: AFuF++mCdhPRRHu0gijagIkEQ7/57Xhj4UrIiitH0n2JM6BF/nUM2tm4
	UKUFgcGwGraLR/Emv3MUxylsEWzT9/Fa12wgeI7Y644xaCSKsbmhRrhsfD5keM6LrYI=
X-Gm-Gg: AR+sD133FYdkNvt6XNdqUhSKhB17XK3g0AVF7+kiri+lj7xYJk8WS8+5TEydTuSaV9s
	wQnPuQ7nfJCVAR/jMEx+yOG/7byi2iA8ReJCs2M936JTGdp45sODNfKkqSc/fi7paAwJu835r2z
	/AP3Xe8g3yWKNTUQIrnsSUAuMpFK+zKRkSjO6uacTUMxY6FGaTjD9VwlURFwYaFFuuPNQb/2uZZ
	Va6RSCOd1LDKFuWfYolCJn6QXlCwLpzR5fFZ9dO45747q3nOCWVsvDlcniYSoefHTotHMNpxWNv
	RAN2ecYMz+K6fNqiPkcdb+1GF56CnK0bQUBceONHuZc2ICEYQr/n8gWqfJ0GrITFfAmesdK9jgQ
	ERf9SvikjVqdj1/M2H4u/sX1Qe83MXSCCX0v5NamBTlzxAZ+3Fk6Ad7Sn6W3xnK7+x6HwP4yW0Q
	s+5eBnDzS57Pd9hgdQfNVmgluPC420zj0dIhVkuVvLt5+jPtNmr+VEAyzKz+SJxWa4
X-Received: by 2002:a05:6000:40d9:b0:47f:f43e:f0cd with SMTP id ffacd0b85a97d-482c0b4230fmr7267629f8f.4.1787305776005;
        Fri, 21 Aug 2026 02:49:36 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm17683479f8f.35.2026.08.21.02.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:49:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:49:06 +0100
Subject: [PATCH v2 08/14] perf auxtrace: intel-pt: Use new
 snapshot_has_wrapped callback
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-unformatted-per-thread-fix-v2-8-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The new callback is only for the search, and auxtrace.c fixes up the
pointers after a wrap is found. Update Intel PT to use the new callback
and finish removal of the old one now that there are no more users.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/x86/util/intel-pt.c | 58 ++++++++++---------------------------
 tools/perf/util/auxtrace.c          | 14 +++------
 tools/perf/util/auxtrace.h          |  7 -----
 3 files changed, 19 insertions(+), 60 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index a533114c0048..b8de129a218e 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1080,17 +1080,17 @@ static void intel_pt_copy_ref(void *ref_buf, size_t ref_size, size_t buf_size,
 }
 
 static bool intel_pt_wrapped(struct intel_pt_recording *ptr, int idx,
-			     struct auxtrace_mmap *mm, unsigned char *data,
+			     size_t size, unsigned char *data,
 			     u64 head)
 {
 	struct intel_pt_snapshot_ref *ref = &ptr->snapshot_refs[idx];
 	bool wrapped;
 
 	wrapped = intel_pt_compare_ref(ref->ref_buf, ref->ref_offset,
-				       ptr->snapshot_ref_buf_size, mm->len,
+				       ptr->snapshot_ref_buf_size, size,
 				       data, head);
 
-	intel_pt_copy_ref(ref->ref_buf, ptr->snapshot_ref_buf_size, mm->len,
+	intel_pt_copy_ref(ref->ref_buf, ptr->snapshot_ref_buf_size, size,
 			  data, head);
 
 	return wrapped;
@@ -1113,69 +1113,41 @@ static bool intel_pt_first_wrap(u64 *data, size_t buf_size)
 	return false;
 }
 
-static int intel_pt_find_snapshot(struct auxtrace_record *itr, int idx,
-				  struct auxtrace_mmap *mm, unsigned char *data,
-				  u64 *head, u64 *old)
+static int intel_pt_snapshot_has_wrapped(struct auxtrace_record *itr, int idx,
+					 unsigned char *data, size_t size,
+					 u64 head)
 {
 	struct intel_pt_recording *ptr =
 			container_of(itr, struct intel_pt_recording, itr);
 	bool wrapped;
 	int err;
 
-	pr_debug3("%s: mmap index %d old head %zu new head %zu\n",
-		  __func__, idx, (size_t)*old, (size_t)*head);
-
-	err = intel_pt_snapshot_init(ptr, mm->len);
+	err = intel_pt_snapshot_init(ptr, size);
 	if (err)
-		goto out_err;
+		return err;
 
 	if (idx >= ptr->snapshot_ref_cnt) {
 		err = intel_pt_alloc_snapshot_refs(ptr, idx);
 		if (err)
-			goto out_err;
+			return err;
 	}
 
 	if (ptr->snapshot_ref_buf_size) {
 		if (!ptr->snapshot_refs[idx].ref_buf) {
-			err = intel_pt_alloc_snapshot_ref(ptr, idx, mm->len);
+			err = intel_pt_alloc_snapshot_ref(ptr, idx, size);
 			if (err)
-				goto out_err;
+				return err;
 		}
-		wrapped = intel_pt_wrapped(ptr, idx, mm, data, *head);
+		wrapped = intel_pt_wrapped(ptr, idx, size, data, head);
 	} else {
 		wrapped = ptr->snapshot_refs[idx].wrapped;
-		if (!wrapped && intel_pt_first_wrap((u64 *)data, mm->len)) {
+		if (!wrapped && intel_pt_first_wrap((u64 *)data, size)) {
 			ptr->snapshot_refs[idx].wrapped = true;
 			wrapped = true;
 		}
 	}
 
-	/*
-	 * In full trace mode 'head' continually increases.  However in snapshot
-	 * mode 'head' is an offset within the buffer.  Here 'old' and 'head'
-	 * are adjusted to match the full trace case which expects that 'old' is
-	 * always less than 'head'.
-	 */
-	if (wrapped) {
-		*old = *head;
-		*head += mm->len;
-	} else {
-		if (mm->mask)
-			*old &= mm->mask;
-		else
-			*old %= mm->len;
-		if (*old > *head)
-			*head += mm->len;
-	}
-
-	pr_debug3("%s: wrap-around %sdetected, adjusted old head %zu adjusted new head %zu\n",
-		  __func__, wrapped ? "" : "not ", (size_t)*old, (size_t)*head);
-
-	return 0;
-
-out_err:
-	pr_err("%s: failed, error %d\n", __func__, err);
-	return err;
+	return wrapped;
 }
 
 static u64 intel_pt_reference(struct auxtrace_record *itr __maybe_unused)
@@ -1221,7 +1193,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 	ptr->itr.free = intel_pt_recording_free;
 	ptr->itr.snapshot_start = intel_pt_snapshot_start;
 	ptr->itr.snapshot_finish = intel_pt_snapshot_finish;
-	ptr->itr.find_snapshot = intel_pt_find_snapshot;
+	ptr->itr.snapshot_has_wrapped = intel_pt_snapshot_has_wrapped;
 	ptr->itr.parse_snapshot_options = intel_pt_parse_snapshot_options;
 	ptr->itr.reference = intel_pt_reference;
 	ptr->itr.read_finish = auxtrace_record__read_finish;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 9586989e645e..8ca872e6d465 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2061,16 +2061,10 @@ static int __auxtrace_mmap__read(struct mmap *map,
 
 	head = auxtrace_mmap__read_head(mm, kernel_is_64_bit);
 
-	if (snapshot) {
-		if (itr->find_snapshot) {
-			err = itr->find_snapshot(itr, mm->idx, mm, data, &head, &old);
-			if (err)
-				return err;
-		} else if (itr->snapshot_has_wrapped) {
-			err = auxtrace_find_snapshot(itr, mm->idx, mm, data, &head, &old);
-			if (err)
-				return err;
-		}
+	if (snapshot && itr->snapshot_has_wrapped) {
+		err = auxtrace_find_snapshot(itr, mm->idx, mm, data, &head, &old);
+		if (err)
+			return err;
 	}
 
 	if (old == head)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index c2342d0f4afb..a9d0c84184c5 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -375,7 +375,6 @@ struct auxtrace_mmap_params {
  * @free: free this auxtrace record structure
  * @snapshot_start: starting a snapshot
  * @snapshot_finish: finishing a snapshot
- * @find_snapshot: find data to snapshot within auxtrace mmap
  * @snapshot_has_wrapped: callback to check if the buffer has wrapped in snapshot mode
  * @parse_snapshot_options: parse snapshot options
  * @reference: provide a 64-bit reference number for auxtrace_event
@@ -400,9 +399,6 @@ struct auxtrace_record {
 	void (*free)(struct auxtrace_record *itr);
 	int (*snapshot_start)(struct auxtrace_record *itr);
 	int (*snapshot_finish)(struct auxtrace_record *itr);
-	int (*find_snapshot)(struct auxtrace_record *itr, int idx,
-			     struct auxtrace_mmap *mm, unsigned char *data,
-			     u64 *head, u64 *old);
 	int (*snapshot_has_wrapped)(struct auxtrace_record *itr, int idx,
 				    unsigned char *data, size_t size, u64 head);
 	int (*parse_snapshot_options)(struct auxtrace_record *itr,
@@ -595,9 +591,6 @@ int auxtrace_record__info_fill(struct auxtrace_record *itr,
 void auxtrace_record__free(struct auxtrace_record *itr);
 int auxtrace_record__snapshot_start(struct auxtrace_record *itr);
 int auxtrace_record__snapshot_finish(struct auxtrace_record *itr, bool on_exit);
-int auxtrace_record__find_snapshot(struct auxtrace_record *itr, int idx,
-				   struct auxtrace_mmap *mm,
-				   unsigned char *data, u64 *head, u64 *old);
 int auxtrace_record__has_wrapped(struct auxtrace_record *itr, int idx,
 				 unsigned char *data, size_t buf_size,
 				 u64 head __maybe_unused);

-- 
2.43.0

