Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3551E1E1C
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 06:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475596; cv=none; b=bktok6XTV+QzBjKI2LKGU/RkEk4J7FtBX4PmWBGS1liRXL9qHwWPYc3ucA7Q3jdCYaJp31kLe9QUcgsfy8s7WX4+NdVZciH5+SUaNBioj25Vxd+eaaJMDebxmC484yRmP0nV+SRFBZkbQqXuchD3WmOuGbW3V/bezslPk6EHnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475596; c=relaxed/simple;
	bh=qMgpRKdwe+vERSNZdaF5hButPH9QkwO+KzQ0SYWzH+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bean6cizIkn44xHyvj8zuXmeu9K9g6rNPvThNOqNEBp2OFUFrxeokEFz/+ZrvH46FFZs8h6eAA6inVQRgB71UvLvHzbcWG95kWe2eaxfP24Mgn4igRYP0DfLJve0YSO32VsgIs7BZuxFSbFryUJi7jAtgUeK9Tmhs0QSWAHbH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOoXwwfF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOoXwwfF"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240a7aceeaso7659395ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 23:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745475594; x=1746080394; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijUzm2FXhbx1VrGK1jhOa0tysywdn84a+bsw2IFyqQk=;
        b=fOoXwwfFIgNeHJL05j2QuIyx1Y2i0HGiTZ+O60hbYmk/J89HaK2k2cpkslhMbSkwRT
         6QFubI98/8WdSC4+j4ZJsksP/1pGR9yQsztnawICoPztNaTk7MJbLH3QXk4iAAvQowJQ
         4+uPJ3u8W+o3JZcJ+RuYQdexF/4oCJtAi64pIbqX6hwY21pj93cMFdEEixNr9vWn1qfL
         QHJTh5HJ626X4QUbADVzLIA/u1A5sNYli4YVAjMmE3XbS5wzM1uaITLefhNAcN+4eT5r
         QTFoQG6UqGsJ4jhdcBqPp3+K4nDFOgLgG0FAFTonDcKcsu5xIg+rY+aByIDa+SOJEzGR
         9SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745475594; x=1746080394;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijUzm2FXhbx1VrGK1jhOa0tysywdn84a+bsw2IFyqQk=;
        b=vJ8MxuDbCoYvrY/t2kQmgw8qDpAWRpWP0e8ij3+C/6CITJaTqeoxfXu0iCA2u1Y6+q
         cfMkD/exKOLkIo5/uNmdO3G6LowPVhoBzh8YZV5nZx/Xtq8QhOqJKElDAJk+R8RbGaAJ
         v9Y4uP6yZMnB+M4OUgWrgg+kuCMGKnTf/sV+F5+BwyVVEZH+0axx5FEqDrXPcX4mj90k
         Zt0dPunxRDVzXcYs0/dSYuz6fpBxPjwsjW+HGiwrKJ0znGFzNODJfF0Ad2X1j5eIj2rd
         i+56tjAPstWkX2iexvJ0Q/oIKgeePtyDu4b5aJdchnzeQ97eVKsdXdSyTpdBaqW9JYpw
         MmjA==
X-Forwarded-Encrypted: i=1; AJvYcCXCD5fqZ+q6gWSkHlagb3viopP551XQuRzUbS7a/QGP4zVYicpPw4ZMzqFLSD7jjaFEpGbgqBN1NJPG90w13QNm@vger.kernel.org
X-Gm-Message-State: AOJu0YwFaWawNNWTGs0t5ihPtiTHk0uDvSrgNTPxRnRTYESJQ1akEx20
	JOuKVioVyNe78/uz42IJwl5LaZrCmWfMe6bqzpYTM5h/2f+OOeYuiyvfE+Ihvx8Gks1skrUOb+A
	qT8TMkA==
X-Google-Smtp-Source: AGHT+IHi6peJYh8WdBLWYemRE9B9XWTAmwLFst4zj7kMnGZ1vbaDlKdo4s5QyAPr/Wl3X3iMsn5mDT9Nhe4U
X-Received: from pltj7.prod.google.com ([2002:a17:902:76c7:b0:224:efa:ef21])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68a:b0:21f:45d:21fb
 with SMTP id d9443c01a7336-22db3bacc32mr17954985ad.3.1745475594142; Wed, 23
 Apr 2025 23:19:54 -0700 (PDT)
