Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E21F37B7;
	Wed, 11 Dec 2024 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955944; cv=none; b=eHjbymlqi/lIJXja1c8YY0OBaFUr+IQ75pxJRvT8zAbYORv8XX+Ec0/oVee99Mi9Bf9AH8zuWEi6MKv2bRz5beL3YsihBE1AuBd+9Y+QT6UYmSogY8AJ9/99C8UfVNSA6EvJEyAMT4FcQMreTKopSYlBFd35+08NLcDf6BtixVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955944; c=relaxed/simple;
	bh=e6fI2ZVl4IzPXnFdTWlY97syscDRQIiFgkHg3JcX4HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QI9OxbY3Mt/rkrIRSN4McKu30OiVGBtUBH0ttLOYV7rrfQxXhD8pazbjhST+VnI+czcvXllzOP/JNDAyRqAskhUmDrF2eyiCWDEf1yAiYKDWOH43tg18VZYjWxie90VduxKghkm/w8SV/LX1Cz++uIGhfTmS0osMxNJkMbTbdbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDMJsTbP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDMJsTbP"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so1011997a91.0;
        Wed, 11 Dec 2024 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955942; x=1734560742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfGyJy7AZeOLJsFch884GnYaUHhnZ6+BK2uA6O0m4MI=;
        b=VDMJsTbPMqDtke4ws/h5TEx2VHPiUbX07nrtZhikM0cdItvUyjRbrB/Jj4hXwZ5uid
         fy9RULI6zn+SDj9b9lroDxDMKRWt/oTiLkLH/GRlP9t3Lj9OCIHfqkyt6C69d+3Qycjq
         7p4End/5fkFw2YXARrlF23TaL0OQqesrXOlDGQqwdQ9eFfVfd5pWPcOeniI9OoqgtA63
         W090I1FFzUkzouL5kzLTjmFHg87OBt3aRIOHqs2/dMWcuSiVIAii9MwxF6+N1He7yY/T
         8cKcIOtV2PpdUdyT3rvpLjAJ9E3wY158Et52L2TWQxkBTIeGGgSehLgC2ruLTLdXCJUV
         kY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955942; x=1734560742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfGyJy7AZeOLJsFch884GnYaUHhnZ6+BK2uA6O0m4MI=;
        b=VA9QSxiF6BqaGFPOWk7/GRJYOK0N+TXIg+o0Bf7cfZp3KQvntzdOJt4eCpEEG0bt/E
         Ux+Nj74zHaAMp1KHPLYvZEmGkoECTVktA83xmxHlhB1UTrhUjYlY3+vNCi7lNEIHLfy6
         ypoK3fQUmXMZDk/FwSe39lgv0L1hi+BlQMCN9leZnhp393ggOxP7FKcJxe74H9prCvuF
         a7IP7sCyqgIEldHsSOur1QWxg4wtWuaXIq5tjPD5QXd8wm8gzFycMsehIWuVHjRO6+ug
         wmo3/6JoCOtkJMQh+XnocjEBWfFJCeskvqYtQUQvdM5whChmr67kWHkiySPeD+CkKVsq
         noWw==
X-Forwarded-Encrypted: i=1; AJvYcCU/QIuu7Q9FCZ6rCrZuguTkCra1zPD1xYJENqYK03Oo9BQn3tXhq5R39M1kwhlPnIRis5bRKqP2w9zAnqw=@vger.kernel.org, AJvYcCUOly6XGhxxeHxe6SoXh63TzkITE82ATvJsIbZZ9C7HHCqY8IQaLdt7BPjtlEuadOe5u9Afc4Em9bsSJl456QyYIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5gvzyuZQgIEBrrzcqBhpZ2Xkklht59aP/PhswFcCYY8qCpoB
	+92bsSml4J7H8/DwtnqaoV1oPUXTverc27dqqbPNAyV9T1rBtAXE
X-Gm-Gg: ASbGncswA1vjLYRI/yBban7NyeIxQU/dMQG9S7PzcWxuswNBkBAzOtKYgU06BgPPDI5
	T/EUlah8UL6jIKcNEBDg16Rk2Xjr8K4Y/a9XM5N5lwhJPkS+8RBAoDiKMvCk9QFeml/S15LXYgm
	WsYrjlklQpBoAinlXlaxhU9Wcquc/0z3FOo3zzf91f51WaPoiQC0m7bn2FzzRWw5/1OANbbBPPD
	0brGDtMLB8pwqQidCR7bBMir37xF0LTA4xnrfYxbcNaDtK3cftNWdUDvxVdfajp1F53vP/I2yW1
	1UPRSfwrIw==
X-Google-Smtp-Source: AGHT+IH6rJt0wfLeJPiMiHwnzI36p7i6CSPeeZXjJ+xGQAfBfOTZvTzVkmdbhymPhSSJoz7GQoIjtw==
X-Received: by 2002:a17:90b:1fc4:b0:2ee:7504:bb3d with SMTP id 98e67ed59e1d1-2f13a992eb9mr1574864a91.0.1733955942475;
        Wed, 11 Dec 2024 14:25:42 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm11241561a91.36.2024.12.11.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:25:42 -0800 (PST)
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
Subject: [PATCH v11 06/10] perf record --off-cpu: Disable perf_event's callchain collection
Date: Wed, 11 Dec 2024 14:25:24 -0800
Message-ID: <20241211222528.945590-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211222528.945590-1-howardchu95@gmail.com>
References: <20241211222528.945590-1-howardchu95@gmail.com>
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

