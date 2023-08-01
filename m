Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162A5C0015E
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Aug 2023 21:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjHAVrz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Aug 2023 17:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjHAVry (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2023 17:47:54 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656461BE3
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Aug 2023 14:47:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40c72caec5cso99581cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Aug 2023 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690926472; x=1691531272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PbA9v4F/wRUABSfNCsKF/Y95U0K3jFhfUUpxSb83mo=;
        b=VeysAaIkkm4ytJphXyoHB4sosx542KfcJmzXHs5pe3Wtco5Gxk2s74/iX4iSQaGR82
         k1RpDd5EYtA+jErvn9HmxaAI/QiZhEYV6AF5F6Zg7/SIWmCnEIbn1jQEUNS9iDAO70ad
         KODCSkhRS8T5JXVScX1bF+6UZ+owcfdvo95VA8/ByuHM/JFzRJtc6v3VXKsP9i3ORS9o
         UcH1LsHCb2s1B4bqzyU1lR76Lj81eeHx4t3QaOC9WCF77Vnrdlw1xs6tB0O+9JPmfc5Y
         u9etNbuQXsOqaDNhbLcIwAbJhA9Zvg8eTH1v/Ne74JAaM7w/ty79LHgc0WW8V3Tgmm9D
         WhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690926472; x=1691531272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PbA9v4F/wRUABSfNCsKF/Y95U0K3jFhfUUpxSb83mo=;
        b=MVJi6Rc+FRdQAVniOoHXFz2TEB1wsyu3Z1MTsmD0eJbeq6+6xNLM0Jacf3VlC6hjVI
         nsAUM8FMTw5Opu/IFVlXGeJu6a6gVG6oucWi+E/zyxKJXN4KAAdTCHoxbzGlHii8FSFd
         WwQDeR4r5XP3Y2AvK1f4RQd1Oq3gzoFJ5gkEd8ZLQ1YUVd1rAtWYaQOUKV8QWcNs8ERV
         Gezt+dpkQDUxvoyocAgy3RnYwWFrrWF9gsntUZMy/uACWwZ/Scbze2dwlgxgdPezXkDY
         MxBmveKD7LX2nVVTxEhSfZYR22M9xPUiWq9sORXiZ4Cm/Txth/ZR97fgFcmXWsXaBu5n
         OU4g==
X-Gm-Message-State: ABy/qLbE7pkWLLKMb2xEk2zv3Xh1mBz0Jy8jmHrYaQw2/ioHZEWHG99L
        VLjMd9zsW44W4EjOoR0YLK9pDkuF5AAxldjf0vbWuPCeSrzRaPb4AcogBg==
X-Google-Smtp-Source: APBJJlHc68qLtuaX35qfCq2zbyGhxp5iqrxeecf0B28WUBAWxDgsfmgxsPn0RXJR2R7VU88f3COPTQP6SlKAvuxzaUw=
X-Received: by 2002:ac8:598a:0:b0:403:ac9c:ac2f with SMTP id
 e10-20020ac8598a000000b00403ac9cac2fmr980233qte.17.1690926472462; Tue, 01 Aug
 2023 14:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <ZMlrzcVrVi1lTDmn@tassilo>
In-Reply-To: <ZMlrzcVrVi1lTDmn@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 1 Aug 2023 14:47:41 -0700
Message-ID: <CAP-5=fWrYmRAb2fvc+ratD6TPfHMHQFtugHWWc2YgNvp0bsSqA@mail.gmail.com>
Subject: Re: duration_time regression
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 1, 2023 at 1:32=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
>
> With recent perf duration_time output regressed:
>
> e.g. with an older version I get duration_time only once:
>
> % perf stat -e cycles,duration_time true
>
> CPU0                 190,925      cycles
> ... all the other CPUs printing cycles
> CPU0                5,047,008 ns   duration_time
>
>        0.005047008 seconds time elapsed
>
>
> with the current perf it is printed on all CPUs, but not counted on most
> of them:
>
> % perf stat -e cycles,duration_time true
>
> # started on Tue Aug  1 13:29:26 2023
>
>  Performance counter stats for 'system wide':
>
> CPU0               61,301      cycles
> ... print cycles for all CPUS ...
> CPU0            5,343,556 ns   duration_time
> CPU1        <not counted> ns   duration_time
> CPU2        <not counted> ns   duration_time
> CPU3        <not counted> ns   duration_time
> CPU4        <not counted> ns   duration_time
> ... repeat the same for all CPUs ...
>
> which is fairly useless.

Agreed, I sent out:
https://lore.kernel.org/lkml/20230801205452.3380578-1-irogers@google.com/

Thanks,
Ian

> -Andi
