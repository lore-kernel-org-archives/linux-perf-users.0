Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9547C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 11:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD287610FF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 11:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhJ1LUJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhJ1LUJ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 07:20:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 219CF60230;
        Thu, 28 Oct 2021 11:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635419862;
        bh=J8jy9tuBckxRSi+qIzZp/xilQsnDoDURjsHWfnqtDdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tC6izQdbp5n0P4O8e3dhxQipAZ3kVKU0SOOme0MCrB1GIwtKketSY3QCSF7XtYCk2
         Q6avK3hc4x/eKpcI/696GUi8ZUg3lJsaNt/Dv2GoH2h28eFfjju0/jhO2R8j4apUCR
         T1RVgxYNSAw+hxuD68hm71BCFtm6Dlt/Tu09tgrTxJ9FzeMAxi/87cz2L+Lwoz+0zg
         qtJ+qNbFkLfboefEUMXTS+soNIjMLNX3fTMjUy6w5VyogsK2vrMOyeFdHgHUK4jQCK
         VUunEWbKlY8VLNKRjxfVW7+jsr9alkKGnnT3eOKiFzumnkwTSTBb9bys51KGoNFulC
         WSVZ2keYBCDqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ED516410A1; Thu, 28 Oct 2021 08:17:38 -0300 (-03)
Date:   Thu, 28 Oct 2021 08:17:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "irogers@google.com" <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "james.clark@arm.com" <james.clark@arm.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Enable warnings through HOSTCFLAGS
Message-ID: <YXqG0jb4qg4+x5DE@kernel.org>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
 <1634807805-40093-3-git-send-email-john.garry@huawei.com>
 <YXFhr2YoVp9GPsDM@krava>
 <86aee893-0b6b-bce3-d1aa-3b66365592d1@huawei.com>
 <YXaXvGgvs4gr8Cgi@krava>
 <YXbZa8SaQta9pzHS@kernel.org>
 <32d98804-7e56-e73b-4c66-8776dbf58ddf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d98804-7e56-e73b-4c66-8776dbf58ddf@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 28, 2021 at 09:23:58AM +0100, John Garry escreveu:
> On 25/10/2021 17:20, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Oct 25, 2021 at 01:40:44PM +0200, Jiri Olsa escreveu:
> > > On Fri, Oct 22, 2021 at 10:42:11AM +0100, John Garry wrote:
> > > > On 21/10/2021 13:48, Jiri Olsa wrote:
> > > > ok, so IIRC, then the rule for building .o from .c in
> > > > tools/build/Makefile.build will pick up HOSTCFLAGS through this variable, so
> > > > we then don't need to explicitly mention it in the per-target rule, so can
> > > > have this as before in pmu-events/Build

> > > > HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include

> > > > right?

> > > > (Indeed I guess that we can get rid of -I$(srctree)/tools/include as well)

> > > hm, the -I.. should stay no? I don't see that
> > > it's being added soem other way

> > Probably this change from KBUILD_HOSTCFLAGS back to HOSTCFLAGS should
> > come with this;

> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Fixes: 96f14fe738b69dd9 ("kbuild: Rename HOSTCFLAGS to KBUILD_HOSTCFLAGS")

> > Right?
 
> Maybe, but then renaming back from KBUILD_HOSTCFLAGS -> HOSTCFLAGS seems odd
> as a fix
 
> Anyway, now that this original series is in perf/core,

Nope, just this one landed:

commit 342cb7ebf5e29fff4dc09ab2c8f37d710f8f5206
Author: John Garry <john.garry@huawei.com>
Date:   Thu Oct 21 17:16:44 2021 +0800

    perf jevents: Fix some would-be warnings

---

The one you asked to wait for further discussion wasn't merged.

- Arnaldo

> I'll send patches on top with this change, cc'ing Laura and Masahiro
