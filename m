Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7888DC76196
	for <linux-perf-users@archiver.kernel.org>; Fri, 31 Mar 2023 05:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjCaFui (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 31 Mar 2023 01:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCaFuf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 31 Mar 2023 01:50:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458DD12CDE
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 22:50:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ix20so20298992plb.3
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2023 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680241833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzgUwKsTXlcKR3IZP1bVNxBagrJvGQ4VZm8bOrKutDM=;
        b=xaAE32ETbzPfQ38td8hI3jF6TeQaETDeGClpg3d7IlaSPGhI7kqCo/7S40gHEWyMq8
         m0x2nzdeKrfSyZnb8HgwWhKo4rNRxYcO11zByLfWIf7vmGp8vgvw2W2OD6cJC+KEjL31
         rQPHiFQgUDPP+C7IpOD0w1C7z1/QmeO4GHbab/QwlT+jteRwg6dqqWq6qdMrhFxH+LmA
         8HScU9P8tF3BCrHaKQJmf+kqUGqMEfRFBJ917ag4S5QxlEIVFOoPR8P26c0wRawjZNrr
         BrZ0zI+7RhpmR98rWxu84x9znPNDae0LfHxNnJfO5suyA26h/Zzct9kVeQT0Fpy+0xBL
         ynEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680241833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzgUwKsTXlcKR3IZP1bVNxBagrJvGQ4VZm8bOrKutDM=;
        b=U+VVOtze/dOTnOlRfONrxllfFFSVWfOxP+zeb/VCmSuHx3+a1so2XuKhahi9TXdEfu
         A+KH05kqTFOxjl6uNbyo1mbPSSoHI36qM2D9MUD1/zHFaKWDSEVSIQ8qt335g2bGo0dc
         hN5Ay/oaC8xmnE9s1O/3Oyr6fDRr2b5eT8mBv9qhq6dN83w1RAw+mei5ZmHthDrwLJVd
         t0BD8EO8wUyQmP9ZGq2QP9WXPMc8FgZySw2zPS29ze6FlI/FMT0rawfrTiahtchuzWkm
         qp4gyfFnl2tRMym2SZkDZuf0VyfUnp0N+5EAAKkPMepG9vvcsq2PYwggp+4bbS3MHhC3
         X/VA==
X-Gm-Message-State: AAQBX9ce5aDCyoA6q4GjLdXQ+L9XX0eo5YIhtWHS+ESbqOulfGWeMxs+
        wZJmM3JpJGh2frJX2DQS2wfUEzAEAQxc3Ei69T87GQ==
X-Google-Smtp-Source: AKy350aJ2MdnJe836h4peLGe+7yJUEWRJ/iVZhGH4oxEsAv3J7nFUhrtHqK96PUMTfwbcGDndhEhvnUdJ+STEIW6aYA=
X-Received: by 2002:a17:903:41d1:b0:1a0:5402:b17f with SMTP id
 u17-20020a17090341d100b001a05402b17fmr9406603ple.6.1680241832638; Thu, 30 Mar
 2023 22:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230329111422.3693-1-mike.leach@linaro.org> <20230329111422.3693-2-mike.leach@linaro.org>
 <ZCQx5HlPnxCIFaNQ@kernel.org> <ZCQyNnk/vfHZkSda@kernel.org>
 <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com>
 <ZCQ7nhrISA+jCfnI@kernel.org> <CAJ9a7VhJRnRe0A43=_X463432LvjL=S5buVgeq6rB8K8nDZb6A@mail.gmail.com>
 <ZCSRU8zvjjBHhq+x@kernel.org> <ZCS4XJaWg7NvaWb7@kernel.org>
 <20230330031307.GD252145@leoy-yangtze.lan> <20c28979-53a7-19eb-16fd-4d8535454d4e@arm.com>
In-Reply-To: <20c28979-53a7-19eb-16fd-4d8535454d4e@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 31 Mar 2023 06:50:21 +0100
Message-ID: <CAJ9a7VjxHkf4SsmmoRhPBeS=68igtOrwSsgJdcTy+9JWT1sBCA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi

On Thu, 30 Mar 2023 at 11:55, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 30/03/2023 04:13, Leo Yan wrote:
> > On Wed, Mar 29, 2023 at 07:14:52PM -0300, Arnaldo Carvalho de Melo wrote:
> >
> > [...]
> >
> >>> Not here, I'll check after a call:
> >>>
> >>>    50     9.90 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
> >>>      arch/arm/util/cs-etm.c: In function 'cs_etm_save_ete_header':
> >>>      arch/arm/util/cs-etm.c:720:29: error: implicit declaration of function 'coresight_get_trace_id' [-Werror=implicit-function-declaration]
> >>>        data[CS_ETE_TRCTRACEIDR] = coresight_get_trace_id(cpu);
> >>>                                   ^~~~~~~~~~~~~~~~~~~~~~
> >>
> >> This function was removed in:
> >>
> >> Author: Mike Leach <mike.leach@linaro.org>
> >> Date:   Wed Mar 29 12:14:21 2023 +0100
> >>
> >>      perf cs-etm: Update record event to use new Trace ID protocol
> >>
> >>      Trace IDs are now dynamically allocated.
> >>
> >> I'm removing this series from perf-tools-next, please address this issue
> >> and send a v9.
> >
> > I can reproduce this building failure.  I am curious for how to verify
> > building for patch wise, the link [1] gives me some hints and below
> > command works for me:
> >
> >    $ git rebase -i --exec "make -C tools/perf clean && \
> >      make -C tools/perf VF=1 DEBUG=1 CORESIGHT=1 && \
> >      make -C tools/perf clean && \
> >      make -C tools/perf VF=1 DEBUG=1" HEAD~3
>

Thanks Leo. However, I've now written a python script that given a
patch directory will run:

foreach patch in dir
     git am patch
     build

so that can work directly on patches before they are sent - or when
they are received in future.

> Looks like perf-tools-next has some changes that has not reflected
> elsewhere. The ts_source patches are queued there, which is causing
> the above build failure.

> Mike,
>
> Are you able to rebase your patches on perf-tools-next branch ?
>
perf/core and perf-tools-next are both on the same commit.
v9 tested against perf/core

Mike

> Kind regards
> Suzuki
>
> >
> > Thanks,
> > Leo
> >
> > [1] https://stackoverflow.com/questions/26983700/git-run-shell-command-for-each-commit
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
