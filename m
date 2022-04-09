Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D0C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  9 Apr 2022 15:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiDIPlE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 9 Apr 2022 11:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiDIPlD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 9 Apr 2022 11:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5E58F99C
        for <linux-perf-users@vger.kernel.org>; Sat,  9 Apr 2022 08:38:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B5A60B30
        for <linux-perf-users@vger.kernel.org>; Sat,  9 Apr 2022 15:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B6FC385A0;
        Sat,  9 Apr 2022 15:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649518734;
        bh=pDNJhxSm31sYytwZsjmFHwFuGWVQZufcT4dXj5WtH+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkuHDqv5Im1nRndV86Jw8RoyyEQ6gtsY6b2b8X+TRUhrP40L3i3i9uZcnzWAt+fLX
         Ap1XZoXBkn/tHMMN3kZLLo2fKYEm9PhQDMGvIOXBQXJfAT2Lh0yMEYF4WjnUtYHTun
         ErEXWdMn0np29hk6zO7fmWRCCWt1KQ2Y+a8vRB9MGRlje83emwb8qa+Su0UfE2hWW7
         F9CBE+Dl6ZiRxj6jIIRioBaonZxAbX6FHyCPb/f1r78pGC8Q+2I9koyqb2zUr6cWwg
         cDqHAWjDkOjhsF9mabShDZTsf/lQmrZMoJ4YrzFBiLtoo16VrClmXlKhK6qNRTBG4n
         lckqD3ctEOcCQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B8C440407; Sat,  9 Apr 2022 12:38:51 -0300 (-03)
Date:   Sat, 9 Apr 2022 12:38:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, acme@redhat.com, jolsa@kernel.org
Subject: Re: [PATCH 2/2] perf: Add external commands to list-cmds
Message-ID: <YlGoiyhJRe31yIrp@kernel.org>
References: <20220404221541.30312-1-mpetlan@redhat.com>
 <20220404221541.30312-2-mpetlan@redhat.com>
 <CAP-5=fXo+gU1YwnHdWwk+5WNSOu9=V7WT7VknabwNnz0Lycxjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXo+gU1YwnHdWwk+5WNSOu9=V7WT7VknabwNnz0Lycxjw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Apr 05, 2022 at 01:54:21PM -0700, Ian Rogers escreveu:
> On Mon, Apr 4, 2022 at 3:59 PM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > The `perf --list-cmds` output prints only internal commands, although
> > there is no reason for that from users' perspective.
> >
> > Adding the external commands to commands array with NULL function
> > pointer allows printing all perf commands while not changing the logic
> > of command handler selection.
> >
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/perf.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index 2f6b67189b42..91eb36ec6f1c 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -55,6 +55,7 @@ struct cmd_struct {
> >  };
> >
> >  static struct cmd_struct commands[] = {
> > +       { "archive",    NULL,   0 },
> >         { "buildid-cache", cmd_buildid_cache, 0 },
> >         { "buildid-list", cmd_buildid_list, 0 },
> >         { "config",     cmd_config,     0 },
> > @@ -62,6 +63,7 @@ static struct cmd_struct commands[] = {
> >         { "diff",       cmd_diff,       0 },
> >         { "evlist",     cmd_evlist,     0 },
> >         { "help",       cmd_help,       0 },
> > +       { "iostat",     NULL,   0 },
> >         { "kallsyms",   cmd_kallsyms,   0 },
> >         { "list",       cmd_list,       0 },
> >         { "record",     cmd_record,     0 },
> > @@ -360,6 +362,8 @@ static void handle_internal_command(int argc, const char **argv)
> >
> >         for (i = 0; i < ARRAY_SIZE(commands); i++) {
> >                 struct cmd_struct *p = commands+i;
> > +               if (p->fn == NULL)
> > +                       continue;
> >                 if (strcmp(p->cmd, cmd))
> >                         continue;
> >                 exit(run_builtin(p, argc, argv));
> > --
> > 2.18.4
> >

-- 

- Arnaldo
