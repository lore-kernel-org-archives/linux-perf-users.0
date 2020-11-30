Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC79C63777
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Nov 2020 15:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B966E2076E
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Nov 2020 15:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgK3Pzq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 10:55:46 -0500
Received: from foss.arm.com ([217.140.110.172]:57016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgK3Pzp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Nov 2020 10:55:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1540BD6E;
        Mon, 30 Nov 2020 07:55:00 -0800 (PST)
Received: from [10.57.27.168] (unknown [10.57.27.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECE973F718;
        Mon, 30 Nov 2020 07:54:58 -0800 (PST)
Subject: Re: [PATCH] perf tools: add aarch64 registers to --user-regs
To:     Alexandre Truong <alexandre.truong@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20201127153923.26717-1-alexandre.truong@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <cd0592be-68d2-c88d-ff18-05f7d3ba8cc2@arm.com>
Date:   Mon, 30 Nov 2020 17:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201127153923.26717-1-alexandre.truong@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 27/11/2020 17:39, Alexandre Truong wrote:
> Previously, this command returns no help message on aarch64:
> 
>   -> ./perf record --user-regs=?
> 
>   available registers:
>   Usage: perf record [<options>] [<command>]
>       or: perf record [<options>] -- <command> [<options>]
> 
> With this change, the registers are listed.
> 
>   -> ./perf record --user-regs=?
> 
>   available registers: x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 lr sp pc
> 
> It's also now possible to record subsets of registers on aarch64:
> 
>   -> ./perf record --user-regs=x4,x5 ls
>   -> ./perf report --dump-raw-trace
> 
>   12801163749305260 0xc70 [0x40]: PERF_RECORD_SAMPLE(IP, 0x2): 51956/51956: 0xffffaa6571f0 period: 145785 addr: 0
>   ... user regs: mask 0x30 ABI 64-bit
>   .... x4    0x000000000000006c
>   .... x5    0x0000001001000001
>    ... thread: ls:51956
>     ...... dso: /usr/lib64/ld-2.17.so
> 

Checked that the registers can be listed with =? and that recording different combinations of registers works as expected.

Tested-by: James Clark <james.clark@arm.com>
