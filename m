Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B113DDAA
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630561; cv=none; b=O/F5ixcUiV16OXtyxLJuoxwMJSsOn0Ex5B/Fbc+VhGQPhBOQ47fK75nxjkRzd5cIbBVmdhCayokh6pw8rHDUsQYKF/dLWrU/8jPG1WtevVF3EwTp7vCdGi3V4M2CHqFe4z1RPZMCQE7BoCkl3bShZ/Jw5CzZraWs3ybTrIbZYC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630561; c=relaxed/simple;
	bh=5vg+V2entINAiiEpQ/q34TEWfHyNUppODe0zBuoZe/A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=FPHqH5ka6p73T/1iyb0Ks3Z5vIyhLoKN7Hoq2U9LR6q/PLIWJhGLMmKdTOTdrjsHgwqW2pbiIPU8WqUBpJiSwSpT+VMePbWTfnDEZUdNmBG4UGvE9nk8RM9RwCOjyJ/aQzkRFhtfGrboAUekeZMcj44yWxYpz98xZ3YyMd+QCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIyCb4xR; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIyCb4xR"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bce224720d8so7344536a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 15:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764630559; x=1765235359; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pyTN6HqjnDsVWIvLCcWayuVvyVE02Kj+ZHxb/5CJn78=;
        b=eIyCb4xRppqKkT8o0g7dbV7Xhm2dFFg8olhZ7MKLgmHJ0or5kV6lyjj1rcJytSF/7y
         /F/Ku5BF2OhRcs8RvEEVWqZrmr+qwuDkG6jpXuc6byLMT2pyuQEmHDxtLxzjvmSMOaiQ
         WEXR+hKRlZe5Fc+P3pJsG9ZfmroH41WMsB/Ih2j9QG1YRkK9ffaCI5zsr3LTC1FnOuCA
         aqOymIrkvkPZuo3JMvoDZbOAnnMuWBh4jx9tqk/b4oce1yfIdHotU8GlQcmMGjwtsqtp
         EvMHVL3dzvRrbkjtF0EaTlpeJ9eycXUsw86/OmFJ6V140rqextpJqgIPra7reOakrPEJ
         VSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764630559; x=1765235359;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pyTN6HqjnDsVWIvLCcWayuVvyVE02Kj+ZHxb/5CJn78=;
        b=uBhj38AetPcytoBM6lEaDl+BB4lovIuCuQIFLqaZpSDpk0HELthFZgclNTn3a+oPWm
         pUCkKSz9V3wvobVAU857J/0XuFKYzZ+wg/2Ec+9SCUhoS9Dgr4URaTsueMcrTYXmJnHm
         qZ25Vw8nOaLr4bhFCVeg9bU/57WhjT5J+hD7HHT+mYQpSbzAClTyiCDVHwwEkvKPm7fP
         wKJyvilU0/7xa5ENE/9JlHyz8Q7Lx0/XCG/GYSCxWv57jFS5+rXpzeplAY8w1HG0BkZx
         pB25iqsclemqqEVcL7SO/qD0hD/0UyQQRGJgaZ8lCrRndemb6EDMo1h/lQb0bDBBnqqk
         PySg==
X-Forwarded-Encrypted: i=1; AJvYcCXmyBaUyNHUFmWsQdmuDhw0yMXFTxwpIFzWseM6zbr95BYt9eL4F8Doyax+eA3+01BzT4z/JbV1fsrLRepRtpvx@vger.kernel.org
X-Gm-Message-State: AOJu0YyqtD3gnUNoI9VTuvTicNYk7RI5lCT4WZGZQYrXCrPxOPzqHX3z
	S3eKFnlOk44C0gORdSFVH44KeM+tbx4hyXr31Q+DC+SOwB8FzasIVBxLQz9J0DR0UE9+EtF/IOC
	NQ8melmILaw==
X-Google-Smtp-Source: AGHT+IHne5jiJnAiQjXUjNl66YdlmgbnT68Is+WQjUySyZRd5zBSWYXxZXTX8RYp7Y51hvsEBBTX5Nv01QHX
X-Received: from dylq24.prod.google.com ([2002:a05:7300:5998:b0:2a2:2846:c507])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:320b:b0:2a4:3593:6452
 with SMTP id 5a478bee46e88-2a7190aa81fmr26728655eec.2.1764630559213; Mon, 01
 Dec 2025 15:09:19 -0800 (PST)
Date: Mon,  1 Dec 2025 15:09:01 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201230904.290733-1-irogers@google.com>
Subject: [PATCH v1 1/4] perf stat: Allow no events to open if this is a
 "--null" run
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It is intended that a "--null" run doesn't open any events.

Fixes: 2cc7aa995ce9 ("perf stat: Refactor retry/skip/fatal error handling")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5c06e9b61821..6410115ed9c5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -923,7 +923,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			goto err_out;
 		}
 	}
-	if (!has_supported_counters) {
+	if (!has_supported_counters && !stat_config.null_run) {
 		evsel__open_strerror(evlist__first(evsel_list), &target, open_err,
 				     msg, sizeof(msg));
 		ui__error("No supported events found.\n%s\n", msg);
-- 
2.52.0.158.g65b55ccf14-goog

