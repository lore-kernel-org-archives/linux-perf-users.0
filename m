Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28FCC001DF
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Aug 2023 20:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjHCUjB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Aug 2023 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHCUjA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Aug 2023 16:39:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D44830EA;
        Thu,  3 Aug 2023 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691095139; x=1722631139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ui8pT4QSnRjdR3WIhyY0tRtBQtjeMD2JTUos/SzfUik=;
  b=APLlFhxEc9jim+fFeg+3ggbjyWonJOkuceEkF9KNyYmHUOA6CeSk5LY9
   x+YnFroXIhTL5x8yb/0gy5KDn1tYnG2ATt3DEq3ksUUTCWj/502Y1d026
   UQ2F3SOfACRHSNwmfm/A/r4nA3FrXzLY5OXxYd/H7DO/wVO4qU+/4AlY6
   C+MGXtzGbsC284dJh72U3w42K0xgK7fhtUBzBv+RUYpWoQ73gLpi2JEhy
   dHBEyjA0d3mK3UFpYN+w11Mb48cpG6lHn97ukjShOwes1D70FPzd0ldC2
   zl86gNibYu9yctKy4r3VUvhYd9kAewGbU4nupprVmyakbuYR876mGt3EY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="368891931"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="368891931"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 13:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="819818851"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="819818851"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 13:38:58 -0700
Date:   Thu, 3 Aug 2023 13:38:57 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Don't display zero tool counts
Message-ID: <ZMwQYTJeJ5cNfORr@tassilo>
References: <20230801205452.3380578-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801205452.3380578-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 01, 2023 at 01:54:52PM -0700, Ian Rogers wrote:
> Skip zero counts for tool events.
> 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Andi Kleen <ak@linux.intel.com>
