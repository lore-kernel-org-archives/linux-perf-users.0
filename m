Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01E1C174A
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167839; cv=none; b=oBDu22oI8Y89S0TggkZuodoayFiLC+nA8Scdioak5Q492azPYmi6RMbSwYrcDK7ZeKi/5xGbRzU9kN39ryrbOzEqeOCxlSb3yaH8x0GsNlUFJKXJP9gc/JzLINpfZ9KugYHwGBbaywz0Sh3My6qFebG6avqhns77ax/f4JTrZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167839; c=relaxed/simple;
	bh=Vk535oLjOoVnV6GXf6fF06oFHm6U/y8aVOQzLJgw0ks=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eEpXY2A6MONhdxGaEnoZiv0iaWzCU0PI3AmEQ6wZjAJUVTrF1d/HiJJdOshQCXccDJIKfJOrCB/MtP4fT/XByoAieGczCd5dNgJteqk+5nube1+x6+R4vchwYGlmk3DDivfh2TvdR5Ir63CVN4AgpBVkGvwRhrboSf+H5UHqrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ZRW/bG/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ZRW/bG/"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d3aa5a6715so3278627b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167836; x=1726772636; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nv46Pxr4RqOiUfocd6lnckQ6oaO49PAAJVzHx2iL/LI=;
        b=3ZRW/bG/1Kw8xpkWQvAb16sItUCWyMDKtgP49iwFKFUsKbz+1B9+v7BMkv1IFenJpW
         g6Yn9kAV+NEMzhNDIS4xe4mtzcCNosjvwiOwRuLlulNiPv4MrM6kZI4Ar3RFexGC6T/J
         PoQDyFN36QKXsiHLtY0fNgnNJod6X21R6v4a89BgB73b4Njuxrh5ZYA+zknt8ULxAw1w
         fxJICM72+Xu7LC8S3gEypNkulfNf4C74WVZBIe2nSiQZ4rgeeiIb0sEYC6Hfx46/3Rll
         9O72V5uX6BaDms5KFH44TZ9x43xBDEGyT/8WsFkyaRN/dSVnbOj3rB9Z9+7LVSATmzF8
         QczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167836; x=1726772636;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv46Pxr4RqOiUfocd6lnckQ6oaO49PAAJVzHx2iL/LI=;
        b=Uo/D+TIyR/tR3h7Bmd0ZW7bFInSLONkcR/xgTItuSuVk3fd/CFuYEZrkFkqIL1o4vO
         bM05MA3qHtZ1bt3/yE2HPOAs6j2/2ePU0HXOM82SsG65U2qK7ns2aIFnEQ76UmW4Np0T
         7ClKYf0yVk5aE1SQNukCHR8s33xmQWIOMYfDWFgVtE9iVsNNK6xgAuv34vaxUR1CLFxm
         fFv45IZo51zW970nzJOuSul0/EjcjU4C4W7XolpCiuMoemvnc5EZPyB+hRuFf9PAuMtk
         LNJq+mmgoulzdVtdhb/0nm7fNvy9zbHX1UosDAUSErveFuDagOyIrwdKlYY+cLy7sbxD
         R8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7szP6dJPYv0ILp8wqXHObPbHhe/pjeB+NCjIfso5GCspGJdypm3VQyFVivElzmj4YfKydk3KSoA77eu5GrF0T@vger.kernel.org
X-Gm-Message-State: AOJu0YyT7txcWd/HPW2vCrlKlpkDhWYlks7c9yn5QuRSZQw2FO7Sw2JK
	I41yw6Tl4BWtEnDhtHlKBtmNq/5TPb/rP0ojHee+tCVZedbyc4xUCnC4ro9AWnB074301j+YUqm
	//neS8Q==
