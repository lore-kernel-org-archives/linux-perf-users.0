Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CABDC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Mar 2022 22:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiCUWz0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Mar 2022 18:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiCUWzJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Mar 2022 18:55:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFD3386718
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2022 15:33:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y10-20020a5b0d0a000000b00633b9765410so7910259ybp.18
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2022 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SpMsyAVY3Ou4ayr2UUYCx6xfElQ9mcgAD2W4Le+nlxs=;
        b=bxKFolBykFNwtGqa9A5Zv5QZ9Ai6Ja84JYVRKGk+yEJYFUgtKde7nioaqACjn8FG2G
         tmv5I6Pm13yFLyrQhOoEW3XVEtflPeAjcShYbuWGFHRmh0cfao9cXbvNHclX4vYI5twx
         JNzzvLk10AayW8KECkv/Nq2PgPL4870qnyxtnlxhOAGeW8oZhgXJHZK4g982LoK11iHx
         X4ag52xx5xMBjQhkfIlRF+mmtK0/NJLrfi5/I1YLTtw0utBqzqj4m4vE2By+1YjcfGsu
         wHOf7xkEHJHLEWXwGc1QwKTloyWocN5HuVM5SHn45E5vg/BRoO1BO1nwXnB0XdtGf2Bk
         tSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SpMsyAVY3Ou4ayr2UUYCx6xfElQ9mcgAD2W4Le+nlxs=;
        b=hLNjR4vwxlcfDVfq8nGoWz2QWAtzXvEfdVdu6MlFKvTWUFnYZAlHvZ++NEn5FCsl39
         piPI3LNf8Y/nXOI4gq8xP5DSPcuFUtF/GSegvvG5UQzIYuKbAa2QgUPh1F0KfA5XdoEd
         WWvUgrC6Hw3AEV43w8DgmDLqXspZNMu6YINwhA2193oMjvAL11xkILuZEk4heaMb4cde
         S4hk3fh5Vw4nPqvFGeWORv4ufeidMa/zS6F0KvLrCzQ0jjXYzl7SAjsY9ePRpKj8ciEe
         T0/MNE7WJ8NccP5cREVZr0o0f8wfsr9PjeJ+5fKPsBWakfFrfVdTOckjWC5cGDb47jCF
         E5JQ==
X-Gm-Message-State: AOAM531Vo1pt61OWnWyCwpeIQX8sKfX+/0kGey1+YXYFLMhStGWHqji8
        pzEIP9EjCC48lbDFZegoyRofwTCkrGrl
X-Google-Smtp-Source: ABdhPJwNEOs7GijFSfW6DVg3FBLi7BK61nctdq2vDBs8q3qZjbfN2iuMK2ufFC13SQ9m3MWAcUhaH2beDQqF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1626:404f:eb8e:caae])
 (user=irogers job=sendgmr) by 2002:a81:1e95:0:b0:2e5:ad0d:b7fc with SMTP id
 e143-20020a811e95000000b002e5ad0db7fcmr26767986ywe.328.1647902028157; Mon, 21
 Mar 2022 15:33:48 -0700 (PDT)
Date:   Mon, 21 Mar 2022 15:33:44 -0700
Message-Id: <20220321223344.1034479-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] perf parse-events: Move slots only with topdown
From:   Ian Rogers <irogers@google.com>
To:     Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If slots isn't with a topdown event then moving it is unnecessary. For
example {instructions, slots} is re-ordered:

$ perf stat -e '{instructions,slots}' -a sleep 1

 Performance counter stats for 'system wide':

       936,600,825      slots
       144,440,968      instructions

       1.006061423 seconds time elapsed

Which can break tools expecting the command line order to match the
printed order. It is necessary to move the slots event first when it
appears with topdown events. Add extra checking so that the slots event
is only moved in the case of there being a topdown event like:

$ perf stat -e '{instructions,slots,topdown-fe-bound}' -a sleep 1

 Performance counter stats for 'system wide':

        2427568570      slots
         300927614      instructions
         551021649      topdown-fe-bound

       1.001771803 seconds time elapsed

Fixes: 94dbfd6781a0 ("perf parse-events: Architecture specific leader override")
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 8d9b55959256..cfc208d71f00 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -20,17 +20,27 @@ int arch_evlist__add_default_attrs(struct evlist *evlist)
 
 struct evsel *arch_evlist__leader(struct list_head *list)
 {
-	struct evsel *evsel, *first;
+	struct evsel *evsel, *first, *slots = NULL;
+	bool has_topdown = false;
 
 	first = list_first_entry(list, struct evsel, core.node);
 
 	if (!pmu_have_event("cpu", "slots"))
 		return first;
 
+	/* If there is a slots event and a topdown event then the slots event comes first. */
 	__evlist__for_each_entry(list, evsel) {
-		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
-			evsel->name && strcasestr(evsel->name, "slots"))
-			return evsel;
+		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") && evsel->name) {
+			if (strcasestr(evsel->name, "slots")) {
+				slots = evsel;
+				if (slots == first)
+					return first;
+			}
+			if (!strncasecmp(evsel->name, "topdown", 7))
+				has_topdown = true;
+			if (slots && has_topdown)
+				return slots;
+		}
 	}
 	return first;
 }
-- 
2.35.1.894.gb6a874cedc-goog

