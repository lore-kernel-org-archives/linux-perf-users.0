Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB161D9324
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Dec 2024 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037096; cv=none; b=FO2yfq6Rv81s4j8VYr906M9ctUcVuk4gtdgqsovyP0pMPrFt+waxe8+Gerqs+RAdvZ9hFhv0AQU+/vOEZykI+6jhtCeWHsDfoKNEO86ThyPP2uGBvu1UxH0NJYFOYNqyAQ5xi8MDVbz0yBghf+6xgoCWzHxXNhEhuT94VU0++9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037096; c=relaxed/simple;
	bh=RerMUU2iJNRvAH+P/WRIzJRF2OXWh6S/x0SNAoX8N2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJn2xgdu6vfauHOiuy9AabmU34DauypV+DmIvNzIAKfQAi7l7AmvU+UIE8GPu1ZN0FEvIQUkPlhS82DYMVy6IO1+fnvucdUQAIvjMEXxBf4B96sLqUpIf37I9rTfb3wnUvjlZ1gESyGrKZS8C41LyCAbI9fb90zDvR3L562LTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JoVoOiWU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JoVoOiWU"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385de59c1a0so2998075f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Dec 2024 02:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735037093; x=1735641893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwyNoR0SnuVGySQmrh3vEyVb1ET66P1aG6x3YnivKGw=;
        b=JoVoOiWU+LTn+LzaphtbuB4Uy4oRwIAX12TYoxTIyc99OcRv0k1xpgCYbeGRUQukqO
         9BC0T/W69NXtBNB8oxSdTsUYaMqVBU/eIwjInM/SutQGRFGmEYuO0/Pn00AisA5/bna9
         b8hz7lX+wYeObujE3ZP2+HMLlLXlaNzqVk5MKhsUTSVXm8B+ilfBmX3M6ZO9N8nrxAdz
         MW6B+BwJCdndxPaFQ3Q1hYTc6nrxeKtIssYKApNQGxpN6mB9rQfojH1X7grvoEeh7EkF
         tpKo4esC7tqLroFw4E13Dz26NWZQ7MmKiwa7hJ94zkun6Iq7mzP3Hxlw0VKKUrSVIBRx
         h6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037093; x=1735641893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwyNoR0SnuVGySQmrh3vEyVb1ET66P1aG6x3YnivKGw=;
        b=ElT86ZA9JmlccZ2hvJfnL1EXkCL6K+E/KykneVGXbnp3tDKCCuhCPjnwk2QafPGo+R
         tH8ODR9Z78TZK16+ikhQYdm88MwCCzv5xLV87C3prXZ6hp1sEnjvtTHUPKg1/xOOXao9
         wWOiWR3mGo+Ei+vVK+dDIZ/b05p29yVF7BJikRRUUnjUEnFm5z9TlHNGag3/MZ9fcy+Z
         E8TE7Uf7+4w5hpN5GrXI60Sgqq45amEbvLThlZ97PRVtReJllrl61KWTgnd4lB8x0Zz7
         WF7iYsE+f/d1VLKIffTfyywT/TtT4/+5Qu4pjPOMTe7wv3VZte3e+J4/oiz3CpO20G8L
         jatg==
X-Forwarded-Encrypted: i=1; AJvYcCUXLJNzNHo5U2e0XOty1I1tii6LAl7deqndDHARIA+BpeL6aMFcGE4kgu5d7S8qQVcn8e162awrEx6rfzAGLG0G@vger.kernel.org
X-Gm-Message-State: AOJu0YyeH1DJ/VKdtDmtF0wr4Z4i3O9VrBbXPEDHTPPV4aARd/PILNpR
	fMy0Syv7pENn/fQhsrB6dQtG7FZ3TStmh0T0xL2YYL1UAhB8FRRsN2YDxkK3FXs=
X-Gm-Gg: ASbGnctiNkQuOBgNB/S7Y9I6iBNqwC1kvfAwNocEYyImYC5M+Usvp8l9UlY6v5Rg4f8
	TSGrSkM9DwWkZludkUEAaSa0ryRPthUIWe2MqndGovye4CL2bp2BdRiWoIH2VSHxlZaf+pHMCOs
	sIzimocb3Xr/DK4UbNXXM/lmIhbKgggKABFdaermsrEIhBNpq6aRa9xooKBtPVlLWKuzebx0o3b
	KvArqeaDPPY++KEee26R2HYzMMOB+fvU7P9XK9nxZyQb9gUhXZ5vkc=
X-Google-Smtp-Source: AGHT+IEHX62hM4cRXueG3YQu6eg84405e7WqgYcT9lFPGrHLB17v7HhSKT3GSKfbXrWS+gmH7kk2Dw==
X-Received: by 2002:a05:6000:794:b0:385:e013:b842 with SMTP id ffacd0b85a97d-38a221ea331mr12569563f8f.14.1735037092689;
        Tue, 24 Dec 2024 02:44:52 -0800 (PST)
Received: from pop-os.. ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847714sm13938184f8f.54.2024.12.24.02.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:44:52 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 5/5] perf docs: arm_spe: Document new discard mode
Date: Tue, 24 Dec 2024 10:44:12 +0000
Message-Id: <20241224104414.179365-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224104414.179365-1-james.clark@linaro.org>
References: <20241224104414.179365-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the flag along with PMU events to hint what it's used for and
give an example with other useful options to get minimal output.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index de2b0b479249..37afade4f1b2 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -150,6 +150,7 @@ arm_spe/load_filter=1,min_latency=10/'
   pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
   store_filter=1      - collect stores only (PMSFCR.ST)
   ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
+  discard=1           - enable SPE PMU events but don't collect sample data - see 'Discard mode' (PMBLIMITR.FM = DISCARD)
 
 +++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
 than only the execution latency.
@@ -220,6 +221,31 @@ Common errors
 
    Increase sampling interval (see above)
 
+PMU events
+~~~~~~~~~~
+
+SPE has events that can be counted on core PMUs. These are prefixed with
+SAMPLE_, for example SAMPLE_POP, SAMPLE_FEED, SAMPLE_COLLISION and
+SAMPLE_FEED_BR.
+
+These events will only count when an SPE event is running on the same core that
+the PMU event is opened on, otherwise they read as 0. There are various ways to
+ensure that the PMU event and SPE event are scheduled together depending on the
+way the event is opened. For example opening both events as per-process events
+on the same process, although it's not guaranteed that the PMU event is enabled
+first when context switching. For that reason it may be better to open the PMU
+event as a systemwide event and then open SPE on the process of interest.
+
+Discard mode
+~~~~~~~~~~~~
+
+SPE related (SAMPLE_* etc) core PMU events can be used without the overhead of
+collecting sample data if discard mode is supported (optional from Armv8.6).
+First run a system wide SPE session (or on the core of interest) using options
+to minimize output. Then run perf stat:
+
+  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
+  perf stat -e SAMPLE_FEED_LD
 
 SEE ALSO
 --------
-- 
2.34.1

