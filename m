Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF5282F0A
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043410; cv=none; b=dVpahtdG8V311UkLfzgOgpRmSGua/s9Qaa7gAX6muiB7Vfx8wGxX28hl+Yh9rrRF2bn2VwXKp+TaeVXKYxSxNFquR0pkaUXc3hZBJFHDBQCd9fwf9/SyuLCVxNP/NQN8TOag77/P3LS1Zq4UmVVte7MnOja6Yi1mTkGR0Oj8jGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043410; c=relaxed/simple;
	bh=EIb6tJcKoSqkpkMiIWHT8GXSEcQ8tARRtV2V9HnrXoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bMNTvC5HgYZ1Sf5KIGIsfgFVNWMo+xAIOAO+xCyjwbS7lvKM3DnJNeb2myuO0Th2blYSRBKmbuqyrJkwOZK+N7/3z/NyG7P7fVfcS1tsM0yWo/YSVjA6nGrzmuvdJzJJ1eYwyqgKvenqY45Bx7BNztGMNNwJOEzT3vITDZk2Ue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4gbsRf2; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4gbsRf2"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d443c3b094so8551171eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043409; x=1776648209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0NBhXTshGbMXUhORX+eVN1pO2rFpCDmkzuCKC25Nuc=;
        b=U4gbsRf2qL6W1us9qhLvY5HiUc/UIapgVSuKGNqffMFSu/r+1u62+DAK/PYKZgAN4n
         ORln2Lz1ad0D8yDjrNhLQtSpFhmaw0hh75ahnCZyFVMXf9pkKwTgAiAE35gbL04uwMq6
         B8K3CA7Lte+SMVLgl9EFDA76F/gVN/8dhYIMzHQrK0eff5eVmmCYY2rXmNcpW+vHDFXo
         1AcYpLRU+hjhtJ4exIfgjMFrMyJ8AYTKfEyJptdKyxsHIyq3y1bHbEhwaGPOoklViBkz
         WAqyw5NRDeVkSyOzRtL+4nKkJBpkhpbBYbitAKYe07DY8EGo6hlgR0AiYEZWrf1ZRW8Z
         zwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043409; x=1776648209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0NBhXTshGbMXUhORX+eVN1pO2rFpCDmkzuCKC25Nuc=;
        b=qnP9n159MlKRKjohYxnliEQFcYfM7En8bjCF4c+WTGjIWgbnsQMjdMzaD6WBzMwaeU
         dhntQLiPyp5QkGAq9czBhNhQX26PgaozRK2Q2x1S+Kwr354cqBPKy0gXxHfEgVkewAVY
         xgX8rzL8pnjJkVZT+kHnAzZvH5REC+s6B29MU1wjRpQUhfUxyDycVGvYMdkSk3o2+hLg
         xSGgvmncII+lVPRFk2xxoPXREK1t4bArH5NFNpG0Sh8Eo+/LUMWcF8kNiS+7bxUuZmhR
         MPv7Acvk3JLVbynk9OcLaT2CdBUESL0PuILQz3Ry5H0tpY4Uo5o+L9k1v6xzDn4kylqZ
         IprQ==
X-Forwarded-Encrypted: i=1; AFNElJ+STyAGdLNXVAowjFvqV750Nr3XxrSK7A8FECA2IshWMyA8tNneV3imdSFjAhC0+uqIKvJQy3MGIXXUgN5Qvef9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl3Rk609Ev/XFxEx08b5z6qOWXH3vd7x7oYBwwFrO7KDHO1l8T
	z7fwk11xVdrvb2YXIZfuPPto1NBwUapKnEWSxqaMWlP2SXvXbhrNzb+TYNAWCIWOisvONs+rKAK
	/SFvvkGGpCQ==
X-Received: from dybtv6.prod.google.com ([2002:a05:7300:f486:b0:2d8:5b05:964b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e82c:b0:2cb:990a:b5e
 with SMTP id 5a478bee46e88-2d5881acd8dmr5868305eec.15.1776043408615; Sun, 12
 Apr 2026 18:23:28 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:20 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-27-irogers@google.com>
Subject: [PATCH v11 26/33] perf kmem: Fix memory leaks on error path and when skipping
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Add missing frees and thread__put as necessary. An issue detected by
Sashiko code review.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 68a39f56204d..daf2272c7337 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -783,17 +783,21 @@ static int parse_gfp_flags(struct perf_sample *sample, unsigned int gfp_flags)
 
 			new = realloc(gfps, (nr_gfps + 1) * sizeof(*gfps));
 			if (new == NULL)
-				return -ENOMEM;
+				goto err_out;
 
 			gfps = new;
-			new += nr_gfps++;
+			new += nr_gfps;
 
 			new->flags = gfp_flags;
 			new->human_readable = strdup(str + 10);
+			if (!new->human_readable)
+				goto err_out;
 			new->compact_str = compact_gfp_flags(str + 10);
-			if (!new->human_readable || !new->compact_str)
-				return -ENOMEM;
-
+			if (!new->compact_str) {
+				free(new->human_readable);
+				goto err_out;
+			}
+			nr_gfps++;
 			qsort(gfps, nr_gfps, sizeof(*gfps), gfpcmp);
 		}
 
@@ -802,6 +806,9 @@ static int parse_gfp_flags(struct perf_sample *sample, unsigned int gfp_flags)
 
 	trace_seq_destroy(&seq);
 	return 0;
+err_out:
+	trace_seq_destroy(&seq);
+	return -ENOMEM;
 }
 
 static int evsel__process_page_alloc_event(struct perf_sample *sample)
@@ -971,6 +978,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	}
 
 	if (perf_kmem__skip_sample(sample)) {
+		thread__put(thread);
 		return 0;
 	}
 
-- 
2.53.0.1213.gd9a14994de-goog

