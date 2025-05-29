Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3472550D8
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493619; cv=none; b=djh5F3zDlsz7V2txTEByG4uTvyHteHeaCQTFJBTIymdy0Dl8kHKMLqm/7SvSNN/Pi67OIaCy/WeQqMhK2cgp/gbgWQ1uMS1GY+61coUy8QxEWxBaG5hfTfmdbXSBcNS8L6yM6fzFHoyL6Hj4EkIAMXVBZg01KRmoS8d1y5lMGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493619; c=relaxed/simple;
	bh=8sjuAjOj2orpAYr10kkA5Z/nzFBBjR+5CoUq/1YdQGA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=m5CMki6Iq2cTq16QyjBt4Zau2P1xvsDeOxwPlft/b779FT+ayXyDZwQyHXEoNWq7nfFb+NpXdWmxTPHWfZrN9RqM0irvgH+Y9880tBiuwfc0Yp4puSSYM9kWg9xdzXqf73R17K1W747ngakYWBdf1gHcZ9D5/CVxnwqIu6b4x9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bg3msAMc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bg3msAMc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-231d13ac4d4so7625305ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493617; x=1749098417; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3cc4XfHjT63tW0sHOE7oV+T/kyDzOGhrcNlU3mn958=;
        b=Bg3msAMcbToDTUynjMg4I0Ys7uLPNQyZVInyscrx1f+/Ha0R1vVb9oW3CLpfHxtJRk
         bTsGKIAsZLTJM5lVFLkRqYpyLVCyZYMI7rC8fL7LFC22BzqlL4ECXi+8GMYjemodyatO
         VsxkzvHkppTpaKgmrygxj9V6Eh61NO2LDDYvkGOWf2FnpSleSLxub7H58xBMFL+aHj6a
         YzNBfWOtZmu/D/En4OBQIcyFQbS8Ku8gaZtCEJVIJBgvPV8jkHPVbl/pKMaQNxUfpUSk
         GELMAV+hoy/pRfnGj9aVCwSGj6yIJAiE4W5e6En+GeFf5P0a0OeahXHVThtral/MWqEB
         ROxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493617; x=1749098417;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3cc4XfHjT63tW0sHOE7oV+T/kyDzOGhrcNlU3mn958=;
        b=mR2umWHHA7c0KL7rulKk5un05Sj21wg8GXWJ4NrLsVUYFrzfpAk8Tv7ezLOaLHrtiN
         hdaS1WPcezjBXSJ1dy9kSk1GAFBWOx45GtwZ/coG1HR1QSt1+dBHOOX9taEht7yhPG5c
         UwkIo+ddZx+fNxd2eG4VB5ZZaPXvteGxIzTFbQuJE7sd1ZyL/qMZ7bO38qcsFTJvA1bN
         DUzpfYD8ZDodVGx5Ow0DrdpSbYvNU/fJfqmQs7Z5Bhv2VUqm9685LYJiQ6q24j+oKY2W
         8l7WPsGdlfxWtuHluIPHnjOSazkeHCX20k3l37dVXL3kR51/7wdFPojymWLcFRdJzw4j
         DfZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgeeh4h9c/0ndYoDE/y4dpNdU64R8ysB5VtoYjp4ODkNdKe1Azs1QJluBmCPnKQC9JZwympb6sPO8J/w/Uq8Ul@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTtr9X9dgW/2m+8ZTTlj7urYbpHMG1x45e/NdwERQQX7aMYf+
	FM020V3qFeHfkzLYvoPE3y+sjGwBJR8S3CcB2dfNO/stUmEns+Yhcp4zsm8N9YlBb/L7/brqHyS
	Rl61LdXTQcw==
X-Google-Smtp-Source: AGHT+IH+nZZXQ1e5vfxdxY87E7j36c97TAZI0T6FIGcXkXjpMxDQyv++Eq5U9c3zbazcw0Gy3vnoxfpD0cNc
X-Received: from plbp4.prod.google.com ([2002:a17:903:1744:b0:223:225b:3d83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1311:b0:234:bca7:2921
 with SMTP id d9443c01a7336-234bca736d0mr74929435ad.33.1748493616471; Wed, 28
 May 2025 21:40:16 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:41 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-6-irogers@google.com>
Subject: [PATCH v4 05/24] perf build-id: Mark DSO in sample callchains
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
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
2.49.0.1204.g71687c7c1d-goog

