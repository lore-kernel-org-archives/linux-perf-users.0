Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQ7Ffzeo"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C133842
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:11:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db40f549659so5816580276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123064; x=1701727864; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SgzJhwUmMLXBFn6JMneX8WO48Fxs5qeBUSS9OEPabk=;
        b=EQ7FfzeozHMCZRBXfUMlZHWiakceeWKue4R9O82UED9cZbWEK7I0ywNtY90Oh96pce
         A9Fbxh6z7zPfPDRXC5+dAI0w+ZJ/wg3MKZITvXE82t1c4xw0fNp+9QiBFIY1Q4oXIMO2
         6Bu6iUiH9F2gMkaNUcEB2I2bqZa7nt7FJmnu8t/UZDQl4wMI+WsFBxfhkOQzZ/g6e34o
         S2gvEC+Zp2GrObRg/8QeEi1VmWTj0u3QDW8C6sawKLdsD46TN1t/v/tnGQx9BG6nxwRy
         jsoFwQVrvbDNp2gxdV2VK0TJlxeDB+nu3oDAsc1zkZlz8fEzskdBiQ+v1EZRDUE9DefT
         QBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123064; x=1701727864;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SgzJhwUmMLXBFn6JMneX8WO48Fxs5qeBUSS9OEPabk=;
        b=Jl/FVCMn911dIYc0IqAuXgH20lu/hH3Nk56dQsE6d5St9Yms23gCRWCjPW63blTgcD
         MgNQShojj82Vx8gazkHmQ74tKVuNreNX6AY16zIzeiov0PgJxCOlPflCOtU8Gl+StAM/
         LWefMj9J1aztOMLVU3y3qulV2Kdve+7jnvzQo0zHcxrYI/BXN5VT4JrX7gbVaMDm2ICK
         KyiIRHNE73YhvvH0XBPdVsCDXy8XHXlXlJuhQefLa8t+q9OO827Xx9h1nQdVXJxFud+E
         XmbIZS0m58MkAsLTCIlJ3dJT4SNYVfgHq8KlaEQ6T8rTfctMwhrWdfmpjAPqa27E5HDl
         Gyaw==
X-Gm-Message-State: AOJu0YwnmGr9s69mQrs4HeTR0QpoTexMwPkm5w7Vsuj1m7OcrKXGCo/f
	tTNq7Ilut5NXLoPBEkbTTzOVc2KgUkXq
X-Google-Smtp-Source: AGHT+IELE/ZF1UcQrdQ9gttRweNIudxYVEJnjD1C91Yi+u9ySGHAuYYMPloFWZ+cSSe9AvoeoE3xGqCJ6QDL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:3507:0:b0:db4:4df:8c1a with SMTP id
 c7-20020a253507000000b00db404df8c1amr468637yba.12.1701123064266; Mon, 27 Nov
 2023 14:11:04 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:56 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-45-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 44/50] perf dsos: Remove __dsos__addnew
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
2.43.0.rc1.413.gea7ed67945-goog

