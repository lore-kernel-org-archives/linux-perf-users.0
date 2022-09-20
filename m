Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C1FC6FA8B
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Sep 2022 10:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiITK3D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Sep 2022 06:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiITK3C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Sep 2022 06:29:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ED0F7198B;
        Tue, 20 Sep 2022 03:29:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90CFB23A;
        Tue, 20 Sep 2022 03:29:07 -0700 (PDT)
Received: from [10.1.26.30] (e121896.cambridge.arm.com [10.1.26.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B2353F73B;
        Tue, 20 Sep 2022 03:28:58 -0700 (PDT)
Message-ID: <0dd10e45-d797-f6a8-59a6-cdbebb5d825a@arm.com>
Date:   Tue, 20 Sep 2022 11:28:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] arm64/sve: Add Perf extensions documentation
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        leo.yan@linaro.org, john.garry@huawei.com, catalin.marinas@arm.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220901132658.1024635-1-james.clark@arm.com>
 <20220901132658.1024635-3-james.clark@arm.com>
 <YxC0r6RCffBXXllT@sirena.org.uk>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <YxC0r6RCffBXXllT@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 01/09/2022 14:33, Mark Brown wrote:
> On Thu, Sep 01, 2022 at 02:26:58PM +0100, James Clark wrote:
> 
>> Document that the VG register is available in Perf samples
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Hi Will/Mark R,

Is this set ok to go into 6.1?

Thanks
James
