Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2033A6F3
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839477; cv=none; b=cViGYDCUECV1Rjez10DoN8BhC/hFRcJ0E1qGqoVtJB1sas8zft7EuX8xyC5f2inu7vMIEao4bodzEzHSWFyEUlW7k4IdKazIB7zeHX32mUXHBOP4gyqXFA9ZO00S72y/ZYlxo6F7gmAK/bowoQM0SgpGWwgNn6p/lLfG0lCUnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839477; c=relaxed/simple;
	bh=nXoX/KkEDD4WgAlpkopzYz76JHrEvu6uyqQSE3EJk3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbwP/3KexanT25o883+5p26PzL+GNuMB1N/Cwp/twoBD8Oakr7WW94l9pjYng4O7MQmRfCfWIH565W3qaUdi10LWAG2su9pkkE5TR9ErY/fyGwCmKhkH457/4KNIDAdhrknEYNz61J5phB9APVRZbr5lUUzF7JTgw4pNnH9b3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RCTEfVmB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCTEfVmB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477b91680f8so6609065e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 01:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764839474; x=1765444274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwGBYjKOBvIUB64b+mlhVfmQWWJY0YeMY/8ci8MwFyI=;
        b=RCTEfVmBu5zlGG2QcbVCgPEaJ99v4g7ajTLus9RzVfZiU02bD/l1pHtKQFclPyhzkT
         EMHqLOX6g5xBs6XnZKv4YKtjuwXOalRD57fQlJNCMhosFRlZQ7L1GwHOwGKHmBINtZtu
         qdP+RR3Q2b24yC7DCnpd3vjOVepVJFLLlHKSCSBZLfD1oAmSNyDIaXIbyp6KCQOB6UR4
         00Y8NsJIiwcWLp7dVhEkMVrvEzExp5skfrTj45M1Et7RWPWDGaGOQagvivOnVN9osMAQ
         ONejcpP7RxNg/Nr/zdwEtxMrDjFcXkjy5ggN4TqCP8OqMLAZcGOt00aLPiUyCTmoylcg
         q2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764839474; x=1765444274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BwGBYjKOBvIUB64b+mlhVfmQWWJY0YeMY/8ci8MwFyI=;
        b=GPcVcOwanLJwGAt3hnxcrIJWSDz+1qnOyAK/V9nWNkFTB2HL0Y965Lz4CsHydduT8+
         dkaPz8I+Hz/PET1K/lJYz4cfLZhWvGrjYBiaxvH+EMQBrmiueKbtSx89+4hXDX/kQst+
         w45tiQJ3cLP1nraTsdG1R7AjZFWyw9FjfuUhpGsEVEIZ7eClLYR4Xaghydg1IqAc/3jL
         544Gj3mxYz3p+U/kSSccYqRBIjc25KjT84aHuhk7kAS7kHz2LU7QL4aElrGXPR5WJn0L
         oADMOCj9SO4NXCwmJG0zZ85Oa7uMF/f0L+SYDqsPdsfpIrBqpgtw5+4uyLWjeKxh5X3N
         /Wzg==
X-Gm-Message-State: AOJu0YwALjSJ0TxFvBXDIhQQ23dh+LkOjLBOVFdZGZreF2DngYyW4Hb8
	y3F7DR4ygMHIchICZ4cah8VRl9UoIaPoxfcM9S7pWUSf1oRU4vlz8tgAnWT7d+aYpy8=
X-Gm-Gg: ASbGncsy8gnqRTfG9W9y+hti1/OKWzNuAifrBLtjdcgbN84h6oGop3Osg2xwH+JeMis
	lEoXfnbPBVbDxb1buBFF2fvqOBuMFjyvd415YpxBogBl9IGUZ2w4NeovmfZbbxLiSY3iRJiPXiR
	MGcO65lXxYemyVWi3PhqJbFbroRd5+LjMwjIkFFzif6cpp4M9kyWtXhnFwRLUzVvggMfS/SHdPi
	+NJRsxV7fciXJvQC+TriS9ShFeNJuNJJ42aeE7nZOTT+V4OJiMwk3mjciFeGQdxDrosNiJ2bwFG
	R9EiZuPGC1haKH2YiYgCR5tnp6fj1pni6Run1nujmLtHUB7dvqEJAUm62KZhGmOvyomLo5By46T
	wOvdmVrBk91R0vO2fkukrQS8n5ajZVXAbKVJC7OTEqWULClOKuqB+vqnHF8C7C77sk5O3BCHmUZ
	eWMyzZCq5w2p2CG7vsTS8Q
X-Google-Smtp-Source: AGHT+IFR+zE0yxgOVwcKFg/YXz3pkr2Mp2pA5PlhNSGsQxaQ4xghRizau0SyfTU1m4OVsPW0+kyzLg==
X-Received: by 2002:a05:600c:1907:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-4792aef70bbmr69278005e9.15.1764839474288;
        Thu, 04 Dec 2025 01:11:14 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b157783sm38720515e9.5.2025.12.04.01.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 01:11:13 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 04 Dec 2025 09:10:53 +0000
Subject: [PATCH 1/2] perf tools: Always uniquify event names
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-james-parse-events-test-v1-1-e6f922ca395e@linaro.org>
References: <20251204-james-parse-events-test-v1-0-e6f922ca395e@linaro.org>
In-Reply-To: <20251204-james-parse-events-test-v1-0-e6f922ca395e@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

evlist__uniquify_evsel_names() only gets called in __parse_events() if
verbose is > 0. This means that the auto added "slots" events stay as
"slots" rather than being expanded to "cpu_core/slots/" unless Perf is
run in verbose mode. This is invisible to users when running Perf stat
because evlist__print_counters() always calls it regardless of verbose
mode before displaying.

The only thing this seems to affect is the test "Parsing of all PMU
events from sysfs" which fails when not run in verbose mode.
test__checkevent_pmu_events() always expects event names to be prefixed
with the pmu name, but this only happens for "slots" events after
evlist__uniquify_evsel_names() is called.

One fix could be to relax the test to accept the non prefixed name in
normal mode. But seeing as Perf stat uniquifies unconditionally, make
parse_events() do the same.

This fixes the following test failure:

  $ perf test "Parsing of all PMU events from sysfs"
  5.2: Parsing of all PMU events from sysfs                    : FAILED!

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 17c1c36a7bf9..50e88c9d3d46 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2217,12 +2217,12 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	evlist__splice_list_tail(evlist, &parse_state.list);
 
 	if (ret2 && warn_if_reordered && !parse_state.wild_card_pmus) {
+		evlist__uniquify_evsel_names(evlist, &stat_config);
 		pr_warning("WARNING: events were regrouped to match PMUs\n");
 
 		if (verbose > 0) {
 			struct strbuf sb = STRBUF_INIT;
 
-			evlist__uniquify_evsel_names(evlist, &stat_config);
 			evlist__format_evsels(evlist, &sb, 2048);
 			pr_debug("evlist after sorting/fixing: '%s'\n", sb.buf);
 			strbuf_release(&sb);

-- 
2.34.1

