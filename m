Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB81FFC58
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Feb 2025 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204639; cv=none; b=eNcEi0mpS7olWOzHNR/tB1ruKK05+52PtRk4OrR/Ha3VZmH8rlz2aSp8jw8nslM+5Vt942HAQr2j/cvMfDkfNs9DGNdzzqIlBhTIKqmTkNurhHH7lvYjJS6KIclDVaruEgGAVv8JfYow97nzkFMFU+86CFlfwjdAaXSFaeRG0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204639; c=relaxed/simple;
	bh=9ucfSZ+DSIqnt9/D0VSNTgbnBQ56WKkLObX9RoT/pvQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=KNfnBm+TAYtSIDyDWUZe8MqKBasOfDTFpNBqAlSQvOtuF3t+nSa8SnMNFsueFWjv5jKSRq8WhQTJu6NsZUzT26q4SCRu0FO3VTJlEBweM9SLe8ZFJjDqBWDLOEoq5OE8SV5N++RQR631FylUKI7BsRsOOQFuPKytsmJ4UGBK1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2yk/MFg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2yk/MFg"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e5b2c00f76bso5211433276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Feb 2025 22:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740204637; x=1740809437; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJkz0HMkEeLA7dO/rwYMGkbidcoBGERjpw0WaVKXEv0=;
        b=j2yk/MFgGhZZvVOMdrH5lD0d0tF/zSXnhXF8S9r+PWmAe7ro3qfPhmjnL67t+D3nq2
         jGeN40Olg3B9aOVnQn4fzP3MtD0gjIBZzgK3z3bMH7EwmZy7SKzrBSksottgzRM7tZ7Z
         F6djVB8m3/eoSNUaxrNoIAGOOo4cjjF37pXdW2V06DSlQz/QUixmcCTd2HRI/CTXEi1S
         n7841tMRi4PWRvLRE54S5zh4IaMeg9SsJljvftbSb7dfia3FFZ2wKRp5PW/oiMEoC5hO
         gt3PAiU7ziilRuQwnXQngXyCzEygK9+EXRRkP47wRl7MIKuSEN8WVvERxwi+7UFn+dNp
         3Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740204637; x=1740809437;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJkz0HMkEeLA7dO/rwYMGkbidcoBGERjpw0WaVKXEv0=;
        b=mVk9GiMhZ8yF3q0XACxP8iSJVlJ13i2ib7SVSsdWXpu+7iFFjlV2nbrYsSY0AZVaRo
         +pwOpjZiNsys/0+r+TnEOvSwI8ldoCw/B3e4U2iYOPmijegk9R1DZmKCwffefztiaq5i
         1q/fdDdE4PZAFgRAD+2apUac5b+oKvSPEBiVUo/2OR1jMXt35WCY6awr+88Cd/xhtXPE
         I+jxIkNamFAUHtmG2y8uCPp8ptg1DosnewmsBLSGA3jRa5M+qCAY6PSV2YbaDw1VHQfP
         vRDdmOGKfb9p5cEjbhM/GyqG7fs/3mI4Wp1fugV1gbC5fPI9ZubLh5b7Qgd/UktQVvNH
         Ji1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWog52r9UhwwKHJnS2DgiKUnzPtYRWIo12zpEi/m71csivwTjrpQ/cJe9mEng3NTAgURGnV0eRTJug56ctn+e1Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxguHUtPFHV6xmJoaqpKgHzKJkMUHzXwlAtsul4sGOImGC4ZPYv
	YsAucWctggZ7zULov3Lx4MY2PnFIo4cKqVoZOt387pIKW3YAGsUMVHve9NjgRWlp8YYDbjHvq3B
	Gk9P93A==
X-Google-Smtp-Source: AGHT+IEBspnJAKBzWkWTjIu1qILbutTNKhI5LZBLyodUxmyHgXnLBOW2hkoSK/Tlq102Fc0XLDK0NA1tOHlJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5003:3a14:d4e7:121])
 (user=irogers job=sendgmr) by 2002:a25:dc4b:0:b0:e5b:3bfe:4bf4 with SMTP id
 3f1490d57ef6-e5e24844e2dmr471779276.1.1740204636687; Fri, 21 Feb 2025
 22:10:36 -0800 (PST)
Date: Fri, 21 Feb 2025 22:10:11 -0800
In-Reply-To: <20250222061015.303622-1-irogers@google.com>
Message-Id: <20250222061015.303622-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Subject: [PATCH v3 6/8] perf parse-events: Switch tracepoints to io_dir__readdir
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid DIR allocations when scanning sysfs by using io_dir for the
readdir implementation, that allocates about 1kb on the stack.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

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
2.48.1.658.g4767266eb4-goog