X-Google-Smtp-Source: AGHT+IFHO09bW2w4OpHfnI1mvLyMuz+jqvEx61veclezxCDRJ5X1P4hSJYcP6uZSfsVCOzJE/dx5n6NbJdWI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a0d:c641:0:b0:6c1:298e:5a7 with SMTP id
 00721157ae682-6dbcc584e0emr97147b3.5.1726167836594; Thu, 12 Sep 2024 12:03:56
 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:30 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 03/13] perf parse-events: Expose/rename config_term_name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Expose config_term_name as parse_events__term_type_str so that PMUs not
in pmu.c may access it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 20 +++++++++++---------
 tools/perf/util/parse-events.h |  2 ++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 26bbc6f603ab..776812460dad 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -794,7 +794,7 @@ static int check_type_val(struct parse_events_term *term,
 
 static bool config_term_shrinked;
 
-static const char *config_term_name(enum parse_events__term_type term_type)
+const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 {
 	/*
 	 * Update according to parse-events.l
@@ -880,7 +880,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 
 		/* term_type is validated so indexing is safe */
 		if (asprintf(&err_str, "'%s' is not usable in 'perf stat'",
-			     config_term_name(term_type)) >= 0)
+			     parse_events__term_type_str(term_type)) >= 0)
 			parse_events_error__handle(err, -1, err_str, NULL);
 		return false;
 	}
@@ -1004,7 +1004,7 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	default:
 		parse_events_error__handle(err, term->err_term,
-					strdup(config_term_name(term->type_term)),
+					strdup(parse_events__term_type_str(term->type_term)),
 					parse_events_formats_error_string(NULL));
 		return -EINVAL;
 	}
@@ -1127,8 +1127,9 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
-						   strdup(config_term_name(term->type_term)),
-				strdup("valid terms: call-graph,stack-size\n"));
+					strdup(parse_events__term_type_str(term->type_term)),
+					strdup("valid terms: call-graph,stack-size\n")
+				);
 		}
 		return -EINVAL;
 	}
@@ -2568,7 +2569,7 @@ int parse_events_term__num(struct parse_events_term **term,
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = type_term,
-		.config    = config ? : strdup(config_term_name(type_term)),
+		.config    = config ? : strdup(parse_events__term_type_str(type_term)),
 		.no_value  = no_value,
 		.err_term  = loc_term ? loc_term->first_column : 0,
 		.err_val   = loc_val  ? loc_val->first_column  : 0,
@@ -2602,7 +2603,7 @@ int parse_events_term__term(struct parse_events_term **term,
 			    void *loc_term, void *loc_val)
 {
 	return parse_events_term__str(term, term_lhs, NULL,
-				      strdup(config_term_name(term_rhs)),
+				      strdup(parse_events__term_type_str(term_rhs)),
 				      loc_term, loc_val);
 }
 
@@ -2709,7 +2710,8 @@ int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct
 				if (ret < 0)
 					return ret;
 			} else if ((unsigned int)term->type_term < __PARSE_EVENTS__TERM_TYPE_NR) {
-				ret = strbuf_addf(sb, "%s=", config_term_name(term->type_term));
+				ret = strbuf_addf(sb, "%s=",
+						  parse_events__term_type_str(term->type_term));
 				if (ret < 0)
 					return ret;
 			}
@@ -2729,7 +2731,7 @@ static void config_terms_list(char *buf, size_t buf_sz)
 
 	buf[0] = '\0';
 	for (i = 0; i < __PARSE_EVENTS__TERM_TYPE_NR; i++) {
-		const char *name = config_term_name(i);
+		const char *name = parse_events__term_type_str(i);
 
 		if (!config_term_avail(i, NULL))
 			continue;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 10cc9c433116..bbe6c5700828 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -162,6 +162,8 @@ struct parse_events_state {
 	bool			   wild_card_pmus;
 };
 
+const char *parse_events__term_type_str(enum parse_events__term_type term_type);
+
 bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 			      const struct perf_pmu *pmu);
 void parse_events__shrink_config_terms(void);
-- 
2.46.0.662.g92d0881bb0-goog

