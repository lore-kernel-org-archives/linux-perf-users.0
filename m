Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E5DC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Mar 2022 22:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbiCNWNo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Mar 2022 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiCNWNn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Mar 2022 18:13:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467A13C72D
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Mar 2022 15:12:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so379863wmq.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Mar 2022 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=deYMzCeSeX0HO53o1GTJ/pdHqEp2rXpmLBf161Wqo6o=;
        b=MrhR4SSCIC5nD3u4tkwowRe0RBwdxcxmGNVdzqq3C1uEonjECmPAh9mJHPxb3bqHxV
         lkHzAohBRO9BqFeV4AlGiUjOoVV4Q5yyVQWt7HjtUj4Y9d5WAsYuPbU8PjrhKwHKzAOA
         xf5bxuhfpet56+RG/e/ROuhMxdbtZ5eBzjOlgWdDz+K4Tp5hJ56xH2sAtY9o9Mo1fcow
         pcsdQTAfb//tE4q1FrHEN775kUXKzIAlHx2uB70IDM7iQxLn5YXcCdW6TT08LjgDOPqd
         mPYKRKeKVmHK9dgrYEo4qPZiLETJ7XPvjo+TpumEbSPWOSvyYl+Y352yhMTKCHeoUQYZ
         5G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=deYMzCeSeX0HO53o1GTJ/pdHqEp2rXpmLBf161Wqo6o=;
        b=r1uPAkJ58vsSMbijltO1x65nfMO4J+zKRyjYl4YsI87m8ovL1J62wo2svVOkm0yk9T
         c+4ZvnAQSN2cLGSOBAdZyysNH+WMI0MpYMkI6EaEq2WRTYNd6DPgOgNDm81PZwzKeuBu
         VqWmW77WTkOiEyXjpynM3hZ4eCwGl15m5/XJmEbV736tLQ9ae3u1mXxvsIGrjARp/kpN
         xxx6hv056nmkPOO/4VjIuVd/5TM2DOLT6XTBSEKdVPPQOQSHdflcYBfEBjUXCgrhg8+S
         vZLLc79vpj0YE+eb+U4wbTCCAVipzX1OpqbW+17fYC1O8l9U9BFfT6Ll3A3dbHsBTT4L
         /Wcw==
X-Gm-Message-State: AOAM530+Uzn0xEmVzrQjiPkIVaPg12G1Mfv/e/XHgULQQ5AYspjOzVZ4
        sdtclN2uJUILZnQynCb0p72EvAUcFui6p0kTYl2f0g==
X-Google-Smtp-Source: ABdhPJw/OCgVb3K0D1sBSFXF6NI1hMFneRzwCXSBfWrXk2aTag+SsZYih4X5DzqeHFlJRHr+vJCFSjRs5rVEDphKo98=
X-Received: by 2002:a05:600c:4881:b0:381:1f8f:5299 with SMTP id
 j1-20020a05600c488100b003811f8f5299mr902674wmp.149.1647295951494; Mon, 14 Mar
 2022 15:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <1645449409-158238-1-git-send-email-john.garry@huawei.com>
 <1645449409-158238-3-git-send-email-john.garry@huawei.com>
 <CAP-5=fXT3VYB2uBXmihuruq==FENLFcFSHMLY0Fk29pRvU-wag@mail.gmail.com> <ebde0845-fa4b-0e6c-c9e6-6c8d27377952@huawei.com>
In-Reply-To: <ebde0845-fa4b-0e6c-c9e6-6c8d27377952@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Mar 2022 15:12:19 -0700
Message-ID: <CAP-5=fUHbuhFeUPTktithxc=NR5ahhF66jWQ2xOZKA=Azj96NQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf: Fix version kernel tag
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, olsajiri@gmail.com,
        rric@kernel.org, ak@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Mar 11, 2022 at 12:28 AM John Garry <john.garry@huawei.com> wrote:
