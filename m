Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42F210FE
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0WGHHZF"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0BD1FFA
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:59:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5acac8b6575so18565347b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947972; x=1699552772; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcVt1aT4gUmQp5/16uolyIHaqxHPYf1MRUEtlWW/iRk=;
        b=l0WGHHZFIdFme0FiO6YF73aIolgDlQFM7MxUb9tlJ241Rz8bvHLTjJNQ6dqmEqualM
         v4261biDVRIDG3Ug9Bxo5/oLX5C1z6MOhkwArD3SfuXECwBFXI4mUbO4HszpfB5dyAGU
         FUJkPgsSADItVqSAE2xkgRRdoHPNLfCZfUg13biq8HJS1EM0aXFeKxzcolln5IFJYtCn
         aiB2ydkSaeOSsRfSAEW3m2vY2CpC5Tdrcj40d0f7bP9GXHlY3ioTHMXOi8kXIFYF1Hzo
         E7MZY0QNLrmMJ5cS/2lQPHm6lhG5dhOhyjQJd0AP+mC73omaIDRXca+xQXzqxepzlbNJ
         lx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947972; x=1699552772;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcVt1aT4gUmQp5/16uolyIHaqxHPYf1MRUEtlWW/iRk=;
        b=fy2UFy9eqSNQin7SWEYZbaJ/V8yKFHWf8EHo/Jz7xIGRbd1NTbLsDF03rpegpYujW4
         zi2AU0Hi5rSpG8heqOSD2tNwkpKuTm4e8iQ8tWWUU69ZST3KU/iHbL1cZR0DC8RyR1Sw
         AelHO5K2YMT2LOPyIJgCsdwxGezEoG9vDIPaG7SrAxm+S5Jpi4oTshq1xi0fXvIN/j+o
         wvkpSdKqYsR/I94eEjq3hCHYfHL1XVRNOkBAZrrhTdDsutPQ8hP9cxc/vM+ZVGOwM9yj
         Yz0HCbVqvZ7zfUs1vDq+/woZqYi0KBs0KiZ0YSDeWNps0iSsLosYAr0fGfwcT7e2xOX5
         aJew==
X-Gm-Message-State: AOJu0YziMLafWle6PU9NBAp6vEAGjBXKOCFDD3F7ejh53vPvQPQmTIQA
	x+xX8qCWWiuHLy1oTFVm3U2KFh5LajdP
X-Google-Smtp-Source: AGHT+IE+pcgSsvxkzMuf0Kk9PTAMZqQBfcbDCug/w8V/ZP+LIIZi73gL9G920NGunw9+gFAqHpwppDKewmwx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a0d:eb8a:0:b0:595:8166:7be with SMTP id
 u132-20020a0deb8a000000b00595816607bemr10047ywe.0.1698947972504; Thu, 02 Nov
 2023 10:59:32 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:24 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-43-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 42/53] perf dsos: Tidy reference counting and locking
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

Move more functionality into dsos.c generally from machine, renaming
functions to match their new usage. The find function is made to
always "get" before returning a dso. Reduce the scope of locks in vdso
to match the locking paradigm.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c    | 73 +++++++++++++++++++++++++++++++++++----
 tools/perf/util/dsos.h    |  9 ++++-
 tools/perf/util/machine.c | 62 ++-------------------------------
 tools/perf/util/map.c     |  4 +--
 tools/perf/util/vdso.c    | 48 +++++++++++--------------
 5 files changed, 97 insertions(+), 99 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e65ef6762bed..d269e09005a7 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -181,7 +181,7 @@ struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso
 			 * at the end of the list of duplicates.
 			 */
 			if (!dso || (dso == this))
-				return this;	/* Find matching dso */
+				return dso__get(this);	/* Find matching dso */
 			/*
 			 * The core kernel DSOs may have duplicated long name.
 			 * In this case, the short name should be different.
@@ -253,15 +253,20 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct d
 	if (cmp_short) {
 		list_for_each_entry(pos, &dsos->head, node)
 			if (__dso__cmp_short_name(name, id, pos) == 0)
-				return pos;
+				return dso__get(pos);
 		return NULL;
 	}
 	return __dsos__findnew_by_longname_id(&dsos->root, name, id);
 }
 
-struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
+struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 {
-	return __dsos__find_id(dsos, name, NULL, cmp_short);
+	struct dso *res;
+
+	down_read(&dsos->lock);
+	res = __dsos__find_id(dsos, name, NULL, cmp_short);
+	up_read(&dsos->lock);
+	return res;
 }
 
 static void dso__set_basename(struct dso *dso)
@@ -303,8 +308,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	if (dso != NULL) {
 		__dsos__add(dsos, dso);
 		dso__set_basename(dso);
-		/* Put dso here because __dsos_add already got it */
-		dso__put(dso);
 	}
 	return dso;
 }
