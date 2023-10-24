Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939694292A
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CoJ0f3p4"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A8B272E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5a3f2d4fso5756272276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186327; x=1698791127; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ndf4120/UMb6KGHcRZrmqdMAZ7pHFTlKKfpIyLscZJ4=;
        b=CoJ0f3p4aWl/uTgfDXZxl8+eaIvudN6Nao8BPWMSORZARBSZFCwvZPAr/gXvByaAO/
         JeCAHIIa+cg1qiUoM8rRBcbkDo2s+MoeBBnsKz1YNjcD+JdtgMMJh/6HZk/U5MsAY6K0
         RwGh1L+kd7rnxXribEcJrRiea2p86EHxXmI33TuRVO63zbTWxFDmoPnrJGIKiONJ6xk2
         qyYVQHM/8JwBECj+cBnYt2shdoRZnNYMpAtqshG16eei8z7Fpu9mQbUnhGQujFFKX3D8
         UX7J7E6W/ZOJXzeNqfsV90KEoSYlTsRd40ttVBKiSbdhY/I34EdtOl7HIWlBc+fZW/94
         2wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186327; x=1698791127;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ndf4120/UMb6KGHcRZrmqdMAZ7pHFTlKKfpIyLscZJ4=;
        b=B8gMgaLLD2AsyvvzaTDlN4wI418N+R7ZBMOZsP6mvPLIawtisNqt3YlqM8Fh6FNBhR
         3DaVVndl/OgnDhFYVL+mCRnqCLQicrxKwdEBfRPTXPJ+AeSnZPWVGx/LN5myxaMSnj6b
         aP+q2X4cW6X4Yx+gFvoTED3sjGIagYAxHT4ecrDzRLX5NAj8zLXaF3K/nqwJypWQQLLe
         PmPhvcdIcQSFbET6qvHRa48ilWQUTpVcguGRwMdA0qLffgqmzS3vB8lIPPd1lR5mw+Mr
         AKUCj/ZzDWuvcBjIgbl9yN+15ciDbQs6dAbRt1V6b3sxJ1tX2KcdiscWQrNpuLQ4Lrd5
         BSVA==
X-Gm-Message-State: AOJu0YwLnEC1lg8kcScJyUJFsGGYg9eDGqfqy129mwKYBkpK5jxAaUta
	4r/o41oPUB45f62sQQZq8DgFlpLVULnL
X-Google-Smtp-Source: AGHT+IE4p1TSpdnPzu03gk9/UpKN4EfYYED8mqgqZ7C/q2qn3L5MAhNiVpliNIDogs5+bd9+rIfpz42SrlhD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP
 id v3-20020a056902108300b00d9ac3b84274mr348613ybu.7.1698186327431; Tue, 24
 Oct 2023 15:25:27 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:36 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-34-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 33/50] perf maps: Rename clone to copy from
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
index cab818af6787..07b158aa3e44 100644
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
2.42.0.758.gaed0368e0e-goog

