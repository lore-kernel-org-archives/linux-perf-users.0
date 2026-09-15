Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765843A718D;
	Tue, 15 Sep 2026 05:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451663; cv=none; b=nx3R4olb4n+aMR92Lsxqiyi7G9Gng3+Q0Wiv7G8AeBRhbZU5OcuWQgzf+FhSSWFcUBHuEYawo0kD8SGV+b8pbIH5G3fgE5y0uNhWEgQsBHbdASjEcVvDK4VIACAt3YhavFV/1ZzFoxrgM55jAvJrIsmbf4eFRtvIeDAtHV0AKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451663; c=relaxed/simple;
	bh=32QncO42ogdd1YcS4VhT6UVHXxFKqtuucnpN95mFK0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdjLU6NLtS3wHizBw1Viqu4ibbZbPmZtRf/aFyZgLcHLtPnJ3mNwa19QQflb2Np1pj+LscOiaUbBoVAYGzlWL35JKNg0NQZsb0vWimtCjZiggqGo0cmx7XgW8y5LgLTLlkkforUsWIXgE7zsGm5p/J10xmEeirJcMSBghNOobBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+3XL9fa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+3XL9fa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EDC1F000FF;
	Tue, 15 Sep 2026 05:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789451662;
	bh=toHrB1IToMyqXz6Fr1e4cLPpy1QqZkTe818DjiZV8eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B+3XL9fagtXq2bxFrewB8rh6nzkOcHQNp3JIaevyReJSHFtHyQFCTgoZwLQwJbEsV
	 gqkp1A4Br6Hl8iXDtyfnJcvRUB5Q7yuhOxINnPe8WVID1e5vy7PKsx0MY8XXSqDd92
	 /iIMuseTcoODEE0fxcry8zPIcircvqc43OrBrO6KUcKZUozVy18oJm6IV7HLQfXcdq
	 X3sIvQ+z/WO/S5vHsa5bm7fos0aXUvhmjiS5ahFw0tB5wox/T7fCVH37KaM5Fkk9i2
	 QR2ubVpSLVMNF9Hb/m9cpeI5oL0gtKc4WzbacIDOX+pDYtXCY1MOs+zLdLjj3ky5yK
	 gYXPdwdf1bVxA==
Date: Mon, 14 Sep 2026 22:54:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>, Tengda Wu <wutengda@huaweicloud.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 2/4] perf dwarf-aux: Add die_has_flex_array() helper
Message-ID: <aqjdixZz4RYQZgCJ@google.com>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-3-namhyung@kernel.org>
 <20260915084048.5779ad90647c116806822df5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915084048.5779ad90647c116806822df5@kernel.org>

Hi Masami,

On Tue, Sep 15, 2026 at 08:40:48AM +0900, Masami Hiramatsu wrote:
> On Sun, 13 Sep 2026 23:45:33 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > The die_has_flex_array() returns true when the given type is a compound
> > type and contains an array at the end.  To prevent an infinite recursion
> > add a depth field to the internal function.
> 
> Hi, thanks for this nice extension!
> BTW, I have a comment on this implementation.

Thanks for your review!

> 
> > 
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/dwarf-aux.c | 77 +++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/dwarf-aux.h |  3 ++
> >  2 files changed, 80 insertions(+)
> > 
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index d7160f87ac7d7ab3..465824e6513eb0ac 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -2180,3 +2180,80 @@ Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
> >  
> >  	return die_get_member_type(&type_die, offset, die_mem);
> >  }
> > +
> > +static bool is_flex_array_member(Dwarf_Die *mb_die)
> > +{
> > +	Dwarf_Die type_die;
> > +	Dwarf_Word size;
> > +
> > +	/* get the type of the member */
> > +	if (die_get_real_type(mb_die, &type_die) == NULL)
> > +		return false;
> > +
> > +	if (dwarf_tag(&type_die) != DW_TAG_array_type)
> > +		return false;
> > +
> > +	return dwarf_aggregate_size(&type_die, &size) < 0 || size == 0;
> > +}
> > +
> > +#define MAX_FLEX_ARRAY_RECURSION  256  /* arbitrary */
> > +
> > +static bool die_has_flex_array_recurse(Dwarf_Die *parent_die, int depth)
> > +{
> > +	Dwarf_Die die_mem, last_mb;
> > +	int tag = dwarf_tag(parent_die);
> > +
> > +	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type)
> > +		return false;
> 
> What happen if the parent_die is "typedef struct {..." ?
> I think you need to use die_get_real_type() here. ;)

Currently I expect callers to do it before calling.  But probably I can
add it to the outer function.

> 
> > +
> > +	/* prevent infinite recursion */
> > +	if (depth > MAX_FLEX_ARRAY_RECURSION)
> > +		return false;
> > +
> > +	if (dwarf_child(parent_die, &die_mem))
> > +		return false;
> > +
> > +	do {
> > +		if (dwarf_tag(&die_mem) != DW_TAG_member)
> > +			continue;
> 
> If the member is a "const" member, you may have to use
> die_get_real_type() to get the actual type.
> (in this case, you need a cursor DIE for dwarf_siblingof()) 

Doesn't it belong to a type of the member?  In my simple test program,
it shows the struct type only has children of members and their types
including const are referenced from the member DIEs.

Also I don't think flexible arrays will be const as they cannot be
initialized.

> 
> > +
> > +		if (tag == DW_TAG_union_type) {
> > +			if (is_flex_array_member(&die_mem))
> > +				return true;
> > +
> > +			if (die_get_real_type(&die_mem, &last_mb) &&
> > +			    die_has_flex_array_recurse(&last_mb, depth + 1))
> > +				return true;
> > +		}
> > +
> > +		if (tag == DW_TAG_structure_type)
> > +			memcpy(&last_mb, &die_mem, sizeof(last_mb));
> 
> To find the last member, I think you'd better check the
> DW_AT_data_member_location and DW_AT_decl_line to ensure the
> DIE is the last member.

Good point.  I can add the member location check.  I'm afraid decl line
may be incorrect if compiler randomized the layout.

So far I haven't seen DWARF data having unsorted members (by location),
but it'd be better to make sure it's sorted.

Thanks,
Namhyung

