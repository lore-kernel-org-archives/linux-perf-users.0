Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FAC54EAA
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Jan 2023 00:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjAaAjr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Jan 2023 19:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAaAjp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Jan 2023 19:39:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A238298D1
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jan 2023 16:39:44 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso9465988wms.3
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jan 2023 16:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6AfmE3NriTDZXeBtPjgO5/cFK1t9ckr012YHXC87X88=;
        b=atG3rW3Qq1QGQMTcmfDo7Fkt2jfEqLzTNzH/DGSkqLEzUcFKVz9LPmDmg9nYE9j122
         f52ewBWuv5abxIoF/Zlf+uaLuVozSK5l5PdKeg5aTD4U2r8xcMjzVNE8g1MdxLFRgnPU
         OWKunZLpyW48NzPeyrYKOGOFteyAi7CjZmxjXtZ7RMFOEeVYp3Lh3quhdstnaWxcX4Q3
         pNdsrFvjw7c2MoXa/HvcECRTxuPCE5wfAHZ0N99pC/vSxPMqVDbljTdqPQeOKTLziCkV
         Im8Pwoits5fwpIIIZoAvKWcGDj3KVV8YgCJroq8GPDtVj/o+iDDebPGsgKebl1hInui7
         5ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AfmE3NriTDZXeBtPjgO5/cFK1t9ckr012YHXC87X88=;
        b=NgzoB3QftlLvywGwj8QZF+RqzYScIxCtp/yfqN5Srn6br7muaSdu0hqj7dSXivGhMi
         rxSxctvL/D60FCAfU3L/rBf6oR/0nF/BoQHnazfubo+lW0e9OapVLkfTPJkHd8k1CRfV
         3b30vqpX25Sn63Dqb2c4nEqmziVgkSHDhjOhd3zm4Xc4UrHfy3vCPvbgLKCH7l5xyKgC
         Odl+g1u387zk/7gArdwO5cfhP384SDDUUtUWeLsZL2yd0hfRQ0jk0+xzZBIGJy4J0N48
         9SxyU6MvoifSxBeJMJ6UAGQrRf6+UgMF1nyY7rPKlnHSpBImQbABl1F1bUTyIVl0a/Av
         OqTA==
X-Gm-Message-State: AO0yUKXbY0RnNi3MWGg18ayLtMtEnR/BHmCiXguULaG8TeQrViwnWIG9
        hRryzx/exusLBhJ34NHJWus6uWgN6IqX/ZVSO/4Pow==
X-Google-Smtp-Source: AK7set8dbrb84Sq6Vq89iS+Rfc/IidveFR9I6gsKg0LdArFqaNehK7b3xc+T8mhT2oN98RrBoyaXefpNBRjJnygEtIw=
X-Received: by 2002:a1c:2b07:0:b0:3dc:19fc:3059 with SMTP id
 r7-20020a1c2b07000000b003dc19fc3059mr1488017wmr.188.1675125582994; Mon, 30
 Jan 2023 16:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com> <56f1ed31-886d-358d-cfcc-0ab9fe7a76d8@oracle.com>
 <CAP-5=fWc1UcjZT-8YcqHaiSEUGJCMNd4Syx3-MVhnk5PGUDPMQ@mail.gmail.com> <c18b2293-5f34-28b9-25de-c92c25d5c3f0@oracle.com>
In-Reply-To: <c18b2293-5f34-28b9-25de-c92c25d5c3f0@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 30 Jan 2023 16:39:31 -0800
Message-ID: <CAP-5=fWvdOFG0r5eibOy4Ai2EF2zcKZBsFU+vSDBPasvjFepVg@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] jevents/pmu-events improvements
To:     John Garry <john.g.garry@oracle.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 30, 2023 at 7:22 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 27/01/2023 13:48, Ian Rogers wrote:
> > On Fri, Jan 27, 2023, 5:20 AM John Garry <john.g.garry@oracle.com
> > <mailto:john.g.garry@oracle.com>> wrote:
> >
> >     On 26/01/2023 23:36, Ian Rogers wrote:
> >
> >     Hi Ian,
> >
> >     At a glance, none of this series has your Signed-off-by tag..
> >
> >     Thanks,
> >     John
> >
> >
> >
> > Thanks John, will fix. Is there anything else?
>
> Do you think that pmu-events/__pycache__/metric.cpython-36.pyc should be
> deleted with a make clean? I would expect stuff like this to be deleted
> (with a clean), but I am not sure if we have a policy on this (pyc files)

Should they be covered by the existing clean target?
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.perf?h=perf/core#n1102

Thanks,
Ian

> Thanks,
> John
