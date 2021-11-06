Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B87C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 19:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D066112D
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 19:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhKFTzq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhKFTzp (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Nov 2021 15:55:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C74A61054;
        Sat,  6 Nov 2021 19:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636228384;
        bh=qOGVHV2slOC5KIVm+e1qOM8RcHuz8RRw18Wkv9dHLGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFcAv2qBwo6SX9n6aQ+4q0Uyjo7i879ialfqOLPD4spS8Sweh3QPkd0s7uMyrBzPc
         KFVzmcJKhr1bl2YEelz/R+eA4nPyVqViwpSiPZ54170W2M11XXfqsXsiGh/0VlieI2
         L8UUu19g47Wee1/lS59TkSVourVJbbWK4JFp3kNheT7hNrMf3Yb7elcRIfFZrqlgnx
         JLt6LVLDUXmOlwxl9joReuVpC4buZFNl12rt+hHCmuD8nvjNrZvA72ugusnXvexe/F
         sTQyaclbHzSzpfMJlDwqmY5wFXPcB9f3k6XFLKytIquuyt6QzlhkWxKsxT+GjJNTr8
         YjQidxwULyKRQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38D31410A1; Sat,  6 Nov 2021 16:53:02 -0300 (-03)
Date:   Sat, 6 Nov 2021 16:53:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Denis Nikitin <denik@chromium.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf inject: Add vmlinux and ignore-vmlinux arguments
Message-ID: <YYbdHl8GXosMn8rX@kernel.org>
References: <20211018134844.2627174-1-james.clark@arm.com>
 <20211018134844.2627174-4-james.clark@arm.com>
 <CADDJ8CWoHb28JDjxq+ZtFVTUXQjhtFTszjeeXKx1WMue8zBp2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADDJ8CWoHb28JDjxq+ZtFVTUXQjhtFTszjeeXKx1WMue8zBp2A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Nov 05, 2021 at 09:19:10PM -0700, Denis Nikitin escreveu:
> On Mon, Oct 18, 2021 at 6:49 AM James Clark <james.clark@arm.com> wrote:
> >
> > Other perf tools allow specifying the path to vmlinux. Perf inject
> > didn't have this argument which made some auxtrace workflows difficult.
> >
> > Also add ignore-vmlinux for consistency with other tools.
> >
> > Suggested-by: Denis Nitikin <denik@chromium.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/builtin-inject.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index 6ad191e731fc..4261ad89730f 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -938,6 +938,10 @@ int cmd_inject(int argc, const char **argv)
> >  #endif
> >                 OPT_INCR('v', "verbose", &verbose,
> >                          "be more verbose (show build ids, etc)"),
> > +               OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
> > +                          "file", "vmlinux pathname"),
> > +               OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
> > +                           "don't load vmlinux even if found"),
> 
> I think we also need to update documentation at Documentation/perf-inject.txt

I can replicate what is in 'perf report' where this came from, will do
it now.
 
> >                 OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name, "file",
> >                            "kallsyms pathname"),
> >                 OPT_BOOLEAN('f', "force", &data.force, "don't complain, do it"),
> > @@ -972,6 +976,9 @@ int cmd_inject(int argc, const char **argv)
> >                 return -1;
> >         }
> >
> > +       if (symbol__validate_sym_arguments())
> > +               return -1;
> > +
> >         if (inject.in_place_update) {
> >                 if (!strcmp(inject.input_name, "-")) {
> >                         pr_err("Input file name required for in-place updating\n");
> > --
> > 2.28.0
> >
> 
> Tested-by: Denis Nikitin <denik@chromium.org>

Thanks,

- Arnaldo
