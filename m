Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C403C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 15:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8443B60F9F
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 15:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhJSPT1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232764AbhJSPTZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 11:19:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA79160FE8;
        Tue, 19 Oct 2021 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656633;
        bh=Jghv2qiCrh2T7drOu62Q4awOcshsMbwP6PP7jKtWi1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bt6/2z+zIvp3TGsSWODu3BRbZl/jMTKSeavPb3jIviUjQZxXnA1qxzkmSohvP51+5
         kItHqxMjndylgZGkBFyz6PxLCVy+00T0kQ1gt8I/ZuICj9C/g4F8YdyLBv+Zl7WyIa
         I9i7QPu7PoHTDDM6efQupm1mui2UgNwlRBammTMeOUYOHivQCGcXw0E7N1Qf6pVACs
         u0wUpLqodUtFSjx7E3mgpIambACpOFtnO1DUhx2GTDIeRaM67EnabjZWJhNOxLSXBP
         tgebH79ygtLLPKKpU0K2TJ/pjKELGxV4iE2UYf76fKcSxfJ/IeRj8CGXVT91j9nXdB
         +ar7TEdcKN+1g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38F12410A1; Tue, 19 Oct 2021 12:17:10 -0300 (-03)
Date:   Tue, 19 Oct 2021 12:17:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 21/21] perf metric: Allow modifiers on metrics.
Message-ID: <YW7hdvJ8eHS/jlgx@kernel.org>
References: <20211015172132.1162559-1-irogers@google.com>
 <20211015172132.1162559-22-irogers@google.com>
 <YW7e6OvE/juYY8it@kernel.org>
 <YW7gsEDXBw1jk65o@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YW7gsEDXBw1jk65o@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Oct 19, 2021 at 12:13:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Oct 19, 2021 at 12:06:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Oct 15, 2021 at 10:21:32AM -0700, Ian Rogers escreveu:
> > > By allowing modifiers on metrics we can, for example, gather the
> > > same metric for kernel and user mode. On a SkylakeX with
> > > TopDownL1 this gives:
> > > 
> > > $ perf stat -M TopDownL1:u,TopDownL1:k -a sleep 2
> > > 
> > >  Performance counter stats for 'system wide':
> > 
> > Hi Ian, can you please take a look on this? this is on my perf/core
> > branch.
> 
> I processed the first version of this series, reviewed by Andi, can you
> please submit the diff from one to the other?

The interdiff from the 21st patch on the first batch versus on the v2
batch is below, but it doesn't apply to my current perf/core branch,
lemme push it to tmp.perf/core...

- Arnaldo

⬢[acme@toolbox perf]$ interdiff ~/wb/old.patch ~/wb/new.patch
diff -u b/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
--- b/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1308,8 +1308,7 @@
 	int ret;

 	*out_evlist = NULL;
-	ret = metricgroup__build_event_string(&events, ids, modifier,
-					      has_constraint);
+	ret = metricgroup__build_event_string(&events, ids, has_constraint);
 	if (ret)
 		return ret;

@@ -1324,7 +1323,8 @@

 		ids__insert(ids->ids, tmp);
 	}
-	ret = metricgroup__build_event_string(&events, ids, has_constraint);
+	ret = metricgroup__build_event_string(&events, ids, modifier,
+					      has_constraint);
 	if (ret)
 		return ret;

@@ -1568,7 +1568,10 @@
 				return -ENOMEM;

 			new_expr->metric_expr = old_expr->metric_expr;
-			new_expr->metric_name = old_expr->metric_name;
+			new_expr->metric_name = strdup(old_expr->metric_name);
+			if (!new_expr->metric_name)
+				return -ENOMEM;
+
 			new_expr->metric_unit = old_expr->metric_unit;
 			new_expr->runtime = old_expr->runtime;

⬢[acme@toolbox perf]$
