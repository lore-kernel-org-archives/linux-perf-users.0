Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D22D030
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831697; cv=none; b=jLava88/BmMmtHoyG9b9NU6xyvvdEhUuFn7m5x2jPeZU2u/w8214e5MGmWZ1O+gX/P8O/tRtpPdGPIgnVgGm8d3cKY8gg9FniDJd6bAAwhkgsF+z06ArbDRJT+AyFNTEnjegdGmI3ilptMJNnaT3rt7EemgzN2CJkuNT7BgyuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831697; c=relaxed/simple;
	bh=t5EUGcnche4/CSvOdCl3xbAPqqCIWm8X2sMW8nv5oIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S08v7+BNZ2lfxmMQz+xidYDXe5dTL+SVzKPWlpGiXAAyA84EqNoHWsfT2467ia+q1kkz1HQ0A7YWKtPBwqn2pmHXBp9ioQzHjRJ13d9wwl1dU31B/lXrw+ROvHX2s1kaDapbkIDtRLJ3U0H/m+QMqUgClVZGOfS6IoPQLgXui+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B+4ZvqnN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+4ZvqnN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36858357bb7so3833294f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721831694; x=1722436494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VhERnVjZMf0Sg6OFzVS2dnAmWgxdNCZ5orzDkCtCZ0=;
        b=B+4ZvqnN87B6UI1BppKescHNl/KPjC19QGGLa3JYIgPG8LXooBDfkpEd5adNEOnfRL
         wE90NqFV2ZwLFYfmAmDwWoQ0rKkFhT4g8ZZ2ehq1nY87Pjjy4nd3hqxSa00b3qZZ82J5
         /m6+eHu7/CXx8bSw6agwHBMpXROQzgW5VCeQZarBp5FOStCBImwmaO00aornV+pOJypO
         S4A0p4B7j1veSDH3XvvX6FyYLMCWSKgOzyq7zEvqidf7SKC0F9dHXkjy3fYc0Aht7Knm
         x5cOt+USK8fSvPpcJbiBtZhOygTCMXm2S6qoo1pMSx09vLrKHjLYdMMbs9L+hg77uuQ5
         ExwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831694; x=1722436494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VhERnVjZMf0Sg6OFzVS2dnAmWgxdNCZ5orzDkCtCZ0=;
        b=kU5Fc5YYn007oLoCq3zdeGt/LUIWdqiSYS17ypr7E84MCnGkNEycXxn/6+MjRpzJhl
         MOTrtj8t3DdRl51fSymsZq3sfekZRioStgz8KqBQ/2oD/MgA7c8Mfw7MTEw1iTgomGz7
         KQzJyjjqVrdg3883uB4wW+pDGoDXhO3JVFELoYgJelBfKBwQd5AnwfuRc5FAH56NInKW
         wPxX/tNELvHs1VnbUPUXgT489KAUG5zDk4C2MytFYDXsLRpL8tuRfJHZtK12oLKGrjMl
         V8Vl13XA64fAxE5CBMtv/2bUffp+ljIqs6I25kbmchEMa1LMF1ItI9TJJ4oW1aV5DFMY
         ytMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZwlAoViZHxfPJPKYF/azUJj0IwqIXREeM0n7a80z7jqTezFbqepYuE9GzfBzdT0lc06laOpOvUwzQFXj6rEKa2hUM6SEx9N34FUBsSN7g6A==
X-Gm-Message-State: AOJu0YxlmW5lmo+hjBRwohYoCc1L07/bpJdnq8Tp/Pm2MAcgH9MVsPM1
	HE/woww/MSSrDOwSEXiTjNHQ37smcsvR67tMoUJm8dcXP4Q5WLBJMGipdkgnsxk=
X-Google-Smtp-Source: AGHT+IHlr0nOuurrzX3Z4gyyCK7iSTvctyAT+dqqlEdpLLITtmGkF24655oMdP6cxoltl8ni+fS6TQ==
X-Received: by 2002:a05:6000:1884:b0:368:5e34:4b4b with SMTP id ffacd0b85a97d-369f5b162b1mr1808467f8f.6.1721831694301;
        Wed, 24 Jul 2024 07:34:54 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ebab0sm14657816f8f.92.2024.07.24.07.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:34:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@arm.com,
	suzuki.poulose@arm.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf scripts python: cs-etm: Update example to provide vmlinux path to Perf
Date: Wed, 24 Jul 2024 15:33:18 +0100
Message-Id: <20240724143319.169745-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example shows the vmlinux path being given to the script, but this
only works when running on the target. If the script is run off the
target, then confusingly the vmlinux argument also needs to be given to
Perf as well.

Without going into too much detail in the example about when it is or
isn't required, just include it. It doesn't do any harm even when
running on the target. Now the example command works in both places.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..4aeb9b497f7a 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -19,10 +19,10 @@ from perf_trace_context import perf_set_itrace_options, \
 # Below are some example commands for using this script.
 #
 # Output disassembly with objdump:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py \
+#  perf script -k path/to/vmlinux -s scripts/python/arm-cs-trace-disasm.py \
 #		-- -d objdump -k path/to/vmlinux
 # Output disassembly with llvm-objdump:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py \
+#  perf script -k path/to/vmlinux -s scripts/python/arm-cs-trace-disasm.py \
 #		-- -d llvm-objdump-11 -k path/to/vmlinux
 # Output only source line and symbols:
 #  perf script -s scripts/python/arm-cs-trace-disasm.py
-- 
2.34.1

