Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsxW6DNP"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908EA10FE
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:18:10 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf86963ecso1804377b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911889; x=1702516689; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fa0yzbvjGhr4NhEJ4udLP0p51ZFXxXnD3jAPwBOmSuU=;
        b=MsxW6DNPjcm5lXhgrPs/F1kqrwe0yhpO3eU89Vd4QfVJDe7pnuSHMcJjSvNzpjn9fo
         ht3jV4NZ1hl9iqeyggKHTlN6v2jRjIKoMfgjNl1eSdPlkkDNiz+T5n856tr0wMSr4lzY
         /kLKEWH4Z7weuLpkCtBH1gKJchp4PI6OYP4uU9dnUfOxHOEQfXFOUgk2qp36YODGYL4N
         3BxCHIKIJh7jQ1qkr9gAbm/mUDzM7Et0yshdYsH4F2lQrXyOB1LucdtQAwoV6FR5D2je
         IvL07YVtdJHhJcMUOdr6PolnBW6fVBB+YCkA1XkNYoJY6E2eAXr2h4O7ZwnB+gLKCsP3
         Tykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911889; x=1702516689;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa0yzbvjGhr4NhEJ4udLP0p51ZFXxXnD3jAPwBOmSuU=;
        b=N0mih6f5o3Z6EBOgAghv1sy+x2verFEDP+A7OBprnEqU+Yp864f6+QtEHrxZviGai3
         kNN6wXFIzk8LFE+bQxDeNLLRCqSCLcUF1D4YJlh6Qjd05BUNeS7ON5ynnMC665pM8qmN
         6hggemYwMnC9fcul5d9FDsuE4k44jv5qc0+Sk3MEBJdmeWrOVD2eHimBU1KLing+mnF+
         sUUM0mD0M0D1nTLDuIRdhDZ/j2+fheEHa0V0Mgf36eDgoR9wg7+V4aSiVQ/5Q3o1lCl2
         6GzwkxciT7baegvExqG63+ur0HY/pdOCUR8PS4ZwwcvYeu9/D9LjZQwf7g2hFFYL8Zo7
         mLMA==
X-Gm-Message-State: AOJu0Yzt0r3e6gfs693+GrI4trQxzlqiosTwKoZLy7MbKevsFH3YlP3d
	nUEnxWmFM3c2tnUy5t2MWh8kVv0hgUav
X-Google-Smtp-Source: AGHT+IFSmlUZ6GOZ35fZlj7BKZUnlQnekneA05Dz/Ida9kK02qCYXH/cLzPKYy/LVYUYGoyg6zeSdu7kf4/S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:250b:b0:5d3:9222:a83e with SMTP
 id dt11-20020a05690c250b00b005d39222a83emr31358ywb.10.1701911888965; Wed, 06
 Dec 2023 17:18:08 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:52 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 18/47] perf maps: Rename clone to copy from
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

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 2 +-
 tools/perf/util/maps.c    | 6 +-----
 tools/perf/util/maps.h    | 3 +--
 tools/perf/util/thread.c  | 2 +-
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index ca855fc435ac..38bf7108821d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -453,7 +453,7 @@ static struct thread *findnew_guest_code(struct machine *machine,
 	 * Guest code can be found in hypervisor process at the same address
 	 * so copy host maps.
 	 */
-	err = maps__clone(thread, thread__maps(host_thread));
+	err = maps__copy_from(thread__maps(thread), thread__maps(host_thread));
 	thread__put(host_thread);
 	if (err)
 		goto out_err;
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f305a4834cf0..986daa1b0497 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -453,12 +453,8 @@ int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
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
2.43.0.rc2.451.g8631bc7472-goog

