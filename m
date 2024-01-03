Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56365199C2
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jan 2024 05:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWIvUVNC"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e6f42b1482so135337937b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jan 2024 21:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704258443; x=1704863243; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5RW6C4QLlKb0JTE6SUzx9NkbdG8GLD5Go3ZjoyQj1I=;
        b=QWIvUVNC8io+GBiLMKamE1O6DsOpqKM5CLYCUV227u0zTQSbeyQoPZQtIsjIpHdRay
         Z4MZnoA98f+1xACA/6hRbfMYdKg5Y8lZsmPX+opAS1MFHJpgf8NB1xYbo0u+nk3r9/C4
         EYR82pwmk/drh+BeYwzqyGdyjAyAb4TaHakqVYnmm5DUrejtBZWkT9d1/CzlKbHlV+ns
         Fdb3uSSiKwCzy6djYdDNSeM7JwKAzh0YbG+/nX5lDjprJVDlm4soBoNZTiOdrc7Nj8mj
         hJnuhU96DSln++VqhIvae1Kb/ms2RR3b23swGafCye1zD+1rHqJmjQzGPhBVBEsStAaa
         VFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704258443; x=1704863243;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5RW6C4QLlKb0JTE6SUzx9NkbdG8GLD5Go3ZjoyQj1I=;
        b=IDB6NWvzNfknbPDOvIly3rGXN1o2agEvItwQurrAYGQcOf8E2WpLGON60N2e5XQ0/8
         snucxtDQ7DC75A2g5m06FU7oFAeyia+zZNY24035mE1GjiqS9LMaYrxhdmlznJFzUckr
         heYeJZKGfHzORiCjDWDb+gVcrSiTD7qidm37ldD6mrlmiRJyfEjZB8ba0knY0kpoqCYG
         Oe8pj5gVlWGhS2RF3LorGLgwE9XZuB5NQcOSNbqvyQdlIzqeonGUETaeQtsxruE8Nyho
         +x20x9iL6r4EctfZeE7opUIUQN8whyuqnz1sYUsNZCqzZRF6z3UZyQATznt/y1iHKRQF
         UblQ==
X-Gm-Message-State: AOJu0Ywjs1dlmh0N0wZipzlhXtIItVv8S8ELLLEPhQ58z3irfiA2QbKX
	/oQgtSBl0Nymqpcj446YhWvpDl9PlW6NfQx38yk=
X-Google-Smtp-Source: AGHT+IF2NvIxFKJPHwA+mNbn55izav/7/2GUPnqmjVEjVirGYQyGVvhBV2ElZjF5KCi8lv5Yp7vgmShwQ2V2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e2bd:f1f6:8ea6:8d6c])
 (user=irogers job=sendgmr) by 2002:a25:b9c1:0:b0:dbd:b7cb:8a6b with SMTP id
 y1-20020a25b9c1000000b00dbdb7cb8a6bmr520882ybj.1.1704258443525; Tue, 02 Jan
 2024 21:07:23 -0800 (PST)
Date: Tue,  2 Jan 2024 21:06:26 -0800
In-Reply-To: <20240103050635.391888-1-irogers@google.com>
Message-Id: <20240103050635.391888-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v7 16/25] perf dsos: Add dsos__for_each_dso
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

To better abstract the dsos internals, add dsos__for_each_dso that
does a callback on each dso. This also means the read lock can be
correctly held.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 25 +++++++-----
 tools/perf/util/build-id.c  | 76 ++++++++++++++++++++-----------------
 tools/perf/util/dsos.c      | 16 ++++++++
 tools/perf/util/dsos.h      |  8 +---
 tools/perf/util/machine.c   | 40 +++++++++++--------
 5 files changed, 100 insertions(+), 65 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ef73317e6ae7..ce5e28eaad90 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1187,23 +1187,28 @@ static int synthesize_build_id(struct perf_inject *inject, struct dso *dso, pid_
 					       process_build_id, machine);
 }
 
