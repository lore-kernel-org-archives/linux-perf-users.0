Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F932C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 12:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiKPMAA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 07:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiKPL7k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 06:59:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EE82FC0D;
        Wed, 16 Nov 2022 03:51:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DE3761D44;
        Wed, 16 Nov 2022 11:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B335C433D6;
        Wed, 16 Nov 2022 11:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668599491;
        bh=oVmMYntouiaOEf7aTBjD4O602LixAMAv75Jho8nCQ04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8+AQBnKP7fRdhhwUwTdJeAqI9WuPj3yAUrLBCqV9FnNVQHLB+BKlomy44OWDclja
         lYdgZb1HQqeBNRxP2PPbEK1jZ0wH9ImTXjLHGsRRTFBGfjvvzN1y+/yravxFhA+PeL
         fFwkcLadpwLTZdPLoF4OOYeFo5HgSVT6MBPis1vxhAmGVT69D3exiFWlDZXpR2ln/z
         N4hfF/nW5MqyhFDZIZpSLASBhSOXwGZWDfApBlimKesFkSAu8hl1Ocus2g9IcVKHYY
         k2aWhzH+xxvJNhzTaO2QqyEAZOSppAIEfGanW9iBaWdmvsrAPUVWca0d1PA/w33N4E
         oospbyzgRPvOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 123984034E; Wed, 16 Nov 2022 08:51:29 -0300 (-03)
Date:   Wed, 16 Nov 2022 08:51:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 10/10] perf list: Add json output option
Message-ID: <Y3TOwYdhzURKTgyB@kernel.org>
References: <20221114210723.2749751-1-irogers@google.com>
 <20221114210723.2749751-11-irogers@google.com>
 <Y3OX1pcclKCgbpeT@kernel.org>
 <Y3TIG7BIzltgvCPw@kernel.org>
 <Y3TK/6bBFsHxduPc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3TK/6bBFsHxduPc@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Nov 16, 2022 at 08:35:28AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Please always run 'perf test' before and after your patches and before
> > sending it upstream.
 
> Running as !root on a different machine I get some other interesting
> info:
 
> ⬢[acme@toolbox perf]$  perf list syscalls:sys_enter_open*
> double free or corruption (fasttop)
> Aborted (core dumped)
> ⬢[acme@toolbox perf]$
> 
> That is:
> 
>         free(ps.pmu_glob);
> 
> 
> at the end of cmd_list().

This plus the change to default_ps in the subsequent patch cures the
double free, now working on the segfault.

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 12811fc40a3067cc..ce62a2fdcbd6ca61 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -329,6 +329,7 @@ int cmd_list(int argc, const char **argv)
 			metricgroup__print(&print_cb, &ps);
 		} else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
+			char *old_pmu_glob = ps.pmu_glob;
 
 			sep_idx = sep - argv[i];
 			s = strdup(argv[i]);
@@ -346,6 +347,7 @@ int cmd_list(int argc, const char **argv)
 			ps.metricgroups = true;
 			metricgroup__print(&print_cb, &ps);
 			free(s);
+			ps.pmu_glob = old_pmu_glob;
 		} else {
 			if (asprintf(&s, "*%s*", argv[i]) < 0) {
 				printf("Critical: Not enough memory! Trying to continue...\n");
