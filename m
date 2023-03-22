Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8339BC6FD1C
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Mar 2023 16:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCVQDr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCVQDq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2023 12:03:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE70076AA
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 09:03:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3d7aef37dccso91601cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679501023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu3i1BkHYZ7DUaI3A4JGGpOlbvqywmdO7N9J0ujAvoQ=;
        b=nJWxWdACVzPnsoMnbPPg0tfBFN0xZu1kwsA7/qrmkAIYeU//Cy8czxmgw+sgoK4T3x
         oPI/Zs5Jg+0sZGAudB/2dqxMRueO7IuhFbbl65+VeueefkkRl+BczpxHPKisNFEIW6tx
         OTCtErqOFc+uB3NXF3ssgR5aLHBgcy8urnBz0w6MFJMzPCgTw/I5xFMPtVYSSZHw7LEl
         JSVL6dYxPGyrSS67JV/Ib0hDhpbF04UJDYQBj/xij7K7ov/Tj3SqifofDfcJeGr2xX9N
         lFDWkYWNXJKoMTxS8EHhyBfNHPS0nywIk1TwYrt3nDa/93NfxzIXgBIaEXo0lPQMKDWZ
         UaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zu3i1BkHYZ7DUaI3A4JGGpOlbvqywmdO7N9J0ujAvoQ=;
        b=mByHZGqhOhe0MIOJJp8JfGv1m74jK6iQXG6RIhD8fFe7nfyuW26wdX/IKUKf9WUI+c
         DjRDmtIxDEHS4q9KFp/EDCOoYqp+vGYDVzoc2zzmDUFzFowj5BkF8JyicJirumqNY3AU
         OSoQQaRKi4EjBTd8hc/jNC4FGSCMp8HPrwdOmC+QXAIARcbNYqbUWwMkuMbnPhXubdIo
         4W4/Nf44J8HzXv72CFMXq3MOkIxvTyXjDJ44vniBh+CYZCL2EBn+JbjJeurrFMSfnzh/
         OIODx0PhZbwPYUDZZ1gVKrC6ITozT6bPzQo8N13FM5N6fAxHfqqYxOdzvzhNN3W/bDBW
         dKVg==
X-Gm-Message-State: AO0yUKU4wZGKnc/IVoQXzIiAAEkKKn8+IqoGDYGuNWSbr9Ho/6yTUvN4
        nHqmi9ctmvqxdsYm/NBTYO/vZl4bSBt4w2Wj2SFjnw==
X-Google-Smtp-Source: AK7set/uJ4rv11Gwd9M4V3e0q/tIdvP4BwOrA5dBtGnCQNioUAFEijLJ/77Yywt0fc50Kzs5xzDostowHZZX/hb7/nQ=
X-Received: by 2002:a05:622a:214:b0:3bf:d313:77dd with SMTP id
 b20-20020a05622a021400b003bfd31377ddmr439756qtx.14.1679501022652; Wed, 22 Mar
 2023 09:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <202303222158.8975b36d-oliver.sang@intel.com>
In-Reply-To: <202303222158.8975b36d-oliver.sang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Mar 2023 09:03:28 -0700
Message-ID: <CAP-5=fV3x_=6JqVsX8Z_+5bz67de_5JcWX-1B=So18wpMK3r=A@mail.gmail.com>
Subject: Re: [acme:tmp.perf-tools-next] [perf build] a980755beb: perf-sanity-tests.perf.make.fail
To:     kernel test robot <oliver.sang@intel.com>
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

On Wed, Mar 22, 2023 at 7:20=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
> Greeting,
>
> FYI, we noticed perf-sanity-tests.perf.make.fail due to commit (built wit=
h gcc-11):
>
> commit: a980755beb5aca9002e1c95ba519b83a44242b5b ("perf build: Make BUILD=
_BPF_SKEL default, rename to NO_BPF_SKEL")
> https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git tmp.perf-tool=
s-next
>
> in testcase: perf-sanity-tests
> version: perf-x86_64-e8d018dd0257-1_20230320
> with following parameters:
>
>         perf_compiler: clang
>
>
>
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skyla=
ke) with 32G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202303222158.8975b36d-oliver.sang@=
intel.com
>
>
> [   89.510180][  T246]   LINK    /usr/src/perf_selftests-x86_64-rhel-8.3-=
func-a980755beb5aca9002e1c95ba519b83a44242b5b/tools/perf/util/bpf_skel/.tmp=
/boo
> tstrap/bpftool
> [   89.510191][  T246]
> [   89.801665][  T246]   GEN     /usr/src/perf_selftests-x86_64-rhel-8.3-=
func-a980755beb5aca9002e1c95ba519b83a44242b5b/tools/perf/util/bpf_skel/vmli=
nux.
> h
> [   89.801677][  T246]
> [   91.387572][  T248] libbpf: failed to find '.BTF' ELF section in /usr/=
src/perf_selftests-x86_64-rhel-8.3-func-a980755beb5aca9002e1c95ba519b83a442=
42b5
> b/tools/perf/util/bpf_skel/.tmp/bootstrap/bpftool
> [   91.387584][  T248]
> [   91.601268][  T248] Error: failed to load BTF from /usr/src/perf_selft=
ests-x86_64-rhel-8.3-func-a980755beb5aca9002e1c95ba519b83a44242b5b/tools/pe=
rf/u
> til/bpf_skel/.tmp/bootstrap/bpftool: No data available
> [   91.601281][  T248]
> [   91.626292][  T248] make[2]: *** [Makefile.perf:1075: /usr/src/perf_se=
lftests-x86_64-rhel-8.3-func-a980755beb5aca9002e1c95ba519b83a44242b5b/tools=
/per
> f/util/bpf_skel/vmlinux.h] Error 195
> [   91.626303][  T248]
> [   91.648913][  T248] make[2]: *** Deleting file '/usr/src/perf_selftest=
s-x86_64-rhel-8.3-func-a980755beb5aca9002e1c95ba519b83a44242b5b/tools/perf/=
util
> /bpf_skel/vmlinux.h'
> [   91.648922][  T248]
> [   91.667624][  T248] make[2]: *** Waiting for unfinished jobs....
> [   91.667631][  T248]
> [   98.262749][  T248] make[1]: *** [Makefile.perf:236: sub-make] Error 2
> [   98.262761][  T248]
> [   98.266203][  T246] make: Leaving directory '/usr/src/perf_selftests-x=
86_64-rhel-8.3-func-a980755beb5aca9002e1c95ba519b83a44242b5b/tools/perf'
> [   98.270224][  T248] make: *** [Makefile:70: all] Error 2
> [   98.272060][  T246]
> [   98.284492][  T248]
> [   98.290078][  T246] make perf failed

Hi Oliver,

Could we add NO_BPF_SKEL=3D1 to the build flags? The idea with changing
the default is that is what most users want and so we want the BPF
skeleton to be opt-out rather than opt-in.

Thanks,
Ian

>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
>
>
