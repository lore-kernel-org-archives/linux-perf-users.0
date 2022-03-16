Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B4FC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Mar 2022 17:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbiCPRkg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Mar 2022 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345918AbiCPRkf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Mar 2022 13:40:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C9726AA48;
        Wed, 16 Mar 2022 10:39:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA351476;
        Wed, 16 Mar 2022 10:39:20 -0700 (PDT)
Received: from [10.57.6.128] (unknown [10.57.6.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C72E3F66F;
        Wed, 16 Mar 2022 10:39:18 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] perf test arm64: Test unwinding using fame-pointer
 (fp) mode
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, namhyung@kernel.org, leo.yan@linaro.org,
        Alexandre.Truong@arm.com, Jiri Olsa <jolsa@kernel.org>,
        acme@kernel.org, linux-perf-users@vger.kernel.org
References: <20220316172015.98000-1-german.gomez@arm.com>
 <592a32d6-b618-951c-9db9-711d022ff85e@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <5ccb6f06-374e-ff02-b062-0479f306f232@arm.com>
Date:   Wed, 16 Mar 2022 17:38:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <592a32d6-b618-951c-9db9-711d022ff85e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 16/03/2022 17:30, James Clark wrote:
>
> On 16/03/2022 17:20, German Gomez wrote:
>> Add a shell script to check that the call-graphs generated using frame
>> pointers (--call-graph fp) are complete and not missing leaf functions:
>>
>>   | $ perf test 88 -v
>>   |  88: Check Arm64 callgraphs are complete in fp mode                  :
>>   | --- start ---
>>   | test child forked, pid 8734
>>   |  + Compiling test program (/tmp/test_program.Cz3yL)...
>>   |  + Recording (PID=8749)...
>>   |  + Stopping perf-record...
>>   | test_program.Cz
>>   |                  728 leaf
>>   |                  753 parent
>>   |                  76c main
>>   | test child finished with 0
>>   | ---- end ----
>>   | Check Arm SPE callgraphs are complete in fp mode: Ok
>>
> Ran it on N1SDP and it passes, and it fails if b9f6fbb3b2c2 isn't applied.
>
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks!
