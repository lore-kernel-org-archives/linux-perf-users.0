Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3808AC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Dec 2021 10:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhLNKXB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Dec 2021 05:23:01 -0500
Received: from foss.arm.com ([217.140.110.172]:51140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhLNKXA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Dec 2021 05:23:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77DE06D;
        Tue, 14 Dec 2021 02:23:00 -0800 (PST)
Received: from [10.57.35.107] (unknown [10.57.35.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84CCF3F5A1;
        Tue, 14 Dec 2021 02:22:59 -0800 (PST)
Subject: Re: PMU event repository for Arm
To:     Ian Rogers <irogers@google.com>, Al Grant <al.grant@foss.arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
References: <486e7e8d-de21-5e26-3792-db2fd6991602@foss.arm.com>
 <CAP-5=fUtkCzgsGS6LkCVTuyPmw981Dd-EavtU6uv3o7OB7CnDA@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <ba55b083-dbfe-d069-ad67-0322b79112a3@arm.com>
Date:   Tue, 14 Dec 2021 10:22:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUtkCzgsGS6LkCVTuyPmw981Dd-EavtU6uv3o7OB7CnDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/12/2021 18:47, Ian Rogers wrote:
> This is very helpful! It is a bit strange seeing the event codes not
> as hex. Do you have any plans around metrics? What is the flow from
> this json to the linux/tools/perf json?

Hi Ian,

I can't answer about the metrics part, but we do currently have an internal
script to convert from this repo to the perf tools jsons. Maybe @Andrew
can clarify what the plan to upstream this is. I think we struggled to
find a suitable place to put it.

James

> 
> Thanks,
> Ian
> 
> On Fri, Dec 10, 2021 at 7:53 AM Al Grant <al.grant@foss.arm.com> wrote:
>>
>> Hi, other vendors have shown the value of having a machine-readable
>> collection of PMU events, and we now have this for Arm:
>>
>>    https://github.com/ARM-software/data
>>
>> This is equivalent to the tables in about 40 of Arm's public CPU
>> reference manuals. It includes some details that aren't needed in
>> tools/perf/pmu-events, but one could be generated from the other.
>>
>> There's also a map of CPU ids (MIDR) to CPU names, and an example
>> script to scan /proc/cpuinfo and retrieve the correct JSON file(s).
>>
>> I won't spam linux-perf-users every time we add something, but we
>> haven't publicized this before, so here it is. Feedback is welcome.
>>
>> Al
