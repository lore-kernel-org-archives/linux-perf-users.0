Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F80C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 05:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661366058D
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Oct 2021 05:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhJZFos (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:44:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:32225 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231394AbhJZFoq (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Oct 2021 01:44:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="229687280"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="229687280"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 22:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="596776976"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2021 22:42:15 -0700
Subject: Re: [PATCH: Fix for_each_set_bit(u64) build on 32-bit arches, was
 perf intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, mingo@redhat.com,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YXbg2vbY71qGdsYq@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a8b64cea-755c-13ee-b923-4d1c521f6068@intel.com>
Date:   Tue, 26 Oct 2021 08:42:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXbg2vbY71qGdsYq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 25/10/2021 19:52, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 20, 2021 at 02:25:43PM -0300, Arnaldo Carvalho de Melo escreveu:
>>   29     8.60 debian:experimental-x-mipsel  : FAIL gcc version 11.2.0 (Debian 11.2.0-9)
>>     util/intel-pt.c: In function 'intel_pt_synth_pebs_sample':
>>     util/intel-pt.c:2146:33: error: passing argument 1 of 'find_first_bit' from incompatible pointer type [-Werror=incompatible-pointer-types]
>>      2146 |         for_each_set_bit(hw_id, &items->applicable_counters, INTEL_PT_MAX_PEBS) {
>>     /git/perf-5.15.0-rc4/tools/include/linux/bitops.h:37:38: note: in definition of macro 'for_each_set_bit'
>>        37 |         for ((bit) = find_first_bit((addr), (size));            \
>>           |                                      ^~~~
>>     In file included from /git/perf-5.15.0-rc4/tools/include/asm-generic/bitops.h:21,
>>                      from /git/perf-5.15.0-rc4/tools/include/linux/bitops.h:34,
>>                      from /git/perf-5.15.0-rc4/tools/include/linux/bitmap.h:6,
>>                      from util/header.h:10,
>>                      from util/session.h:7,
>>                      from util/intel-pt.c:16:
>>     /git/perf-5.15.0-rc4/tools/include/asm-generic/bitops/find.h:109:51: note: expected 'const long unsigned int *' but argument is of type 'const uint64_t *' {aka 'const long long unsigned int *'}
>>
>>  Adrian, this is on:
>>
>>  commit 803a3c9233990e1adac8ea2421e3759c2d380cf8
>> Author: Adrian Hunter <adrian.hunter@intel.com>
>> Date:   Tue Sep 7 19:39:03 2021 +0300
>>
>>     perf intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
>>
>>     Originally, software only supported redirecting at most one PEBS event to
>>     Intel PT (PEBS-via-PT) because it was not able to differentiate one event
>>     from another. To overcome that, add support for the
>>     PERF_RECORD_AUX_OUTPUT_HW_ID side-band event.
>>
>>     Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>     Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>
>>
>> That is still just on tmp.perf/core, so we can fix it, probably its just
>> making that uint64_t into a unsigned long, will check later if you don't
>> beat me to it.
> 
> Do as other code in perf does, e.g.  arch/x86/events/intel/ds.c, dealing
> with PEBS.
> 
> I'm adding this to that patch to fix the build on 32-bit.
> 
> - Arnaldo
> 
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 1073c56a512cdc6e..c9542fada8fb6f9b 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2143,7 +2143,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>  		return intel_pt_synth_single_pebs_sample(ptq);
>  	}
>  
> -	for_each_set_bit(hw_id, &items->applicable_counters, INTEL_PT_MAX_PEBS) {
> +	for_each_set_bit(hw_id, (unsigned long *)&items->applicable_counters, INTEL_PT_MAX_PEBS) {
>  		pe = &ptq->pebs[hw_id];
>  		if (!pe->evsel) {
>  			if (!pt->single_pebs)
> 

That is fine. Thank you!

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

