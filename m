Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49724C001B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 22:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjGSWeg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Jul 2023 18:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGSWef (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2023 18:34:35 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C68BB3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 15:34:34 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-346099c6f43so52575ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Jul 2023 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689806073; x=1692398073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIbuVyN5d3NyUBHRaekU7xza2xcWELBLsfoZP8e9gNg=;
        b=2hxfLvUnWST1hw5GHv+xREoq79Syz2FB2qGP2KKuqS3JcgJ3VRnxxDA4HtD4TomoRS
         c8VbEXGK/dNFnd0BMqEcDL8zSJ4/ae7LyF3rhus4PkPJMdb+PXpiWcS1UoGu31hfRfHz
         TGQiRlYA2CPIWG1xhGptxv5gQW2pQ7HoTudYJOCjw//U0C9h96eWd1zm7UwTSJyL6kts
         0iZiz/lrqcMVDFAXiC6d3mxWEGV+FtGq3NierD9tZzc9UWyLGEC9aHrZhZdtDfYExC4r
         bUyr7rBPvEzyxg6af8CCWhUSkwoexwomx8FdiF6Q5ScCtJC6M7MOeOc7nUHcR+h+hoML
         L/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689806073; x=1692398073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIbuVyN5d3NyUBHRaekU7xza2xcWELBLsfoZP8e9gNg=;
        b=QWhAKolsopdKiygVbzl0i8w5d8l2Q8542NKUtrPto1XzDMDaEr3FlDLa8F9KvUg6bW
         uqjdb5Jl58GTh4VlPcEijSVicqqb+RuPssiCt+OlagqCw0DtSSqPde+oWwxMvXaxZ0jn
         h0l9zdXGi2n0jgATxn6k+LDIAW6t/DcK1xdFfN79zEXM/c9YuJWmcEhVDy2xi1SHHB87
         2DP6hA08YENK9JATZq1mjpk5zY/jIffGzC8ZLyrM3+FzcOt3g0YK9ctP0JC8zogPN06B
         OZ/gkQEkPNxjB8s3NpLIvT8udSjfuQURwCls9qmpA/8/23O7bYcdzN39JW2SWeu6+PJe
         Vl5g==
X-Gm-Message-State: ABy/qLauFWsTb/o76RfuyFbVOGkxROy5qUdHZIPT36A3FYAKTjcVGesn
        CCpgxBMigwswR1P+NHEklRnaoGmumeZ6jqvPlv6w/g==
X-Google-Smtp-Source: APBJJlG9jUMqVyvUlse88weKimxWs0pP1zXlRDmC++8lT6+P6hHKROIp/1otTP4crqWLUHpvTdqFVht2+4BxQnlXnOI=
X-Received: by 2002:a05:6e02:1789:b0:346:48bd:da43 with SMTP id
 y9-20020a056e02178900b0034648bdda43mr99530ilu.4.1689806073680; Wed, 19 Jul
 2023 15:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230719202951.534582-1-acme@kernel.org>
In-Reply-To: <20230719202951.534582-1-acme@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 15:34:21 -0700
Message-ID: <CAP-5=fWj8ZgbYd2OX85LjW=Cd6jvF_tfqPdVELsTXHG+GebxRg@mail.gmail.com>
Subject: Re: [PATCHES 0/6] Fix some 'perf trace' leaks found with -fsanitize=address.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 19, 2023 at 1:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi,
>
>         Please review/ack, I put it as well on the tmp.perf-tools-next
> in the perf-tools-next tree:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
commit/?h=3Dtmp.perf-tools-next
>
> Best regards,
>
> - Arnaldo
>
> Arnaldo Carvalho de Melo (6):
>   perf evsel: Free evsel->filter on the destructor
>   perf thread: Allow tools to register a thread->priv destructor
>   perf trace: Register a thread priv destructor
>   perf trace: Really free the evsel->priv area
>   perf trace: Free thread_trace->files table
>   MAINTAINERS: Add git information for perf-tools and perf-tools-next
>     trees/branches

Series:
Acked-by: Ian Rogers <irogers@google.com>

I think patch 2 could use an extra assert to be extra safe.

Thanks,
Ian

>  MAINTAINERS                |  2 ++
>  tools/perf/builtin-trace.c | 38 +++++++++++++++++++++++++++++++-------
>  tools/perf/util/evsel.c    |  1 +
>  tools/perf/util/thread.c   | 11 +++++++++++
>  tools/perf/util/thread.h   |  2 ++
>  5 files changed, 47 insertions(+), 7 deletions(-)
>
> --
> 2.41.0
>
