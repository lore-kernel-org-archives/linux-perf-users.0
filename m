Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A93EB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 00:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjFUAsU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jun 2023 20:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFUAsT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jun 2023 20:48:19 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EBE10CE
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jun 2023 17:48:18 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso5364863276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jun 2023 17:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687308497; x=1689900497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XivSQCtjI3r7uuieVa+Um6KFwyIb4sUtx6fC8E3IjV0=;
        b=OjOVROiUHYlNSs/CDgEdFLKgGTzT+t8q02DyUvc1aXR7692CwPemRmqhXXyQZ2tiFK
         H/GIl8zBwy5Jorwckm/Pgf75TLEONhpaxFuiT2M2ImZXPkU+iHWmXx3KLcjHNZ5RxMy0
         2GwyUc8tkEcwqZqveimdJXW6nPu98aVu1+tQPCfXa0mea3K0y0vyS5vsXzVql38UpkX5
         8cIRrdvXLoDyN4e0gkN6zBWnPKjy/j4oCti2MxRB/nFBxFtzD9oiAAHlTNzaR8mX8mRs
         QY9Kx0swaqXxBx6bL3xK6W128SMk/DHqnJfi8whFsjlLidrhLMOCKdSxFK8tzNcPVxRg
         MuhA==
X-Gm-Message-State: AC+VfDyGO0Q8mVVGm12xFfM655vEeIOskRT8hVLoBdDim6r2is00Vfmd
        jSa0KUDcGcJHQmt+Hz23STsYNsalzKJ7i3u4pc8=
X-Google-Smtp-Source: ACHHUZ5ZouLvNwZVP8+Ju4aUatcm1UED7wvrspHS+TPdT8Wp667J4oEVN3NqdwNZE26GHRi8eCaEBQuujEDrhIEO4kI=
X-Received: by 2002:a25:5f4d:0:b0:bcb:caf8:7aae with SMTP id
 h13-20020a255f4d000000b00bcbcaf87aaemr10348976ybm.44.1687308497348; Tue, 20
 Jun 2023 17:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-16-atrajeev@linux.vnet.ibm.com> <ZIjMWUk/axKfMCM4@kernel.org>
In-Reply-To: <ZIjMWUk/axKfMCM4@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 17:48:05 -0700
Message-ID: <CAM9d7cjrpaNk0UC22ntBSP+LzQwT2YAHwQ2o3z1aayAZNQ329g@mail.gmail.com>
Subject: Re: [PATCH 15/17] perf tests task_analyzer: fix bad substitution ${$1}
To:     Hagen Paul Pfeifer <hagen@jauu.net>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Aditya Gupta <adityag@linux.ibm.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
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

Hello,

On Tue, Jun 13, 2023 at 1:06 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jun 13, 2023 at 10:11:43PM +0530, Athira Rajeev escreveu:
> > From: Aditya Gupta <adityag@linux.ibm.com>
> >
> > ${$1} gives bad substitution error on sh, bash, and zsh. This seems like
> > a typo, and this patch modifies it to $1, since that is what it's usage
> > looks like from wherever `check_exec_0` is called.
>
> Nicely spotted!
>
> Please add the people that last touched the problem to the cc list,
> specially when it fixes a bug.
>
> Thanks for adding a Fixes tag, that helps the stable@kernel.org guys to
> get this propagated to supported kernel releases.
>
> I've added the test author to the CC list in this message.
>
> thanks!
>
> - Arnaldo
>
> > This issue due to ${$1} caused all function calls to give error in
> > `find_str_or_fail` line, and so no test runs completely. But
> > 'perf test "perf script task-analyzer tests"' wrongly reports
> > that tests passed with the status OK, which is wrong considering
> > the tests didn't even run completely
> >
> > Fixes: e8478b84d6ba ("perf test: add new task-analyzer tests")
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---

I'm seeing a different error even after this fix.
Can you please take a look?

Thanks,
Namhyung


$ sudo ./perf test -v task
114: perf script task-analyzer tests                                 :
--- start ---
test child forked, pid 1771042
Please specify a valid report script(see 'perf script -l' for listing)
FAIL: "invocation of perf command failed" Error message: ""
FAIL: "test_basic" Error message: "Failed to find required string:'Comm'."
Please specify a valid report script(see 'perf script -l' for listing)
FAIL: "invocation of perf command failed" Error message: ""
FAIL: "test_ns_rename" Error message: "Failed to find required string:'Comm'."
...
test child finished with -1
---- end ----
perf script task-analyzer tests: FAILED!
