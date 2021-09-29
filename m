Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EB4C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 17:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B02F613A5
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 17:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbhI2RQJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 13:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345367AbhI2RQI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Sep 2021 13:16:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34D9061052;
        Wed, 29 Sep 2021 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632935667;
        bh=QRT81ol30QYMdX4x58oQVOt0/3wqgrWhENxKrgzQ5Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5geUBo4iw42fgTwiYY1nvKnKtkmwSOIgMbJZsAO4SUm7di5IkO3J1CTU74zRYOn5
         oEVLKirjENE/iIZ0zbjb3Dj/q99ukAEZ3aQL28VDo6njS8b8IhP8dw9Q9aebCA1otM
         lQZmZFDsX8cs8J0ROQu2FFGXRx/LNLvK3I+IIhOHHkeljnsuC2NiIf0hMG9GZcmMGD
         XH2WP4kIZJ5vcy4j5025NC2J8VKQ463WLo6NfjH6JqY2jnFXYvOmnK+eoXsapCrjq6
         12dtOyzxzHeW5u5Ohh/a3Yuu3AEefLiPNjG/DKGhCj5btjVN0NQiSicQ6qA00BI5BK
         0DKyBpsn/+Wew==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ECF2D410A1; Wed, 29 Sep 2021 14:14:24 -0300 (-03)
Date:   Wed, 29 Sep 2021 14:14:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH] perf tests vmlinux-kallsyms: ignore hidden symbols
Message-ID: <YVSe8Fv6YAbuLJFQ@kernel.org>
References: <20210922152706.23655-1-mpetlan@redhat.com>
 <CAP-5=fUN_fYmgm69ruBvp6E+nkLKsTvZwHqGzaRd471MhMRykA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUN_fYmgm69ruBvp6E+nkLKsTvZwHqGzaRd471MhMRykA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Sep 22, 2021 at 09:36:11AM -0700, Ian Rogers escreveu:
> On Wed, Sep 22, 2021 at 8:27 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > Certain kernel symbols are purposely hidden from kallsyms. The function
> > is_ignored_symbol() from scripts/kallsyms.c decides if a symbol should
> > be hidden or not.
> >
> > The perf test "vmlinux symtab matches kallsyms" fails in case perf finds
> > some of the hidden symbols in its machine image and can't match them to
> > kallsyms.
> >
> > Let's add a filter to check if a symbol not found isn't one of these
> > before failing the test.
> >
> > The function is_ignored_symbol() has been copied from scripts/kallsyms.c
> > and needs to be updated along with the original.
> >
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> It is a shame this can't be a library to ensure the function is kept in sync.

Thanks, applied.

- Arnaldo

