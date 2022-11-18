Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FE9C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Nov 2022 02:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbiKRCsQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbiKRCsO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 21:48:14 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593228DA4F
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 18:48:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5so2728895wmo.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 18:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BueznbYbggQL65sE4mcwNsXbMIiOLvwnyD78G/vrsK8=;
        b=emQVGDvIHmzYwqxLLjcIKVs/9qc0VNR6MtpQ4f1cOoXtOa7ac74JEPtDlRZkp4MNrS
         Xj+NX3MQ/cqzBxyLUK3JGN2mKiXrZk183Cc1TycNtq2lQs0FI8Mlw4Y0sT3aPoQkmaaJ
         lQOLNNIabuQDRwI4bKNhuFndB3SMhdK50u45fKrQ9/MLI2QNr8NXBMpKf8zKwiHM3r7o
         mJnMxzWVOQ9EbUKx0HC2cAkBe1/je9Yjzd5aZ5vG2XQk9BWjkWVdcQ3VfzYTKk1MiEp2
         IQEOhXqq8kSt75OMaEVW5cHXiBdLpDD8glSpVvJ6fAFMEuMtbFBBetH91EzbSbbhwslI
         28Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BueznbYbggQL65sE4mcwNsXbMIiOLvwnyD78G/vrsK8=;
        b=FhuqNPbG+r6F3UVJREVGkSKd7O9udQj2ouxpttOXlqVTPy0NcAlLcMiCdpzq9elmLo
         QfyW4IhoTJy/FgrHyWu8Jil2+aeOcHI27P+Oh7k+C0eR2xfvoXOHNKVPLlDva0WNiN8s
         B4wu9XreJzt1MeYlgDymGD9ibAGqTisGFxli6d4xw2ECW3YgiIq3NAjbVoC1s9K/ktvp
         AIk8FKW66NxiiJlllbqdt1ZumAi1w0qYuZb1NA3a1ybUDlwVX1YJyS49ey6/85WGAa7h
         Zf2W1xniZH7i9KX/7RnXgb/rzfH2veF9Vyu+kzd5YESqJm4A6eeJmwXW9YcJPKFNPgd8
         9Tvg==
X-Gm-Message-State: ANoB5pmGLAIwifWxuNE4Bu3uf+2bZzO82JWODMg200oEOTYm2Nve/TDb
        FHeiWCsQA8BOxxiAwG/hyXybUN5ZterJtg7kVRQSog==
X-Google-Smtp-Source: AA0mqf5aLac6FQkKwINkhvxrzeSP9a5i5KYkEoUPsyqYr2rWNQe7FLXH1g0q+olvgMORkULyC1MP9F4ROOOHC8t8HKo=
X-Received: by 2002:a05:600c:4fc4:b0:3c6:c109:2d9 with SMTP id
 o4-20020a05600c4fc400b003c6c10902d9mr3504087wmq.149.1668739691747; Thu, 17
 Nov 2022 18:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20221114210723.2749751-11-irogers@google.com> <Y3OX1pcclKCgbpeT@kernel.org>
 <Y3TIG7BIzltgvCPw@kernel.org> <Y3TK/6bBFsHxduPc@kernel.org>
 <Y3TOwYdhzURKTgyB@kernel.org> <Y3Tah5Ocvx6lQ4jP@kernel.org>
 <Y3ThXYH3SAyEGmQ+@kernel.org> <Y3T/35DcAw+h4R93@kernel.org>
 <CAP-5=fU-tJPdxosVFfbbKtrswom7bnY6Ei3JczRJaQYyOnjcAA@mail.gmail.com>
 <Y3Zh+XTXbhrOXAla@kernel.org> <Y3Zlu4lAbZI8cQhT@kernel.org>
In-Reply-To: <Y3Zlu4lAbZI8cQhT@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Nov 2022 18:47:58 -0800
Message-ID: <CAP-5=fW_VVi=cYmsJuMSqPK1kLv+MOaXBcunjWxnjZz5KZR2RA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] perf list: Add json output option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 17, 2022 at 8:48 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 17, 2022 at 01:31:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Nov 16, 2022 at 11:52:39AM -0800, Ian Rogers escreveu:
> > > I think this should be squashed into "perf list: Reorganize to use
> > > callbacks". Some explanation, in porting the : glob case I'd assumed
> > > the before the colon would be the PMU and the after the event. Doing
> > > things caused tracepoint output to differ too much and so for
> > > tracepoints the : is kept in the event name. So we can simplify the
> > > matching to not be pmu and event, just use the event glob.
>
> > Next time please send the patch, I did it manually and before the last
> > option I get:
>
> > [root@quaco ~]# perf list syscalls:sys_enter_open |& grep syscalls
> >   syscalls:sys_enter_open                            [Tracepoint event]
> > [root@quaco ~]# perf test 112
> > 112: Check open filename arg using perf trace + vfs_getname          : Ok
> > [root@quaco ~]#
>
> Ok, adjusted the last patch in the series, everything is in my
> tmp.perf/core branch, will go to perf/core later today when all tests
> gets passed.
>
> Please check that what is at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/core
>
> Is ok, its passing 'perf test' for me, including the one that was
> failing:
>
> [root@quaco ~]# perf test 112
> 112: Check open filename arg using perf trace + vfs_getname          : Ok
> [root@quaco ~]#
>
> - Arnaldo

Thanks! Looks good to me, I rebased the libpfm4 fix on it:
https://lore.kernel.org/lkml/20221118024607.409083-1-irogers@google.com/

Thanks,
Ian
