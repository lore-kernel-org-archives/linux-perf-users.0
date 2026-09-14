Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70359371067;
	Mon, 14 Sep 2026 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418336; cv=none; b=TTnk7SiZufWMwf0z9zOb2XQJmiL95ttolGAlcZT936S3SzDSRMYefr3vR/nlz0iRdClLE1lRVPdn6t8063N8cDIfaf2N1s/gSGhDL8XoXpWRKugBz8QT4byHwn0BrHYxJNkL1Wp2WNohwcCeB3W6cQt7UEyKNoBO0Svk7IOzsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418336; c=relaxed/simple;
	bh=yEHDj0OcrRVuSLu7zUTid1cIYCLNJ5VtZYE9ps7V+64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGNFhLmK+nRrgjge3mXrOC8oSdJOS51m54zUFeK6WtEisvS5TAbSfMoerSTq3Vcrm6uk7hFenOzqf9bPXXEVi2qr285pXPrdDH3QLp7mVnJVs9beO9G2B27/eXZzx5sLPMWsIcBGiudzd5CCHxa2+GLgIdm0wUQGny+iv5iCLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMPRxE35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMPRxE35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1177A1F000FF;
	Mon, 14 Sep 2026 20:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789418335;
	bh=HtACgMY2jyiDkJhkmXqq3UKVjivKTsin/mOWkzWYv/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AMPRxE35EpPIuLhQHI3mQxvupEGJugdmB5toFaxaLBjtyelLDSUD1nAJ99oeJasCj
	 s2sOHli7cP717Op4H9AaBENYvMnE9yOsgu7n2lVnl4bZ//cXkKKRZmoMz9IFSue0ri
	 go70e62w8bFWXdo6smJRGyDl2iViDYGkZ2ObWoKgk47CILfrUjAT0LXNH0U+Q33jVT
	 Llix6LM+meyOzjDRVxJ5ynZ60JjC7FQlfhGGozp/BOJbevRDzEIsMp64BATPafnKr6
	 6vNVicxpf7YIwOIpPm5wOIybGrnrSCWE5+rUE8AzD4G8ryLCxrNeMG17eRnBeg3m9p
	 4apLsKGaziO8A==
Date: Mon, 14 Sep 2026 13:38:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 4/4] perf annotate-data: Adjust type offset for
 flex-array
Message-ID: <aqhbXa25oQYEWRTS@google.com>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-5-namhyung@kernel.org>
 <20260914070105.209DC1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914070105.209DC1F0089A@smtp.kernel.org>

On Mon, Sep 14, 2026 at 07:01:04AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] Off-by-one error and tail padding overlap in flex-array offset adjustment causes accesses to be silently dropped and incorrectly attributed.
> - [Medium] Calling `strstr()` on `child->type_name` without checking for NULL causes a segmentation fault if memory allocation failed during type name extraction.
> - [Medium] The newly added `strstr(child->type_name, "[]")` call reads uninitialized heap memory, leading to out-of-bounds reads and potential crashes when analyzing malformed or unknown DWARF entries.
> --
> 
> commit 546415e2740f53443f133b3600542636f3d84f31
> Author: Namhyung Kim <namhyung@kernel.org>
> perf annotate-data: Adjust type offset for flex-array
> 
> This commit adjusts the type offset for flexible array members that are located
> beyond the original type size. It ensures a field name is found for flex arrays
> by adjusting the offset in an array to find a corresponding element.
> 
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > index e8aff6a916c0a..a66b72feb6e2f 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> 
> [ ... ]
> 
> > @@ -355,15 +376,37 @@ static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
> >  			len = 0;
> >  		}
> >  
> > -		return fill_member_name(buf + len, sz - len, child, offset, first) + len;
> > +		return fill_member_name(buf + len, sz - len, child, offset, first,
> > +					has_flex_array) + len;
> >  	}
> > +
> >  	return 0;
> >  }
> >  
> >  int annotated_data_type__get_member_name(struct annotated_data_type *adt,
> >  					 char *buf, size_t sz, int member_offset)
> >  {
> > -	return fill_member_name(buf, sz, &adt->self, member_offset, /*first=*/true);
> > +	return fill_member_name(buf, sz, &adt->self, member_offset, /*first=*/true,
> > +				adt->flex_array);
> > +}
> > +
> > +static struct annotated_member *find_flex_array(struct annotated_member *m)
> > +{
> > +	struct annotated_member *child;
> > +
> > +	if (list_empty(&m->children))
> > +		return NULL;
> > +
> > +	child = list_last_entry(&m->children, struct annotated_member, node);
> > +	if (strstr(child->type_name, "[]"))
> 
> [Severity: Medium]
> Could this call to strstr() safely handle scenarios where child->type_name is
> NULL or uninitialized?
> 
> During DWARF parsing, for instance in __add_member_cb(), if die_get_typename()
> fails due to a malformed DWARF entry or memory exhaustion, strbuf_detach()
> might return an uninitialized heap buffer or NULL. If that happens, does this
> scan risk triggering a segmentation fault or an out-of-bounds read when looking
> for the "[]" string?

Ok, will check.

> 
> > +		return child;
> > +
> > +	return find_flex_array(child);
> > +}
> 
> [ ... ]
> 
> > @@ -1740,6 +1783,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
> >  {
> >  	struct dso *dso = map__dso(dloc->ms->map);
> >  	Dwarf_Die type_die;
> > +	struct annotated_data_type *result;
> >  
> >  	/*
> >  	 * The type offset is the same as instruction offset by default.
> > @@ -1752,7 +1796,25 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
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
> Will this boundary check correctly catch accesses that fall exactly on the
> boundary or within the struct's tail padding?
> 
> If an event samples a flexible array element whose offset is greater than 
> flex_array->offset but less than or equal to result->self.size (the total
> padded size of the struct), it appears this condition evaluates to false.
> Could this cause the offset adjustment to be skipped, causing valid sample
> counts to be silently dropped during data presentation?

I think it's ok.  If it's less than or equal to result->self.size, it'd
have high chances to fall into the flex array element so I think they
will be processed properly without adjusting the offset.

Basically this adjustment is to improve visualization of the member
name.  It won't to drop samples anyway.

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
> Sashiko AI review · https://sashiko.dev/#/patchset/20260914064535.1671939-1-namhyung@kernel.org?part=4
