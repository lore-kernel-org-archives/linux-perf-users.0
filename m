Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ADB1DF26B
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970712; cv=none; b=Lakw5duxponVUuNbs/EhnAtRl9bgBLS+Q0FrVQJHwWbS9b9pgtlCGNNApDf1iDrL7ChoNzPESS85Mf5plUDGXdo/AV12IeopsDeltXLYXK5O5CJtm/JCpZfFod6P2B02bH08UxGV/uUvm2CYRmj9hj58sZbuJCt/UCsxaVlKETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970712; c=relaxed/simple;
	bh=lPSjxe8EQdyLJNhxVnaEAEUzrbZ+uiKlVP9aEAxUbic=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lMW1BRm60tFyOHdZb6/ZutVJKVvbnAj4QY2tlEVUCyzaXNQqfZ/GuPjy0qbDspT/O83vmFQi/WdItLmXCaYAokq702YHmhH+FVJUBXskAUsL9QN4Lg7aNj8GBiDgISAugv59Fq0CPbE0QhzjEmPbNfxhPphHPQhaGDPQs56mkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZRsMpdQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZRsMpdQ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so3039441276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 15:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738970710; x=1739575510; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrDPJWFQMloTVXFZxhclfRLm+mWnVUJwYXKzkzhD8f0=;
        b=sZRsMpdQ5XpoRvsFwyzzOzCNCKg+NPXkXU8zk7/ZPbkoxc5w8tHnurBaaUEC29ATBJ
         cmoADdSdryB/b7KWmV6LVqA1U1hsHlVgdDcFlnuPmCjPPijxq4jf+umxMODMn3nNcQxN
         Z82vzb4SNGWYKmJZHPTj8tDg6aW8cxTKwYJaw/L6MWyzKQgtzx6918eDwV+ax/45BbyG
         Q/LWssc9uALtInIaVbiXQUjfRgnXb+i6bNewvUYXTheXIG2fN+hDfDznDUBQ4SFmeShS
         i2r3KTVliikoIUYzg+8GkjhlvVJZ/3wzk8glSAevWmp6lGzZOlBxqoQcCguWpGB7djRL
         IEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970710; x=1739575510;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrDPJWFQMloTVXFZxhclfRLm+mWnVUJwYXKzkzhD8f0=;
        b=XJQPVU186H/jahQStd4csSLNkllm/X3nneC8B7eqo6bem9uNfFfU98ZpiAWG8ataow
         2LSMoP1hJqbzUBkjg3ZVEja0FGwUkSyN1fEZGhN/6e0eD+tusXC/6ciGfyykYzkIxcSr
         RVGBPhMO8vjvKqYLTMHPq5pfv5V3WZ/zGoOoW+vJ8xsGAzIEYIBfAuIZQLSQ5ldEaRY0
         YsXIveKaqhY4+/qH8xduZFnNfLSjt70zDCp+InCVUuKHUiDXOUUyyTB0O+Vq2e41Wjgu
         cpGPbG0uosoVY4wBUT+jZIJGOok0aAJzfPdY+aENFNsZGORHr5TFwvhcgFLmTFlWUkkE
         cuRw==
X-Forwarded-Encrypted: i=1; AJvYcCWFXzfNZdpD7EntYfoiJU52bdDMD0ucBq0wr8epGXhXYXg56FthH/z/oUhXWJ3F+Sr7oqHw9OTN0n6P0DPgJ73L@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjqOax2Kwr5Tji3VZs3psQKi2caoYsFeVMWY0dd6JbwX7pggE
	61KxIEXOFnVT+lKoL4XOBTNZ1dpPUbDipBnOlz+a6/SywsgV2/1oVeIwwzcTuYJdwJUhrloIfpG
	utj78xw==
X-Google-Smtp-Source: AGHT+IHN5ZtGiB8X7PuL9QQhXelXTLNxO7zsQQpubBASNLxja4NwnfQS/hy//fqiIqfp+6TVHlXERFY8gPTI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:79e4:4a45:1e80:ace5])
 (user=irogers job=sendgmr) by 2002:a25:5f0e:0:b0:e5b:12df:4e08 with SMTP id
 3f1490d57ef6-e5b46063273mr36231276.0.1738970710243; Fri, 07 Feb 2025 15:25:10
 -0800 (PST)
