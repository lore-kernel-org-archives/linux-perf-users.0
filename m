Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEDE2EE614
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374832; cv=none; b=RLyN2Ti2bfW6hHYJ+y/gJnb8xgVz/FWxPSTjcj951d4MBwRWTDQuOvMANapbx0CygM22s3ZVtrvriJJJsS+a0I4QYQEkRicrxLQ62a/V0NqSkt3qB4iMVv0NSkQUUJsuHhs2PMgilvYGVblHXghElssR1H6yWh/Stxj/KJXcHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374832; c=relaxed/simple;
	bh=M1y3Ccv5wcC/FlJvlmEgkQTMj66snv5y7BAiZnAjazI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MEioVayeiaxoWExSN06nSEiZb02kZyjFtlOTK2gzYul22CWrXig+9ito5cpttLs5FgU72ZpaeR9592qZxdtbK4m76WEv4HcOfKynO+41tvnXUwNypva3ckxvsjmNXpNvwRskHCuPNclna2tG3m+cMMgiBPAaOXGg3jWvxfhSCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0F9T4dHZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0F9T4dHZ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso2125441b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374830; x=1753979630; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDeRluXdBwCYopmgtwRgx8UAXiSsbc3geNmQzma7A5A=;
        b=0F9T4dHZsFflH6udPW/DSz+QcpTcULRnKSex7OJUkEfEBZhBLdz5AoKlfcgb4NpH+n
         KWucWGPQ+mZHzkC/UyA7p1CwMRpT4twBTuE+vdzG+q0io/AaDC9rlrbKLKP+TIyOf3nA
         wPEelwLFkOCyAe/WwZy4thUwiGzMmDPhlY5yj7+YqFpOy1x3nMwxeTVvTWMrXrpGLFbX
         MXE1nawoEKLeSIvIsjPERjOyLCZAoxDGNtybujFOG1nbmhj9Tv1T5MUa0S2ryUpYnSbP
         c9ST6yf+54R5zX43hat6ReRgqGYu0Jso9zCnvUmJByefRkxSHhwy4VtvkcRYEkILxWkH
         i7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374830; x=1753979630;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDeRluXdBwCYopmgtwRgx8UAXiSsbc3geNmQzma7A5A=;
        b=YOw3dj/qY+IN8MOM2Spy5J1VR7bwbSeTx04k/FWOaZslfs41ncmpdaQgpLj1dnpNAn
         ky3e3dXURwf40GV81c86fxzXFIGUV2139UAS+q8UCMROscli7WvGKtyKXhKwXFB/vlyT
         4tGDrS65nXHEOG8SN+kGOnJoJ9xzskJsRXQm6lOtUe/kXsQ5CSl78owdVzKH5BOIFLLM
         5sJFwEBloO8up/V0lkGRddG6dBM3GCUHcwhty+UBpjRpq5UyiO1pcHyTABKAWSRAOLBG
         pp1LO3EWurSycEirRe0taEUB3cqkfjtaPmLYjJ4gHZRw8K/uuhnm38XwobrSXhNcG432
         HQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVETvInNK5+NtNlPYjRg4GDqzQ14UF+qCRVr52bjcmQPdDclGVRtdRTvQIB4tJywRnacgiYiUZJRN/U/+DvAA2@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMfwlOLmk924REU+NNJj/UuL3g2pReS8lgaiTmJHyqK30TUsk
	gxnvxV+eDR74LZ61dcszlT8JYCmtwmGh1GfrGqWxVytgJJSEYeIDi6F0fqyTJhfK30vr22VS4Sh
	LECsDO7MJyA==
