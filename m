Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F151A5A8
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jan 2024 05:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yc3N+CgR"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e74c97832aso135475447b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jan 2024 21:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704258452; x=1704863252; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WsFfZjtyQ/vupuXNWc6ZaFgCOFnGSemPyorRcK3/9uQ=;
        b=Yc3N+CgRsfmVD3fK+PN/3QQXCzRDDO3X8QgbKm9d+rIJawHXUP8XQKsSkJCa9h0bw6
         BvY0hjMkQxBNNCCU4TgQZWCWTNjSxixbQzS7veKYwy7G7zK1j7N+OWhSsMis/8EuO+uS
         uAdhCIOhCsXIbe80KiBR0Dm72KFcnNnGIFItVlGrtT2rEAhoWIstSTBa75EC4DqRPHPW
         UJc2LY126/c+/EhrNpkwXeQzSRI83NGLKkcVCqcY4uxQX6h2Uy0TfeKe9Rqe1kqhtVEI
         1jeJrqE2xhHQGjr3DtnG67qYYTbPH4Lr76/z/rbST89krL1iUWjzrq94khW3a8o74YlG
         QNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704258452; x=1704863252;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsFfZjtyQ/vupuXNWc6ZaFgCOFnGSemPyorRcK3/9uQ=;
        b=vWmheH0eWvvBOwKynkU4+COch5ThM4Z+9gRGd7zKevFkdyX/7BRWzB1J97pZu2de4A
         oI+neOm62EqNoSN2vrVKhrR3LHGUuCIbF+4V8VrTyqhEGNTLiw8j9VXlZB95RUqiRrsY
         uCZwrdhvlJqqndvFbza08L0/TsjMuaoGaBHQvFkWY7pXI4GVC78RkbP8e4j/H+gvm0E7
         JLziIfJxRRkEfKsAUozGQbHgfp0kBZ3b8am8HzvEFzFFxmckCd1xoi1tuW6eiRcWxk2i
         k66SZYUelHOrtjm+pllaiuPeerJpZU3rRwfR1Et4gWsOAWtFgKCynkhWsnHgavbDRzpg
         EEeg==
X-Gm-Message-State: AOJu0YwLToexgui47p/qsl0W/1obfib1OHP2k8MADgOPLd5IycacsQ/N
	zmetDzEvfS/Pqd2crmZ9EXj2avFq3XSir772W6c=
X-Google-Smtp-Source: AGHT+IGaUvVt/aSvel6vIpjHau735vBHOw5/xaxzHy3M1MdAbR3W9UcTxRMpSxwlVCBsILDt2NfuLqsWcUha
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a05:690c:c8a:b0:5e8:c4b6:9b5a with SMTP id
 cm10-20020a05690c0c8a00b005e8c4b69b5amr7450642ywb.4.1704258452710; Tue, 02
 Jan 2024 21:07:32 -0800 (PST)
Date: Tue,  2 Jan 2024 21:06:30 -0800
In-Reply-To: <20240103050635.391888-1-irogers@google.com>
Message-Id: <20240103050635.391888-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v7 20/25] perf dsos: Remove __dsos__addnew
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Function no longer used so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 5 -----
 tools/perf/util/dsos.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cfc10e1a6802..1495ab1cd7a0 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -341,11 +341,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	return dso;
 }
 
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
-{
-	return __dsos__addnew_id(dsos, name, NULL);
-}
-
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index c1b3979ad4bd..d1497b11d64c 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,7 +30,6 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
-- 
2.43.0.472.g3155946c3a-goog

