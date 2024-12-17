Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27681F4263
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436604; cv=none; b=Hg2qAxm1VhBRXvDlUUa/p3kNUodQOF4bjcUG4v/lKfXVubJ3HIlgG3Te5JZ1spmtiVR2UkxYgQHzkMbUeSSJEAu/eNI0GOHvXvILH2VmW13YtZfaGyfboBle/0A/jK2gtyA2N0xz/CdVr1/eQqDftGUI/l2l4wtRyzeVwMP49VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436604; c=relaxed/simple;
	bh=fyI0/dhbkFxqKd8iWh2Jzy9mpwkSrgNFZ+i9alPd06w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jg5xfIBmwcf2IUo/o5gJ/fE1SKX5HHFjEGaFHJdg1qDkAGN4hZRqVG0XNosxUBsDK/kNuxN//DC2rjFnvj70HqbdiVWhV8tRtA7Rs2xjuuGh0knPE70yMGuqGGuG28SwbyKR/FOOLII1B2yZISk4U2mVg0pAuGYy4fDl0+agCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WmrD2b/b; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmrD2b/b"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43635796b48so20317705e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 03:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436601; x=1735041401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFM1q7jsB7Su3lAVmgr0rlaLhCHhfoFOEst7jXnFLG4=;
        b=WmrD2b/ble34C9MwCDKzGxVg0vFLBUyrDuJVfLLw1rqm1qyUXqWiR4eOZbNAk1BNVb
         w4Jfgt14YAEDSRgePSBFuicKaAgUGvmJ9KwAjmlzoZcAyaMCeTIcWsakq8DZKghJYTTH
         RdTK+wh+fy0FLBLE1CNgxbjk/MuMoXFuOBFn+mGQMYKWiW1kkYesLDjNUohiIRRv42L3
         tEBnBEcZhdBHqtYPB2CqdsAuXKhNiySB36/XPUBHQ89xX+TnS84awpFdq5CEcJlr6M+X
         jGSfOJdqpWl7+gNYy60d/+FvDsWF+ezjMtjKNRe8YzoCgnw5JWBID5d1O+20jG16Uw+B
         YZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436601; x=1735041401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFM1q7jsB7Su3lAVmgr0rlaLhCHhfoFOEst7jXnFLG4=;
        b=jgqpNmtMhRQmuM54n1IjKpgbrxF9iKm18lQbrAIfOGlE2niYoUPN5amc5J+8r8+EaI
         nnG3qlgY/8S1ej1qpacX65yeO9vp/+KjxJdNrMuTC/5852me4kcLeAwuONtJZ7vhi9xN
         /FvqtOM56DLBbiegZCGk5jpewX+nCPYJxAI6sHIyY7v63nZyRt57LlZL5cN04+0Yg2Vv
         fC+UQ0FTAqsfpS9nWQ339leClyFcQPTtc5vEOd7+85BqWaunYyOa4o96OoOxbWWvBKjt
         kvpgJVSpEs+VGWaCou+S6x7/1KHlnWuOUV6r3YuuMaE1s9Y3+eurTYbQEeeRvUzh59N3
         M0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXmgwpXA+xUiKh/kaeSMiF9Sm+cGoEi2ml6puaeDFVJcw3ubUaC3wycj+ssjKbtCW+eWHLtMYB8D/XiSwOsSQra@vger.kernel.org
X-Gm-Message-State: AOJu0YwWphIgrLDivojtp+nbjsfbIdcoQhpOQlHvP57nU9hi5wjothAN
	EgouFA1/3QSFa9bM2kk7iG9shf9U73cY8aGS6OOnK8qVRHlXAvYkiPcFtfKo2w4=
X-Gm-Gg: ASbGncv+05kqx4yiw7pTbx51fGdctqHWk1LZIJe7QlOiVvlF31usOxegxS6BuSz2hEh
	6YkXpR37X36h+/+QiHt5ET67iQmIobYOK8wRs78VrrBup/nOmtKeG4E2QxRyepg4kBFwcBjdHmu
	fE9gdUUDesN7y6lSk4PEXxaV0wMlXftm/TgHI7hCFDdRAe4nmhln/sIpMggr/cRVTXxQWVxHsAk
	GjUGf2P/81zIGo7LrlW5htIyP2UnsUIxW1fzpWNqnEBNusymxbRmwxv
X-Google-Smtp-Source: AGHT+IGHK04q5y+mpaaNrdicK1T9ozCfgAnXqS1cmz3u3H1E5qAKa1r9yR6aB/fLQM8NPU3JxtkxJw==
X-Received: by 2002:a05:600c:3516:b0:436:1b77:b5aa with SMTP id 5b1f17b1804b1-4364815c7d6mr27745645e9.8.1734436601097;
        Tue, 17 Dec 2024 03:56:41 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:40 -0800 (PST)
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
Subject: [PATCH 5/5] perf docs: arm_spe: Document new discard mode
Date: Tue, 17 Dec 2024 11:56:08 +0000
Message-Id: <20241217115610.371755-6-james.clark@linaro.org>
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

Document the flag, hint what it's used for and give an example with
other useful options to get minimal output.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index de2b0b479249..588eead438bc 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -150,6 +150,7 @@ arm_spe/load_filter=1,min_latency=10/'
   pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
   store_filter=1      - collect stores only (PMSFCR.ST)
   ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
+  discard=1           - enable SPE PMU events but don't collect sample data - see 'Discard mode' (PMBLIMITR.FM = DISCARD)
 
 +++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
 than only the execution latency.
@@ -220,6 +221,16 @@ Common errors
 
    Increase sampling interval (see above)
 
+Discard mode
+~~~~~~~~~~~~
+
+SPE PMU events can be used without the overhead of collecting sample data if
+discard mode is supported (optional from Armv8.6). First run a system wide SPE
+session (or on the core of interest) using options to minimize output. Then run
+perf stat:
+
+  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
+  perf stat -e SAMPLE_FEED_LD
 
 SEE ALSO
 --------
-- 
2.34.1

