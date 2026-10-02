Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A33438A0;
	Fri,  2 Oct 2026 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790981566; cv=none; b=gZF3XbxRSi3W0hfltz9Me/RIj+OgcGJ8VEuLAoZl1jkm4xYZ0+aPJxdqDYVMPvJZr6r75KrgfWqAliUiOXz+v2z7+7KNOtDHtZ+hWjzaN9sGuGG+7sWQ1O72I7f1ouErGZcnKKEOPiZADEjghxWkq4u7bUqKzrUOfvRDV/9K8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790981566; c=relaxed/simple;
	bh=0+PRHAdnIW4b5KGtIbdTCy6AkPvzX4dQrn+b/TfinPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WL5TDrgKZ2DA9U+L0ys+7GPEtQmOr9Rki5y9y+zwO9rGZ13dB04AbxlGC4efHr+HrQT5Z8RohyEkk0h1WWY3ts2lyXHhhDFbXAzS3roKOZ+kvI/55Ds/KiX/SqCCBxT4NEWtm1sSiNWDanxT94fT15lSN6rhloT8xM53c6oeKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8qxcvla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8qxcvla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D5F1F000FF;
	Fri,  2 Oct 2026 22:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790981564;
	bh=sk8cmahE72VkyCDPGqs7Xgd7IrOvJ3nVdLA7qac7vYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y8qxcvlacV3yYi9GMwbiU+wADA1L4gc/4LwDBFFAiTbrLw3To91c/V0upinBCYOJU
	 TZ00ynl6Y5mOyleeBefpNlvVyXuyLSknlpt8DIYgRvJFBg1qf9U67PJXVQGmkqVEmY
	 hfAmDS17P3/y6/5UYbJ5C5GIicX6ShrzgHXMo/lvB/poEeKZyxYhkEQ6E0+cj+jR8T
	 TePqFQtWYE8EppwKI6148erlXB2DK8rUmt68fItT5lUfuByH1VhpJz9+6xgwD8paW4
	 BrVHIpkAqH5NhwNDB8kvfBD1zqHew0i0JqoSifHCx5m2hyOGZZhDKyrA5wqb71cfQ6
	 ucWb6f4DZkbaw==
Date: Fri, 2 Oct 2026 15:52:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Yanbo Zhao <yzhao62@ncsu.edu>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf dwarf-aux: Add C++ vtable helpers
Message-ID: <asA1u7LBRp2gqbWI@google.com>
References: <20260930210038.196928-1-yzhao62@ncsu.edu>
 <20260930210038.196928-3-yzhao62@ncsu.edu>
 <20260930211057.2E1641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930211057.2E1641F000FF@smtp.kernel.org>

On Wed, Sep 30, 2026 at 09:10:56PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf dwarf-aux: DW_AT_virtuality presence check incorrectly skips non-virtual bases
> - [Medium] perf dwarf-aux: infinite loop in C++ inheritance traversal on malformed DWARF
> --
> 
> commit e1f1b87424c8d58d923a8c3fbc1408fa0ae0c3b9
> Author: Yanbo Zhao <yzhao62@ncsu.edu>
> 
> perf dwarf-aux: Add C++ vtable helpers
>     
> Add DWARF helper functions needed to resolve C++ virtual function calls
> statically in the data type profiling.
> 
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index eb4b8f3475df1..b1f3dca057abb 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -2293,6 +2293,222 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
> > [ ... ]
> > +static int __die_find_primary_base_cb(Dwarf_Die *die_mem, void *arg __maybe_unused)
> > +{
> > +	Dwarf_Attribute attr;
> > +	Dwarf_Die base_die, vptr_die;
> > +	Dwarf_Word loc;
> > +
> > +	if (dwarf_tag(die_mem) != DW_TAG_inheritance)
> > +		return DIE_FIND_CB_SIBLING;
> > +
> > +	if (dwarf_attr_integrate(die_mem, DW_AT_virtuality, &attr))
> > +		return DIE_FIND_CB_SIBLING;
> 
> [Severity: Medium]
> Does this code incorrectly skip valid primary base classes when parsing DWARF 5?
> 
> DWARF 5 allows DW_AT_virtuality to be present with the default value
> DW_VIRTUALITY_none (0x00).
> 
> If a compiler explicitly emits this default value, will the presence check
> evaluate to true and falsely identify the non-virtual base as virtual,
> skipping it?

Right, it'd be better to check the value of the attribute as well.

> 
> > +
> > +	if (die_get_data_member_location(die_mem, &loc) < 0 || loc != 0)
> > [ ... ]
> > +Dwarf_Die *die_find_virtual_func(Dwarf_Die *class_die, int index,
> > +				 Dwarf_Die *die_mem)
> > +{
> > +	Dwarf_Die cur_die = *class_die;
> > +	Dwarf_Die base_die;
> > +
> > +	while (die_is_compound_type(&cur_die)) {
> 
> [Severity: Medium]
> Can this loop hang indefinitely when processing malformed DWARF?
> 
> If a maliciously crafted or malformed DWARF file contains cyclic inheritance,
> die_get_real_type() resolves the type back to the current class.
> 
> Since the loop does not maintain a depth counter or cycle detection, does it
> spin infinitely as it re-evaluates the same class type?

It seems sashiko is picky about possible recursions on invalid dwarf.
As we recently added recursion depth limits, can you follow the
convention and bail out if it detects one?

> 
> > +		if (die_find_child(&cur_die, __die_find_virtual_func_cb,
> > +				   (void *)(long)index, die_mem))
> > +			return die_mem;
> > [ ... ]
> > +Dwarf_Die *die_get_vptr_class(Dwarf_Die *type_die, int offset,
> > +			      Dwarf_Die *die_mem)
> > +{
> > +	Dwarf_Die class_die = *type_die;
> > +	Dwarf_Die vptr_class = *type_die;
> > +	Dwarf_Die member_die, mb_type;
> > +	Dwarf_Word loc;
> > +
> > +	while (die_is_compound_type(&class_die)) {
> 
> [Severity: Medium]
> Similarly, does this loop also lack a depth limit or cycle detection when
> traversing base class subobjects dynamically, risking infinite cycles on
> malformed DWARF?

Ditto.

Thanks,
Namhyung

> 
> > +		if (die_find_child(&class_die, __die_find_member_offset_cb,
> > +				   (void *)(long)offset, &member_die) == NULL)
> > +			return NULL;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930210038.196928-1-yzhao62@ncsu.edu?part=2
