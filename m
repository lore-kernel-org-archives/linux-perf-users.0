Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE833F8B3
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057146; cv=none; b=Mh7XolIueNPV6PVqPN1XMOoEhykku2Xau6qCHcVHj3j50S3ofIVhkrqcbU5YbM2W1InFBuCd8lsk2D5ZOKSbtfPzERjlQqKc1Dt+ZSPkqmHbNbNFeVrCu8WiYpTIR7Gg1W5X1Q6Dl+d/HNM2yejbxD4gteIZU80on82cA424yvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057146; c=relaxed/simple;
	bh=0G/j/xJj1qsweoCKMUXKGFzeFo7TvQZ/7fH1qwVBjpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FUo+MXoeiLQ6Tixw3rWoBwlLqtpKmrNCauAa9TANOqag2xvPmY04NPX51iWBI5qZSIejen7AE+FxqxPogYNJb5TqR1TQgs4Wr9pmp4D6v4Yi1HI+S7v7AMU+GpNHLFfYMejDdd7oj1fiDfUYGNjWvjrkH9iLPZhNUlzuvSuURMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDcZvJIE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDcZvJIE"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b95d06db747so1745383a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057145; x=1763661945; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwL0flbR67e6mq7ibhkhVdiS0tjPyP1QzI5zBDpL9cA=;
        b=xDcZvJIErPpu7Z/SU4vqwwY7t35sXRCkgfC01ash+1zIwWCCD+e3eOxUsotIb88hTZ
         Le6Lp+GpLTgRFvUBIIiHTfA1kyuvWBcSsYfQVP98jXDVViwDtgfoPbgLvb0MABSzURp6
         g8zIGRdkqOBSOFjGV5D94LfIj6vtIFELdSlp2/muFz9Qs9uYamoeXcilcqN4VsSGSP1Q
         MfYH4cbpZSRQx5DcaRMt27a6Xgf37hvaDi4qPZUovVz+UvutIZ4ekxNwIz16pBn2tx2w
         dWwmK7jp3dLsRHY4ghNolDA5YqOaXc5DBx3YSenlPF6AVln82YXUsO3DYny5+2k3WxU5
         04zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057145; x=1763661945;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwL0flbR67e6mq7ibhkhVdiS0tjPyP1QzI5zBDpL9cA=;
        b=dAP1PalS/ooR5S2Bi660QfpAzBNH5sYUlSe3YzMM7mgq+AmkV37HOdH2ERDQRoAvc1
         HX09zBXpTYHhnxOsYLa4i/r0/XfCMXCogYOpLx8XITcZ3AucEixNLaye4S6dUTCESSIM
         bEFkJxObPRwmRFnRU7C6Ta1ANtn3Qs9roAaZ7HePzpGpYrmH1o+1C8iefmPif/9B0ICj
         k7XH1WyllEmXjpiP741UTPHv7QjNTcltTLa8Db9a2TU4EOrQWkRxSUJpAX846wYxCVLH
         SA+eBu3Gi80Kca9Pn07HDQa4i7qcQ1pRdTj248PXJ44+l4OX1Sxc+z5yNmNYgkHM08R8
         j7ew==
X-Forwarded-Encrypted: i=1; AJvYcCX4RvPD9zLme28JXHS6796+ORO+DBDDnvVvFdp+tikz8xlBc878Lg4Qm0USueUJUVevNAuQO3stzrk1NEadJDjj@vger.kernel.org
X-Gm-Message-State: AOJu0YzQAMIk0n1hHmfvNaqbSLh4ORW99l/gpTEw19Gga2ewgKfifehE
	FzT3Q55cuQNNwGmkApIck4LR+z4jq3om1PDmRI6PlAxRquQvqAMIlM4uj4Ho/dNUlScxWtTZbK2
	NW3EvW2hDqA==
X-Google-Smtp-Source: AGHT+IF6Jd/RowQsFfWnNU8wA7E0ssHBi+qEZJ0B7mLoneITR8fS1wlRdblP/48yXPF2vGHx7hvFukXw9/Mb
X-Received: from dlbqc12.prod.google.com ([2002:a05:7023:a8c:b0:11a:3b81:6bc6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6624:b0:11a:468a:cf9b
 with SMTP id a92af1059eb24-11b034b5b0amr155103c88.9.1763057144586; Thu, 13
 Nov 2025 10:05:44 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:07 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-2-irogers@google.com>
Subject: [PATCH v4 01/10] libperf cpumap: Reduce allocations and sorting in intersect
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On hybrid platforms the CPU maps are often disjoint. Rather than copy
CPUs and trim, compute the number of common CPUs, if none early exit,
otherwise copy in an sorted order. This avoids memory allocation in
the disjoint case and avoids a second malloc and useless sort in the
previous trim cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index b20a5280f2b3..7e88417ba84d 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -453,21 +453,33 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
 struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
 					     struct perf_cpu_map *other)
 {
-	struct perf_cpu *tmp_cpus;
-	int tmp_len;
 	int i, j, k;
-	struct perf_cpu_map *merged = NULL;
+	struct perf_cpu_map *merged;
 
 	if (perf_cpu_map__is_subset(other, orig))
 		return perf_cpu_map__get(orig);
 	if (perf_cpu_map__is_subset(orig, other))
 		return perf_cpu_map__get(other);
 
-	tmp_len = max(__perf_cpu_map__nr(orig), __perf_cpu_map__nr(other));
-	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
-	if (!tmp_cpus)
+	i = j = k = 0;
+	while (i < __perf_cpu_map__nr(orig) && j < __perf_cpu_map__nr(other)) {
+		if (__perf_cpu_map__cpu(orig, i).cpu < __perf_cpu_map__cpu(other, j).cpu)
+			i++;
+		else if (__perf_cpu_map__cpu(orig, i).cpu > __perf_cpu_map__cpu(other, j).cpu)
+			j++;
+		else { /* CPUs match. */
+			i++;
+			j++;
+			k++;
+		}
+	}
+	if (k == 0) /* Maps are completely disjoint. */
 		return NULL;
 
+	merged = perf_cpu_map__alloc(k);
+	if (!merged)
+		return NULL;
+	/* Entries are added to merged in sorted order, so no need to sort again. */
 	i = j = k = 0;
 	while (i < __perf_cpu_map__nr(orig) && j < __perf_cpu_map__nr(other)) {
 		if (__perf_cpu_map__cpu(orig, i).cpu < __perf_cpu_map__cpu(other, j).cpu)
@@ -476,11 +488,8 @@ struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
 			j++;
 		else {
 			j++;
-			tmp_cpus[k++] = __perf_cpu_map__cpu(orig, i++);
+			RC_CHK_ACCESS(merged)->map[k++] = __perf_cpu_map__cpu(orig, i++);
 		}
 	}
-	if (k)
-		merged = cpu_map__trim_new(k, tmp_cpus);
-	free(tmp_cpus);
 	return merged;
 }
-- 
2.51.2.1041.gc1ab5b90ca-goog

