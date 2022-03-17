Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C5CC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Mar 2022 22:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiCQWod (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Mar 2022 18:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCQWoc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Mar 2022 18:44:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C355771
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Mar 2022 15:43:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h8-20020a25e208000000b00628c0565607so5560424ybe.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Mar 2022 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Quw5pKZWI0gGahzjOjy/Y5sjn3FIERyKvG0tcs0jMps=;
        b=RC4U9MKxbUpik1R32Ww8fll/kQRSlc2R8uVUmQXKT+y9Kms3VodZZpZIlcoE4qN/3s
         vwGwOEQ+wAG4RTNaN++I9Y9ulLYLOI97fUnFnVzAlFhx3FlacUQOnqS/xnDsKR+fXchI
         cVfJvUi8Ln1avhgjpSt+Xrjgp96UuG11Tp/IhwIzIjwqgoIuTFvCYBW31zP5jWb8teHY
         8VOTRjj8Krsr41fqYg2bQPNLd1dFb9exCXZBqjv/xl47wTZgVitYxsHd2Qqdi+wYZfxF
         OhmavQ5dhEVB5eBk+iLf+DlrD44IDCzi2rNoMYRbjLS1hAKm7lmUKnSP7TEcICrRn2HB
         ZrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Quw5pKZWI0gGahzjOjy/Y5sjn3FIERyKvG0tcs0jMps=;
        b=24Wl13dPr3HYsgkPqE5mPHSq8mGG9TzBYU3wXkifbOWNUytxSmSGBLnmoqBiZT4KTm
         zavfXv9xFkeXKHri2b6waDjXJTOM88pzn16vaoEt0J6cHhBmJ0UHvJiiWeZ6PDLsRySp
         8dGr/0UYpBppCk0+Oif8V/4n6xW2mKc7DnN9hBeoV/0ro6hMqvyMqO3TGbbJgH7w98PC
         ZYG175VjIF9BJdsdA8MPie5pnc2C/HmVaX14PXsGwMPkx24TrIWWoxr5w5q1G0ncs757
         LKYrqAlrn9VRvVAvatWIwTp3rXIvxjp6CSoY6lDiL5H2lgSOFWZ/I5XT1T949yiMm0vt
         TNuw==
X-Gm-Message-State: AOAM533zskl+GpCSLsJ6xCUFt5X8z1gcrsUctrsJp7eUQYWVmCZi4zrc
        ieMuCzWD/Kby9mwzCH3Az+AHDnXCtYKs
X-Google-Smtp-Source: ABdhPJxxoHmYNsNLQpHtSnpG/Uy+E0F4Jk4lzTm63hLihwRDkSNrbNkfgc41BZzTlMlkSpgcqUtnj4fvURI0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6811:1685:e3b9:7904])
 (user=irogers job=sendgmr) by 2002:a25:5b57:0:b0:633:6b5c:86ad with SMTP id
 p84-20020a255b57000000b006336b5c86admr7751468ybb.113.1647556993187; Thu, 17
 Mar 2022 15:43:13 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:43:09 -0700
Message-Id: <20220317224309.543736-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] perf parse-events: Ignore case in topdown.slots check
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
        Ian Rogers <irogers@google.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

An issue with icelakex metrics:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json?h=perf/core&id=65eab2bc7dab326ee892ec5a4c749470b368b51a#n48
That causes the slots not to be first.

Fixes: 94dbfd6781a0 ("perf parse-events: Architecture specific leader override")
Reported-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index f924246eff78..8d9b55959256 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -29,7 +29,7 @@ struct evsel *arch_evlist__leader(struct list_head *list)
 
 	__evlist__for_each_entry(list, evsel) {
 		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
-			evsel->name && strstr(evsel->name, "slots"))
+			evsel->name && strcasestr(evsel->name, "slots"))
 			return evsel;
 	}
 	return first;
-- 
2.35.1.894.gb6a874cedc-goog

