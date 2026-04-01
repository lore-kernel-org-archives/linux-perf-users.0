Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6753337BB5;
	Wed,  1 Apr 2026 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077880; cv=none; b=TES3ZcXUBfhrpkT5iwNV/Xw4a4cYKzLHFGX2An6zyNcLSKNh9l2SS27h0bAUODCJkbAAx+trlnr21xtFjnxQpxOZsHRxOoeuGmApPrbKf2CfkJCkrMJzqCY/bDMRIiyNxDr86O9ERpUexwR9geJ1w5trKvbnaU4YkQm6nxpv6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077880; c=relaxed/simple;
	bh=UyIjbxZElQCOPdZlwMmhz77CmkooPytlNReJidGcgDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnYOomHC118N38p189hJPMJrKqwqO2Q8C/1RzCcWY8Wxh29nUnHsoYaRgn2FvFTh39M3Bda6M3zPrWzAU+teQvlDkICD+mJf8pacZfdK/vqozhoi0nvgj+9GnAxBwstmXqdGvJuQdtIGueRGs9qEphJUuxieY4weD9wBKQ2I+YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/cObhqT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/cObhqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE115C4CEF7;
	Wed,  1 Apr 2026 21:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775077880;
	bh=UyIjbxZElQCOPdZlwMmhz77CmkooPytlNReJidGcgDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/cObhqTK+3SCnPPq1pvZ20KqkYioSAtW06oGJYioLCHk7GcqnbziA2LsgST0mqCj
	 i5MbG0NClPy30hAtPXE6jm+Ht+ZqDEizvZ1lWSPrO/TK9ZNCUH/NxSbYruLrnfdLVs
	 XLXaf2oFFSapyvDhHqkC+3Xylq51YMPmlLHSAz/SDo2RRslnXL8SA9nRl3eGbH30hE
	 PeI5/bLFCGpcGWOW8v5NBzg46iG+fCfZHqr+u14m2W7/sihzz2vSSrG/27xnb2SZGO
	 BRmIuBpwvgAz72S48zlchIF0WxO8qk8fT64b+jJWkdrFnrsiEowB3RjBsmPuygMAPk
	 A7DC3e8cjbFoA==
Date: Wed, 1 Apr 2026 18:11:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Steinar H. Gunderson" <sesse@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Improve C++ support in arguments
Message-ID: <ac2J9BRFsmzdJo2J@x1>
References: <20251205123608.3125691-1-sesse@google.com>
 <CAP-5=fW7y93ZfSF0Mrt3nB1Jqu4HaKypEUhH88CTyy9-v4JPdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW7y93ZfSF0Mrt3nB1Jqu4HaKypEUhH88CTyy9-v4JPdA@mail.gmail.com>

On Wed, Apr 01, 2026 at 02:03:42PM -0700, Ian Rogers wrote:
> On Fri, Dec 5, 2025 at 4:36 AM Steinar H. Gunderson <sesse@google.com> wrote:
> >
> > For purposes of specifying arguments in tracepoints, C++ classes
> > work exactly like structs, and C++ references work almost exactly
> > like pointers (they are dereferenced with . instead of ->).
> > However, they use different tags in DWARF, which means you cannot
> > use them in arguments.
> >
> > Implement support for both, based on the existing struct and pointer
> > support. This allows us to to something like this in Chromium:
> >
> >   perf probe --exec content_shell --add 'PerformanceMark=\
> > _ZN5blink15PerformanceMark6CreateEPNS_11ScriptStateERKNS_12\
> > AtomicStringEPNS_22PerformanceMarkOptionsERNS_14ExceptionStateE \
> > mark_name.string_.impl_.ptr_'
> >
> > even though mark_name is an class AtomicString&.
> >
> > We don't support advanced C++ features, such as operator overloading.
> > Unfortunately, we also don't support C++-style strings where there
> > is a separate length field instead of null-termination. We also cannot
> > go past ptr_ in the example above (e.g. add ->length_), due to
> > unrelated DWARF issues.
> >
> > Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> > Cc: Ian Rogers <irogers@google.com>
> 
> This change makes sense to me, Namhyung?

