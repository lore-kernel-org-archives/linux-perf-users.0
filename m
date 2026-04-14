Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5CC30B53C
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189542; cv=none; b=MZRgJQjhKn03m8B4WW05jBBaFVb1Y6a+xJDMZnogpf14KmYXkeBrhcxCrGrmS9LYcaQfOemFT8ECbN+FlHYnBRWJCzl/1x4Ny/d8ePgsEvolvfD5VNCjWX+vki41RKgPFMuJ710jX4jhO80GqogpwxKiOH14Zta+j1USbu+nq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189542; c=relaxed/simple;
	bh=Kp2PfuS3nx2OUfVs93QelDdpZy3qsgDX2nFQbF4Fu00=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=c7iRkcmI2w0O4yV5g4yPZXyF3hnPqP+EOOvr+YcmqxNNxiOmIL2NltuXSF5+ZqfD0+WB/gi/bk3vevG9IxvLMUe/2+y/fqOf4AcH5YsrSDsEgzGGcxueER6ekcV7qHpGRX6PAKXUeIqKldY2V5z1s3wVaxwq2zoI99MgeJVMfl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEQcKwME; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEQcKwME"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c28353912so2171830c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776189540; x=1776794340; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QsDGz/PU3e42c9nl3NR4MaQvOT7jRTzsi7EmBj171Cc=;
        b=XEQcKwMEvc2yGq3D9mlqkiM5rbu8wqDILIDS/+QbfbN+OY1P8uoStMsbW/ei5mOlyf
         AiRZa3dYiPZ34U3ChsQJfl1Dd2WNIvjdage2DZ4WC3Mm5+9Cf1CtFMsNhpyVHbkfCrao
         HjFJA/qLFKZ4eE/cMtcY7gaVUTsjaxLjVUwtJoCjLnAl27HzP/cNlkShkw79hsycAMWv
         XUpmyyVtCGQuaLCco+t13mEDPKXY9PXVf0eBbKhXSiTmIkL32YFgWi6h1eMoF+c257td
         JN7XgIbypV++6wcp0ZGh81qknn2rMMXiwlC2gO9I/nAsMrUSXQyO0odtR0D31q4DWRqv
         zJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776189540; x=1776794340;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsDGz/PU3e42c9nl3NR4MaQvOT7jRTzsi7EmBj171Cc=;
        b=JdAElB8lo0wT3tgahWFUumIdivNAdhoXdCYc1R1SHdtxIXpb4KjIRdn5UcDcUETxCr
         RotIn5FqWP3nq4AdyRu9HRfaNT+EKjp0MbP0e80UfW1h5Fu/ZmdUTQZgOdf3rwChZQMX
         ZEJzu8h5ZAIhm4kGSEgmsfDI/7tzW01Rg82GTODNkF9pasL1u5j+7u/sRhEDqzlzB8Nr
         meZda2eKv69sJG3i6v7dhyG8KoZJMsOAueZr8C7u001MnZ0f+PvUKcSAlMnrnRYFFUpY
         ZwJEJ37wXexOfXkAwwXpGAUNnHHnzFtxRIgrXWiNMkyTVrDoYcXjj7QHAfu9PxYcV7SD
         raqg==
X-Forwarded-Encrypted: i=1; AFNElJ83xUWQ0T/mRV07YK1t/0AKdtiXRQPpjQRtvxqMNdhsOXslxfthZ4VBYR08r56ejSyR9qVHooP/IueY/GrEnXV/@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqX1qHSo+wcUF8tqa3afMuMy5Q3ig8vGITfmenzkcQB7/GqNo
	WtUTg5gqcm96IQMq3HB2n2DPPfNw4gmfV4YvgR1ZmK85HJfImhWyhhVcLcOTjeRLns8ijpgDbK5
	1c1mRIcJ40A==
X-Received: from dlbvv21.prod.google.com ([2002:a05:7022:5f15:b0:12c:177a:ac1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eac7:b0:127:33e0:ea33
 with SMTP id a92af1059eb24-12c34ede98bmr10388284c88.22.1776189539357; Tue, 14
 Apr 2026 10:58:59 -0700 (PDT)
Date: Tue, 14 Apr 2026 10:58:55 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414175855.2089482-1-irogers@google.com>
Subject: [PATCH v1] perf pmu-events AMD: Switch l2_itlb_misses to bp_l1_tlb_miss_l2_tlb_miss.all
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

l2_itlb_misses is a valid legacy cache event name, hence allowing it
in all_events in metric.py. l2_itlb_misses was also a json event for
AMD zen1, zen2 and zen3. For zen4, zen5 and zen6 the checking that
metric events are within the json was skipping l2_itlb_misses as it is
a valid legacy event, however, the PMU driver lacks the event mapping
causing it to be a bad event when used in the metric. Add
bp_l1_tlb_miss_l2_tlb_miss.all as the l2 itlb miss event (bp = branch
predictor, the AMD way to say itlb), so that is used in preference to
l2_itlb_misses when the event exists. Remove l2_itlb_misses from
metric.py as the legacy event isn't used by any metrics and having it
is error prone for newer AMD zen models.

Fixes: e596f329668e ("perf jevents: Add itlb metric group for AMD")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 2 +-
 tools/perf/pmu-events/metric.py      | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 63e5098606c4..ee5381646a8d 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -287,7 +287,7 @@ def AmdDtlb() -> Optional[MetricGroup]:
 def AmdItlb():
     global _zen_model
     l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
-    l2m = Event("l2_itlb_misses")
+    l2m = Event("bp_l1_tlb_miss_l2_tlb_miss.all", "l2_itlb_misses",)
     l2r = l2h + l2m
 
     itlb_l1_mg = None
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0c41a502cf21..c1931b2a5170 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -25,7 +25,6 @@ def LoadEvents(directory: str) -> None:
       "cycles",
       "duration_time",
       "instructions",
-      "l2_itlb_misses",
   }
   for file in os.listdir(os.fsencode(directory)):
     filename = os.fsdecode(file)
-- 
2.54.0.rc0.605.g598a273b03-goog

