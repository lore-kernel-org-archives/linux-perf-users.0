Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356E13D881;
	Thu, 12 Dec 2024 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970300; cv=none; b=JE79UMrxIpF5yX+vV1Tu0+ogTxvowSbj9bLPmdP235cZ01qaA7d/71ehberTLhNQKavX8FEVz+7W/Cgdwig4KDLT6rGrA1tFPXrcLGwP+ol7kno+/f4UFvteJ7mvInMpvusnRAS/xEHOKNCPKdIeR5dwARJWzNddoZO4jZxwAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970300; c=relaxed/simple;
	bh=e6fI2ZVl4IzPXnFdTWlY97syscDRQIiFgkHg3JcX4HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZ7eKeULHIQq03LuuqoJlFlDqU2oaXSoFxJNTSY2SY5Gzfb2LBpNlQuL4UVC2GcSI6+4ekL2Pt4Vwg00NPYfnjlY0mG4BcM6kbgCSm+z+7sXl/TZp3yYSFRsv077H/zXQDhveYtsbRV9dahrnbq67hM8OYfBeYAE6otDlH4yc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4lXyWoR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4lXyWoR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so66596a91.2;
        Wed, 11 Dec 2024 18:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970298; x=1734575098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfGyJy7AZeOLJsFch884GnYaUHhnZ6+BK2uA6O0m4MI=;
        b=Q4lXyWoRpzzEc5I/dyiwn3uDL+lB0TIuAj+frbAfPhjtWOsojJrrVsey7fQhlZNku+
         nWN3dM/FgtU3a8jtR5FRptlFyiO33143/RE0YLcXlOqHrw3Em0GFahSQ48E30OD55nnZ
         NEmYifS21m4SGq2UNHFlEn1OAmbEaiR9hp0mpUjEvU0iOKBNgk+nWxgFF36T5AJvaPo1
         jHhyTzXBJNSUsa5mIlBDvhm8nnPkyLH51Bdz06aY5j+ZiAomxoXjHyxWxLMyUPRP+RJg
         sraTh8HFcNuL8NxiPHNeDYsZsX3I95MUFOISZW3Lhm41f+00BHdjPswKsDt1owmSpiEZ
         MaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970298; x=1734575098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfGyJy7AZeOLJsFch884GnYaUHhnZ6+BK2uA6O0m4MI=;
        b=g5DfJ/VKDEsyPPUK2aAxG6Guw2+p/ULfA3Qth5lbaxSZ0PrcCTyK1OzHUytLLiMvHV
         9cTknfDwSdY+V+ighOvcv5mG/gjDiTEIrZmYG059orZ5BIPO5kwkILVpa4e3E+IbmemH
         oHVFsB/GDks1HeJYV83p5GgozfS7Mf5EiQgGm4HhkTGOyxN8RxSaiNQTdf3hl/Q/f9tB
         dZvOrv5rbgd6Z/m4oujCsXvjAF6MtEA797OOpwsokDc4whprsI3vqYPg2n1sv7mkvGgk
         YleTVria4uL3YejzXcGxdaPhZUg1/wHY0MQYvAo+Z/GSsNLHv1r0RsXchPWUjN1DRVi1
         miUw==
X-Forwarded-Encrypted: i=1; AJvYcCV5UJEgTNA3CsfvbGEu/fw+imiTLRtvJerA+XUvREYiLITgs50EZfk4dlhrghY47n5PHFKDO2PMmxdyj5QsjJ9qqw==@vger.kernel.org, AJvYcCVz/vkeGdnlJ3W7aAQxAp+Uy9fJuFsuAf+M5cPyZscPQsxtWR0HaK+zBfjbpyzSNnpBkp0JiK9InM/MJAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5WzBVpvzMuL8tIds7AX1qaFpe+xvzV0BFH1gWdHXon9AEXVF
	7oerNNQlywB/1NcgMdnmtXR+wxSyiLDdunpTaeFTdvQGLdTp/I8Aoq76SjA9
X-Gm-Gg: ASbGnctGrxqFu45BMhuNGtoqruolofLlphVtQ5a972jWL/ifVEURbbTNVsXa+rrF+cq
	Uo62gIpX/H3B+r7oBniNM7Tqwx3/Sj9WnIZ+dFnhZo8gYd+HJjSK1v77KKK12E+ipUhEDMhg7N5
	a9n1MkfYFOz7NbgfO8PtU1whXeeR7IJ8sz0njkb0vc8heJ7LZXaEnTpnSk5zzmXwvykvRRB9vyp
	D4nLKX9Jo5Xj3AVcLMHSimgHWFmZ+ma3CsDFxntyhHmUO/TSVapOViMsGmqOvJCPfJ2FzGGclxl
	PRThDEpkdKfX
X-Google-Smtp-Source: AGHT+IFw4mUIouJwApusjzHKMyp6o3wRPJj73PqHImU2VuMn/rfXhfHyWeBhY3yXomyPnnF7l9De9Q==
X-Received: by 2002:a17:90b:5405:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-2f127fa5e12mr10370446a91.12.1733970298104;
        Wed, 11 Dec 2024 18:24:58 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:24:57 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v12 06/10] perf record --off-cpu: Disable perf_event's callchain collection
Date: Wed, 11 Dec 2024 18:24:16 -0800
Message-ID: <20241212022420.1035999-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212022420.1035999-1-howardchu95@gmail.com>
References: <20241212022420.1035999-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a check in evsel.c that does this:

if (evsel__is_offcpu_event(evsel))
	evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;

This along with:

 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
			      PERF_SAMPLE_CGROUP)

will tell perf_event to collect callchain.

We don't need the callchain from perf_event when collecting off-cpu
samples, because it's prev's callchain, not next's callchain.

   (perf_event)     (task_storage) (needed)
   prev             next
   |                  |
   ---sched_switch---->

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-8-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/off_cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2dd67c60f211..2a4b7f9b2c4c 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -13,7 +13,7 @@ struct record_opts;
 #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
 			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
 			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
-			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
+			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
 
-- 
2.43.0

