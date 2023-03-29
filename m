Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD63C74A5B
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Mar 2023 16:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjC2QzC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Mar 2023 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjC2QzB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Mar 2023 12:55:01 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843304C33
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Mar 2023 09:54:54 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3e0965f70ecso343701cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Mar 2023 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680108893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mmMTcKbNFZJ+ADW94MCmFYakixmyIY5T+sGgFQVqJY=;
        b=EcvUtO42jTnqBkvpZAcPDRX1B/EBgeIHIvGlYQxBY9ZpicDaqou6cUmnVTgvVlrkuT
         34nkDwRTApfZRQfmmpXskr3uYUE3mfpGxAAolVUJxfAP3MYo9aFBD2kDCVpUwe7mt+bY
         agwP1g9K5cHbZldk8q82nVJkXZwLdLl+Yo+zmFryh42iqo2u61fy1gqnWYo1CW2vx7zG
         V3pBuL3iZiTrxZSk1nCdqEAb2T8su9Pl5+fmoyj9INWPh5VgvnRRCJD3KS88j2HXTFuQ
         vyGAUsDslmzrJwu765Hv54PjFJdloMIn+Iz0lRb96Oz9rEvgegkhtCA1ThQDmXg0wAeU
         taEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680108893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mmMTcKbNFZJ+ADW94MCmFYakixmyIY5T+sGgFQVqJY=;
        b=llOLTILUvgTWJhv2ijP/ZSQTF8FjBRftU5wtZ6t69EunSaFargmRoPzRbAxrAwFCUL
         t4ZwjxutCu4/INnTsGvjbZwRvclHISXXOR2Ho7ocVfrK4vnzmtMwN6uj6vI+x5rwhQXT
         WubSg0Sy7DjGczwAjn1vTQC7TE+sLJFFVaLlWUfjH0C15/7YG+dcMO5ATHTvNz+5606f
         dBnRv72BIj5sZvsaTIxXBGe+PG/IjOfPH+GE5YKO4bu35o+plATbe6eGCnjiEAOqM5QR
         ZIQBO/9oi+x8M71iLrSqswRKa1LyyxbEtqac9zAtlby+UqbRTSjhXmwSCQmLkdJWvQU8
         Ugcw==
X-Gm-Message-State: AAQBX9fuuj3l6iMGUXbqC8VANuWplcY0v7A4AYpQWwXPW4ViUY8ZEgpl
        GNNZslieWaWPtUltDgqZZSADDyvswLWplI+5qAY9XOzY08pqdBJO6mRCiQ==
X-Google-Smtp-Source: AKy350aZEuGOkGAUo3/PlvmvlZZ+e7ire4m+tofzP4fSUzLBgqwscgupalCGJKg/ccutDUs+9sYPCXIF0zSlFtAKH3c=
X-Received: by 2002:ac8:5916:0:b0:3e3:86d0:4f02 with SMTP id
 22-20020ac85916000000b003e386d04f02mr368594qty.11.1680108893525; Wed, 29 Mar
 2023 09:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <202303222158.8975b36d-oliver.sang@intel.com> <CAP-5=fV3x_=6JqVsX8Z_+5bz67de_5JcWX-1B=So18wpMK3r=A@mail.gmail.com>
 <ZCPX5bYv0zK+/a6u@xsang-OptiPlex-9020>
In-Reply-To: <ZCPX5bYv0zK+/a6u@xsang-OptiPlex-9020>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Mar 2023 09:54:39 -0700
Message-ID: <CAP-5=fVV-3jYnJsrLZjqoJz3DzmT4b5t==Y3joC0NHgpz-qp-w@mail.gmail.com>
Subject: Re: [acme:tmp.perf-tools-next] [perf build] a980755beb: perf-sanity-tests.perf.make.fail
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andres Freund <andres@anarazel.de>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tom Rix <trix@redhat.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 28, 2023 at 11:17=E2=80=AFPM Oliver Sang <oliver.sang@intel.com=
> wrote:
>
> hi Ian,
>
> On Wed, Mar 22, 2023 at 09:03:28AM -0700, Ian Rogers wrote:
> > On Wed, Mar 22, 2023 at 7:20=E2=80=AFAM kernel test robot <oliver.sang@=
intel.com> wrote:
> > >
> > >
> > > Greeting,
> > >
> > > FYI, we noticed perf-sanity-tests.perf.make.fail due to commit (built=
 with gcc-11):
> > >
> > > commit: a980755beb5aca9002e1c95ba519b83a44242b5b ("perf build: Make B=
UILD_BPF_SKEL default, rename to NO_BPF_SKEL")
> > > https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git tmp.perf-=
tools-next
> > >
> > > in testcase: perf-sanity-tests
> > > version: perf-x86_64-e8d018dd0257-1_20230320
> > > with following parameters:
> > >
> > >         perf_compiler: clang
> > >
> > > [   98.290078][  T246] make perf failed
> >
> > Hi Oliver,
> >
> > Could we add NO_BPF_SKEL=3D1 to the build flags? The idea with changing
> > the default is that is what most users want and so we want the BPF
> > skeleton to be opt-out rather than opt-in.
>
> Thanks a lot for guidance!
>
> I added NO_BPF_SKEL=3D1 then make perf can pass upon this commit.
> I also tried to add BUILD_BPF_SKEL=3D1 while make perf for parent, it wil=
l fail.
>
> since you said in commit message
> "BPF skeleton support is now key to a number of perf features."
> we will start to fix make issue.
>
> Thanks!

This is great Oliver, many thanks!
Ian

> >
> > Thanks,
> > Ian
> >
> > >
> > > To reproduce:
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         sudo bin/lkp install job.yaml           # job file is attache=
d in this email
> > >         bin/lkp split-job --compatible job.yaml # generate the yaml f=
ile for lkp run
> > >         sudo bin/lkp run generated-yaml-file
> > >
> > >         # if come across any failure that blocks the test,
> > >         # please remove ~/.lkp and /lkp dir to run from a clean state=
.
> > >
> > >
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests
> > >
> > >
> >
