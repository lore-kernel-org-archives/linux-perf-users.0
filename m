Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89BBC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 20:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B66B60F5E
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 20:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhIEUfE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 16:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhIEUfD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 16:35:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53432C061575
        for <linux-perf-users@vger.kernel.org>; Sun,  5 Sep 2021 13:34:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z4so6655397wrr.6
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Sep 2021 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=HB5rxAe7Wj5sveWljQWfJe52FTr93PInI+zChOxlc44=;
        b=WlTTufSfqNzVqxLndBdYlQCS3Zs7Q75ghpDw5g9abdu1yoUUzRcPUJ8JNlqG5EaCxS
         at89kl5JHh+4/kIYwwrryUOamMo2HhZtnb2h4H5Ggye0w02PL2i/zLZ+saqe4YhISdZ+
         xs3nlY8UUBuz+uBSlEqJdjGOhCC6IXPNztxuni+GcqSB50ykZfWUrGIMNlQRa+ZhtbsC
         5x8w8e5akMRlLzvcBFpLOVizdbXCjfNeqv8uBXIe5jMGpu8l0XRg0666mgAtaiLkW4b7
         ecuEQotaI1Fi5v6KTMgWOJyiiYCQOrY1mtY2ZEvLzQXP+MxHH5OyuduriaKqdXXeX2mj
         ARnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HB5rxAe7Wj5sveWljQWfJe52FTr93PInI+zChOxlc44=;
        b=CS7C8bCqAEC+5vHcO2LOA85BWbe25Vn+qVdU1SrHAh9OiLbYgmyroHe12oXC8jmNVu
         vMTiArn3fMT/0JzfaY8WpcaUh7N7R+GSQYvlqyJPwCuFurLhDPaJeai6r+c0carh8B71
         EDdX79s+ehthhaBAC3f+7as8/RSVsMeEaESkDW4bfFXWonfXWSETDq90c6hEOyOVbeyy
         JXDOjLgIznKqStwKbpylMPCNwsRzQDDvvaLv553a+sBidltAYdiIJYDJeA+z0x2Hgr8B
         I2A9gLGJTRCOF1cRtka48TAMiDv6TR/JiBHO8jPxwXZ+7bzEQIHnbhzHPqNiqrZCZUIk
         WjQQ==
X-Gm-Message-State: AOAM530KTj7swkoL0cEeJ9kt7iHvSxdPOZo0zig9RWxdmM5LQV70JZSX
        fgwfC8SByFqrDoU5sCxlJS3HaQ3rw/xT
X-Google-Smtp-Source: ABdhPJx+RG2r+IfpB2VTL8ChxDhmuaRzzehEXL8kcy/Ea1pfwy/5VVwIa4g3aSsO/PstB49TKdzv7w==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr9661524wrj.72.1630874037587;
        Sun, 05 Sep 2021 13:33:57 -0700 (PDT)
Received: from [192.168.1.99] (i5C75B6C9.versanet.de. [92.117.182.201])
        by smtp.googlemail.com with ESMTPSA id s7sm5957009wra.75.2021.09.05.13.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 13:33:57 -0700 (PDT)
Subject: Re: A list of visual Profiler UIs for linux perf
To:     Mark Hansen <mark@markhansen.co.nz>,
        linux-perf-users@vger.kernel.org
References: <CAM07o6QB9rUgzxHxR=sdwTddn+2GxeK5Uwj9QeCVMyEiD5SRdA@mail.gmail.com>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <fe56fd75-a51b-3e3d-8747-1640685b8d5d@gmail.com>
Date:   Sun, 5 Sep 2021 22:33:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAM07o6QB9rUgzxHxR=sdwTddn+2GxeK5Uwj9QeCVMyEiD5SRdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Mark,

On 9/5/21 8:19 AM, Mark Hansen wrote:
> Hi perf-toolers,
>
> I wrote a quick literature-review of profiler user interfaces
> available for analysing the output of Linux perf:
> https://www.markhansen.co.nz/profiler-uis/
>
> I couldn't find a similar list of profiler UIs online. Hopefully this
> can help people find the profiler UI that's right for them.
>
> I'd appreciate any feedback; in particular: did I miss any great perf UIs?

I am not sure if it qualifies as great perf UI but there is traceshark:

https://github.com/cunctator/traceshark

It's a visualizer with a focus on visualizing things like scheduling and 
wakeup events. I guess it's mostly useful to see what a task has been 
waiting for but it's also possible to see which tasks are burning CPU 
time. It doesn't support perf.data files, it read files generated with 
"perf script -f".

It has the possibility of filtering and saving the filtered output, so 
it's possible to filter on various things, for example a certain task, 
or set of tasks, for a certain time window. It's then possible to save 
the filtered cycles events and use Brendan Gregg's flamegraph tools to 
generate a flamegraph.

In case you decide to try it out, I recommend building it from source, 
since the binary packages in Debian/Ubuntu don't have OpenGL support. 
For some older versions, that is older than what is currently in 
Debian/testing, there is also an OpenGL configuration mismatch issue 
between the application and a library that makes scrolling and zooming 
painfully slow.

best regards,

Viktor


