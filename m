Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B549E5E3;
	Mon, 14 Sep 2026 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417685; cv=none; b=Ky+mJCfhOJbSkyUxcnggxD7hVxCWAwY7aGrI9jR7Kh3DuCddbL+kRJBb4hqCbXR9MHUrRtDlm5NYK69dCfscVx7oshqhmtc8r2yyiX1mgD5KmsP6HDjImNR6QGAHvLXlGs1g++RdNvow3o0+SKW2H0mrklAJ4js5PiUOZ5lxUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417685; c=relaxed/simple;
	bh=uyO3IBh3iu2ZEWiRiGpu/T78ScWQ+VfFvl3xyuXIDgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3HzSyRmiSNG+m3t4+x4q3sWwBb/1UQ6ULbcSlSn7DsFmO/+mPumVxpFDV6LDoMQTeqwU6URCwPlt91s0B2c6FXUZkpyAoeCfVjAWKJnfWiZwGZ7a13d8v6M8HdaF5KwdPCx2KNaUFDitRQ2cFyRIrYM7mc63f/yQ+EFq8OH3Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVikE3UU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVikE3UU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564681F000FF;
	Mon, 14 Sep 2026 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417683;
	bh=D2oZtJT0wR+1pOa4hSC2okxaLQzRIjR4TKZcHNVGe0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mVikE3UUr5kT/nOexnYujOv7NxUMSBcCZopS8u3Wy1NUuv1/cZBBiO4ZvFUSWYfia
	 i22Ow1X/sr7DMrTVZIc1palaORUUdGgnoHakEJUeNPHg5TeIBiudkBKtDyQjIAFO33
	 aljZqhZ3eErkQDHsuhvk+MGDZbWPQrPx/CcoNFIB7tLe5NEsHIhNHOpXM7x5smEzsM
	 PcEeDW4MEKmGmEwhkk+tHggoaUktXtIZYj4mDaC/u8jJSpPJEg9Xpq4dzIt6jmzdPj
	 izPuVHzV2gVUwY5k9AQJva3JTactevN0gRctJTGic6s7m3RZ8mLsbap23qD1eMQbwL
	 1l3XbnCI7CytA==
Date: Mon, 14 Sep 2026 13:28:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 2/4] perf dwarf-aux: Add die_has_flex_array() helper
Message-ID: <aqhY0oe7fsXRwRgI@google.com>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-3-namhyung@kernel.org>
 <a8320365-6bf9-4db4-b05e-7776a6089a98@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8320365-6bf9-4db4-b05e-7776a6089a98@huaweicloud.com>

Hello,

On Mon, Sep 14, 2026 at 08:14:56PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/9/14 14:45, Namhyung Kim wrote:
> > The die_has_flex_array() returns true when the given type is a compound
> > type and contains an array at the end.  To prevent an infinite recursion
> > add a depth field to the internal function.
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
> > +
> > +	} while (dwarf_siblingof(&die_mem, &die_mem) == 0);
> > +
> > +	if (tag == DW_TAG_structure_type) {
> > +		if (is_flex_array_member(&last_mb))
> 
> Not sure if this case can actually happen, but adding a check for whether
> last_mb is valid is probably better. (I see Sashiko flagged this too.)

Right, will fix in v3.

Thanks for your review!
Namhyung

