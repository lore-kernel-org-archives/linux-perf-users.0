Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5A19DFAE
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549078; cv=none; b=sYFyJud9+XlihyIGmRXLhWZOkxFBH+1FEEK65b5r5zcL77pRDv/aGpFk6K7iuAbDqdXLUKTmZZ9z3eKOIgXm3FXQzyv16u3FIv9ex6AhsmS3ubUFGPKi7ph+xS5hgWzmKV8AJjTh+FFToweoaG8F2R4HXWO+OBQb/rewtlfmVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549078; c=relaxed/simple;
	bh=I9MC7x7L3df1lYQ3uA8v2KL/YaxxbJ+dLNIhKPtkiME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f60wwu5GIlc9EqN4/XUKWIIB4rIm9UTQIpAam973kLVb9YhnTNrTqtTZ5zHlntwJfQqscrMtpb25URE72XVU2571SrHQhOefrqZ5NHIEy6O5ZfoB2qGFh3ycv3YSUckpOrlRvFz+W806QtHu+GY083kLwjhCiG6EYZvrIZ2y73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCqtNG6U; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCqtNG6U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549076; x=1757085076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I9MC7x7L3df1lYQ3uA8v2KL/YaxxbJ+dLNIhKPtkiME=;
  b=aCqtNG6Ub9/eZ67Blb4D2BQwzwf578zAGqCxoEyULH1mfEaod1dgAfdR
   dKWUjcO+RTatrsqsuqCkuudhA+kDq4az50HBBpotJSUz5U94laE9SivrB
   9KUWOEp3ONbg7t2jPPOLax+5LgnT4C+YANx08SSXXwEzV2YGuQKpMt4/I
   NbLxSyCbznrJkpPg5VqTr66SxEqi886fjmPq0PzX9BN5u6l+0MMgPG0CT
   YDrQFCDJ7cgTYlI4JHaftHGs31UepWXrwMkn2X2Klx+9Al0ruBjLzA4K1
   KpTImexEqGZCsU52PhUROJwWPZAypQWJyu3EepQRNrWYf+poeb/QBBplC
   A==;
X-CSE-ConnectionGUID: ME3Ork5TSh6jJ8KPBTSQMg==
X-CSE-MsgGUID: OkLaRRZlTa+19CbYDgnPiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688975"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688975"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: R9KYaGvvQSqM3MwA2DE4OA==
X-CSE-MsgGUID: m23u7g2JSjaN6PGcdrtQUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456102"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 03/10] perf: Plumb passing machine to scripts
Date: Thu,  5 Sep 2024 08:07:57 -0700
Message-ID: <20240905151058.2127122-4-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905151058.2127122-1-ak@linux.intel.com>
References: <20240905151058.2127122-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Future patches requires the machine pointer in the script events
callback. Add the plumbing to pass (and ignore) machine everywhere.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c                            | 2 +-
 tools/perf/util/scripting-engines/trace-event-perl.c   | 5 +++--
 tools/perf/util/scripting-engines/trace-event-python.c | 6 ++++--
 tools/perf/util/trace-event-scripting.c                | 7 +++++--
 tools/perf/util/trace-event.h                          | 7 +++++--
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index dc7e5406dae9..c12beceae8b3 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2528,7 +2528,7 @@ static int process_sample_event(const struct perf_tool *tool,
 				thread__resolve(al.thread, &addr_al, sample);
 			addr_al_ptr = &addr_al;
 		}
-		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr);
+		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr, machine);
 	} else {
 		process_event(scr, sample, evsel, &al, &addr_al, machine);
 	}
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index e16257d5ab2c..7b901bf1bdad 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -462,9 +462,10 @@ static void perl_process_event(union perf_event *event,
 			       struct perf_sample *sample,
 			       struct evsel *evsel,
 			       struct addr_location *al,
-			       struct addr_location *addr_al)
+			       struct addr_location *addr_al,
+			       struct machine *machine)
 {
-	scripting_context__update(scripting_context, event, sample, evsel, al, addr_al);
+	scripting_context__update(scripting_context, event, sample, evsel, al, addr_al, machine);
 	perl_process_tracepoint(sample, evsel, al);
 	perl_process_event_generic(event, sample, evsel);
 }
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d7183134b669..d0ea8bbe962a 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1509,11 +1509,13 @@ static void python_process_event(union perf_event *event,
 				 struct perf_sample *sample,
 				 struct evsel *evsel,
 				 struct addr_location *al,
-				 struct addr_location *addr_al)
+				 struct addr_location *addr_al,
+				 struct machine *machine)
 {
 	struct tables *tables = &tables_global;
 
-	scripting_context__update(scripting_context, event, sample, evsel, al, addr_al);
+	scripting_context__update(scripting_context, event, sample, evsel, al, addr_al,
+				  machine);
 
 	switch (evsel->core.attr.type) {
 	case PERF_TYPE_TRACEPOINT:
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index bd0000300c77..79ac0424b43e 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -26,7 +26,8 @@ void scripting_context__update(struct scripting_context *c,
 			       struct perf_sample *sample,
 			       struct evsel *evsel,
 			       struct addr_location *al,
-			       struct addr_location *addr_al)
+			       struct addr_location *addr_al,
+			       struct machine *machine)
 {
 	c->event_data = sample->raw_data;
 	c->pevent = NULL;
@@ -39,6 +40,7 @@ void scripting_context__update(struct scripting_context *c,
 	c->evsel = evsel;
 	c->al = al;
 	c->addr_al = addr_al;
+	c->machine = machine;
 }
 
 static int flush_script_unsupported(void)
@@ -55,7 +57,8 @@ static void process_event_unsupported(union perf_event *event __maybe_unused,
 				      struct perf_sample *sample __maybe_unused,
 				      struct evsel *evsel __maybe_unused,
 				      struct addr_location *al __maybe_unused,
-				      struct addr_location *addr_al __maybe_unused)
+				      struct addr_location *addr_al __maybe_unused,
+				      struct machine *machine __maybe_unused)
 {
 }
 
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index bbf8b26bc8da..c8414c7421ad 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -99,7 +99,8 @@ struct scripting_ops {
 			       struct perf_sample *sample,
 			       struct evsel *evsel,
 			       struct addr_location *al,
-			       struct addr_location *addr_al);
+			       struct addr_location *addr_al,
+			       struct machine *machine);
 	void (*process_switch)(union perf_event *event,
 			       struct perf_sample *sample,
 			       struct machine *machine);
@@ -133,6 +134,7 @@ struct scripting_context {
 	struct addr_location *al;
 	struct addr_location *addr_al;
 	struct perf_session *session;
+	struct machine *machine;
 };
 
 void scripting_context__update(struct scripting_context *scripting_context,
@@ -140,7 +142,8 @@ void scripting_context__update(struct scripting_context *scripting_context,
 			       struct perf_sample *sample,
 			       struct evsel *evsel,
 			       struct addr_location *al,
-			       struct addr_location *addr_al);
+			       struct addr_location *addr_al,
+			       struct machine *machine);
 
 int common_pc(struct scripting_context *context);
 int common_flags(struct scripting_context *context);
-- 
2.45.2

