Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF7F567B
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3FqjgaT"
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B677FC2
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 00:42:18 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-565334377d0so2117745a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697269338; x=1697874138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPjwMRuEKu2fsJk8eO76Y756wMaad6TrvFKtRdmyvgc=;
        b=W3FqjgaTUX+Z10b2sszwoijXfVfsbd5Ihyzcu6ETyB/T2qd4qJjlaWWTIRM2E3L2IU
         s72nNG4SpPaWGuU859X7P3eTLbqRT9YikLK0O8ZQpm2+hcXAmwBfLF3Ax9AbFR5sRbfd
         6lJzVeBcYAgoDeDVawaI0i3prQb5g53M/BMj4aq/apE4FnP8J64gE69Vq6YlQdO7ILKc
         Mh1z9IDYeSTL0SumYlUqEX/hgX3789aCv8fyV0VeoeAKjQ8VAaq2kC+adFvg8m6dl3QS
         +hM2wlhCT17194oApu3FIztjFATMfzE7vGi1lhEtCm2KMEs0y9dgWyC98kqLovJp4B62
         q5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269338; x=1697874138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPjwMRuEKu2fsJk8eO76Y756wMaad6TrvFKtRdmyvgc=;
        b=uQcscOSwFJcJAjgugn98WHvkEBtOOF13gIpV6H4gSt9aAtysjz9ltuW+AmqKOMsHVm
         GqY+ABEgHL+MFyjRmfQi+Xe/WNbCzNF5BisNrPcXIz8J1K9t+miOt1EdiuvWbEJWD6LI
         rdMqxIzKXvgjXGtMjOB+aMNaSLJzz7eurh67SWz8JXzdG4pvmII7impJlBrKLY2sIGuJ
         ml8lWAt2VcyLzlQZKjPIuBOqvR4QYYCuXyMK/8iEdx4B1TO3+Tud7SceRHyIikiirMAD
         Jxj2cZ8RCIHUYneWP0+/qFfyiyzdL+gLKazpWbTi/CKfJW2syJfxQTKNrYpSanzZ2S2j
         sUXA==
X-Gm-Message-State: AOJu0YzrLksAmWFzChLpyZArWLp7PaLxZNLAHDJ6ybX6xr7Vw1NrFD7k
	MMpS51WjCOPQIErSJar9enFA2A==
X-Google-Smtp-Source: AGHT+IECBCN/waMn4CVxWfjTHzRQM0vxC1enXmqkv/HTlH8YN6+Hz/gOIJlqQsRCWAKJZ3FI/AW8xQ==
X-Received: by 2002:a17:902:c408:b0:1c5:f0fd:51b5 with SMTP id k8-20020a170902c40800b001c5f0fd51b5mr36509701plk.40.1697269338131;
        Sat, 14 Oct 2023 00:42:18 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.106])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001c5b8087fe5sm4957319pls.94.2023.10.14.00.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:42:17 -0700 (PDT)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 RESEND 1/2] perf cs-etm: Validate timestamp tracing in per-thread mode
Date: Sat, 14 Oct 2023 15:41:58 +0800
Message-Id: <20231014074159.1667880-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231014074159.1667880-1-leo.yan@linaro.org>
References: <20231014074159.1667880-1-leo.yan@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

So far, it's impossible to validate timestamp trace in Arm CoreSight when
the perf is in the per-thread mode.  E.g. for the command:

  perf record -e cs_etm/timestamp/ --per-thread -- ls

The command enables config 'timestamp' for 'cs_etm' event in the
per-thread mode.  In this case, the function cs_etm_validate_config()
directly bails out and skips validation.

Given profiled process can be scheduled on any CPUs in the per-thread
mode, this patch validates timestamp tracing for all CPUs when detect
the CPU map is empty.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b8d6a953fd74..cf9ef9ba800b 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -205,8 +205,17 @@ static int cs_etm_validate_config(struct auxtrace_record *itr,
 	for (i = 0; i < cpu__max_cpu().cpu; i++) {
 		struct perf_cpu cpu = { .cpu = i, };
 
-		if (!perf_cpu_map__has(event_cpus, cpu) ||
-		    !perf_cpu_map__has(online_cpus, cpu))
+		/*
+		 * In per-cpu case, do the validation for CPUs to work with.
+		 * In per-thread case, the CPU map is empty.  Since the traced
+		 * program can run on any CPUs in this case, thus don't skip
+		 * validation.
+		 */
+		if (!perf_cpu_map__empty(event_cpus) &&
+		    !perf_cpu_map__has(event_cpus, cpu))
+			continue;
+
+		if (!perf_cpu_map__has(online_cpus, cpu))
 			continue;
 
 		err = cs_etm_validate_context_id(itr, evsel, i);
-- 
2.34.1

