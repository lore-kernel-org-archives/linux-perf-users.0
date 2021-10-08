Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF3C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 10:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB4AC60F6D
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 10:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhJHKZl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 06:25:41 -0400
Received: from foss.arm.com ([217.140.110.172]:40904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236118AbhJHKZl (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 06:25:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27AECD6E;
        Fri,  8 Oct 2021 03:23:46 -0700 (PDT)
Received: from [10.57.25.67] (unknown [10.57.25.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BA103F70D;
        Fri,  8 Oct 2021 03:23:44 -0700 (PDT)
Subject: Re: [PATCH] perf vendor events power10: Add metric events json file
 for power10 platform
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.vnet.ibm.com,
        jolsa@redhat.com, "acme@kernel.org" <acme@kernel.org>
References: <20211006073119.276340-1-kjain@linux.ibm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <4cd80a52-3938-a708-9272-99e9ed86be00@arm.com>
Date:   Fri, 8 Oct 2021 11:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006073119.276340-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 06/10/2021 08:31, Kajol Jain wrote:
> Add pmu metric json file for power10 platform.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  .../arch/powerpc/power10/metrics.json         | 772 ++++++++++++++++++

I checked this with the new strict JSON parser from "[PATCH 0/3] perf tools: Enable strict JSON parsing"
and it seemed fine from that point of view.

James
