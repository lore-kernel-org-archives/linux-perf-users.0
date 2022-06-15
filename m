Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E4EC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Jun 2022 13:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiFONVT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349376AbiFONVR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Jun 2022 09:21:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D966F3B02F
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 06:21:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE883139F;
        Wed, 15 Jun 2022 06:21:16 -0700 (PDT)
Received: from [10.57.84.186] (unknown [10.57.84.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA1B3F66F;
        Wed, 15 Jun 2022 06:21:15 -0700 (PDT)
Subject: Re: [PATCH] perf test: Record only user callchains
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        jolsa@kernel.org, Leo Yan <leo.yan@linaro.org>
References: <20220614105207.26223-1-mpetlan@redhat.com>
 <20220614131704.GA237086@leoy-ThinkPad-X240s> <Yqjc/FSW2sJ6ZA5U@kernel.org>
 <20220615081402.GA121588@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <3cee66ce-f4d6-fee6-6efe-84a3e3ef5bb1@arm.com>
Date:   Wed, 15 Jun 2022 14:21:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220615081402.GA121588@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 15/06/2022 09:14, Leo Yan wrote:
> On Tue, Jun 14, 2022 at 04:09:48PM -0300, Arnaldo Carvalho de Melo wrote:
>
> [...]
>
>>> With addressing German's comment for "excluding kernel callchains":
>> Addressed.
>>  
>>> Reviewed-by: Leo Yan <leo.yan@linaro.org>
>> Thanks, added.
> Thanks a lot, Arnaldo!

+1, thank you for the edits and merging
