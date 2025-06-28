Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292F21FF3C
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086242; cv=none; b=GgBbMHFEUH+vVUJnmmgrYQqKjHgVL4/l5lq56Bd39HaD3otTgGlV6Us9LiNEwRLOrXQUv60P8DUWSxWfN/n/3Vc1Hi2d1k6QYsUZ73k3kB0v102kq0Oxsx9lDfXr3ClzdYkVLb30wtMJojl11HGbBds3vXmVam1TnHspMN+YJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086242; c=relaxed/simple;
	bh=Z2pwwVZvIgwwTJU2wludLOiTgLmYGa7xboLGjgPwTKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fIrZIfO+13hrf3nKqE/AghxTfPaI5wpv0NcsIpt6WiNkCuwfau8K6FUybGbtA9iecYHcKR9qAsyIVI8ZgeQO0xqIdXZISjL49patFyB2WOo0aRIX8sOg9lxFzeihCQ5JAcKzU2sQnMs7vvohNA/23edqbqLsCRL49uOLhHAUxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjcoDWh8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjcoDWh8"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e7337f26so2069390a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086238; x=1751691038; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dPZp1DF+AnYAgGb07vB2UMFLl9YEjHisGw1InIxv9DY=;
        b=IjcoDWh8xb956pEP+XZ+rqII3PvNYYXjEFdM4EsEiawxNfJHjCFJHV4kSsJZ2ZcD0Z
         UpS7uu2mESjXoJQCfXIZj0OlfuxE6H0VfvqJQPMmPXmwoQbtx9nu+yK46wOa0iqS3eDJ
         2BrlUw2/dOYleHJqFUfy1KYoerMck7MZXxIssT57aTo9KBZsaAg/9b8OVEduSHmjrE/b
         znvRxl64LoEn1m4ieTKnkRUmG6ZrICUMzaX/WrLklPQjoeKEF6QMoD3urOipr02mQANj
         s7aHzTl2vT/bogAeDBCnvj+5Szre//SurfNImlXVdkVD8RcSE1VML4RPomI/zmkP+P8C
         bVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086238; x=1751691038;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPZp1DF+AnYAgGb07vB2UMFLl9YEjHisGw1InIxv9DY=;
        b=BYkDs12ps3ne0cSJGUet35XCWVPOXXN8PlfXvoF15KKg8ZX2CHtc2nU6DiwHTc3ljK
         RuQ5lwQfl33Vaw+PclE2dKZh60sjUMPsPuV/VtfFxkDB5EBESUENn8ZCMS7wMgcbz3Xr
         gYl4GgvoF9qF5fZwfA1Z08Hj/WjuDFX96051kEUw3bh1fdGFOU2C3avJJz/Ok1wvshla
         QuAB34IwuPsWA62+DQ3KBuk8KqpA963KRAfHJ0g2FEvkuZW8BdLxZBzRkFzLd/IYVkDq
         Tkkfc+NyeafjrAXGHTL6M9f2x4/+yFq/fnnB+i83Jo9bjltIez4Dz0hwMmizTWYg8UGB
         7AKA==
X-Forwarded-Encrypted: i=1; AJvYcCU6CMIt3TzjB2MUy7haqgDcx1zQs2ByYAyeIPErGBTuYQFb6rOs/moseMV16WYnYAv19v2XnqucuFpnp5w6h7mh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjl/eD6TEY5AdKULB21ye2PEfHCvYGJQyOkyej66FFy6FQ61Sm
	lqRzmUfkUWJWHHHQf3H+0ne0ytwuozo91cHOv/MF9wkKhyIEYPZxJ0PTFMb5Nqu9k9aLcToL4hF
	04pRrNGalmw==
X-Google-Smtp-Source: AGHT+IFCL3Q9YU7AqufiZFitiUBCS0v3CdXfZMxaNF5NPjGhZrEflyH0sGNIYK2vcuRl7dqRnSVa5OjDliI3
X-Received: from pjbpv13.prod.google.com ([2002:a17:90b:3c8d:b0:312:1af5:98c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c83:b0:312:1508:fb4d
 with SMTP id 98e67ed59e1d1-318c931997emr10195380a91.33.1751086238488; Fri, 27
 Jun 2025 21:50:38 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:49:57 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-4-irogers@google.com>
Subject: [PATCH v5 03/23] perf build-id: Change sprintf functions to snprintf
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
index 057fcf4225ac..97664610c37e 100644
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
@@ -1704,7 +1704,7 @@ static size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 	return fprintf(fp, "%s", sbuild_id);
 }
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 4d213017d202..47538273915d 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -373,7 +373,7 @@ static int dsos__fprintf_buildid_cb(struct dso *dso, void *data)
 
 	if (args->skip && args->skip(dso, args->parm))
 		return 0;
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 	args->ret += fprintf(args->fp, "%-40s %s\n", sbuild_id, dso__long_name(dso));
 	return 0;
 }
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 14b0d3689137..fcf44149feb2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -334,7 +334,7 @@ size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 
 		build_id__init(&bid, event->mmap2.build_id,
 			       event->mmap2.build_id_size);
-		build_id__sprintf(&bid, sbuild_id);
+		build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 
 		return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
 				   " <%s>]: %c%c%c%c %s\n",
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2dea35237e81..44941b3adddd 100644
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
index 00f2c6c5114d..6655c0bbe0d8 100644
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
index 8b30c6f16a9e..ea86a6253f04 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2151,7 +2151,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 			goto proc_kallsyms;
 	}
 
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 
 	/* Find kallsyms in build-id cache with kcore */
 	scnprintf(path, sizeof(path), "%s/%s/%s",
-- 
2.50.0.727.gbf7dc18ff4-goog

