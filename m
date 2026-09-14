Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787A260580;
	Mon, 14 Sep 2026 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789346476; cv=none; b=VnzJGj4eugyCoFcCi+f3p6Kjki97p1b3x7ID+dP/Gv0u9FBCHxGhh2zMw5vGqFQDu/kAiekPUaRSLopeDzf/RbmU6EgnZm7SjcbKDXb4whnKAoDb4Pjq86q1GsVyTn9AJslT4unz70EIROIsEKko4kfXAz9dwRcHjAtnMchTy/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789346476; c=relaxed/simple;
	bh=kF9tP3TufBJm9x91VexQ+QW2egah3OQz7sdWU06QvYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FW94h7tfPUHEwlgrknEEq/Q1myPXaIp4SwWSorZ5Nu46x+KY8/7Z8kB6Sm8XUpEPTmQsBIAIwG8fyKGFhSvBDpG/ncqLkRxKG4EAIh3XzTmJggbM7sA8HftrVQwOyENu3mJXtH43c0Tzu4rpu6h4wc+VixssCxBLB7QFDNTPGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEipq8Jj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEipq8Jj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FF81F000FF;
	Mon, 14 Sep 2026 00:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789346474;
	bh=fObGq8jNad+/mA9gRBzjTYvJpc8gy1HY1rp+ZYaaOwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PEipq8JjrTEeudRG0g054OYcA9uvx60TIHA26dA/0MuQq+w/H1fqK9H271XN3d6kb
	 /0/2nIVermUTfyo5hbUZuL7ydu0ddwvDW9thmD7AVvzTd92PCdjKOIdwt17zdotyaZ
	 2qbuBjeY37KsarLrbLk3whL08vBiO2sVlaC4/62xmplpztqlaZHtQgH0FY09UklzbV
	 X4l9QQQ0UcAiIZZz86yjK3seHoIH1E+wmZYiCN3vP6QdhyNDyfw0utlp5iSIgQt8jU
	 7zdwWQI1EFD0Lnydl0ifvO1aADIYVzfXJYzQ7MBX0Gb2AVhtu786Q67vAjDniY1AAj
	 jTuxH7p94uZHQ==
Date: Sun, 13 Sep 2026 17:41:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf annotate-data: Adjust type offset for flex-array
Message-ID: <aqdCqFVZ4O5eaSpW@google.com>
References: <20260912054706.1475583-1-namhyung@kernel.org>
 <20260912054706.1475583-5-namhyung@kernel.org>
 <20260912055756.8BEC81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260912055756.8BEC81F00893@smtp.kernel.org>

