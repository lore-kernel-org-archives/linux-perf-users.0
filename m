Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95567C001B0
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Aug 2023 14:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHGOyz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHGOyy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2023 10:54:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291F0107;
        Mon,  7 Aug 2023 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420094; x=1722956094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BdAcThl5yIUwfNNvFSUWR4vsRYU002qXlLYHAIqkQ10=;
  b=Y3dUPmkNJMdY4MYcLgMkSb3fzKTUSxiz96V2w3FCDaf9Smx5hJzK+PGX
   LMcdV/yd7UpUHKgZf5cMH62hs1OzjjvOMx7uSTKewk0pyhk4lPsi7c/DS
   t/YoNMjSdLb7iNKnkcFg/B/M3XPEPIXFW+DhOnjqVlE0FphhKn7MYweBO
   7wWb/17L9ZMPnxEunHOT7+n8cJxm03f2pzh/e0XldxMca9US2CxOVr09b
   YMFA1bcjVQwGFpryAxlK9NbU6GUZfSFtqCc2tLDgLCAngEYqyvSUOaz0Q
   wJvAtF70M8lSl3sMUt3zN0OyiQt1QZoSIclC8s4DRgRQkVu8xDCqy4elE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401537300"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="401537300"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="904790742"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="904790742"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:54:52 -0700
Date:   Mon, 7 Aug 2023 07:54:47 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <ZNEFt3w/wNCvdawF@tassilo>
References: <20230801205452.3380578-1-irogers@google.com>
 <ZMwUI/YtEHsO3Cc8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMwUI/YtEHsO3Cc8@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 03, 2023 at 05:54:59PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 01, 2023 at 01:54:52PM -0700, Ian Rogers escreveu:
> > Skip zero counts for tool events.
> > 
> > Reported-by: Andi Kleen <ak@linux.intel.com>
> 
> Andi,
> 
> 	Have you tested this? Can we please have your Tested-by?

I thought I had sent it earlier?

Tested-by: Andi Kleen <ak@linux.intel.com>
