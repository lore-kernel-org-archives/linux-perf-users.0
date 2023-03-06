Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBFDC678D4
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Mar 2023 06:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCFGyn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Mar 2023 01:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFGym (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Mar 2023 01:54:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD3093C9
        for <linux-perf-users@vger.kernel.org>; Sun,  5 Mar 2023 22:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678085680; x=1709621680;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=mJJya7SIAzAlCuAvpaKizpxbQ+o+i8w0w7p4mZVk4wE=;
  b=YLQeVGDEKTBbKp7ZhPYEfMfRqvMU3XUJd9flpjaXaH2+7hY3polUFme4
   p8PG6J7Ff3VBapJl2Gwq6kG0YcWd0zJadFc9C8mWRaJhy6aA6N85aEj6N
   mX+zTJAq20GN4BKM89TmvojOryLhxp1IgxuHTuEVUR94pUOu6HWnKID2R
   sPkXzt47FV6KyqmTSioznz0gkwPCyx0jxDSuTS5LpYxmMTEc40uDwLbp9
   xb8M42GMjv5Icp7YDgXNVh2MJha7zVHYlc1j9zhbUGkgU/s5f6EcfN0WR
   aBC7vOcvPDPDSbQxQsVyMLsINh+wBMPULglAL+AnIxm1cEh6ea83TOeqU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="421760758"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="421760758"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 22:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="626059260"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="626059260"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.82])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 22:54:38 -0800
Message-ID: <a1b7c912-1554-a623-6799-32dbd0ead4de@intel.com>
Date:   Mon, 6 Mar 2023 08:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: brstack information with perf-intel-pt?
To:     Iti Shree <itishree1999@gmail.com>,
        linux-perf-users@vger.kernel.org
References: <CAO3P5YQ-BU+fmhQo98SAKdc96qMEsim4nNvMRiBmsW0YSUYjQg@mail.gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAO3P5YQ-BU+fmhQo98SAKdc96qMEsim4nNvMRiBmsW0YSUYjQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 13/02/23 20:33, Iti Shree wrote:
> Hello,
> I am trying to get brstack information in perf.data with intel-pt
> flag. I am passing following command for the following: perf record -e
> intel-pt// -m, 32768
> 
> When I try to check if brstack is present in the gathered data with :
> perf script -F pid, ip, brstack -i pt-perf.data I can only see pid and
> ip information.
> 
> I can seem to find branching information with --itrace=b however I was
> wondering if there is any way I can get brstack information decoded
> into perf.data when I use intel-pt flag similar to what I get with
> default perf record?

You need to use --itrace=li which will synthesize "instructions" events
and add a branch stack.  Note that the period of the instructions events
can be defined e.g. --itrace=li10us for 10 microseconds.  And also the
max size of the branch stack e.g. --itrace=l10i for 10 branches.

Typically you need to be aware of decoding errors also, so also add
the 'e' option i.e. --itrace=el10i10us.  There is also 'L' which adds
the branch stack to non-synthesized events (that you may have added
with the -e option).

Some more information about --itrace for Intel PT is here:

https://perf.wiki.kernel.org/index.php/Latest_Manual_Page_of_perf-intel-pt.1#New_--itrace_option

General information and examples for about Intel PT can be found here:

https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace


