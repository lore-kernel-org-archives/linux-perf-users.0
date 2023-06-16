Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51C3EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jun 2023 21:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjFPVrt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jun 2023 17:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFPVrs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2023 17:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA991195
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 14:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6702F60F5A
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 21:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6AFC433C8;
        Fri, 16 Jun 2023 21:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686952066;
        bh=BCYXhGSmVVvqAYCRUFMQE+0twl5zp9eVZeX9R7mGAu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aD3DWQE4rB2D/UHSVl5dauq53IK/Us21uT1+iqvuV0mS1vfbCgnwJZCDUxg7xOYy0
         ISpgoPVoqPmaA9h5fj2MQH6ykT57D77r99JspetvNFBt7ec1caxrU4DiowB5+F2QkY
         xdEUeiWsz5L2ZT9kWgbc78ZGty3XL+MPxalkzfre3fGnI1ehCOZkAlGqF/c6coGyBA
         bxkjMnmIkzKa4kji0JyfdQDe5hpV5zfR6wPLx5udbEqsNht8TpGHoyEg9z7JZTB2Se
         S6pN90hM/bmFC6wOsKFFTpXs7vuWDITbswqNyC6cL+FgOUBaXTNWtzxzgHAgVsU/2X
         rcQKBWjp0qUEA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B89840692; Fri, 16 Jun 2023 18:47:44 -0300 (-03)
Date:   Fri, 16 Jun 2023 18:47:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>
Subject: Re: Hybrid PMU issues on aarch64. was: Re: perf test failures in
 linux-next on s390
Message-ID: <ZIzYgImv61OGK1wA@kernel.org>
References: <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
 <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com>
 <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
 <a19a30b0-8f16-5871-6856-503eadf56e3c@linux.ibm.com>
 <ZIshkbmQR7oOFiHu@kernel.org>
 <CAP-5=fVYy6jMd9Nw7iqqsm_G-qW__Lo8kFeCocJ0W2no4XTbpg@mail.gmail.com>
 <ZIxza13x+AwApbQb@kernel.org>
 <ZIx1Y9mWc13huQt2@kernel.org>
 <CAP-5=fVpU6Bm1REcANEu2qsE5eQH2VOx2uz+X0VSoH76r_d7uQ@mail.gmail.com>
 <ZIyTlR+jJ27YKPVx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIyTlR+jJ27YKPVx@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jun 16, 2023 at 01:53:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> > presumably with the #ifdef you just get 1 PMU - shame. I think rather
> > than do an #ifdef we can do something like call is_event_supported:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/print-events.c?h=perf-tools-next#n232
> > so:
> > bool perf_pmus__supports_extended_type(void)
> >   struct perf_pmu *pmu = NULL;
> >   if (perf_pmus__num_core_pmus() <= 1)
> >      return false;
> >   while((pmu = perf_pmus__scan_core(pmu) != NULL) {
> >     return is_event_supported(PERF_TYPE_HARDWARE,
> > PERF_COUNT_HW_CPU_CYCLES | ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT);
> >  }
> > return false;
> > }
> > We probably don't want to do this for each call of
> > perf_pmus__supports_extended_type so you could use a static and
> > pthread_once, etc.
> > 
> > This would mean if this regression is introduced elsewhere than ARM it
> > will self heal. It will also mean that when ARM support extended types
> > in the kernel, they will get the normal heterogeneous behavior.
> 
> That looks better, I'll try it when I get back to my office.

End result, Ack?


diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index a2032c1b7644..d891d72c824e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -4,6 +4,7 @@
 #include <subcmd/pager.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include <pthread.h>
 #include <string.h>
 #include <unistd.h>
 #include "debug.h"
@@ -492,9 +493,35 @@ int perf_pmus__num_core_pmus(void)
 	return count;
 }
 
+static bool __perf_pmus__supports_extended_type(void)
+{
+	struct perf_pmu *pmu = NULL;
+
+	if (perf_pmus__num_core_pmus() <= 1)
+		return false;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		if (!is_event_supported(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES | ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT)))
+			return false;
+	}
+
+	return true;
+}
+
+static bool perf_pmus__do_support_extended_type;
+
+static void perf_pmus__init_supports_extended_type(void)
+{
+	perf_pmus__do_support_extended_type = __perf_pmus__supports_extended_type();
+}
+
 bool perf_pmus__supports_extended_type(void)
 {
-	return perf_pmus__num_core_pmus() > 1;
+	static pthread_once_t extended_type_once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&extended_type_once, perf_pmus__init_supports_extended_type);
+
+	return perf_pmus__do_support_extended_type;
 }
 
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 7a5f87392720..a7566edc86a3 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -229,7 +229,7 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 	strlist__delete(sdtlist);
 }
 
-static bool is_event_supported(u8 type, u64 config)
+bool is_event_supported(u8 type, u64 config)
 {
 	bool ret = true;
 	int open_return;
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index e75a3d7e3fe3..d7fab411e75c 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -3,6 +3,7 @@
 #define __PERF_PRINT_EVENTS_H
 
 #include <linux/perf_event.h>
+#include <linux/types.h>
 #include <stdbool.h>
 
 struct event_symbol;
@@ -36,5 +37,6 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
 			 unsigned int max);
 void print_tool_events(const struct print_callbacks *print_cb, void *print_state);
 void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state);
+bool is_event_supported(u8 type, u64 config);
 
 #endif /* __PERF_PRINT_EVENTS_H */