Agreed, and there are some other C++ specific (Go as well), like
DW_TAG_rvalue_reference_type, that we may want to support, also it would
be great to have some extra workload in 'perf test -w' to have a shell
testing this feature, no?

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/annotate-data.c |  3 ++-
> >  tools/perf/util/dwarf-aux.c     | 13 ++++++++++---
> >  tools/perf/util/probe-finder.c  | 24 +++++++++++++++++-------
> >  3 files changed, 29 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > index 07cf9c334be0..d97b5fc61e6f 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> > @@ -459,7 +459,8 @@ static bool is_pointer_type(Dwarf_Die *type_die)
> >  {
> >         int tag = dwarf_tag(type_die);
> >
> > -       return tag == DW_TAG_pointer_type || tag == DW_TAG_array_type;
> > +       return tag == DW_TAG_pointer_type || tag == DW_TAG_reference_type ||
> > +              tag == DW_TAG_array_type;
> >  }
> >
> >  static bool is_compound_type(Dwarf_Die *type_die)
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index 9267af204c7d..25bbc840d1a8 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -1112,6 +1112,8 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
> >         tag = dwarf_tag(type_die);
> >         if (tag == DW_TAG_pointer_type)
> >                 tmp = "*";
> > +       else if (tag == DW_TAG_reference_type)
> > +               tmp = "&";
> >         else if (tag == DW_TAG_array_type)
> >                 tmp = "[]";
> >         else if (tag == DW_TAG_subroutine_type) {
> > @@ -1124,6 +1126,8 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
> >                         tmp = "union ";
> >                 else if (tag == DW_TAG_structure_type)
> >                         tmp = "struct ";
> > +               else if (tag == DW_TAG_class_type)
> > +                       tmp = "class ";
> >                 else if (tag == DW_TAG_enumeration_type)
> >                         tmp = "enum ";
> >                 else if (name == NULL)
> > @@ -2065,7 +2069,8 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
> >
> >         tag = dwarf_tag(type_die);
> >         /* If it's not a compound type, return the type directly */
> > -       if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
> > +       if (tag != DW_TAG_structure_type && tag != DW_TAG_class_type &&
> > +           tag != DW_TAG_union_type) {
> >                 Dwarf_Word size;
> >
> >                 if (dwarf_aggregate_size(type_die, &size) < 0)
> > @@ -2080,7 +2085,8 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
> >
> >         mb_type = *type_die;
> >         /* TODO: Handle union types better? */
> > -       while (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
> > +       while (tag == DW_TAG_structure_type || tag == DW_TAG_class_type ||
> > +              tag == DW_TAG_union_type) {
> >                 member = die_find_child(&mb_type, __die_find_member_offset_cb,
> >                                         (void *)(long)offset, die_mem);
> >                 if (member == NULL)
> > @@ -2091,7 +2097,8 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
> >
> >                 tag = dwarf_tag(&mb_type);
> >
> > -               if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
> > +               if (tag == DW_TAG_structure_type || tag == DW_TAG_class_type ||
> > +                   tag == DW_TAG_union_type) {
> >                         Dwarf_Word loc;
> >
> >                         /* Update offset for the start of the member struct */
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > index 5ffd97ee4898..ca4734c75bba 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -360,12 +360,20 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
> >                 ref->offset += dwarf_bytesize(&type) * field->index;
> >                 ref->user_access = user_access;
> >                 goto next;
> > -       } else if (tag == DW_TAG_pointer_type) {
> > +       } else if (tag == DW_TAG_pointer_type || tag == DW_TAG_reference_type) {
> >                 /* Check the pointer and dereference */
> > -               if (!field->ref) {
> > -                       pr_err("Semantic error: %s must be referred by '->'\n",
> > -                              field->name);
> > -                       return -EINVAL;
> > +               if (tag == DW_TAG_pointer_type) {
> > +                       if (!field->ref) {
> > +                               pr_err("Semantic error: %s must be referred by '->'\n",
> > +                                      field->name);
> > +                               return -EINVAL;
> > +                       }
> > +               } else {
> > +                       if (field->ref) {
> > +                               pr_err("Semantic error: %s must be referred by '.'\n",
> > +                                      field->name);
> > +                               return -EINVAL;
> > +                       }
> >                 }
> >                 /* Get the type pointed by this pointer */
> >                 if (die_get_real_type(&type, &type) == NULL) {
> > @@ -374,7 +382,8 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
> >                 }
> >                 /* Verify it is a data structure  */
> >                 tag = dwarf_tag(&type);
> > -               if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
> > +               if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type &&
> > +                   tag != DW_TAG_class_type) {
> >                         pr_warning("%s is not a data structure nor a union.\n",
> >                                    varname);
> >                         return -EINVAL;
> > @@ -389,7 +398,8 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
> >                         *ref_ptr = ref;
> >         } else {
> >                 /* Verify it is a data structure  */
> > -               if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
> > +               if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type &&
> > +                   tag != DW_TAG_class_type) {
> >                         pr_warning("%s is not a data structure nor a union.\n",
> >                                    varname);
> >                         return -EINVAL;
> > --
> > 2.51.0
> >
