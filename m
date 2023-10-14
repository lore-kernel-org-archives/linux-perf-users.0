Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA750567B
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5w6CmFj"
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E80BBF
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 00:45:30 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3573dc94399so11262605ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697269529; x=1697874329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUGayCjdfCKVMoAdEORZ5NxIXkJ/ofSNrTgGs/xtftE=;
        b=e5w6CmFjkySmPdLyRuMcoXlHko8ip3BpnpVLoHnVMBEQXVpNKnKhEPnFZfe6az2Ige
         cHqfsMNiWabdspaL2GdeBaZAWp2C2oZppT+k3kyS83waVxyXVgzbaxwMUUIDHNpnGbhk
         APLLUi1MA9sOCsdUjdgWl1Y7iaSGQBCOpynWO0Xv6zbp7GsJkKLmkWONh+qwIKw4+i8G
         LXHniKLVsNnaQCyT6+zitQ3obM2EaJGnYKmLy+ZOeNePTIAiWEof9z7qa478DzrkTxXy
         sG/eogQGdFzXbAm+6Pf3kFC8oDXui8y6W6kmR1N980doMzcdMjTkyHuN7iK0xa1mKsm2
         dUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269529; x=1697874329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUGayCjdfCKVMoAdEORZ5NxIXkJ/ofSNrTgGs/xtftE=;
        b=SQpv1haNS+GJAeX8kw6EC2L/Fme8BIjHlPJSBnC3gECGjYPvu0PlBXll4UN9saxEBQ
         v7ND9AXrqPANZhpI8cvudiKu2oKvi2PTZbhsClo48gMf+iDaNYakJkkXLDcFbicjwiCt
         5j9EZUpqTaKPCSnR+4lhRvezTft9+czqODVUGBMe8dnWEj8ynqmTmeK5voKgJDnXjKJj
         ERpSDn9+12iJifSV3v/lmnNCrcF2gaPdzvcGTwCYe5/IjP2EVEjQugiFvjj7JmzYbIBP
         cnm7o/rFVKNvICAi8YyRBZyapjowU0SqFR8rq4kR1K1Tz7IKlydFTQZF/wVAkmSpuS4g
         3m/A==
X-Gm-Message-State: AOJu0YwKOvlNSaDrk7TV1HJ3AynliK4FZir8kZLkk7JDsD19hjtttaQo
	ohTJEp4A0OUNk9U+UonCmtW9gA==
X-Google-Smtp-Source: AGHT+IFu4IpYYh0fEp9h0zOOlOY34CAXroKMc6faHAM0eY/L+xaLENO/R/YjFnAwiYbWYfOexjgEcQ==
X-Received: by 2002:a92:c269:0:b0:357:5234:802d with SMTP id h9-20020a92c269000000b003575234802dmr10535089ild.10.1697269529372;
        Sat, 14 Oct 2023 00:45:29 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.106])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902be0800b001c3e732b8dbsm4965124pls.168.2023.10.14.00.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:45:28 -0700 (PDT)
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
Subject: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for timestamp trace
Date: Sat, 14 Oct 2023 15:45:12 +0800
Message-Id: <20231014074513.1668000-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231014074513.1668000-1-leo.yan@linaro.org>
References: <20231014074513.1668000-1-leo.yan@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

An AUX trace can contain timestamp, but in some situations, the hardware
trace module (e.g. Arm CoreSight) cannot decide the traced timestamp is
the same source with CPU's time, thus the decoder can not use the
timestamp trace for samples.

This patch introduces 'T' itrace option. If users know the platforms
they are working on have the same time counter with CPUs, users can
use this new option to tell a decoder for using timestamp trace as
kernel time.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/util/auxtrace.c          | 3 +++
 tools/perf/util/auxtrace.h          | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index a97f95825b14..19cc179be9a7 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -25,6 +25,7 @@
 		q	quicker (less detailed) decoding
 		A	approximate IPC
 		Z	prefer to ignore timestamps (so-called "timeless" decoding)
+		T	use the timestamp trace as kernel time
 
 	The default is all events i.e. the same as --itrace=iybxwpe,
 	except for perf script where it is --itrace=ce
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a0368202a746..f528c4364d23 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1638,6 +1638,9 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 		case 'Z':
 			synth_opts->timeless_decoding = true;
 			break;
+		case 'T':
+			synth_opts->use_timestamp = true;
+			break;
 		case ' ':
 		case ',':
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 29eb82dff574..55702215a82d 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -99,6 +99,7 @@ enum itrace_period_type {
  * @remote_access: whether to synthesize remote access events
  * @mem: whether to synthesize memory events
  * @timeless_decoding: prefer "timeless" decoding i.e. ignore timestamps
+ * @use_timestamp: use the timestamp trace as kernel time
  * @vm_time_correlation: perform VM Time Correlation
  * @vm_tm_corr_dry_run: VM Time Correlation dry-run
  * @vm_tm_corr_args:  VM Time Correlation implementation-specific arguments
@@ -146,6 +147,7 @@ struct itrace_synth_opts {
 	bool			remote_access;
 	bool			mem;
 	bool			timeless_decoding;
+	bool			use_timestamp;
 	bool			vm_time_correlation;
 	bool			vm_tm_corr_dry_run;
 	char			*vm_tm_corr_args;
@@ -678,6 +680,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				q:			quicker (less detailed) decoding\n" \
 "				A:			approximate IPC\n" \
 "				Z:			prefer to ignore timestamps (so-called \"timeless\" decoding)\n" \
+"				T:			use the timestamp trace as kernel time\n" \
 "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
 "				concatenate multiple options. Default is iybxwpe or cewp\n"
 
-- 
2.34.1

