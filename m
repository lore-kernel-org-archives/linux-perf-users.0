Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D59C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 May 2022 04:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiECEgy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 May 2022 00:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiECEgx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 May 2022 00:36:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14DE3DA44
        for <linux-perf-users@vger.kernel.org>; Mon,  2 May 2022 21:33:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i5so21777934wrc.13
        for <linux-perf-users@vger.kernel.org>; Mon, 02 May 2022 21:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T6JzwNU5N6ZQgsg3vBp+2Ps84bl0FUHxkZcdsFZWCew=;
        b=jzsEdxhF/8w8wSglh4N86LdZ1hFAd8qUpWLlP3fvRA9AnGlCoxQSyxgGiuUaYnOlII
         qD9bVFvxYSlAT4jBHNuZRxh8r7D8CqoT/nAavK7r97L/nPRtilE9EBZN5tLqfP5ATeE/
         CGy0NDu5uGMrn5lm4vvXwhhCj33rK6fNBXVFT8k4ifxjeYI2cojpbkJetBCOjZmGhfHH
         K1AvCC5hTcqcQNqlW9XRs6HnScGAZ5r0XwIJZBi/ilfmoV+3IZGPEjgFzUpXzoZBgK7k
         8tAFuJ+8uS1/xzD647eLM0ie2SVRUUAL7Gi7J7KXAsODq3yddcU6+1LdLUgOqukm0Ely
         DBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T6JzwNU5N6ZQgsg3vBp+2Ps84bl0FUHxkZcdsFZWCew=;
        b=cBB6JuZJCfHz7vLhmK40SwJhkunteKbEPHo4IIkQ5/CWkjnYRnVgf5HIIJ1KTo3EYj
         EhNOP83c/VZdkXymFQuZZxa4OcYQcgNjTv0oTNXrGTVlpP56x/GvXS3DKwqH+mO3qKBc
         UaAqxEcHb99lPw/6JjAU+cYaNf8HG3f2gPTzldugIMfE9fdn7rof7bkDHZXbB0DCGbFJ
         VJWR7XOMsWJWl2lDWoDpV9nVtF47MNF5yTOC3ExWvdglQo9eVlMkdK06ulLeJAfIwJjY
         E/qwJ8g0BtFY77an0ULNsio2NGtvr+U2rVWteX7dlZKClMOQbaVgzHv2Qf3RdWjE7HRA
         xn1w==
X-Gm-Message-State: AOAM5301TCdU4nz2co7x8Wcka8+9GzlnsRIqylnu/JdSqFrEdQ+DYfMq
        68erclL8Dy+0hRyP/Oxxwh5tOJlIs+AIHTfOcZ5lKQ==
X-Google-Smtp-Source: ABdhPJz8nC07LYK1GNCpXh+O4YgAirf6NWITWfuhN7M/tAmrimRnfBMks4TDgEOzGNDBUGgi6MKcHdMmd5BbkQcVnlQ=
X-Received: by 2002:adf:dc0f:0:b0:207:9980:5de8 with SMTP id
 t15-20020adfdc0f000000b0020799805de8mr11196700wri.300.1651552399252; Mon, 02
 May 2022 21:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220429061336.1184848-1-irogers@google.com> <d36e7dc7-e063-365f-2bf4-8cac590b5802@linux.ibm.com>
In-Reply-To: <d36e7dc7-e063-365f-2bf4-8cac590b5802@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 2 May 2022 21:33:05 -0700
Message-ID: <CAP-5=fU8+QOeZjL=DMgwwQeJiKqnKw28eF=0m1kmp8C7Mwfz+Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add skip to --per-thread test
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 2, 2022 at 2:39 AM Thomas Richter <tmricht@linux.ibm.com> wrote=
:
>
> On 4/29/22 08:13, Ian Rogers wrote:
> > As reported in:
> > https://lore.kernel.org/linux-perf-users/20220428122821.3652015-1-tmric=
ht@linux.ibm.com/
> > the 'instructions:u' event may not be supported. Add a skip using 'perf
> > stat'.
> >
> > Switch some code away from pipe to make the failures clearer.
> >
> > Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/record.sh | 44 +++++++++++++++++++++++++++++---
> >  1 file changed, 41 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/=
record.sh
> > index cd1cf14259b8..efc0cb07a929 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -5,11 +5,43 @@
> >  set -e
> >
> >  err=3D0
> > +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > +
> > +cleanup() {
> > +  rm -f ${perfdata}
> > +  rm -f ${perfdata}.old
> > +  trap - exit term int
> > +}
> > +
> > +trap_cleanup() {
> > +  cleanup
> > +  exit 1
> > +}
> > +trap trap_cleanup exit term int
> > +
> >  test_per_thread() {
> >    echo "Basic --per-thread mode test"
> > -  perf record -e instructions:u --per-thread -o- true 2> /dev/null \
> > -    | perf report -i- -q \
> > -    | egrep -q true
> > +  if ! perf stat -e instructions:u --quiet true
> > +  then
> > +    echo "Per-thread record [Skipped instructions:u not supported]"
> > +    if [ $err -ne 1 ]
> > +    then
> > +      err=3D2
> > +    fi
> > +    return
> > +  fi
> > +  if ! perf record -e instructions:u --per-thread -o ${perfdata} true =
2> /dev/null
> > +  then
> > +    echo "Per-thread record of instructions:u [Failed]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  if ! perf report -i ${perfdata} -q | egrep -q true
> > +  then
> > +    echo "Per-thread record [Failed missing output]"
> > +    err=3D1
> > +    return
> > +  fi
> >    echo "Basic --per-thread mode test [Success]"
> >  }
> >
> > @@ -18,6 +50,10 @@ test_register_capture() {
> >    if ! perf list | egrep -q 'br_inst_retired.near_call'
> >    then
> >      echo "Register capture test [Skipped missing instruction]"
> > +    if [ $err -ne 1 ]
> > +    then
> > +      err=3D2
> > +    fi
> >      return
> >    fi
> >    if ! perf record --intr-regs=3D\? 2>&1 | egrep -q 'available registe=
rs: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> > @@ -39,4 +75,6 @@ test_register_capture() {
> >
> >  test_per_thread
> >  test_register_capture
> > +
> > +cleanup
> >  exit $err
>
> Ian,
>
> thanks very much for looking into this.
> I have tested your patch on several configurations and to be perfect, ple=
ase
> change this line:
> # git diff
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index efc0cb07a929..9cb8494f314d 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -21,7 +21,7 @@ trap trap_cleanup exit term int
>
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> -  if ! perf stat -e instructions:u --quiet true
> +  if ! perf record -e instructions:u --quiet true 2> /dev/null
>    then
>      echo "Per-thread record [Skipped instructions:u not supported]"
>      if [ $err -ne 1 ]
> #
>
> This runs fine, just use record instead of stat, you use perf record late=
r
> on anyway.
>
> With this change you have my
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks! Done, but I also add a '-o' in v2 so the perf.data file is
cleaned up by the cleanup function.

Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
