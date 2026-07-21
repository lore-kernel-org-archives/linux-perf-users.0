Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0FB476CC0
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677991; cv=none; b=nvOl4oEgsjL7oxT1kx7QVOsfjQWW++KNZLVeuwAh+WdpZuCcgeXNwNGdlpwKRL6EfZuDCMKihmPetB6XsmAqK8N4syBvkJ9RRaOHBJvrNV/PbLdXKoJkId9cM4imNdhk0a57azvUCVtgO3plmX56EJkoR9BM670bQJwDkRdiguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677991; c=relaxed/simple;
	bh=/YeOSfAgO5rkMvf9uJr3Wv7ZqimEhbokrDMzqormkcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbVU+d3qcBlEievIPq0PIm+xWaTJdf10Bfqg0uTh1EPSZ+gsCRZ5KbujPfFO5SKGjoNA7/w5pKjBgafUNmL2BhVjBsxSGa46xVM01aqTjr2ECB/ZTvz871Guntd7OKL5WdvKiDUqHVNKjIzYYujXJ/dUqeqA5bGa28F5USNH9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4jJzwVO; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4jJzwVO"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so10711598a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 16:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784677990; x=1785282790; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CVX6X+hj30Y8z8Y2WWGsOx1d6huMMqhYwvfBgRyMVvE=;
        b=e4jJzwVOkgtsTZ3H6Azp+vvyEi9kYVuHUfYAVxBKWUus5WvoT6vjCntIddApbBUUbE
         beKpPPeVHx0+CuO6zHNR2e+qEir98gATqMHUgKGqs9gV1IfvonCxZYJ+UUqsrqPnvjwp
         6qyPODAnw1zavH/3I/OsJNpT866EGFsUMmI2s9H0kLc6foD9fzDVGMHOdIbzGiUC5I5p
         StMMU6CycppeOk2PS++GDjZyf3YYe36KuR46u+5rSZdgIp4lnaqH1KQBoEvA0F8sM/4k
         TO5mvPOb5YpI7rRZuRJo0cBnYRGklTP67w2oox0tVQoEryilOSwGPGy47wexe54FFmCM
         +esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784677990; x=1785282790;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CVX6X+hj30Y8z8Y2WWGsOx1d6huMMqhYwvfBgRyMVvE=;
        b=UI7QWNjKCUFGUC21upaOxpD+u6PAY1rDa2UV1IoFbJGJDJZI2BzSy+Oyz22wVB0TRJ
         zK6QIZ9LO7ntUzuAXgP8U4KAzl1Y0J70NOt0DFqggl7pKgdGKnVDKyi/ejXG+u6+wWw8
         AE++/Y2oDqwFROASm5aAa3GvQIjNF4+EZmkkV843dz98+ojO4L7Awow4dZ8cWl884iAC
         cWmJV7A6m7nNlBTKnGwEHKZg6A5TinV/FFsGdk0fOmY18NPF76JqI/k1C4r4HC2accms
         9NUqd8kpNQis2qSdThXpX1CuCsh70OpM5iidUvxVD1VGDCAoUa35tFYfdCFCbgk2rX2B
         j0Zg==
X-Forwarded-Encrypted: i=1; AHgh+RpciNDlGSsCzX8b+SuBCc0OCQTfYKoX1a3tlRXUvYuv0Un+Lzf/Q+p3dpTCo8YOAvSl+7+c6jxOQBaNQJ8HLuTS@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNaHbYb57xDK/HLj4xJXGGw6zP/kQOgVIznjm2IWYVqvPMDOF
	/mChuV9BtGn5DzEsOmw1VRyGMIlhIGku3EyG03F11Wu5ov2BpUDQMi2v3/ShaGiY8QDMS7mtFSk
	SXEEmAsJ+BQ==
X-Received: from dloo22-n2.prod.google.com ([2002:a05:7023:a56:20b0:13c:e1bd:718c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b86:b0:38e:8050:e63a
 with SMTP id 98e67ed59e1d1-38e8050e7b8mr9552295a91.6.1784677989362; Tue, 21
 Jul 2026 16:53:09 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:52:54 -0700
In-Reply-To: <20260721235254.294053-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721230952.267754-1-irogers@google.com> <20260721235254.294053-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721235254.294053-6-irogers@google.com>
Subject: [PATCH v7 5/5] perf synthetic-events: Fix bounds and union member
 access in mmap2 build_id synthesis
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"

Modify bounds and union member access in mmap2 build_id synthesis. Bound
max_filename_len against the minimum of filename array capacity and the
outer union stack layout minus sample ID trailers. This prevents both
-E2BIG overruns and _FORTIFY_SOURCE array bounds aborts on strlcpy even
if the enclosing union expands.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 5bbf024ad606..75a32ae8ef62 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2457,13 +2457,18 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
-	void *array;
+	void *array = &ev;
 	int ret;
+	size_t max_filename_len;
 
-	if (filename_len >= sizeof(ev.mmap2.filename))
-		return -EINVAL;
+	max_filename_len = min(sizeof(ev.mmap2.filename) - 1,
+			       sizeof(ev) - (MAX_ID_HDR_ENTRIES * sizeof(__u64)) -
+			       offsetof(struct perf_record_mmap2, filename) - 1);
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
+	if (filename_len > max_filename_len)
+		filename_len = max_filename_len;
+
+	ev_len = offsetof(struct perf_record_mmap2, filename) + filename_len + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
 	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
@@ -2483,16 +2488,15 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
 	ev.mmap2.build_id_size = bid->size;
 	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
-		ev.build_id.size = sizeof(ev.mmap2.build_id);
+		ev.mmap2.build_id_size = sizeof(ev.mmap2.build_id);
 	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
 
 	ev.mmap2.prot = prot;
 	ev.mmap2.flags = flags;
 
-	memcpy(ev.mmap2.filename, filename, min(strlen(filename), sizeof(ev.mmap.filename)));
+	strlcpy(ev.mmap2.filename, filename, filename_len + 1);
 
-	array = &ev;
-	array += ev.header.size;
+	array = (void *)((char *)&ev + ev.header.size);
 	ret = perf_event__synthesize_id_sample(array, sample_type, sample);
 	if (ret < 0)
 		return ret;
-- 
2.55.0.229.g6434b31f56-goog

