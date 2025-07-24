Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01A1F0E47
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374798; cv=none; b=hNyJYEcWGJlXqV96m3S27HBm3dhyu++4SpUXRys0QX2kOe/cswGYqZpWeQbQt5CdXV0zMq7NGvsAWoWzmQGpWYGyKl1bTLJPBlfQgqqW115gkYsqIu5YMHVbW4W4d+COku5ikkDeSiXxCBl9Nz8S0DJQusvdsbYUZwtNuZJNdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374798; c=relaxed/simple;
	bh=qdkXYwZwQilwi089YMqVjrMiZV659L43XoqfQaPVoIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=neBwq1rjIdNO6+0JsrwswA2Hxbo0rGYb52A2i/bvnqXiUvOd3wONt39X4hh4AwaBr9dsZ1Rw21fU7iq5HEHC5OBKHh4m1ua6SuRpXvbUHjxsZu099ytccAESorKgbKXOUjtqJne/MvL7IK/oLcJjfn+gTNOUzLXkglNayZDMGr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDNgcKbP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDNgcKbP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23507382e64so12669795ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374796; x=1753979596; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHMRbh0OGf1VtE1XWliHZ+PxZ7EmgPTkysBcMOF3iMA=;
        b=zDNgcKbPZ6lkhMBCyj6KteVitHhE6nbUIxfv5l+jFl4VZkxmYA3bGVl+4/YWpT9fuH
         vVT0bFDpxKK6RsG2GFiiA8+aKiesz90dh8qQVDE7MZWbuvNgSG6ICBPi3LllQHbWH7Nk
         jx1cb/eYkCUuaUy5XHw0WrvhWEdIxz50n9WiU/7t7MHFQdKJ08FRCBdurznz8PjCahEx
         i6Z8deoauGJI5DFh0kV0hFT39E4uRhJrvjuNVCnQ8eGWNEbGjBtn89Ta5vq1272EIqm6
         TpsFzI+su97shaoOe+h3RnRelDL+ywIVKJUaMlWehg7mJjctELimnY/iDE6eyprpV8AV
         8P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374796; x=1753979596;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHMRbh0OGf1VtE1XWliHZ+PxZ7EmgPTkysBcMOF3iMA=;
        b=bTh9gqFQ2ezw7qA+t1ccE6UIscAU/Q0eqzv9wzaiY+8kRyQRoDV6qTloFXSu/bqHFt
         is3b+1TpIzcRhetXXSeLFQ7m/r79DfLrYvr8MhD3FHISB0Iz85758wiQ6sZ4ksCdHRqP
         xXwC/XdO26unAf9m+mBqxKma+TL5Gh9Jq3FnQxuv5WSUnAk2XUB5oyrnA8nwJ8BBaMH3
         lgCvgyGRo/2RiFqOzo6RjkZMsgzSS9mG4bqS67tk36j0RISPKGdoHCAS130NxJM+RmNl
         8GgJ5DrwAmTvqbRVsH598yjWuES46C26eaCJ8+5lnNYQZ1ZsVjrroQM/mikMF5S2i+R3
         2OJg==
X-Forwarded-Encrypted: i=1; AJvYcCUMDyJPFOUDdQBahD8Zszyu3RPvM6w70LWnDtywLpJEP1pwShkQghhVQPbb7DAZf14r4g1KLp1Ll/dhoHPYsYSg@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCZgjRELIkUZSYF4eMcBOhUZ3HXq/ZI6urysnNSZ4xHlQwaFM
	H2fbL//CLaRNUczK/Sr4t1uRKYhGz6VEOAU8JhiGlUmTIDHqXf1/6szdTLEEWWVD6tIhtvIsey6
	Rqhl5Lpyh/Q==
X-Google-Smtp-Source: AGHT+IFUn9ibU7z3cYjN4eNtr5ZP5Zw75GPYkYhnnHDx8ub8GXqfpX9vK922RLak71vDGMJczBiyKtYkWmCZ
X-Received: from plge7.prod.google.com ([2002:a17:902:cf47:b0:23d:eb0e:df66])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c942:b0:234:a139:1215
 with SMTP id d9443c01a7336-23f981d3e70mr105002605ad.35.1753374795910; Thu, 24
 Jul 2025 09:33:15 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:41 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-2-irogers@google.com>
Subject: [PATCH v6 01/22] perf build-id: Reduce size of "size" variable
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

Later clean up of the dso_id to include a build_id will suffer from
alignment and size issues. The size can only hold up to a value of
BUILD_ID_SIZE (20) and the mmap2 event uses a byte for the value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.h         | 2 +-
 tools/perf/util/synthetic-events.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index a212497bfdb0..e3e0a446ff0c 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -13,7 +13,7 @@
 
 struct build_id {
 	u8	data[BUILD_ID_SIZE];
-	size_t	size;
+	u8	size;
 };
 
 struct dso;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2fc4d0537840..68bb7c5fe1b1 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2248,7 +2248,9 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 
 	memset(&ev, 0, len);
 
-	ev.build_id.size = min(bid->size, sizeof(ev.build_id.build_id));
+	ev.build_id.size = bid->size;
+	if (ev.build_id.size > sizeof(ev.build_id.build_id))
+		ev.build_id.size = sizeof(ev.build_id.build_id);
 	memcpy(ev.build_id.build_id, bid->data, ev.build_id.size);
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
@@ -2308,7 +2310,9 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	ev.mmap2.len = len;
 	ev.mmap2.pgoff = pgoff;
 
-	ev.mmap2.build_id_size = min(bid->size, sizeof(ev.mmap2.build_id));
+	ev.mmap2.build_id_size = bid->size;
+	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
+		ev.build_id.size = sizeof(ev.mmap2.build_id);
 	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
 
 	ev.mmap2.prot = prot;
-- 
2.50.0.727.gbf7dc18ff4-goog

