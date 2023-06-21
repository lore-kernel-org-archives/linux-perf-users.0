Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C0BEB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 15:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjFUPYW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 11:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjFUPYB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 11:24:01 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45251170C
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 08:23:33 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so5981852276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 08:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361012; x=1689953012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/3AFmhGrnT7miz2C2qw2MKk/841rTkgAzatLOE0ayw=;
        b=YQh39UNEV4IS3mpPF9PlmGSp0z7GLS5d+0b4bWVx+zonsGIhWbOYmZnOqS4nCb8jYj
         ps7fs+ZVUwW4dKzZdo7DWRSoifdIRS/pIE/r2ZPlWQ9EXHCLIGR8TWXIScP3RPFB47RF
         mgyEfousISCqLZT8tk9bL+122JfWo2ckqulfcCLDKuFJ0L8vDTWPbwxq+H/HtznnqcRq
         sMhHohH7e4PHTjVVhU+pJaibPfiBidhxP9VNzKCCFhpwcjlLos0ZL5XsecD4SFauvaqx
         FthT01211tEzK6nLSAygIzEYCc0uWZlBlEeJf/OSC8RAbWlnFtTem3p/pksWTeD8mnN2
         y4Bg==
X-Gm-Message-State: AC+VfDwkcDrCG/GBQlo9EMRGsr7C/mF1dWGC94XuKWdwus7VrTCfuaa+
        SADmmdjQBy7WDHMsSYU+rY3rXq8B3/2IfX1CgPg=
X-Google-Smtp-Source: ACHHUZ7pv1M82zaGE8eykIulxbJ0/K7GzIgBbww4P2+H//HaGGZw4qWn45Wc3Pv5WXcy7xDcNv0U57YFueK6umYS/qA=
X-Received: by 2002:a25:abb1:0:b0:bc2:65d:6e9d with SMTP id
 v46-20020a25abb1000000b00bc2065d6e9dmr12122505ybi.11.1687361012341; Wed, 21
 Jun 2023 08:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-16-atrajeev@linux.vnet.ibm.com> <ZIjMWUk/axKfMCM4@kernel.org>
 <CAM9d7cjrpaNk0UC22ntBSP+LzQwT2YAHwQ2o3z1aayAZNQ329g@mail.gmail.com> <5ab5cc25-03b0-ef7f-3dc0-be1b59a4147d@linux.ibm.com>
In-Reply-To: <5ab5cc25-03b0-ef7f-3dc0-be1b59a4147d@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 08:23:20 -0700
Message-ID: <CAM9d7cgcETpnNgvgJ8a966bwc0phQuVMwABHzA8APk6Z9Er=OQ@mail.gmail.com>
Subject: Re: [PATCH 15/17] perf tests task_analyzer: fix bad substitution ${$1}
To:     Aditya Gupta <adityag@linux.ibm.com>
Cc:     Hagen Paul Pfeifer <hagen@jauu.net>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        irogers@google.com, ravi.bangoria@amd.com, john.g.garry@oracle.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Aditya,

On Wed, Jun 21, 2023 at 3:05 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
>
> Hello Namhyung,
>
> On 21/06/23 06:18, Namhyung Kim wrote:
> > Hello,
> >
> > On Tue, Jun 13, 2023 at 1:06 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> >> Em Tue, Jun 13, 2023 at 10:11:43PM +0530, Athira Rajeev escreveu:
> >>> This issue due to ${$1} caused all function calls to give error in
> >>> `find_str_or_fail` line, and so no test runs completely. But
> >>> 'perf test "perf script task-analyzer tests"' wrongly reports
> >>> that tests passed with the status OK, which is wrong considering
> >>> the tests didn't even run completely
> >>>
> >>> Fixes: e8478b84d6ba ("perf test: add new task-analyzer tests")
> >>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> >>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> >>> ---
> > I'm seeing a different error even after this fix.
> > Can you please take a look?
> >
> > Thanks,
> > Namhyung
> >
> >
> > $ sudo ./perf test -v task
> > 114: perf script task-analyzer tests                                 :
> > --- start ---
> > test child forked, pid 1771042
> > Please specify a valid report script(see 'perf script -l' for listing)
> > FAIL: "invocation of perf command failed" Error message: ""
> > FAIL: "test_basic" Error message: "Failed to find required string:'Comm'."
> > Please specify a valid report script(see 'perf script -l' for listing)
> > FAIL: "invocation of perf command failed" Error message: ""
> > FAIL: "test_ns_rename" Error message: "Failed to find required string:'Comm'."
> > ...
> > test child finished with -1
> > ---- end ----
> > perf script task-analyzer tests: FAILED!
> Can you please check if your environment has libtraceevent devel
> libraries (or did you compile with `make NO_LIBTRACEEVENT=1`) ? When
> libtraceevent support is not there, perf record fails and so perf.data
> doesn't contain the strings it's searching for and hence those errors
>
> The error you mentioned has been mentioned and fixed in patch 17/17 of
> this series.

Thanks for your reply but It has libtraceevent.  Also, shouldn't it
skip if it's not?

Thanks,
Namhyung
