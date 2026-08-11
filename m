Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF763BF662
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462257; cv=none; b=Y1dpwlkLLW/0V84RJdwLOQnj0bkRIcMOvGmWytMXznGkank0kMZCG+sW7GAsclsNjT5rUA0CvdVI6d2VnL4QhOIyEIS1v6fwpehbthuboJPHTBoDulg8V+7MtUkGK3eStehVpdLojrVQtYsv6AOz2GVoTzT+rHpYpuGOMbzXeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462257; c=relaxed/simple;
	bh=RecoXOCNMxrMx0zkiKfC1PDkmODYasriw0nUGDxsh8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3iF2wrjdNvShhcgFHADGx6/XEqFjP44wH/6qZj8ZkT5eVXQ7WV7zgDhhkqiTp43xCBzRSssM3MFzBN6j5EXOegTf6lElXEa8jbh5ZyHeRi57K1NbPnSDO/Ry+2hw+nExWA8wdM8OSu8ahnElvy/x75UIsCBARcgh7wrD+Pr5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZMP7qi/M; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMP7qi/M"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so26616485e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462254; x=1787067054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcFhjwes9A89zvUuGgSpPmP9VQvVv75EU6Q8BfuMsS4=;
        b=ZMP7qi/Ml4GGGsBS7z3LLDHfKN+et54F6229HiDUdRPP+B5uniM5URGlOx6IOTbXf2
         sU5mJaOFh2Hgnq3otUI/Q+rBwABMHTPA7rS42v3x2HK8QEpGI8Lb1lSbc89uhrmJjX/J
         2QsQKHhqIoR+GOCvL8lrutwVetj0cvK6RGD7mBGXOj+J/W0MFylgviomZx5/IyLr2YH4
         UIgSnFngWmLdBm5aZSXuOQf8i8buBJfDvzLyvDqCe6BPSAq9TuXW2Kp8cUN8n6UWygrb
         ELmfS26FlAQANTU6DBKzBTJqLZ+3KkjVOX0Km0sAkNgTPJEFeaB43NXv0dFuBVK/tujQ
         tudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462254; x=1787067054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bcFhjwes9A89zvUuGgSpPmP9VQvVv75EU6Q8BfuMsS4=;
        b=jmkXFpDJnLOaU1x+bQdHru6zs+6OCPA94DaK0jeliPlEiRCXiYk0AlywPhI5Nvi/hx
         +gzVb/8PgGe7vCL/q2aMf64j3gOTZvBryEqt2ApS808wdUN3aMYGw5cRSxcruvee7u6w
         KTmEu2/0MiH51CWPb1DoLjtmvfnEM4CZCEMr8gtKSF3Jhf3Ja5uUedgt5GvnV02CKD2A
         HkI1zDfVbr0rEBjFbDOjUS7IdnEbHmx4/Q/11FMDNOgcSwpGoax3ivVqrzaYp3iqN4pp
         knM5nft2n0LZAEjXXeuLa/3IUW6ZkWT1wq4kDq1iFGGh7zF/RgISLdRbCTvwGhm50tD0
         xHpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1eT1hWRaaoUnaYPcFL5CW09SkjxSb/lwyeSvM1HzhYyh9cOLtC3uAvuh2aErk2CB1i6puLBIqC3TfI9pFGAXo@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKiNOdT3O/XpSrsClLnQeXAY8MKBoDjhu1iCYGpi9CEDN74Wv
	HelieWfhGbt6nrfpVlWVy7mTiVaPvDFlF5zEB3yBrSdScoX8mIRaAEN6M97pIXtfgwc=
X-Gm-Gg: AR+sD13XwzMJeWE+cc5w+WdUHnGPSQvtFUlbdUCc9aL4dkNj6ZPDy2UjefWIRKO0R10
	O7PXfLQG0xN7jE955GBWWeieHZX0oijxSMwaobHsN8sEsMHuB7jxwtTk0H4F7XessBDh3Dm4+MN
	w/D8e0OMFzXpXOsfBmFCjD3v+NjLKaLsIC3I+mgSh/RxwpnZDv33Imv8/Fmbla/OpGcHyTgT2n1
	tyc3+7Wd+WvjEiCH4pb6URzykU/zj8oWa6schfp0TROGSrWkImnT+zm84HSEbtD3/ui1rUFN5R7
	qJQGCrV+n2Qdl185ruoYYz1JrfaaDCJHB4neO+ruMnY7Jz9XeC05ayn+TDp2HublvML2PtZkRRn
	DXjsGNab7nb/w5MRXJHgBwQCMbulo/5YUfe37x0HqmF4/dLttFZ5Hrlpi3FQDfyH6R4Qgsz+1qQ
	O41Ipwvw8buPOt/6ONnfWCFcRJ0qOar83gd2HUSyfW7SQ2EPl8zpd6a2DjwHMV/Y5Vza4dpw==
X-Received: by 2002:a05:600c:8219:b0:493:bacb:1341 with SMTP id 5b1f17b1804b1-4997842db6cmr72514755e9.4.1786462253990;
        Tue, 11 Aug 2026 08:30:53 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:30:52 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Aug 2026 16:30:08 +0100
Subject: [PATCH 05/14] perf cs-etm: Increase default timestamp generation
 period
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-5-90565318f5f8@linaro.org>
References: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
In-Reply-To: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The original purpose of timestamps in per-CPU mode was to roughly emit
samples in the order they occurred across multiple CPUs, rather than
emit all the trace from CPU 1 followed by all from CPU 2 etc.
Previously there was no way to change the interval from the minimum of 1
cycle, but custom intervals are now supported by the driver.

Drastically reduce the number of timestamps emitted by increasing the
interval, which is more than enough to interleave sample generation.
This reduces the size of the trace generated.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d0486a164a70..d36b7e41399b 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -70,6 +70,9 @@ static const char * const metadata_ete_ro[] = {
 
 enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
 
+/* Default timestamp period of 256 cycles (2 ^ (9 - 1) = 256). */
+#define DEFAULT_TS	9
+
 static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
 static int cs_etm_get_ro(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path, __u64 *val);
 static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path);
@@ -458,7 +461,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		 * Timestamps are required to interleave samples from different
 		 * CPUs.
 		 */
-		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
+		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", DEFAULT_TS);
 		/* Context IDs are required to associate trace to a process */
 		evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
 	} else {
@@ -477,7 +480,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 * timestamp tracing.
 	 */
 	if (opts->sample_time_set)
-		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
+		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", DEFAULT_TS);
 
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");

-- 
2.43.0

