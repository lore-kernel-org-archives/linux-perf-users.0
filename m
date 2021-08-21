Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58617C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D83C61207
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbhHUJWz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhHUJWc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DAAC061152;
        Sat, 21 Aug 2021 02:20:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z20so25183200ejf.5;
        Sat, 21 Aug 2021 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Nz5cuYI+OBcCvgsxocGu8/AZ30FKdwuuYGkZjJe3RI=;
        b=XlfGwAjvHqfY+y4udXph83bMIIMSpq+LH04Tv1UnmEAhu+SI9fZUUDs8BQlQmhWdPn
         Y7cfA0zb+kADyU9y1OZPZ9t2mjEJQBD1OwjPxi8/76ohjBipKsx778JAaxcqaoVmQxLM
         maTYh5GJETMpfc91FdgA8MSnIw+7IyOEkLiehoCzgC7iQnRoQEC1wXDZ3zADk1mBfOgP
         dIGgtMI1P6+bhVPv0zCmRpO5ayN+CrHb8/nNFODRBnG+6uZy6aCkNli3/YJysAoJ5c2o
         3bgrIeA8j/3btQV+VNS4CJ/77cTlPqsbQWmq/WUfDMr2fR90HRF6MT1jI/KimY2zRw+M
         1YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Nz5cuYI+OBcCvgsxocGu8/AZ30FKdwuuYGkZjJe3RI=;
        b=JoI+5hcJi7GLEixgDoCqCkjM78MJUs7ZcPtpJLgyweEh2DuBx6fwdvzSw0S9gvvY0f
         1Wq3r+oB/6L2FF9iJqnyCrWzqYdvPTa2NNdA/MvGgRaWBI3EUGtrGO5Vo2RAqGubWCLG
         4/UQ9oOL4+wscAIcufWKNikSXB6XeAs7+yB5AduYGtSP+B/01bboDB+pvj1gyyQk+O5i
         cL/ty0sstoCzrhYwhbyAYGPkWXBocGQzFPik1W0/9WZ6jQHdvHNuYgkVIIdnTdrNYk6c
         OUfv2HRgKTSPU4x0XDysVh+j/dyg+9z9sN/CYONtfSE6T7PHT/ht0ScMECFEqNiD4mhR
         yjPQ==
X-Gm-Message-State: AOAM530jboCXGa/6u0KRQJxONLv8q4jfCGNtUjYC+5ipBrkGL8hcqwux
        Lmn6ci1AskNOn5LzAmwzCis=
X-Google-Smtp-Source: ABdhPJwEhzv1vtyyOdarPLAkKYHQELwvwBMh67mJUrR4i0LAMM810AeJvCpK5/M7CjiVNVh7D2OytQ==
X-Received: by 2002:a17:906:ac1:: with SMTP id z1mr25592170ejf.261.1629537631322;
        Sat, 21 Aug 2021 02:20:31 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:30 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 34/37] perf record: apply multithreading in init and fini phases
Date:   Sat, 21 Aug 2021 11:19:40 +0200
Message-Id: <f73e485eb0d29539722da396555d9fcbd0267642.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch grows the multithreaded portion of perf-record, marked by the
perf_set_multithreaded and perf_set_singlethreaded functions to the whole
init and fini part of __cmd_record.
By doing so, perf-record can take advantage of the parallelized evlist
operations (open, enable, disable, close).

This patch also needs to handle the case in which evlist and synthesis
multithreading are not enabled at the same time. Therefore, in
record__synthesize multithreading is enabled/disabled and then
disabled/renabled if needed.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-record.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e2d2445e05d7c07a..db9ec08db672f994 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1411,6 +1411,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	struct perf_tool *tool = &rec->tool;
 	int err = 0;
 	event_op f = process_synthesized_event;
+	bool perf_was_singlethreaded = perf_singlethreaded;
 
 	if (rec->opts.tail_synthesize != tail)
 		return 0;
@@ -1499,12 +1500,16 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (rec->opts.multithreaded_synthesis) {
 		perf_set_multithreaded();
 		f = process_locked_synthesized_event;
+	} else {
+		perf_set_singlethreaded();
 	}
 
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
 					    f, opts->sample_address);
 
-	if (rec->opts.multithreaded_synthesis)
+	if (!perf_was_singlethreaded && perf_singlethreaded)
+		perf_set_multithreaded();
+	if (perf_was_singlethreaded && !perf_singlethreaded)
 		perf_set_singlethreaded();
 
 out:
@@ -1735,6 +1740,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	record__uniquify_name(rec);
 
+	if (rec->opts.multithreaded_evlist)
+		perf_set_multithreaded();
+
 	if (record__open(rec) != 0) {
 		err = -1;
 		goto out_child;
@@ -1877,6 +1885,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		}
 	}
 
+	// disable locks in the main thread since there is no multithreading
+	if (rec->opts.multithreaded_evlist)
+		perf_set_singlethreaded();
+
 	trigger_ready(&auxtrace_snapshot_trigger);
 	trigger_ready(&switch_output_trigger);
 	perf_hooks__invoke_record_start();
@@ -1998,6 +2010,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		}
 	}
 
+	// reenable multithreading for evlist
+	if (rec->opts.multithreaded_evlist)
+		perf_set_multithreaded();
+
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
@@ -2099,6 +2115,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	if (!opts->no_bpf_event)
 		evlist__stop_sb_thread(rec->sb_evlist);
+
+	// disable multithreaded mode on exit
+	if (rec->opts.multithreaded_evlist)
+		perf_set_singlethreaded();
 	return status;
 }
 
-- 
2.31.1

