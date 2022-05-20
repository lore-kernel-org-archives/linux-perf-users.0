Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05906C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 May 2022 15:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiETP7S (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 May 2022 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351203AbiETP7R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 May 2022 11:59:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDE7179959
        for <linux-perf-users@vger.kernel.org>; Fri, 20 May 2022 08:59:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h14so12086536wrc.6
        for <linux-perf-users@vger.kernel.org>; Fri, 20 May 2022 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PwFAuFgONb+vg0ZLZxC6Xv2WfN46rPNU+1JbG6LHMk=;
        b=ZfPQ6RMzXBoOdMkQC/e3gsjgM43Gs/A6hC2+e8rExFj7C19n6ZFMS5dy88XesH8E0x
         Soy5IhKWEUlL7e0zPU+1ZdhaVQQsGMjf8oDyXq2wtOENSVB0DDFSuxzbK5UYtFgoSCKa
         YI2nBrJiBMrCjh6EEeQ9YVVabOB8yKwLMQVQhPQkThZmoxfED9izWaZDR1t8pdgBf/dF
         k5uVVA/rzoZQezo0C724OfIGoXewBHrhvNZA5z+JagR37COX4IPCPo+hERs5F9L9Vonl
         uMmKcvFnMZ1zzL9ahnYqTU6UaasTdYTewSVO/jOay0Ntg94hk9KWHM3Dd3W8IzRF/oG/
         MkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PwFAuFgONb+vg0ZLZxC6Xv2WfN46rPNU+1JbG6LHMk=;
        b=34APC7Rbtd8hlSTX8S9Gra28JOKEBYsWNu6MmWtzEksoE+L0q7yo34ikPj0DpVHgDt
         WJ4+3ST/aTLtfO/BELM/q9TpYJxGj76X0kRZRvjGC984QKVWZ1rLdqI+7puhMgr/A/ki
         bHXGxkJVkj57VXMybJeeUni09JeqODmde0OBBM+9OlxWq6eTuFbeTzwQp3CgyZvO+ZQ5
         RRmhWEJ0EhZ9kqozdyPy3mmOd5OWBAAbsffT59avp76aebw8Rm8QVZuzMZQGpaqHn/S7
         PVo6b6x2C+Zxdndhy76Er7LTbekeLsOrmcgQeloQW/DC23n/t17ir2TShIPPUYsJzqHh
         o/rA==
X-Gm-Message-State: AOAM532Arh+DmilZ6EFFbd2buSfjXtPYtwyUE33yNlzy0peaa1XnZRfe
        tgTpRvq6ZR2fq5uBlfOS3wP+4MlsM01eB1N5GtEecPabv+M=
X-Google-Smtp-Source: ABdhPJz3KxMmXQxeNwT0z3srN5Ei4fSMZ+Vn6Mfq8zTE0XRnBM+G3mMbPmQPJiAvD7LzJ9phdKW0QzCXaz6fmvd5SrM=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr8913185wri.343.1653062354562; Fri, 20
 May 2022 08:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220519154324.12531-1-atrajeev@linux.vnet.ibm.com>
 <CAP-5=fXrtTe=6-z8-OMzG60XZmA92nHEhc94+NyCJK-ZPDekPQ@mail.gmail.com> <YoedbRTgfdQs+7H0@kernel.org>
In-Reply-To: <YoedbRTgfdQs+7H0@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 20 May 2022 08:59:00 -0700
Message-ID: <CAP-5=fUyD=njaTYeGQkCL-KnNxB8M64G9Fe1_2_HS9w1AsKUqw@mail.gmail.com>
Subject: Re: [PATCH V2] tools/perf/test: Fix perf all PMU test to skip
 hv_24x7/hv_gpci tests on powerpc
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 20, 2022 at 6:53 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, May 19, 2022 at 11:45:07AM -0700, Ian Rogers escreveu:
> > On Thu, May 19, 2022 at 8:43 AM Athira Rajeev
> > <atrajeev@linux.vnet.ibm.com> wrote:
> > >
> > > "perf all PMU test" picks the input events from
> > > "perf list --raw-dump pmu" list and runs "perf stat -e"
> > > for each of the event in the list. In case of powerpc, the
> > > PowerVM environment supports events from hv_24x7 and hv_gpci
> > > PMU which is of example format like below:
> > > - hv_24x7/CPM_ADJUNCT_INST,domain=?,core=?/
> > > - hv_gpci/event,partition_id=?/
> > >
> > > The value for "?" needs to be filled in depending on
> > > system and respective event. CPM_ADJUNCT_INST needs have
> > > core value and domain value. hv_gpci event needs partition_id.
> > > Similarly, there are other events for hv_24x7 and hv_gpci
> > > having "?" in event format. Hence skip these events on powerpc
> > > platform since values like partition_id, domain is specific
> > > to system and event.
> > >
> > > Fixes: 3d5ac9effcc6 ("perf test: Workload test of all PMUs")
> > > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > > ---
> > > Changelog:
> > >  v1 -> v2:
> > >  Instead of checking for platform, used the pmu name
> > >  ie, hv_24x7 and hv_gpci to skip the test since this
> > >  pmu name is specific to powerpc as suggested by
> > >  Michael Ellerman.
> > >
> > >  tools/perf/tests/shell/stat_all_pmu.sh | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> > > index b30dba455f36..7d046bb8a7b9 100755
> > > --- a/tools/perf/tests/shell/stat_all_pmu.sh
> > > +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> > > @@ -5,6 +5,16 @@
> > >  set -e
> > >
> > >  for p in $(perf list --raw-dump pmu); do
> > > +  # In powerpc, skip the events for hv_24x7 and hv_gpci.
> > > +  # These events needs input values to be filled in for
> > > +  # core, chip, patition id based on system.
> > nit: s/patition/partition/
> > > +  # Example: hv_24x7/CPM_ADJUNCT_INST,domain=?,core=?/
> >
> > I've no problem with this patch, we may need to do similar for other
>
> Can I take this as an Acked-by?
>
> - Arnaldo


Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > architectures. For this specific problem I wonder if rather than
> > skipping the event the event can be fixed with domain and core set to
> > 1 ? This would provide a little additional coverage.
> >
> > Thanks,
> > Ian
> >
> > > +  # hv_gpci/event,partition_id=?/
> > > +  # Hence skip these events for ppc.
> > > +  if echo "$p" |grep -Eq 'hv_24x7|hv_gpci' ; then
> > > +    echo "Skipping: Event '$p' in powerpc"
> > > +    continue
> > > +  fi
> > >    echo "Testing $p"
> > >    result=$(perf stat -e "$p" true 2>&1)
> > >    if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> > > --
> > > 2.35.1
> > >
>
> --
>
> - Arnaldo
