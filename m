Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85B1F2396
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436592; cv=none; b=q2u3ASty6gz5piGNrTj95zKhLSslhB3FOnkMTO9ZfJFjkTxV7n7cwiYKsCphvHizrpPhLqlslU8JujNBKrdUzqN6eiiZaiLh+NozNJcdZUsxmHy4XJFg2juokVs6FleHW6/kGSaGsqHgBKFSYjMyKNR3sfXKVZuQTYKhpye39ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436592; c=relaxed/simple;
	bh=tpnlelcMbJ7A8lxnHi41TMdRMlFf/pMqWGQuvroX664=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/4ek9JEj8YBauewc2Ep9pwxXSp1UsoFgKPQW4P1ew7xU/ivtZRUDLuwDqN0sy0PJNETJn9Nj1Lw9J2+LE5GRxI/pOhHf9nKszYAyg1LwJrVxb/zA9TswY0vCa+UweAZvVl4cd1l0zURpyjYe97ALYAjo4btivt6KT1YMnP9L8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6QTUKrY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6QTUKrY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43623f0c574so36334025e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436589; x=1735041389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Swt8An6cH0UytiEm5BcU77Mv2Ddjr7IJCM9GFGK4Ig=;
        b=a6QTUKrYjFhtafekqJdaynKjbNhAAMY7O2v41wmwEQydeLW4sXdiVSBGWCMUBtHuy/
         pUaBE/NaN14J46TANmNMFzB/lJhG3vpWQbNCZZESmmPhSYdEKWXWzKPZU9E2tVQa8di5
         sla3CkmbrPdK+TDRlKbgVD8sFPgxZ7ObBY7OHwuKQ+5gYMO1DHNjRhZnYtSzZS2Au8rY
         0lCDgxnuafM/RnbSIRS7VCXW6la4MuhoRhU7ncrzATeQuur/ZfEX1mfH9fmEWk2FdJgI
         +i7hkkIPWLbeoTKV7Y3iEPcVzsrjh1OX+ZxgVf/O51K3fITcPRrtImrqGyWaBPy4aRoO
         kRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436589; x=1735041389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Swt8An6cH0UytiEm5BcU77Mv2Ddjr7IJCM9GFGK4Ig=;
        b=hlm2iFPIc2qOFm6kXV0izMoaa9gifJrKRjbTW2XytBY6M9dpj0GFjHqF97oOB2ZqGT
         Li+wGeqxRj9Lu3CQCkCvObfj/Sid5XoOnBxUB3lnNIjHSIg2ii5HYjf7gE1zd0YKN+qa
         Pi7AZJGWn11TehO/WXQo6t/2kYfiDwmQUZjRc9dBVzHtfY40etYRuP1DqNFet1X+co9M
         YYqCx9hdwtrSvbe+/9pHYE1xQH4sfSajDqkFDmhXuIj/TRNzh0Suro30XdGHtWRC+S8z
         S1JrhafVvP07rT4Ew4uYN7d7pH4QDKMyClUjlpvEf5d14U9w/42xuVihQWKPu1PBOPps
         N2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXt7ZuE7Djyutr7n1OuPM2QQSga9RavIz/qxJKzIi/PB3a8MwV3Q+8/xJvTJGd42WCQzajqKO9bB1KeYdawAFbX@vger.kernel.org
X-Gm-Message-State: AOJu0YwGuSyV81Xnrk8KSWh9CXJ3qz6JlHZWxieo0oVU2OA+ssTVi9YE
	Oy3l8o+ldGGN+xDrttd9jKe+qY9LihBJd8Ih24Q39UlBTcIJ6UlL77BzzoOD+4g=
X-Gm-Gg: ASbGncsPDp8kmxAF2Y5lL0kQGkt+qIPL7qS/MJcl3ooKpoaWM+j2bD7C6/bxIdJCz6C
	vM878r8NO4IJPI1O0Q1XxDo22iE74Ixz0oAAOrBZsbOf7VyZJ/Hp73i4V9WknQtEQVggjTdqWJz
	MC4aJWAVmK2KkicP73G5cwJCCauk1j8yBUsBnwqdnknSLVy/crkVowf3T9B2saTAlDE8v+3uTX3
	wQa12IXYzIuPCiiUrxVj2BoQqo5Tu2iuMGHoRmsQ1Ugy6kts4lXmAd5