Date: Wed, 23 Apr 2025 23:19:41 -0700
In-Reply-To: <20250424061943.1321025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250424061943.1321025-4-irogers@google.com>
Subject: [PATCH v1 3/5] perf build-id: Change sprintf functions to snprintf
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Leo Yan <leo.yan@arm.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pass in a size argument rather than implying all build id strings must
be SBUILD_ID_SIZE.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-buildid-cache.c            | 12 +++----
 tools/perf/builtin-buildid-list.c             |  6 ++--
 tools/perf/util/build-id.c                    | 33 ++++++++-----------
 tools/perf/util/build-id.h                    |  6 ++--
 tools/perf/util/disasm.c                      |  2 +-
 tools/perf/util/dso.c                         |  4 +--
 tools/perf/util/dsos.c                        |  2 +-
 tools/perf/util/event.c                       |  2 +-
 tools/perf/util/header.c                      |  2 +-
 tools/perf/util/map.c                         |  2 +-
 tools/perf/util/probe-file.c                  |  4 +--
 .../scripting-engines/trace-event-python.c    |  7 ++--
 tools/perf/util/symbol.c                      |  2 +-
 13 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index b0511d16aeb6..3f7739b21148 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -31,7 +31,7 @@
 #include <linux/string.h>
 #include <linux/err.h>
 
-static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
+static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid, size_t sbuildid_size)
 {
 	char root_dir[PATH_MAX];
 	char *p;
@@ -42,7 +42,7 @@ static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
 	if (!p)
 		return -1;
 	*p = '\0';
-	return sysfs__sprintf_build_id(root_dir, sbuildid);
+	return sysfs__snprintf_build_id(root_dir, sbuildid, sbuildid_size);
 }
 
 static int build_id_cache__kcore_dir(char *dir, size_t sz)
@@ -128,7 +128,7 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
 		return -1;
 	*p = '\0';
 
-	if (build_id_cache__kcore_buildid(from_dir, sbuildid) < 0)
+	if (build_id_cache__kcore_buildid(from_dir, sbuildid, sizeof(sbuildid)) < 0)
 		return -1;
 
 	scnprintf(to_dir, sizeof(to_dir), "%s/%s/%s",
@@ -187,7 +187,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 		return -1;
 	}
 
-	build_id__sprintf(&bid, sbuild_id);
+	build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 	err = build_id_cache__add_s(sbuild_id, filename, nsi,
 				    false, false);
 	pr_debug("Adding %s %s: %s\n", sbuild_id, filename,
@@ -211,7 +211,7 @@ static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
 		return -1;
 	}
 
-	build_id__sprintf(&bid, sbuild_id);
+	build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 	err = build_id_cache__remove_s(sbuild_id);
 	pr_debug("Removing %s %s: %s\n", sbuild_id, filename,
 		 err ? "FAIL" : "Ok");
@@ -317,7 +317,7 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 	}
 	err = 0;
 
-	build_id__sprintf(&bid, sbuild_id);
+	build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 	if (build_id_cache__cached(sbuild_id))
 		err = build_id_cache__remove_s(sbuild_id);
 
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 52dfacaff8e3..ba8ba0303920 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -31,7 +31,7 @@ static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
 
 	memset(bid_buf, 0, sizeof(bid_buf));
 	if (dso__has_build_id(dso))
-		build_id__sprintf(dso__bid_const(dso), bid_buf);
+		build_id__snprintf(dso__bid_const(dso), bid_buf, sizeof(bid_buf));
 	printf("%s %16" PRIx64 " %16" PRIx64, bid_buf, map__start(map), map__end(map));
 	if (dso_long_name != NULL)
 		printf(" %s", dso_long_name);
@@ -57,7 +57,7 @@ static int sysfs__fprintf_build_id(FILE *fp)
 	char sbuild_id[SBUILD_ID_SIZE];
 	int ret;
 
-	ret = sysfs__sprintf_build_id("/", sbuild_id);
+	ret = sysfs__snprintf_build_id("/", sbuild_id, sizeof(sbuild_id));
 	if (ret != sizeof(sbuild_id))
 		return ret < 0 ? ret : -EINVAL;
 
@@ -69,7 +69,7 @@ static int filename__fprintf_build_id(const char *name, FILE *fp)
 	char sbuild_id[SBUILD_ID_SIZE];
 	int ret;
 
