Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUrE4/XM"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8451988
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da033914f7cso5544132276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123010; x=1701727810; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xp8iIxo035oHbvCFG1UawGFv2rk11B4jTXVswVvjASk=;
        b=BUrE4/XMQNQ1Ra4CBGM1v3cF4C7O32Gl+n96nIN4DM6rc1W2CzhsGnHacDEPHyU5X6
         15RKWKSch4tTWHHa1f5wq0xKJGfdI57w7vWHmc5lNizb2sjj5r5bsoAK3vsLfmpta9tM
         dAhJPfivtEt2QWVn6acsGOeZZ4KVxxvl9TYS/2xi9Plam4LTGEnEwKe1pmu6txI0iT6s
         ONpZ2Gl15Oms1QYGJ6TPTle+HG/2mwIZsrNpeUMROa4gLCKOk1ONyhQZU8iE05JZdNvG
         SM0NJbeqN3WvECRIthmYl9dO+aySHjRsPasf/EyqEnwD7i6LfKE9+E7UjkIVJ+pa0RTj
         4IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123010; x=1701727810;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp8iIxo035oHbvCFG1UawGFv2rk11B4jTXVswVvjASk=;
        b=vQpsA78bAxx/qDKtUh+BKNMRA/SMQ2ToWxCY5BxfsELQFwwMHEMTeTnhzYzclz4qes
         p7ZmeqUMToWeCnfhIAeZmmupZ3UMzKUmeVsEBftQUxd2EQIgT4rKRqg/Cc8dx0QgD3Gx
         oxiplNwYK1Z2OeB4v0uzPYwAiundsYzCBkPWf+Z4jSl3SyVJVhVaBo09RnST2unHVf2c
         dLMIIf5IZ6HwsBkDS5MNjzvp2ZK5z5+MEfwYJsoSzvuOaDjAJWoglo59ZwPURVVD8NDK
         7CwODtaVDXz1SDt2XqtkTvsFTuNeVGd3g8JkIPgAu8Jx5ccowhNh7ev1Y2Tdx/11RmI/
         spuw==
X-Gm-Message-State: AOJu0YxmgowORzFenRpzV+Z8KyPwS2dtjYnBP5fYFT5cSV62Yyq4KcnO
	aMVM3PrZXzcFqUaYU+NERlrf9W6yO2bC
X-Google-Smtp-Source: AGHT+IGeyyQaMmLbqCN92w+hBxIYvS3reZkb5q+BcPSfsU7r0C55NGH7xLQ0bx7pKgMF4gkf9x+xa70Lb3Pt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:3383:0:b0:da0:c6d7:8231 with SMTP id
 z125-20020a253383000000b00da0c6d78231mr445480ybz.0.1701123010280; Mon, 27 Nov
 2023 14:10:10 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:32 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 20/50] perf maps: Rename clone to copy from
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
2.43.0.rc1.413.gea7ed67945-goog

