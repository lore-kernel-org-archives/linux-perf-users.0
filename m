Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF513CD37B2
	for <linux-perf-users@archiver.kernel.org>; Sat, 16 Sep 2023 03:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjIPD47 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Sep 2023 23:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjIPD4v (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Sep 2023 23:56:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838931BC5
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Sep 2023 20:56:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8191a1d5acso2980548276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Sep 2023 20:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694836605; x=1695441405; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bzQLVbdICvR0anuI1LoACUXsVUlI7kEOUbUElnKpCyc=;
        b=kde0jXwFzS3mRaxWJym0JxLBJs84Di/zLD5SNDxY/ZPHWRtk7yzWueAWNDoJZa1UtZ
         WoYAXlFj5uONXU73v46gOsjH3DdoYZyPsXxn3MnadvOuxW4xurf5oj4uKrS9c5q9PArQ
         hDD0uqr9rfp7N5cBeI6rcL4CPg1x+ot6DEVHtjeZ5wrJDmlTsLRUA+rdlMaB7Y+XSYHg
         INCTHAlXEtI/PU+/ENu73wxuO1dkKllr3t2XG/77YO+qizqPu54yCpYrvoSeu+Od6Bn9
         nmk69yTbZNImmf4Gfa3WGLBKmmQO8BTDLRPRczeT+FEPWPduXO5UfeswtJaXiSoYMwyt
         J05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694836605; x=1695441405;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzQLVbdICvR0anuI1LoACUXsVUlI7kEOUbUElnKpCyc=;
        b=rq1slkTVToWAnIQvlC1Xjr1O8JtVAa8YZ8CGw9cyqAOwZNmqWQKqRa7cjVJGH8p3sW
         rwtpCw4qmYK2rVAG1r2HW+FHTLYYbn6+KgJS+/RSYJqpM957UJQN0lt7dCQSUyROd4i2
         orMwrd3LRk6S7wP/T0/vMlyieqYLltwe98/TdD13IbwoV4w3hAaAALaEv7foceKTi37i
         lQkbJXjPINAvSD0mSY7FAQqQb7CWwX2zzplfAQCaD2fDIeDjKInzok1nhiCz3gHIy90C
         ze9ZS+mxvqDJwDgH21WfEOzVt+EFXdt0hR5HJK+SL6AOMl7kiQu8tAEsTgdvf04O7uMA
         LT6Q==
X-Gm-Message-State: AOJu0YxJGs1sCVNcVTVyyfIOVzQfXxlaYhsqTQBkf4LUVjVct2tPcPM6
        PjJqXuzGggz4qFg548oj0gOARM/M2JR0
X-Google-Smtp-Source: AGHT+IHPl2mfI2FXOQHCNG1ebyKKkDV0rSTCXZae55BeQ1YbUjz4gqpnWaVzSdtYUzwE5EG9x/odWUcTn9JV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:de72:1a43:1938:6165])
 (user=irogers job=sendgmr) by 2002:a05:6902:118a:b0:d80:183c:92b9 with SMTP
 id m10-20020a056902118a00b00d80183c92b9mr90954ybu.4.1694836604799; Fri, 15
 Sep 2023 20:56:44 -0700 (PDT)
Date:   Fri, 15 Sep 2023 20:56:40 -0700
Message-Id: <20230916035640.1074422-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
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
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Dummy events are created with an attribute where the period and freq
are zero. evsel__config will then see the uninitialized values and
initialize them in evsel__default_freq_period. As fequency mode is
used by default the dummy event would be set to use frequency
mode. However, this has no effect on the dummy event but does cause
unnecessary timers/interrupts. Avoid this overhead by setting the
period to 1 for dummy events.

evlist__add_aux_dummy calls evlist__add_dummy then sets freq=0 and
period=1. This isn't necessary after this change and so the setting is
removed.

Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy constructor")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 25c3ebe2c2f5..e36da58522ef 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evlist *evlist)
 		.type	= PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
+		/* Avoid frequency mode for dummy events to avoid associated timers. */
+		.freq = 0,
+		.sample_period = 1,
 	};
 
 	return evsel__new_idx(&attr, evlist->core.nr_entries);
@@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 	evsel->core.attr.exclude_kernel = 1;
 	evsel->core.attr.exclude_guest = 1;
 	evsel->core.attr.exclude_hv = 1;
-	evsel->core.attr.freq = 0;
-	evsel->core.attr.sample_period = 1;
 	evsel->core.system_wide = system_wide;
 	evsel->no_aux_samples = true;
 	evsel->name = strdup("dummy:u");
-- 
2.42.0.459.ge4e396fd5e-goog

