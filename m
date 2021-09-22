Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A782CC4167B
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 13:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90535611B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 13:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhIVNmj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 09:42:39 -0400
Received: from foss.arm.com ([217.140.110.172]:49300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233561AbhIVNm0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 09:42:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2B6E11B3;
        Wed, 22 Sep 2021 06:40:56 -0700 (PDT)
Received: from [10.57.50.100] (unknown [10.57.50.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 748C63F7D7;
        Wed, 22 Sep 2021 06:40:55 -0700 (PDT)
Subject: Re: [PATCH 3/3] perf tests: Improve temp file cleanup in
 test_arm_coresight.sh
To:     Leo Yan <leo.yan@linaro.org>
Cc:     acme@kernel.org, leo.yan@linaro.com,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210921131009.390810-1-james.clark@arm.com>
 <20210921131009.390810-3-james.clark@arm.com>
 <20210922110012.GA400258@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <5a1c5eab-d9b7-5623-2d7d-c6b1921b3628@arm.com>
Date:   Wed, 22 Sep 2021 14:40:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922110012.GA400258@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 22/09/2021 12:00, Leo Yan wrote:
> On Tue, Sep 21, 2021 at 02:10:09PM +0100, James Clark wrote:
>> Cleanup perf.data.old files which are also dropped by perf, handle
>> sigint and propagate it to the parent in case the test is run in a bash
>> while loop and don't create the temp files if the test will be skipped.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/tests/shell/test_arm_coresight.sh | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
>> index c9eef0bba6f1..6de53b7ef5ff 100755
>> --- a/tools/perf/tests/shell/test_arm_coresight.sh
>> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
>> @@ -9,8 +9,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  # Leo Yan <leo.yan@linaro.org>, 2020
>>  
>> -perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>> -file=$(mktemp /tmp/temporary_file.XXXXX)
>>  glb_err=0
>>  
>>  skip_if_no_cs_etm_event() {
>> @@ -22,13 +20,20 @@ skip_if_no_cs_etm_event() {
>>  
>>  skip_if_no_cs_etm_event || exit 2
>>  
>> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>> +file=$(mktemp /tmp/temporary_file.XXXXX)
>> +
>>  cleanup_files()
>>  {
>>  	rm -f ${perfdata}
>>  	rm -f ${file}
>> +	rm -f "${perfdata}.old"
>> +	trap - exit term int
>> +	kill -2 $$
> 
> Here it always sends signal SIGINT to current PID with $$, another
> choice is to send signal based on the incoming signal type, like below:
> 
>   [[ "$1" = "int" ]] || kill -SIGINT $$
>   [[ "$1" = "term" ]] || kill -SIGTERM $$

Yes I thought that this might be an issue, but I tested it in a few different
scenarios. Especially when running it under the normal ./perf test command and
it didn't seem to cause an issue whether it passed or failed. So I'm not sure
if it's worth changing or not. Maybe it is in case it gets copy pasted into
another shell test?

James

> 
> If you think the current change is sufficient to meet the testing
> requirement, then this patch would be fine for me either:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
>> +	exit $glb_err
>>  }
>>  
>> -trap cleanup_files exit
>> +trap cleanup_files exit term int
>>  
>>  record_touch_file() {
>>  	echo "Recording trace (only user mode) with path: CPU$2 => $1"
>> -- 
>> 2.28.0
>>
