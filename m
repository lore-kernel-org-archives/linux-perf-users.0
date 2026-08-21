Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3E46985F
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305784; cv=none; b=ARXXbr6AaNpUyHG+hzyozvv8na+oCcaO/s2M+NKnmToGFZp8xgpEeAvl6GsWt96FEv6IufuQbSkeqt/na9jPGw2o+qVCxJsDH7qckgwXGMwiDhHNGgaJN3xM99ByLeLXdwGCJ2dlvUFCrcrT0TkaKx6tFoRUrLUnf1AjWrnGFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305784; c=relaxed/simple;
	bh=RecoXOCNMxrMx0zkiKfC1PDkmODYasriw0nUGDxsh8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WrlRE8s7aZjIsqLUjrz0Q33AWXW33nDR87YZnkH/uIuCS9y9hl3KMH/3B2Rq2HLl9yfpts4YXz4nrAfRv16LucWgktauLlZ1sryYq3Ec46oTWpWkbCfO96Bdk1aMHAvKXrKxYs1kW08v6EOThGoH21Mn7LVyjiKOy4W8l/FZ6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KsjdWvMe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsjdWvMe"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fd66a094eso272878f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305771; x=1787910571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcFhjwes9A89zvUuGgSpPmP9VQvVv75EU6Q8BfuMsS4=;
        b=KsjdWvMeIFX9sdU1ll+27diRGYXannmkx1oxidLQLoYhsgYdunjdNaxra7hwrjW1qj
         +YKlKQ35w3SCe9ArSPkhm6Hq1sAUXwSGyqerHyGmR/EC9v8zvpytCyXRtpDWnL5gAtcj
         i4YN0rjCRpFzc0//qYFdd+B0xjD06AS49SU+ZZzWpOOywKeBdqguGGRQ1cg2j9H9IDYe
         587n6KTZofTlYW3oIfoWC/svyFe0jTNqX63YkGtwn2xHscRLlA9FairwTegYMtmN1YaX
         HtjtVshcrw+CTdKTxBQNzhuYA9idqwUZ6c+au4PxpUpeNrkrOioh5u8cmu6kNTHh6vhB
         AS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305771; x=1787910571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bcFhjwes9A89zvUuGgSpPmP9VQvVv75EU6Q8BfuMsS4=;
        b=fYj1vLHnw1I1jqEIrVAXlPEyPUJn/8rQSZkZyH0Au8ONAh1G7PD4Vm+Bi1j/EAuS6+
         jLfgpzg56EVv3A3h5nOxwejKSuPWlce7dvayfW+6cEH7EZewsBTblbaIrpd8l7PFiXV6
         VAwJUL5uUKFR0RfOtJzlIbGCcGXHdllgpfQ+wYFaPUK2CSd7dvl9VFSRepm0oqORVNPD
         rF5Taz63KEAdb+ZoXepJz5yCNNVdpTGGpknRK/Rq7x4e8Y/7GhqMXiQI2pZU9MQQ744S
         tAUis5F7qlxn8xDbEk1M3EJJoax4JfFDwGnhUPdRSGLw8RFfrGrxhWVXIF0x8s0PcYt0
         nL5A==
X-Forwarded-Encrypted: i=1; AHgh+Rq8bWVzO8c+gVfIz8AMyamw7S1Xw0dOWd/H9SBNVdote0eMHEnUQX/tlnhJANyK1qRq/gJ46T5C00bEBuvSW6R3@vger.kernel.org
X-Gm-Message-State: AFuF++l4y7+3s4py2Ppk8ppAg6hiCMZYqLBqSh5JeY42rYlaz2Tcpg7w
	w0U9dDzxHLyjq+XM0dE+PM2a7gMHAqMHU1z03ytzIOdb90jcfY1qas7I3JxyFerScXI=
X-Gm-Gg: AR+sD13nP4rh/Uiano6GbL4StiNTWu/R2OwvY+PXRHqdthFLgrUo9qaIcoX53la+PQI
	rwir5THLfGih5mPDoiUeFIxbZ2JQnUUiuzig2rou4XhcCTcelh+Js0vpNFRR+VbrNPC2Dv1n4d0
	m8Id97Rptrn5hqxkJUIHxNw4CgurNvUb4NzsKaCkNx1Yt3hWMKDfPFrGysQZAgokdSdjbEiAl5x
	3N3YBZKTdTEaiAGTDlWX71YYC5bdwOf1WrtzuivTyA5LmJAvTn/KL/COy5hw0L3YPdd6fUKccvm
	MBPMHJkr7NWDPV4agEoAZ4AIxZkJXbOXKzAgyTTz64o6giNff1zFxPaBblGwnO54mrhLKy0pLWZ
	BmW1Ekbuy0QpANeOxhM/nPEptfsARenHWCKqqAZqW6mlsfM3ZkcPPEiq0/QNsgWxwjG12J+MTHx
	rePLXb6gdsZyGgesNRBCQNAfglM9M5SN6nxU0nrHadbjocBoyIJu3qboouLW9jlTgV
X-Received: by 2002:a05:6000:461c:b0:47f:86d5:d1d7 with SMTP id ffacd0b85a97d-482c0b63396mr7979910f8f.6.1787305771015;
        Fri, 21 Aug 2026 02:49:31 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm17683479f8f.35.2026.08.21.02.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:49:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:49:03 +0100
Subject: [PATCH v2 05/14] perf cs-etm: Increase default timestamp
 generation period
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-unformatted-per-thread-fix-v2-5-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
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
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
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