X-Google-Smtp-Source: AGHT+IE5otf6xpjAUYQYmChzsncjQN9CdKwppi9ARvo8Df52CwrBGA3qyM9fysoiTGRSjVSItiZ7IO/2pR+I
X-Received: from pfvf6.prod.google.com ([2002:a05:6a00:1ac6:b0:747:a8e8:603e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:815:b0:740:9d7c:8f5c
 with SMTP id d2e1a72fcca58-760356fbf25mr10861518b3a.18.1753374829698; Thu, 24
 Jul 2025 09:33:49 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:54 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-15-irogers@google.com>
Subject: [PATCH v6 14/22] perf top: Make perf_env locally scoped
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

The use of the global host perf_env variable is potentially
inconsistent within the code. Switch perf top to using a locally
scoped variable that is generally accessed through the session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 41 +++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 2760971d4c97..e9743f17bd0c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1301,7 +1301,7 @@ static int __cmd_top(struct perf_top *top)
 	perf_set_multithreaded();
 
 	if (perf_hpp_list.socket) {
-		ret = perf_env__read_cpu_topology_map(&perf_env);
+		ret = perf_env__read_cpu_topology_map(perf_session__env(top->session));
 		if (ret < 0) {
 			char errbuf[BUFSIZ];
 			const char *err = str_error_r(-ret, errbuf, sizeof(errbuf));
@@ -1624,6 +1624,7 @@ int cmd_top(int argc, const char **argv)
 		NULL
 	};
 	int status = hists__init();
+	struct perf_env host_env;
 
 	if (status < 0)
 		return status;
@@ -1637,14 +1638,19 @@ int cmd_top(int argc, const char **argv)
 	if (top.evlist == NULL)
 		return -ENOMEM;
 
+	perf_env__init(&host_env);
 	status = perf_config(perf_top_config, &top);
 	if (status)
-		return status;
+		goto out_delete_evlist;
 	/*
 	 * Since the per arch annotation init routine may need the cpuid, read
 	 * it here, since we are not getting this from the perf.data header.
 	 */
-	status = perf_env__read_cpuid(&perf_env);
+	status = perf_env__set_cmdline(&host_env, argc, argv);
+	if (status)
+		goto out_delete_evlist;
+
+	status = perf_env__read_cpuid(&host_env);
 	if (status) {
 		/*
 		 * Some arches do not provide a get_cpuid(), so just use pr_debug, otherwise
@@ -1661,18 +1667,24 @@ int cmd_top(int argc, const char **argv)
 
 	if (disassembler_style) {
 		annotate_opts.disassembler_style = strdup(disassembler_style);
-		if (!annotate_opts.disassembler_style)
-			return -ENOMEM;
+		if (!annotate_opts.disassembler_style) {
+			status = -ENOMEM;
+			goto out_delete_evlist;
+		}
 	}
 	if (objdump_path) {
 		annotate_opts.objdump_path = strdup(objdump_path);
-		if (!annotate_opts.objdump_path)
-			return -ENOMEM;
+		if (!annotate_opts.objdump_path) {
+			status = -ENOMEM;
+			goto out_delete_evlist;
+		}
 	}
 	if (addr2line_path) {
 		symbol_conf.addr2line_path = strdup(addr2line_path);
-		if (!symbol_conf.addr2line_path)
-			return -ENOMEM;
+		if (!symbol_conf.addr2line_path) {
+			status = -ENOMEM;
+			goto out_delete_evlist;
+		}
 	}
 
 	status = symbol__validate_sym_arguments();
@@ -1735,7 +1747,7 @@ int cmd_top(int argc, const char **argv)
 		symbol_conf.show_branchflag_count = true;
 
 	if (opts->branch_stack) {
-		status = perf_env__read_core_pmu_caps(&perf_env);
+		status = perf_env__read_core_pmu_caps(&host_env);
 		if (status) {
 			pr_err("PMU capability data is not available\n");
 			goto out_delete_evlist;
@@ -1829,14 +1841,16 @@ int cmd_top(int argc, const char **argv)
 		perf_top__update_print_entries(&top);
 		signal(SIGWINCH, winch_sig);
 	}
-	top.session->env = &perf_env;
 
-	top.session = perf_session__new(NULL, NULL);
+	top.session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
+					  /*trace_event_repipe=*/false,
+					  &host_env);
 	if (IS_ERR(top.session)) {
 		status = PTR_ERR(top.session);
 		top.session = NULL;
 		goto out_delete_evlist;
 	}
+	top.evlist->session = top.session;
 
 	if (!evlist__needs_bpf_sb_event(top.evlist))
 		top.record_opts.no_bpf_event = true;
@@ -1851,7 +1865,7 @@ int cmd_top(int argc, const char **argv)
 			goto out_delete_evlist;
 		}
 
-		if (evlist__add_bpf_sb_event(top.sb_evlist, &perf_env)) {
+		if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
 			status = -EINVAL;
 			goto out_delete_evlist;
@@ -1873,6 +1887,7 @@ int cmd_top(int argc, const char **argv)
 	evlist__delete(top.evlist);
 	perf_session__delete(top.session);
 	annotation_options__exit();
+	perf_env__exit(&host_env);
 
 	return status;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog

