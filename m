Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C65FC7EE31
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 03:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjE0Dn5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 23:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjE0Dnv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 23:43:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA52710A
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 20:43:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56552a72cfbso33192087b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 20:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685159028; x=1687751028;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SX/Sd6Hz8SucmgLLqLgFnj2GhAGV//bvgD4WKofd4fE=;
        b=wq+K9+YK2q2GWtwBQagLJBPoNdupJSt8Trc6Xc2YbvtweMG3pLrGczGpkHj1qdbXEd
         lRlL/TPPGxzEilLsh6ZsHYBHUwIOWtPVFQeGVPtgKj36wPZddikWy7mVpWMogfxGyQji
         zd/5bIWv2LrrAaDp3bQiPUj5eT59sb/hl2zNXTzzpc0/ODlX2/izzmNX6jOttB5Gwvc6
         xC/f0XAHW4TaGswS4OTMY0pixe0MDGKP3sjB63mSc5h65L8m9Uq5ZtMXjFnMt7V62sUh
         AXd4mtf/NiIhG8mK5M6EjCjvV2D6c+BWbhiGC82EFDLucc//Kz6Lfof64TCnQRbVguOA
         K4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685159028; x=1687751028;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX/Sd6Hz8SucmgLLqLgFnj2GhAGV//bvgD4WKofd4fE=;
        b=fEqzC/wCeIlv/AqDiOE6Hjau964sJXRxvblDpACVeeVBVl5tPAa9Yd6wuxSsp/EJOI
         9qJXu9YWKnocQ9eA2GFFB5iw7cQ5f+tDKpPPFDmGNlViVSfD+z7jtwyDlw80s2ZN0YwU
         rm1UOHgRT527plsvR4kIpG7AHXupz3WnyHQCcWTddFX4sXMcfkpmVC/UwHtOczlWqCxR
         Y2uRdMEAsxsVbszptwajDb0I61PFC9uN1v2IkQgoPVvd32nG7Hh+3AhMSIAp9k9W24O1
         piJijwCR4pMQTZyNkxhEyMkHIrz859XO93DLP9VujAH9ft92OWyIb2Z0czWJAtp/Qlh1
         YbDg==
X-Gm-Message-State: AC+VfDyUSA8nGVbyzUWgq8FKc9fVDTShwVj3pGWY2BcYfr8RThvo58zW
        0Axc02oT0yzJRuGOmet+ZVzgcLLISmPk
X-Google-Smtp-Source: ACHHUZ6oHxaq/Re3GjQR3B8rFQwiDAFpOTBD4/Os9JJh1F7fFYsEUjt4QQ/nKBe1tBvxls9SJIEZ0Mxvpzpk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:ac07:0:b0:565:b269:5ef7 with SMTP id
 k7-20020a81ac07000000b00565b2695ef7mr2190130ywh.1.1685159028067; Fri, 26 May
 2023 20:43:48 -0700 (PDT)
Date:   Fri, 26 May 2023 20:43:21 -0700
In-Reply-To: <20230527034324.2597593-1-irogers@google.com>
Message-Id: <20230527034324.2597593-4-irogers@google.com>
Mime-Version: 1.0
References: <20230527034324.2597593-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 3/4] perf inject: Lazily allocate event_copy
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The event_copy is 64kb (PERF_SAMPLE_SIZE_MAX) and stack allocated in
struct perf_inject. It is used for aux events that may not exist in a
file. Make the array allocation lazy to cut down on the stack usage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 61766eead4f4..da8c89fefa3a 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -122,7 +122,7 @@ struct perf_inject {
 	u64			aux_id;
 	struct list_head	samples;
 	struct itrace_synth_opts itrace_synth_opts;
-	char			event_copy[PERF_SAMPLE_MAX_SIZE];
+	char			*event_copy;
 	struct perf_file_section secs[HEADER_FEAT_BITS];
 	struct guest_session	guest_session;
 	struct strlist		*known_build_ids;
@@ -320,8 +320,14 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
 {
 	size_t sz1 = sample->aux_sample.data - (void *)event;
 	size_t sz2 = event->header.size - sample->aux_sample.size - sz1;
-	union perf_event *ev = (union perf_event *)inject->event_copy;
+	union perf_event *ev;
 
+	if (inject->event_copy == NULL) {
+		inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
+		if (!inject->event_copy)
+			return ERR_PTR(-ENOMEM);
+	}
+	ev = (union perf_event *)inject->event_copy;
 	if (sz1 > event->header.size || sz2 > event->header.size ||
 	    sz1 + sz2 > event->header.size ||
 	    sz1 < sizeof(struct perf_event_header) + sizeof(u64))
@@ -357,8 +363,11 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 
 	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
 
-	if (inject->itrace_synth_opts.set && sample->aux_sample.size)
+	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
 		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
+		if (IS_ERR(event))
+			return PTR_ERR(event);
+	}
 
 	return perf_event__repipe_synth(tool, event);
 }
@@ -2389,5 +2398,6 @@ int cmd_inject(int argc, const char **argv)
 	if (!inject.in_place_update)
 		perf_data__close(&inject.output);
 	free(inject.itrace_synth_opts.vm_tm_corr_args);
+	free(inject.event_copy);
 	return ret;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

