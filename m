Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4C1EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 08:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGCISb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGCISa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 04:18:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96F60C5
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 01:18:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C629F1FB;
        Mon,  3 Jul 2023 01:19:11 -0700 (PDT)
Received: from [10.57.38.97] (unknown [10.57.38.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5783F73F;
        Mon,  3 Jul 2023 01:18:28 -0700 (PDT)
Message-ID: <cf180f9a-085b-ad9b-c477-f02d32559c0a@arm.com>
Date:   Mon, 3 Jul 2023 09:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Some questions about using the perf tool in ARM-SPE
To:     Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?B?6JSh5rKF5L+h?= <fissure2010@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org
References: <CALDTKqiVNLHM8b21T-zikuNvhfE0N_-kEinpZGSRjSO-04R96w@mail.gmail.com>
 <874963e2-f97e-b463-1351-b00640b0f67b@arm.com>
 <CALDTKqg01+xJ2xu218c_QH2PbX9wdhYOiJfDieCXL5PHWV-6FQ@mail.gmail.com>
 <77773641-26e5-a754-63cf-e7d3443e11fc@arm.com>
 <CALDTKqgek3Bicxkvnq3BQnSaS2keQG6UK8S6_0oJn26r0D00MA@mail.gmail.com>
 <20230614012102.GJ217089@leoy-huanghe.lan>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230614012102.GJ217089@leoy-huanghe.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo
On 14/06/2023 02:21, Leo Yan wrote:
> Hi,
> 
> On Tue, Jun 13, 2023 at 09:23:33PM +0800, 蔡沅信 wrote:
>> OK
>> I have a new discovery that c2c seems to support only certain Arm
>> Neoverse (N1/N2/V1) CPUs, I wonder if cortex-X4 could support it?
> 
> Based on Cortex-X4 TRM [1], we can see Cortex-X4 has the same SPE data
> source packet format with Neoverse CPUs.  In theory, we can add
> Cortex-X4's MIDR into the neoverse_spe[] array in
> tools/perf/util/arm-spe.c to support Cortex-X4.
> 
> Linux master branch misses the definition for Cortex-X4's MIDR [2],
> Mark.R / Suzuki / James, could you confirm if Arm has plan or already
> has patches for enabling Cortex-X4's MIDR?
> 

Is there a particular reason why need this in the kernel ? Usual
policy is, kernel needs to distinguish an MIDR, only if it ever
needs to. e.g, a CPU erratum specific to the MIDR.

Suzuki

