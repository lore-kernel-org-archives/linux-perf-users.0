Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147721FF41
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086274; cv=none; b=g9b3iOPyZEgI1Wa6paZjyUJ+cP7tqEOatfBctM5z1z6LSHFD5j3z4HOjr2m0sZpOynG/yqg82nkFXiizAVXtp1mSUlv/YjxlMJt46LZJu34ayJbsRS1iOzIDtrXIIP7XCVe3WPU0Nw89vBDM3wfEhekZy/GiP30VdxTCTNf3C38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086274; c=relaxed/simple;
	bh=8RWUW+TcnFEXdNv/Uk32ZicFePVvRTy5c3CKcsXSp68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SbOORVdDiVW4arq8AoD1Sf76P0VP3Pujn07+UrHEi4cXpzple+xx3SfeqT9TZlJyBwYEZ2D4X4E21nrNm0KW4WTQRXU25didsoX4fBmdlY3LBAgB63+ogGNIZD5h1koGI44hZ32le9KGuJQ+AnFmW2qFCH+VFXe3Hlr1uZAMTRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+ATd3wT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+ATd3wT"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74ad608d60aso503323b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086272; x=1751691072; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C96JAGkPAc0LFzD2iy/4OszeuhNF3cJzB9GEOz3PGEU=;
        b=g+ATd3wTm+AhW98ipVEBvO0saYfjNdSpxM1BQJdOv/qatLJ7vb3r2U6DG0UiQf8ZWd
         SRKYnQ/WsJMTW4kHHpGhdWBKKHbO+4iAkdUIbprtskOSn0mW92FQ1xERcFH7PEwXRK5P
         ph1M32a8veR++oxO1KuRbtRK7PsiPmIx6q2g71HD+oFqPD0IRihqP+Elb5ZUsRJUICoR
         qIk91e4uVsCYnzNxojCt2HqGEfWTpl6Bna1Z0HUayscyVLCJXLo+bH+XEFQ5SnF9I5iP
         8HQ9WqXSSPPAzuxePQOz/KH3QL5teL0iqnS0td6M+jmIL9Mxwq6ybeTzmMDpxd1k8Mv6
         tPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086272; x=1751691072;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C96JAGkPAc0LFzD2iy/4OszeuhNF3cJzB9GEOz3PGEU=;
        b=N70AX716EZ3mzSd24EUCLM6cqYYYGt8x9wcEuGRC87P0Fc2aBOZc+eWSbBfZcdfWbV
         0DXrFPI0wiaqwOvjLdXz4VZ2a9ivx65ynarOl68iSiWOT5pmtVhCH6Bphfcp6AN12guz
         aDfm0OFh1AJ5ZSkQV55y9K+D+h426v88OZvXBb0UC0OUVZUQR9QZkKVo1R1SFQGuEpQc
         kqTv7eNEF9sJrz6QxBg/mYtx/V1iiYUEUGQerDOn6sAFcfVXwx1BJBkD36u3ZUlWdJ3c
         isn+4psJKHtn1FrRtzoXiYFzB6A07Nm6oTcfjlbQYg7k/Y2fdjaahEKqCu3gUHIeNGB5
         ODOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Kou4UWA5Z8T+SeMZRORSUz6eta6DB2XZ0LAxqbKMNJ9FXaFeFNwA+vUUlubZcKPXBohMXpTOpappHu/FyxSe@vger.kernel.org
X-Gm-Message-State: AOJu0YyihnLRvccKY0kOV/V2olFJfuigUSJSha5DAdYl1b4bnVb1K9yZ
	CmyrbMPXTKhpSqR76xstQIr7fv4nB18FVMyAL+RUo5mzXXT8O8oDXm4G+QNTzEIBU+oGhZPNVQ2
	GbWdstwuABQ==
X-Google-Smtp-Source: AGHT+IGfUVNUkCqHuooZSLSEIRDc4HHAGWz/NrI5PdI1bYekJaTo1T5722lSTuTm5psui7KE8iVyedV6kxV8
X-Received: from pfjd20.prod.google.com ([2002:a05:6a00:2454:b0:748:34d:6d4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f93:b0:748:e0ee:dcff
 with SMTP id d2e1a72fcca58-74af6f22819mr8017717b3a.11.1751086269923; Fri, 27
 Jun 2025 21:51:09 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:50:09 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-16-irogers@google.com>
Subject: [PATCH v5 15/23] perf top: Make perf_env locally scoped
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

The use of the global host perf_env variable is potentially
inconsistent within the code. Switch perf top to using a locally
scoped variable that is generally accessed through the session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 72f9be5a3b30..d84daeae291b 100644
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
@@ -1639,12 +1640,17 @@ int cmd_top(int argc, const char **argv)
 
 	status = perf_config(perf_top_config, &top);
 	if (status)
-		return status;
+		goto out_delete_evlist;
 	/*
 	 * Since the per arch annotation init routine may need the cpuid, read
 	 * it here, since we are not getting this from the perf.data header.
 	 */
-	status = perf_env__read_cpuid(&perf_env);
+	perf_env__init(&host_env);
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
@@ -1821,14 +1833,16 @@ int cmd_top(int argc, const char **argv)
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
@@ -1843,7 +1857,7 @@ int cmd_top(int argc, const char **argv)
 			goto out_delete_evlist;
 		}
 
-		if (evlist__add_bpf_sb_event(top.sb_evlist, &perf_env)) {
+		if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
 			status = -EINVAL;
 			goto out_delete_evlist;
@@ -1865,6 +1879,7 @@ int cmd_top(int argc, const char **argv)
 	evlist__delete(top.evlist);
 	perf_session__delete(top.session);
 	annotation_options__exit();
+	perf_env__exit(&host_env);
 
 	return status;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog

