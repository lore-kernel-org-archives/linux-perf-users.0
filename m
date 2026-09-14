Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB061F4611;
	Mon, 14 Sep 2026 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789346178; cv=none; b=S6y79rBElZGSavRxPtMg3SSbf/E4S5iqdW28euUzBsVFnjrEIx5CRBtle/WtjF4iZEEAqRa18qmvH9LiHUOe0ZwzdwIrOgKawj9KaNjKjBSd+ivrIl77Hzj3goAutJ1SgGMpy5haZ0zb0hSOfoZ4XqOQ87p5x3vulW4W+Ze4D8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789346178; c=relaxed/simple;
	bh=zcfgCXijBe8VOXzQKRzbqL2NgTH3XJgnWdb0IMMvIn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmFpz7jFUp2qTjQP5HcWC/E4yQSin6uhWgnnWrclRpa4XVn99XU/NaMSfYFal4BBfZd8LpRfAZISRXpnt8u7a4C5fr2ms19qTygfBQwfQ3NDRQIMavBaLDtFM9KWDYecuCUkUjOuFx++VHaRq1/Y9wCT4ix+k8BuxNqqfmzaoV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrsJwin7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrsJwin7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADE11F000FF;
	Mon, 14 Sep 2026 00:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789346176;
	bh=dBfAGTv5TDPh12ICCTP92vWbJj7U9jhJD98+1kH4na0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LrsJwin7qRRXySZh/MQSZ7idKN5GVOSd/2V19L5MrqbBZtypee8NV87hadNrNTMND
	 0kTpXuepK9cwM6mYvXki5uxdZrjr88Pp6CF6keWWa8a9d4reGEOFm9qCc2kGoKmfiG
	 BG9DU3RtdFWSsMPUFs72OYpboV58tXCTE54wKcC7LamdRGvlBNelgH6U+UEQZ9QL04
	 LURrkZGNlCeoz3cSDi/4tbPkYyFujaNIz3tNTyXsWAyf+XvrUEqr0TYZlLCZvZRhI2
	 ASi7jPX+ksjWINZ0TlRRKy9+Z3HMQFuAtjzvCe0XeHF0NbCHS5FLtjOyOk57KtZhdo
	 ek9pJDaxr8Ydg==
Date: Sun, 13 Sep 2026 17:36:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] perf annotate-date: Allow out-of-size access for
 flex-array types
Message-ID: <aqdBfo6cz7IgTqrt@google.com>
References: <20260912054706.1475583-1-namhyung@kernel.org>
 <20260912054706.1475583-4-namhyung@kernel.org>
 <20260912060225.69D271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260912060225.69D271F000FF@smtp.kernel.org>

On Sat, Sep 12, 2026 at 06:02:24AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Low] The patch breaks the negative bounds check for variables containing flexible arrays, allowing invalid negative offsets to be falsely accepted.
> - [Low] Failure to expand flexible array elements if the element type is a typedef.
> 
> Pre-existing issues:
> - [Low] Missing explicit inclusion of <string.h> for libc string functions, violating musl compatibility subsystem guidelines.
> --
> 
> commit 71730adfd191d6d7dd60b7b99d73c9bc2ede7031
> Author: Namhyung Kim <namhyung@kernel.org>
> 
>     perf annotate-date: Allow out-of-size access for flex-array types
>     
>     Structs that have a flex array will have accesses beyond its original
>     size as the array was declared as 0 sized.  For now, it just allow any
>     offset bigger than the size.  It could be refined later.
> 
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > index aff60a630fd05..ad043403ced58 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> > @@ -8,5 +8,5 @@
> >  #include <errno.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <inttypes.h>
> >  #include <linux/zalloc.h>
> 
> [Severity: Low]
> This is a pre-existing issue, but is there a missing include for <string.h>
> in tools/perf/util/annotate-data.c? The file uses libc string functions like
> strcmp and strdup, and failing to explicitly include <string.h> violates the
> subsystem guidelines for musl libc compatibility, which could lead to build
> failures.

Will add.

> 
> [ ... ]
> 
> > @@ -248,8 +248,15 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
> >  	else
> >  		die_mem = member_type;
> >  
> > -	if (dwarf_aggregate_size(&die_mem, &size) < 0)
> > -		size = 0;
> > +	if (dwarf_aggregate_size(&die_mem, &size) < 0) {
> > +		if (dwarf_tag(&die_mem) == DW_TAG_array_type) { /* flex-array? */
> > +			__die_get_real_type(&die_mem, &die_mem);
> 
> [Severity: Low]
> Will __add_member_cb() fail to resolve typedefs here? Using
> __die_get_real_type instead of die_get_real_type strips const and volatile
> qualifiers but stops at DW_TAG_typedef. This prevents the subsequent struct
> expansion if the flexible array element type is a typedef of a struct.

Ok, I can change it to die_get_read_type() to handle tyepdef.

> 
> > +			if (dwarf_aggregate_size(&die_mem, &size) < 0)
> > +				size = 0;
> > +		} else {
> > +			size = 0;
> > +		}
> > +	}
> >  
> >  	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {
> 
> [ ... ]
> 
> > @@ -559,7 +567,7 @@ static enum type_match_result check_variable(struct data_loc_info *dloc,
> >  		return PERF_TMR_NO_SIZE;
> >  
> >  	/* Minimal sanity check */
> > -	if ((unsigned)offset >= size)
> > +	if ((unsigned)offset >= size && !die_has_flex_array(&sized_type))
> 
> [Severity: Low]
> Does check_variable() allow invalid negative offsets to bypass the check?
> Since offset is cast to unsigned, a negative offset evaluates to a large
> positive number. If the type has a flexible array, the negative bounds check
> is now broken and the offset will be falsely accepted.

Right, I'll add a separate negative value check.

> 
> >  		return PERF_TMR_BAD_OFFSET;
> >  
> >  	return PERF_TMR_OK;
> 
> [ ... ]
> 
> > @@ -1168,7 +1176,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
> >  
> >  		/* Get the size of the actual type */
> >  		if (dwarf_aggregate_size(&sized_type, &size) < 0 ||
> > -		    (unsigned)dloc->type_offset >= size)
> > +		    ((unsigned)dloc->type_offset >= size && !die_has_flex_array(&sized_type)))
> 
> [Severity: Low]
> Could this logic in check_matching_type() lead to negative offsets bypassing
> the check as well? Similar to check_variable(), casting dloc->type_offset to
> unsigned causes negative values to appear as large positive numbers, bypassing
> the bounds check if there is a flexible array. This flaw is repeated multiple
> times in the pointer tracking logic.

Will fix them all.  Probably with a helper function.

Thanks,
Namhyung

> 
> >  			return PERF_TMR_BAD_OFFSET;
> >  
> >  		return PERF_TMR_OK;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260912054706.1475583-1-namhyung@kernel.org?part=3
