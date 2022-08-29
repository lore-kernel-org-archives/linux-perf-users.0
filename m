Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB831ECAAD8
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Aug 2022 22:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiH2WNE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Aug 2022 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2WND (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Aug 2022 18:13:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D697D78B
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 15:13:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z2so11909022edc.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date;
        bh=Cw12sPySznvtDCJ418gV39Dnk6cekbND70YyQBlbRb0=;
        b=HfNm14Dcf0+Hg/ijM44HVhx8ah1N7M9T+XrGoUJLHz9E+Kd9UjvkmqyRVUf0zhF062
         r0XFpG1rlR6NrplhQqmZWGC13vZp0C61StMdC9mUvwqW7JNIWnb9evCgsikjgLWpRfUg
         afmjB5ipAIYWdAxSq8E/EyDHlEp5T9u+h5EIuCQ7zJv6i/gNRZV3TP9x+Vo/ukRY9Kqu
         scxq5dokGSJt83I/u6krKIhwNt+jtxiqscyh9rFMWl6IptJkzKvYbP+o77f5hMtLmSD2
         n7rY8yAb+0HAJ+H5Ayc6kfVRjRpwl1fiSoyzvefNQZv+bYT1UDt1ecHSOYp/DUFAdBxg
         gpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Cw12sPySznvtDCJ418gV39Dnk6cekbND70YyQBlbRb0=;
        b=WJoE1bRki7MaOi3ncDiG5+2K8NNLuGH6y0X7kfpnl5rJnLvTGzT+zXgXJC7e22RJP7
         Y5oHHAFEn043E5XsoS/cLmlSwvtbxb3lhfSyQkAY4RDyxRDjWpxvhc1Wwkp/odaVv+Ha
         U0i86ETG+fxv6dbEiGCpP7dvzPODz+KCd3ei/+JmJ63CJlLPHe2EktoBJ6QFlzTmZSYm
         7cCEjmBvaDrHYyaeaSiLLpvJp+rm/wOnH8B41rxOs75mPgIGEs+461mt9LRVVtoZcpZO
         g5/eL0bdHVrGaBfKbZfgvjBwF2Af+XWMFcV0lV/+IRK5Cnol8CxPC5G6xb3I1YwbkX2D
         J8ng==
X-Gm-Message-State: ACgBeo2e8zVrzGXgI5XVBU1x//5WQ8ao/b0hvKsetdSt0PffzJIb79B7
        UmYHxt3r7dSzBuixLGNnJBY=
X-Google-Smtp-Source: AA6agR5bYiJlBOZYFnE13ajqmzORVrw45TrKjV1EwNYg+M2Xbxu8HJvCZ5ifYt9XwrlnTov7ENvBag==
X-Received: by 2002:aa7:c956:0:b0:43b:206d:c283 with SMTP id h22-20020aa7c956000000b0043b206dc283mr17948757edt.381.1661811180175;
        Mon, 29 Aug 2022 15:13:00 -0700 (PDT)
Received: from krava ([83.240.61.220])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906498a00b007307c4c8a5dsm4925092eju.58.2022.08.29.15.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 15:12:59 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 30 Aug 2022 00:12:58 +0200
To:     Hongtao Yu <Hongtao.Yu@outlook.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Cannot print 'uregs' field with perf script -F uregs
Message-ID: <Yw056ndacsdoAyVg@krava>
References: <DM4PR18MB5026C7008C77EF24557409138A6B9@DM4PR18MB5026.namprd18.prod.outlook.com>
 <YwyxOVALB0mUf/t9@krava>
 <DM4PR18MB50267E1E2D1A247C5E10F8098A769@DM4PR18MB5026.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR18MB50267E1E2D1A247C5E10F8098A769@DM4PR18MB5026.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 29, 2022 at 04:24:57PM +0000, Hongtao Yu wrote:
> Thanks for the response. I tried with hw:uregs but it didn't seem to work expectedly. Instead of giving uregs samples, it gives something like
> 
>       hhvmworker 10485 [003] 2812596.974788:      16009 br_inst_retired.near_call:uppp:          10349698 [unknown] ([unknown])
>       hhvmworker  4412 [006] 2812596.975085:      16009 br_inst_retired.near_call:uppp:          1339b05e [unknown] (/tmp/perf-1530.map)


could you share how do you record the data?

it seems to work on my setup:

[root@krava perf]# ./perf record -a --user-regs sleep 1 
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.477 MB perf.data (1574 samples) ]

