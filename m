Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A338442FBE;
	Mon, 14 Sep 2026 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417942; cv=none; b=g2RM0f4FbM1ZQKHKvD+LiKJlFnWzcJWXb68mwVpstLW7AOGssWzsRg22uqjuLfn2o/eqi9TztQELJpjKUO64+iuW+Do7dMKiiESNJmb+FIEWcgRW7kBFIg1j3URvfFM3lpWcXp3ZEY7tO8TFgOcvy57awOx7Qza06v6YFInXh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417942; c=relaxed/simple;
	bh=zYl0IiqW10o87NfZCnRWySNKX55Em0WStArvbcTtXVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx9HD6/NdQ7MboZWkFFt1pNDPr6CQldeslJgMV0+z9Depzzfs4jOKP04WcnBfb2QnvtOMo7DFtDiHGcuCLwKMawqOWgSkhY40Mp1XHqkFy90u0pqkdDvP1IaDGCqzWIjLjrfnTRIBExeWK2EEvuKtWTFRRgARH+QixANxNxG4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfYLlG1I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfYLlG1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E468A1F000FF;
	Mon, 14 Sep 2026 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417941;
	bh=Lc0fZw3sGAXNoTNspT8RYmpd8RC7tFsmkpl1MGBnjHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hfYLlG1IU1J5mAGI0GT86tOFpk24ydCHJAB8U10PiUD2lzYJ77f3D3YAEwmX7p+Q0
	 AwJwfKCmHElW9/k0AkBaPI0rH8cuAVqw7ikAXxlIlSVmXuJd5lr14UroyHVlnnfUnZ
	 hg7BLuq/3xEXaB32CUw6XcrLSxhkxSgmCRDY6qfFOja4TX8F9Qnli0y11ChmDtE3YK
	 oDjtXNwdWsifFVft/yyibzEG+Z/lETWQ3RM4LeGTN2H6waPxZ0l+LgmernJfpkVY0Y
	 x1Si5zxb5OmYzLl9kI7efq7TP8FaVGx4C8tP03daqTD+274pe2uciEmRGYtbAet4kt
	 IqC/gttmmhn3w==
Date: Mon, 14 Sep 2026 13:32:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf annotate-date: Allow out-of-size access for
 flex-array types
Message-ID: <aqhZ054shwK7_eR_@google.com>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-4-namhyung@kernel.org>
 <20260914070049.635701F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914070049.635701F0089C@smtp.kernel.org>

On Mon, Sep 14, 2026 at 07:00:48AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] check_variable and check_matching_type fail to pass the typedef-resolved 'sized_type' to 'check_type_offset', causing an unused variable warning and breaking flex-array detection for typedefs.
> - [Medium] Uninitialized stack variable 'last_mb' is used in 'die_has_flex_array_recurse' if a structure contains children but no data members.
> --
> 
> commit cd675d28ffa1b31e0fe343fa27c89e7794eb74ec
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf annotate-date: Allow out-of-size access for flex-array types
>     
> Structs that have a flex array will have accesses beyond its original
> size as the array was declared as 0 sized.  For now, it just allow any
> offset bigger than the size.  It could be refined later.
> 
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > index aff60a630fd05..e8aff6a916c0a 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> 
> [ ... ]
> 
> > @@ -399,6 +407,7 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
> >  	result->self.type_name = type_name;
> >  	result->self.size = size;
> >  	INIT_LIST_HEAD(&result->self.children);
> > +	result->flex_array = die_has_flex_array(type_die);
> 
> [Severity: Medium]
> Will this call into die_has_flex_array_recurse() trigger an uninitialized
> stack variable access for empty structures?
> 
> If the structure has child DIEs but none of them are DW_TAG_member, the
> last_mb variable won't be assigned in the loop, leaving it uninitialized
> when evaluated:
> 
> tools/perf/util/dwarf-aux.c:die_has_flex_array_recurse() {
> 	Dwarf_Die die_mem, last_mb;
> ...
> 	do {
> 		if (dwarf_tag(&die_mem) != DW_TAG_member)
> 			continue;
> ...
> 		if (tag == DW_TAG_structure_type)
> 			memcpy(&last_mb, &die_mem, sizeof(last_mb));
> 
> 	} while (dwarf_siblingof(&die_mem, &die_mem) == 0);
> 
> 	if (tag == DW_TAG_structure_type) {
> 		if (is_flex_array_member(&last_mb))
> 			return true;
> ...
> 
> Should last_mb be initialized, or should we track whether it was set before
> calling is_flex_array_member()?

Will fix.

> 
> >  
> >  	if (symbol_conf.annotate_data_member)
> >  		add_member_types(result, type_die);
> 
> [ ... ]
> 
> > @@ -554,15 +580,7 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
> >  	else
> >  		sized_type = *type_die;
> >  
> > -	/* Get the size of the actual type */
> > -	if (dwarf_aggregate_size(&sized_type, &size) < 0)
> > -		return PERF_TMR_NO_SIZE;
> > -
> > -	/* Minimal sanity check */
> > -	if ((unsigned)offset >= size)
> > -		return PERF_TMR_BAD_OFFSET;
> > -
> > -	return PERF_TMR_OK;
> > +	return check_type_offset(type_die, offset);
> >  }
> 
> [Severity: Medium]
> Should this pass &sized_type instead of type_die?
> 
> Passing type_die ignores the typedef resolution performed earlier in this
> function and leaves sized_type completely unused. Since check_type_offset()
> now evaluates die_has_flex_array(type_die), this might break flex-array
> detection for types hidden behind typedefs.

Oops, that's right.  Will fix.

> 
> [ ... ]
> 
> > @@ -1190,12 +1202,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
> >  
> >  		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
> >  
> > -		/* Get the size of the actual type */
> > -		if (dwarf_aggregate_size(type_die, &size) < 0 ||
> > -		    (unsigned)dloc->type_offset >= size)
> > -			return PERF_TMR_BAD_OFFSET;
> > -
> > -		return PERF_TMR_OK;
> > +		return check_type_offset(type_die, dloc->type_offset);
> >  	}
> 
> [Severity: Medium]
> For pointer types here, should type_die also be stripped of typedefs before
> checking the type offset?
> 
> Similar to the logic used for TSR_KIND_TYPE, flex-arrays might go undetected
> if they are hidden behind unresolved typedefs.

This may be a valid concern but doesn't belong to this change.  Probably
I can check and fix separately later.

Thanks,
Namhyung

