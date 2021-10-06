Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB8EC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CA961152
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbhJFIpd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:45:33 -0400
Received: from foss.arm.com ([217.140.110.172]:33214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237420AbhJFIpd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 04:45:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 551EAED1;
        Wed,  6 Oct 2021 01:43:41 -0700 (PDT)
Received: from [10.57.22.130] (unknown [10.57.22.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBDE83F7B4;
        Wed,  6 Oct 2021 01:43:38 -0700 (PDT)
Subject: Re: [PATCH 1/4] perf vendor events: Syntax corrections in Neoverse N1
 json
To:     John Garry <john.garry@huawei.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211004160008.21645-1-andrew.kilroy@arm.com>
 <b7a4a1b3-3d22-7a52-75b1-66c04b57a50c@huawei.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <0743bf83-2e5d-8830-61bc-ed0731db108d@arm.com>
Date:   Wed, 6 Oct 2021 09:43:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b7a4a1b3-3d22-7a52-75b1-66c04b57a50c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 05/10/2021 11:10, John Garry wrote:
> On 04/10/2021 17:00, Andrew Kilroy wrote:
>> There are some syntactical mistakes in the json files for the Cortex A76
>> N1 (Neoverse N1).  This was obstructing parsing from an external tool.
> 
> If the trailing comma is not allowed by standard, then maybe we should fix our parsing tool to not allow it also. However maybe there is a good reason why we allow it..

It would be nice to do, because I have also made similar fixes before. We looked at the STRICT option
in the parser (https://github.com/zserge/jsmn), but even then it seems to allow trailing commas.

Trailing commas are not allowed in the json standard, but there is a split between parsers
where some allow it and others don't. Specifically the Python parser doesn't allow it, and Python
can easily be involved in some workflow that parses these files.

The only way forwards I can think of is either getting a change accepted upstream to the parser
and then updating it in perf, switching to a different parser, or doing some hack to add an extra
step in perf to look for commas. None of which sound ideal.

James

