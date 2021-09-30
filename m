Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3305AC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 12:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A579615A4
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 12:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348161AbhI3MLD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 08:11:03 -0400
Received: from foss.arm.com ([217.140.110.172]:53192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348155AbhI3MLD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Sep 2021 08:11:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64B91106F;
        Thu, 30 Sep 2021 05:09:20 -0700 (PDT)
Received: from [10.57.21.68] (unknown [10.57.21.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36493F793;
        Thu, 30 Sep 2021 05:09:17 -0700 (PDT)
Subject: Re: [PATCH 1/5] perf cs-etm: Print size using consistent format
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210923162434.GA2189675@p14s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <67a54101-a514-6077-96ba-8809226181eb@arm.com>
Date:   Thu, 30 Sep 2021 13:09:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210923162434.GA2189675@p14s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Mathieu,

Thanks for your feedback. I will keep these points in mind for future 
submissions.

On 23/09/2021 17:24, Mathieu Poirier wrote:
> Hi German,
>
> On Thu, Sep 16, 2021 at 04:46:31PM +0100, German Gomez wrote:
>> [...]
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> A couple of things to improve for your next interactions with the Linux community:
>
> 1) Using a cover letter, even for small changes, is always a good idea.
> 2) RB tags should be picked up publicly rather than done internally and added to
> a patchset.
> 3) Keep patches semantically grouped.  Here patches 04 and 05 have nothing to do
> with 01, 02 and 03.
Did you perhaps mean separating 01 and 02 from the rest? I grouped 03 to 
05 because
they were related to snapshot mode.

Thanks,
German

>
> Moreover Arnaldo queues changes to the perf tools but I don't see him CC'ed to
> this patchset.  As such he will not see your work.  Ask James about how to
> proceed when submitting patches to the perf tools.
>
> Thanks,
> Mathieu
>
>>   		     cs_etm_decoder__get_name(etmq->decoder), buffer->size);
>>   
>>   	do {
>> -- 
>> 2.17.1
>>
