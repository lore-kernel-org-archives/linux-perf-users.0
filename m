Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D01C77B72
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Apr 2023 23:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDNXPK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Apr 2023 19:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDNXPJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Apr 2023 19:15:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C35330D8
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Apr 2023 16:15:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso150235e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Apr 2023 16:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681514107; x=1684106107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FuwBRzQdljgOs1p7YJRLZAflcnTl/oPe1U4wF3aHsU=;
        b=Nk+MmfNU657jvr9HCL7otTcpk7dUqUJapSorFs0iwJNKM1+mcIL0U3/wJuGM8EEUvI
         vYze6iirrCF3wydZCIyOGQdVZ6er3luuaXonT/5pKGiw9SZT6s2cZDiKN9jjge/Fq0fP
         uPK5iDDAQHyRhdVt7oZoiCq6sFXkXmDxHSBTpUPVcnUY8dy5PwGD/YFHDomLDKTFnbNg
         F2Nu0bELzrQQIztWjQGC/tysIAgtj24ShRYE/LeFQvsvY+p1juq6H/XJKZMGEFyRdIac
         91EfuoN8B/4kqnxSORa0HFleFHce/ey2qx0dJc52cn0OeqOMp3Ulf9yrSkUzVhLEDb7h
         bMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681514107; x=1684106107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FuwBRzQdljgOs1p7YJRLZAflcnTl/oPe1U4wF3aHsU=;
        b=HK4GkT3X25txcMOcWqsK77nbBpnYkRTBIZyrSnwJA6ndzaCf+gceNVplYMbsCm+dqe
         4kpqMYChAzu0MyjO76lHQcWCadMV2TiGRsPTwVRVP/hG7iGu+KVpzds2qRt29RX84QdS
         2lxFGt5CEy7/q+2OVrmXwwrcGnGjVDy6pirtDMXQA8BYi8Oxln5igSbL25GF1fleTu7Y
         sK2rWkAIwOv8PHMQhWfQNOrKtQruDZVp5ZCEoujBufLpZZsOn+MUcpRln+yJlLvOgvsP
         pCP7JPeiEWiB+GP+S5W6ldjDxlHOkk9rkjpLPUb8KmJOXaLc8jqKBkttRCgFdlJNwlQV
         NOBQ==
X-Gm-Message-State: AAQBX9dqxayNkI6lhzFkEszc3zhV+C9NnSMGU00joGTkkIlOYEXhFmHF
        4CSF+FdCA0t6tZ61mS9PEaPSipIABsiZi/vVxGJObw==
X-Google-Smtp-Source: AKy350bB3qMJ5WQ3JGCKy4czluqi6P5Mwd7fpRuKc4qUvfDh9zXWxvylDP4F1JahKsEadomo0sJBzi1AOdHtpCRELIo=
X-Received: by 2002:a05:600c:3baa:b0:3f0:9f0e:a102 with SMTP id
 n42-20020a05600c3baa00b003f09f0ea102mr38647wms.4.1681514106610; Fri, 14 Apr
 2023 16:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230413132949.3487664-1-irogers@google.com> <ZDgL1Qca7N+Wilm6@kernel.org>
 <20230414081816.GS4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230414081816.GS4253@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 14 Apr 2023 16:14:54 -0700
Message-ID: <CAP-5=fU=h2pu=jgpzGTQ5MbZTZGvFTRYJLw2tqUPYk1vRr7c7w@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] Update uncore topics, 1x event updates, 2x new archs.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Apr 14, 2023 at 1:20=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Apr 13, 2023 at 11:04:05AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Apr 13, 2023 at 06:29:28AM -0700, Ian Rogers escreveu:
> > > Update the uncore PMUs and topic classification as created by:
> > > https://github.com/intel/perfmon/pull/70
> > >
> > > Event updates stem from:
> > > https://github.com/intel/perfmon/pull/68
> > > impacting alderlake, icelakex and sapphirerapids.
> > >
> > > Grand Ridge and Sierra Forest events stem from:
> > > https://github.com/intel/perfmon/pull/69
> > >
> > > Changes generated by with PR70 in place:
> > > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.p=
y
> > >
> > > v3. Rebase over the update of alderlake and icelakex events.
> > > v2. Adds improvements to uncore topics, uncore PMU name fixes and
> > >     fixes a trigraph issue from ??? being in the json.
> >
> > b4 isn't liking it:
>
> Fwiw, the way I've set up b4 it takes the patches from my local
> mailstore and it doesn't matter what made it out to lkml. Specifically,
> I pipe the patches from mutt directly into b4.
>
> I think there's some information in the b4 docs on how to set that up,
> but let me know if you want more info.

Thanks Peter! I'm using gmail for everything and I suspect I won't be
able to reproduce your setup easily. I think the right thing is for me
to set up a public git repository. I got about half-way through the
kernel.org documentation before getting distracted. I should finish it
off :-) Perhaps Arnaldo can use the set up though.

Thanks,
Ian
