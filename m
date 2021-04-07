Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD59C43462
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Apr 2021 19:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4943161279
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Apr 2021 19:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345697AbhDGTbB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Apr 2021 15:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345553AbhDGTbA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Apr 2021 15:31:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4671B6023C;
        Wed,  7 Apr 2021 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617823849;
        bh=7cOMNq1oMwTCv3juIjgFhKSa19070uFirkx4n4/BBsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtT22GKUtbi11GFZ9alnrNwmmDviqxSGHGbLzKRykT60p+d4dGgl7nyHJAn5WcqD4
         aa8xtgLjHlNycKgS6IOBULiGZPkGzZA87OEf46pRoPO1ypvrlEdaOwdqoC2iy2pkvp
         g8K1hIOu2eUiBFJEa6qMisaqW0aEdvEBKFPE4uBERgdk41roMc1vIO/VCnUtB0yDGB
         F2yay5tEtre1w/6ELD4Od7rUWQ30LG2aK++Cm76zHO5NRaijFGVCO7aQsZlSMOBt9v
         ib+zc6ThRxWqSFE4MYZZovnUXXksxjeRMEWOOsJTn7aFKOLwyYE/ph9xhCuLUMX/AN
         ZzBCKA0xdKhrg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A3A5640647; Wed,  7 Apr 2021 16:30:46 -0300 (-03)
Date:   Wed, 7 Apr 2021 16:30:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate: improve --stdio mode
Message-ID: <YG4IZhfYiE+2tyw7@kernel.org>
References: <a0d53f31-f633-5013-c386-a4452391b081@suse.cz>
 <YDVb4KS/ARbtfoAw@kernel.org>
 <fedc723d-1c8f-fcd7-accb-421707b3a09f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fedc723d-1c8f-fcd7-accb-421707b3a09f@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Feb 26, 2021 at 10:24:00AM +0100, Martin Liška escreveu:
> On 2/23/21 8:47 PM, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Feb 21, 2021 at 01:46:36PM +0100, Martin Liška escreveu:
> > > The patch changes the output format in 2 ways:
> > > - line number is displayed for all source lines (matching TUI mode)
> > 
> > Are you aware of 'perf annotate --stdio2' ? If the goal is to make the
> > stdio mode better, doing it in that mode would be best, as it was done
> > to share as much code as possible, not just the looks, with the TUI
> > mode.
> 
> Yes, I'm aware of it. My motivation is to generate a HTML perf annotate report
> and I see the following parts of --stdio2 not ideal:
> 
> - coloring is not available (--stdio-color=always does not work)
> - 'Sorted summary for file ' is missing so one can't easily search for
>   hot spots in browser
> - source line number are displayed, but not the source files
> - there's a missing option for 'Toggle disassembler output/simplified view' which
>   is available in TUI mode
> 
> That said, the stdio2 annotation report is quite different and so handy for my use case.

I'll add these to my TODO list, all valid concerns. And being able to
directly generate some sort of HTML with CSS, etc also seems a great
feature to have.

- Arnaldo
 
