Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5B8C0015E
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 23:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGMXzP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 19:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGMXzO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 19:55:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184D2D48
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689292510; x=1720828510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4o8lBKyp1oyuJzpWi+GpsOMuxQzYFerPJGCAKRWJhp8=;
  b=hgleD1kjX9QgXsLQ/kdDev1JIORl05R8fFQlRKJajWVzmRcU75MBx2Qz
   le8W7T2MTeiW1U2jk40O0FlWjF3Yy0Y3JO8spG7o2KRv5//puhIZjkuyb
   d8XOdO6CoVfuSAyEmeXUvY8vODbR7RRtLm0M5wo4OyEvgzOS37XKgaRK3
   xTD0rqsNgSt4rd15wGpqqjLWst40mSRRbcmvdPOiJo6uNd7sEa5BfRHWu
   Y3/wMpzw1SwuAYSPp7EsUezgM9XS7ND9gcB7C0PsXXcAk/+HDGznHQIAf
   DX+UpGCN+SimPwOkb695ORi/TqPXs6exMyFfsgBBnTnejsvefI8wOug5H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429108143"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="429108143"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="835809033"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="835809033"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:55:09 -0700
Date:   Thu, 13 Jul 2023 16:55:07 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: Event reordering regression for software events
Message-ID: <ZLCO27OKNPdp6xXV@tassilo>
References: <ZLBgbHkbrfGygM/u@tassilo>
 <ZLBjI4a3wIMs75lA@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLBjI4a3wIMs75lA@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> It would really be great to have new entries that exercise what is
> expected by toplev so that we really are careful with compatibility.

It is unfortunately difficult to do, see my reply to Ian.

But if you have automated checking tests perhays you could run my test suite too?

git clone https://github.com/andikleen/pmu-tools
cd pmu-tools
PERF=/new/perf ./tl-tester 

-Andi
