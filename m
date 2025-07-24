Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D82EBBA8
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374807; cv=none; b=TpGLGyFtsWDIJY54fSv6BDvq8Jv2opOfOoGrmiprmwkdzO+ffaI0MDh/kzoLPJdzhIVtRWDC7I4cZJK6C/gr020Ir25AGhnl4gahCfaiBMNM0+ldhR2uTdqN6UFYM7xsC49bbsIGPYUQgsV/I8r7OEcqs9ln97xCiIERcyadQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374807; c=relaxed/simple;
	bh=i87jvX210l24c7RqxS+bUYqmgL8+oZvqMbe8qDfav9Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kiIJ79glQ1Z8dA5Vt5MV4JFbLOOmwVlnZhb7XRu5QL1GslKRovb0SuarwIED1Os3/ztn2PfmCYOicNZ40FpMdtlieC7IqZeL0DOfY9MzQnnI4QpDt5tJYMZxdTzwmvUss+srZ6SJkUyMeAl50Pd6UfJ7NebPzSMFem1f6OroFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjM5KkS9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjM5KkS9"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3f2e05fb78so940933a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374806; x=1753979606; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62dSX49aFLikEjIUMEVRlCmIJbHK4eeNScGSo/Mzprs=;
        b=XjM5KkS9vBcw5ali616l9FMbzTggDUX60SKh6sdl4g3HEcwSmVVeoY4mWb8AOBRITC
         r5HcghPWgfWOscXnZ4XeuSHSweuudWilg6KWATrilLU3IjPTtoJJY8pEJvpUwXRFQJpQ
         eHVv+4i+fMOUQucr+vNQy4TmCM6R/Oxx5GdMX8DjSoXQMjSsDL+mgCIIF0JJcvIOLOnD
         nW3CPHG+QTmYk5sw6ulwdDWx4Ak9nuTqyxPNBJWoc3r6jFudxyGTblqhIJsJbBXsALQT
         zzjeiQL57iIvZskL+MQAfv6T2LgaOWdvREw3SbtYaCfRJC/mjzLL9qsA0GoErxfBctzy
         ykVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374806; x=1753979606;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62dSX49aFLikEjIUMEVRlCmIJbHK4eeNScGSo/Mzprs=;
        b=jSi9/c+WdBF3Omhi5zhPBzEVeLdsMfbRN4+DNy0Rg91cksUowBZiw+OdBxoAO643vw
         fpSno8ZP5p6pfYO7WEwY720CuW+qmXEq2Qb/ycmXTMl1EnnXu+ysRh79lxou3GkubfN1
         Ao2jWxrQfDC2JwhWo4CUwS4rTvfxfceqe/yRiIozWci9FYGsjjNuJJPBT1YpC06jh/bY
         6H7wtk2Gpx3+iW0kwfafZ3uCS4gDVEGqiHeaqsShoQeSIRL0r6Wg46I4nFH8SKDIBcbv
         oFDHzH1e2+fDyNUIIlNGnbFoj9vSGTJxBxjExEJnNoRrH4GUlCp7BTZjDrLg+xDOSTLx
         nCQg==
X-Forwarded-Encrypted: i=1; AJvYcCUxFJGPTeKljj96s1pRsRiQzHCnGHTMd6IjQdBsuC5KmAXf3S5WoVtZPuzKsmzV5zIZfMMaocd7JkKYOMfm8cvM@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkG9nYoOqgQKpgIAFOfuFufCNabqGxZIucbb65WSmzHV2nOjD
	v+FMHDx5+R1n/L6VMMra5LsF/yA2fveaDcCN7gmQZJZ7Zozc/+MsXdiYUVTJauo5jJc0FjmOour
	ubs6yYwOXvg==
X-Google-Smtp-Source: AGHT+IFZCjFgmdaI3NnelSKPac8n0knclpKXQWik2c3NFOqFyfb4a3FQ6KRAvAGmmyaW3sKiM5KoSl2FkuwJ
X-Received: from pfvf6.prod.google.com ([2002:a05:6a00:1ac6:b0:747:a8e8:603e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d80f:b0:220:82c7:309c
 with SMTP id adf61e73a8af0-23d48fe74b2mr12168299637.7.1753374805136; Thu, 24
 Jul 2025 09:33:25 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:44 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-5-irogers@google.com>
Subject: [PATCH v6 04/22] perf build-id: Mark DSO in sample callchains
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously only the sample IP's map DSO would be marked hit for the
purposes of populating the build ID cache. Walk the call chain to mark
all IPs and DSOs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index aa35dceace90..3386fa8e1e7e 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -42,10 +42,20 @@
 
 static bool no_buildid_cache;
 
+static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data __maybe_unused)
+{
+	struct map *map = node->ms.map;
+
+	if (map)
+		dso__set_hit(map__dso(map));
+
+	return 0;
+}
+
 int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 			   union perf_event *event,
 			   struct perf_sample *sample,
-			   struct evsel *evsel __maybe_unused,
+			   struct evsel *evsel,
 			   struct machine *machine)
 {
 	struct addr_location al;
@@ -63,6 +73,11 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 		dso__set_hit(map__dso(al.map));
 
 	addr_location__exit(&al);
+
+	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
+					/*symbols=*/false, mark_dso_hit_callback, /*data=*/NULL);
+
+
 	thread__put(thread);
 	return 0;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog

