Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF82F3C1A
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333444; cv=none; b=JxOnfQZtQQegbTdRwbyDEz8xemC8j3HSY+MPuvM0iyhgnP5C88Ek/diIio436xf8OExNiPXJ7XOVCDzvXvQtE1clpJOTXgjYHSoThkPFY/hjreMQZlciWmoPLzXI1M7D3GEullEzt4Go+vB//DD8ieAGA46UW3t/2K3TBbMu2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333444; c=relaxed/simple;
	bh=0kvhJTYzI5zCuQfF6zHXAyfebJa9RB+TyZLC9vyQ/uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BsHOvewK84xJ/Bvof0mp8UgXaY/bXYjxvKqMmmMtzyAPBPpy9I1Gxto3uK7bVXCAF91CswPWtG/M1r6OxQYf2Pj/QDpUchKeNoilzgi3E3LJkUDPu1q1WucyKXvcNxSI8Ml+wAstoYBZlDqwv4U4xVLQehjWPnyd4nMfqW0KKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uXlSsaNS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXlSsaNS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e537dc30c7so2652766f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333441; x=1757938241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPsz3uNLgOVT7SPTn9Igef5H+k3XdxFXx7NJztU0cBc=;
        b=uXlSsaNS7MAonEGjFPCTZKCTM+htf3AmuTfefpu610B9qcvKn5ZfrcTFeL4ReI5EDD
         eHY9JMhSiy2REgv0/HdTXiv/8/nIxwmm/sU5sGXb8HvXawhivDK/ZvusVQkLipeqRh0z
         pqCVeY+bsNrcTHsy1x4xgG1pSaugUHw2cYLCG8iBwEQNpVPWUHWbDNUlZXGvcqfehTwr
         ZS1cwnNB41KhFOBei9vrYMbyIhe3aw1ob4oL/Dr1waKrP0IjRkMmyn2vL9To2xTL20Wk
         ifZjodOYtHUvuE8D+gpV3enYmAJ7WvlSAkg1BEkrvHlyhlEFi+DHM6/cO6D9lAFnMVKW
         hysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333441; x=1757938241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPsz3uNLgOVT7SPTn9Igef5H+k3XdxFXx7NJztU0cBc=;
        b=lPPZb6jCF1uIrGzrqWETL3VQRpv0ASSRJhsFis+AymJbLdojbv7Vbjyhx7HELn//JA
         b+AjRId/d/j6UBdpIc17er9MxzyPDMLU5J3HuAsgUDPlRj+s/6ypg0alFrsH5veNnD4W
         eL5eOFXUp7YWLMlnWyCQeuird88rqTdm1Izy4BjWwaU8AxrEvBJ14PW+S/9NW9oxfha0
         QPoS9yr0oYNRoyfGrFejvQfjgn5hFXvg8yR5JW+xgYM5SAgsKWwbE9UvHJ06F2NkanKW
         sHLiktahfoJCwyasbdBi7fNX5NEqK7k7F1BW8uCuQEfOjYYibvj92SlklxpebQ7blAWA
         2PIA==
X-Forwarded-Encrypted: i=1; AJvYcCVSAJytbckmOROPzbtqtwzD21prp2z5rKP21XefmOoIhx923AUB1VX0ewjVC2RcIzEf1nh6Fn4sI6pN5FBaDdb0@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxKG1h5MrQ2nbueHKNYSRHPHz0hA3Vht52jiCXIYBLFytYM+P
	+lwZxWmbxucxeRbR8scA1X4+4722dXcWXgm561/HIrYul04JZGu9TPc48bYIMT++eCo=
X-Gm-Gg: ASbGnct+oLc5SA8DV1x/SqXT2OnpoClmUYS+Az/P6Gx8lo4p5g1Ij82OBSosRdwoakc
	wMTZK92xJ+pu6d5YUAFNKkfH9x0nFe0lWnGntMFX9hDIQzgKIFSDBFh3ZG2BxD45iqplhZOBdE+
	1sga0MD4qVlQ+bnks/RiUt045Znl9Kwz5IIMYgiBdLM/pxHd/N3B8KBuwLKQCfQb/b2DIqn3guj
	esXiONpA0Nvqwj2sQlG7VkS/IM0+mBf/jKrgaz/eVnYLTWHdUf6n8LrnmhAk3SP9NfIF74iRY52
	HwqcjbdVwalBB7anhiZZRMd0qDM0Wy27a3/Kl3QqVcSNrTaWnPCNSz1vLhXSFxXIn1/g2fk21cv
	TDjBVt0Mdczz6Kr3roDBDWnAXVkn7RJyZ9stiCKKDQw==
X-Google-Smtp-Source: AGHT+IFAaqKpjwj4aPOKWJLqNnoA3Btfgww5j5z05x/U+gptVrld/EgQZppTeTjJAuYETx5PqyHeFQ==
X-Received: by 2002:a05:6000:2489:b0:3da:37de:a3c2 with SMTP id ffacd0b85a97d-3e642cadf51mr6040771f8f.24.1757333440672;
        Mon, 08 Sep 2025 05:10:40 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm41397825f8f.50.2025.09.08.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:10:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Sep 2025 13:10:18 +0100
Subject: [PATCH 1/4] perf arm-spe: Show instruction sample types by default
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-james-perf-spe-period-v1-1-7ccd805af461@linaro.org>
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
In-Reply-To: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, George Wort <George.Wort@arm.com>, 
 Graham Woodward <Graham.Woodward@arm.com>, Ben Gainey <Ben.Gainey@arm.com>, 
 Michael Williams <Michael.Williams@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Instruction sample types are enabled in the default itrace options in
Perf, but this never applied to SPE because the default nanoseconds
period isn't supported. This meant that instructions ended up being
opt-in by the user only when they requested an instruction based period.

Change the default period type to instructions so that instruction
samples are generated by default. This can overridden by specifying any
--itrace option.

This solves a common complaint from users that the unfiltered SPE
samples appear to be missing, and only the samples that have memory
flags set appear in the various memory groups.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 8942fa598a84..b33a0a170ef8 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1871,10 +1871,14 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	if (dump_trace)
 		return 0;
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set)
+	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
 		spe->synth_opts = *session->itrace_synth_opts;
-	else
+	} else {
 		itrace_synth_opts__set_default(&spe->synth_opts, false);
+		/* Default nanoseconds period not supported */
+		spe->synth_opts.period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
+		spe->synth_opts.period = 1;
+	}
 
 	err = arm_spe_synth_events(spe, session);
 	if (err)

-- 
2.34.1

