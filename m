Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9C45304AC;
	Thu,  1 Oct 2026 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878470; cv=none; b=bF+t657kKkO7gUPJ5KyMQRoa1kXpI7rbVq8bk1Eh3vGBzPQ8q4U8d8Zii3tFEs0bHCwqpDNlZ7//mgLgVqaGi7OLOjEwYQZ2aVTStcY9VASmP9N/ax3zNaI0luAhpqTvtGbjXljDErHpUTK7y6n5MGWU8Gm2K/9q7a0ytgGAn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878470; c=relaxed/simple;
	bh=w9P9rJzSRE0GpuIuoLKKYxu3RJc5Jzvrmnq0TtCsS/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm/QXmQIKwYNRnY3vapmwfOC0agikifjsmjvLb+by6t0RZwHew+hCm9yqwjWn4akAq+Lz2Cg7nJK/nDVfq/hAgOPjzAxIH7vkkbBS8sQYe7wCHZoDEV9nyzJQK3NF+xkYxWV8D8/IiZVBI9f3++ma7aRA065HmAKM7v6CNAPHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe/kvKa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe/kvKa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB71B1F00898;
	Thu,  1 Oct 2026 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790878462;
	bh=jS0Nq0w9RKs5B8nsMHGnTmNUpi2QgzhTBj/CTSHxK6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oe/kvKa9imnqiph3EzOibz/+ag7e9Ge6CMURePovPsw0z4tGtMuxDcR459Ny8Pyf8
	 /B1ql80ZLbAhhp69kw/OVfV3FcOMls2bsyyg+7sXCc5tkxTG3swqFHVSFqD7X1tHpn
	 0u6yaTMGrzdHs7Z33TVLQOOqOFpp5iv/fp5Ef9Y1iZ3YsZpWG7foff74O1wsJZAaPh
	 CSxSXFAbc/F7JkW/TYvAp32oMhcSuSDq+dF0SSsUiLp1xkF2q0AP9E7HRtcm1QL3Du
	 Qk11T13QFHOi8iEB7FY4tGfsixEMEV0un1yoM20DmaIJ3i6GR0sUVeu/Tnuu573KgS
	 TMzcNCLt6P1wg==
Date: Thu, 1 Oct 2026 11:14:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Yanbo Zhao <yzhao62@ncsu.edu>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf dwarf-aux: Add die_is_compound_type() to
 handle C++ class types
Message-ID: <ar6i_ZKXNVZmze2r@google.com>
References: <20260930210038.196928-1-yzhao62@ncsu.edu>
 <20260930210038.196928-2-yzhao62@ncsu.edu>
 <20260930211051.8EFDA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930211051.8EFDA1F000FF@smtp.kernel.org>

On Wed, Sep 30, 2026 at 09:10:51PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] perf/dwarf-aux: stack overflow in __die_find_member_offset_cb via cyclic inheritance
> - [Medium] perf/dwarf-aux: flex array detection fails for C++ classes
> --
> 
> commit 3f3b9b56b2e28f1713af3b40ab8946d5bbc8d245
> Author: Yanbo Zhao <yzhao62@ncsu.edu>
> 
> perf dwarf-aux: Add die_is_compound_type() to handle C++ class types
> 
> This commit introduces die_is_compound_type() to support C++ classes alongside
> structs and unions. It also updates offset lookups to descend into base class
> subobjects using DW_TAG_inheritance entries.
> 
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index 54f8b5ec74a2f..eb4b8f3475df1 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -61,6 +61,14 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
> >  	return dwarf_formstring(&attr);
> >  }
> >  
> > +bool die_is_compound_type(Dwarf_Die *type_die)
> > +{
> > +	int tag = dwarf_tag(type_die);
> > +
> > +	return tag == DW_TAG_structure_type || tag == DW_TAG_union_type ||
> > +	       tag == DW_TAG_class_type;
> > +}
> 
> [Severity: Medium]
> Does die_has_flex_array_recurse() also need to be updated to use this new
> helper?
> 
> If we look at die_has_flex_array_recurse() in tools/perf/util/dwarf-aux.c,
> it currently forces flex array detection to return false for C++ classes
> because it explicitly ignores DW_TAG_class_type:
> 
>     if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type)
>         return false;
>     ...
>     if (tag == DW_TAG_structure_type && found) {
>         if (is_flex_array_member(&last_mb))
>             return true;
> 
> Could this cause accesses to flex array members inside C++ classes to be
> wrongly rejected as out-of-bounds?

IIUC C++ officially doesn't support flexible arrays and there are
better alternatives so I guess it's rare to see them in C++ classes.
Maybe it's ok to ignore them until we find it's really needed.

> 
> [ ... ]
> 
> > @@ -2164,6 +2180,30 @@ static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
> >  			loc = 0;
> >  	}
> >  
> > +	if (tag == DW_TAG_inheritance) {
> > +		Dwarf_Die base_die, member_die;
> > +
> > +		/*
> > +		 * A base class subobject can be smaller than the size of the
> > +		 * class type: an empty base takes no space (EBO) and a member
> > +		 * of the derived class can be placed in the tail padding of
> > +		 * the base.  In both cases a member of the derived class is
> > +		 * at the same offset as the base, so only match the base if
> > +		 * it actually has a member at the offset.
> > +		 */
> > +		if (offset < loc)
> > +			return DIE_FIND_CB_SIBLING;
> > +
> > +		if (die_get_real_type(die_mem, &base_die) == NULL)
> > +			return DIE_FIND_CB_SIBLING;
> > +
> > +		if (die_find_child(&base_die, __die_find_member_offset_cb,
> > +				   (void *)(long)(offset - loc), &member_die))
> > +			return DIE_FIND_CB_END;
> 
> [Severity: High]
> Does this recursive call into the DWARF child tree lack a depth limit?
> 
> Unlike __add_member_cb(), there is no recursion depth limit tracked or
> enforced here. If a maliciously crafted or corrupted DWARF file contains
> cyclic inheritance (e.g., A inherits from B, B inherits from A), could
> this trigger unbounded mutual recursion between die_find_child() and
> __die_find_member_offset_cb(), rapidly exhausting the stack?

It looks like a corner case which requires some refactoring.  I feel
like we can add it in a separate patch.

Thanks,
Namhyung

