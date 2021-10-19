Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD4AC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 08:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576AB61372
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 08:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJSIgu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 04:36:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4001 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJSIgt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 04:36:49 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HYRl54zNKz67Kvc;
        Tue, 19 Oct 2021 16:30:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Tue, 19 Oct 2021 10:34:35 +0200
Received: from [10.47.85.98] (10.47.85.98) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 09:34:34 +0100
Subject: Re: [PATCH 2/2] perf jevents: Enable warnings through HOSTCFLAGS
To:     James Clark <james.clark@arm.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <mingo@redhat.com>
CC:     <irogers@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kjain@linux.ibm.com>
References: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
 <1634316507-227751-3-git-send-email-john.garry@huawei.com>
 <1804d7f3-c3bb-a90f-c86d-d96bff4235d2@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <89695366-c729-492e-aad6-5c98f914da79@huawei.com>
Date:   Tue, 19 Oct 2021 09:37:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1804d7f3-c3bb-a90f-c86d-d96bff4235d2@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.98]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 18/10/2021 11:41, James Clark wrote:
> 
> 
> On 15/10/2021 17:48, John Garry wrote:
>> Currently no compiler warnings at all are enabled for building jevents,
>> so help catch bugs at compile time by enabling through HOSTCFLAGS.
> 

Hi James,

> Is there any reason to not enable -Wall and -Werror so that it builds like
> the main project? Or if HOSTCFLAGS ends up being the same as CORE_CFLAGS
> then why not use CORE_CFLAGS instead?

I am not sure that we really want that, as CORE_CFLAGS brings with it 
things like _LARGEFILE64_SOURCE, which I doubt we want.

> 
> I added them like this and only one unused function needs to be removed to
> make it build successfully:
> 
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 65934984f032..b2edcedf01db 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -18,6 +18,8 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
>   
>   CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>   HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> +HOSTCFLAGS += -Wall
> +HOSTCFLAGS += -Wextra
>   
>   include $(srctree)/tools/scripts/Makefile.arch
>   
> @@ -212,6 +214,7 @@ endif
>   ifneq ($(WERROR),0)
>     CORE_CFLAGS += -Werror
>     CXXFLAGS += -Werror
> +  HOSTCFLAGS += -Werror

These seem fine to add. Actually what I have in HOSTCFLAGS doesn't seem 
to detect unused functions, with one example fixed in b94729919db2.

Thanks,
John
