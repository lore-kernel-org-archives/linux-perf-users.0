Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A1EC4332B
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jan 2021 10:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D37A2339F
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jan 2021 10:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbhAMK6m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbhAMK6l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Jan 2021 05:58:41 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC8FC061795
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Jan 2021 02:58:01 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x12so846377plr.10
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Jan 2021 02:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=1WK+XEEJn4oGZYYnRruy9aIAMhDz+5cPeL9GOYA+tIg=;
        b=HdnaQTkC5bPf07QRcriaAKBn3LR6KlTFf87f1TQ3SZH59yWDboFr4mlca4WmwIKN1P
         EPMQ0MYaXdjzOLFFlgYuqPsZZ5t4wFhPrQ59zrbuYh/IHfVFT2nUHdqGz477Ptiz+SCv
         RIW8/WJyikq7VTSei5dUFl7SkQ+W1VRq+XQqdVYv0zElAzCpPmqwHEduHIENRMAYM17i
         L9Do6uk9WWb0IsBvYo6nXp8Gm5EvCk8upFd7n76R7j4zdUyylnr1CogYBmAKtPVe9GZV
         FrFb4GAS4YlExvvKudTfuX8rOQcUdnEFPzDbQFX0zAH4Bbjwq8EqS17tSQ5roPC0Xt4Z
         SotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1WK+XEEJn4oGZYYnRruy9aIAMhDz+5cPeL9GOYA+tIg=;
        b=IoZWDiiZPibw0O9E0wjCg9iqxLZt3VDQoPG9z/MyPyuCog8sWE566AaGtVFwwR5Mcu
         6K9ZFRWHl3QORhhr5kbPQcZkraEnt6+cGrRzgEHU2eVCd1i55wfFi+A7JAp8at7FeCnt
         yzYvlQuBuoa1hJYcaz/ry13Kf8o/zqKrnPzU65e4wYXAdkg6+ksvtJBDAjsS4J/wczYv
         m7RfGip8Fw4fYtRjw3zdUuVkIir0q9+6nVGFKretTn/13qXGS9hho+bxRPCHcUMIxtUH
         yoTqoPO5gDKBZySS5bV/o+fxG5wMApNh5jL8OzgjAqgdNemDUzbgQhBsRrKEb0odqGvM
         aU4w==
X-Gm-Message-State: AOAM531uTmZgC6L7AN6Ujb5N/+nae5HAlS7LRyY5cTCqpV7MLO9tMt2/
        9rT+Meg64Y4G4O1YEBO2rv5/ykHNpkI=
X-Google-Smtp-Source: ABdhPJwGa4Y3ZxI3z3VR0wYaDtZFUpSjzlW+ozKN86yl+syhkjgO7PiwZEu9WQgYrzysKknoMBqVhw==
X-Received: by 2002:a17:902:6a83:b029:dc:2a2c:6b91 with SMTP id n3-20020a1709026a83b02900dc2a2c6b91mr1753677plk.8.1610535480582;
        Wed, 13 Jan 2021 02:58:00 -0800 (PST)
Received: from [0.0.0.0] (tunnel595741-pt.tunnel.tserv22.tyo1.ipv6.he.net. [2001:470:23:8a4::2])
        by smtp.gmail.com with ESMTPSA id x143sm2464818pgx.66.2021.01.13.02.57.58
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 02:58:00 -0800 (PST)
Subject: Re: [BUG] JIT symbols not resolved after mprotect() combined vma
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-perf-users@vger.kernel.org
References: <40d550d6-e698-fad2-be81-aab6a56c5e64@gmail.com>
Message-ID: <c99426db-b696-e74b-417c-636dee0b1c8f@gmail.com>
Date:   Wed, 13 Jan 2021 18:57:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <40d550d6-e698-fad2-be81-aab6a56c5e64@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

The problem had been solved. I'm using a old kernel so I encountered 
this problem. I should try my program on latest kernel first.

Here are some pointers about this problem:

https://www.spinics.net/lists/linux-perf-users/msg09833.html
https://lkml.org/lkml/2019/10/31/785

Thank you all!
Zhang Boyang

On 2021/1/9 16:59, Zhang Boyang wrote:
> Hello,
> 
>    I'm using perf to measure my LLVM jitted code performance. However, I 
> found with some condition, perf will unable to resolve or annotate JIT 
> symbols. After some debugging, I found the cause is mprotect() combined 
> two adjacent vma, and report a MMAP2 event of merged vma, confusing perf.
>    I wrote a sample program (sample.c). It creates function computing 
> factorial. First it creates test1() and exec it for 10000 times. Then, 
> it creates test2() and exec both test1() and test2() for 10000 times 
> respectively. As a result, test1() was executed 20000 times, and test2() 
> was executed 10000 times.
>    However, perf report shows:
> 
>    33.33%  a.out    jitted-10742-3.so    [.] test2
>    33.30%  a.out    jitted-10742-2.so    [.] test1
>    33.26%  a.out    [JIT] tid 10742      [.] 0x00007f4b8cb3d010 // test1
> 
>    This is because LLVM create jitted code by using mmap() and 
> mprotect(): (the address is different because of ASLR)
> 
> //// compile test1
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
> = 0x7fca1a491000
> mprotect(0x7fca1a491000, 4096, PROT_READ|PROT_EXEC) = 0
> //// compile test2
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
> = 0x7fca1a490000
> mprotect(0x7fca1a490000, 4096, PROT_READ|PROT_EXEC) = 0
> 
>    The second mprotect will merge two adjacent vma, and report a MMAP2 
> event of merged vma. The pref tool saw this:
> 
> 9547033496331 0x2510 [0x60]: PERF_RECORD_MMAP2 10742/10742: 
> [0x7f4b8cb3d000(0x2000) @ 0x7f4b8cb3d000 00:00 0 0]: r-xp //anon
> 9547033524086 0xf00 [0xb0]: PERF_RECORD_MMAP2 10742/10742: 
> [0x7f4b8cb3d000(0x18) @ 0x40 08:02 10224200 1]: --xs 
> /home/zby/src/qemuproject/qemu/.debug/jit/llvm-IR-jit-20210109-ad4573/jitted-10742-2.so 
> 
> 9553628266188 0x103898 [0x60]: PERF_RECORD_MMAP2 10742/10742: 
> [0x7f4b8cb3c000(0x3000) @ 0x7f4b8cb3c000 00:00 0 0]: r-xp //anon
> 9553628283472 0xfb0 [0xb0]: PERF_RECORD_MMAP2 10742/10742: 
> [0x7f4b8cb3c000(0x18) @ 0x40 08:02 10224201 1]: --xs 
> /home/zby/src/qemuproject/qemu/.debug/jit/llvm-IR-jit-20210109-ad4573/jitted-10742-3.so 
> 
> 
>    The event of third line, confusing perf, make it thinks test1() had 
> disappear. Then perf if unable to resolve test1() or annotate it.
> 
> 
> Thank you very much!
> Zhang Boyang