>
> On 11/03/2022 02:18, Ian Rogers wrote:
> >     Generating the version kernel tag relies on "git describe" command
> >     to get
> >     the latest Linus kernel tag.
> >
> >     However, when working from clones of Linus' git we may not have the
> >     latest
> >     tag. For example, when working on Arnaldo's acme.git, we can have this:
> >     $git branch
> >     perf/core
> >     $head -n 5 ../../Makefile
> >     head -n 5 ../../Makefile  | tail -n 4
> >     VERSION = 5
> >     PATCHLEVEL = 17
> >     SUBLEVEL = 0
> >     EXTRAVERSION = -rc3
> >     $ git describe --abbrev=0 --match "v[0-9].[0-9]*"
> >     v4.13-rc5
> >
>
> Hi Ian,
>
> Thanks for having a look.
>
> >
> > I'm a little confused by this, isn't the "git branch" showing your local
> > branch? For me:
> >
> > $git branch
> > acme
> > $git status
> > On branch acme
> > Your branch is up to date with 'acme/perf/core'.
> > $git describe --abbrev=0 --match "v[0-9].[0-9]*"
> > v5.17-rc4
> > $git remote show acme
> > * remote acme
> >    Fetch URL:
> > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> > <http://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git>
> >    Push  URL:
> > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> > <http://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git>
> > ...
> > $ /tmp/perf/perf --version
> > perf version 5.17.rc4.g56dce868198c
> >
> > Is your branch tracking acme/master ?
>
> I was following acme/perf/core but I don't think that it is so important.
>
> The difference is that I am working from a clone of acme/linux.git and
> so torvalds/linux.git is a remote for me. I assume that you have a clone
> of torvalds/linux.git
>
> That means that if my clone of acme git does not pull in the tags from
> torvalds git then "git describe" gives a wrong result.
>
> Please check this experiment:
>
> john@localhost:~> git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git acme_test
> Cloning into 'acme_test'...
> remote: Enumerating objects: 59, done.
> remote: Counting objects: 100% (59/59), done.
> remote: Compressing objects: 100% (3/3), done.
>
> ...
>
> john@localhost:~> cd acme_test/
>
> john@localhost:~/acme_test> git checkout remotes/origin/perf/core -B
> perf/core
> Updating files: 100% (58299/58299), done.
> Branch 'perf/core' set up to track remote branch 'perf/core' from 'origin'.
> Switched to a new branch 'perf/core'
>
> john@localhost:~/acme_test> git describe --abbrev=0 --match "v[0-9].[0-9]*"
> v4.13-rc5
>
> john@localhost:~/acme_test> head -n 5 Makefile  | tail -n 4
> VERSION = 5
> PATCHLEVEL = 17
> SUBLEVEL = 0
> EXTRAVERSION = -rc4
>
> john@localhost:~/acme_test> git remote add torvalds
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> john@localhost:~/acme_test> git fetch torvalds
> remote: Enumerating objects: 1516, done.
> remote: Counting objects: 100% (1516/1516), done.
> remote: Compressing objects: 100% (413/413), done.
> remote: Total 1944 (delta 1202), reused 1314 (delta 1098), pack-reused 428
> Receiving objects: 100% (1944/1944), 1.68 MiB | 5.12 MiB/s, done.
> Resolving deltas: 100% (1270/1270), completed with 400 local objects.
>  From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
>   * [new branch]                master            -> torvalds/master
>
> ...
>
>   * [new tag]                   v5.17-rc2         -> v5.17-rc2
>   * [new tag]                   v5.17-rc3         -> v5.17-rc3
>   * [new tag]                   v5.17-rc4         -> v5.17-rc4
>   * [new tag]                   v5.17-rc5         -> v5.17-rc5
>   * [new tag]                   v5.17-rc6         -> v5.17-rc6
>
> ...
>
> john@localhost:~/acme_test> git describe --abbrev=0 --match "v[0-9].[0-9]*"
> v5.17-rc4
>
> So you can see that "git describe" gives the wrong result (v4.13-rc5)
> before we pull in torvalds git.
>
> My point is that git tags are unreliable and we should avoid them.


(Plain text resend)

Got it, thanks for the detailed explanation!

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
> Thanks,
> John
