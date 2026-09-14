Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC8175A85;
	Mon, 14 Sep 2026 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789346082; cv=none; b=fUntdTvu7ZkDLi9WQmO67VfNh0wsxqjEJofnXg17T4tljkJKIF2dxnGmlBrK+zT6CKvzoiM7CuTUq/xnUIgI3O6WUNJOGGHsXhvS4AncGolkDBcvw7l1Nx1jdEtRjQBLxpvo8+bCbanahH1+EsfJlxP+hLMD0+uLOkK6NqHeX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789346082; c=relaxed/simple;
	bh=ozr+G4WolJdsvXg4uRRsME/sWhZuJtNjzaYZWN0X6Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvlT0Mg+yMPDJrbv1B2OUBxEZK5RRAWSvVTPpf6NcrBo5z/ECbqePIWuMtnujyH3i0QDHQOVh7JzxSgJofPWzK2ncse6OHr6ZCU9UywvGO/PnpD2uRbk4NOhT4GI+4aZ6TPw9/diDc/2gn3tw4qasGxmP/cTL5PCoCjIlAbfZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QievNqEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QievNqEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3D61F00893;
	Mon, 14 Sep 2026 00:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789346081;
	bh=igOgEov9O0bDjoIf9Fh+EI3ezPpbc1ZHlxJWXBRYGPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QievNqEwG+7xiklZ1clu93YKDOxFzOZpd7rfRyO8dqJnjqNnWUYr5sbIIAs74eWVh
	 UI6EeZvs1OaumHu7gKvUYtWR3opdXFdOaoe4268lMsYf2FOhOGLqiCG1BL5FRc8TQB
	 HC0XCjqqHTEIs2l1W2NlXXJdw3wcio4BAcs89+zjP+0enhn1htyEJHIAcApTIvKgTz
	 53SB+ZgkbnIg719z4cTUJnshq3+GmJ7q72rrBF/R5tX5pFOVdtuvL9KDn4QUkveir6
	 HlquBY+xniFiRWUOlcP7MDBw0TiMdkC20ECdKBDrXTTMWfRePB50GwBNzErAXu4eMO
	 DvurmxyyjvGGw==
Date: Sun, 13 Sep 2026 17:34:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf dwarf-aux: Add die_has_flex_array() helper
Message-ID: <aqdBHyq6MIzH3211@google.com>
References: <20260912054706.1475583-1-namhyung@kernel.org>
 <20260912054706.1475583-3-namhyung@kernel.org>
 <20260912055837.3D9741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912055837.3D9741F000FF@smtp.kernel.org>

On Sat, Sep 12, 2026 at 05:58:36AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] die_has_flex_array() uses a flawed heuristic (`loc == size`) to identify flexible arrays, which falsely rejects standard C structs with trailing alignment padding.
> - [Medium] Nested structures bypass the bounds and padding validation for flexible arrays, creating inconsistent logic compared to direct array members.
> - [Medium] The function fails to detect flexible arrays that are embedded inside a trailing anonymous union.
> - [Medium] Infinite recursion in die_has_flex_array() when parsing maliciously crafted cyclic DWARF structures, leading to stack exhaustion.
> --
> 
> commit 8b9b8180d24f8e4da056fe22e70f6b84446a7257
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf dwarf-aux: Add die_has_flex_array() helper
> 
> The die_has_flex_array() returns true when the given type is a struct
> and contains an array at the end of the struct.
> 
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index d7160f87ac7d7..98d018798fa75 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> [ ... ]
> > +bool die_has_flex_array(Dwarf_Die *parent_die)
> > +{
> > +	Dwarf_Die die_mem, type_die;
> > +	Dwarf_Word size, loc;
> > +
> > +	if (dwarf_tag(parent_die) != DW_TAG_structure_type)
> > +		return false;
> 
> [Severity: Medium]
> Does this rigid check against DW_TAG_structure_type fail to detect valid
> flexible arrays embedded inside trailing anonymous unions, which are frequently
> used in the kernel?

Hmm.. ok.  I'll add union type support.

> 
> [ ... ]
> > +	if (dwarf_tag(&type_die) == DW_TAG_array_type)
> > +		return die_get_data_member_location(&die_mem, &loc) == 0 && loc == size;
> 
> [Severity: High]
> Does this strict loc == size equality accurately detect flexible arrays when
> standard C structs contain trailing alignment padding?
> 
> When preceding members do not perfectly align with the struct's maximum
> alignment, the compiler pads the total struct size. For example, if a struct
> has an 8-byte long, a 4-byte int, and a trailing flexible array, its total
> size is padded to 16 bytes. However, the data member location (loc) of the
> flexible array is 12.

Right.

> 
> Could this cause perf annotate to falsely reject legitimate samples targeting
> flexible array members in padded structs by evaluating as PERF_TMR_BAD_OFFSET?

Ok, I'll change the logic to check the last member being an array and
its size is not specified or zero.

> 
> > +
> > +	if (dwarf_tag(&type_die) == DW_TAG_structure_type)
> > +		return die_has_flex_array(&type_die);
> 
> [Severity: Medium]
> Does this recursive call bypass bounds and padding validation for flexible
> arrays nested inside structures, making the logic inconsistent compared to
> direct array members?
> 
> If the last member is a nested struct with no padding, it returns true,
> completely ignoring any padding that may exist between the nested struct and
> the end of the parent struct.

I'll add a check for the offset too.

> 
> [Severity: Medium]
> Is there a risk of infinite recursion and stack exhaustion when parsing
> maliciously crafted cyclic DWARF structures?
> 
> If an untrusted DWARF file defines a struct A whose last member is struct B,
> and struct B's last member is struct A, this recursion could overflow the
> stack since it lacks depth limits or cycle tracking.

I'm not sure if it's possible but anyway I can add a recursion check
just in case.

> 
> > +
> > +	return false;
> 
> [Severity: Medium]
> Is this fall-through where DW_TAG_union_type is unhandled, dropping support
> for flexible arrays wrapped in trailing unions?

Will handle that as well.

Thanks,
Namhyung

