Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE812701DF;
	Mon, 30 Jun 2025 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287916; cv=none; b=BkJueE9LG/XQLeWicpJtczXUNUPzcesKAV2s183ngxstmmU4GQVWgIcmdpi917ir9d3Sc8u6q5WHl43Mg837uRBUy02XJvlcGKiVN7fafWAQIfLxRvkY7wv9C28TAHD0B78DUucHcibALx80g3dcE+oYmwPg3JAYqKu05y+V0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287916; c=relaxed/simple;
	bh=1GZnzJ9gT2t7alHrMVtRMKxx2nwrgqs6HEQbRg1qdF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gfDQYFznC5jvBmzw+2XmSXfT1Dr1pHjj/uJucxmonuqXMaav0nTwNbeeC4wmHtM3Lkk3VIGaRWMzW5TfJkCH4hANtZh2d9ZYnZAZ13wyB3z7C/pCXC7kAL3I3YOUuldnb+c6NV5XC/t3yr7BADT8xp2DdZ0usnYsDghXJvYGB44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0AxlP8t; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0AxlP8t"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d7b50815so14538385e9.2;
        Mon, 30 Jun 2025 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751287913; x=1751892713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bGmFeyDMoBpTbQ19lKlxDLGZE93GOj2clGGn+vOYYyQ=;
        b=f0AxlP8t7yn8JXZ7OZn3dsnq+CjcjBqSS1PENuXtaQXnElQRV25Zog2TAfqguqsVYl
         0CV62KpRciG/Fkq4JNFnPz3uFqjwXmnIJ2w+qffRUkbp4ICGYbmWoAgT7HjDaimyySXh
         0WBftJ5leow+rap06kBvPQ7kn8Vss+jPYYZxnNgXtCfCFze9Q0xaqpJcRlbAKA2o77h9
         c5u0qX6mhl5BBWBw+2TUs/a2InEUhbpA8Vrg51wLoZ1OjEvkkT8c+wZXdw9etbSSJof5
         Gljmtiou6L3YBGUmZUO66pbE9Y2yyDP2svonKMD31hlW0VpNWBmHyz5ISu/WVcCvjso3
         Z1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751287913; x=1751892713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGmFeyDMoBpTbQ19lKlxDLGZE93GOj2clGGn+vOYYyQ=;
        b=LDy/w+B4QLH9eGk80wzOH8Vk2N8NHp610brRdz5mPq2GK/lI+66mWwPBMAgKEm5IB+
         H0qrWwI81RzMnuP/EAHGX2+zWsJGo88SHdO7NKsmvKOlcKyaYpCHBpzVOI9W5IHvu6iz
         Pi/wtt/I3UGigG4D4nC/2BFv8CJLN++w9z3vSADI6ZTy+wjDqco8njLRpESKv3uoac5r
         F4LObysBAotHq6HXJpqQq6sknX7PpjtiExe5elNhwq7lKhbNpg1m/VqbYgSfyBQymfzV
         acOyeit1JrkB6G95A7/jtz4OdqjQaU/P+wp9OoF0ttq+luVZdqRfe84QlONJr1DmWqrP
         xlIg==
X-Forwarded-Encrypted: i=1; AJvYcCUc8kUc7++jPGIL/jv1FVhN2+hFof2p2zkHxPHRqxmQqv3jkaaNPFYWZF/TL0/KVJWo81aMO/eYqkUV0vZiXaA/kw==@vger.kernel.org, AJvYcCXpqwgk0WyS3Gd5eJkMEqD6AN7quaXCC7zTJSLfuKoDAKmKDPVV7G+UDy3H2zmRG5wlDth3+8bn0wgPCos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIbsLrMtBXAPWwyjMywzIosI9acLaqRXbEUWs8DPINgxOjquU
	xDItGFz0B8EdCg6q/PSedj3xUNhJFSBim8e6AIuUDGBZYKpIG1LkRUF8
X-Gm-Gg: ASbGnctFwgqxl2S+GtggX8GCEdhw4SRcxO1Tu5fNlbedHJi4CjpDYGljJpIFjjzrqI+
	GzQSEl3RAUzbWESQWguPBKxlcPcdKXQUnAENilqoPrWGRWoQBQ0kWd0ZwXj4XEL9o/ZhLNZ39+G
	Lqb2m66eOHphSqJBk/pvwObWnKt3YmrUDZ4jbUO9nMKZvbkRHzYBbt15lfrnKStSvbxUMAtYvsw
	srkAvNHlQVotFDz/fCPHk9cIXsW9hyxVcdNKDvzGkAP4TFAqmgtSjt5tXF7qz9EvPyZhIvGqxYu
	3sJQCmaGjWaMgq6jDl/j7q/MWcQkFEX1lS8Rt5ekhyDdVppaHOaSPlZ8W6+Y
X-Google-Smtp-Source: AGHT+IEyE7HdVRfyChdQyAIYEvU7j+qS4oD7GW9tgHyuCTGXIQ3vI+csy6l0qNSfKih8u1T4PBULbg==
X-Received: by 2002:a05:600c:1e12:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-4538ee39aabmr119794565e9.11.1751287913250;
        Mon, 30 Jun 2025 05:51:53 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538a3a5599sm137326365e9.13.2025.06.30.05.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:51:52 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf drm_pmu: Fix spelling mistake "bufers" -> "buffers"
Date: Mon, 30 Jun 2025 13:51:28 +0100
Message-ID: <20250630125128.562895-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in some literal strings. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/util/drm_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/drm_pmu.c b/tools/perf/util/drm_pmu.c
index 17385a10005b..988890f37ba7 100644
--- a/tools/perf/util/drm_pmu.c
+++ b/tools/perf/util/drm_pmu.c
@@ -210,17 +210,17 @@ static int read_drm_pmus_cb(void *args, int fdinfo_dir_fd, const char *fd_name)
 		}
 		if (starts_with(line, "drm-purgeable-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_BYTES,
-				  "Size of resident and purgeable memory bufers");
+				  "Size of resident and purgeable memory buffers");
 			continue;
 		}
 		if (starts_with(line, "drm-resident-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_BYTES,
-				  "Size of resident memory bufers");
+				  "Size of resident memory buffers");
 			continue;
 		}
 		if (starts_with(line, "drm-shared-")) {
 			add_event(&events, &num_events, line, DRM_PMU_UNIT_BYTES,
-				  "Size of shared memory bufers");
+				  "Size of shared memory buffers");
 			continue;
 		}
 		if (starts_with(line, "drm-total-cycles-")) {
-- 
2.50.0

