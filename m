Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D01C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 18:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B160C610E6
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 18:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhHXSD7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238629AbhHXSDx (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 14:03:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F0D0610D0;
        Tue, 24 Aug 2021 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629828189;
        bh=6+xeVzOAhY7yu4NJoUhz/MQdr0MvjHaPrV6CCAoQ9HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQ0cj3GrhI2zHosqh8PGmQwEj420cq4WijwVnmbEVvwr0xW4YodC4ykABR9dUKH11
         FVPdSO91BYizeS1lf3m/4PEAAlCMepN7CLvjLEXD+emFjTpObV2+L5Fry0WETbEDoA
         /kjDlWxIllfxCL6JdR+9sUzLZKLOWfI+NEGiPkwMRHsvZPOWTlQZiNhRTZQmE942UD
         JaqOHN+/Tt/y1R5xdYAZ+HnW2xvrYm+c4PUFiXozy9rR9EHLuehKcKkfT7drBkjo76
         cAc1cUyOuk9bo7apLAxSxSIIbhj803zU4t7u0ks9ylHgrf5lKkm2/cqXUyvnQNnr6d
         b/Ox10nhcLABw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 303FD4007E; Tue, 24 Aug 2021 15:03:07 -0300 (-03)
Date:   Tue, 24 Aug 2021 15:03:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Nghia Le <nghialm78@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add missing newline at the end of file
Message-ID: <YSU0W9L/TWhyQd6y@kernel.org>
References: <20210824085947.224062-1-nghialm78@gmail.com>
 <CAKXUXMzbJRHyUpFLGk8SBJHrkmkwq4VtfXmgvZtUBJGiED8qxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMzbJRHyUpFLGk8SBJHrkmkwq4VtfXmgvZtUBJGiED8qxw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 24, 2021 at 04:37:19PM +0200, Lukas Bulwahn escreveu:
> On Tue, Aug 24, 2021 at 11:00 AM Nghia Le <nghialm78@gmail.com> wrote:
> >
> > Add missing newline at the end of file parse-sublevel-options.h.
> > Thus removing relevant warning reported by checkpatch.
> >
> > Signed-off-by: Nghia Le <nghialm78@gmail.com>
> 
> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>


Thanks, applied.

- Arnaldo

 
> This addresses the only instance of a "no newline at the end of the
> file" throughout the kernel tree.
> 
> This is part of a larger effort to identify all rules that checkpatch
> warns about and that are never false positives (compared to the many
> rules in checkpatch that are heuristics or are known to be ignored by
> the current development community and hence, cause many false
> positives). We could use such rules to be enforced in the submission
> process.
> 
> Lukas
> Lukas
> > ---
> >  tools/perf/util/parse-sublevel-options.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/parse-sublevel-options.h b/tools/perf/util/parse-sublevel-options.h
> > index 9b9efcc2aaad..578b18ef03bb 100644
> > --- a/tools/perf/util/parse-sublevel-options.h
> > +++ b/tools/perf/util/parse-sublevel-options.h
> > @@ -8,4 +8,4 @@ struct sublevel_option {
> >
> >  int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
> >
> > -#endif
> > \ No newline at end of file
> > +#endif
> > --
> > 2.25.1
> >

-- 

- Arnaldo
