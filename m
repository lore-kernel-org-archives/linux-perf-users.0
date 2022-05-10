Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6855AC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 May 2022 09:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiEJJiv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 May 2022 05:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiEJJip (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 May 2022 05:38:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19A6A28F7FE;
        Tue, 10 May 2022 02:34:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AADEF1042;
        Tue, 10 May 2022 02:34:48 -0700 (PDT)
Received: from [10.57.2.65] (unknown [10.57.2.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D2163F66F;
        Tue, 10 May 2022 02:34:46 -0700 (PDT)
Message-ID: <34e48640-24a1-eaa2-e873-f7137aa47ba3@arm.com>
Date:   Tue, 10 May 2022 10:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/6] perf: arm64: Add SVE vector granule register to
 user regs
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, german.gomez@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org
References: <20220509144257.1623063-1-james.clark@arm.com>
 <20220509144257.1623063-2-james.clark@arm.com>
 <Ynk3vTtJApO13peb@sirena.org.uk>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Ynk3vTtJApO13peb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 09/05/2022 16:48, Mark Brown wrote:
> On Mon, May 09, 2022 at 03:42:49PM +0100, James Clark wrote:
>> Dwarf based unwinding in a function that pushes SVE registers onto
>> the stack requires the unwinder to know the length of the SVE register
>> to calculate the stack offsets correctly. This was added to the Arm
>> specific Dwarf spec as the VG pseudo register[1].
>>
>> Add the vector length at position 46 if it's requested by userspace and
>> SVE is supported. If it's not supported then fail to open the event.
>>
>> The vector length must be on each sample because it can be changed
>> at runtime via a prctl or ptrace call. Also by adding it as a register
>> rather than a separate attribute, minimal changes will be required in an
>> unwinder that already indexes into the register list.
> 
>> +static u64 perf_ext_regs_value(int idx)
>> +{
>> +	switch (idx) {
>> +	case PERF_REG_ARM64_VG:
>> +		if (WARN_ON_ONCE(!system_supports_sve()))
>> +			return 0;
> 
> These WARN_ON_ONCE()s seem a bit loud but I do see they are idiomatic
> for this code so

They should never ever be hit because the mask is validated when opening
the event so hopefully it's not an issue.
 
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks Mark
