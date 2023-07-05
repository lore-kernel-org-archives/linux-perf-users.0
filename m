Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0BEEB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jul 2023 19:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjGETox (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjGETou (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jul 2023 15:44:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65121990;
        Wed,  5 Jul 2023 12:44:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b895a06484so18453565ad.1;
        Wed, 05 Jul 2023 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586279; x=1691178279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yclTrzBLsbaEGvGCEpSUrAGw5ZKqNxDtNfrRanKfTkM=;
        b=KK357Qafb3bDy59jGWZwHPs6hzA/M9nIBL7YEFkn14veMx8Jw+PLHXDidJo2JeUUzT
         B0Gs0Cykr03evtx0ZNnx0o8PII8ZKrBIbdO2LgVGMN48DYjMWzzVkuYVa3Gkt42sIYRF
         oTVsmbnhgj1wANPd40Cxnu3ZGndhD+Bo9+yfV0qjv3j16Ipm9/Fi/jaSemgjOYXiJ10H
         FkJ5gEwWiG9FcpQQ4LzPTDkCqhAMmNP+h2TICzNtkU94mSqERZvSrvHETz15D7FlUhcZ
         XYgxXNLhA7oZoNamzQleYZnezkZO2haJoKbUft+2v3+B7UioMAMQQQU54nLVSlXXc+a0
         67IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586279; x=1691178279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yclTrzBLsbaEGvGCEpSUrAGw5ZKqNxDtNfrRanKfTkM=;
        b=G7Qh8qtyK5njiWSxAytNrbSIOmMqfJ6H0c16BZcLAosmrTlPw5ZQrsQO+fnxsPs9La
         QJ2mhW5L/Xy78Z6xoFpd+ZV4AcWkTfzKl668KV2x0qKMH412FBURGopfFvq12//4f8Z/
         OV4FbOGd34WFqpyXVrJ6YlZXq+i7yNbxXh1uAAA2jgRCvBMaBn46Ajo6PXCLuEUJLRdl
         07OPIOjRpimGFdoCwpoDIXVSXv7sr04w8l1osqHEchydKHN2THJ7ECxQm2lJjPlMfghd
         Walf8Z6TRA0yJ9pwq5+iBw2mKKWEZb0oNTM4tAyxH6D4r66gBOgXV37oGwr7G/ymY0rQ
         b1Xw==
X-Gm-Message-State: ABy/qLYfFi+AcwWVVThLByJdzFBJRDyJSJZUGLBHm0MSgM8S8ehWq9Hy
        jPOhAT8bJXYX88UAzUyUgR4=
X-Google-Smtp-Source: APBJJlGhvTrWD9TaRY6Fyr9MEAhGSBRSIMAIqvbM2M6VIgtotIllmt2k9luwDXM+lQ0VP12DJuAbKQ==
X-Received: by 2002:a17:902:f68c:b0:1b8:a6be:ead3 with SMTP id l12-20020a170902f68c00b001b8a6beead3mr4613918plg.57.1688586279163;
        Wed, 05 Jul 2023 12:44:39 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c628:31be:68ae:86f5:48b9])
        by smtp.gmail.com with ESMTPSA id bg6-20020a1709028e8600b001b3d0aff88fsm19298830plb.109.2023.07.05.12.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:44:38 -0700 (PDT)
Date:   Thu, 6 Jul 2023 01:14:31 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] scripts: python: Introduce thread sample processing
 to create thread
Message-ID: <df4773a4ebb43a6c855bad5a2bbc338bc2669ca7.1688585597.git.anupnewsmail@gmail.com>
References: <cover.1688585597.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688585597.git.anupnewsmail@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The _addThreadSample function is responsible for adding a sample to a specific
thread. It first checks if the thread exists in the thread_map dictionary.
If not, it creates a new thread using the _createtread function and assigns
it to the thread_map. Finally, it calls the 'addSample' method of the thread,
passing the thread name, stack, and timestamp.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../perf/scripts/python/firefox-gecko-converter.py  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index ce663840d212..95b061a97cbc 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -18,7 +18,20 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 from perf_trace_context import *
 from Core import *
 
+thread_map = {}
+start_time = None
+
 def process_event(param_dict):
+	global start_time
+	global thread_map
+
+	def _addThreadSample(pid, tid, threadName, time_stamp, stack):
+		thread = thread_map.get(tid)
+		if not thread:
+			thread = _createtread(threadName, pid, tid)
+			thread_map[tid] = thread
+		thread['addSample'](threadName, stack, time_stamp)
+
 	time_stamp = (param_dict['sample']['time'] // 1000) / 1000
 	pid = param_dict['sample']['pid']
 	tid = param_dict['sample']['tid']
-- 
2.34.1