X-Google-Smtp-Source: AGHT+IHYPBPQkQDRXyVGehPAmC7A1dmxHnikbhEhvzazvTv4q/sZtDwu0z2Pco+deD3aSmH2xXPBEw==
X-Received: by 2002:a05:6000:1f82:b0:385:ed16:cac with SMTP id ffacd0b85a97d-3889ad33ff4mr10801795f8f.56.1734436589050;
        Tue, 17 Dec 2024 03:56:29 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:28 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/5] perf tool: arm-spe: Pull out functions for aux buffer and tracking setup
Date: Tue, 17 Dec 2024 11:56:05 +0000
Message-Id: <20241217115610.371755-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217115610.371755-1-james.clark@linaro.org>
References: <20241217115610.371755-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These won't be used in the next commit in discard mode, so put them in
their own functions. No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 83 +++++++++++++++++-----------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 22b19dcc6beb..1b543855f206 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -274,33 +274,9 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 		evsel__set_sample_bit(evsel, PHYS_ADDR);
 }
 
-static int arm_spe_recording_options(struct auxtrace_record *itr,
-				     struct evlist *evlist,
-				     struct record_opts *opts)
+static int arm_spe_setup_aux_buffer(struct record_opts *opts)
 {
-	struct arm_spe_recording *sper =
-			container_of(itr, struct arm_spe_recording, itr);
-	struct evsel *evsel, *tmp;
-	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool privileged = perf_event_paranoid_check(-1);
-	struct evsel *tracking_evsel;
-	int err;
-
-	sper->evlist = evlist;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__is_aux_event(evsel)) {
-			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
-				pr_err("Found unexpected auxtrace event: %s\n",
-				       evsel->pmu->name);
-				return -EINVAL;
-			}
-			opts->full_auxtrace = true;
-		}
-	}
-
-	if (!opts->full_auxtrace)
-		return 0;
 
 	/*
 	 * we are in snapshot mode.
@@ -330,6 +306,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			pr_err("Failed to calculate default snapshot size and/or AUX area tracing mmap pages\n");
 			return -EINVAL;
 		}
+
+		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
+			  opts->auxtrace_snapshot_size);
 	}
 
 	/* We are in full trace mode but '-m,xyz' wasn't specified */
@@ -355,14 +334,15 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
-	if (opts->auxtrace_snapshot_mode)
-		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
-			  opts->auxtrace_snapshot_size);
+	return 0;
+}
 
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel__is_aux_event(evsel))
-			arm_spe_setup_evsel(evsel, cpus);
-	}
+static int arm_spe_setup_tracking_event(struct evlist *evlist,
+					struct record_opts *opts)
+{
+	int err;
+	struct evsel *tracking_evsel;
+	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");
@@ -388,6 +368,45 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int arm_spe_recording_options(struct auxtrace_record *itr,
+				     struct evlist *evlist,
+				     struct record_opts *opts)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct evsel *evsel, *tmp;
+	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
+
+	int err;
+
+	sper->evlist = evlist;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_aux_event(evsel)) {
+			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
+				pr_err("Found unexpected auxtrace event: %s\n",
+				       evsel->pmu->name);
+				return -EINVAL;
+			}
+			opts->full_auxtrace = true;
+		}
+	}
+
+	if (!opts->full_auxtrace)
+		return 0;
+
+	evlist__for_each_entry_safe(evlist, tmp, evsel) {
+		if (evsel__is_aux_event(evsel))
+			arm_spe_setup_evsel(evsel, cpus);
+	}
+
+	err = arm_spe_setup_aux_buffer(opts);
+	if (err)
+		return err;
+
+	return arm_spe_setup_tracking_event(evlist, opts);
+}
+
 static int arm_spe_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
 					 struct record_opts *opts,
 					 const char *str)
-- 
2.34.1