> > 
> > I kept --stdio around because changing the output in that way could
> > annoy people used to that format.
> 
> Sure. But I think the current format provides quite broken visual layout:
> 
>       0.00 :   405ef1: inc    %r15
>       0.01 :   405ef4: vfmadd213sd 0x2b9b3(%rip),%xmm0,%xmm3        # 4318b0 <_IO_stdin_used+0x8b0>
>    eff.c:1811    0.67 :   405efd: vfmadd213sd 0x2b9b2(%rip),%xmm0,%xmm3        # 4318b8 <_IO_stdin_used+0x8b8>
>           :            TA + tmpsd * (TB +
> 
> vs.
> 
>       0.00 :   405ef1: inc    %r15
>       0.01 :   405ef4: vfmadd213sd 0x2b9b3(%rip),%xmm0,%xmm3        # 4318b0 <_IO_stdin_used+0x8b0>
>       0.67 :   405efd: vfmadd213sd 0x2b9b2(%rip),%xmm0,%xmm3        # 4318b8 <_IO_stdin_used+0x8b8> // eff.c:1811
>            : 1810   TA + tmpsd * (TB +
> 
> I bet also the current users of --stdio mode would benefit from it.
> What do you think?

Agreed, I tried applying but it bitrotted, it seems :-\

- Arnaldo
 
> Thanks,
> Martin
> 
> > 
> > Please take a look at 'man perf-config' and see what can be configured
> > for both 'perf annotate --tui' and 'perf annotate --stdio2'.
> > 
> > Perhaps we can do something like:
> > 
> > perf config annotate.stdio=tui_like
> > 
> > And, for completeness have:
> > 
> > perf config annotate.stdio=classical
> > 
> > wdyt?
> > 
> > Looking at the other patches now.
> > 
> > - Arnaldo
> > 
> > > - source locations for the hottest lines are printed
> > >    at the line end in order to preserve layout
> > > 
> > > Before:
> > > 
> > >      0.00 :   405ef1: inc    %r15
> > >           :            tmpsd * (TD + tmpsd * TDD)));
> > >      0.01 :   405ef4: vfmadd213sd 0x2b9b3(%rip),%xmm0,%xmm3        # 4318b0 <_IO_stdin_used+0x8b0>
> > >           :            tmpsd * (TC +
> > >   eff.c:1811    0.67 :   405efd: vfmadd213sd 0x2b9b2(%rip),%xmm0,%xmm3        # 4318b8 <_IO_stdin_used+0x8b8>
> > >           :            TA + tmpsd * (TB +
> > >      0.35 :   405f06: vfmadd213sd 0x2b9b1(%rip),%xmm0,%xmm3        # 4318c0 <_IO_stdin_used+0x8c0>
> > >           :            dumbo =
> > >   eff.c:1809    1.41 :   405f0f: vfmadd213sd 0x2b9b0(%rip),%xmm0,%xmm3        # 4318c8 <_IO_stdin_used+0x8c8>
> > >           :            sumi -= sj * tmpsd * dij2i * dumbo;
> > >   eff.c:1813    2.58 :   405f18: vmulsd %xmm3,%xmm0,%xmm0
> > >      2.81 :   405f1c: vfnmadd213sd 0x30(%rsp),%xmm1,%xmm0
> > >      3.78 :   405f23: vmovsd %xmm0,0x30(%rsp)
> > >           :            for (k = 0; k < lpears[i] + upears[i]; k++) {
> > >   eff.c:1761    0.90 :   405f29: cmp    %r15d,%r12d
> > > 
> > > After:
> > > 
> > >      0.00 :   405ef1: inc    %r15
> > >           : 1812   tmpsd * (TD + tmpsd * TDD)));
> > >      0.01 :   405ef4: vfmadd213sd 0x2b9b3(%rip),%xmm0,%xmm3        # 4318b0 <_IO_stdin_used+0x8b0>
> > >           : 1811   tmpsd * (TC +
> > >      0.67 :   405efd: vfmadd213sd 0x2b9b2(%rip),%xmm0,%xmm3        # 4318b8 <_IO_stdin_used+0x8b8> // eff.c:1811
> > >           : 1810   TA + tmpsd * (TB +
> > >      0.35 :   405f06: vfmadd213sd 0x2b9b1(%rip),%xmm0,%xmm3        # 4318c0 <_IO_stdin_used+0x8c0>
> > >           : 1809   dumbo =
> > >      1.41 :   405f0f: vfmadd213sd 0x2b9b0(%rip),%xmm0,%xmm3        # 4318c8 <_IO_stdin_used+0x8c8> // eff.c:1809
> > >           : 1813   sumi -= sj * tmpsd * dij2i * dumbo;
> > >      2.58 :   405f18: vmulsd %xmm3,%xmm0,%xmm0 // eff.c:1813
> > >      2.81 :   405f1c: vfnmadd213sd 0x30(%rsp),%xmm1,%xmm0
> > >      3.78 :   405f23: vmovsd %xmm0,0x30(%rsp)
> > >           : 1761   for (k = 0; k < lpears[i] + upears[i]; k++) {
> > > 
> > > Where e.g. '// eff.c:1811' shares the same color as the percentantage
> > > at the line beginning.
> > > 
> > > Signed-off-by: Martin Liška <mliska@suse.cz>
> > > ---
> > >   tools/perf/util/annotate.c | 30 ++++++++++++++----------------
> > >   1 file changed, 14 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > > index e60841b86d27..80542012ec1b 100644
> > > --- a/tools/perf/util/annotate.c
> > > +++ b/tools/perf/util/annotate.c
> > > @@ -1366,7 +1366,6 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
> > >   {
> > >   	struct disasm_line *dl = container_of(al, struct disasm_line, al);
> > >   	static const char *prev_line;
> > > -	static const char *prev_color;
> > >   	if (al->offset != -1) {
> > >   		double max_percent = 0.0;
> > > @@ -1405,20 +1404,6 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
> > >   		color = get_percent_color(max_percent);
> > > -		/*
> > > -		 * Also color the filename and line if needed, with
> > > -		 * the same color than the percentage. Don't print it
> > > -		 * twice for close colored addr with the same filename:line
> > > -		 */
> > > -		if (al->path) {
> > > -			if (!prev_line || strcmp(prev_line, al->path)
> > > -				       || color != prev_color) {
> > > -				color_fprintf(stdout, color, " %s", al->path);
> > > -				prev_line = al->path;
> > > -				prev_color = color;
> > > -			}
> > > -		}
> > > -
> > >   		for (i = 0; i < nr_percent; i++) {
> > >   			struct annotation_data *data = &al->data[i];
> > >   			double percent;
> > > @@ -1439,6 +1424,19 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
> > >   		printf(" : ");
> > >   		disasm_line__print(dl, start, addr_fmt_width);
> > > +
> > > +		/*
> > > +		 * Also color the filename and line if needed, with
> > > +		 * the same color than the percentage. Don't print it
> > > +		 * twice for close colored addr with the same filename:line
> > > +		 */
> > > +		if (al->path) {
> > > +			if (!prev_line || strcmp(prev_line, al->path)) {
> > > +				color_fprintf(stdout, color, " // %s", al->path);
> > > +				prev_line = al->path;
> > > +			}
> > > +		}
> > > +
> > >   		printf("\n");
> > >   	} else if (max_lines && printed >= max_lines)
> > >   		return 1;
> > > @@ -1454,7 +1452,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
> > >   		if (!*al->line)
> > >   			printf(" %*s:\n", width, " ");
> > >   		else
> > > -			printf(" %*s:     %*s %s\n", width, " ", addr_fmt_width, " ", al->line);
> > > +			printf(" %*s: %-*d %s\n", width, " ", addr_fmt_width, al->line_nr, al->line);
> > >   	}
> > >   	return 0;
> > > -- 
> > > 2.30.1
> > > 
> > 
> 

-- 

- Arnaldo
