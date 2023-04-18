Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350ECC77B75
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Apr 2023 15:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjDRPwt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Apr 2023 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjDRPws (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Apr 2023 11:52:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753FD118E9
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Apr 2023 08:52:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso56945e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Apr 2023 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681833127; x=1684425127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8AJaTAL1L9nuKjca6IxxV5WvVoR66rW4VK9cQe2Its=;
        b=tTcxcgjXlPWgzp12LZaqONOFzAR3OnpA3nO76yp8jFzJbuUPTK1q2eltwV+GHv5njp
         KXbQKIVukbWVhlHPwNqFX3EpwW8Tck5Jw2F3sR3tcJp/dxBi5hffPf3hzyAUDNwJbv5a
         bGTmLxVmrDQTO+SH4kA6abnLsm2AqrSzesC1K6DqG9cWa33EKt2cCePnIMEd7q2tf2qL
         BjBiC4N4095m6+jS5w/Cfp60CN2bLsALrREmHoCvn3n9BciNxeVxk3my1D4+NZG0U0uP
         OzooP8ZfIAEM0jqIHqKKBCcamDbtMWs2q3/+3PAWSmlKbv/dJUXNiYd3YDToa9v1wvm6
         02xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833127; x=1684425127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8AJaTAL1L9nuKjca6IxxV5WvVoR66rW4VK9cQe2Its=;
        b=dFzlyorNb2aPFDEaQoXREolqINGFUiFUTqqXfcE2v0XftEuaMWNINHL/DOyTDtdVK7
         5Kt/Y8W4UYeiKrwZ/myEF8nvZORpbbsdRkkTsh91yCPSRaXEDSUH2b9toMzV6EBHkVak
         WES6f1f+Sa2bWOVMV0/uxve2RGhZxe84f/V/UvDuo079y8s1r+y/efIK0n2TjnPgbDbj
         sMO7mw08lPfqIB48JCnxVvjecQsVfhmC/sOlFkOQVM42svBKNG0lkjCvcB7WeZ1CMcsv
         TmEL2oZgVg1zepbR3b8u4M0ZFNH0nFcMMAbutjt9EeZwHIraolYyaONZENzsxuy/JlfG
         iSEQ==
X-Gm-Message-State: AAQBX9dAuo1SU+ADvw5Tb8z09Q6AjgT+1H3G34wg1yEs3SybmAOYBAIP
        37Om2u8VrArYuxVGhSs6tSNVdj8uP9+mjpk1OzTn0w==
X-Google-Smtp-Source: AKy350ZpV2IOebxfwF+HpsSE5r6eITnamp/nMwc0jszxYZEFirHdz3lgJ7MEkiCa9WdNhzir5KAOB4hulRMOuRJfOes=
X-Received: by 2002:a05:600c:19cc:b0:3f1:758c:dd23 with SMTP id
 u12-20020a05600c19cc00b003f1758cdd23mr170026wmq.7.1681833127265; Tue, 18 Apr
 2023 08:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230414082300.34798-1-adrian.hunter@intel.com>
 <20230417110221.GH83892@hirez.programming.kicks-ass.net> <89733d35-0b71-615f-4fb8-55183585c67a@intel.com>
 <d7d6cbc8-1f5f-d0f4-6656-f0cc8ab3a118@intel.com>
In-Reply-To: <d7d6cbc8-1f5f-d0f4-6656-f0cc8ab3a118@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 Apr 2023 08:51:52 -0700
Message-ID: <CAP-5=fWjyvsFuQhPNQyoa1ExTo4yggKRrmaksuatwU29v0uNXA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] perf: Add ioctl to emit sideband events
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Apr 18, 2023 at 6:36=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 18/04/23 09:18, Adrian Hunter wrote:
> > On 17/04/23 14:02, Peter Zijlstra wrote:
> >> On Fri, Apr 14, 2023 at 11:22:55AM +0300, Adrian Hunter wrote:
> >>> Hi
> >>>
> >>> Here is a stab at adding an ioctl for sideband events.
> >>>
> >>> This is to overcome races when reading the same information
> >>> from /proc.
> >>
> >> What races? Are you talking about reading old state in /proc the kerne=
l
> >> delivering a sideband event for the new state, and then you writing th=
e
> >> old state out?
> >>
> >> Surely that's something perf tool can fix without kernel changes?
> >
> > Yes, and it was a bit of a brain fart not to realise that.
> >
> > There may still be corner cases, where different kinds of events are
> > interdependent, perhaps NAMESPACES events vs MMAP events could
> > have ordering issues.
> >
> > Putting that aside, the ioctl may be quicker than reading from
> > /proc.  I could get some numbers and see what people think.
> >
>
> Here's a result with a quick hack to use the ioctl but without
> handling the buffer becoming full (hence the -m4M)
>
> # ps -e | wc -l
> 1171
> # perf.old stat -- perf.old record -o old.data --namespaces -a true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.095 MB old.data (100 samples) ]
>
>  Performance counter stats for 'perf.old record -o old.data --namespaces =
-a true':
>
>             498.15 msec task-clock                       #    0.987 CPUs =
utilized
>                126      context-switches                 #  252.935 /sec
>                 64      cpu-migrations                   #  128.475 /sec
>               4396      page-faults                      #    8.825 K/sec
>         1927096347      cycles                           #    3.868 GHz
>         4563059399      instructions                     #    2.37  insn =
per cycle
>          914232559      branches                         #    1.835 G/sec
>            6618052      branch-misses                    #    0.72% of al=
l branches
>         9633787105      slots                            #   19.339 G/sec
>         4394300990      topdown-retiring                 #     38.8% Reti=
ring
>         3693815286      topdown-bad-spec                 #     32.6% Bad =
Speculation
>         1692356927      topdown-fe-bound                 #     14.9% Fron=
tend Bound
>         1544151518      topdown-be-bound                 #     13.6% Back=
end Bound
>
>        0.504636742 seconds time elapsed
>
>        0.158237000 seconds user
>        0.340625000 seconds sys
>
> # perf.old stat -- perf.new record -o new.data -m4M --namespaces -a true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.095 MB new.data (103 samples) ]
>
>  Performance counter stats for 'perf.new record -o new.data -m4M --namesp=
aces -a true':
>
>             386.61 msec task-clock                       #    0.988 CPUs =
utilized
>                100      context-switches                 #  258.658 /sec
>                 65      cpu-migrations                   #  168.128 /sec
>               4935      page-faults                      #   12.765 K/sec
>         1495905137      cycles                           #    3.869 GHz
>         3647660473      instructions                     #    2.44  insn =
per cycle
>          735822370      branches                         #    1.903 G/sec
>            5765668      branch-misses                    #    0.78% of al=
l branches
>         7477722620      slots                            #   19.342 G/sec
>         3415835954      topdown-retiring                 #     39.5% Reti=
ring
>         2748625759      topdown-bad-spec                 #     31.8% Bad =
Speculation
>         1221594670      topdown-fe-bound                 #     14.1% Fron=
tend Bound
>         1256150733      topdown-be-bound                 #     14.5% Back=
end Bound
>
>        0.391472763 seconds time elapsed
>
>        0.141207000 seconds user
>        0.246277000 seconds sys
>
> # ls -lh old.data
> -rw------- 1 root root 1.2M Apr 18 13:19 old.data
> # ls -lh new.data
> -rw------- 1 root root 1.2M Apr 18 13:19 new.data
> #

Cool, so the headline is a ~20% or 1billion instruction reduction in
perf startup overhead?

Thanks,
Ian
