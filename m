Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE6AC77B7C
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 May 2023 00:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjEKAF0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 20:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjEKAFZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 20:05:25 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4135535B8
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 17:05:24 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f396606ab0so639771cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 17:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683763523; x=1686355523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+8v3lTv3eF3gAbNNLwTPhgtj58/fhMScKy6E6vydYY=;
        b=aMcDZUw0oCpo9YRfCyBmegSHoivLcGDyBQ95VKOwStftMp00spJ/rpKinhF0FqlPlu
         ilR9IK1aCi9UjAsQ+Q2eWToQA6JL22VGPrw+asP9JeTMcPayE+NLAlFzMfCv6pKorG+R
         OjaTgy3sRggnDiVxBFZ02IoPMbiQwH7gcM3wZXsMTveKTwV0H9R7Dwm86v6AgLpcg37/
         TyIne6pn5O5VHSHbg1LMvWbgBwiPYICaiPT2N66uvCPsUyxCO7gBDGNBvk9U/FK8ADcA
         gvkuYutnq3h3nl9G97QpvnTGJ/hRlwZWSNV+ZtvMjsIwVtioszi0AjuJAxmUn3SsrmRe
         VXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683763523; x=1686355523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+8v3lTv3eF3gAbNNLwTPhgtj58/fhMScKy6E6vydYY=;
        b=ToA22M6Rovb6/20arN9R8shTIe6NsJPMNL4hs75wGjTTMOn8fSYCqJc9sHhPL8Csoj
         ErfCiwONCBJjrEHkKQ+SYjwdGIXwuhw2LN9oBybHBdgJv1+oUnQ6gi7rju01rSYcfcsk
         9Y9mD2/KTxz518mZZ0+Pe0fU3VQEJKG0CmQTSif3H5sf1ooUfYDoZBFgIJun/vP+SOpA
         mDqR3TVc8GVpIl5Azs3A9MvzFpI9g2JgfHA8XXIrMD2Iu6on8Ye1W+T5MOk2q+wwc7Ta
         1RnIuA+25Vd5kOpmbwU6fYrcUGkiH0yO0HHlbAz79g5wnJYNuBIFmdtfwQxqD/MZ6W7t
         Vtkw==
X-Gm-Message-State: AC+VfDx6gvlRszPD5BMyxr9h18ofw5AirXN4LvQNlm+mMziL8NyNwkwC
        nSy/IVjbiuew8sgk+2Ho7xZu6bxYcETUk4TW3B24JKAU26Ke0IGmcPw=
X-Google-Smtp-Source: ACHHUZ6NYpikewAqy/KBFgbWhK3AZyUBaYd3J3XrlZ2EqmW2eDx5O3EzAwGdaB9COrOAA1Z9CgDhjPjVb+0CFzGaNDo=
X-Received: by 2002:ac8:5a10:0:b0:3de:1aaa:42f5 with SMTP id
 n16-20020ac85a10000000b003de1aaa42f5mr69541qta.15.1683763523237; Wed, 10 May
 2023 17:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230506021450.3499232-1-irogers@google.com> <ZFvVvp0tYqxHWFsB@kernel.org>
In-Reply-To: <ZFvVvp0tYqxHWFsB@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 May 2023 17:05:09 -0700
Message-ID: <CAP-5=fVmFRxD1=3pX5yG_T=a=_pnU-OtXbNLnwMmTxjHv2itgw@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Add system include paths to BPF builds
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <songliubraving@meta.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 10, 2023 at 10:35=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, May 05, 2023 at 07:14:50PM -0700, Ian Rogers escreveu:
> > There are insufficient headers in tools/include to satisfy building
> > BPF programs and their header dependencies. Add the system include
> > paths from the non-BPF clang compile so that these headers can be
> > found.
> >
> > This code was taken from:
> > tools/testing/selftests/bpf/Makefile
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Makefile.perf | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 61c33d100b2b..37befdfa8ac8 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1057,7 +1057,25 @@ $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT=
) $(LIBPERF_OUTPUT) $(LIBSUBCMD_
> >
> >  ifndef NO_BPF_SKEL
>
> So this patch was done before the reverts, I adjusted it to what is
> upstream and to another patch that makes the build use the headers from
> the perf sources instead of the system's (linux/bpf.h and
> linux/perf_event.h, from vmlinux.h), please take a look at the patch
> below, I'm also trying to figure out that other problem you pointed with
> linux/types.s :-\
>
> What I have now in tmp.perf-tools:
>
> =E2=AC=A2[acme@toolbox perf-tools]$ git log --oneline torvalds/master..
> a2af0f6b8ef7ea40 (HEAD -> perf-tools) perf build: Add system include path=
s to BPF builds
> 5be6cecda0802f23 perf bpf skels: Make vmlinux.h use bpf.h and perf_event.=
h in source directory
> 7d161165d9072dcb perf parse-events: Do not break up AUX event group
> a468085011ea8bba perf test test_intel_pt.sh: Test sample mode with event =
with PMU name
> 123361659fa405de perf evsel: Modify group pmu name for software events
> 34e82891d995ab89 tools arch x86: Sync the msr-index.h copy with the kerne=
l sources
> 705049ca4f5b7b00 tools headers kvm: Sync uapi/{asm/linux} kvm.h headers w=
ith the kernel sources
> 8d6a41c8065e1120 tools include UAPI: Sync the sound/asound.h copy with th=
e kernel sources
> 92b8e61e88351091 tools headers UAPI: Sync the linux/const.h with the kern=
el headers
> e7ec3a249c38a9c9 tools headers UAPI: Sync the i915_drm.h with the kernel =
sources
> e6232180e524e112 tools headers UAPI: Sync the drm/drm.h with the kernel s=
ources
> 5d1ac59ff7445e51 tools headers UAPI: Sync the linux/in.h with the kernel =
sources
> b0618f38e2ab8ce3 perf build: Gracefully fail the build if BUILD_BPF_SKEL=
=3D1 is specified and clang isn't available
> 5f0b89e632ed81b6 perf test java symbol: Remove needless debuginfod querie=
s
> 327daf34554d20a6 perf parse-events: Don't reorder ungrouped events by PMU
> ccc66c6092802d68 perf metric: JSON flag to not group events if gathering =
a metric group
> 1b114824106ca468 perf stat: Introduce skippable evsels
> 2a939c8695035b11 perf metric: Change divide by zero and !support events b=
ehavior
> =E2=AC=A2[acme@toolbox perf-tools]$
>
> Please help me test this,

build-test and compiling with/without BPF skeletons looked okay in
perf test on my Debian derived distro.

Thanks,
Ian

> Regards,
>
> - Arnaldo
>
>
