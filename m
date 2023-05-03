Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3732C77B7F
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 May 2023 17:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjECRQs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 May 2023 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjECRQr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 May 2023 13:16:47 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE11140FA
        for <linux-perf-users@vger.kernel.org>; Wed,  3 May 2023 10:16:39 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33164ec77ccso120955ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 May 2023 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683134199; x=1685726199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hTF/f5W7mfhVcIgHt1rtu4BQKXkWNpqlFd5KseezRg=;
        b=xPQ37BEIl/tb3mZYi/MgDlp7F++MBNnSq6R2tLfSlo+brHoyfTjpqdxqW7mXeAofUG
         iSSdKCaoSwmtDN2ovf/MQgupDgyBI6GpuDSKON5wCOvF8VHe+S3M1EbESa00FEhhlxUo
         J1ZSVWsu9hZ8aNT2VlbtLucMWuerP/WYoyIMevRlarweob6j2e3B+vU/1Rn7LHdESiaZ
         PyWfA3axGuabIJX68kYm4/9G894KYAWQXICg0z7CB06tNsOAiAxQRgIsvoYZtTT++XDQ
         7HbfBRjLVjzttHkJkHyP0y3oip+DWWq4Div9GpaYkQS2yyP/97AKVzjwxpiyhjupgSIU
         dm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683134199; x=1685726199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hTF/f5W7mfhVcIgHt1rtu4BQKXkWNpqlFd5KseezRg=;
        b=h6AMjhAUO88DFMU4mKcQHbi4/4al7WUtuO322cEnsdnTZeBveQEi59+fJHDqIjywDt
         BMna4hkUg2luJzNqdr35Ene8jIDdZQIcV8fYYPLPLrlWIG84wSLQExNajeVc7uLrKfuf
         h84XoHHyGk/Kys4kIRX3d4Kvcc/KJekkpK+fBszJjTyxM9Gh6mEA9HAGTHu0CYynP1Ks
         nrcWao4tfow48CRK6HQi0gMdP6+Q8KKaHjumguNEIaH1eeQ2zKrSZY3wxicruiWUJ8XI
         fr0d8Us+BfakJCV3B5u1PwIR9cPbLddmYPhkC7tk0SCOWxO1TPFdRQzdj7NK4e1PS6EW
         0fYg==
X-Gm-Message-State: AC+VfDwzDIHCSJXPS29/PeTPC/3NFl49l4UwSXm38ZSiyjRRKiob9bWB
        VnRUAdxdGr+A7GH83T1Fal9ET3vjewI+Qj3Kt8jMkg==
X-Google-Smtp-Source: ACHHUZ5ArHdDqvETOAHPW/PSJlKZ2gSYno2r8SpqcRkHPNaNBE4NgclTgDUti4HHkkV3AOKuV7GsH+nNb/D8BBdigas=
X-Received: by 2002:a05:6e02:1569:b0:32a:db6c:d4f3 with SMTP id
 k9-20020a056e02156900b0032adb6cd4f3mr400922ilu.10.1683134198851; Wed, 03 May
 2023 10:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230502203135.24794-1-jinli.xiao@nyu.edu> <CAP-5=fV-RZGwcM8+dMCsqwK_1aFERrvQ1sLJfUCA+kBFMEdoDw@mail.gmail.com>
 <CAExMFzgmcQqnVSBj9+YVr2UAkUg8CHdpLjQJF6CuOaWdcMbqDQ@mail.gmail.com>
In-Reply-To: <CAExMFzgmcQqnVSBj9+YVr2UAkUg8CHdpLjQJF6CuOaWdcMbqDQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 May 2023 10:16:27 -0700
Message-ID: <CAP-5=fWy5AztcN3MZyiNcSkbpdNws0cevarfYwt0TWqhyf3eEw@mail.gmail.com>
Subject: Re: [PATCH] perf python: Set error messages on call failure
To:     Jinli Xiao <jinli.xiao@nyu.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 2, 2023 at 7:27=E2=80=AFPM Jinli Xiao <jinli.xiao@nyu.edu> wrot=
e:
>
> Thanks for the prompt response!
>
> On Tue, May 2, 2023 at 4:37=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Nice! Would it be possible to test this? We could do a shell test
>
> All my changes in this patch is just setting the error message that
> can be interpreted by Python just before the bindings return.
>
> I am not sure about shell test, but I can do something like
>
> [root@nyu-lexis linux]# export PYTHONPATH=3D~jinli/linux/tools/perf/pytho=
n/
> [root@nyu-lexis linux]# python3
> Python 3.11.2 (main, Feb  8 2023, 00:00:00) [GCC 12.2.1 20221121 (Red
> Hat 12.2.1-4)] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> import perf
> >>> thread_map =3D perf.thread_map(9999)   # a non-existent pid in /proc
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> FileNotFoundError: [Errno 2] No such file or directory
>
> whereas the original output is
>
> >>> thread_map =3D perf.thread_map(9999)
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> SystemError: <class 'perf.thread_map'> returned NULL without setting
> an exception
>
> Upon testing I did find some of the changes unnecessary. I will submit
> a new patch to this.
>
> This is my first time contributing so please let me know if I did
> anything wrong :)

Everything is good with your patch. I'm keen that we try to make sure
we have coverage with tests. We have other shell tests that run
python:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/tests/shell/stat+json_output.sh?h=3Dperf-tools-next
So I wonder we can start doing what you did in your example and then
just assert we get a FileNotFoundError in the python. The shell script
is really just a way to run the python and can follow the example in
the link. Sound good?

Thanks,
Ian

> Best wishes,
> Jinli
