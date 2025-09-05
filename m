Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A5280A5F;
	Fri,  5 Sep 2025 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102946; cv=none; b=JnGq5icDzcK743Q04f5/nRDzgR939oRbUoxdwHI5CXNiwn0wGK3xGSEV4P/4YoH0Gd7DU2AAQoxtSqfSIK4BKLrdzwoXObdb+0HUWVOzHl9Gx3HvwCWR/eHoScYn9KX5kU/aNTqeVuayQINZaKTUIAPlJCiw6r8WBXNUUL2n3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102946; c=relaxed/simple;
	bh=Li7bM5SQHqjbRpCJToYrtYTRr5PgxJgR1Ff2r6AoN9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPo0p7m6aa5tJtg+NkemqYtHdp26tcL+Xd+gp5C58w5cZOXGZq3cmRofnnfEPvIBxuHTJUb9vLs8Ag69T6Ow8aaTSA9zbBcnM50GuhuTi54rGvbvOKRqpXhyjd8XhaRuE4Yjd+5a4W4Y88KBB1hBieZUkVhOcmiQ2dk0MpDwS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GShNvFcV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GShNvFcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15B4C4CEF1;
	Fri,  5 Sep 2025 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757102946;
	bh=Li7bM5SQHqjbRpCJToYrtYTRr5PgxJgR1Ff2r6AoN9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GShNvFcVVEyuIUXPWLss5knF52KhZt+jKuUpQNJGBuFjQ6ywhxA8VgeJ2eJmnDAus
	 89J7/QU5uehFZmxzeD9Nz3vUZ3xGE9C6z858aCAPrPEMRQ2prsQFvtYxFlvfI9JoBl
	 rUQpo7l4pWuO3TZUemIlxjfkbAGhDIDU3iBRcz8GkjY82lCID+123RrWXLA7eLI3qZ
	 ICaRHNHKUZRyGeA6RcKgxRo594g2xbNCiqCF+dfOPq+IzjELNmAsY298HLagg0xwOz
	 cY7RIuhJI4v1FHEr1zqCoTR3i1Oppbh0k6hQQbNdQiAVYLhvuffu7hJUwDi/0DLW8H
	 BUKl3uyuoZjBQ==
Date: Fri, 5 Sep 2025 13:09:03 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] perf dwarf-aux: Skip check_variable for
 die_find_variable_by_reg
Message-ID: <aLtDX0W0DMMr6BE4@google.com>
References: <20250825195806.226328-1-zecheng@google.com>
 <aLKot1esgc3HHubX@google.com>
 <CAJUgMy+jTTAQ+=F=ddryLrftyB0h==pezZdvnZAT-UHmSU994w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJUgMy+jTTAQ+=F=ddryLrftyB0h==pezZdvnZAT-UHmSU994w@mail.gmail.com>

On Wed, Sep 03, 2025 at 05:23:01PM -0400, Zecheng Li wrote:
> On Sat, Aug 30, 2025 at 3:31 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > > - In match_var_offset, use __die_get_real_type instead of
> > >   die_get_real_type to preserve typedefs. Move the (offset == 0) branch
> >
> > Why do you want to preserve typedefs?  I think a variable type can be
> > typedef to a pointer then now it won't resolve that target type anymore.
> 
> check_variable preserves the typedefs. It would sometimes resolve to
> an unnamed struct if we remove the typedefs. 

Ah, that's unfortunate.

> Let me test if it will
> affect the dwarf_tag(&data->type) == DW_TAG_pointer_type check. Also I
> found calling dwarf_aggregate_size on typedef'd types gives the
> correct result, so maybe we don't need the sized_type in
> check_variable?

You're right.

> 
> > > - When comparing types from different scopes, first compare their type
> > >   offsets. A larger offset means the field belongs to an outer
> > >   (enclosing) struct. This helps resolve cases where a pointer is found
> > >   in an inner scope, but a struct containing that pointer exists in an
> > >   outer scope. Previously, is_better_type would prefer the pointer type,
> > >   but the struct type is actually more complete and should be chosen.
> >
> > Can we improve is_better_type() then?
> 
> Here we are comparing two types with the extra access offset
> information. In other contexts, the calls to is_better_type compares
> two types only, so I think we don't need to add two new parameters to
> is_better_type?

Right, I meant just about pointer type and struct type.  It compares two
types take the same location so I didn't expect they can be a pointer
and a struct.  My intention was about a pointer and a base type.

Also you may consider typedef and struct.  I think we prefer struct
since it can access the member field.  But as you said we should use
typedef if it's an unnamed struct.  It'd be great if we can get members
even for typedefs (for structs).

> 
> > > -                     if (!found || is_better_type(type_die, &mem_die)) {
> > > +                     if (!found || dloc->type_offset < type_offset ||
> > > +                             (dloc->type_offset == type_offset &&
> > > +                              is_better_type(type_die, &mem_die))) {
> > >                               *type_die = mem_die;
> > >                               dloc->type_offset = type_offset;
> > >                               found = true;
> 
> I find changing the is_better_type call to !is_better_type(&mem_die,
> type_die) would yield better results: prefer types from outer scope if
> the current one is not "better" than the new one.

Ok, sounds good.

Thanks,
Namhyung