@@ -328,7 +331,7 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
 {
 	struct dso *dso;
 	down_write(&dsos->lock);
-	dso = dso__get(__dsos__findnew_id(dsos, name, id));
+	dso = __dsos__findnew_id(dsos, name, id);
 	up_write(&dsos->lock);
 	return dso;
 }
@@ -374,3 +377,59 @@ int __dsos__hit_all(struct dsos *dsos)
 
 	return 0;
 }
+
+struct dso *dsos__findnew_module_dso(struct dsos *dsos,
+				     struct machine *machine,
+				     struct kmod_path *m,
+				     const char *filename)
+{
+	struct dso *dso;
+
+	down_write(&dsos->lock);
+
+	dso = __dsos__find_id(dsos, m->name, NULL, /*cmp_short=*/true);
+	if (!dso) {
+		dso = __dsos__addnew(dsos, m->name);
+		if (dso == NULL)
+			goto out_unlock;
+
+		dso__set_module_info(dso, m, machine);
+		dso__set_long_name(dso, strdup(filename), true);
+		dso->kernel = DSO_SPACE__KERNEL;
+	}
+
+out_unlock:
+	up_write(&dsos->lock);
+	return dso;
+}
+
+struct dso *dsos__find_kernel_dso(struct dsos *dsos)
+{
+	struct dso *dso, *res = NULL;
+
+	down_read(&dsos->lock);
+	list_for_each_entry(dso, &dsos->head, node) {
+		/*
+		 * The cpumode passed to is_kernel_module is not the cpumode of
+		 * *this* event. If we insist on passing correct cpumode to
+		 * is_kernel_module, we should record the cpumode when we adding
+		 * this dso to the linked list.
+		 *
+		 * However we don't really need passing correct cpumode.  We
+		 * know the correct cpumode must be kernel mode (if not, we
+		 * should not link it onto kernel_dsos list).
+		 *
+		 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
+		 * is_kernel_module() treats it as a kernel cpumode.
+		 */
+		if (!dso->kernel ||
+		    is_kernel_module(dso->long_name,
+				     PERF_RECORD_MISC_CPUMODE_UNKNOWN))
+			continue;
+
+		res = dso__get(dso);
+		break;
+	}
+	up_read(&dsos->lock);
+	return res;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 1c81ddf07f8f..a7c7f723c5ff 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -10,6 +10,8 @@
 
 struct dso;
 struct dso_id;
+struct kmod_path;
+struct machine;
 
 /*
  * DSOs are put into both a list for fast iteration and rbtree for fast
@@ -33,7 +35,7 @@ void dsos__exit(struct dsos *dsos);
 void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
-struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
+struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
  
@@ -48,4 +50,9 @@ size_t __dsos__fprintf(struct dsos *dsos, FILE *fp);
 
 int __dsos__hit_all(struct dsos *dsos);
 
+struct dso *dsos__findnew_module_dso(struct dsos *dsos, struct machine *machine,
+				     struct kmod_path *m, const char *filename);
+
+struct dso *dsos__find_kernel_dso(struct dsos *dsos);
+
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a0abfba90962..06026a1b2d1a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -646,31 +646,6 @@ int machine__process_lost_samples_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
-static struct dso *machine__findnew_module_dso(struct machine *machine,
-					       struct kmod_path *m,
-					       const char *filename)
-{
-	struct dso *dso;
-
-	down_write(&machine->dsos.lock);
-
-	dso = __dsos__find(&machine->dsos, m->name, true);
-	if (!dso) {
-		dso = __dsos__addnew(&machine->dsos, m->name);
-		if (dso == NULL)
-			goto out_unlock;
-
-		dso__set_module_info(dso, m, machine);
-		dso__set_long_name(dso, strdup(filename), true);
-		dso->kernel = DSO_SPACE__KERNEL;
-	}
-
-	dso__get(dso);
-out_unlock:
-	up_write(&machine->dsos.lock);
-	return dso;
-}
-
 int machine__process_aux_event(struct machine *machine __maybe_unused,
 			       union perf_event *event)
 {
@@ -854,7 +829,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 	if (kmod_path__parse_name(&m, filename))
 		return NULL;
 
-	dso = machine__findnew_module_dso(machine, &m, filename);
+	dso = dsos__findnew_module_dso(&machine->dsos, machine, &m, filename);
 	if (dso == NULL)
 		goto out;
 
@@ -1659,40 +1634,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		 * Should be there already, from the build-id table in
 		 * the header.
 		 */
-		struct dso *kernel = NULL;
-		struct dso *dso;
-
-		down_read(&machine->dsos.lock);
-
-		list_for_each_entry(dso, &machine->dsos.head, node) {
-
-			/*
-			 * The cpumode passed to is_kernel_module is not the
-			 * cpumode of *this* event. If we insist on passing
-			 * correct cpumode to is_kernel_module, we should
-			 * record the cpumode when we adding this dso to the
-			 * linked list.
-			 *
-			 * However we don't really need passing correct
-			 * cpumode.  We know the correct cpumode must be kernel
-			 * mode (if not, we should not link it onto kernel_dsos
-			 * list).
-			 *
-			 * Therefore, we pass PERF_RECORD_MISC_CPUMODE_UNKNOWN.
-			 * is_kernel_module() treats it as a kernel cpumode.
-			 */
-
-			if (!dso->kernel ||
-			    is_kernel_module(dso->long_name,
-					     PERF_RECORD_MISC_CPUMODE_UNKNOWN))
-				continue;
-
-
-			kernel = dso__get(dso);
-			break;
-		}
-
-		up_read(&machine->dsos.lock);
+		struct dso *kernel = dsos__find_kernel_dso(&machine->dsos);
 
 		if (kernel == NULL)
 			kernel = machine__findnew_dso(machine, machine->mmap_name);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index cf5a15db3a1f..7c1fff9e413d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -196,9 +196,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			 * reading the header will have the build ID set and all future mmaps will
 			 * have it missing.
 			 */
-			down_read(&machine->dsos.lock);
-			header_bid_dso = __dsos__find(&machine->dsos, filename, false);
-			up_read(&machine->dsos.lock);
+			header_bid_dso = dsos__find(&machine->dsos, filename, false);
 			if (header_bid_dso && header_bid_dso->header_build_id) {
 				dso__set_build_id(dso, &header_bid_dso->bid);
 				dso->header_build_id = 1;
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index df8963796187..35532dcbff74 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -133,8 +133,6 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
 	if (dso != NULL) {
 		__dsos__add(&machine->dsos, dso);
 		dso__set_long_name(dso, long_name, false);
-		/* Put dso here because __dsos_add already got it */
-		dso__put(dso);
 	}
 
 	return dso;
@@ -252,17 +250,15 @@ static struct dso *__machine__findnew_compat(struct machine *machine,
 	const char *file_name;
 	struct dso *dso;
 
-	dso = __dsos__find(&machine->dsos, vdso_file->dso_name, true);
+	dso = dsos__find(&machine->dsos, vdso_file->dso_name, true);
 	if (dso)
-		goto out;
+		return dso;
 
 	file_name = vdso__get_compat_file(vdso_file);
 	if (!file_name)
-		goto out;
+		return NULL;
 
-	dso = __machine__addnew_vdso(machine, vdso_file->dso_name, file_name);
-out:
-	return dso;
+	return __machine__addnew_vdso(machine, vdso_file->dso_name, file_name);
 }
 
 static int __machine__findnew_vdso_compat(struct machine *machine,
@@ -308,21 +304,21 @@ static struct dso *machine__find_vdso(struct machine *machine,
 	dso_type = machine__thread_dso_type(machine, thread);
 	switch (dso_type) {
 	case DSO__TYPE_32BIT:
-		dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO32, true);
+		dso = dsos__find(&machine->dsos, DSO__NAME_VDSO32, true);
 		if (!dso) {
-			dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO,
-					   true);
+			dso = dsos__find(&machine->dsos, DSO__NAME_VDSO,
+					 true);
 			if (dso && dso_type != dso__type(dso, machine))
 				dso = NULL;
 		}
 		break;
 	case DSO__TYPE_X32BIT:
-		dso = __dsos__find(&machine->dsos, DSO__NAME_VDSOX32, true);
+		dso = dsos__find(&machine->dsos, DSO__NAME_VDSOX32, true);
 		break;
 	case DSO__TYPE_64BIT:
 	case DSO__TYPE_UNKNOWN:
 	default:
-		dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
+		dso = dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
 		break;
 	}
 
@@ -334,37 +330,33 @@ struct dso *machine__findnew_vdso(struct machine *machine,
 {
 	struct vdso_info *vdso_info;
 	struct dso *dso = NULL;
+	char *file;
 
-	down_write(&machine->dsos.lock);
 	if (!machine->vdso_info)
 		machine->vdso_info = vdso_info__new();
 
 	vdso_info = machine->vdso_info;
 	if (!vdso_info)
-		goto out_unlock;
+		return NULL;
 
 	dso = machine__find_vdso(machine, thread);
 	if (dso)
-		goto out_unlock;
+		return dso;
 
 #if BITS_PER_LONG == 64
 	if (__machine__findnew_vdso_compat(machine, thread, vdso_info, &dso))
-		goto out_unlock;
+		return dso;
 #endif
 
-	dso = __dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
-	if (!dso) {
-		char *file;
+	dso = dsos__find(&machine->dsos, DSO__NAME_VDSO, true);
+	if (dso)
+		return dso;
 
-		file = get_file(&vdso_info->vdso);
-		if (file)
-			dso = __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
-	}
+	file = get_file(&vdso_info->vdso);
+	if (!file)
+		return NULL;
 
-out_unlock:
-	dso__get(dso);
-	up_write(&machine->dsos.lock);
-	return dso;
+	return __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
 }
 
 bool dso__is_vdso(struct dso *dso)
-- 
2.42.0.869.gea05f2083d-goog

