Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79491F30BE
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978227; cv=none; b=OW4OpFCb8cZA2w6oYdYCA6HSr00HeMg5kH5mLbYnZ7fpE1kNVUwH15D3EwLoaDISl7qzdRj+NAK5gzR7+NOUM0FEZu0b3/vZZ4OLqwlziRiApIrKqpjYVZUDJcPVj1IX7wT3yEnb+9fEXKc16u01UpBo3YatospDiCs4ItWbc3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978227; c=relaxed/simple;
	bh=5Ef/H9SQz0qyD6vdyn2cJCrQtQNhElDaP1JYvY7e3sM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AKxs+NpggKm9wqJyB0taGppWsT3wPcCgTT1/r7mecTrRtL7EFXPWkf1UL6NxebAmhR68+dMZ02tqxgZhobe7EmN5TlFc23Cn5oI9roVSoI8KVNlDBU58WM356mLeXhfDbgJ6xK/SHXyY8mcQJUcNGhFYMU6Ze9xYSyQZUH3UKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvc2HCEm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvc2HCEm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43996e95114so13317165e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 07:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739978224; x=1740583024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AB8I4wegTQXb4Nt4v2IoDrjBpPCGZeradmAL978Ns8Q=;
        b=rvc2HCEm003zi3oHKix3zVzhhJYyenN0h/SuqjE7ECNtQ35cAm2aq6QCF2MLsWBdbm
         k1IpHQcDXREzOKBWz/ONaBCBLHkL2wysnqr9v2PwX53S4RE+/yAHx/8v/4GgH3tVzvdq
         JriOpjotM9Zb6Znr+4JPDibbIjR+J6CpdVnyY5mziZs4aPtzrgMYf4lnwBdx+2MPKySG
         nCr5dP5LTlPTdcFKorMzlzUeXol82e4KuGV5RC9hbY3vIng3L6qikjLkowtpjiHkyfRV
         WJv093EwdiE2jH059rRJ1XNYjOBkhormcPGsUWyrOqo5WbdYaJEOZyR8iYfqzfgBFY+B
         4ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978224; x=1740583024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AB8I4wegTQXb4Nt4v2IoDrjBpPCGZeradmAL978Ns8Q=;
        b=cYXuWC9LkNqHfB2z4EQ09m3h69McfjKGcAltyvuRDtw99S6GOQLejPi9JrancEESiZ
         VKxOg4qxHrkQI5XAk95DlyoqXsh7UlzFxvtsh8vBXfyW4qaHUjYNT70dYK78zvkS8y+b
         46QYFT9+7rizgDsDzZI5wBPIh/MfA0wYQfwacPnGxxJ2ZmVj5FR+g2RU8gkjCw4tT5sZ
         +z2IOz1HiePt+ZQdK0vvcjrqbwn8Pcdd8xhiAdBoCW1U5D5MZY4kj+q5uEUcxHBTh2Js
         JUejMF8e5ep+KO3fgHp25wzBLg/tGHUxbQSzGgQGtCpMIht8xGxHqHa6uFjftejMLK7R
         ZmPw==
X-Gm-Message-State: AOJu0YzMz80wsJUOJM+BUOBE04FJ3aXKxt2QKpU2JuO0AGcugwoQSCD8
	YJAog6GwjdiXZvQGZDuG8QiQxh3kLE5RRaGZMbAIKFwYy09gFVgk2PqfsTvL/5jpKz1HCXXrT0v
	7osQ=
X-Gm-Gg: ASbGnctDylm2R++Lfnon1SauTD6iYX/c3h82l1HPseILgwHdrEGBwVCGhRgbNEH0jov
	V9gZVkTbG3ZF9Z8/2i6OGo0A+a1kVNO1EvO8Tkb6TNk1UArg4qhwCYDXbFDQeqpuKdG0p64tHGv
	6CjJtxAUduUHvh3GAzmoytPGSyqCx2/Lp4druJJZDhZ0+mP+wiJjp1/Hv7MnBFVvhqcUI/xfUxO
	6TExmw0pz6iBX3vciJ+D05ePrbygzZv1wyNlE+6ZWTEOkx2HPycTuj/ZldM+s42Ak3qy2b0h7IS
	7R/lvie6Ig+I/8U=
X-Google-Smtp-Source: AGHT+IFghAhU4CVYMM0z3nQZRvpFSkI5KSPb68OtzHjy/xmGIk0I938mkd7Bxd8Al9toNUNiuN4WlQ==
X-Received: by 2002:a05:600c:1f0f:b0:439:8653:20bb with SMTP id 5b1f17b1804b1-439865322ddmr114719455e9.14.1739978224110;
        Wed, 19 Feb 2025 07:17:04 -0800 (PST)
Received: from pop-os.. ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f8a2sm214703065e9.2.2025.02.19.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:17:03 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	cyy@cyyself.name
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf list: Also append PMU name in verbose mode
Date: Wed, 19 Feb 2025 15:16:21 +0000
Message-Id: <20250219151622.1097289-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When listing in verbose mode, the long description is used but the PMU
name isn't appended. There doesn't seem to be a reason to exclude it
when asking for more information, so use the same print block for both
long and short descriptions.

Before:
  $ perf list -v
  ...
  inst_retired
       [Instruction architecturally executed]

After:
  $ perf list -v
  ...
   inst_retired
       [Instruction architecturally executed. Unit: armv8_cortex_a57]

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-list.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 9e7fdfcdd7ff..c19826f218a0 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -163,11 +163,10 @@ static void default_print_event(void *ps, const char *topic, const char *pmu_nam
 	} else
 		fputc('\n', fp);
 
-	if (long_desc && print_state->long_desc) {
-		fprintf(fp, "%*s", 8, "[");
-		wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
-		fprintf(fp, "]\n");
-	} else if (desc && print_state->desc) {
+	if (long_desc && print_state->long_desc)
+		desc = long_desc;
+
+	if (desc && (print_state->desc || print_state->long_desc)) {
 		char *desc_with_unit = NULL;
 		int desc_len = -1;
 
-- 
2.34.1

