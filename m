Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38456C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Mar 2022 08:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiCKI3L (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Mar 2022 03:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiCKI3J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Mar 2022 03:29:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D6B6D04
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Mar 2022 00:28:03 -0800 (PST)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KFJvg4hTYz681Yv;
        Fri, 11 Mar 2022 16:27:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 09:28:00 +0100
Received: from [10.47.87.13] (10.47.87.13) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 08:27:59 +0000
Message-ID: <ebde0845-fa4b-0e6c-c9e6-6c8d27377952@huawei.com>
Date:   Fri, 11 Mar 2022 08:27:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/2] perf: Fix version kernel tag
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <olsajiri@gmail.com>,
        <rric@kernel.org>, <ak@linux.intel.com>
References: <1645449409-158238-1-git-send-email-john.garry@huawei.com>
 <1645449409-158238-3-git-send-email-john.garry@huawei.com>
 <CAP-5=fXT3VYB2uBXmihuruq==FENLFcFSHMLY0Fk29pRvU-wag@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAP-5=fXT3VYB2uBXmihuruq==FENLFcFSHMLY0Fk29pRvU-wag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.87.13]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/03/2022 02:18, Ian Rogers wrote:
>     Generating the version kernel tag relies on "git describe" command
>     to get
>     the latest Linus kernel tag.
> 
>     However, when working from clones of Linus' git we may not have the
>     latest
>     tag. For example, when working on Arnaldo's acme.git, we can have this:
>     $git branch
>     perf/core
>     $head -n 5 ../../Makefile
>     head -n 5 ../../Makefile  | tail -n 4
>     VERSION = 5
>     PATCHLEVEL = 17
>     SUBLEVEL = 0
>     EXTRAVERSION = -rc3
>     $ git describe --abbrev=0 --match "v[0-9].[0-9]*"
>     v4.13-rc5
> 

Hi Ian,

Thanks for having a look.

> 
> I'm a little confused by this, isn't the "git branch" showing your local 
> branch? For me:
> 
> $git branch
> acme
> $git status
> On branch acme
> Your branch is up to date with 'acme/perf/core'.
> $git describe --abbrev=0 --match "v[0-9].[0-9]*"
> v5.17-rc4
> $git remote show acme
> * remote acme
>    Fetch URL: 
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git 
> <http://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git>
>    Push  URL: 
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git 
> <http://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git>
> ...
> $ /tmp/perf/perf --version
> perf version 5.17.rc4.g56dce868198c
> 
> Is your branch tracking acme/master ?

I was following acme/perf/core but I don't think that it is so important.

The difference is that I am working from a clone of acme/linux.git and 
so torvalds/linux.git is a remote for me. I assume that you have a clone 
of torvalds/linux.git

That means that if my clone of acme git does not pull in the tags from 
torvalds git then "git describe" gives a wrong result.

Please check this experiment:

john@localhost:~> git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git acme_test
Cloning into 'acme_test'...
remote: Enumerating objects: 59, done.
remote: Counting objects: 100% (59/59), done.
remote: Compressing objects: 100% (3/3), done.

...

john@localhost:~> cd acme_test/

john@localhost:~/acme_test> git checkout remotes/origin/perf/core -B 
perf/core
Updating files: 100% (58299/58299), done.
Branch 'perf/core' set up to track remote branch 'perf/core' from 'origin'.
Switched to a new branch 'perf/core'

john@localhost:~/acme_test> git describe --abbrev=0 --match "v[0-9].[0-9]*"
v4.13-rc5

john@localhost:~/acme_test> head -n 5 Makefile  | tail -n 4
VERSION = 5
PATCHLEVEL = 17
SUBLEVEL = 0
EXTRAVERSION = -rc4

john@localhost:~/acme_test> git remote add torvalds 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

john@localhost:~/acme_test> git fetch torvalds
remote: Enumerating objects: 1516, done.
remote: Counting objects: 100% (1516/1516), done.
remote: Compressing objects: 100% (413/413), done.
remote: Total 1944 (delta 1202), reused 1314 (delta 1098), pack-reused 428
Receiving objects: 100% (1944/1944), 1.68 MiB | 5.12 MiB/s, done.
Resolving deltas: 100% (1270/1270), completed with 400 local objects.
 From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
  * [new branch]                master            -> torvalds/master

...

  * [new tag]                   v5.17-rc2         -> v5.17-rc2
  * [new tag]                   v5.17-rc3         -> v5.17-rc3
  * [new tag]                   v5.17-rc4         -> v5.17-rc4
  * [new tag]                   v5.17-rc5         -> v5.17-rc5
  * [new tag]                   v5.17-rc6         -> v5.17-rc6

...

john@localhost:~/acme_test> git describe --abbrev=0 --match "v[0-9].[0-9]*"
v5.17-rc4

So you can see that "git describe" gives the wrong result (v4.13-rc5) 
before we pull in torvalds git.

My point is that git tags are unreliable and we should avoid them.

Thanks,
John
