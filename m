Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E9C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 14:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24F961211
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 14:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbhJOOnl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 10:43:41 -0400
Received: from foss.arm.com ([217.140.110.172]:43880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240561AbhJOOnj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 10:43:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 320E5147A;
        Fri, 15 Oct 2021 07:41:32 -0700 (PDT)
Received: from [10.57.73.178] (unknown [10.57.73.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3218D3F66F;
        Fri, 15 Oct 2021 07:41:29 -0700 (PDT)
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <James.Clark@arm.com>
References: <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
 <20211006095124.GC14400@leoy-ThinkPad-X240s>
 <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
 <20211013003916.GA130842@leoy-ThinkPad-X240s>
 <20211013075125.GA6701@willie-the-truck>
 <35209d5c-6387-5248-ab61-a1e1cb0553de@arm.com>
 <20211015141601.GA66946@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <4cb80863-922f-ee8e-abc6-c5be8fe5cff1@arm.com>
Date:   Fri, 15 Oct 2021 15:41:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015141601.GA66946@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 15/10/2021 15:16, Leo Yan wrote:
> Hi German,
>
> On Fri, Oct 15, 2021 at 01:33:39PM +0100, German Gomez wrote:
>
> [...]
>
> Thanks for sharing the testing cases.  Could give me a bit more time for
> the test at my side?  And please expect I might give some comments if
> I think it's necessary.
>
> Thanks,
> Leo


Absolutely. Please take the time you need.

Many thanks,
German


