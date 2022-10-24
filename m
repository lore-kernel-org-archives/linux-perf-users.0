Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8EEC38A2D
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 15:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiJXP3v (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 11:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiJXP3e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 11:29:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3881B2CDE4;
        Mon, 24 Oct 2022 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666620978; x=1698156978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X3/yRnGq3LuZ70IQMEINL0knE9wzrPyEZSHDBsDmTRc=;
  b=O/R/MdLcwnBg+tz+cBBPOFp6gc0SiBV1GmIzghiA6T1PQ7E48q4y7VWj
   muDgZHUt9FeAx6tth8Udm8kP9Vsf/LJgJ7ZnkcOHY2kOx9Fu8tN2bsf5K
   hKLQ4SwDc4cNcB9nk+Gp0AJpVPuiqp5BIQqHYF2buYBVbEuSej23bvXOU
   7rkS0ipONqGMGOUyO9W557/y9XVvOwPZgHbeG5SWMdf2wxLswAraxZgY6
   Z5U+S1WUFFhi7fqAyqBtsrf735KO0/z0XTtZIomYNSafwO82rP/AhHxl7
   +VviyNyK6G1MbsLzuJKAByVq7NgABvNAfi1jy4Wp96Aoc/Xuzf4rKpMvA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287139504"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287139504"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 07:00:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="633715546"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="633715546"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.9])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 07:00:20 -0700
Message-ID: <960317d2-1bf8-cc2a-8772-8d0f5a136b6b@intel.com>
Date:   Mon, 24 Oct 2022 17:00:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH 3/8] perf test: Use a test program in perf record tests
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
References: <20221020172643.3458767-1-namhyung@kernel.org>
 <20221020172643.3458767-4-namhyung@kernel.org>
 <CAP-5=fWKCdyFzR8ZZSK_2v6vT_RKngxxnXGieUVb8PBATJ64eQ@mail.gmail.com>
 <Y1Z3/t4RtnB8r03t@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Y1Z3/t4RtnB8r03t@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 24/10/22 14:33, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 20, 2022 at 04:52:14PM -0700, Ian Rogers escreveu:
>> On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
> 
>>> If the system has cc it could build a test program with two threads
>>> and then use it for more detailed testing.  Also it accepts an option
>>> to run a thread forever to ensure multi-thread runs.
>>>
>>> If cc is not found, it falls back to use the default value 'true'.
>>>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>
>> Acked-by: Ian Rogers <irogers@google.com>
>>
>> I wonder if these utilities should just be built into perf to avoid
>> the cc dependency. Perhaps we can have a hidden option built into perf
>> test.
> 
> Agreed, not depending on a compiler makes 'perf test' usable in more
> systems, particularly production ones where we may want to check if perf
> is passing all tests applicable to that system.

I haven't seen anyone package anything except the perf executable, so
I presume the only people running these tests install the source, and
so need a compiler anyway.

