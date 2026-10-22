Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637397;
	b=zjhsBfhTkbpn75fWFTlstjgdko7B0fkXg+RwEbdqC3jzqzWF2FWL+fnhAZNg7vzCUuzc
	 2HjRJgZB9B4g0TfRfm8WGR68gyeQX4wzHabjvjplBuco2FDHKle9/93d3ZAQrOcUWBxvu
	 GI8KoId2aCaSi+GPtNtoJ/uNuxq9KPl0hXYB1dTzg4D0gHpR6wILm1GNG/XaNbWOGHnKP
	 1tPx4fGwuvX9zhacYEpKp7f0CFuSZ/KKsa2sdcGZh7avFBAnY7E4YZU+ZoHHl8Zlu7B+g
	 w+gvBOstpHz09XursTPMYftYkr6pmGhkoa47v5uCuMi87ci8W6Ta9WE3I8mt7xK6fSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4PnAfrR6wugwd7UJwfD+6OvXY7U07aUad4B+VZO/VrQ=;
	b=ZzGU5wBZJnU2dNMO7XWRGka/QoQWVn6ms0s7Fdt5vfTSLlBx6CyoAmcNb2qZaUI73+Br
	 xoGooqqri/CFPc80H0/TEU50NmOg5o+i5+JJV3lf4ATOq03GRt1JvmYns6TsvByK1DVER
	 VKJrC4Q71QJc9o4pHiWkiNdBYpwQ2Csg6ZGe54PKYGWG3dbzVNaoH8S54NhOqRu9bV+0f
	 xFKiZzXXtrNK0aKpFOYcz/Px3ei90mdYGaWHLJDfdZl3FlgpR02p26wIhfQeNkVDDlanh
	 Uzf5Y/+rKB63u3jplhvJMvtEbtZ5D3mK10lLaLtIjcHwr1yAhQv3RVR76EZZQLfD6uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IOWDuMQD;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA16606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA16606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IOWDuMQD
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2637353eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 19:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637396; x=1793242196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4PnAfrR6wugwd7UJwfD+6OvXY7U07aUad4B+VZO/VrQ=;
        b=IOWDuMQDIa63aAoWvQuh8lW60U8FRCftSEME5rtm2PgVOYiu62rNo0kwvfUKC88AYH
         LKT3LE38+xk+cs/JCHMIGaQGKr4LumtAUrQRGg9AZVcjZJ7q0Y9rZkCFDOYSLcknLMXH
         5qG1Hej5+mJR/xxNpvVgjwKdIxiazMkYaC10W4OOWTzDZr1LfeLJOTJ9gbyGvvSsPJL/
         weVY/GCkDW3UhLlFu8WRpENRXFlMzRGIVG/EaY5HJClZ+ETebxapK2GDpQiBLigz9uBr
         EWD63iorTqCKyjXgxAStVBG/eXPPRVKH1eX//imj343bDzSdPi7hcPuZuMW6SD/UUXZ7
         FAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637396; x=1793242196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4PnAfrR6wugwd7UJwfD+6OvXY7U07aUad4B+VZO/VrQ=;
        b=w39AMS3tbnKJPEkz+b6YXBJBI6BqxmDoSZxECR91eTyC8OlJElIq7vEjCm1W+S8Sh3
         JfGe4EYbxUIc84I/Wd6K2A3vYzr2qOI4JuHyb17eSUAilKt4X0bmy0O99g7LzdGOYoKK
         wFtQVwNe9JmnrF0aHHkRJf1rvnfJJtHFWDA7eB/bGGzCjYtRVLMg1xiSXKYWua2pzIC5
         rDgKQte0LECbAP6pajy847GUwsKGxLgQ2enuUpcu+uek3IuqMSZJ1tnuEs6FbxkvPPnU
         whK7htP0VYrVT3g9F3R+ak8+gCIr/kui5RX1K8rgO6fASAW5/FU+mDDuNNVG8Znt4wvx
         14MQ==
X-Gm-Message-State: AFq9FYIjcdcv9TIsiS41gXbzW9pQVZZy22eQqslHrDcRBzi5LKpo52VF
	KhCuzgcvcnu8t9oKwLhrxYPx5tvH1Wmzje6tgTfp5InYddix8hfHBNXJmNVr+Q==
X-Gm-Gg: AYBFou0GcthkgTXF+t1K62sxWuB7t7oC6kusxH9Y4e/gszJjmc2vRawItQoV3qbxHto
	2xguxREowmG7unN1A+djuI0zEHnSEXN4qtQG3ElvYNYL7seRPoO7MEPpUatkXs7eB+OHrs4m0//
	Ueijxkj5eYDxlUjlK+CkGZdFj8Z36gVek31ePUYKsMFIIz1PNu0kfBvj7rKv6Ee9foOUbg2ixZg
	AgNzLVSKFkobzGtWi7czhM0lyWAGMhqwIpQQGPo+GLlp1vsNjx0iHpdvSWtlnRpX3/YgYgHvmGu
	ZS2SZRb50EtaG8CpsIO1vmwYDxl3Xy9J8uv8sYQvBRNcwoa0gWlYw7jujipFqXS48E57rEphmZl
	ZvFPI0T4ST0R0Fy899K4byPKS17RN7dbLDIWV9Y/8Is7c742AdDn9HYSaOANqcRKJYOmDvkJ6hi
	A8fP7kqhwMwWpimZWFcGKXLwtci80uhT2MYD/d+s+rHjOB2C5L4TvgomQE6ge8cyM+LinSqKv1J
	qZlKGcfLwpnrfFoPtaXrl2lZWbmDyiBaN9izKK14BHxVAXO
X-Received: by 2002:a05:7300:8d:b0:366:9fc2:ab70 with SMTP id 5a478bee46e88-3674cc3ccc6mr5691526eec.14.1792637396375;
        Wed, 21 Oct 2026 19:49:56 -0700 (PDT)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bc89fsm14356826eec.16.2026.10.21.19.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:49:55 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] perf test: Skip the extra metric line for stalled_cycles_per_instruction
Date: Thu, 22 Oct 2026 02:49:50 +0000
Message-ID: <20261022024950.264235-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The STD output linter maps one metric to each default event and stops at
the first line that shows a different one.  stalled_cycles_per_instruction
is computed as max(stalled-cycles-frontend, stalled-cycles-backend) /
instructions, so its event set differs from the one behind
backend_cycles_idle and perf stat prints it on a line of its own: a
second stalled-cycles-backend line carrying that metric.  The linter
rejects it with "wrong event metric. expected backend_cycles_idle in
...".

Metrics printed on their own line are already skipped
(skip_metric=("tma_" "TopdownL1")); add this one to that list.

Verified on an Ampere Altra (arm64, Neoverse-N1): `perf test "perf stat
STD output linter"` fails before the change and passes after it.  Only
the linter is changed; the perf stat output is untouched.

Fixes: c7adeb0974f1 ("perf jevents: Add set of common metrics based on default ones")
Assisted-by: LLM
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 9c4b92ecf448..d9610f2c92a6 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -13,7 +13,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
 event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "backend_cycles_idle" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
-skip_metric=("tma_" "TopdownL1")
+skip_metric=("tma_" "TopdownL1" "stalled_cycles_per_instruction")
 
 cleanup() {
   rm -f "${stat_output}"

base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.53.0

