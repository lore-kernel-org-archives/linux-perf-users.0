Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028FEC71133
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 13:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244973AbjHYNOl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244992AbjHYNOQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 09:14:16 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4454F1FFA
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 06:14:14 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40c72caec5cso270771cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692969253; x=1693574053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e30ygpUnem0hnNXEifSCeb6KdAoBljm9WluqG1YNW+c=;
        b=gOLCH/Lb00Mz/K9+MfGJuQI+gpTU/aXIcKyNJKEZRfJzEDN6z7Fjm/ZJJbJ3YFJf06
         eEZ9ldF7S/Icc5bzc0VKBYNbeU2Kclv78vSvHcQuMOjlEpzLqHoZr0NZMr5ruim/O7ku
         f/mAQ3KVcAv0X5g5UnawPC8HzBWAd9UaNmawz9AGlKCY7gPyLCEx+SvCVrh1lrTnmjzs
         548i5lqvLT7ftR1D1YkWUYT1TM0sdZ+nGgApO2nZWlaQ4yTyT5Z6APgHjuH3kPXYbpgm
         Cv4dERMbuC8XRr9opa0AA9JSfZYChbs/LgwDRIs3ry7dxIfK/yEXE89nkHKxoR4vXEAL
         3Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692969253; x=1693574053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e30ygpUnem0hnNXEifSCeb6KdAoBljm9WluqG1YNW+c=;
        b=XJ+6BhwpnyaM8YAuu8GAqsw6dT04c7lthLwqFgUBBsaFeOrhzB0RGJjlbOQ4ea9Xg+
         gktkndOoAJF1jbNOIwyycYODIm9t/vZPo8vdgnqdFiev3Xv9dks06FmvuqmhLOnYVlfW
         tBehUTxWijVRFQCJS0tiNboblWLCg1C5EqJR/MS1eELNnlGxRlK4ZhUum5vyEeOszOGA
         7fkVUzbvbvNDBoZqJwYy6sG/O5abZyB5vAPEyQPDLD0oQKKblufI8iLpmz7pVEZSNakR
         vkJWkaQuTD0Tz+4SFd0nffLvnJCAocOlqWaEfXeVotsHtPufbPmRjtjEAxrLz1LE+F8W
         nX/A==
X-Gm-Message-State: AOJu0YxsxtrKNY9JN20CVS9tfXkl3lwyKpW6Fj7jg//qgLdaX7hasDDH
        t+/m5edLGVXFpiI2txLYqO/m0SYwTs2UWDRUykj9ZA==
X-Google-Smtp-Source: AGHT+IH+VlhSr/7ethdftBz4x+JgfAMJPFqEn9CO5of2hOfCYJWtOCDujhaXCutycQfctL9dyoDM5xODuPjY8K50w8s=
X-Received: by 2002:ac8:7f96:0:b0:3f8:5b2:aef0 with SMTP id
 z22-20020ac87f96000000b003f805b2aef0mr295265qtj.24.1692969253167; Fri, 25 Aug
 2023 06:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com> <20230824041330.266337-7-irogers@google.com>
 <ZOdiX4eJHFfFbQhi@kernel.org> <428afeb4-d5ca-8115-73fc-881119a1cd51@linux.ibm.com>
In-Reply-To: <428afeb4-d5ca-8115-73fc-881119a1cd51@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 25 Aug 2023 06:14:01 -0700
Message-ID: <CAP-5=fVt1vxK0CJ=aYjZzs4mushbxAx8056uxVQZUfsLAKpVoQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] perf s390 s390_cpumcfdg_dump: Don't scan all PMUs
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 25, 2023 at 1:20=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 8/24/23 15:59, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Aug 23, 2023 at 09:13:18PM -0700, Ian Rogers escreveu:
> >> Rather than scanning all PMUs for a counter name, scan the PMU
> >> associated with the evsel of the sample. This is done to remove a
> >> dependence on pmu-events.h.
> >
> > I'm applying this one, and CCing the S/390 developers so that they can
> > try this and maybe provide an Acked-by/Tested-by,
> >
> > - Arnaldo
>
>
> Arnaldo,
>
> I have downloaded this patch set of 18 patches (using b4), but they do no=
t
> apply on my git tree.
>
> Which git branch do I have to use to test this. Thanks a lot.

Hi Thomas,

the changes are in the perf-tools-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
