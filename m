Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE8EC4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Nov 2022 12:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKYMBx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Nov 2022 07:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKYMBw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Nov 2022 07:01:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40FC62FC1A
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Nov 2022 04:01:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EA452B;
        Fri, 25 Nov 2022 04:01:57 -0800 (PST)
Received: from [10.57.5.149] (unknown [10.57.5.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F6A83F73D;
        Fri, 25 Nov 2022 04:01:50 -0800 (PST)
Message-ID: <ecfae192-95fd-0814-1896-d60e9d44417a@arm.com>
Date:   Fri, 25 Nov 2022 12:01:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Available Arm CPUs with SPE
Content-Language: en-US
To:     Marc Jorda <marc.jorda@bsc.es>
References: <2695ecbe-816e-eab7-8da2-30e0f62ae926@bsc.es>
From:   James Clark <james.clark@arm.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
In-Reply-To: <2695ecbe-816e-eab7-8da2-30e0f62ae926@bsc.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 25/11/2022 11:17, Marc Jorda wrote:
> Hello,
> 
> I am trying to know which currently available Arm CPUs implement the
> Statistical Profiling Extension (SPE), does anyone know where can I find
> such information?

Hi Marc,

Graviton 2s on AWS should have it and N1SDP has it. You will need a
metal instance at the moment so that rules out Graviton 3.

Make sure you read the kernel requirements section here [1]

> 
> As far as I know, it is an optional extension in Armv8.2, but I don't
> know if it is mandatory for newer versions. Is it correct to assume that
> all Arm Neoverse CPUs have this extension?

I'm not sure about this, as you say it's optional, but whether all
current Neoverse CPUs have it or not I don't know.

I found this here [2] if it helps:

   SPE is an optional Armv8-A architecture extension available since
   Armv8.2-A. Examples of infrastructure CPUs supporting SPE are
   Neoverse-E1, Neoverse N1 and Neoverse V1. Graviton 2 and Ampere Altra
   are examples of Neoverse-based processors

> 
> Thank you very much,
> Marc
> 

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-arm-spe.txt

[2]:
https://community.arm.com/arm-community-blogs/b/tools-software-ides-blog/posts/arm-allinea-studio-21-0
