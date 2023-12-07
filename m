Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7AUBGvy"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61ED2D78
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:19:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so528876276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911945; x=1702516745; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eUnOiwv/1uHn3VWkJ5mr8e8+hlMGBYfKCz2gV1d9s0=;
        b=G7AUBGvydcBZWw82+5MfyfcDdlGM++5NXq+dgB4/ozfc9eGoKiI8mv9CSS7PybwQ2p
         ARbv2uK5eozQ7qzg3L+NNCbMTSXH4yRxCaFAQM87zv86wJ6YOOygmsuQPMlS+4CmekAO
         8LUq79oF6Hx7zG1GUsgUhD4uwqGofWsoCsINGA++Vd7VjLHiTlCCt/nsAFO1uKJ8nxAe
         JGZ6oG6gLKrlULvs/wgn4AtvqQC8ws0ikRpxosfNeh6liUeleY1T3b7TPMZlIIRWUhgI
         eVieg3+X2gYwcWH/DPCo8Ft8NqlXs3W505L8EF1TdPXgp7vbo5VLRewOPkjKYREaesKC
         I2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911945; x=1702516745;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eUnOiwv/1uHn3VWkJ5mr8e8+hlMGBYfKCz2gV1d9s0=;
        b=RlGpL4HsvxU/8B5o8gosZ48g+f+MTFo+8DdjRTr0bsnjiswQh3j9S0++PHZ9tvg76H
         gjA3fpAkKzbH/q9TJmwYiHK8Usl0CI024WTUxLtG8oT1kPSvgFjMMvRBNOQKLlzBc9gP
         mw/BcvvZksvtTyK64vQF7lqD6dFUbHEVnz5GmmBWmlVON+N5aDRMw3D6QIQ7JFPkAL6B
         B4Dq0rVKA4Q8v6955PltF1dr6jpEIrXV9MQSBrtl/Xppt/JjimmeCBr8AadzdtYAn3ig
         P0CUEPTpIR+EhBPmiO4f0LYFUVmaLqcSamT5MhF6XFwaAx1bGswJRI4TR7vFZ7hWDPFB
         I+Ig==
X-Gm-Message-State: AOJu0YzuCSdptxKWRjKHcEnvimvuKeiQk+YM6/aqAnSGBnQ2kDkffDfH
	GoyDwImek7Gr9OiREq+vmpWiMyI3a/1j
X-Google-Smtp-Source: AGHT+IHdR+71Tx/Rcf4rmQHuKEHpJpeXZeLxD/kcp9lxi6wxZSlljDG6ekbcBR+PnqOsuzLWfndE34N57YSF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:3144:0:b0:db3:f436:5714 with SMTP id
 x65-20020a253144000000b00db3f4365714mr27107ybx.0.1701911944884; Wed, 06 Dec
 2023 17:19:04 -0800 (PST)
Date: Wed,  6 Dec 2023 17:17:16 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-43-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 42/47] perf dsos: Remove __dsos__addnew
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
2.43.0.rc2.451.g8631bc7472-goog