-	ret = filename__sprintf_build_id(name, sbuild_id);
+	ret = filename__snprintf_build_id(name, sbuild_id, sizeof(sbuild_id));
 	if (ret != sizeof(sbuild_id))
 		return ret < 0 ? ret : -EINVAL;
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 5bc2040bdd0d..aa35dceace90 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -67,24 +67,17 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-int build_id__sprintf(const struct build_id *build_id, char *bf)
+int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size)
 {
-	char *bid = bf;
-	const u8 *raw = build_id->data;
-	size_t i;
-
-	bf[0] = 0x0;
+	size_t offs = 0;
 
-	for (i = 0; i < build_id->size; ++i) {
-		sprintf(bid, "%02x", *raw);
-		++raw;
-		bid += 2;
-	}
+	for (size_t i = 0; i < build_id->size && offs < bf_size; ++i)
+		offs += snprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
 
-	return (bid - bf) + 1;
+	return offs;
 }
 
-int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id)
+int sysfs__snprintf_build_id(const char *root_dir, char *sbuild_id, size_t sbuild_id_size)
 {
 	char notes[PATH_MAX];
 	struct build_id bid;
@@ -99,10 +92,10 @@ int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id)
 	if (ret < 0)
 		return ret;
 
-	return build_id__sprintf(&bid, sbuild_id);
+	return build_id__snprintf(&bid, sbuild_id, sbuild_id_size);
 }
 
-int filename__sprintf_build_id(const char *pathname, char *sbuild_id)
+int filename__snprintf_build_id(const char *pathname, char *sbuild_id, size_t sbuild_id_size)
 {
 	struct build_id bid;
 	int ret;
@@ -111,7 +104,7 @@ int filename__sprintf_build_id(const char *pathname, char *sbuild_id)
 	if (ret < 0)
 		return ret;
 
-	return build_id__sprintf(&bid, sbuild_id);
+	return build_id__snprintf(&bid, sbuild_id, sbuild_id_size);
 }
 
 /* asnprintf consolidates asprintf and snprintf */
@@ -212,9 +205,9 @@ static bool build_id_cache__valid_id(char *sbuild_id)
 		return false;
 
 	if (!strcmp(pathname, DSO__NAME_KALLSYMS))
-		ret = sysfs__sprintf_build_id("/", real_sbuild_id);
+		ret = sysfs__snprintf_build_id("/", real_sbuild_id, sizeof(real_sbuild_id));
 	else if (pathname[0] == '/')
-		ret = filename__sprintf_build_id(pathname, real_sbuild_id);
+		ret = filename__snprintf_build_id(pathname, real_sbuild_id, sizeof(real_sbuild_id));
 	else
 		ret = -EINVAL;	/* Should we support other special DSO cache? */
 	if (ret >= 0)
@@ -243,7 +236,7 @@ char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 	if (!dso__has_build_id(dso))
 		return NULL;
 
-	build_id__sprintf(dso__bid_const(dso), sbuild_id);
+	build_id__snprintf(dso__bid_const(dso), sbuild_id, sizeof(sbuild_id));
 	linkname = build_id_cache__linkname(sbuild_id, NULL, 0);
 	if (!linkname)
 		return NULL;
@@ -769,7 +762,7 @@ static int build_id_cache__add_b(const struct build_id *bid,
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
-	build_id__sprintf(bid, sbuild_id);
+	build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
 
 	return __build_id_cache__add_s(sbuild_id, name, nsi, is_kallsyms,
 				       is_vdso, proper_name, root_dir);
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index e3e0a446ff0c..47e621cebe1b 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -21,10 +21,10 @@ struct feat_fd;
 struct nsinfo;
 
 void build_id__init(struct build_id *bid, const u8 *data, size_t size);
-int build_id__sprintf(const struct build_id *build_id, char *bf);
+int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size);
 bool build_id__is_defined(const struct build_id *bid);
-int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id);
-int filename__sprintf_build_id(const char *pathname, char *sbuild_id);
+int sysfs__snprintf_build_id(const char *root_dir, char *sbuild_id, size_t sbuild_id_size);
+int filename__snprintf_build_id(const char *pathname, char *sbuild_id, size_t sbuild_id_size);
 char *build_id_cache__kallsyms_path(const char *sbuild_id, char *bf,
 				    size_t size);
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 8f0eb56c6fc6..96e6a5d6eacc 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1218,7 +1218,7 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
 		char *build_id_msg = NULL;
 
 		if (dso__has_build_id(dso)) {
-			build_id__sprintf(dso__bid(dso), bf + 15);
+			build_id__snprintf(dso__bid(dso), bf + 15, sizeof(bf) - 15);
 			build_id_msg = bf;
 		}
 		scnprintf(buf, buflen,
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 8619b6eea62d..776506b93b8b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -217,7 +217,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 			break;
 		}
 
