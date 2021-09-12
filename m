Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42860C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Sep 2021 08:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D4D6113E
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Sep 2021 08:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhILI0u (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 04:26:50 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:42372 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhILI0u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 12 Sep 2021 04:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=66/6NqPSrhkqph5BWOoEvjv8N+hS8IRfOIKI44IZqjw=; b=wWA3BWxW/Smiw4RQINt8mfkrq0
        DkLrdMsHmO89LiHr/IMLslutz6bmKIYbIZPIoH6QSLvYUbA6C26WJyvfanXeotjKkXaXjfw5k2GWF
        ANexlgrkN1YmK1bIKvjM0XjIzRjqmRfV25noVlHcu4gAg7fJwA0SDb6Sa8FAqoBnr0lI=;
Received: from lfbn-mar-1-908-222.w90-73.abo.wanadoo.fr ([90.73.223.222] helo=[192.168.1.32])
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <rbernon@codeweavers.com>)
        id 1mPKnq-0002FX-7Y; Sun, 12 Sep 2021 03:25:32 -0500
Subject: Re: [PATCH] perf symbol: Look for ImageBase in PE file to compute
 .text offset
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210909192637.4139125-1-rbernon@codeweavers.com>
 <YTpuTiYzkTKbUM/l@kernel.org>
From:   =?UTF-8?Q?R=c3=a9mi_Bernon?= <rbernon@codeweavers.com>
Message-ID: <e8ae2882-12cd-0fe1-b5e6-da9fc286b821@codeweavers.com>
Date:   Sun, 12 Sep 2021 10:25:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTpuTiYzkTKbUM/l@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 9/9/21 10:27 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 09, 2021 at 09:26:36PM +0200, Remi Bernon escreveu:
>> Instead of using the file offset in the debug file.
>>
>> This fixes a regression from 00a3423492bc90be99e529a64f13fdd80a0e8c0a,
>> causing incorrect symbol resolution when debug file have been stripped
>> from non-debug sections (in which case its .text section is empty and
>> doesn't have any file position).
>>
>> The debug files could also be created with a different file alignment,
>> and have different file positions from the mmap-ed binary, or have the
>> section reordered.
>>
>> This instead looks for the file image base, using the corresponding bfd
>> *ABS* symbols. As PE symbols only have 4 bytes, it also needs to keep
>> .text section vma high bits.
> 
> I added a:
> 
> Fixes: 00a3423492bc90be ("perf symbols: Make dso__load_bfd_symbols() load PE files from debug cache only")
> 
> To help stable@kernel.org to pick it, its on my local tree now.
> 
> It would be great to get a:
> 
> Reviewed-by: Nicholas Fraser <nfraser@codeweavers.com>
> 
> Can we have it, please?
> 

Well, Nicholas doesn't work with us anymore. I've reached them 
separately but didn't get any answer so I'm thinking they may not be 
interested.
-- 
Rémi Bernon <rbernon@codeweavers.com>