[root@krava perf]# ./perf script -F hw:uregs | head -10
 ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
 ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
 ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
 ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
 ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
 ABI:2    AX:0x20ddb70    BX:0x7ffde3dde620    CX:0x1    DX:0x2030b80    SI:0x0    DI:0x2090f60    BP:0x7ffde3dde5f0    SP:0x7ffde3dde5d0    IP:0x4c6afa FLAGS:0x8    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0x7ffde3dde600   R13:0x0   R14:0x0   R15:0x3 
 ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
 ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
 ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
 ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 


[root@krava perf]# ./perf script -F hw:+uregs | head -10
            perf 958512 [000] 278398.227483:          1   cycles:  ffffffff9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
            perf 958512 [000] 278398.227486:          1   cycles:  ffffffff9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
            perf 958512 [000] 278398.227488:          8   cycles:  ffffffff9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
            perf 958512 [000] 278398.227489:        173   cycles:  ffffffff9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
            perf 958512 [000] 278398.227491:       3967   cycles:  ffffffff9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x5    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
            perf 958512 [000] 278398.227493:      90589   cycles:            4c6afa evlist_cpu_iterator__next+0x2a (/home/jolsa/kernel/linux-perf/tools/perf/perf) ABI:2    AX:0x20ddb70    BX:0x7ffde3dde620    CX:0x1    DX:0x2030b80    SI:0x0    DI:0x2090f60    BP:0x7ffde3dde5f0    SP:0x7ffde3dde5d0    IP:0x4c6afa FLAGS:0x8    CS:0x33    SS:0x2b    R8:0x0    R9:0x0   R10:0x0   R11:0x246   R12:0x7ffde3dde600   R13:0x0   R14:0x0   R15:0x3 
            perf 958512 [001] 278398.227515:          1   cycles:  ffffffff9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
            perf 958512 [001] 278398.227517:          1   cycles:  ffffffff9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
            perf 958512 [001] 278398.227518:         13   cycles:  ffffffff9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 
            perf 958512 [001] 278398.227519:        415   cycles:  ffffffff9d073374 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.18.19-200.fc36.x86_64/vmlinux) ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7fa8ce50740f    DX:0x0    SI:0x2400    DI:0x6    BP:0x7ffde3dde5f0    SP:0x7ffde3dde560    IP:0x7fa8ce50740f FLAGS:0x246    CS:0x33    SS:0x2b    R8:0x0    R9:0x1   R10:0x0   R11:0x246   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff 


jirka


> 
> Thanks,
> Hongtao
> 
> 
> 
> From: Jiri Olsa <olsajiri@gmail.com>
> Sent: Monday, August 29, 2022 5:29 AM
> To: Hongtao Yu <Hongtao.Yu@outlook.com>
> Cc: olsajiri@gmail.com <olsajiri@gmail.com>; linux-perf-users@vger.kernel.org <linux-perf-users@vger.kernel.org>
> Subject: Re: Cannot print 'uregs' field with perf script -F uregs 
>  
> On Mon, Aug 15, 2022 at 10:34:44PM -0700, Hongtao Yu wrote:
> > You fix works, thanks! Are you going to commit it?
> 
> sorry for delay.. I was checking in more detail and we actually
> can do it even without the fix with 'hw:' prefix like:
> 
>   # perf script -F hw:uregs
> 
> dummy event is special, but I'll need to check if we want
> to hardcode that first
> 
> jirka
