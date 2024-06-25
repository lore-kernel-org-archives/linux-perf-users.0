Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512B17B4EB
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336427; cv=none; b=gfDYjbdx1wLXjq/NCrErlzpE12UhFNxpcLqsu/4sN9N26KuTfyxWoyuzBmPAiwf4Had+AETNwVs1EdnBgORfgkn1miA+DyLcswiyLPxx/Z1iDYwd0QKKIYpLlrxIEoi0jZTFU66EtWnmpc2Mh7PqwIhJcgdrGjL5f4NVinqxfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336427; c=relaxed/simple;
	bh=k7QXVgVjC5ziryU8iqEZw+jIGB8CNwx93bpexssSTVM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=V3zUpssxab8K27yWm8L2g7LTwwalBDrC8yY1U3T6qYcvMGs2z0UM0xP5Da80uNUzIIVpPOfTgzC/HrY21yQiNr4FQPiC6kAfDwjw68XPSv5SJcWw9T/EbGgxFplsx+JzkK+cVZjdFiPvEdXxjTKTrKO/smDaNIQQH/ajecof7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xLc3JCJm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xLc3JCJm"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-631b498f981so105202387b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336425; x=1719941225; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAL+qN5eeqrm/YV9CC2nA0bNTj605bqM/+2MNtl5Dek=;
        b=xLc3JCJmqV2S0+8H7YZV6O1/pqmfnOeYtGfsAmzxk8Yiv9PIrIUmyW+ZRH8MtZkt/c
         GNVlSZvCDEo6rMfEmLeEBDpvWcIzdPMR4POANFLh3E6FTyKRxfmx4sR97GScZInxpDOk
         Kpud/mWlellw1BKYPu6l+gflkxdOntKqtPguIKQl83FW5RojcpaOkhZl7xuh16G+AnFl
         QWdBsXYmgHRgiqdco1x0HTH6q8KKoG/Nq8DglP+lmXJWp4gxgdSb3+2BuRcV0mLpyX0O
         /fpX+rlxKK65jeHCUG/QtaeaB7JBWhNiX8QjeS6L6AvR+5zgUqgYukOPMH00etCFpydq
         2rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336425; x=1719941225;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAL+qN5eeqrm/YV9CC2nA0bNTj605bqM/+2MNtl5Dek=;
        b=TlKuArNOsbyUifBeE9bkeiSZEZXLXGndyTLUO1fLg8XP1AoPbnyyJYMItRoSYdVaZq
         y5HPOmAOfPlsfcBlD5NtGb1xH1f9Avoq7YfxIhejsOnrtu5hZQnpObZfq0MK1e1h+djO
         JrMMnR6BDO1H3IX01GMfRWVLj8AgdR3aacaINGQOBSiFhryfGEyvzoJbF1MDatGAFvGv
         klQ6+q5amdn9Ftqm7lBH7V0Vcf6rL/VVbMwb9/64vAuwwKctG0O0d3Fqz7qtKPakDM09
         VKTw6Bg1iUFGPJaKnx65eMo9M8lKxEpa6N01ap1QT9i7da0aarYJlAMSB12JQv4meooT
         STWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1rxuHRSTzxgmCiMFDJYOddsGEW3JgHc+CdeOR6YtuPK8wdtyyj2NCLyKrbZOuxWe97gVQCSMF/sORluzjLMMtlSKXM2IlHOfeN++Jpx2wIQ==
X-Gm-Message-State: AOJu0YxTjVgtJ6UhH6Q7W2MvLFJExxksUNa/udQobcXpFH1uRZeQUJ0U
	lRO3J8KGVS3L25FdCzUDJKtHLRbifOHQt4QtMCdQX/WEOypNyKHivUDJeakke5+TWPMrpZUmm4R
	GwKoSJw==
X-Google-Smtp-Source: AGHT+IGD6NROzE2EHc5jjqSHDQHS8KekgYNdRcbDS/mIM8HTKqE/Qyr/e8zZMvz4P4dAQ8k6OBlvKbOYHFCe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:1201:b0:e03:2583:13e4 with SMTP
 id 3f1490d57ef6-e032583168cmr45685276.8.1719336425108; Tue, 25 Jun 2024
 10:27:05 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:26:01 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 24/26] perf kwork: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8ffaa80a2d1d..6a4281b8fd10 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2322,12 +2322,6 @@ int cmd_kwork(int argc, const char **argv)
 {
 	static struct perf_kwork kwork = {
 		.class_list          = LIST_HEAD_INIT(kwork.class_list),
-		.tool = {
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.sample		= perf_kwork__process_tracepoint_sample,
-			.ordered_events = true,
-		},
 		.atom_page_list      = LIST_HEAD_INIT(kwork.atom_page_list),
 		.sort_list           = LIST_HEAD_INIT(kwork.sort_list),
 		.cmp_id              = LIST_HEAD_INIT(kwork.cmp_id),
@@ -2462,6 +2456,11 @@ int cmd_kwork(int argc, const char **argv)
 		"record", "report", "latency", "timehist", "top", NULL
 	};
 
+	perf_tool__init(&kwork.tool, /*ordered_events=*/true);
+	kwork.tool.mmap	  = perf_event__process_mmap;
+	kwork.tool.mmap2  = perf_event__process_mmap2;
+	kwork.tool.sample = perf_kwork__process_tracepoint_sample;
+
 	argc = parse_options_subcommand(argc, argv, kwork_options,
 					kwork_subcommands, kwork_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.45.2.741.gdbec12cfda-goog

