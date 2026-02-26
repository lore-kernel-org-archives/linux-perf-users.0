Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50D1A08AF
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067917; cv=none; b=FNXEtB2n/aZ1ykvCNiuiKHoxhyGXL83pjxEPtUPpzSlEZbLjyQLUnduZqE/2RKnQM5swdb77ZZd2t3fNX7CbMjswvVdxaGTGBO+oZm+tkXmS8DsWw4Q8NneFz0YAzQeK0cMJvH2mSqpq32A6qeDgZhQD6SrG+N6he1U3JGMFMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067917; c=relaxed/simple;
	bh=2jCY5Aff47NorBDq1SiSlgbyb2jMkIUA21wECQnAsk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm1mg14rP/worDTy6DvEBUj4rFyaypYzRBW493lb+AlVaf5W7+jMojcTxWH24C/RCTn26ZJ3Rnp+Q3W3chHiczzG+9lcvsmsnt9sY1wVqHasQxCXLvkTHy1FkVWrwU3SDs9xZ7qebt4MRQnvPICUkeTBjGCgd9gm4t333CNKS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFANIyqB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFANIyqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD863C116D0;
	Thu, 26 Feb 2026 01:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772067916;
	bh=2jCY5Aff47NorBDq1SiSlgbyb2jMkIUA21wECQnAsk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFANIyqBI6HEnUhkOg3lG2r9OWEj1w+Avw+oAEOfTjfdnz6U9F4duYROxfKZG0Qw+
	 XAH1hhfGSVj88J6WEwJ8ry66HQNxx0fBy3b79AiDB17KwpE5Jb90AjktIYb3wVsQuH
	 eNmlK2RPvOlb5uV35INzjAnutuCkk+Dhi2xn9U1/SBNxkHXWbO4kJ1VcOgJqf+T4Ix
	 aIqTNatuQ53jX9lqSXbD4/+r44wNzka2ATWz3Y/vUFk4TEg8BMr/OnqoI4hph6sNCH
	 x2hglA6ZsmvZvexX948/uBuKONmhQXvXfsUfRlTN8b9zkvLgR6F5xoxFd8mg+ScbOh
	 OO+S0Q/+XPFSg==
Date: Wed, 25 Feb 2026 17:05:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf, script: Fix brcntr output with --xed
Message-ID: <aZ-cS_Tkh6Vko701@google.com>
References: <20260218014056.3454977-1-andi@firstfloor.org>
 <CAP-5=fWUr2QC0RRhjp11Cdci_QY3yHSfFU6=6OPgSEUFf_p-NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWUr2QC0RRhjp11Cdci_QY3yHSfFU6=6OPgSEUFf_p-NA@mail.gmail.com>

Hello,

On Wed, Feb 25, 2026 at 09:28:23AM -0800, Ian Rogers wrote:
> On Tue, Feb 17, 2026 at 5:48 PM Andi Kleen <andi@firstfloor.org> wrote:
> >
> > brcntr in perf script brstack insn currently outputs
> >
> > $ perf record -j any,counter ...
> > $ perf script -F +brcntr,+brstackinsn
> > ...
> >             BC1s 3450809 5665912.127194:     100127
> > cpu_core/cycles/:      7f0475d6cc89 handle_intel.constprop.0+0x2b
> > (/usr/lib64/ld-linux-
> > x86-64.so.2)
> >         intel_check_word.constprop.0+224:
> >         00007f0475d6ca7e        insn: 00 4b db                  br_cntr: # PRED 21 cycles [21]
> > ...
> >
> > This has two issues:
> > - The description says no event is a single dash, but that is not what is printed.
> > - The b in brcntr is ambigious with the hex numbers in insns, which
> >   breaks with --xed. It parses the b as another instruction byte and
> > merges the instruction with a missing b and no space:
> >
> > $ perf script -F +brstackinsn,+brcntr --xed
> > ...
> >         00005618c6d683b5                        jnz 0x5618c6d683bdr_cntr:       # PRED 5 cycles [1396] 8.60 IPC
> >
> > This patches fixes these two problems. It moves the brcntr output into
> > the "#" comment which also looks nicer and also fixes the no event case.
> >
> > $ perf script -F +brstackinsn,+brcntr --xed
> > ...
> >         00005618c6d6624f                        jnz 0x5618c6d65fb7 # br_cntr: -  MISPRED 1 cycles [1398] 3.00 IPC
> >
> > Since the old broken format has shipped for a few releases there is a
> > risk of breaking some existing parser, but since this is a obscure
> > feature I hope they're not too common and can adapt.

:)

> >
> > Signed-off-by: Andi Kleen <andi@firstfloor.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks.
> Ian
> 
> > ---
> >  tools/perf/builtin-script.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 62e43d3c5ad7..ac361aa51094 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -1264,11 +1264,11 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
> >
> >         if (PRINT_FIELD(BRCNTR)) {
> >                 struct evsel *pos = evsel__leader(evsel);
> > -               unsigned int i = 0, j, num, mask, width;
> > +               unsigned int i = 0, j, num, mask, width, numprinted = 0;
> >
> >                 perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
> >                 mask = (1L << width) - 1;
> > -               printed += fprintf(fp, "br_cntr: ");
> > +               printed += fprintf(fp, "\t# br_cntr: ");
> >                 evlist__for_each_entry_from(evsel->evlist, pos) {
> >                         if (!(pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
> >                                 continue;
> > @@ -1276,16 +1276,20 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
> >                                 break;
> >
> >                         num = (br_cntr >> (i++ * width)) & mask;
> > +                       numprinted += num;
> >                         if (!verbose) {
> >                                 for (j = 0; j < num; j++)
> >                                         printed += fprintf(fp, "%s", pos->abbr_name);
> >                         } else
> >                                 printed += fprintf(fp, "%s %d ", pos->name, num);
> >                 }
> > -               printed += fprintf(fp, "\t");
> > +               if (numprinted == 0 && !verbose)
> > +                       fprintf(fp, "-");

I think it should be:       printed += fprintf(fp, "-");

Anyway, it's a nitpick.  I can update it locally.

Thanks,
Namhyung


> > +               printed += fprintf(fp, " ");
> >         }
> >
> > -       printed += fprintf(fp, "#%s%s%s%s",
> > +       printed += fprintf(fp, "%s%s%s%s%s",
> > +                             !PRINT_FIELD(BRCNTR) ? "#" : "",
> >                               en->flags.predicted ? " PRED" : "",
> >                               en->flags.mispred ? " MISPRED" : "",
> >                               en->flags.in_tx ? " INTX" : "",
> > --
> > 2.52.0
> >
> >
