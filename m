Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD823C5827
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305792; cv=none; b=W823i4hNjHd0Uvtw+dUYsaFEFPSstiVLcIz/st6z1xSl2s1Y/V8iwdyaTLa9OUCm3yVCDZkiXae9ZD1BuWbhI+9AKQk8IXL7s4YCHLyaehCO4mIRDLJ1jPdv763teUUF2iQIKfKdNNt4/g/fd3GMiMMdbzFfMw4+TzPyAwABqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305792; c=relaxed/simple;
	bh=fP2IfPP/3FxAZdBFPU46BWk56GVJBXw30IVSIBNxU7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HqZ8R26aN6VgMj9tfsNlSGJwzxfps8sRE3aI95g1gJgyvr9ku4ckNlUHxyBaekjJQ57WYeZHfHS+oq62/1kxVuYFScdzo4DlU7lpWetmz3DhFL5J4NQl0rFIgTGYmBJHzi1Ow8xssDzttPYGpNDIwZdcUrIwetMU1Zxc13himzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h/k48Rod; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/k48Rod"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4815bce4652so504407f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305768; x=1787910568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SdlWRdH/H8iL8QSy1QmXwkvjy5+5wNnPwJoBbpgZwJA=;
        b=h/k48Rodqxb3mS2n5Ozt4WGa7c1lfMDtzjRWobiRl0l0MDYLC0OrGu+r1yVZT70ad0
         9UhHiBGxBcQycjA/p7Ij24+e1ch9n66GHCuWX3CW5gPB4Xx+2kzV0Kah/StXUurroalM
         UVdQIUVBHj1FalGOgEt5lnVj/ou2/4/r+t+JJ2BQw6JHp+HWlOpv6YD3dvRyj33f2v8H
         +mkD7ey9aqaanyrTf1fffBLf0WR8FzwKmP3YIidPOzhCbIVRhdnfZC9r4EN0TS+tlFWY
         IA/6Dodk1EuNVVM34G9bX0+U8FUlt0ob8SHejSZaLyESAIISr8Ip2s+utvgtj9c9Dvvo
         Shkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305768; x=1787910568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SdlWRdH/H8iL8QSy1QmXwkvjy5+5wNnPwJoBbpgZwJA=;
        b=l8HyNxEkt0Ca79lGg/OyJ/3W2sQjwfv9N4d+e66HNW2ooPEZC41XO0pxsUwQueq+f/
         vn2Nt3QBvIfdJte/1ik4YQ5cK5otJZRUXSoBlik1/X92nQw5voJ6AoHf8dLwYsLdObqC
         B4Z7JCDk/a2HnTm6E1YchAVQFzsbxlQMHgBFO2NYwlqmHSOdhXrEExJF2VUi5MOgy4xm
         Jjp/kuP0uwc/v9z8zAH3KcGYl0FO9j8PUkU5YxoRChGGzZ5u4flYWtZoxbfJWot+I2M2
         PEeUl00kyWdeztK2lmNHqfiotbHu4Hz0vpXKjBNN2UjPBasXb0JZIiu+LNo+sXpV638G
         DVgg==
X-Forwarded-Encrypted: i=1; AHgh+RpTy860fkGcBSZUzn8u5ul0AMnZwjjMRGTA8/TuNcKOTTwQEl+LC+kVGZ/3cE4Ts+Up8WAXyF0SAuu/LoGOg71r@vger.kernel.org
X-Gm-Message-State: AFuF++mLMpMSUFVFPEF8qma7NemZaUbbWP2nTyAvI9zcjjX1P7b4ScZ3
	4yDK2Hq0Txmj5Yl4Q1rWFhMVnyRgBOBxKC/JOfR7j/foJXMK8p0PixwU1JyEUDtEO/Y=
X-Gm-Gg: AR+sD11d2vMQAMd8CnfCam6Phbj1xMp4DT5F+CYLEvuLLOuB30MYnSWzxIjtArxoBEQ
	paNxxMZRE5sS/Q3vTDR9M8coX9hiMK/oXbPEzycbM/TJher+0anZqq4Qn0eMUwyGeWNRZTqn41B
	gYyR11yHYkl3i+E2mg/U9FeKmPhg9v7480mJIPa/OgQQs8pumby+KG59XOHA0c9oQOiwKclRkfO
	7i8uY4bjIoi0RcpLpgHKbLLTeKfVNeos0A2chyae4Iq+ulD4OzFr8qQ3AlLZ8fXiSJ5p71PDt45
	046xnJ1rQ1yR09qO0er6fX3CIS8ZNwS6fCcUMX9jlfQ70glykUfzfc0BivySDenW22M44XdI7Yw
	4VvCTRLL/pcVpSuCbGHCHm2DTjDA8Aj2HUkfUGbn47re3dxGGi7gLTLWwplHvDiiuncYyc9vm37
	7nGmZgV0XjpK9pG4yDewuUcUuFpOr8LssgkT8+ZOPePbWC1pRQkZhhHrcHsUIOI2tA
X-Received: by 2002:a05:6000:1aca:b0:47f:86af:8fdd with SMTP id ffacd0b85a97d-482c0b588eemr5703982f8f.3.1787305768520;
        Fri, 21 Aug 2026 02:49:28 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm17683479f8f.35.2026.08.21.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:49:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:49:01 +0100
Subject: [PATCH v2 03/14] perf cs-etm: Turn on context packet timestamps in
 per-thread mode
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-unformatted-per-thread-fix-v2-3-00c4fd0701b4@linaro.org>
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

Practically this costs nothing and preempts future changes that will be
made to support decoding trace in order with Perf MMAP and JIT events.
It also helps keep samples in order when we add support for multiple
per-thread mode threads in the next commit.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index acfdb3f53821..d0486a164a70 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -453,13 +453,22 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 */
 	evsel__set_sample_bit(cs_etm_evsel, CPU);
 
-	/*
-	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
-	 * when a context switch happened.
-	 */
 	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
+		/*
+		 * Timestamps are required to interleave samples from different
+		 * CPUs.
+		 */
 		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
+		/* Context IDs are required to associate trace to a process */
 		evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
+	} else {
+		/*
+		 * Enable context packet timestamps only (no periodic
+		 * timestamps). Even in per-thread mode with a single process we
+		 * still need to correlate trace to a specific mmap around
+		 * execs, which can be done with just context packet timestamps.
+		 */
+		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", UINT64_MAX);
 	}
 
 	/*

-- 
2.43.0

