Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5E27145F;
	Wed, 20 Aug 2025 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725433; cv=none; b=YR+uzpo+cQIDcyGhbUTk1ClF4X7FzQTxBtvBuUJA+xCQMlbpgvD/EcYLLRLpjqraU7fOIaGSlckwFio9dPlpUlfPLwnLA+cyzQlETuPJK7W3M6U+5ZogFbfoh4aopLoE1dH/UnyGVCgvsu1Zcjwo8VxYj08yqW13rRSBmY0ltdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725433; c=relaxed/simple;
	bh=5meq2Pl7uGd23u+zcu4m9slFz7snYlrh8f0aomwmB/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cknr2MVZDOdgvtQ0GEKukZOq0ib5JJmSjcccSWri4Mmx3kIv+Iz8dfvQQ8GAsPp+FQSOTwWN/00gsy9d8qhsvbsb7UcKPZuzR/Jk2j4MQOmS2yR14dQmvUV2f7b4VvFuwbKOeaZU3nyp5LEv+V3t2mq11/tFsCueesU/mizGSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4JhaskC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4JhaskC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB044C4CEE7;
	Wed, 20 Aug 2025 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755725433;
	bh=5meq2Pl7uGd23u+zcu4m9slFz7snYlrh8f0aomwmB/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4JhaskCIA+5pVjLeSK/TaY5OWlIiLMotsTw5FXxr21SJi/znxgsLXTfPFUxm3ISI
	 eSqY/BcyE+N6g560aXbJFaTwyMVAs7B7GYePw0lK6W8IuaWGUSKueqjuTMWSSJMJu4
	 iiubvaDm8EGFQ1eu1OHWCd3G8pSnXKQUvPEKldWpqmDhPPn3qU4Iw7EmA01eJNe/bJ
	 xSbQaBNLpYzbwO3RwIsggAHDDk01QFubsJXgiH30FMR70X0zI/oisdUdIj0IZnSdEi
	 l+v8w0iFbgfYpKGBvT0LUSeIbLgoGEpcp2p/0suI9iXi0scYk2WI5UZSXuedp4y07G
	 m5Pwvjzl2AtAw==
Date: Wed, 20 Aug 2025 18:30:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 10/12] perf annotate: Hide data-type for stack
 operation and canary
Message-ID: <aKY-deTOzHz6n0ZQ@x1>
References: <20250816031635.25318-1-namhyung@kernel.org>
 <20250816031635.25318-11-namhyung@kernel.org>
 <aKY-Ed1ZjOgRi8As@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKY-Ed1ZjOgRi8As@x1>

On Wed, Aug 20, 2025 at 06:28:53PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 15, 2025 at 08:16:33PM -0700, Namhyung Kim wrote:
> > It's mostly unnecessary to print when it has no actual type information
> > like in the stack operations and canary.  Let's have them if -v option
> > is given.
> 
> In the main 'report' TUI the 'V' key is wired to bumping the verbose
> level, wiring it up in the annotation view seems in order :-)

So using just 'perf top', then pressing 'V' and then going into the
annotation gets the verbose level needed to show these stack operations
in the annotate view :-)

- Arnaldo
  
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
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 99e976d254493de2..ea68b32da7ce584a 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -765,6 +765,17 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
> >  			    struct debuginfo *dbg, struct disasm_line *dl,
> >  			    int *type_offset);
> >  
> > +static bool needs_type_info(struct annotated_data_type *data_type)
> > +{
> > +	if (data_type == NULL || data_type == NO_TYPE)
> > +		return false;
> > +
> > +	if (verbose)
> > +		return true;
> > +
> > +	return (data_type != &stackop_type) && (data_type != &canary_type);
> > +}
> > +
> >  static int
> >  annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
> >  		       struct annotation_options *opts, int printed,
> > @@ -844,7 +855,7 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
> >  
> >  			data_type = __hist_entry__get_data_type(apd->he, apd->arch,
> >  								apd->dbg, dl, &offset);
> > -			if (data_type && data_type != NO_TYPE) {
> > +			if (needs_type_info(data_type)) {
> >  				char buf[4096];
> >  
> >  				printf("\t\t# data-type: %s",
> > @@ -1958,7 +1969,7 @@ static int disasm_line__snprint_type_info(struct disasm_line *dl,
> >  		return 1;
> >  
> >  	data_type = __hist_entry__get_data_type(apd->he, apd->arch, apd->dbg, dl, &offset);
> > -	if (data_type == NULL || data_type == NO_TYPE)
> > +	if (!needs_type_info(data_type))
> >  		return 1;
> >  
> >  	printed = scnprintf(buf, len, "\t\t# data-type: %s", data_type->self.type_name);
> > -- 
> > 2.50.1
> > 
