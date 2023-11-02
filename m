Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B514620B35
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2kwlR0lp"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA8B19D
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0c7d27fb0so1423901276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947929; x=1699552729; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qB7MKGYwy6W2k++DMikZr9fNmwsId1Vn+RjugNY41g=;
        b=2kwlR0lpTXuTW64udno04EcnsaMVxA4p7AtSyQX0zkP/STVAYorA9lf59BgHckoS+d
         fJh6v7+9w5/1uqRX/8Sm+SJHDNmnKQefaeM0O0On+O+7GnKx6QVe0m/bfhQFihl4sJjE
         u3G72vrs4MMdcd50F8xVhsPnoHB1DCFL/a8jQ7jJT1K8ujZ/ibUMCHA5pm7KN4AvjscN
         Sb/BcZdYhVULgt1+dUnskXJw124acjNEoxJmz0gNlDPLaBTZI8AOYlLiRKGLPjsDoBX+
         CdOHefqaWikHyjuD7fl+KbBk/9q4mgw5ISnfmPEFLbKC3VElagnt4s54nql2E2a76nah
         NBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947929; x=1699552729;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qB7MKGYwy6W2k++DMikZr9fNmwsId1Vn+RjugNY41g=;
        b=H2Iu8c2WfsQPGNDYWk+HnKMSEDazQZqVTKWvPyakzMS/8UaxeDYW+H0NxD1e5cHfph
         kxG0WuaRBV7e6HChFofuLiY3QUZvSrIvI4iUyuBKUYDIGhM0kSopulG5YGc4Kab8SCWP
         1QkUo0wxlU5KG5xDgjQN+IU/3r2AjZQRSpYJnizfvi2ZkuDB0kOE9U66Be/6vQ3ISx5J
         7xO2d5CQS1X7HsLvj8qrKCb+ZoVGAYr9FnRvKvwvwnC+jgdnToa+b8cN6hrhq6kVXlZ1
         ARwCkHSZ9tMKRM8i1BkxBHOWBbOfcQsbf7flixvhViLqTMhZZgTJCyWNyWcJi7PSe/dM
         jdsg==
X-Gm-Message-State: AOJu0YyEA6kTCQ3QwJiAu4rBiy4QUWWiyFBaK38X649+kj00Y5lJF2Mv
	mqVNn+xrgA2LnNaStA7bjO9iRaZT0ANF
X-Google-Smtp-Source: AGHT+IGnNbr0ATXhvcobY5b1C+xpslu+egv1QsNnD9crxHuCIQZxikYpeND5J0/RExYebRMCygts88rccQXR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:1802:b0:da0:94e8:84d4 with SMTP
 id cf2-20020a056902180200b00da094e884d4mr348163ybb.12.1698947929133; Thu, 02
 Nov 2023 10:58:49 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:05 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 23/53] perf maps: Rename clone to copy from
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

Rename maps__clone to maps__copy_from to be more intention revealing
of its behavior. Pass the underlying maps rather than the thread.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 2 +-
 tools/perf/util/maps.c    | 6 +-----
 tools/perf/util/maps.h    | 3 +--
 tools/perf/util/thread.c  | 2 +-
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c967295c9a3..191e492539e5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -454,7 +454,7 @@ static struct thread *findnew_guest_code(struct machine *machine,
 	 * Guest code can be found in hypervisor process at the same address
 	 * so copy host maps.
 	 */
-	err = maps__clone(thread, thread__maps(host_thread));
+	err = maps__copy_from(thread__maps(thread), thread__maps(host_thread));
 	thread__put(host_thread);
 	if (err)
 		goto out_err;
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 14e1a169433d..85bea2a6dca9 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -452,12 +452,8 @@ int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 	return err;
 }
 
-/*
- * XXX This should not really _copy_ te maps, but refcount them.
- */
-int maps__clone(struct thread *thread, struct maps *parent)
+int maps__copy_from(struct maps *maps, struct maps *parent)
 {
-	struct maps *maps = thread__maps(thread);
 	int err;
 	struct map_rb_node *rb_node;
 
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index 62e94d443c02..e4a49d6ff5cf 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -14,7 +14,6 @@ struct ref_reloc_sym;
 struct machine;
 struct map;
 struct maps;
-struct thread;
 
 struct map_rb_node {
 	struct rb_node rb_node;
@@ -61,7 +60,7 @@ struct kmap {
 
 struct maps *maps__new(struct machine *machine);
 bool maps__empty(struct maps *maps);
-int maps__clone(struct thread *thread, struct maps *parent);
+int maps__copy_from(struct maps *maps, struct maps *parent);
 
 struct maps *maps__get(struct maps *maps);
 void maps__put(struct maps *maps);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 3d47b5c5528b..89c47a5098e2 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -390,7 +390,7 @@ static int thread__clone_maps(struct thread *thread, struct thread *parent, bool
 		return 0;
 	}
 	/* But this one is new process, copy maps. */
-	return do_maps_clone ? maps__clone(thread, thread__maps(parent)) : 0;
+	return do_maps_clone ? maps__copy_from(thread__maps(thread), thread__maps(parent)) : 0;
 }
 
 int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone)
-- 
2.42.0.869.gea05f2083d-goog