+static int guest_session__add_build_ids_cb(struct dso *dso, void *data)
+{
+	struct guest_session *gs = data;
+	struct perf_inject *inject = container_of(gs, struct perf_inject, guest_session);
+
+	if (!dso->has_build_id)
+		return 0;
+
+	return synthesize_build_id(inject, dso, gs->machine_pid);
+
+}
+
 static int guest_session__add_build_ids(struct guest_session *gs)
 {
 	struct perf_inject *inject = container_of(gs, struct perf_inject, guest_session);
-	struct machine *machine = &gs->session->machines.host;
-	struct dso *dso;
-	int ret;
 
 	/* Build IDs will be put in the Build ID feature section */
 	perf_header__set_feat(&inject->session->header, HEADER_BUILD_ID);
 
-	dsos__for_each_with_build_id(dso, &machine->dsos.head) {
-		ret = synthesize_build_id(inject, dso, gs->machine_pid);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return dsos__for_each_dso(&gs->session->machines.host.dsos,
+				  guest_session__add_build_ids_cb,
+				  gs);
 }
 
 static int guest_session__ksymbol_event(struct perf_tool *tool,
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index a617b1917e6b..a6d3c253f19f 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -327,48 +327,56 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	return write_padded(fd, name, name_len + 1, len);
 }
 
-static int machine__write_buildid_table(struct machine *machine,
-					struct feat_fd *fd)
+struct machine__write_buildid_table_cb_args {
+	struct machine *machine;
+	struct feat_fd *fd;
+	u16 kmisc, umisc;
+};
+
+static int machine__write_buildid_table_cb(struct dso *dso, void *data)
 {
-	int err = 0;
-	struct dso *pos;
-	u16 kmisc = PERF_RECORD_MISC_KERNEL,
-	    umisc = PERF_RECORD_MISC_USER;
+	struct machine__write_buildid_table_cb_args *args = data;
+	const char *name;
+	size_t name_len;
+	bool in_kernel = false;
 
-	if (!machine__is_host(machine)) {
-		kmisc = PERF_RECORD_MISC_GUEST_KERNEL;
-		umisc = PERF_RECORD_MISC_GUEST_USER;
-	}
+	if (!dso->has_build_id)
+		return 0;
 
-	dsos__for_each_with_build_id(pos, &machine->dsos.head) {
-		const char *name;
-		size_t name_len;
-		bool in_kernel = false;
+	if (!dso->hit && !dso__is_vdso(dso))
+		return 0;
 
-		if (!pos->hit && !dso__is_vdso(pos))
-			continue;
+	if (dso__is_vdso(dso)) {
+		name = dso->short_name;
+		name_len = dso->short_name_len;
+	} else if (dso__is_kcore(dso)) {
+		name = args->machine->mmap_name;
+		name_len = strlen(name);
+	} else {
+		name = dso->long_name;
+		name_len = dso->long_name_len;
+	}
 
-		if (dso__is_vdso(pos)) {
-			name = pos->short_name;
-			name_len = pos->short_name_len;
-		} else if (dso__is_kcore(pos)) {
-			name = machine->mmap_name;
-			name_len = strlen(name);
-		} else {
-			name = pos->long_name;
-			name_len = pos->long_name_len;
-		}
+	in_kernel = dso->kernel || is_kernel_module(name, PERF_RECORD_MISC_CPUMODE_UNKNOWN);
+	return write_buildid(name, name_len, &dso->bid, args->machine->pid,
+			     in_kernel ? args->kmisc : args->umisc, args->fd);
+}
 
-		in_kernel = pos->kernel ||
-				is_kernel_module(name,
-					PERF_RECORD_MISC_CPUMODE_UNKNOWN);
-		err = write_buildid(name, name_len, &pos->bid, machine->pid,
-				    in_kernel ? kmisc : umisc, fd);
-		if (err)
-			break;
+static int machine__write_buildid_table(struct machine *machine, struct feat_fd *fd)
+{
+	struct machine__write_buildid_table_cb_args args = {
+		.machine = machine,
+		.fd = fd,
+		.kmisc = PERF_RECORD_MISC_KERNEL,
+		.umisc = PERF_RECORD_MISC_USER,
+	};
+
+	if (!machine__is_host(machine)) {
+		args.kmisc = PERF_RECORD_MISC_GUEST_KERNEL;
+		args.umisc = PERF_RECORD_MISC_GUEST_USER;
 	}
 
-	return err;
+	return dsos__for_each_dso(&machine->dsos, machine__write_buildid_table_cb, &args);
 }
 
 int perf_session__write_buildid_table(struct perf_session *session,
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index d269e09005a7..d43f64939b12 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -433,3 +433,19 @@ struct dso *dsos__find_kernel_dso(struct dsos *dsos)
 	up_read(&dsos->lock);
 	return res;
 }
+
+int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data)
+{
+	struct dso *dso;
+
+	down_read(&dsos->lock);
+	list_for_each_entry(dso, &dsos->head, node) {
+		int err;
+
+		err = cb(dso, data);
+		if (err)
+			return err;
+	}
+	up_read(&dsos->lock);
+	return 0;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index a7c7f723c5ff..317a263f0e37 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -23,12 +23,6 @@ struct dsos {
 	struct rw_semaphore lock;
 };
 
-#define dsos__for_each_with_build_id(pos, head)	\
-	list_for_each_entry(pos, head, node)	\
-		if (!pos->has_build_id)		\
-			continue;		\
-		else
-
 void dsos__init(struct dsos *dsos);
 void dsos__exit(struct dsos *dsos);
 
@@ -55,4 +49,6 @@ struct dso *dsos__findnew_module_dso(struct dsos *dsos, struct machine *machine,
 
 struct dso *dsos__find_kernel_dso(struct dsos *dsos);
 
+int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data);
+
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8d0ea17e432a..f1186a5bb73c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1561,16 +1561,14 @@ int machine__create_kernel_maps(struct machine *machine)
 	return ret;
 }
 
-static bool machine__uses_kcore(struct machine *machine)
+static int machine__uses_kcore_cb(struct dso *dso, void *data __maybe_unused)
 {
-	struct dso *dso;
-
-	list_for_each_entry(dso, &machine->dsos.head, node) {
-		if (dso__is_kcore(dso))
-			return true;
-	}
+	return dso__is_kcore(dso) ? 1 : 0;
+}
 
-	return false;
+static bool machine__uses_kcore(struct machine *machine)
+{
+	return dsos__for_each_dso(&machine->dsos, machine__uses_kcore_cb, NULL) != 0 ? true : false;
 }
 
 static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
@@ -3136,16 +3134,28 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 	return sym->name;
 }
 
+struct machine__for_each_dso_cb_args {
+	struct machine *machine;
+	machine__dso_t fn;
+	void *priv;
+};
+
+static int machine__for_each_dso_cb(struct dso *dso, void *data)
+{
+	struct machine__for_each_dso_cb_args *args = data;
+
+	return args->fn(dso, args->machine, args->priv);
+}
+
 int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv)
 {
-	struct dso *pos;
-	int err = 0;
+	struct machine__for_each_dso_cb_args args = {
+		.machine = machine,
+		.fn = fn,
+		.priv = priv,
+	};
 
-	list_for_each_entry(pos, &machine->dsos.head, node) {
-		if (fn(pos, machine, priv))
-			err = -1;
-	}
-	return err;
+	return dsos__for_each_dso(&machine->dsos, machine__for_each_dso_cb, &args);
 }
 
 int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, void *priv)
-- 
2.43.0.472.g3155946c3a-goog

