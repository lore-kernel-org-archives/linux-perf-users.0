Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59641C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Dec 2021 09:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379509AbhLCJZd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Dec 2021 04:25:33 -0500
Received: from foss.arm.com ([217.140.110.172]:46070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351316AbhLCJZd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Dec 2021 04:25:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D73913D5;
        Fri,  3 Dec 2021 01:22:09 -0800 (PST)
Received: from [10.57.33.246] (unknown [10.57.33.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 793B03F5A1;
        Fri,  3 Dec 2021 01:22:07 -0800 (PST)
Subject: Re: [PATCH] perf: Drop -lstdc++ from OPENCSDLIBS
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Branislav Rankov <branislav.rankov@arm.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
 <8a5aead5-369d-5c0b-1ef7-362f777c5b9a@arm.com>
 <241b28ec-4acf-b30f-90c1-e1f7ef6c1443@arm.com>
 <f4518dad-b02a-368b-99d7-7a57b57f36eb@kleine-koenig.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <4d9761e7-083c-0d94-526b-1513d0eb1576@arm.com>
Date:   Fri, 3 Dec 2021 09:22:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f4518dad-b02a-368b-99d7-7a57b57f36eb@kleine-koenig.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 02/12/2021 16:07, Uwe Kleine-König wrote:
> On 12/2/21 17:00, Branislav Rankov wrote:
>> I did not have problems when trying crosscompile in both dynamic and static case.
>> But maybe you have a case where this is a problem. I would like to understand what
>> your case is.
>> Does your libOpenCSD.so have a dependency on libstdc++.so?
>> If so, where is the libstdc++.so?
> 
> As noted in an other thread branch: I have libstdc++.so.6.0.29 but not libstdc++.so. For linking this is enough as the binary that is linked doesn't need any symbols from libstdc++.so.
> 
>> If this is a genuine problem, we could add -lstdc++ conditionally only for the
>> static build.
> 
> That seems to be the path to go then.

Hi Uwe,

Yes I think so. There are also quite a few similar cases in the makefiles like:

  ifeq ($(findstring -static,${LDFLAGS}),-static)
    DWARFLIBS += -lelf -lebl -ldl -lz -llzma -lbz2
  endif

With the conditional added to this patch:

Reviewed-by: James Clark <james.clark@arm.com>


Thanks
James

> 
> Best regards
> Uwe
