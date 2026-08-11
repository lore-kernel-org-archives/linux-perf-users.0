Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC43B71DF
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462254; cv=none; b=bRcm272CnU3er8T9lvorZmQHEN/Hqp0NSHNnOX50jiQ6W/AGIG4qekVyi/OxZ++wEEZwhbO8edQojRz0SNsix/cIl4YtmVOkO554AD38DDlR1tZ9jvk2HtakCOn0nzAI8lUChciOMAtaKjUlu9EAR9I/zxtqYBBXm1+ID3nQYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462254; c=relaxed/simple;
	bh=fP2IfPP/3FxAZdBFPU46BWk56GVJBXw30IVSIBNxU7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3zBd/8A/NUJDcg3wzlIPBNhLUIGJ2l/wN5qv2esIyjEjg2f2apV3IPSEIzQp6gYyKP9FdlarcAgcb9DC8KsOLIZdHMxx5ObmmccJjIstLpSTbFgWh9PlRb4h3nnUUlt1+0SlDcPcRzKeyoyxriyA7aKV2KzDlGn7KAJtrkjzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qByNlg0R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qByNlg0R"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49954b88fffso35230715e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462250; x=1787067050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SdlWRdH/H8iL8QSy1QmXwkvjy5+5wNnPwJoBbpgZwJA=;
        b=qByNlg0RehNdU0PIGepICwOUkqvYcrNh7Rz8af9UL/+NdixtzxN7mpIQqt1x2Ksolp
         VJB54Fn4U253Sqcb2FQ+SZCcsdjhpKT5TEVQKivr17ziZ5fpVDRlnQ7hHTzRUFZpLlPp
         MCZsPdUtROdqS0P+9aaVCRbY4zPpCe/IaQTy5THzbcJhrwNMMNiD5ijulHAYgrLR9yQ1
         upSPwRH1ydIGraK8WhRwqjiRlCo1+tBqP/Z82mFZZmnmN9rGQmRMe+MpbSiy62xzi7An
         826RUgHLvWGmG4N8mkPyeBTZGDCzi5g1vxMp1FQTYgNhnQL/U/nmgCdrolaYOcM64uzW
         KQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462250; x=1787067050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SdlWRdH/H8iL8QSy1QmXwkvjy5+5wNnPwJoBbpgZwJA=;
        b=UV6alc7hXVOzF7Qz1PH3OOcJZTAAs1umNz1OUTjbuw70gn1CRK9XySi2VO2ZSEMfQD
         +3Nfg0qxNn4iiM+bUglQhK8sBYuyqdLnFxFDXkQVBtVLuk2LolW54wTb3dypZufr9s3c
         JImEM5bOITF87pVG670RYbHxuLM+2NuNpIe7oaPnyX6IFDKNOLzLyaUjJEyqjkja8yjD
         LDYB3emTE/yK0/BEIyN779AzYm9/2c/APupt2ALuGOs965ZQGCkjMb09krGLtZp8KFkG
         4gdFd4++V1xfasvnjjYPt0Bg5AlG7fVp72tHeQJM5SJfyix3l6OVzz6gGX+EtVW2IZom
         31CA==
X-Forwarded-Encrypted: i=1; AHgh+RoXHQ4ghPWgTNvsIDIMJOgdjJYhYa69kPfX/K27N5gl8SEhgUMcUPSi6Yn2pjh5hFPdUpW0F5hhhjfBpFfuRa59@vger.kernel.org
X-Gm-Message-State: AOJu0YxuaZE6o7XGqJ9qbK52FR8fZA8fqtZdmMVRwN2BxsiJDLr/1yjC
	ee5s2E2/C26D97JwPFk4X0j3yAj06KVI5cejN3LzFGgW7GRSU7M8HyxSGWD7EDBmP/c=
X-Gm-Gg: AR+sD12wQqCcfte9PRnel9ny1x8Duvt1c59JDWUdEYW1skVLKAPq3W2FTuntEcY73je
	O/gPqKpdRDLM7PRrfHL/bN1j49eECgdrgHNYcTFpXpRO43iwx7CCtKMQ0zn+SvtiDo7LZivcKxW
	VzOeufEEnnPxxVNhDxddMCCfxA7TZ7EjRMb6ZMjEnJl9q5h1ZolEbQPLpXGSvwInWASsh9jmvs5
	CY0oCvD8lM4hAtFE66Z0Z51UgTOp+mI2X4sNYJ2Y2yd0pWvMTGvh9fK9DzVX8OIVSb0vxGzceeJ
	VS1kAY1B+dj84BMp0IJylaeMwHx9bMNwiUYmDfo7G6OK4ivDllk/iYUpa9J0dKIVy21HBYK1Agw
	H9IQupAlwTYZmHVC5fci95f3nKR1FpJ37z+kHcOIZuj+ZvfTvVp/mWq8i/PhVCfkZ+I6hS+iDIN
	pA12xwdKuds//RPbQA9p925gMkhQiO6OPGabrY5jV4fyUf1himxtA2v5RwxHfgM7/c
X-Received: by 2002:a05:600c:310f:b0:499:737c:ce4c with SMTP id 5b1f17b1804b1-4997843703cmr53727915e9.6.1786462250133;
        Tue, 11 Aug 2026 08:30:50 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:30:49 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Aug 2026 16:30:06 +0100
Subject: [PATCH 03/14] perf cs-etm: Turn on context packet timestamps in
 per-thread mode
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-3-90565318f5f8@linaro.org>
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

