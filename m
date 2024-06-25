Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A21802A5
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336422; cv=none; b=W1vtnwjaDbkCGa5t/ibIkW6wZVqNMWAAhoAB5ZzpBf5O7XBtbjLd5x/Ra5Sk77G5JdzeLWNF5UQjA0I224wu/RsJnGQRiaGmSrXgFDiLd7g1jHTNyRIc/nnAD8DCKV9NZ7BB9w6ayaLG2KOrawcejg7tU1Ekj0pNpHPsjI2Spgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336422; c=relaxed/simple;
	bh=2DeEVPLy0FEUT5ZAm0DKrKbPev4k7F682AE5BOrx02o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CCS0sQrzV4JTYelwCxMeqViUXXGNPKp7HSHveRityJzTzNcaOOn5FXhQO1xOAgcMtjwZhBpGudRNkXijLDOPPTId/gCJOBEmJJmjZv/AJezD231mw8OseH9eRB2/FmHjTvI/lRtIJ0MS/RKdYqSHwpHe36cDyiJ4KMhArSjfvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvCeEzBz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvCeEzBz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62d054b1ceeso120074777b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336420; x=1719941220; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6A7PaqIwyu4CU4GrB89ckL5QJWFy56tGr5i6+q3YuHU=;
        b=FvCeEzBzv4xEfgVFNK0k0NFftPJh/9BSppTSV+gR/RWdbcn1WU3DDMyshSxiYUJs8v
         GW0G11kcWXPYnkTo5pkFiymKeyl+PIyNrioaHllUm4lE8wvrMQ10jB84LA+a8xVIM2HS
         +/zILn0T3mV4XBKbVxOV05V+irb//yiNYcRRhzPyoxLiLEmi3XYGKj+nCDqUKieH4GjS
         notM1cZoFAMFxt83hJ+zgewhQdPojoMgU25vClkNXyXHlNvmWjbNjnVPC45ZqFiWnZZS
         PuKi0VNbxBtz0oVyIDgCvninOET7GDIRuDsU2WiDSiYIPTlAXJL855gONv65V5wpHYYs
         +lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336420; x=1719941220;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A7PaqIwyu4CU4GrB89ckL5QJWFy56tGr5i6+q3YuHU=;
        b=AFqSDSa9RfeWAdirF5PWOJfHuGES18SZCCw+YIX1+ZM9106pioAD1j/BYo+K+qZ1Oj
         L68BzcjrqTT59zBfaJCrCr9fFamO1NkRbj7V674gi5KuNERl3mBTLRMubQhNwAfaZczm
         u1/K6n2Jk/xJIoNwbnyISakfSL17gnBihdOczf1FoPedsruB+BGbWnFyZ97ofa93qvZW
         IfVVps/Uqi/u63gXjFM/uMHq6zST7CTY6C1R9RcyShzPu7OLAl3/3mPk5NYoBK2mwTAv
         6ZK8XUkD7EaeWj72jV16hnxI3dG94xbQFKydu6xIUOimy0hTkJ/8ePbybh7cZjmJPmUK
         kUqA==
X-Forwarded-Encrypted: i=1; AJvYcCUkyL13oRj1A/4yyKdzajDcl5fgDNJHSSa7TNxk9xwGF4fzWpFYyq1jKki3FZ4rhPu2Ue/L/CNqUEJvH9Ggv+5bpsnMBhe+dgnkVXzL1q8qVg==
X-Gm-Message-State: AOJu0Yy4hv5Qny6RaM3o/+SIytNxLLksIaljAElhnzi5Pfeo6MNZeXLw
	L1rKUx0gSbbL8ibLifZUCIEZSmt5StoUgxgH63ked4+fvfa3SRJusUXExcSwyNWFB5nhHKsWpEQ
	/CbFedw==
X-Google-Smtp-Source: AGHT+IGIWKw3wlhnYW+gj5sNzYIaUB7CqGMqyR/kggiKnBfYHZogEyOyafdY5n5VrvSu0dmMoUTAy5u3BnvK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:7001:b0:62d:a29:537f with SMTP id
 00721157ae682-643ac338f18mr3046937b3.4.1719336420093; Tue, 25 Jun 2024
 10:27:00 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:59 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 22/26] perf auxevent: Add explicit dummy tool initialization
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure tool is initialized to avoid lazy initialization pattern so
that more uses of struct perf_tool can be made const.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/arm-spe.c     | 1 +
 tools/perf/util/cs-etm.c      | 1 +
 tools/perf/util/intel-bts.c   | 1 +
 tools/perf/util/intel-pt.c    | 2 +-
 tools/perf/util/s390-cpumsf.c | 1 -
 5 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 70bad18c4a0d..06a198b2f483 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1097,6 +1097,7 @@ static int arm_spe_synth_event(struct perf_session *session,
 
 	memset(&arm_spe_synth, 0, sizeof(struct arm_spe_synth));
 	arm_spe_synth.session = session;
+	perf_tool__init(&arm_spe_synth.dummy_tool, /*ordered_events=*/false);
 
 	return perf_event__synthesize_attr(&arm_spe_synth.dummy_tool, attr, 1,
 					   &id, arm_spe_event_synth);
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 231cd833c012..02eb5b3eed14 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1619,6 +1619,7 @@ static int cs_etm__synth_event(struct perf_session *session,
 
 	memset(&cs_etm_synth, 0, sizeof(struct cs_etm_synth));
 	cs_etm_synth.session = session;
+	perf_tool__init(&cs_etm_synth.dummy_tool, /*ordered_events=*/false);
 
 	return perf_event__synthesize_attr(&cs_etm_synth.dummy_tool, attr, 1,
 					   &id, cs_etm__event_synth);
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 779982c478e0..ae97109542be 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -761,6 +761,7 @@ static int intel_bts_synth_event(struct perf_session *session,
 
 	memset(&intel_bts_synth, 0, sizeof(struct intel_bts_synth));
 	intel_bts_synth.session = session;
+	perf_tool__init(&intel_bts_synth.dummy_tool, /*ordered_events=*/false);
 
 	return perf_event__synthesize_attr(&intel_bts_synth.dummy_tool, attr, 1,
 					   &id, intel_bts_event_synth);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index bed35029e1f6..48ed60e521ed 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3687,7 +3687,7 @@ static int intel_pt_synth_event(struct perf_session *session, const char *name,
 
 	memset(&intel_pt_synth, 0, sizeof(struct intel_pt_synth));
 	intel_pt_synth.session = session;
-
+	perf_tool__init(&intel_pt_synth.dummy_tool, /*ordered_events=*/false);
 	err = perf_event__synthesize_attr(&intel_pt_synth.dummy_tool, attr, 1,
 					  &id, intel_pt_event_synth);
 	if (err)
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 5834bad6ac0f..eb835e531cd6 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -953,7 +953,6 @@ s390_cpumsf_process_event(struct perf_session *session,
 }
 
 struct s390_cpumsf_synth {
-	struct perf_tool cpumsf_tool;
 	struct perf_session *session;
 };
 
-- 
2.45.2.741.gdbec12cfda-goog

