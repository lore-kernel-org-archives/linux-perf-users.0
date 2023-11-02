Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E67210EA
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhLXyXHf"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2DA18B
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:59:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afacc566f3so17216817b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947984; x=1699552784; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8AzM8ZmO2/LuV9OGW5MoPE4fbBNeZFfotiJyJxsLNU8=;
        b=WhLXyXHfo1tm2wllCyBUZ5LgGEOazptIOVz7pQszSLhD2nm0PWTWefTXnpESukDciy
         e6Wk/Yeja5rY4f/WU2raaG9hz5VtPwxuVNArbC9a28V/WkUpGEf8J4bSOwV8W0x1l39r
         nlQ8ehNYA+jOoQlfsHISPQuO6M+OOXTwu7mYL0mZDYu2/pGF8go7ibvu15U0eIyDg9Jw
         RoPsQx9rXqiW4UkrCTc0y4nB5KfgncrTwFTM9rvOBFjB2WfJldaFSVgVrHfD/U+LkDsS
         HQqNFZ+HzQ2Q5+ethFNrpMjnQBYoccTuOXTmCIlpFJnOoruY+QzOCXDmc6UWCYM4us+Y
         N/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947984; x=1699552784;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AzM8ZmO2/LuV9OGW5MoPE4fbBNeZFfotiJyJxsLNU8=;
        b=OL7wl2tr1nfvRduyivbwof4yiSg9ID9qzffmoWu8N/9dsXkuMqCEr65N1UL9nDDGqI
         erGKXl4wxsyF+fKqXaAjqcfQSN/rfydpG4gMHxKjG5G0+Cd9k6nfUj2cYvr7n5xRHHSL
         OkJMD4kxUwUVZhHUyzbbnDDIAXIigsHGday8p88gMa40lIDTZl5m/AiFFLhSPY2Usunf
         Fs+ssat9u7djoVOnExir2LVoYtJIvbpKYRBIJUv4q4O/SNLJ9HOntuJ3dxoAEYQ8nUBj
         nO9XKR5gpvt+L01rIYexOF9yueKlSjLrAStIFssoF6OXc+F6QUUTXi3d5nJkwmkuejfE
         vbog==
X-Gm-Message-State: AOJu0YzBNgzBfkCoaEQqRGkQz3BBPj1KzwfnnHNxBADRHQUHDte8wSHx
	2zhei4AAI30AKEi1dX9lPwGQh3GOvi/w
X-Google-Smtp-Source: AGHT+IGQ+tz9Wp+C4hZ1JGaNXWdqeBjHWqxpAu7qdzkOqTHdvhVH0cS/Vpup2e7C0XewIsPwSzO60Bk3FdsN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:6d17:0:b0:5a7:7683:995d with SMTP id
 i23-20020a816d17000000b005a77683995dmr8705ywc.5.1698947983702; Thu, 02 Nov
 2023 10:59:43 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:29 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-48-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 47/53] perf dsos: Remove __dsos__addnew
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.42.0.869.gea05f2083d-goog

