Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EEC248896;
	Sat, 19 Sep 2026 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789802373; cv=none; b=HK2bmGFyE7wM134R8PkS+8nK0JA76TrT4PhQoBTJMwYXtd3sArOsIZyRnJknv3YBRocxtxzoeCibZZFXQWXDCezGWXeMgJf2AQsWXg8ls4xL4UHu0W3YHOJtDUFCq212Kt2TuP3VuA9JnCJAKtzNTWUJUjWrKPdZGIYKDd5Npn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789802373; c=relaxed/simple;
	bh=0gpq8ITjjwq0RtKYSegekReqPxa0IW/AgK4iNjTV8q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRxm2MOSGY5KtiWFllXlYQtMVbCWupd8NIsgYiubifFz42Efj/pYysjdp0sB7/R72aZ40GosW9pI6NfxY45f0E/SogYyFuzpeWnfhROyfk+020wtOzepj/eIuOhSjeR4i6/16vE8h+lhKEQQg3uuSuarIlT5a75/Qq2AHPN7yTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0rmZkEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0rmZkEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52E41F000FF;
	Sat, 19 Sep 2026 07:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789802371;
	bh=4uIB0dRz17da31aEieG1rUFLAuF4O+fIONGYthd8A6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L0rmZkEo9HozLKOWgFKp+mPYGjUseRs8SnEdwMxLY+pq1ygBNPnn7gbNZp5HjEoTH
	 rKBaHjYmfcg6wGa+uKGhA82sNUDgWPaY2iIdLBHem4Gj6/X0N96tiDZWLqkVok1VWS
	 eZjZ/k1qkkGnmQNdo4kNMFMwrifJMXDsySbjcwuRfIjb99McsLKCelZBwJS6gWW9za
	 JbQvczqFI1Wq89thH3lN5/DFBkMN/xFrarwXpwssmNt822JbgE2HIe51K4qE3SN2Gj
	 /ATKtexwcc/yxPqRXRyRM+dF3FRRi/2Fznf5jFuoyTEipOwr1WYTxJqebqwBENsj3c
	 Dk3ty5QaApjnQ==
Date: Sat, 19 Sep 2026 00:19:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 4/4] perf annotate-data: Adjust type offset for
 flex-array
Message-ID: <aq43ghI8KTFfkMje@z2>
References: <20260919063745.48444-1-namhyung@kernel.org>
 <20260919063745.48444-5-namhyung@kernel.org>
 <20260919064647.C05051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260919064647.C05051F000FF@smtp.kernel.org>

On Sat, Sep 19, 2026 at 06:46:47AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf annotate-data: incorrect flex array adjustment skips elements in struct padding
> --
> 
> commit b87f5c6310512e6a55305050539cf57984efb087
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf annotate-data: Adjust type offset for flex-array
> 
> The flex array members are located beyond the original type size.  Also
> it needs to adjust the offset in an array to find a corresponding
> element using module operation.  Note that we focus on access to type and
> field, so array index is not important.
> 
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > index 5dd6c6ec2d424..e9b58a3d587be 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> 
> [ ... ]
> 
> > @@ -1741,6 +1816,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
> >  {
> >  	struct dso *dso = map__dso(dloc->ms->map);
> >  	Dwarf_Die type_die;
> > +	struct annotated_data_type *result;
> >  
> >  	/*
> >  	 * The type offset is the same as instruction offset by default.
> > @@ -1753,7 +1829,25 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
> >  	if (find_data_type_die(dloc, &type_die) < 0)
> >  		return NULL;
> >  
> > -	return dso__findnew_data_type(dso, &type_die);
> > +	result = dso__findnew_data_type(dso, &type_die);
> > +	if (result == NULL)
> > +		return NULL;
> > +
> > +	if (result->flex_array && dloc->type_offset > result->self.size) {
> 
> [Severity: Medium]
> Since result->self.size (derived from DWARF's DW_AT_byte_size) includes
> trailing padding for alignment, won't this check skip flex array elements
> that fall within the struct's padded size boundary?
> 
> For example, if a struct has an 8-byte aligned member and a trailing flex
> array of 2-byte structs, the struct size includes up to 6 bytes of trailing
> padding. Accesses to indices 1 through 3 would remain `<= result->self.size`
> and erroneously skip this modulo adjustment.
> 
> Does this cause fill_member_name() to fail matching the unadjusted offset
> against the first element's nested fields, truncating the resolved name to
> just the outer array name instead of the specific inner field?

As I said, I think practically this is fine and will find a flex array
member for most cases.

Thanks,
Namhyung

> 
> > +		struct annotated_member *flex_array = get_flex_array_member(result);
> > +
> > +		if (flex_array && flex_array->size > 0) {
> > +			int offset = dloc->type_offset;
> > +
> > +			/* adjust offset in the flex array */
> > +			offset -= flex_array->offset;
> > +			offset %= flex_array->size;
> > +			offset += flex_array->offset;
> > +
> > +			dloc->type_offset = offset;
> > +		}
> > +	}
> > +	return result;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260919063745.48444-1-namhyung@kernel.org?part=4
