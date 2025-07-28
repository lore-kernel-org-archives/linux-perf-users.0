Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715498BE8;
	Mon, 28 Jul 2025 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728707; cv=none; b=V6LqfEQQ+73UBtq8PVNcYgXHipzluZm1s6qLG88Ah6VqvcIc9QRR7RCjOzZBZBLItJmXJZJuvSP0RBM3cJP9KMX3Gp10lzSPjmxLpwwaVJyxUuhdmIJVYfhE10rGvpzodjamh22pYlf2gkvZcRZeIwJzd9FdbJj8HqVd5SN4qEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728707; c=relaxed/simple;
	bh=GTSwy1O36/JRknrJGF9qlur4Q0A4yngcbkrPXG+BwBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miAEHjKj5uUWiPbbH3YUppuT+WxE5MbKVQgcjLBsKFZCGho1y4lI7RLlGQIVcm3vd76CHma+3arH+6VHCxM9lxCGYIFhJ2nwAXf1ZA8gaMPdDu9395zLP6Dvg4yz352hgbbkNHpsS13yFcWn8i6P3XlftA60weQZgPrf2jxqmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qabTawZl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qabTawZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96055C4CEE7;
	Mon, 28 Jul 2025 18:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753728707;
	bh=GTSwy1O36/JRknrJGF9qlur4Q0A4yngcbkrPXG+BwBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qabTawZluY8Nu9pQ0XqTVqYvFj7sDBgUZhwD5R3yx1Z26wHJ0XclF/Jx9zbmjCcxJ
	 dyqwaN/+4pi0ZSqtSc3Xn1UtJ5gh7RYp4lJm0sd1Xmg17/Q8aVgoXR/zqaWA0iP0pB
	 sCGptbDF7XHWQDpEwm4As2AdheAWFUSUtCyoZ16c3YFVt/H+/j0M7qO5ZSNT2vWg1k
	 QywwfMBNZYuyKbGxGDz4cuyGrejVcv7aWVRWUySO2CtaVKo+rKKA+5An2VX5JWXHgu
	 9qBFY7kfw8s7atliIOcVnCiD7hYbY9ayH/SaMnwF+nMAAE3NZzDZ6Jn+eHktFZ+Z2E
	 TACseWXDrIt0w==
Date: Mon, 28 Jul 2025 11:51:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 8/9] perf annotate: Hide data-type for stack operation
 and canary
Message-ID: <aIfGwdcRZ_gwyhiC@google.com>
References: <20250725193755.12276-1-namhyung@kernel.org>
 <20250725193755.12276-9-namhyung@kernel.org>
 <CAP-5=fWJxCq97Oss3NXbXEKHeNXbif9-yWvktNRQvwtm3H3jbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWJxCq97Oss3NXbXEKHeNXbif9-yWvktNRQvwtm3H3jbA@mail.gmail.com>

On Fri, Jul 25, 2025 at 05:44:33PM -0700, Ian Rogers wrote:
> On Fri, Jul 25, 2025 at 12:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It's mostly unnecessary to print when it has no actual type information
> > like in the stack operations and canary.  Let's have them if -v option
> > is given.
> >
> > Before:
> >   $ perf annotate --code-with-type
> >   ...
> >          : 0    0xd640 <_dl_relocate_object>:
> >     0.00 :      0:       endbr64
> >     0.00 :      4:       pushq   %rbp           # data-type: (stack operation)
> >     0.00 :      5:       movq    %rsp, %rbp
> >     0.00 :      8:       pushq   %r15           # data-type: (stack operation)
> >     0.00 :      a:       pushq   %r14           # data-type: (stack operation)
> >     0.00 :      c:       pushq   %r13           # data-type: (stack operation)
> >     0.00 :      e:       pushq   %r12           # data-type: (stack operation)
> >     0.00 :     10:       pushq   %rbx           # data-type: (stack operation)
> 
> I believe the intent in the dwarf is to say where the caller's callee
> saves are, but the stack slots should just be saved and restored and
> won't be used for anything interesting, perhaps for exception
> handling. An annotation like:
> # caller's RBX at stack frame offset -48
> could perhaps be useful.

The main purpose of the annotation of the stack operation is to sync
with the output of data type profiling.  As it can report lots of
accesses were from the stack operation, this can answer where they are.

> 
> >     0.00 :     11:       subq    $0xf8, %rsp
> >     ...
> >     0.00 :     d4:       testl   %eax, %eax
> >     0.00 :     d6:       jne     0xf424
> >     0.00 :     dc:       movq    0xf0(%r14), %rbx               # data-type: struct link_map +0xf0
> >     0.00 :     e3:       testq   %rbx, %rbx
> >     0.00 :     e6:       jne     0xf2dd
> >     0.00 :     ec:       cmpq    $0, 0xf8(%r14)         # data-type: struct link_map +0xf8
> >     ...
> >
> > After:
> >          : 0    0xd640 <_dl_relocate_object>:
> >     0.00 :      0:       endbr64
> >     0.00 :      4:       pushq   %rbp
> >     0.00 :      5:       movq    %rsp, %rbp
> >     0.00 :      8:       pushq   %r15
> >     0.00 :      a:       pushq   %r14
> >     0.00 :      c:       pushq   %r13
> >     0.00 :      e:       pushq   %r12
> >     0.00 :     10:       pushq   %rbx
> >     0.00 :     11:       subq    $0xf8, %rsp
> >     ...
> >     0.00 :     d4:       testl   %eax, %eax
> >     0.00 :     d6:       jne     0xf424
> >     0.00 :     dc:       movq    0xf0(%r14), %rbx               # data-type: struct link_map +0xf0
> >     0.00 :     e3:       testq   %rbx, %rbx
> >     0.00 :     e6:       jne     0xf2dd
> >     0.00 :     ec:       cmpq    $0, 0xf8(%r14)         # data-type: struct link_map +0xf8
> >     ...
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 06ddc7a9f58722a4..6fc07971631ac8a3 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -765,6 +765,17 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
> >                             struct debuginfo *dbg, struct disasm_line *dl,
> >                             int *type_offset);
> >
> > +static bool needs_type_info(struct annotated_data_type *data_type)
> > +{
> > +       if (data_type == NULL || data_type == NO_TYPE)
> > +               return false;
> > +
> > +       if (verbose)
> > +               return true;
> 
> lgtm given the many overloaded meanings of verbose.

:-)

> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for your careful review!
Namhyung
 
> > +
> > +       return (data_type != &stackop_type) && (data_type != &canary_type);
> > +}
> > +
> >  static int
> >  annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
> >                        struct annotation_options *opts, int printed,
> > @@ -844,7 +855,7 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
> >
> >                         data_type = __hist_entry__get_data_type(apd->he, apd->arch,
> >                                                                 apd->dbg, dl, &offset);
> > -                       if (data_type && data_type != NO_TYPE) {
> > +                       if (needs_type_info(data_type)) {
> >                                 char buf[4096];
> >
> >                                 printf("\t\t# data-type: %s",
> > @@ -2138,7 +2149,7 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
> >                                                                 apd->dbg,
> >                                                                 disasm_line(al),
> >                                                                 &offset);
> > -                       if (data_type && data_type != NO_TYPE) {
> > +                       if (needs_type_info(data_type)) {
> >                                 char member[256];
> >
> >                                 printed = scnprintf(bf, sizeof(bf),
> > --
> > 2.50.1
> >
