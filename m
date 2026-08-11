Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA53D813A
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462264; cv=none; b=MxkH64/mBDrxgIFhp1nvwy6PbEj0AdMrBRLcgxJaaIF+vOJF+5Whu6Nn+UqCSO1GS9EkgzFKZEXfeaeqrGKIYyBJmdbX7p7YoY2NGkIwjJcF98W+KRz2NjICQ4u4NX+6XH17Pbx5ccCF4XW+MGhbNi3YkMiuBb8nrWdBy7GQAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462264; c=relaxed/simple;
	bh=H5RbpglB3mwc0VATOCqHp3bXAY+cQ8dXfMWjveqvYHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G34wzoJ/8+T6yf8HVq274et5+FxUp+z1av0yYvDi2culACjlo+pxPU0G60egKP1My/Wpg4fPwG6nk9a9/V2BcWRIOSiNwqcEYGKstZcZoAFZPEDWYR2hhx2vMPH3Xq55aLASQiWfYHtCTqFQJkbHeerqQcpGP9ebX8AOyMSypcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sjPcPonI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjPcPonI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso5195015e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462260; x=1787067060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BqfzZM8zBnaNvy70ESgvPXpjemsAbMaxUvbbfAWEGvA=;
        b=sjPcPonIccVXnDHLLtkXOq86O/g7+r+RE8Lo31rnhV6hZef4GzzcGVTDtiyyf1OJLB
         VVgwBz/2W8UHHe83tSej3tAqEVvALnL8hHzP/QeN1Th1+Nj5Z7VUbrzgHsNrDF+EfMv+
         tcjIcDZNL6rH4JHfpsCQ0VNsNCjKy8+Mw7Crawdc6FPx54Zw+nGRiwSAvB/D0Iik+p1m
         4xHIuLiLf5bhpheYeZoJp7DlZxXMxf+sp0NIwrrP+rXkMyr9J6TIcDSKGs81lw17BsEK
         HxITZiZv8W/6f57SA5WCvshwFTK90Q8iGsHUmecRY5efK2vZrBanVNyR2dJq7nFqbpG+
         aMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462260; x=1787067060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BqfzZM8zBnaNvy70ESgvPXpjemsAbMaxUvbbfAWEGvA=;
        b=VyzFAgHzZBJNrsaEFYaZrtgVaGuicbYByZWLWn5eNE3ieRuQWicZVLTMjnAqULw7YT
         cCswJqaWtWRORaVNYwUEOu7QPT3oS3qHiDFcu5BCZ7T27KbNfc7J0gAsOYqHoCjITrTh
         KQEo4jHtXYnKL632OR711YFAik/ZjjBB8ZYvH/jMk9xXIcvdyHKNARgG266KqTj6sDDL
         ZZAbf3jS+UWys9Zf+rzmomUrNVkZnYJLJoQVRkPePbVqq1OCwhPL5T/Ll6L0QuCMoGjv
         TJJtI5M0NZJpChJ9emGVuC0+fjEWrA1/JXkNH0AyAm55+k+lJ9VYDvu4sg3HDJ0JOV/6
         0pfg==
X-Forwarded-Encrypted: i=1; AHgh+RruMszy68WBAOmkAyC6umSEbM34B3qNHSYWvxcnrAA/MRmVVkrSXDVMm7OrS7WZ/frs8Rlfb/EocJBps/w2F4aZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlb8KhrPR+mDtaLTTIgn4RFsYihLSgC3z0I7uxs6j0mbHfVyMb
	6YBZeQjZwVStdHP4Ykiyh7KWj2x08kmOP6BpgfsUX5X6vYCgaMI13krElYW+Qp/N40U=
X-Gm-Gg: AR+sD10YYHMIHsHRq6647BXmnPyOXdy9MIG7GE5Ka3ijwB51XQWF8hdobrgSVaao6wt
	RfzpUXi8LXRoTNu1DsEKFdHDnYfOYctQczXRZ136pPxKuDx1unQ1EfjQBpVbJsgOtjMJqTt5ZbS
	gUJ5ibFOCeGvo87Kldn3JucxgX8MwVoJNSuTDST+KdQLWRFvaTb+7fzV25+hLprrv3qGrru5P4r
	k153/e9DhIq5rJEVzJU4PSzGA1lV7qbs72nvHxixoWZOzkPcXBMMR9hqS6kwYl+rmPnC4O4RMHu
	CteXTcEfp6f4/3b2fndkDAGgbBJpB+ZjCUBVMQZ1mZorWDSYU7gFJM2GvIGdhOGo4ukm4VbdtLG
	RyHfSmnaITtNwegXiCJP9klL0s8hbwXbJIFK3AGbuBD+KFN0LKyG9i7IAWSqP7jtokt5TdyTx2T
	kYT9WEvRlL+gB7niCw+NrRB73YIGNFxdC8MiEemBfj3G+JaNarRoZdjq1W/QwMPVLD
X-Received: by 2002:a05:600c:6305:b0:495:7a5a:d96c with SMTP id 5b1f17b1804b1-4997aadefb7mr1062005e9.18.1786462260473;
        Tue, 11 Aug 2026 08:31:00 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:30:59 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Aug 2026 16:30:11 +0100
Subject: [PATCH 08/14] perf auxtrace: intel-pt: Use new
 snapshot_has_wrapped callback
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-8-90565318f5f8@linaro.org>
References: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
In-Reply-To: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
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
 Suyash Mahar <smahar@meta.com>
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

