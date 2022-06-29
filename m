Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2359C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 18:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiF2SLr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiF2SLq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Jun 2022 14:11:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B611811A28
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 11:11:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b26so11282769wrc.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKWWlQLOEb5CNhiWUSoPZ3c2KB23CiF89xYNjZt498Y=;
        b=hEzhln9y815dHz1vopcSdH6UgxjBQ26JMPrFOd0r0Zu7E85XmpX1Fgaq9jLqTdvA2A
         ugy4WoiHPI4PV1sZUEOJdIEE/5egU2gw0CQ9o5RICcrt/Qnb0UGZsKA+XkRV+kMguTLP
         XBEHP3+DdBmGEkZgDdNq+ap/hV7AQN6yT85mfawcMdKC3fupwE4J8wrg+V9qpPmcTgCD
         /TPvzIT2ORoWtHUpGKXY4RYVFCLM3ObAm1nIIUMbRC7HICkIffkc/sB0Potd2qiCEPcd
         x5Agw+5CcwkMv49GJwcU7KzsCbTEo/r7kiFakoN7nfHQvW+XZo3NDEHtFvSx/aL4zkwZ
         Wz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKWWlQLOEb5CNhiWUSoPZ3c2KB23CiF89xYNjZt498Y=;
        b=RDln6jMu7Dy6PTMeBpX/XiCbviE7ajSIZWzueKPJg969ah+Xb4kxTrllD6pfFH9MHF
         av1mmgngY5HOMZmMxzVmOSVc+odj0sUiLFP7oSyofPtD4I55oJaf/cUbsT1w76iNRXoB
         XObI911G4tUyzDBH1JgzDRA5lEP8vt7UIrw9Jt+zIFHf+35Uqn2Ug0c9tvaCIVoefz6k
         KTsc7ir9HYfgYQWKQQ/yCBA30UYoAnVw9yUgEtBTZDSApSBRt6DNNGDsMSZLIujVVGdh
         md9eAhKKtsdg3HsyZFKRkCV+AlfAkr7UvK55PU/LzeDEV8dSHu+aJL8DpjIA43m888HK
         qQYg==
X-Gm-Message-State: AJIora/JlauYcoFKU4uLPn/iupZNDQbjZV2lht+d+jteOmvVLhLUIJyZ
        VImcsSxwLiuwsQ1KAkeodudtaPtsUx9FcG7l134qNA==
X-Google-Smtp-Source: AGRyM1vH0mBEB9/AnxmPjR6pGfw0AEo6P2RAWOMhI9osqKlFGZXF67K7ExbW3VDb03ij4M6fTLPKIm/I3lVrqC03Jg4=
X-Received: by 2002:a5d:5983:0:b0:21b:b7cb:f84e with SMTP id
 n3-20020a5d5983000000b0021bb7cbf84emr4599496wri.654.1656526304117; Wed, 29
 Jun 2022 11:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220627025744.106527-1-irogers@google.com> <20220627025744.106527-3-irogers@google.com>
 <26fb5fec-500d-61c2-f009-556c5f7e86e6@huawei.com>
In-Reply-To: <26fb5fec-500d-61c2-f009-556c5f7e86e6@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jun 2022 11:11:31 -0700
Message-ID: <CAP-5=fXRnPoFZgaTSW5jyh5pcnUyHsMUZHzm9_RsDZpjaK=eyA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] perf jevents: Add python converter script
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
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <rogers.email@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 29, 2022 at 9:56 AM John Garry <john.garry@huawei.com> wrote:
>
> On 27/06/2022 03:57, Ian Rogers wrote:
> > +
> > +    def unit_to_pmu(unit: str) -> str:
> > +      """Convert a JSON Unit to Linux PMU name."""
> > +      if not unit:
> > +        return None
> > +      # Comment brought over from jevents.c:
> > +      # it's not realistic to keep adding these, we need something more scalable ...
>
> Since we're converting to python it might be a good idea to consider
> this - ever have an ideas on something better?

I think it is something ripe for cleanup, no particular thoughts on
this case. I'd like to make it so that jevents/pmu-events is aligned
with sysfs, which this relates to.

Thanks,
Ian

> Thanks,
> John
>
> > +      table = {
> > +          'CBO': 'uncore_cbox',
> > +          'QPI LL': 'uncore_qpi',
> > +          'SBO': 'uncore_sbox',
> > +          'iMPH-U': 'uncore_arb',
> > +          'CPU-M-CF': 'cpum_cf',
> > +          'CPU-M-SF': 'cpum_sf',
> > +          'UPI LL': 'uncore_upi',
> > +          'hisi_sicl,cpa': 'hisi_sicl,cpa',
> > +          'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
> > +          'hisi_sccl,hha': 'hisi_sccl,hha',
> > +          'hisi_sccl,l3c': 'hisi_sccl,l3c',
> > +          'imx8_ddr': 'imx8_ddr',
> > +          'L3PMC': 'amd_l3',
> > +          'DFPMC': 'amd_df',
> > +          'cpu_core': 'cpu_core',
> > +          'cpu_atom': 'cpu_atom',
> > +      }
> > +      return table[unit] if unit in table else f'uncore_{unit.lower()}'
> > +
>