-		build_id__sprintf(dso__bid_const(dso), build_id_hex);
+		build_id__snprintf(dso__bid_const(dso), build_id_hex, sizeof(build_id_hex));
 		len = __symbol__join_symfs(filename, size, "/usr/lib/debug/.build-id/");
 		snprintf(filename + len, size - len, "%.2s/%s.debug",
 			 build_id_hex, build_id_hex + 2);
@@ -1697,7 +1697,7 @@ static size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 	return fprintf(fp, "%s", sbuild_id);
 }
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e0998e2a7c4e..b2172632b3cd 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -370,7 +370,7 @@ static int dsos__fprintf_buildid_cb(struct dso *dso, void *data)
 
 	if (args->skip && args->skip(dso, args->parm))
 		return 0;
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 	args->ret += fprintf(args->fp, "%-40s %s\n", sbuild_id, dso__long_name(dso));
 	return 0;
 }
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c23b77f8f854..34176050ebac 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -329,7 +329,7 @@ size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 
 		build_id__init(&bid, event->mmap2.build_id,
 			       event->mmap2.build_id_size);
-		build_id__sprintf(&bid, sbuild_id);
+		build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 
 		return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
 				   " <%s>]: %c%c%c%c %s\n",
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e3cdc3b7b4ab..38e903307e8e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2291,7 +2291,7 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
 			free(m.name);
 		}
 
-		build_id__sprintf(dso__bid(dso), sbuild_id);
+		build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 		pr_debug("build id event received for %s: %s [%zu]\n",
 			 dso__long_name(dso), sbuild_id, size);
 		dso__put(dso);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d729438b7d65..0f6b185f9589 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -354,7 +354,7 @@ int map__load(struct map *map)
 		if (dso__has_build_id(dso)) {
 			char sbuild_id[SBUILD_ID_SIZE];
 
-			build_id__sprintf(dso__bid(dso), sbuild_id);
+			build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 			pr_debug("%s with build id %s not found", name, sbuild_id);
 		} else
 			pr_debug("Failed to open %s", name);
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index ec8ac242fedb..5069fb61f48c 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -448,10 +448,10 @@ static int probe_cache__open(struct probe_cache *pcache, const char *target,
 	if (!target || !strcmp(target, DSO__NAME_KALLSYMS)) {
 		target = DSO__NAME_KALLSYMS;
 		is_kallsyms = true;
-		ret = sysfs__sprintf_build_id("/", sbuildid);
+		ret = sysfs__snprintf_build_id("/", sbuildid, sizeof(sbuildid));
 	} else {
 		nsinfo__mountns_enter(nsi, &nsc);
-		ret = filename__sprintf_build_id(target, sbuildid);
+		ret = filename__snprintf_build_id(target, sbuildid, sizeof(sbuildid));
 		nsinfo__mountns_exit(&nsc);
 	}
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 520729e78965..68e92552d954 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -780,14 +780,13 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			    const char *sym_field, const char *symoff_field,
 			    const char *map_pgoff)
 {
-	char sbuild_id[SBUILD_ID_SIZE];
-
 	if (al->map) {
+		char sbuild_id[SBUILD_ID_SIZE];
 		struct dso *dso = map__dso(al->map);
 
 		pydict_set_item_string_decref(dict, dso_field,
 					      _PyUnicode_FromString(dso__name(dso)));
-		build_id__sprintf(dso__bid(dso), sbuild_id);
+		build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 		pydict_set_item_string_decref(dict, dso_bid_field,
 			_PyUnicode_FromString(sbuild_id));
 		pydict_set_item_string_decref(dict, dso_map_start,
@@ -1238,7 +1237,7 @@ static int python_export_dso(struct db_export *dbe, struct dso *dso,
 	char sbuild_id[SBUILD_ID_SIZE];
 	PyObject *t;
 
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 
 	t = tuple_new(5);
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 11540219481b..30750ed313ca 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2143,7 +2143,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 			goto proc_kallsyms;
 	}
 
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 
 	/* Find kallsyms in build-id cache with kcore */
 	scnprintf(path, sizeof(path), "%s/%s/%s",
-- 
2.49.0.805.g082f7c87e0-goog

