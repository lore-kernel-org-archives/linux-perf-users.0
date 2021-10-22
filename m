Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE93FC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 12:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B137B6120D
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 12:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhJVM0P (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Oct 2021 08:26:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:59430 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhJVM0O (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Oct 2021 08:26:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315496042"
X-IronPort-AV: E=Sophos;i="5.87,172,1631602800"; 
   d="scan'208";a="315496042"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 05:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,172,1631602800"; 
   d="scan'208";a="484664022"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 22 Oct 2021 05:23:54 -0700
Subject: Re: [RFC] Support Intel-PT code build in 32-bit arches
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, mingo@redhat.com,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Clark <James.Clark@arm.com>
References: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
 <YXAoOgRVfkzr5vcS@kernel.org>
 <744e6d05-eaec-49d9-1e3d-2f96d4e01e1a@huawei.com>
 <YXBRF0vM8sEwherG@kernel.org> <YXHOBXiIXP9b3xps@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <becd9eb5-53d1-bde4-14a6-4ac2bb955508@intel.com>
Date:   Fri, 22 Oct 2021 15:23:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXHOBXiIXP9b3xps@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 21/10/2021 23:31, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 20, 2021 at 02:25:43PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Oct 20, 2021 at 03:41:01PM +0100, John Garry escreveu:
>>> I suppose the best thing now is to send a patch on top once perf/core
>>> contains that commit. Let me know otherwise.
>  
>> You can send a v2, as:
>  
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
> Adrian,
> 
> 	Probably we should just disable Intel PT support from being
> built on 32-bit arches, right? I don't know if anybody is interested on
> that, my tests just try to figure out if it continues to build, and if
> fixing any problem isn't costly, which in this case is more than my
> threshold, wdyt?

It feels like bad form not to compile on 32-bit.

In this case we could just cast it, and I see that has been done
in other places for for_each_set_bit(), but (and maybe I've got
it wrong) that wouldn't work for a 32-bit big endian system?

The following might cover all cases, do you think?

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 1073c56a512c..7c979ffefade 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2129,9 +2129,17 @@ static int intel_pt_synth_single_pebs_sample(struct intel_pt_queue *ptq)
 	return intel_pt_do_synth_pebs_sample(ptq, evsel, id);
 }
 
+/* For 32-bit big endian, put the longs from u64 in correct order */
+#define U64_BITS(var, val)		\
+	unsigned long var[] = {		\
+		[0] = (val),		\
+		[1] = (val) >> 32,	\
+	}
+
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
+	U64_BITS(ac_bits, items->applicable_counters);
 	struct intel_pt_pebs_event *pe;
 	struct intel_pt *pt = ptq->pt;
 	int err = -EINVAL;
@@ -2143,7 +2151,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 		return intel_pt_synth_single_pebs_sample(ptq);
 	}
 
-	for_each_set_bit(hw_id, &items->applicable_counters, INTEL_PT_MAX_PEBS) {
+	for_each_set_bit(hw_id, ac_bits,  INTEL_PT_MAX_PEBS) {
 		pe = &ptq->pebs[hw_id];
 		if (!pe->evsel) {
 			if (!pt->single_pebs)

