Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97D198E6E
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495664; cv=none; b=d18aC6ixcPbPzpujLQ75dtCRl9+HjaGwWI9gfptBJNyCWy2Xlv7HGhGG7gT5rE180kSPcA3dfdYPWhHthKnrr9XiCqKi3EA6qDwD8N6ahOTCkVW6gq2vEIPJmdCx+C+IwF2F/j2Kxr+4+qmzS4VV9x4QpLX2OMLkp6WXNJxaYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495664; c=relaxed/simple;
	bh=ovBQrp6cuImBeAsB+lhDUiPBGEsdYTJWHxVCST9Khl4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JIEmdbpXN8NNOAa9a2imyFWzkTZJ4qCW2MO7QDJSe1xbyqUlebEUU1v7CUMxgvbewpq2hhsTdBYM0kiJNYJrgTQIae0dWTWi0sielc4/3ApygpzkE4MvuN2wyFDSxPmEU46kwuQJTyZIFkyNgGn97O2akItbgklxv9fiNQg018g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QyKyMx/r; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyKyMx/r"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66619cb2d3eso134362377b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495661; x=1724100461; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v61QA+B40h4EB/AYC1TQM7xPmAjFKFUMVcOfqbmd56g=;
        b=QyKyMx/rlLPAO7VEucIXEvm/QDlrfe8kmLfQUbf9Wk+kYism+Hi8mY64AGfARSbuTu
         So5Pw+mTYDEQHqtP1aN3IF5DRU6XXVzpE3OZ9szVtXNpn56FhuwOlruvfAvhzizRhIxg
         cZHIQ7uI1alu2oUzgxAoAO8mo7qo0Acp/o0THVYRq5/hkdfUPj4EH6muNQRXTl3GMChf
         V2jxLtxh1u/C0OkJuyiUEOwsVSigK0rx81YPObUsV5p23XD7YIE7iPDK94Pw8FvXjm5B
         nTUrOnmUn5WCVR5lsS8CDl810UsjOk1OMcSfab5YU+m7PPUOhH2wKyY6DDh39iPZNp+U
         GZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495661; x=1724100461;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v61QA+B40h4EB/AYC1TQM7xPmAjFKFUMVcOfqbmd56g=;
        b=r03k05IeYN0BQMspoMPu0Fe03iBoTxLlnc+/rtKSQ/Ota4QhszQMgLM7De2lfEz+hS
         WyDHtBAUwN5+wmiuqsbk5/Uys+l/ivSgA3fWC//j/Xz4Hfy8Lf/7Hp9nR/jb+2Qf+Mo7
         Etf5CgLVY57rIjB7ukpEfk5eUsN/zSckxR0J8I5cR9rgqeNU7wg7PCeHp/6g0Lm3Fqlq
         R+6KvwSsy/Lf4dPuBmytt1625wrG52Qgz9QRPTY1N10Ui92/cXR49gklHK+qO5bdTedV
         G1LQpIIZXtl6YtBO4WLD2eANenVigSJnjBBTksMli4StKVgdji3GuVQ07XCAlgpteV+f
         0+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXYvLV46bqysYBY3SjmEtxApmx1WUaLe6DFfdbueqrPQdDp7pXf38zEOHHBXplTTuncC7C1llVqFAKRiNnYwDKV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzas7mxfln4J69gl20BAwCuGTZBg8iAruh0Y/lsIs2V5Rx7/vNQ
	hI/hCyMgjPBoLMgu4gSsdofmudlBMmfcBJmPHBiA+pVIY08M1weZFKDxSd9Z6y7gzCia1V9lrQF
	r6rn9Zw==
X-Google-Smtp-Source: AGHT+IEITAC4glbaWo+rDcNbbdxTZMr/2iHGOGSRmojml4G3PiALa4ESNz8qcPjFfsws9FZ2DMfRfYURndma
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:ee84:0:b0:64a:8aec:617c with SMTP id
 00721157ae682-6a96c0410d3mr708277b3.0.1723495660960; Mon, 12 Aug 2024
 13:47:40 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:46:59 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 07/27] perf buildid-list: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Reduce scope of build_id__mark_dso_hit_ops to the scope of function
