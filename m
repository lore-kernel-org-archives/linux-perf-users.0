Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7B3DAAD0;
	Wed, 16 Sep 2026 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538296; cv=none; b=kdhtZOXNtjvMiCTA/sMVYy5OF/9B9Si0XTUk9O095Vo2pLru82SUMJ2MNrTm0UGmIFQaVBERhZnMaUwfFR8A/nz5f/giwQ8RGPGoHvnfzyAcxAl24BYDIR5+Zx0E39w92UFMhoZ0GFWjUtREhLVlJpP7zveNuA4G4N3UFROthtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538296; c=relaxed/simple;
	bh=et0jC4mSIv2ZIl2g8eCuAGl4TvBrjzla1xbzmCO6/ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf6QbqwG1xF77T8WtbNYNdL3mw5gRrzM7pQH9O5n6fv+JwXSxY9Y11rou3tli5YSGItuSMCjX+VYoKiV1sYT1ohvW/CBmCs4jDhka8ClyzHzf5PUkUNwDUJuYRbi4uUB2kVBR/nMR2Qs18EVYaVvy2oZtJaPNkOIvNuBuu+qb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5VYP5b+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5VYP5b+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08571F000FF;
	Wed, 16 Sep 2026 05:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789538294;
	bh=4bLXG1bXs90Ttift3qTLDBxDS6inIZijbenQqiq9uxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V5VYP5b+vsLVq79wCSLtwj9+WRjRMP3Gz/TOJ36Bh51p8sFc4XLlJi9YFyAgp2TZw
	 V8wR3F5ZLzOiV98faKgkFPlEGM97GOKUbyqThPKfBnxejnOI/1PpcphfjKEjxnQbOI
	 JZggo/ml3LVkinwzKwzM9kxS9MVFwBgFh9i1pAla9JR75m+qnAnqSbGlxTwwgDl/uL
	 knI4kI2TX/cHrt+vKtsaQO2H3GNczd5jKaXBRFkQMDX2HI1pKBztc+ZGvHKJP88n27
	 FpeNqyIzqN30wX5of8zRxjcKsui9wdOnV3SRgI6CTb8PL8ebAEOTxVSvRrhBy01iPE
	 AdRBAmoQvhuWg==
Date: Tue, 15 Sep 2026 22:58:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 3/3] perf annotate-data: Adjust type offset for
 flex-array
Message-ID: <aqov9bkuxh6cNI5F@google.com>
References: <20260915064035.1970175-1-namhyung@kernel.org>
 <20260915064035.1970175-4-namhyung@kernel.org>
 <20260915065313.ECA271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915065313.ECA271F000FF@smtp.kernel.org>

On Tue, Sep 15, 2026 at 06:53:13AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] perf: flex-array offset adjustment skips elements in tail padding
> - [Medium] perf: zero-length flex-arrays bypass element size extraction
> - [Medium] perf: null pointer dereference in find_flex_array() on alloc failure
> --
> 
> commit f8d5c159e83503d5c3d85f5f3c22dec6b4f25c06
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf annotate-data: Adjust type offset for flex-array
> 
> This commit adjusts the type offset for flexible array members in perf's
> data annotation. It ensures that the offset is properly adjusted to find
> the corresponding element using modulo operations and updates the member
> name resolution to correctly identify flex arrays.
> 
> > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > index 1ee2b74f99205..1c19b807c4f21 100644
> > --- a/tools/perf/util/annotate-data.c
> > +++ b/tools/perf/util/annotate-data.c
> > @@ -241,7 +241,8 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
> >  		return DIE_FIND_CB_END;
> >  
> >  	strbuf_init(&sb, 32);
> > -	die_get_typename(die, &sb);
> > +	if (die_get_typename(die, &sb) < 0)
> > +		strbuf_add(&sb, "(unknown type)", 14);
> >  
> >  	__die_get_real_type(die, &member_type);
> >  	if (dwarf_tag(&member_type) == DW_TAG_typedef)
> 
> [Severity: Medium]
> Does this code safely handle zero-length flexible arrays during element size
> extraction?
> 
> Just below this change in __add_member_cb(), the logic assumes failures
> for flexible arrays:
> 
> 	if (dwarf_aggregate_size(&die_mem, &size) < 0) {
> 		if (dwarf_tag(&die_mem) == DW_TAG_array_type) {
> 			die_get_real_type(&die_mem, &die_mem);
> 			...
> 
> Since dwarf_aggregate_size() returns 0 for zero-length arrays, the < 0
> condition is skipped. This disables offset adjustment for all GNU zero-length
> arrays (e.g., [0]), which results in incorrect field annotations.

Ok, will handle that too.

> 
> [ ... ]
> > @@ -355,15 +377,37 @@ static int fill_member_name(char *buf, size_t sz, struct annotated_member *m,
> [ ... ]
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
> Could child->type_name be NULL here?
> 
> If strbuf_init() or strbuf_add() fails due to memory pressure during type
> string construction, strbuf_detach() returns NULL. Passing an unchecked NULL
> pointer to strstr() in find_flex_array() could cause a segmentation fault in
> the perf tool.

I'll check the return value of strbuf_init().  Then strbuf_add() won't
fail and type_name cannot be NULL.

> 
> > +		return child;
> > +
> > +	return find_flex_array(child);
> > +}
> [ ... ]
> > @@ -1740,6 +1784,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
> [ ... ]
> > -	return dso__findnew_data_type(dso, &type_die);
> > +	result = dso__findnew_data_type(dso, &type_die);
> > +	if (result == NULL)
> > +		return NULL;
> > +
> > +	if (result->flex_array && dloc->type_offset > result->self.size) {
> 
> [Severity: Medium]
> Does this condition skip elements located in the tail padding of the struct?
> 
> By checking that dloc->type_offset > result->self.size, the offset adjustment
> is skipped if the flexible array element being accessed has an offset less
> than or equal to the total padded size of the parent struct. 
> 
> The unadjusted offset fails to match children in fill_member_name(),
> erroneously falling back to the last member during offline perf data analysis.

As I said in the previous version, I think it's ok and it'll find the
member when the offset is less than the total size.

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
> Sashiko AI review · https://sashiko.dev/#/patchset/20260915064035.1970175-1-namhyung@kernel.org?part=3