Date: Fri,  7 Feb 2025 15:24:47 -0800
In-Reply-To: <20250207232452.994822-1-irogers@google.com>
Message-Id: <20250207232452.994822-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207232452.994822-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v2 6/7] perf parse-events: Switch tracepoints to io_dir__readdir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>, 
	Jesper Juhl <jesperjuhl76@gmail.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Avoid DIR allocations when scanning sysfs by using io_dir for the
readdir implementation, that allocates about 1kb on the stack.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io_dir.h         |  2 --
 tools/perf/util/parse-events.c | 32 +++++++++++++++++++-------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
index c84738923c96..9f07460afacc 100644
--- a/tools/lib/api/io_dir.h
+++ b/tools/lib/api/io_dir.h
@@ -89,5 +89,3 @@ static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_dirent64 *
 	}
 	return dent->d_type == DT_DIR;
 }
-
-#endif
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6c36b98875bc..35e48fe56dfa 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -17,6 +17,7 @@
 #include "strbuf.h"
 #include "debug.h"
 #include <api/fs/tracing_path.h>
+#include <api/io_dir.h>
 #include <perf/cpumap.h>
 #include <util/parse-events-bison.h>
 #include <util/parse-events-flex.h>
@@ -554,8 +555,8 @@ static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
 				      struct parse_events_terms *head_config, YYLTYPE *loc)
 {
 	char *evt_path;
-	struct dirent *evt_ent;
-	DIR *evt_dir;
+	struct io_dirent64 *evt_ent;
+	struct io_dir evt_dir;
 	int ret = 0, found = 0;
 
 	evt_path = get_events_file(sys_name);
@@ -563,14 +564,14 @@ static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
 		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
 		return -1;
 	}
-	evt_dir = opendir(evt_path);
-	if (!evt_dir) {
+	io_dir__init(&evt_dir, open(evt_path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (evt_dir.dirfd < 0) {
 		put_events_file(evt_path);
 		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
 		return -1;
 	}
 
-	while (!ret && (evt_ent = readdir(evt_dir))) {
+	while (!ret && (evt_ent = io_dir__readdir(&evt_dir))) {
 		if (!strcmp(evt_ent->d_name, ".")
 		    || !strcmp(evt_ent->d_name, "..")
 		    || !strcmp(evt_ent->d_name, "enable")
@@ -592,7 +593,7 @@ static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
 	}
 
 	put_events_file(evt_path);
-	closedir(evt_dir);
+	close(evt_dir.dirfd);
 	return ret;
 }
 
@@ -615,17 +616,23 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 				    struct parse_events_error *err,
 				    struct parse_events_terms *head_config, YYLTYPE *loc)
 {
-	struct dirent *events_ent;
-	DIR *events_dir;
+	struct io_dirent64 *events_ent;
+	struct io_dir events_dir;
 	int ret = 0;
+	char *events_dir_path = get_tracing_file("events");
 
-	events_dir = tracing_events__opendir();
-	if (!events_dir) {
+	if (!events_dir_path) {
+		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
+		return -1;
+	}
+	io_dir__init(&events_dir, open(events_dir_path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	put_events_file(events_dir_path);
+	if (events_dir.dirfd < 0) {
 		tracepoint_error(err, errno, sys_name, evt_name, loc->first_column);
 		return -1;
 	}
 
-	while (!ret && (events_ent = readdir(events_dir))) {
+	while (!ret && (events_ent = io_dir__readdir(&events_dir))) {
 		if (!strcmp(events_ent->d_name, ".")
 		    || !strcmp(events_ent->d_name, "..")
 		    || !strcmp(events_ent->d_name, "enable")
@@ -639,8 +646,7 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 		ret = add_tracepoint_event(parse_state, list, events_ent->d_name,
 					   evt_name, err, head_config, loc);
 	}
-
-	closedir(events_dir);
+	close(events_dir.dirfd);
 	return ret;
 }
 
-- 
2.48.1.502.g6dc24dfdaf-goog

