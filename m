Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239A2C11E1
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774779; cv=none; b=LZ2aBgam6ygp9wTypi7/ePBQ+5kWn2CZ7DJjbNfDILoQyRIcMyjD97pJDVBf9pe8mUKAmcWfGkaVra7XL0qWSzkhdNq+/nYiL/w26Fi16mPExoix5AI6zgRlmFGxhWcm9ao/5nBDEwijV+r60qdNk/KA15jaitd1BjPlW8Ys8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774779; c=relaxed/simple;
	bh=Q8lcCWydMDVujK6/wN03/oysJCuCldnfOF+1TNRE1EE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QNZQeAYg35BJNXCENiOgkbtUGLohiSw8pKYKcdpJsEF4ZVIWXtf4zdK3JE5Wsd18ps360zGs+FdS6fJaeeIWlYhiChKDD570rdCHgJ5RgvuZruUMc006l83YzRf98lLOB9BCefPD4R1tyXqYDbOmnzKj04O54EhE5bG8AZ++iNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2jZGSOgi; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jZGSOgi"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b7ef896edcso23271335eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 17:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770774774; x=1771379574; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UiHopQidaKUSI5zxqKq6dP/VKpRLeTJcWrFTpufmmAw=;
        b=2jZGSOgiQPDh0XMddEIvUbepsnz3+BnHPd9N+rdNvkNlh8GP9iOtNjdBvgFOP85mNX
         RNNoRQT1ORvS0Uq3HbfSNKZWXUJylY3ukQjkDC86NrTI0LluyPtjMfqMdKvd51+fcWt3
         p3QQpemkHUroBC0WmMHaVu7QT8D2SBJ7xGQK8rohxkC3/bO06wNpFSdF6z+4nBzV45m6
         7cB8uyE7dbAq+nu1m/JjoNyYdHNVtmRpx1U3J1fKzp32SoChi7HLpw9KbMYvJDxS1QuS
         W1lwwqrDJ2BFdgg49rDAyfnD37cbVtSddWrQS1VhClmoRZoKuYRAyMNZlLGkQK55xzif
         P5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774774; x=1771379574;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiHopQidaKUSI5zxqKq6dP/VKpRLeTJcWrFTpufmmAw=;
        b=sXxVkhV/y4qtp7vYmR0zHDVjznip6/EIL04NjEXTfkIQLtBAQJd229SH55ycXf3vts
         CZZ0sL9QkQH1tQOd+gRPJVV0Ybq802MKZ78wf93E2LH6P+pSX3i+t2JwWCX+YshtBcsU
         4ONqDnpk7BG/NzmYwd7VmYx8jf316+Pfg9bbZrT4DGciQMkthRyq3C77SPJZrpj+vd/W
         d6eJLqq9fQnDfFaCGCcNyYWJUEi0TH9ZoP99/B9sgFV9vHiZYrSG1+lsI8VQM418LtoB
         B25ESdhvmX1fHlez8454cJfqRlI7oeErxkosJfa+v5T9IZTnwoUwUZ8EPMS+lvE7v5vZ
         e5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0gaoVxbiLM0ct0IAq96AySuwDRypREpIkGS4CpkxCqKC/7pjwE42+eW9W8AcMH5LwDRSa6xkDo+3cT/m7xeLO@vger.kernel.org
X-Gm-Message-State: AOJu0YzmYfwtfcbHDEB7KowsyFpn4dc2cEyjmkWIuCloVKDU1tKy/m7H
	4ODmbIzBPtx8HdDGO9+7Imyv5X7+XkyzbWjSBioN7Q1MVAiMoyIddL+Jls+GJVIVHKqonknx1wQ
	UKXp6B4DmLw==
X-Received: from dybgj26.prod.google.com ([2002:a05:7301:11a:b0:2b7:d91:b4a2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fd07:b0:2ba:7b0b:e20a
 with SMTP id 5a478bee46e88-2ba9e16832bmr96757eec.37.1770774774552; Tue, 10
 Feb 2026 17:52:54 -0800 (PST)
Date: Tue, 10 Feb 2026 17:52:40 -0800
In-Reply-To: <20260211015242.2700218-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260211015242.2700218-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260211015242.2700218-4-irogers@google.com>
Subject: [PATCH v1 3/5] perf json: Pipe mode --to-ctf support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In pipe mode the environment may not be fully initialized so be robust
to fields being NULL. Add default handling of attr events, use the
feature events to populate the ctf writer environment.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data-convert-bt.c | 54 +++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index a22e9049ff30..ba1c8e48d495 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -35,6 +35,7 @@
 #include "clockid.h"
 #include "util/sample.h"
 #include "util/time-utils.h"
+#include "header.h"
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
@@ -1338,7 +1339,8 @@ static void cleanup_events(struct perf_session *session)
 		struct evsel_priv *priv;
 
 		priv = evsel->priv;
-		bt_ctf_event_class_put(priv->event_class);
+		if (priv)
+			bt_ctf_event_class_put(priv->event_class);
 		zfree(&evsel->priv);
 	}
 
@@ -1387,7 +1389,7 @@ static int ctf_writer__setup_env(struct ctf_writer *cw,
 
 #define ADD(__n, __v)							\
 do {									\
-	if (bt_ctf_writer_add_environment_field(writer, __n, __v))	\
+	if (__v && bt_ctf_writer_add_environment_field(writer, __n, __v))	\
 		return -1;						\
 } while (0)
 
@@ -1403,6 +1405,52 @@ do {									\
 	return 0;
 }
 
+static int process_feature_event(const struct perf_tool *tool,
+				 struct perf_session *session,
+				 union perf_event *event)
+{
+	struct convert *c = container_of(tool, struct convert, tool);
+	struct ctf_writer *cw = &c->writer;
+	struct perf_record_header_feature *fe = &event->feat;
+
+	if (event->feat.feat_id < HEADER_LAST_FEATURE) {
+		int ret = perf_event__process_feature(session, event);
+
+		if (ret)
+			return ret;
+	}
+
+	switch (fe->feat_id) {
+	case HEADER_HOSTNAME:
+		if (session->header.env.hostname) {
+			return bt_ctf_writer_add_environment_field(cw->writer, "host",
+								   session->header.env.hostname);
+		}
+		break;
+	case HEADER_OSRELEASE:
+		if (session->header.env.os_release) {
+			return bt_ctf_writer_add_environment_field(cw->writer, "release",
+								   session->header.env.os_release);
+		}
+		break;
+	case HEADER_VERSION:
+		if (session->header.env.version) {
+			return bt_ctf_writer_add_environment_field(cw->writer, "version",
+								   session->header.env.version);
+		}
+		break;
+	case HEADER_ARCH:
+		if (session->header.env.arch) {
+			return bt_ctf_writer_add_environment_field(cw->writer, "machine",
+								   session->header.env.arch);
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int ctf_writer__setup_clock(struct ctf_writer *cw,
 				   struct perf_session *session,
 				   bool tod)
@@ -1635,6 +1683,8 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	c.tool.tracing_data    = perf_event__process_tracing_data;
 	c.tool.build_id        = perf_event__process_build_id;
 	c.tool.namespaces      = perf_event__process_namespaces;
+	c.tool.attr            = perf_event__process_attr;
+	c.tool.feature         = process_feature_event;
 	c.tool.ordering_requires_timestamps = true;
 
 	if (opts->all) {
-- 
2.53.0.239.g8d8fc8a987-goog

