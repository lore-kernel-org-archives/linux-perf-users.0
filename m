Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60757C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F373611C9
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 16:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhIVQv3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:51:29 -0400
Received: from foss.arm.com ([217.140.110.172]:51582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231925AbhIVQv2 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 12:51:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13595113E;
        Wed, 22 Sep 2021 09:49:58 -0700 (PDT)
Received: from [10.57.50.100] (unknown [10.57.50.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C86E83F719;
        Wed, 22 Sep 2021 09:49:56 -0700 (PDT)
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
 <5a1c5eab-d9b7-5623-2d7d-c6b1921b3628@arm.com>
 <20210922140832.GB400258@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <85c593b5-5348-8e9a-b9e4-bc4d31ffc785@arm.com>
Date:   Wed, 22 Sep 2021 17:49:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922140832.GB400258@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 22/09/2021 15:08, Leo Yan wrote:
> Hi James,
> 
> On Wed, Sep 22, 2021 at 02:40:54PM +0100, James Clark wrote:
> 
> [...]
> 
>>>>  cleanup_files()
>>>>  {
>>>>  	rm -f ${perfdata}
>>>>  	rm -f ${file}
>>>> +	rm -f "${perfdata}.old"
>>>> +	trap - exit term int
>>>> +	kill -2 $$
>>>
>>> Here it always sends signal SIGINT to current PID with $$, another
>>> choice is to send signal based on the incoming signal type, like below:
>>>
>>>   [[ "$1" = "int" ]] || kill -SIGINT $$
>>>   [[ "$1" = "term" ]] || kill -SIGTERM $$
>>
>> Yes I thought that this might be an issue, but I tested it in a few different
>> scenarios. Especially when running it under the normal ./perf test command and
>> it didn't seem to cause an issue whether it passed or failed. So I'm not sure
>> if it's worth changing or not. Maybe it is in case it gets copy pasted into
>> another shell test?
> 
> I think it's not very necessary to send signal again with command
> "kill -2 $$" at here.
> 
> "kill -2 $$" sends the signal to the shell process itself rather than
> propagating signal to its parent process.  And the up level's script
> should can detect an error with the returned exit code.
> 
> So below change should be sufficient?
> 
> cleanup_files()
> {
> 	rm -f ${perfdata}
> 	rm -f ${file}
> +       rm -f "${perfdata}.old"
> +       exit $glb_err
> }
> 
> Sorry if I miss anything at here and cause noise.

The problem with not re-sending the sigint is that if you want to run the
script in a bash while loop like:

  while ! tests/shell/test_arm_coresight.sh; do echo loop; done

Then it's impossible to exit with Ctrl-C and delete the temp files at the
same time. It exits if we don't trap sigint like it is at the moment, but
then it leaves the temporary files. This change is so we can have both
behaviours of Ctrl-C in a loop and keep the cleanup working.


> 
> Thanks,
> Leo
> 