perf_session__list_build_ids, its only use, and use perf_tool__init
for the default values. Move perf_event__exit_del_thread to event.[ch]
so it can be used in builtin-buildid-list.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-buildid-list.c | 10 ++++++++++
 tools/perf/util/build-id.c        | 32 -------------------------------
 tools/perf/util/build-id.h        |  4 +---
 tools/perf/util/event.c           | 20 +++++++++++++++++++
 tools/perf/util/event.h           |  4 ++++
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 383d5de36ce4..52dfacaff8e3 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -89,6 +89,7 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
+	struct perf_tool build_id__mark_dso_hit_ops;
 
 	symbol__elf_init();
 	/*
@@ -97,6 +98,15 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 	if (filename__fprintf_build_id(input_name, stdout) > 0)
 		goto out;
 
+	perf_tool__init(&build_id__mark_dso_hit_ops, /*ordered_events=*/true);
+	build_id__mark_dso_hit_ops.sample	= build_id__mark_dso_hit;
+	build_id__mark_dso_hit_ops.mmap		= perf_event__process_mmap;
+	build_id__mark_dso_hit_ops.mmap2	= perf_event__process_mmap2;
+	build_id__mark_dso_hit_ops.fork		= perf_event__process_fork;
+	build_id__mark_dso_hit_ops.exit		= perf_event__exit_del_thread;
+	build_id__mark_dso_hit_ops.attr		= perf_event__process_attr;
+	build_id__mark_dso_hit_ops.build_id	= perf_event__process_build_id;
+
 	session = perf_session__new(&data, &build_id__mark_dso_hit_ops);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 098fcc625d91..451d145fa4ed 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -67,38 +67,6 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int perf_event__exit_del_thread(const struct perf_tool *tool __maybe_unused,
-				       union perf_event *event,
-				       struct perf_sample *sample
-				       __maybe_unused,
-				       struct machine *machine)
-{
-	struct thread *thread = machine__findnew_thread(machine,
-							event->fork.pid,
-							event->fork.tid);
-
-	dump_printf("(%d:%d):(%d:%d)\n", event->fork.pid, event->fork.tid,
-		    event->fork.ppid, event->fork.ptid);
-
-	if (thread) {
-		machine__remove_thread(machine, thread);
-		thread__put(thread);
-	}
-
-	return 0;
-}
-
-struct perf_tool build_id__mark_dso_hit_ops = {
-	.sample	= build_id__mark_dso_hit,
-	.mmap	= perf_event__process_mmap,
-	.mmap2	= perf_event__process_mmap2,
-	.fork	= perf_event__process_fork,
-	.exit	= perf_event__exit_del_thread,
-	.attr		 = perf_event__process_attr,
-	.build_id	 = perf_event__process_build_id,
-	.ordered_events	 = true,
-};
-
 int build_id__sprintf(const struct build_id *build_id, char *bf)
 {
 	char *bid = bf;
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index ae87c4c58d5b..a212497bfdb0 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -16,11 +16,9 @@ struct build_id {
 	size_t	size;
 };
 
-struct nsinfo;
-
-extern struct perf_tool build_id__mark_dso_hit_ops;
 struct dso;
 struct feat_fd;
+struct nsinfo;
 
 void build_id__init(struct build_id *bid, const u8 *data, size_t size);
 int build_id__sprintf(const struct build_id *build_id, char *bf);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c2f0e7f40ad5..aac96d5d1917 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -426,6 +426,26 @@ int perf_event__process_exit(const struct perf_tool *tool __maybe_unused,
 	return machine__process_exit_event(machine, event, sample);
 }
 
+int perf_event__exit_del_thread(const struct perf_tool *tool __maybe_unused,
+				union perf_event *event,
+				struct perf_sample *sample __maybe_unused,
+				struct machine *machine)
+{
+	struct thread *thread = machine__findnew_thread(machine,
+							event->fork.pid,
+							event->fork.tid);
+
+	dump_printf("(%d:%d):(%d:%d)\n", event->fork.pid, event->fork.tid,
+		    event->fork.ppid, event->fork.ptid);
+
+	if (thread) {
+		machine__remove_thread(machine, thread);
+		thread__put(thread);
+	}
+
+	return 0;
+}
+
 size_t perf_event__fprintf_aux(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " offset: %#"PRI_lx64" size: %#"PRI_lx64" flags: %#"PRI_lx64" [%s%s%s]\n",
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4b24f1c580fd..f8742e6230a5 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -319,6 +319,10 @@ int perf_event__process_exit(const struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
 			     struct machine *machine);
+int perf_event__exit_del_thread(const struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine);
 int perf_event__process_ksymbol(const struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
-- 
2.46.0.76.ge559c4bf1a-goog

