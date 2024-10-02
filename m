Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5762F22
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839227; cv=none; b=JDk/GkQEBW9OFv32kYfZVKjUYAfjKpgbioQGtQYZGAn2ZjR9t61p20bBI4o+4MRcUwzUj3tlHKeuIF51/bhswPAf4Wy0HwSuiIW2tVFDz8gbvJdUu0iOhfuj5sCf7l1xzDKA9QbnIci5+rzEDOuQm8e4YlSR27ccbycMrb4+t1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839227; c=relaxed/simple;
	bh=Z0h5c1P0yeBhm5Am9G6JjbqtoJL+eQh4PwduChMZ9UI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uxHdE3WabWmxDHxshMrn1oxIudJK5JaP07Zldo019dwi5sKAKA5gY+IswqsvDlnV3vhutzW6lcExjvIOeECSVPQWXobh4L35D1ObFwi+hSOWDZKCmq7ojhfDjqsi5yGgt0me1ZLTZVXjZl0lxdYoKo8Hk1zqWbpjdtm4cYQ7vmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFzNJevI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFzNJevI"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e29b4f8837so6536377b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 20:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839225; x=1728444025; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlqVBWAOpVfJanfv4s+m+V064r/fmGnZe909uVEp74Q=;
        b=FFzNJevIRBYbarn+yFm4lSAD+eH7A8qZ1d2QYfz2+J5ql6DsrGvrYC/8pQYqSjXxZT
         67wXoeEstlxnvePIEb7R0cX1vt9+MRJUTpEg5M5ZHnPEua54k9kIIqNb+mLgjDNasUUI
         9XN/0C63fwMhHbZDx0EVqA1Xid6FpX1yQ6uoDY08kN5zGrtrRlfjtjIVdRNOpno8Sa4A
         rr1E4QHQUbllEJDXK8J3Sl5uVDGUvwt44nwbdPHHP7xc/Aowk5ZOKXvR7PeS+g/9tdUA
         IPzslAqmeKFdSF4AEo1JlnvcC02+NP20Z7j3Gx0RJpA44y/FXT3sr4M3+HeK26VDMAkC
         PJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839225; x=1728444025;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlqVBWAOpVfJanfv4s+m+V064r/fmGnZe909uVEp74Q=;
        b=YePpA8Mf720TQW8xZk+dqbdb9WjBuFnocHW4FStWGx21N6Z8PdS8TZiuFKtpo/Yb5A
         r2dGOvt+rv5YTwUpUHOumQeH6qrmnhrJu46WcfJxDQpy9AAYw84LxjN5zd6FAjq/vVwu
         1xH/AZwc6FoIMFXG1+EokN1ALRC9pXnc8M5EiYvj8+L+sKX3gD22S6kUjNQMu+3rk38X
         iAvBfU0fUuXBMWGD8cym0aXmZSjTLfc1sR1e+r2Dxxg+GdwlUdKwYdSykSb2/p12UT8u
         QPW8zP/NsXULTmzLk/RpncUuUwOuLPCGD37pytpxgQac1I/ybzvRBcs1zxOJsdREFf8n
         8Jbw==
X-Forwarded-Encrypted: i=1; AJvYcCUOpb5LhUnMON2DKtqsmTuj2IJhL9SZjM8JipV6OcZS1bq3j699rMzuYkn0VOUDTo5jhD6dQq6ukoWI+D10ggO+@vger.kernel.org
X-Gm-Message-State: AOJu0YxaP3n7I4O87mi1LI8XS5fbFL+tFGB1Qra8lF2cS8MiDP+f/atN
	W+dYtbPO/lK5cq+NOblbtXzlwuNuzEegJuJxVIPmMwIp/ZXdzvyiVlG3swe6oyzMEgZZbTUi6o+
	LM6SD3w==
X-Google-Smtp-Source: AGHT+IGzuGaCwhO4F5RbpJtWD80jojIRLpMbMtUnTcgGgB1r9Jr5pkreMHPYLvjuBmCRnD7/UJ/Wuc0bIOVS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a05:690c:64c9:b0:6db:e464:addc with SMTP
 id 00721157ae682-6e2a34b7328mr410007b3.4.1727839224568; Tue, 01 Oct 2024
 20:20:24 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:04 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 01/13] perf pmu: Simplify an asprintf error message
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use ifs rather than ?: to avoid a large compound statement.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/pmu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8993b5853687..cb2eb2407de5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1466,13 +1466,12 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 		if (err) {
 			char *err_str;
 
-			parse_events_error__handle(err, term->err_val,
-				asprintf(&err_str,
-				    "value too big for format (%s), maximum is %llu",
-				    format->name, (unsigned long long)max_val) < 0
-				    ? strdup("value too big for format")
-				    : err_str,
-				    NULL);
+			if (asprintf(&err_str,
+				     "value too big for format (%s), maximum is %llu",
+				     format->name, (unsigned long long)max_val) < 0) {
+				err_str = strdup("value too big for format");
+			}
+			parse_events_error__handle(err, term->err_val, err_str, /*help=*/NULL);
 			return -EINVAL;
 		}
 		/*
-- 
2.46.1.824.gd892dcdcdd-goog

