Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB0351FB4
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057148; cv=none; b=hstlDy7hCAIlxMeHh3IwH8HBPLsY2cN2XjhjdHUINE80txIwpjcdBA1k4h/MGpsXXnCtfCU1vhKmeZnri3b717k2O5KQ4nMlmUIrLvXCFpUGOPOGhKYnf8FoZvHB1qzL+peSPQ2YKT6gqyePYbzlRQmDAngSdVDISm+AOMdaX8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057148; c=relaxed/simple;
	bh=Kgo7sxJNHAVdmzHf5VuG0p/PQfK1697phqEp6Xwcyo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XBTItfSJkpWRRcftodc99o4hvypUMhIrkW1jFy6/5xDbn1pRARZo9SHOjX2qMwJR33Cfk3TpTvLdV24Sx9aKaFO6srHHJlB1igXF9TEZeEU4rdojlK9PfiR+tBNyatCPV9J2/dFvClY1pZ0Zs9kIksp/zeYemI7n0Oct6522Sj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkxLh1Qu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkxLh1Qu"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5533921eb2so930822a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057147; x=1763661947; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLwg+2AiO3F/YfbdpvnrnBijRms/bsxixJsYS/jBPB8=;
        b=mkxLh1Qu4AFd3Ts3SYZtceIj/gBo6/jXqiJwrBjtPQtKxFcd8NRwYzd6I18gzmGGW8
         BsGaYbci91Y2O4h8gUoNCNoGBegpvsLVWOy7RpSperd3fjsNyJeAIjZ2z9ntPCa/VICv
         9hIV4NzIlgjR1TxTbBz9+RCmz4JGxRtJlwvhpzsaD2PoMoe7oJ0uAU8dAU/oUtOOkl8m
         ksOAZxEHD1YRHwGkJBXXSr/G+hn27InamWJddFQFu0URVx61WnXPzvcXFtHlHrZkNEZm
         QjZfWN5zwo+ZiOyqKknQqZv+u+TK9+6Sa6jNxddLFucKWOI/5xOdgESVkG7uQ0DH+ulY
         vFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057147; x=1763661947;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLwg+2AiO3F/YfbdpvnrnBijRms/bsxixJsYS/jBPB8=;
        b=X0OBUJ+rulvsW9NhqVPaeKABZmprRj5U5rGoBkuYF0g0xhx5P57xneCK99h7WmCUlk
         ifnwgmr7gflceN3613MuPiUA3Q3yBxZjynVNKoQylyIc7pWXRY+WJjkycVuLCVIAFEz+
         DLLZay3xfBdqYnLKh4Wr/yzhLCYCnM8ye/9EidIdHefbdyDrWQnNh50WBH1fgl5XQkDk
         twQiEeodLar69zoTi8BVSt8EwEDMFdtp5IDdl0J2zIf8tzbZpDnBPfUSrs5fdQw56eM1
         fI8AjOvjjliTtR2dY/rapiKHvM2TDqTZ1BHBSM4tFe5gxt5txK86n1GUmaCIUX0JgXeg
         BqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpwHA7jaidIc+Enx9iwo6qnrvA1XMiLWp6rx54CNRzkIL70pounHEjXtaHh90Ufxdbr60VRAmeisea7t+5kPl2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx//e6hZTAapkbiV5qm6yNV3AV0x1QWfnJwVjDcjKOSig7QHqQ/
	nVmdl31nnYvX42x+Xw4obXkJjR4qx3kWVcSqOmSe1elkP5n3N8yhl7fN5rNVl+wZUtOQKgMn9KO
	CqEN8qrebKg==
X-Google-Smtp-Source: AGHT+IFbajqAQB2d6aMONKVtiXudHvRLHNhAEQeFC1FWchyERaniAWCZhVAeMlCzIly02rNyk9QLl/YT3gO5
X-Received: from dlbbq7.prod.google.com ([2002:a05:7022:6707:b0:11b:65e:f6a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ce8e:b0:2a4:3593:6453
 with SMTP id 5a478bee46e88-2a4ab88119cmr103806eec.3.1763057146678; Thu, 13
 Nov 2025 10:05:46 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:08 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-3-irogers@google.com>
Subject: [PATCH v4 02/10] perf pmu: perf_cpu_map__new_int to avoid parsing a string
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

Prefer perf_cpu_map__new_int(0) to perf_cpu_map__new("0") as it avoids
strings parsing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/drm_pmu.c   | 2 +-
 tools/perf/util/hwmon_pmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index 98d4d2b556d4..fc864bde4cb2 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -119,7 +119,7 @@ static struct drm_pmu *add_drm_pmu(struct list_head *pmus, char *line, size_t li
 		return NULL;
 	}
 
-	drm->pmu.cpus = perf_cpu_map__new("0");
+	drm->pmu.cpus = perf_cpu_map__new_int(0);
 	if (!drm->pmu.cpus) {
 		perf_pmu__delete(&drm->pmu);
 		return NULL;
diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 5c27256a220a..279d6b1a47f0 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -376,7 +376,7 @@ struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
 		perf_pmu__delete(&hwm->pmu);
 		return NULL;
 	}
-	hwm->pmu.cpus = perf_cpu_map__new("0");
+	hwm->pmu.cpus = perf_cpu_map__new_int(0);
 	if (!hwm->pmu.cpus) {
 		perf_pmu__delete(&hwm->pmu);
 		return NULL;
-- 
2.51.2.1041.gc1ab5b90ca-goog

