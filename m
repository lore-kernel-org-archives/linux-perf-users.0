Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711C9C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Mar 2022 15:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbiCWPc6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Mar 2022 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239379AbiCWPcu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Mar 2022 11:32:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3832370F70
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2022 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648049480; x=1679585480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JCWm83l19Ak5HA28nUd8Te3II7s71v8Me0w7zlHNkzo=;
  b=hEQhf41HGYMjWq33GHMA27UfIsPmimkljlMTWJpLS1Qcg/B+KT3Bfaem
   4J5n9Ksakfj0Fbn4+PSvCO66vjSmIM4bXr/cbcXVWe+ngWaur43A4X/uP
   kvEreuN1QpXJCth/qeWgMOZl9gmBaS2NwCGfv71WW1wnhPu9wTZqWDuso
   cwLBPlzjNks2quRpl9qERAs/niwdJaRZJdjLRP853zaHNi+FUrh4mGZo7
   dGNH7vJfFeEtxwzA/wrE69mXi4GC20zqqSlMT80tWepzK/9aKf5EvkLb6
   sWCD0SkynA5atc++gqD9aXatSHO+/G9woYXqB50y6ZFbNxNphXxSGmBjZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258090025"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="258090025"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 08:30:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="544235245"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.33.120])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 08:30:57 -0700
Message-ID: <2febdfab-2b83-515a-ef73-0415c72a6fad@intel.com>
Date:   Wed, 23 Mar 2022 17:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: perf record crash with Intel PT
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Stephane Eranian <eranian@google.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <CABPqkBSKMU-r+AbYvZ9e17nZ70idCyxBQ4sUhKzhkTn-1JaTDA@mail.gmail.com>
 <CA+JHD90unShQ2pvEFRyr2FKD2+tDchrtBQHtZq+LEJxKQjLJ_Q@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+JHD90unShQ2pvEFRyr2FKD2+tDchrtBQHtZq+LEJxKQjLJ_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 23.3.2022 15.58, Arnaldo Carvalho de Melo wrote:
>> On Wed, Mar 23, 2022, 2:06 AM Stephane Eranian <eranian@google.com <mailto:eranian@google.com>> wrote:
>> 
>>     Hi,
>> 
>>     I was trying some simple command lines with perf record from tip.git tree
>>     and Intel PT and to my surprised I got an immediate crash with cmdline such as :
>> 
>>     $ perf record -e intel_pt// -a -C 1 sleep 5
>> 
>>     As soon as you specify -C you get a crash in:
>> 
> 
> 
> I'll check that, but can you please try removing -a?

Happens as far back as v5.9, also without -a

Most likely the addition of "text poke" support because it is
always system-wide, and probably breaks the indexing by cpu.

There is another issue though.  Even for a single CPU, side-band
should really be collected on all CPUs (like it is for text poke).
