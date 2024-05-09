Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584E84FB1;
	Thu,  9 May 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289719; cv=none; b=Iqs52Ci1x+6pmOcqfYTElEscbsjteyFQEDsVZrfhvEV68sYLxyAsoJKEfZSc1gxFrJQtHBPZNQhAaeqREeCk6y6WfRWyekIU6HomCAToJNzrF6EZrdtq/ld4acZ50p7RDO7h6h1922QlmACAK1UvhbXYsfnp7995q0FIJE3QuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289719; c=relaxed/simple;
	bh=8NaOu27Ba2DQElXCBlj4VoleD/3dxECCUoAuTR9sKFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSb9fjg7xfQ9pcZA6zPXPO6N4ptC5lu2LM0eNucyDKjKtQf28UMMshzoAygbGL+PXMAgwDvxcfkSnnK++eBGVtbAXCn/T08o795o7EamDsE9/KoBe9r6q3OxAkzRZQQEDhMWhKIVnFtKtNwLSYgyYNz4J53tG1U85LhASI16aMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu8nQ5Mi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu8nQ5Mi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C9CC116B1;
	Thu,  9 May 2024 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715289718;
	bh=8NaOu27Ba2DQElXCBlj4VoleD/3dxECCUoAuTR9sKFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yu8nQ5MiN7odJjnzNR2c3eKPT6s7qgplI70Ls9HuGzcyRqLCrE+6D4jn1U1IwWDfi
	 o0F+b24A1yNq/pkvfpN8GoUFVNNVplYev8d2dm63z9r+bPUClT7mFKRLhAicfYrgiq
	 UbjlliqVuaj6cVlZQXdNSJJ+UrgUyGvFVe/EPKW0k7OTJLF/Yy0/dv4mmEZ3hpAfCA
	 a+VGUeWxFMepzOlEcAlNw78VOp/5H6TDcZaPtaUiNkRu8sg1w4EZu1flGUZYIkrdji
	 S7sb2rvyGCzBcoXYe2s0Cw2AJ++P0IMqJbWW2OG3G+HibF3RZitMjXQp79OwatN5IS
	 3mdaaMxIq0KHw==
Date: Thu, 9 May 2024 18:21:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	leo.yan@linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf dwarf-aux: Fix build with HAVE_DWARF_CFI_SUPPORT
Message-ID: <Zj0-c7Ac0qHkuLNt@x1>
References: <20240508141458.439017-1-james.clark@arm.com>
 <20240509101136.5b0e0f2bf8df640fc2e65624@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509101136.5b0e0f2bf8df640fc2e65624@kernel.org>

On Thu, May 09, 2024 at 10:11:36AM +0900, Masami Hiramatsu wrote:
> On Wed,  8 May 2024 15:14:57 +0100
> James Clark <james.clark@arm.com> wrote:
> 
> > check_allowed_ops() is used from both HAVE_DWARF_GETLOCATIONS_SUPPORT
> > and HAVE_DWARF_CFI_SUPPORT sections, so move it into the right place so
> > that it's available when either are defined. This shows up when doing
> > a static cross compile for arm64:
> > 
> >   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- LDFLAGS="-static" \
> >     EXTRA_PERFLIBS="-lexpat"
> > 
> >   util/dwarf-aux.c:1723:6: error: implicit declaration of function 'check_allowed_ops'
> > 
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks!

Thanks, applied to perf-tools-next,

- Arnaldo
 
> > Fixes: 55442cc2f22d ("perf dwarf-aux: Check allowed DWARF Ops")
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/util/dwarf-aux.c | 56 ++++++++++++++++++-------------------
> >  1 file changed, 28 insertions(+), 28 deletions(-)
> > 
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index c0a492e65388..c9584563cd56 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -1215,6 +1215,34 @@ static int offset_from_dwarf_op(Dwarf_Op *op)
> >  	}
> >  	return -1;
> >  }
> > +
> > +static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
> > +{
> > +	/* The first op is checked separately */
> > +	ops++;
> > +	nops--;
> > +
> > +	/*
> > +	 * It needs to make sure if the location expression matches to the given
> > +	 * register and offset exactly.  Thus it rejects any complex expressions
> > +	 * and only allows a few of selected operators that doesn't change the
> > +	 * location.
> > +	 */
> > +	while (nops) {
> > +		switch (ops->atom) {
> > +		case DW_OP_stack_value:
> > +		case DW_OP_deref_size:
> > +		case DW_OP_deref:
> > +		case DW_OP_piece:
> > +			break;
> > +		default:
> > +			return false;
> > +		}
> > +		ops++;
> > +		nops--;
> > +	}
> > +	return true;
> > +}
> >  #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT || HAVE_DWARF_CFI_SUPPORT */
> >  
> >  #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
> > @@ -1395,34 +1423,6 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
> >  	return true;
> >  }
> >  
> > -static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
> > -{
> > -	/* The first op is checked separately */
> > -	ops++;
> > -	nops--;
> > -
> > -	/*
> > -	 * It needs to make sure if the location expression matches to the given
> > -	 * register and offset exactly.  Thus it rejects any complex expressions
> > -	 * and only allows a few of selected operators that doesn't change the
> > -	 * location.
> > -	 */
> > -	while (nops) {
> > -		switch (ops->atom) {
> > -		case DW_OP_stack_value:
> > -		case DW_OP_deref_size:
> > -		case DW_OP_deref:
> > -		case DW_OP_piece:
> > -			break;
> > -		default:
> > -			return false;
> > -		}
> > -		ops++;
> > -		nops--;
> > -	}
> > -	return true;
> > -}
> > -
> >  /* Only checks direct child DIEs in the given scope. */
> >  static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
> >  {
> > -- 
> > 2.34.1
> > 
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
