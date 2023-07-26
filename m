Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD83C0015E
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Jul 2023 15:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjGZPIJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Jul 2023 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjGZPID (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Jul 2023 11:08:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0F2D5A
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jul 2023 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690384058; x=1721920058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=II/s8rkvCLJCb6Ut9xtsz/m47c0HcqLmfjOTkbQk31Y=;
  b=jhLy64Dibuqqxib+RNozu6AdRdJgfNqkf6I30ABBgV+Ptft8q7cvFJtW
   OjpHaHQPys+euL5//k6YGkw64NxDCa0LV15o89gp8PEJ6AwZsEJaSjlkA
   Kv1E0LT7/bONGCMnt/zGvu1/K8n8/oqGQnCCEP0X/dWlXXDlOB0/Sy+oh
   GCvo63xkexYkYZj/hPXS+fpesGVnrKwY7flLCCCSl44H4XVtCcbMlFVen
   7l6iNq2vSJn+/Szip4OFJVWFf088SuAux0kDH9jdIdCB0nzlss8iwOh1U
   soIILTjWDLXBuNRx5z14C6v+Q4qboE0+I/FxMrYiG77AkaBLzdpl1Ygp9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="366920953"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="366920953"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 08:05:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="676745510"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="676745510"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 08:05:47 -0700
Date:   Wed, 26 Jul 2023 08:05:46 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: Event reordering regression for software events
Message-ID: <ZME2SpcW945IqhcN@tassilo>
References: <ZLBgbHkbrfGygM/u@tassilo>
 <ZLBjI4a3wIMs75lA@kernel.org>
 <CAP-5=fU5Y95G2FsFdwxwPk=kLe=kka7CkD7ZDrzSU+Xv-Ks=Qg@mail.gmail.com>
 <ZLCOEOtJOQiN+8VB@tassilo>
 <CAP-5=fWjDeXZfgLu8hiavtkRGmWsZnwt3g+Ms5YPL12PxUaCgg@mail.gmail.com>
 <ZLC8AIEfUJMQFOEn@tassilo>
 <CAP-5=fVWyrmRHCmNGRrME-YSSwbJV90-_dcC=LyNAXjk9baMGA@mail.gmail.com>
 <ZLSgzJsom0avu/hX@tassilo>
 <ZLVEHz0uzq79eto5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLVEHz0uzq79eto5@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

<sorry for the late reply I was on vacation>

On Mon, Jul 17, 2023 at 10:37:35AM -0300, Arnaldo Carvalho de Melo wrote:
> Don't we have a JSON output? My expectation is that after the work that
> Ian has been doing we will settle down, but even then downstreamers
> should try to use JSON as input as that would avoid the problems we are
> having?


In classic perf CSV was our machine readable output, and that is what got broken
here. I hope nobody is advocating for abolishing CSV output as a machine
readable format.

For JSON it got broken too because of:

> > I haven't tried to use it, but if you have something like
> > perf stat --json -e '{cycles,branches},{cycles,cache-misses}' how would you
> > distinguish it without order?

> 
> You mentioned that it was difficult to add entries to 'perf test' but

I can add some tests for basic reordering not occurring. That should
be possible.

> that we could try running toplev's regression test, right? I can add it
> to my set of tests but perhaps the best thing would be to wire it up to
> one of the CIs out there?

Yes that would be a good idea. Note that there are sometimes problems
which are on the toplev side, not perf side, but I guess can sort that
out when that happens.


-And