On Sat, Sep 12, 2026 at 05:57:56AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Division by zero when calculating the adjusted offset for a flexible array member if the array element size is zero.
> - [Medium] `find_flex_array()` fails to find the flex array member if the outer struct has trailing padding.
> - [Medium] Fallback struct matching fails for typedefs and unions.
> - [Medium] Struct padding holes are incorrectly annotated as the last member.
> --
> 
> commit 29427abf6848041f9bb5e65c33e21982de9656cd
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf annotate-data: Adjust type offset for flex-array
> 
> The flex array members are located beyond the original type size.  Also
> it needs to adjust the offset in an array to find a corresponding
> element using module operation.  Note that we focus on access to type and
> field, so array index is not important.
> 
> Make sure to find a field name for flex arrays.
> 
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > index ad043403ced58..0789a8cbea7c0 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> [ ... ]
> > @@ -332,19 +332,40 @@ static void delete_members(struct annotated_member *member)
> >  }
> >  
> >  static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
> > -			    int offset, bool first)
> > +			    int offset, bool first, bool has_flex_array)
> >  {
> [ ... ]
> > +	if (!found && has_flex_array) {
> > +		/*
> > +		 * It may have an intermediate struct that has another struct that
> > +		 * contains a flex array.  In that case, the outer struct itself is
> > +		 * has no array and the size is less than the offset so the above
> > +		 * logic won't find the outer struct at the offset.  Let's use the
> > +		 * last struct if it couldn't find a member for the flex array.
> > +		 */
> > +		child = list_last_entry(&m->children, struct annotated_member, node);
> 
> [Severity: Medium]
> In fill_member_name() in tools/perf/util/annotate-data.c, if the requested
> offset doesn't fall into any member's bounds (which occurs for accesses to
> padding bytes between fields), found remains false. If has_flex_array is true,
> this block unconditionally assigns child to the last member and sets found to
> true.
> 
> Will this cause random memory accesses to padding bytes to be erroneously
> annotated as valid accesses to the flexible array's parent struct?

Ok, I think it needs to verify if the offset is greater than equal to
the start of the flex array.

> 
> > +
> > +		if (!strstr(child->type_name, "struct "))
> > +			return 0;
> 
> [Severity: Medium]
> In fill_member_name() in tools/perf/util/annotate-data.c, can this fallback
> struct matching fail for valid nested flexible arrays declared with a typedef
> or a union?
> 
> If the nested intermediate member was declared using a typedef (e.g.,
> typedef struct { ... } foo_t;), the DWARF type name will be foo_t, lacking
> the substring "struct ". If it is a union, its type name begins with "union ".
> In these cases, this check fails, causing the function to incorrectly return 0
> and drop the annotation.

Ok, probably I can just remove this check.

> 
> > +
> > +		found = true;
> > +	}
> [ ... ]
> > +static struct annotated_member *find_flex_array(struct annotated_member *m, int offset)
> > +{
> > +	struct annotated_member *child;
> > +
> > +	if (list_empty(&m->children))
> > +		return NULL;
> > +
> > +	child = list_last_entry(&m->children, struct annotated_member, node);
> > +	if (offset == child->offset && strstr(child->type_name, "[]"))
> > +		return child;
> 
> [Severity: Medium]
> In find_flex_array() in tools/perf/util/annotate-data.c, will this strict
> offset equality check fail if the outer struct has trailing padding?
> 
> When get_flex_array_member() calls find_flex_array(&adt->self, adt->self.size),
> the offset argument is the struct's total padded size. If the struct contains
> trailing alignment padding (e.g., a previous 8-byte aligned member followed by
> the flex array), the struct's padded total size will be strictly greater than
> the actual starting offset of the flex array.
> 
> Will this cause find_flex_array() to fail the equality check and incorrectly
> recurse into the flex array itself, returning NULL and bypassing the offset
> adjustment logic?

Right, probably no need to check the offset as it always checks the last
member.

> 
> > +
> > +	return find_flex_array(child, offset);
> > +}
> [ ... ]
> > @@ -1743,6 +1786,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
> [ ... ]
> > +	if (result->flex_array && dloc->type_offset > result->self.size) {
> > +		struct annotated_member *flex_array = get_flex_array_member(result);
> > +		if (flex_array) {
> > +			int offset = dloc->type_offset;
> > +
> > +			/* adjust offset in the flex array */
> > +			offset -= result->self.size;
> > +			offset %= flex_array->size;
> 
> [Severity: High]
> In find_data_type() in tools/perf/util/annotate-data.c, is it possible for
> this modulo operation to divide by the flexible array's element size without
> validating that the size is non-zero?
> 
> The flex_array->size is determined by getting the size of the array's element
> type. If the element type is an empty struct (a GCC extension with size 0) or
> an incomplete type where DWARF size cannot be determined, flex_array->size
> becomes 0.
> 
> Could evaluating offset %= 0 here directly expose the perf tool to a
> divide-by-zero exception (SIGFPE) and crash?

Ok, will check if the size if 0.

Thanks,
Namhyung

> 
> > +			offset += result->self.size;
> > +
> > +			dloc->type_offset = offset;
> > +		}
> > +	}
> > +	return result;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260912054706.1475583-1-namhyung@kernel.org?part=4
