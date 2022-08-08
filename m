Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C44AC00140
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Aug 2022 08:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiHHIg1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHHIgZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Aug 2022 04:36:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7755B8
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Aug 2022 01:36:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso13814988pjq.4
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Aug 2022 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OU7WvEDIIGXC9xH6gDVyXx9tNvMlvFBVcwNTGsFlT8o=;
        b=XqnrcX8zwkZ1IvbaWDN6yB4G3r6dX+UL/Ps2htwT5i7GkkVjVlAwJZ6gvMi6lQaq2O
         DsSgs+MLwb0CcwQUQ+e4EifrNKElPkHPpitSaj8DpEw29HN+iMTm0X8OeormbrfeyUIU
         H4rn38AC7ZJ30pzltfDIbIR4GwQIpF6i7Mgx5YyfJ+fDh5mlGMSjmCsW7Uvf9i8cja6o
         i86BQ3c1r94bzv1migdC43jFgH7Di8XGckHDPX+GDXk0lz16CadLxskDR9mkZ8s3gTCO
         J+ujbHT3/zeZw+hIXk0K2CLMyMniG1afTeXAGxOIyLe5vOymKFGMyzdUjXiMH1YeTVW3
         F8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OU7WvEDIIGXC9xH6gDVyXx9tNvMlvFBVcwNTGsFlT8o=;
        b=betwUzad16mGXGcP9nf46FK+bVko8MyJlVQTWJAVn6m2Jb0AH/0WGsCVrS0/p8ut4f
         lHB6LFKbWZbZLhC2UNYUQ3Swz37i+TVvi0EqsAvaxVOD9MA9p77Yu3u4e9ICEemTVNff
         +LK8JtG4cNXcfvbG1fWDlZNK0t7hQoOIu9IRnC6Glo1Alk8AQAQepV1JEQn1AeEkBQ51
         XzIBcZf4WXIrzn500YlMbISlyAI0TTOc+kKgiajrYsQGsJ42qs+GqAOdWx1tkcyzq/sO
         TknQcOlqI2pUFDYPSyKX0toopiZ0DWCW1ZgnpBIau00wgovA87nYu3Sb10nNRH8DltA0
         Z2GA==
X-Gm-Message-State: ACgBeo12/weQV8YdWrbLf23b+0RaY9fFyLFqqP/O1Y+T8aJg8BUlH4r4
        IO/VpYIbHOb+JO78+UyU/oG+qw==
X-Google-Smtp-Source: AA6agR6gQ+XKG9WnD1Egvsc/rharC48iFH30b/b5dVa5FV92x+Yzx8Mw6iufbgjaFQgKdjw6L/VD1A==
X-Received: by 2002:a17:90a:c205:b0:1f5:1041:a4ff with SMTP id e5-20020a17090ac20500b001f51041a4ffmr27663272pjt.14.1659947783841;
        Mon, 08 Aug 2022 01:36:23 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([223.104.210.24])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b0016c0eb202a5sm8144196plx.225.2022.08.08.01.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 01:36:23 -0700 (PDT)
Date:   Mon, 8 Aug 2022 16:36:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: perf recording with java runtime broken with commit 2d86612aacb7
Message-ID: <20220808083618.GA35313@leoy-ThinkPad-X240s>
References: <defae7d2-5f3e-5de1-bcd0-f7ee7871a9f9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <defae7d2-5f3e-5de1-bcd0-f7ee7871a9f9@linux.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Thomas,

On Mon, Aug 08, 2022 at 10:28:13AM +0200, Thomas Richter wrote:
> Commit 2d86612aacb7 ("perf symbol: Correct address for bss symbols")
> brakes perf performance measurement for Java runtimes.
> 
> I have a java test program which calculates fractions repeatedly
> for several seconds. It is named j_fac1.java and j_fac2.java
> and has a class named j_fac2_run() which does the calculation
> in a long running loop.
> 
> I do the following steps:
> 1. Execute Java program j_fac1 which does some calculation:
>    # perf record -k mono  -- java -XX:+PreserveFramePointer \
>         -agentpath:/usr/lib64/libperf-jvmti.so j_fac1 1000 123456789
> 
> 2. Get the JIT'ted data with
>    # perf inject --jit -i perf.data > /tmp/perf-jit
> 
> 3. Display the contents of the JIT'ted data with:
>    # perf report -i /tmp/perf-jit | fgrep 'j_fac2.j_fac2_run()'
>     94.52%  java             jitted-28128-319.so  [.] j_fac2.j_fac2_run()
>      0.10%  java             jitted-28128-317.so  [.] j_fac2.j_fac2_run()
>    #
> 
> This procedure works fine until above mentioned commit.
> With above commit applied, the step 3 reproduces this result:
>  #  perf report -i /tmp/perf-jit | fgrep 'j_fac2.j_fac2_run()'
>  dso__load_sym_internal: failed to find program header for symbol:
>         _etext st_value: 0x223d0
>  dso__load_sym_internal: failed to find program header for symbol:
>         Interpreter st_value: 0x40
>  dso__load_sym_internal: failed to find program header for symbol:
>         Lj_fac2;j_fac2_run()D st_value: 0x40
>  dso__load_sym_internal: failed to find program header for symbol:
>         Lj_fac2;j_fac2_run()D st_value: 0x40
>  #
> 
> I see this behavior on s390. I have no machine to test it on x86.
> I have identified this patch using git bisect on the latest linux
> master branch.

Ian has committed a patch "perf symbol: Fail to read phdr workaround" to
address java JIT symbol issue:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=6d518ac7be6223811ab947897273b1bbef846180

Could you confirm if have included this patch in your code base?

Thanks,
Leo
