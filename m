Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB1CCA47C
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 16:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiF2QtJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 12:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiF2Qs4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Jun 2022 12:48:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E38F3F8A6
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 09:47:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v193-20020a1cacca000000b003a051f41541so3572280wme.5
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hS0iWXw2vBwf07hRw+AJMaKL/+/P5ivyQ+NC1agijLM=;
        b=UTPJK6vrgyh5TnMtMa1HKMxiXFPTLDxlke2Q8G4jm+4uxsef+BI0ytD9mAf/f4uMB7
         U6AIMURbzNn50OYHjNi140ZxAmSV/rBOeMBF4Y5UJAZOpqSaCycRF38vD6YWz5XGLBws
         8tHtGQ47NDwpdfrKSTnIs5ZhRiirWZefqcMDPsTIydbTSGbycFInJiquD+w1C0yfVmPU
         n49TZOSp3dpA2rEgnWS6o9zshGGFVbKaDe/IiqiDyPymvgOmTgvIjboUCPfLsDUKID1f
         MVp1O8U/IzvP3+CZuvALPnmix8A1ogKBq3P157+OnajtfQHr0sUfJSXdZF+Fo4X+ZuY7
         fcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hS0iWXw2vBwf07hRw+AJMaKL/+/P5ivyQ+NC1agijLM=;
        b=k9nGSK8sXpvEDC/7Wjf0V11gR3ZeEyf3oKJPW0tALh1DcNIeKZmDCDDSscUdgb8Me2
         6SLB5X94QRaqATIPzvvF7wkj9YpHta5Pu6rEXnEKW1dgWxGRXmLoqeFHpp75FiC/Rgtm
         OX9Oy03y//vIsecXFsVyIbsIAZJrYuBqAGu7x/DbpGQBk5ROHvIs8i15U7/2O1BIK0Wi
         bFJD+PTXvK/8dy4nJguidluzuntVrFBdEHnH0vL8PLmUDNAB+kerEAUo6g54af1FqXil
         DF67AbJvfHBQkctUIHh/jIjos0eNlAPwHxxF4dHEaYYjWr/s2O8MenKvDIVwsksqoZHE
         YeTA==
X-Gm-Message-State: AJIora/GOjh/nuH8KPrUC1AqKPskeIB0tEigO9R/LuaQcbeVorvFuhlB
        M0ffWhSchqD+5nlNygpxCGJspxULu6clgvltfjLE8w==
X-Google-Smtp-Source: AGRyM1uxkhcSA3OsIObuOFN5p+XSrzXK099UTPZg+lPZ9LA/gThbRH5Xl6cD4CYYXDihOH3PPu8P55Igo59ImMRq3jc=
X-Received: by 2002:a7b:c10c:0:b0:3a0:439d:6d66 with SMTP id
 w12-20020a7bc10c000000b003a0439d6d66mr4835817wmi.149.1656521253873; Wed, 29
 Jun 2022 09:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220627025744.106527-1-irogers@google.com> <6f9649d7-8129-57cf-8ab5-03abacd9cb6e@huawei.com>
In-Reply-To: <6f9649d7-8129-57cf-8ab5-03abacd9cb6e@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jun 2022 09:47:21 -0700
Message-ID: <CAP-5=fVxc7H75mb=j23gTD-eMYD3vru5U9QFGQDmODb57aykPA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Rewrite jevents program in python
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 27, 2022 at 10:27 AM John Garry <john.garry@huawei.com> wrote:
>
> On 27/06/2022 03:57, Ian Rogers wrote:
> > A challenge with this code is in avoiding regressions. For this reason
> > the jevents.py produces identical output to jevents.c, validated with a
> > test script and build target.
> >
> > v6. Adds Tested-by from Zhengjun Xing<zhengjun.xing@linux.intel.com>
> >      and Thomas Richter<tmricht@linux.ibm.com>. Fixes issues spotted
> >      by Jiri Olsa<jolsa@kernel.org>, jsmn.c wasn't deleted and the
> >      empty pmu-events.c didn't pass the pmu-events test. It also adds a
> >      missing mkdir which is necessary before creating pmu-events.c and
> >      tweaks the quiet display code in the empty case to display a gen.
> > v5. Adds a 2>/dev/null as suggested by David Laight
>
>
> Hmmm... shouldn't this be v7? Anyway what I got with message-id
> 20220627025744.106527-1-irogers@google.com now seems to build and the
> output looks ok.
>
> Thanks,
> John

Thanks John, I think I've confused myself by working on greater than 1
machine wrt version numbers. I can re-send as v7, would it be okay to
put on a Tested-by: John Garry <john.garry@huawei.com> ?

Ian
