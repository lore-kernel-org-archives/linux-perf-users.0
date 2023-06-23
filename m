Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60DAEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 16:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjFWQIb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjFWQIb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 12:08:31 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9EAB7
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 09:08:30 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so291311cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687536509; x=1690128509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awlw4SDBq/EVN1A7kQsXZpq8IW9b3XSNJsurYU+C4nc=;
        b=QbI99M+WQDhAtfL824R0Jx/dP1jEjMPF3m9kXs7dG2SGG2qquuyvVibkyVIPbkWgJl
         aZdcR4oz6y7c0OAL9MVkaPmWkxF+djpldr4SpqeM+Efi5Og2Dd/PFEWQiAHdH5g/DBvw
         XrASliVWeVemTFCymVXZ0P780/xSE0aoR7W1RfQYO0b12TR1OuCTe17j6ACzgwUqVdgz
         kIT7CEpmC4fh0+uAUNwxxECfqKOE5vb+mv2uzxwOnXVvbOt+Jz2OH5emF41J++gVFv0V
         u7p1AVOasy+LJBcT2w4ja/A7j5GzJ4kWx1URD+fPZ4ZD5ydJXfXawcHh+qg0dG1ahNhK
         Pe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687536509; x=1690128509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awlw4SDBq/EVN1A7kQsXZpq8IW9b3XSNJsurYU+C4nc=;
        b=JYeq7vyEZid2oFBaT+iNo0S+PfsuYHBDQQRpq3rVphNsSwH1VKDZWHsOkoXImLPesi
         ifgEf04z04NRXKpd98EH/jna0nBRbT5gd1qlCjTkAG7wnm2HW02sN/OByllWRrK4u3TB
         0Z0w8/0nwBFd9ZNFmjKZ0oXsAVfW5SGf7wOM2S2OEHIuYadq1XlN4vO2bz1tacR3BlZb
         fef7EtwB7EPoP8Dcbh9XrmNhupzZrHTUOyvy7Dosb5T3HK4tNi25WjWqcMEIjAuoSgJu
         bd1A48GTEolyXjsa+ZDv6P8rMBXtBqq79wQe5qnythD5hvNUToheWuSXm//PtJ0iqBYC
         OMBw==
X-Gm-Message-State: AC+VfDxzGMYh1exw1yPKV19jwEr6Ks3HolZ8rBzjeegk66OQfnoQWw1Z
        ucOIx1LBy9paJGHej7JKwVM22t5LVqjEsbK6iOci9g==
X-Google-Smtp-Source: ACHHUZ7I1svGn6Um+b289e5KGZT4OaB29KSO7bke6i8ZyCWlgx+jWIie8P0N/S2FF74Lsf4bwN2Fc2+EY00oDqN3si0=
X-Received: by 2002:a05:622a:19a3:b0:3ef:343b:fe7e with SMTP id
 u35-20020a05622a19a300b003ef343bfe7emr157356qtc.2.1687536509389; Fri, 23 Jun
 2023 09:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com> <20230623151016.4193660-8-irogers@google.com>
 <ac3b4a0c-7984-8b15-a7ed-9c0428bdb027@maine.edu>
In-Reply-To: <ac3b4a0c-7984-8b15-a7ed-9c0428bdb027@maine.edu>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 09:08:17 -0700
Message-ID: <CAP-5=fXatNFoNBc8PfC6Yd1uvd6ivzyn=k9NLO+sT_QRUrr1cQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] perf vendor events intel: Update icelake to 1.19
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 23, 2023 at 9:04=E2=80=AFAM Vince Weaver <vincent.weaver@maine.=
edu> wrote:
>
> On Fri, 23 Jun 2023, Ian Rogers wrote:
>
> > Updates were released in:
> > https://github.com/intel/perfmon/commit/f3d841189f8964bc240c86301f4c849=
845630b5b
> > A number of events are deprecated and event descriptions updated. Adds
> > events ICACHE_DATA.STALLS, ICACHE_TAG.STALLS and DECODE.LCP.
>
> why are the events marked as deprecated rather than just being removed?

My guess would be so that people who used the deprecated event name
don't suddenly get failures. The deprecated flag means that the events
no longer show in "perf list" unless --deprecated is specified.

Thanks,
Ian

> Vince Weaver
> vincent.weaver@maine.edu
