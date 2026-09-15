Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0E3B1BD;
	Tue, 15 Sep 2026 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430861; cv=none; b=aRul68skWMNYyK6ttVQ6qdS9GxCkd3tOdqrMd5djHnqHuFxQ3+Yll6PhRPUqFVELzKCBGx5BcYzHy34tjhDtZiB+CCnpyaXEDuw9fDSBQBBfsvIXlyLZSWhf+QB/1vGZacGV5EeW11iz5JuZMRpx6Qyhk71lgfIB705fZix1jI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430861; c=relaxed/simple;
	bh=zBon07gWSak2sgLsYggzuaDg8GFtURaDQBpE1qCRfEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K51GLL0HydttMNoYhbOoQOTPfwsAkFtWNO8SFu7LNxIp0yjjAVkHY0lWAEKhcZ3CSdAfs7T8s1JcYL9tyqlKVwT/zu0WnCcqwJseslbraAjhyq+2wtV1qjo4kjAfSqk2PWPNP/oMqFMg4pnSOzC2zIDtl5VYPxf/XeNNgT15+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNa8LhcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNa8LhcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FD91F000FF;
	Tue, 15 Sep 2026 00:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789430859;
	bh=OAsVoZcbOHJ/l4xfgRdXYIlSlMX4ehglMo7gnuUvxRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SNa8LhcRzsw8HJpUZ4BPj20KIu+8eE5hn4W4XfJ15C8BSG7l8Vx/2AqkgNzxVDUmR
	 0SNaHDGcDbPTqp866ABJcB0uvTyNbte7ENL3DoRw1IeCV3QAvRO/mFfz0AKmFJDDV7
	 0b3eWgyr4xKoE7HTJrk3rM8IBC6IjQf0bVzEKQhOv8CRgCbk23R8t8ZpSQzXar5Ufi
	 sq/lEul8/KIT1fR3c6nXaa8KsgQHSFRedOTNTHYAPWsHJuIWRy+70tFdJFBlFWX72x
	 bSlg3GyJ+RzxCwK6ooHUCom8EDGp3ghVzcET+cRdLLhQKaDYIrdMcwNIZGgJoan6x8
	 juua/LRPZZ+kA==
Date: Mon, 14 Sep 2026 21:07:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Message-ID: <aqiMSGuBkJHjMYei@x2>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
 <20260914224650.52982-5-thomas.falcon@intel.com>
 <20260914225716.667A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914225716.667A11F000FF@smtp.kernel.org>

On Mon, Sep 14, 2026 at 10:57:16PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf c2c: valid memory region overwritten by N/A

All the other are minor stuff that I would fix up myself, but there this
one, can you take a look at it, address the other minor ones and post
v10?

Thanks,

- Arnaldo

> - [Low] perf c2c: missing stdio.h inclusion for asprintf
> --
> 
> commit d7af7398254a585e98330957faf348c7603375be
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> perf tools: Show memory region in perf-c2c subcommand
> 
> Add memory region field to the cacheline list view to help users
> identify the memory region to which the cacheline belongs. The memory
> region field was included with the introduction of support for the
> Off-module Response facility (OMR) in Intel's Diamond Rapids and
> Nova Lake architectures.
> 
> Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
> 
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 715b75d42f2a8..4272f5f22c01f 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -247,6 +248,16 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
> >  	}
> >  }
> >  
> > +static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
> > +				   unsigned int mem_region)
> > +{
> > +	if (WARN_ONCE(mem_region > PERF_MEM_REGION_MEM7,
> > +		      "WARNING: invalid memory region ID\n"))
> > +		return;
> > +
> > +	c2c_he->mem_region = mem_region;
> 
> [Severity: Medium]
> Does this code unconditionally overwrite a previously recorded valid memory
> region with a new value?
> 
> In process_sample_event(), this is called for every sample grouped into the
> cacheline hist_entry:
> 
> process_sample_event()
>   c2c_he__set_mem_region(c2c_he, mem_region);
> 
> If multiple samples hit the same cacheline, could an earlier sample that
> provides valid OMR region data be overwritten by a later standard sample
> (such as an L1 hit) lacking it? This could result in the cacheline's
> memory region being incorrectly displayed as 'N/A' in the perf c2c output.
> 
> [ ... ]
> 
> > @@ -3271,9 +3353,16 @@ static int perf_c2c__report(int argc, const char **argv)
> >  		goto out_mem2node;
> >  	}
> >  
> > -	if (c2c.display != DISPLAY_SNP_PEER)
> > -		output_str = "cl_idx,"
> > +	c2c.show_mem_region = perf_header__has_feat(&session->header,
> > +						HEADER_MEMORY_RANGES);
> > +	if (c2c.show_mem_region)
> > +		dim_dcacheline.header.line[0].span = 3;
> > +
> > +	if (c2c.display != DISPLAY_SNP_PEER) {
> > +		if (asprintf(&output_str,
> > +			     "cl_idx,"
> 
> [Severity: Low]
> Does this file explicitly include <stdio.h> for asprintf?
> 
> Since musl libc enforces strict POSIX header separation and doesn't
> implicitly include headers, omitting <stdio.h> here could lead to build
> failures when compiling perf with a musl libc toolchain.
> 
> >  			     "dcacheline,"
> > +			     "%s"
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260914224650.52982-1-thomas.falcon@intel.com?part=4
