Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF8C77B73
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jun 2023 19:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjFETOl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjFETOi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jun 2023 15:14:38 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1494C114
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jun 2023 12:14:34 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33d928a268eso31915ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jun 2023 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685992473; x=1688584473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyL91Ec69lqQv1cIeAH4Hob9qDym4MqPZUuyevd3R8g=;
        b=jXB+Z7R1bUy16bQtNnF/M7OCBmgsTgJcWjiLkVx5tWQwzvzZKrrREsGFh3FB60Zmc4
         mTKQG1kEgqW1xh9f6Gy81vr7OGZwCA33ZSSa3pziU4SQdXfur+Rn7K8jc9aCtWBsQwVQ
         bOLvWSWpx54SLeXlVgMcYqKiVMpimpSAO3fvop0uW6W79SPgRnGSxiPqtb6Db5HW26ou
         pTAQ7ZSJPgyQTRvrN79IUm83ANOvVmzKtSzBQIDieDH4QWEgFLXn9tNdqotHzF04MGyg
         0wwmeSGDvgZS2qz7plot8Kb+62nWwndGzYH+M2o1qlUjTdwq3sLN8Cc0khlaZ9rUATsl
         z88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685992473; x=1688584473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyL91Ec69lqQv1cIeAH4Hob9qDym4MqPZUuyevd3R8g=;
        b=fAskhChV07+DRWVaNtxIKCSyYpgVLywyI8pxePH7uqYazyYY5RPQFNBQc7lUX3TYz6
         NfMMWOnlr0Ro8F7xYmN5XFPe2chTINbssvtt+1vDhdRquYKAODxL7YBuo+TiSbAqyJ1f
         8CeygGeoAP4t0YJ2K3pyIN80Z9QJ9taaVtAavWomZWNO6eFCjC5JN+GlhawBfJvjTFoV
         nsg3088UKWPNZaWgGA+XVYZV9Rt8jRI0nYxDYZh/a5DgiTFFIZZTpldx/lLTl/8b1kfA
         YHQpeC7B1ED4c2gfvAZFpkZNPZnRrX0byWwVVwxszsLW2B+5tRl6C1Fky66/Gkyc8je5
         autA==
X-Gm-Message-State: AC+VfDy0cPhQYykJaFXD3A9TRa8+UFRLb2uZJ78wbhkUG2TUx8bgCtvP
        QFobWSWCrgVUSYQ03bPj99IxbeFVx9bep+RnQzOAyA==
X-Google-Smtp-Source: ACHHUZ6rYSRmEK2A9Buvh4btbinrCfMTRWuZimZRs3lS+f5OxIwk3+ZAurfM7dLslT7TFPLsqza3h46NyyJP9qDqyPw=
X-Received: by 2002:a05:6e02:17cb:b0:33d:6c0e:83c0 with SMTP id
 z11-20020a056e0217cb00b0033d6c0e83c0mr11732ilu.27.1685992473307; Mon, 05 Jun
 2023 12:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com> <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
 <CAP-5=fUj9eTGLDxEpc=Xp082O-mQ_4ALp=2VPFHCvAVq8gO-JQ@mail.gmail.com> <ZH4vru4zR8UlIdEN@kernel.org>
In-Reply-To: <ZH4vru4zR8UlIdEN@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 5 Jun 2023 12:14:21 -0700
Message-ID: <CAP-5=fVhMSBk0Q0az7O=OdXtfiktqdxg9GaXdjOFCPPSS25GZA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Bring back vmlinux.h generation
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 5, 2023 at 11:55=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jun 05, 2023 at 10:18:51AM -0700, Ian Rogers escreveu:
> > On Mon, May 22, 2023 at 4:35=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, May 22, 2023 at 1:41=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' t=
o
> > > > satisfy libbpf 'runqueue' type verification") inadvertently created=
 a
> > > > declaration of 'struct rq' that conflicted with a generated
> > > > vmlinux.h's:
> > > >
> > > > ```
> > > > util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of '=
rq'
> > > > struct rq {};
> > > >        ^
> > > > /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous d=
efinition is here
> > > > struct rq {
> > > >        ^
> > > > 1 error generated.
> > > > ```
> > > >
> > > > Fix the issue by moving the declaration to vmlinux.h. So this can't
> > > > happen again, bring back build support for generating vmlinux.h the=
n
> > > > add build tests.
> > > >
> > > > Ian Rogers (3):
> > > >   perf build: Add ability to build with a generated vmlinux.h
> > > >   perf bpf: Move the declaration of struct rq
> > > >   perf test: Add build tests for BUILD_BPF_SKEL
> > > >
> > > >  tools/perf/Makefile.config                       |  4 ++++
> > > >  tools/perf/Makefile.perf                         | 16 ++++++++++++=
+++-
> > > >  tools/perf/tests/make                            |  4 ++++
> > > >  tools/perf/util/bpf_skel/.gitignore              |  1 +
> > > >  tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
> > > >  tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h | 10 ++++++++++
> > > >  6 files changed, 34 insertions(+), 3 deletions(-)
> > > >  rename tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h (90%)
> > > >
> > > > --
> > > > 2.40.1.698.g37aff9b760-goog
> > > >
> > > >
> > >
> > > LGTM, for the series:
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Arnaldo, could we take this set?
>
> This one isn't applying right now on perf-tools-next.
>
> - Arnaldo

I'll rebase and resend.

Thanks,
Ian
