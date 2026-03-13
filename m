Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFDA390993
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414810; cv=none; b=RCpxDfJ3piHLDUp53q5tpVhLwebEU1wDXGxQe6MwINvoP1lby8QY3Niei8Bsv3BNbQRMIfZjRUvaHmwAKBicRRrPzAolbG8u9Voi0p2KG0iCJ7dR3m7d7ocplycN792uHf69N5M7LwVuWvBCADuT1DUZtTVJlScn/LftOy3iH5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414810; c=relaxed/simple;
	bh=WlovJ7EvHZMZ7do67M/nx5DuFSTm/dh3Yqx9Th+WY5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGtBb5u5+X51NLSAUbogwXJqWgqcRlXJLKDUlKkJRhLqgvfYYrB9papbsSC4dav7QGJJ/WGKJlqPi4Zhd+UIe9dgpvsWSAOH0Vn+Js7Kv76c0bFCxphdaoLCoAqdT6G9yKJucK6InwH3cbRNxlQxvyAlhdyLnW+bJobUztOuB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C1FA165C;
	Fri, 13 Mar 2026 08:13:22 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4513E3F73B;
	Fri, 13 Mar 2026 08:13:28 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:13:26 +0000
From: Leo Yan <leo.yan@arm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Jan Polensky <japo@linux.ibm.com>
Subject: Re: perf stat issue with 7.0.0rc3
Message-ID: <20260313151326.GO4153946@e132581.arm.com>
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>

On Fri, Mar 13, 2026 at 02:13:18PM +0100, Thomas Richter wrote:
> Ian, 
> 
> I just discovered a strange behavior on linux 7.0.0rc3.
> 
> I run these commands on my x86 virtual machine:
> 
> bash-5.3# uname -m
> x86_64
> bash-5.3# perf -v
> perf version 6.18.13-200.fc43.x86_64
> bash-5.3# perf stat -- true
> 
>  Performance counter stats for 'true':
> 
>          1.108.929      task-clock                       #    0,437 CPUs utilized             
>                  0      context-switches                 #    0,000 /sec                      
>                  0      cpu-migrations                   #    0,000 /sec                      
>                 55      page-faults                      #   49,597 K/sec                     
>    <not supported>      cycles                                                                
> 
>        0,002536439 seconds time elapsed
> 
>        0,001363000 seconds user
>        0,001393000 seconds sys
> 
> bash-5.3#
> 
> This is the epected output, however when I use the perf version 7.0.0rc3:
> 
> bash-5.3# ./perf -v
> perf version 7.0.rc3.g1f318b96cc84
> bash-5.3# ./perf stat -- true
> Error:
> No supported events found.
> trace.args_alignment
> bash-5.3# 
> 
> Same happens on my s390 systems (LPAR and z/VM).
> Is this a known already?

I assume you are missing the patch below.  It has been picked to
perf-tools-next but not landed to mainline.

Author: Ian Rogers <irogers@google.com>
Date:   Fri Feb 6 16:49:56 2026 -0800

    perf metricgroup: Fix metricgroup__has_metric_or_groups

    Use metricgroup__for_each_metric rather than
    pmu_metrics_table__for_each_metric that combines the default metric
    table with, a potentially empty, CPUID table.

    Fixes: cee275edcdb1 ("perf metricgroup: Don't early exit if no CPUID table exists")
    Signed-off-by: Ian Rogers <irogers@google.com>
    Reviewed-by: Leo Yan <leo.yan@arm.com>
    Tested-by: Leo Yan <leo.yan@arm.com>
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 46bf4dfeebc8..7e39d469111b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1605,9 +1605,9 @@ bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_gr
                .metric_or_groups = metric_or_groups,
        };

-       return pmu_metrics_table__for_each_metric(table,
-                                                 metricgroup__has_metric_or_groups_callback,
-                                                 &data)
+       return metricgroup__for_each_metric(table,
+                                           metricgroup__has_metric_or_groups_callback,
+                                           &data)
                ? true : false;
 }
