Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D87C54EBE
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Jan 2023 21:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbjAIV3z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbjAIV3e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2023 16:29:34 -0500
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 13:29:33 PST
Received: from out-231.mta0.migadu.com (out-231.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038C60DF
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Jan 2023 13:29:32 -0800 (PST)
Message-ID: <7ec772fb-2108-5945-a308-4bb46fcf0090@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673299374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccawMTleCmZz1jGx2iBWYJBoqvkqRsUGvWtniWP7DjU=;
        b=FFcuPegRP+Lqf0FJBJna8bWVwotz9tpjIml4MmxXbv7ar5KcYsbunlc+/z42M04hlGlytQ
        eqXAWBJ1Cw0w8bnWae8iC/K6/dTvX7ulnH1A0L4jH1TOTBDIgbYfSwvjLIbxouzVM+/y1k
        MQIRuyTwNKIjG4MEmM+C5VYGJcWZ7Ig=
Date:   Mon, 9 Jan 2023 13:22:46 -0800
MIME-Version: 1.0
Subject: Re: [PATCH] perf lock contention: Do not use BPF task local storage
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, Blake Jones <blakejones@google.com>,
        Chris Li <chriscli@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20221118190109.1512674-1-namhyung@kernel.org>
 <dea8c3c5-0739-58c1-9a88-b989878a9b8f@linux.dev>
 <CAM9d7cjk_7-ALzW1kT961TRLpO9Wt8gNX7+rH4ay4N92g1TYkg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAM9d7cjk_7-ALzW1kT961TRLpO9Wt8gNX7+rH4ay4N92g1TYkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 1/9/23 12:56 PM, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Nov 21, 2022 at 9:33 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 11/18/22 11:01 AM, Namhyung Kim wrote:
>>> We could fix the task local storage to use the safe BPF allocator,
>>> but it takes time so let's change this until it happens actually.
>>
>> I also got another report on the kfree_rcu path.  I am also looking into this
>> direction on using the BPF allocator.
> 
> Any progress on this?  Are there any concerns about the change?

Yep, I am working on it. It is not a direct replacement from kzalloc to 
bpf_mem_cache_alloc. eg. Some changes in the bpf mem allocator is needed to 
ensure the free list cannot be reused before the rcu grace period. There is a 
similar RFC patchset going into this direction that I am trying with.

