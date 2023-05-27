Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FF6C77B7E
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 03:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjE0Dnz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 23:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjE0Dnx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 23:43:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B619A
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 20:43:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-564feceb97dso28465857b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 20:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685159030; x=1687751030;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4yvnrpEe2huDW+hchGpet0pGN4yM12JCmRSaRQwE34o=;
        b=vdiA+trob+vQwP/l9vkYEO9/z+6U1/nBEc0wU3JdgwguFq/5kezVdXsk02KtLWokic
         jtJreMGHT9MVlRplIvKdvswFPCDUeXNkYxrFl04Xx1hGU5kHz2z3sLpamee0nh/RrOVI
         viBOVpD596XUao9fsS4EeOEBtVMwghxosbyEPpZtX4JNhLSEfcL0wOtlv10Kg4p/dXau
         NkkT0UwPv0AZ2aBwmuokplOO+N00TAIddsDVI3u4RfDaT6FgTuPAzVfa5dzTk8Yfc6wV
         029oV8TOze6RTO2N7r1o0vCDMPnWgvQ3bwIbYujMjtLmDtk1Ybas1ucjEbaCOQQnwSxQ
         tiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685159030; x=1687751030;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yvnrpEe2huDW+hchGpet0pGN4yM12JCmRSaRQwE34o=;
        b=Uawnsz05ESSQenfWh4+yZcFDwVDluhUkU12JvTDBhgUxwnmJWKen+7DqYauhM0cjki
         ss/qW3NEJufC7Orof9bNU0JfgzDoMgEHrD0s3c4ria7AuA//PsXb36HwTxuWmseojWM2
         E/JdoTaNz5hMJxjRkJv+Hrc/nxV85Rhrgjj862m5xy71eNq1/pyYcz6qpAArxeNYtKvN
         b4s/HhMVn4b80a/fa4eXWT247VdoSzxyoTqrJPcT7T9huXAbZ55KSy1knn+CjQPZ47TQ
         aWoMxbbRDEkZk4HKjgnZkJgTf+j1JmlLRIx+bBd9OkHjHr12ZEkZK6H0RhZl+81HLd0S
         QDEQ==
X-Gm-Message-State: AC+VfDwTPrlAuXWiJL05luaFU1z0Ybdcf+8Glla755MF1XhhCSUMPM4+
        BQes28qmvEDYbA0UuemR1XD7TsD4BD6P
X-Google-Smtp-Source: ACHHUZ4Zsr/NqIVSUKSFW44V5X/YdTceRVOHBh7ZeU4ozH2kjIPNTkmdKhb86VBC89V8M7NU9xpcWemAwXDt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a05:690c:711:b0:565:cfac:6d15 with SMTP id
 bs17-20020a05690c071100b00565cfac6d15mr502739ywb.8.1685159030508; Fri, 26 May
 2023 20:43:50 -0700 (PDT)
Date:   Fri, 26 May 2023 20:43:22 -0700
In-Reply-To: <20230527034324.2597593-1-irogers@google.com>
Message-Id: <20230527034324.2597593-5-irogers@google.com>
Mime-Version: 1.0
References: <20230527034324.2597593-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 4/4] perf inject: Lazily allocate guest_event event_buf
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

The event_buf is 64kb (PERF_SAMPLE_SIZE_MAX) and stack allocated in
struct perf_inject. It is used for guest events that may not exist in
a file. Make the array allocation lazy to cut down on the stack usage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index da8c89fefa3a..d68d25575b6c 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -47,7 +47,7 @@
 struct guest_event {
 	struct perf_sample		sample;
 	union perf_event		*event;
-	char				event_buf[PERF_SAMPLE_MAX_SIZE];
+	char				*event_buf;
 };
 
 struct guest_id {
@@ -1372,11 +1372,19 @@ static void guest_session__convert_time(struct guest_session *gs, u64 guest_time
 
 static int guest_session__fetch(struct guest_session *gs)
 {
-	void *buf = gs->ev.event_buf;
-	struct perf_event_header *hdr = buf;
+	void *buf;
+	struct perf_event_header *hdr;
 	size_t hdr_sz = sizeof(*hdr);
 	ssize_t ret;
 
+	buf = gs->ev.event_buf;
+	if (!buf) {
+		buf = malloc(PERF_SAMPLE_MAX_SIZE);
+		if (!buf)
+			return -ENOMEM;
+		gs->ev.event_buf = buf;
+	}
+	hdr = buf;
 	ret = readn(gs->tmp_fd, buf, hdr_sz);
 	if (ret < 0)
 		return ret;
@@ -2399,5 +2407,6 @@ int cmd_inject(int argc, const char **argv)
 		perf_data__close(&inject.output);
 	free(inject.itrace_synth_opts.vm_tm_corr_args);
 	free(inject.event_copy);
+	free(inject.guest_session.ev.event_buf);
 	return ret;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

