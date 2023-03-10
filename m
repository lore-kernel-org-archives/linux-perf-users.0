Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E0C64EC4
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Mar 2023 14:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjCJOV0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Mar 2023 09:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjCJOU4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Mar 2023 09:20:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745AB11BB2A
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 06:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678457981; x=1709993981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dslIk3BBHKwsSybg8vbqYVfdRVYr+82nX52/098xeZo=;
  b=mxsbZRO68gbZG5fTBF3Jzt4r3bH27Y5v/tOTtCYFqgkzHtkKdbRzQLO8
   fkC/TIgZ04aGAk8Pekc5Ss3+cSMWDGJaxfWEqpLsCjjiTfCMd038bimyA
   7IqfSDp/FGDBLOZRezLBdJYYWBfrtQ4SLzaI6+WNNw5lzcq/P6BuIq+y0
   /oQ00uvAAr0KIZHdqgOo2v79K7HdSWyocmH9B/YhabLUtY653c/QkTH8g
   U3jMVhCdbCV/VihGh+Zso5E+n3XcmyjLcxuVLbIyxggu1WjFcAllU0lRs
   cX1trFa1HjUNpx1+sEF1yixSA7A6QeLl9SKgCJsqjkF1JdcvGWqlxaDjC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="401595040"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="401595040"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 06:19:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="821061820"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="821061820"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 06:19:19 -0800
Message-ID: <db6b4693-3f71-00aa-4dd7-00700fc50668@intel.com>
Date:   Fri, 10 Mar 2023 16:19:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] fix IPC output in perf intel-pt-events script
Content-Language: en-US
To:     Roman Lozko <lozko.roma@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
References: <20230310111001.2836295-1-lozko.roma@gmail.com>
 <01f16399-f600-2b45-766f-0b5e5f868345@intel.com>
 <CAEhC_B=hB+bmozvxk-5sGDfw3mJ5Xt6hd0bUm-L1Dt373Z3Uow@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAEhC_B=hB+bmozvxk-5sGDfw3mJ5Xt6hd0bUm-L1Dt373Z3Uow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/03/23 16:02, Roman Lozko wrote:
> On Fri, Mar 10, 2023 at 3:32 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Thanks for finding this.  Obviously Python 3 is preferred nowadays
>> but Python 2 seems to be still a thing.
>>
>> AFAICT, it would be better to fix this by adding:
>>
>> from __future__ import division
>>
>> at the top of the script, next to from __future__ import print_function
> 
> Is it possible to build perf with python3? May it be better to stop
> supporting Python 2?

PYTHON=python3 make -C tools/perf install

For more information refer:

https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace#Downloading_and_building_the_latest_perf_tools

> 
>> Also the patch subject should be:
>>
>> perf scripts: intel-pt-events.py: Fix IPC output for Python 2
>>
>> Also a Fixes tag could be added i.e.
>>
>> Fixes: a483e64c0b62 ("perf scripting python: intel-pt-events.py: Add --insn-trace and --src-trace")
> 
> Thanks for details, this is my first patch, I knew I would miss something :)

