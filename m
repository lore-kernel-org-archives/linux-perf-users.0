Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E5FC77B7E
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jun 2023 23:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjFAXbi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFAXbg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jun 2023 19:31:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E93E5F
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jun 2023 16:30:53 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso104401cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685662240; x=1688254240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDXuQz1qQeNpZkf2zwjaSgqw94ILfaA6js26wXkpGJI=;
        b=kvO3LFJRpceDEsaqJ4wzY4QHL0Q/9m1qVsiWdAxzeCjuwvUNVzAZ8K/BO8LlFyDtW7
         EoJ7Bndoz54sG3KyoS+3JCHf99otukvAYYy3wDunZM31CHJU9Cz6/M4PRmcA+KZUaRCb
         rL70IeNV8h+64IibmlvGwz0qQsxgNI50lGX+HtFsSWw1wzkf+Y2zDjXHpQiz1dLcnOiz
         MXjh9O/2jIwwPOmFcZgQH4S4lI2lbkzI0WLC7cN1i29QhRC26nTxNIb4TCaxCcjfGkOM
         UII2gTC/B+sUNFw2pjqfjpVfdkOaaJZaSyty7Ed1gqM1PRoXBFnCvhNvX59TYe/lCdGS
         r70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685662240; x=1688254240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDXuQz1qQeNpZkf2zwjaSgqw94ILfaA6js26wXkpGJI=;
        b=kVMsnfQgo0qvqsr5IwgP7rOpYwJiLzTGaTSiXsc7LiSKlUXwIpu/4gQDFZZ3+NiMsk
         O4kfbzxaY5wuHtFe5abp2Zew8yCX6hz8uydn1mmvZe0VE6htymVkbgixvs7Audh7Yqll
         y+mSIB2lwdyrqy1TZ7BLhRJzGQaS5+FDFkQc2JpQTcX5JgLFUUSWpIOLuiIjXEV8PpLz
         +hl6oMLN7oTxaKjRqSMNLQhOyxy9gDdQC7bu9T5ORoYD5V5w3QuCoTAW0AXokvs0CUmA
         yajdx7jgheiPS5mMgrDzt7Eg/lifdhPxg5HVawmXeD+7+F9g3ebAhYfrL9QJMHrRZP9I
         OVmg==
X-Gm-Message-State: AC+VfDxQb3Gg1uvpcI7umDR5MC7zuT9nlwdY6ZzEx+BNBI9NyeEYF4W4
        xJgxxL26FXdG0f0rpkIqPt5M2ZklFnW5U3zvyyW4zTIbjGiPAqC/6q3g4Q==
X-Google-Smtp-Source: ACHHUZ6iTgWaxE8gGmK4eTtxsiJ3p1Qnpfm2k+bPOC4QaUVi/82PeanODNr9F1JxD5I0tTgjQBSWDg46iHzpwxxWAyY=
X-Received: by 2002:a05:622a:1a28:b0:3ef:1c85:5b5e with SMTP id
 f40-20020a05622a1a2800b003ef1c855b5emr39366qtb.19.1685662239803; Thu, 01 Jun
 2023 16:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAPXMrf9mRG_uyEdkppJOjJxCREXjZsXGo2A_QEtwHM4G+nJoEA@mail.gmail.com>
In-Reply-To: <CAPXMrf9mRG_uyEdkppJOjJxCREXjZsXGo2A_QEtwHM4G+nJoEA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 1 Jun 2023 16:30:28 -0700
Message-ID: <CAP-5=fXth=1qRgH6iNKt6eAWt4MM4Xd0jn8o65BD9SDq8v6uYg@mail.gmail.com>
Subject: Re: Reg: Perf report consuming too high memory
To:     RAJESH DASARI <raajeshdasari@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 1, 2023 at 6:51=E2=80=AFAM RAJESH DASARI <raajeshdasari@gmail.c=
om> wrote:
>
> Hi ,
>
> I am noticing high memory usage, oom killer is invoked and restarting
> our node while running perf report command.
>
>  perf record -a  -g   sleep 120
> [ perf record: Woken up 2472 times to write data ]
> [ perf record: Captured and wrote 623.050 MB (3830374 samples) ]
>
> perf report
>
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND
>  119877 root      20   0 7335760   7.0g 670244 S   0.0  59.7   0:22.23 pe=
rf
>
> perf report command is consuming more memory, oom killer is invoked.
> System details : kernel 5.4.242 + glibc 2.26 + gcc12
> I tried with perf 6.x versions but I still see more memory consumption.
>
> I tried the same experiment on a different system under the same load
> , this system has ( kernel 5.4.242 + glibc 2.24 + gcc 11)
>
> perf record -a  -g  sleep 120
> [ perf record: Woken up 1868 times to write data ]
> [ perf record: Captured and wrote 470.203 MB
> /tmp/rcpprofiling/data_cg.data (3828394 samples) ]
>
> perf report
>
> PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAN=
D
> 840045 root      20   0 1459520   1.4g 493380 R  98.1  11.8   0:31.21
> perf report
>
>
> I see that the more the perf.data file size, the more  memory it
> consumes, but in this case i only see 200MB difference between the
> perf.data file and also only 2k sample difference, but memory
> consumption is too high in the first system.
>
> What could be the reason, is this expected behaviour or how to debug
> why perf is consuming more memory here  . Please help me with this
> query .

Hi Rajesh,

As you are using perf in system wide mode every running process has
its memory map added to the perf.data file, this is so that a virtual
address in a sample can be turned into a file offset. perf report will
process the shared objects and even use objdump to annotate them. This
can all be pretty costly in terms of memory but it sounds like perf is
working-as-intended. Have you tried just attaching perf to the process
you are interested in?

Thanks,
Ian

> Thanks,
> Rajesh Dasari.
