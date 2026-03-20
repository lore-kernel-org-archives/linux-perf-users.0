Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF293FE37D
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034949; cv=none; b=D3lnPMfkiPXnNCDGguqGMT/PnDRfdQbVbKnIvNdQlkkd7KF7bpRSrVdux7RYmj6y4VqEtFc1z7djuEeDLKyfg/QcG10rTmTXUdbTyXUEb3ZeaP597yev4d31SnMnJfDXWevxuTykY/VI8blrMl7VpRC6FI2YQ/YSUtEAwdxaAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034949; c=relaxed/simple;
	bh=1ynO/oOoS6OvSSaO5Mmpi750U3vI6vdPKQ2l7YLqtaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cDSsrQAhhaVHN3FSUc5MnwA3JF6xHBCALxS+XLuSDuhDZqwKoOWwqR3tpHwmgSjUm+TCX0CBF7Aa2gT17eixa4JBktymzczlqCjQiOx/THzc4yjum/eIEFbDHzL17h7F1N3h86ZDpg4Au29V0Prhuix7sljPTEnI9v5OK9e4gMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wleInE+k; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wleInE+k"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so904618eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034945; x=1774639745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncpa7z3u9YCuuwO82Go14Rs8JvlNmVnlodPcRsfxcRk=;
        b=wleInE+kDskoZsgRroLmRlt6Wkl7N/LjFXPI1vU0mpDPwRBuk6kKW8z/ho5Mz7p9Y5
         Z9SeTe426xdM/J+5nSmjUqsuOk36JTm1xAZ/Nw3loOb/BXHBFxjchKllLWbmHysdRzA6
         //epwGqi4PYhB8tq5Yh7MI/zjxPxgCipgFL71ttXDemONAlL8buNJJHbDBRJuRhZw19e
         hWBQU+oMiINjlBFMunSQUn7wVfBTefWg78SSv+nLYi332cxQI4alych3Ewo14UqfL6HG
         oMKDvsQuKBX35fjQFwqMT4g/ir+j7m1oOffDCiHLU0oaRmCFgP0p5XRPROwdpD0Xq55a
         UvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034945; x=1774639745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncpa7z3u9YCuuwO82Go14Rs8JvlNmVnlodPcRsfxcRk=;
        b=kCniM28SMCxbDnyyUlQOMUv02onTQDIyqDAGZGuB0K3L3V1m6oJDjGppNSmLkGphZg
         nz8qfrMxad20HLVAcTxHNzXAsxCfA4O89Aw8gc4VrjcE6ghdNwVBNVPFsLMVMsKvIrKe
         u76j+VXKy/1RIoWasi696kjQ59yTKDfFeqcg6aU/641Ef9y/TPP1pqed2OT3MV5zZmrW
         r/Bwq46bw286ghABHso99nm7rew53M+yP4Jn3SFThpG16jTpQhM/aA3eeUzM2O7tTfK+
         IDGY8CwVhb2FQ9ngFbURXb3zx2oHy1oNnfURAwDDeOxCqicwCJvg99BY4leIYKNjon+L
         ujig==
X-Forwarded-Encrypted: i=1; AJvYcCUVGG1rBZ8OW/fWU1OsUSW7Frf6qDQc86YRVp7Wb9s0Qwc0DmMqJzRUKMCOTpNaEBvurRDxl3DvizslAMQMOmex@vger.kernel.org
X-Gm-Message-State: AOJu0YxexQiAZeMIH2vPe57mZLaoIE/b0ZyRDBy7+iTkz4yg7Edj0xNJ
	TlVUYYSlTutw+ry6ZUG4iDsp/vr2TykPkvfYR7ezRwZ/PTbtgy94tbwKHaf8kPb0ere0FFE0QdG
	kIs3JgYqsug==
X-Received: from dynm28.prod.google.com ([2002:a05:7300:2a9c:b0:2be:6d13:4a01])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7495:b0:2b7:24ad:5c54
 with SMTP id 5a478bee46e88-2c1095a9bffmr1862388eec.9.1774034945350; Fri, 20
 Mar 2026 12:29:05 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:24 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-23-irogers@google.com>
Subject: [PATCH v4 22/25] perf evlist: Try to avoid computing evsel from sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

If the sample has an evsel, don't recompute using the sample.id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c           | 4 +++-
 tools/perf/tests/mmap-basic.c      | 4 +++-
 tools/perf/tests/switch-tracking.c | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b89ca48e5d02..faa422e35166 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1163,7 +1163,9 @@ static int deliver_event(struct ordered_events *qe,
 		goto next_event;
 	}
 
-	evsel = evlist__id2evsel(session->evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(session->evlist, sample.id);
 	assert(evsel != NULL);
 
 	if (event->header.type == PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..a18d84d858aa 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -142,7 +142,9 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		}
 
 		err = -1;
-		evsel = evlist__id2evsel(evlist, sample.id);
+		evsel = sample.evsel;
+		if (!evsel)
+			evsel = evlist__id2evsel(evlist, sample.id);
 		perf_sample__exit(&sample);
 		if (evsel == NULL) {
 			pr_debug("event with id %" PRIu64
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 22b0302252db..e32331fee277 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -138,7 +138,10 @@ static int process_sample_event(struct evlist *evlist,
 		goto out;
 	}
 
-	evsel = evlist__id2evsel(evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(evlist, sample.id);
+
 	if (evsel == switch_tracking->switch_evsel) {
 		next_tid = perf_sample__intval(&sample, "next_pid");
 		prev_tid = perf_sample__intval(&sample, "prev_pid");
-- 
2.53.0.959.g497ff81fa9-goog

