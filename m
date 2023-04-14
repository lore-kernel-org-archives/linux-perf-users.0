Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDADDC77B6E
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Apr 2023 09:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDNJdJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Apr 2023 05:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNJdI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Apr 2023 05:33:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F274EFB;
        Fri, 14 Apr 2023 02:33:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 462C31FD93;
        Fri, 14 Apr 2023 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681464786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anqanL63WzuuA9OTxdiLBvl46hTjKTc57YdQQgadd/o=;
        b=wI2sOsws/cqozSHTbYsvf8p7/178t/09nwrSCD3YknFaOZsJlSrl56FMu5dI+8lrj2vBgD
        ArUkAR2Papy1w+DijTuDEb07vK3XtSyymKpCiQydUTjGNC0FMwNUR4zM5s2oL+iYL7V4Zv
        PIVNAOCRy8elJRda0qdrWWNzzQf0A54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681464786;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anqanL63WzuuA9OTxdiLBvl46hTjKTc57YdQQgadd/o=;
        b=UVoCOv8xtrWLrmFnzvFTAMyKVOxL9TIH1CKL0P9VLX5vXSeacUQsignMRTVoQFU6C1eW2U
        DQy6SmKonVkPPXCw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A6DE52C143;
        Fri, 14 Apr 2023 09:33:05 +0000 (UTC)
Date:   Fri, 14 Apr 2023 11:33:04 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
Message-ID: <20230414093304.GE63923@kunlun.suse.cz>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <ZDfQYHJyJOrR5pcB@syu-laptop>
 <CACdoK4JemtGV9m=kuddE4eZQgfTNj1OqhwfhLpDcsspTvfZx7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdoK4JemtGV9m=kuddE4eZQgfTNj1OqhwfhLpDcsspTvfZx7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Fri, Apr 14, 2023 at 02:12:40AM +0100, Quentin Monnet wrote:
> On Thu, 13 Apr 2023 at 10:50, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > On Thu, Apr 13, 2023 at 05:23:16PM +0800, Shung-Hsi Yu wrote:
> > > Hi,
> > >
> > > I'm considering switch to bpftool's mirror on GitHub for packaging (instead
> > > of using the source found in kernel), but realize that it should goes
> > > hand-in-hand with how libbpf is packaged, which eventually leads these
> > > questions:
> > >
> > >   What is the suggested approach for packaging bpftool and libbpf?
> > >   Which source is preferred, GitHub or kernel?

...

> > But I wonder whether packaging one of the motives to create the mirrors
> > initially? Can't seem to find anything in this regard.
> >
> >
> > 1: https://github.com/acmel/dwarves/tree/master/lib
> > 2: https://lore.kernel.org/bpf/CAEf4BzZ+0XpH_zJ0P78vjzmFAH3kGZ21w3-LcSEG=B=+ZQWJ=w@mail.gmail.com/
> 
> It seems like you haven't come across this one?:
> https://lore.kernel.org/bpf/267a35a6-a045-c025-c2d9-78afbf6fc325@isovalent.com/t/
> 
> Yes, easing packaging was one of the motivations for the mirror. As
> mentioned in my other answer, I've not taken the time to reach out to
> package maintainers yet, so this hasn't really materialised at this
> point.

For me as a package maintainer submodules are a major pain. They always
need special handling, break down, get out of sync between different
projects using them, etc.

Somehow in the past it was possible to build and install development
versions of libraries during development of tools using them, and
release both when a feature was finished.

Arguably using submodules for development may work for some people. For
most it would cause having the wrong submodule code when switching
branches, stray submodule changes in patches, etc.

Using submodules as a general method of distributing dependencies is
hell.

The usual methods of downloading and releasing the source code don't
work, the submodules have to be specifically bundled.

If the dependency in question has a bug each tool author has to be
coaxed to update to a fixed version and re-release, or each tool patched
separately.

Over time API bitrots and is given up, each tool requiring specific and
different release or git SHA of the dependency. We can see that
happening a lot in ecosystems where vendoring is the norm.

Thanks

Michal
