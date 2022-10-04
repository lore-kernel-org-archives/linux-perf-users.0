Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4C5C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 18:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJDSPm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Oct 2022 14:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJDSPl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Oct 2022 14:15:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BCB1BE9F;
        Tue,  4 Oct 2022 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664907336; x=1696443336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=39KmLyuEODkTtjXEyfleQ8V4mSh9xQFmSG0UMAaQUSo=;
  b=a3BJcxSE381+eL2nMhf79j6lK823RELu9eDbhayaFhMe5yFx//uRaV5N
   7yKqzgA6a7u4MeoSrlmJ7PeIep2J+nflDhgpjKs5+avceyQd8G1SFCmwC
   8wfvJp/UXZQx1EUyfRmhD/S9lQVSZUGwlbyOWPqgIYOoGd2n/pGd6qcDd
   Ws769+kyi5g9MLLmRUlsGWmn0DHz2fjwv3thMSZKhh92IwXkOnwcAkpNZ
   CRk3LnWpGPpBcuHCwMgG2WOtxBYms+iRN0YOza5Q7SPWcxPvYxuvszo67
   rhaCKLESFnNeTf6reMsn4ELZ/Z4w0+kCGlCU2mTwEXJNvAQ0pQVSZJEhK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="329396475"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="329396475"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 11:15:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="869113448"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="869113448"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.241.236.94]) ([10.241.236.94])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 11:15:34 -0700
Message-ID: <5710d85a-e1ab-1533-cda7-185b9234c580@linux.intel.com>
Date:   Tue, 4 Oct 2022 11:15:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 00/23] Improvements to Intel perf metrics
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20221004021612.325521-1-irogers@google.com>
 <CAP-5=fXk6sLhZsEs72G4pOuZNzDJLc2Vkkvf+Jv=LXQDHPy8-w@mail.gmail.com>
 <677c6ec7-2e01-635b-dbfb-fbb9280e5b7c@linux.intel.com>
 <CAP-5=fUFuw-WYj7xVm3WrnggN2NW7pJkznUQ-j3U4fwMB5PdnA@mail.gmail.com>
 <Yzx25psp6o4XDaVs@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <Yzx25psp6o4XDaVs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


>   
>> So I think you've not got Arnaldo's branch with the changes applied.
>> Unfortunately the instructions around '_group' are only going to apply
>> to Linux 6.1.
> I just pushed perf/core with Ian's v3 series, please check with that
> one.


Yes works with the latest branch thanks.


-Andi

