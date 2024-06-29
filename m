Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2108595F
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636899; cv=none; b=UxF4PZJSymyf+WzTmPxGIVeB7eN8GNprmU49Knl28FEMqCxUUz4mc8fAVjCBQ2te4BPtQdUSbhwqDX5VVFffn1C47MfcOyYNfEcN1Wlqz+R2uZQcbpFtfsVmL87kQ0Qvu2HB9IPMzOiHADzqk4fFtSBalJZyvSjpJHjbWgAhjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636899; c=relaxed/simple;
	bh=gy8GNA9gy1ZCTINiybTx/C9ke2pX0ptvQ1WPaWEqBVA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fTxl/tW+etUgBhp/rA7FUAkDdGfwOoqYZtBojfmgLIecqcoi95Tj1YS8+bzmLMUDmMx37HGDTwJ8yNnAC/20JQFGa9PMo5i+mczW9BT4HOMngKgyoyd2Olc01sWzKjMZd5IGrSC+p2D3ktdtP5Z1wml3+LoYfeh6vyzADTUquac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qRN7+nv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qRN7+nv"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfab38b7f6bso2194522276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636897; x=1720241697; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0v3fokev8dqp3wp/KzvIIEo7fWRsPgHRVVSDRon34u4=;
        b=1qRN7+nv8eQRrS6T1oS39W0CDdSDY97p+XM0q6PvdSH9z0XNotEVlo600ljk9v4Amm
         lm6lZ0sugn6DHtV9GtCIRwGWCbVNSBdn/UMH1Um6jJX7mJc5Y7KRfFsAVoMRGJQguWbJ
         6k25lpWP6+KBpu/q/Rc7/urCsn3bLrsvLWl8QQAkmXqaPRLSkDiVbLHAAkZHLWxattTL
         BB6rd8ugieU4cs7RefK0HPYXLxlCJHPMN1HSi3n3NsOYU7WYXEx60yoi53rilBx44Klt
         2KGhbVIFcliN5mKH+Xbi6CjLCK6MdVYmFNCic6V85/0MeEiHsqTqVGgkV9pSGl1ZKFAD
         94+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636897; x=1720241697;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0v3fokev8dqp3wp/KzvIIEo7fWRsPgHRVVSDRon34u4=;
        b=X/XOrqyDZbAwp+sY2A6msez0xzofKMl2ja7jjuy+BTpGAe/yjn5zOMWUQJNDPjDtB2
         vL2eWZZEPVZ4uuFyS6ck9JuDe7WIV4chZTP8sd6zx0Esa5bFPEptTei01MO1LnKTsaaT
         omRkA43yNuWuCKo3f+wWn6HFaYNLWRJpjX6ibFcd+0W6//xs2X3cNKdkk/ib0NqDi93s
         Q3/JEUXBxxHEDwHJgYmfDI7IujfaQEerui6Veb3NArpo8ZAXS63rqC6z6AaWsgoS+rCW
         wwUlnCuDigABut6ZB3vmcwtVGrWLo3k1tywRCM4l3jT3VqorFQGfXOzkvlOTakRhek4M
         5K3A==
X-Forwarded-Encrypted: i=1; AJvYcCXz1uhLEBAcKv8npqM4lFoi+zfdex0bBUBZXUafuLQhAIKb0JfkfTGQ+qAxNJf1TTj074pNvRpys09Uz8sIJadpegKpXyawTg/BCU0RGEWFdw==
X-Gm-Message-State: AOJu0YyoyayradDX0GzbD6vEnQsM76z3YCmN3M1TpX7qLv+XJl6C0oMQ
	rIDyqhBJKOy+/6pi+TSaHF6XM2abBfsnVzqVBpk6i+mom1zJEL+PmwcY0SdN65cbU/aebMRNkky
	QKYfDlw==
X-Google-Smtp-Source: AGHT+IFebbTbrBD46jrbbAKmEiQhr8CIpwzw2fa35jGiBLO5MmgTjOTYHAA/dOn6kgN3PXW8P1kNAUf1baWR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:724:b0:e03:31ec:8a24 with SMTP id
 3f1490d57ef6-e036ec2e117mr860276.8.1719636897584; Fri, 28 Jun 2024 21:54:57
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:44 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 22/28] perf diff: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-diff.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 4c0567882a7a..28c5208fcdc9 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -467,21 +467,7 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 	return ret;
 }
 
-static struct perf_diff pdiff = {
-	.tool = {
-		.sample	= diff__process_sample_event,
-		.mmap	= perf_event__process_mmap,
-		.mmap2	= perf_event__process_mmap2,
-		.comm	= perf_event__process_comm,
-		.exit	= perf_event__process_exit,
-		.fork	= perf_event__process_fork,
-		.lost	= perf_event__process_lost,
-		.namespaces = perf_event__process_namespaces,
-		.cgroup = perf_event__process_cgroup,
-		.ordered_events = true,
-		.ordering_requires_timestamps = true,
-	},
-};
+static struct perf_diff pdiff;
 
 static struct evsel *evsel_match(struct evsel *evsel,
 				      struct evlist *evlist)
@@ -1959,6 +1945,18 @@ int cmd_diff(int argc, const char **argv)
 	if (ret < 0)
 		return ret;
 
+	perf_tool__init(&pdiff.tool, /*ordered_events=*/true);
+	pdiff.tool.sample	= diff__process_sample_event;
+	pdiff.tool.mmap	= perf_event__process_mmap;
+	pdiff.tool.mmap2	= perf_event__process_mmap2;
+	pdiff.tool.comm	= perf_event__process_comm;
+	pdiff.tool.exit	= perf_event__process_exit;
+	pdiff.tool.fork	= perf_event__process_fork;
+	pdiff.tool.lost	= perf_event__process_lost;
+	pdiff.tool.namespaces = perf_event__process_namespaces;
+	pdiff.tool.cgroup = perf_event__process_cgroup;
+	pdiff.tool.ordering_requires_timestamps = true;
+
 	perf_config(diff__config, NULL);
 
 	argc = parse_options(argc, argv, options, diff_usage, 0);
-- 
2.45.2.803.g4e1b14247a-goog

