Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D35189F43;
	Fri, 14 Aug 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709478; cv=none; b=tvCkWfvTyjDrE68Js0m98j+11YsMY+LO3ZKZyM+wOyqNyBcpI8FZ5s2TVAUe08UGwDqb+i2zGofFmqR8XGBDgZNT0gEtSctN4f001NxOFkJhAhapQMZZ6EzMcMfxGL0nBiGDDfz3r1qqNmYZsOPKgZrwP3Jxk7yd1if0YdBFzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709478; c=relaxed/simple;
	bh=IWRoJSLUEPBktAZ/07HWHkgHPvPq/g9+OYqlbDWBM2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FagN91EmchoJcqoIdZeYubDeLjsGJ3gM/A6t9hGNBjTThf10JxIh8Vn1KhPXQ/zYPDZG+C/72KZcn3ftk5qL8Lq+tCQTaFof8IpXnaAYMGT0neaU1WdJ1+deYEXBCanL38UqYGxYw8ZR2aphXeqXs6lcdnyp5dOqUGnl1LGPLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB8XwA56; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB8XwA56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AC51F000E9;
	Fri, 14 Aug 2026 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786709476;
	bh=+5JMaI4Bp88BI8bpuC2m+oIIwe/RBefFNu8OCzC+8+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oB8XwA563i7ta70vaP+kVSIkXXKEb44r2rMtFwN1UbH9LaJt5GCGi0Fc576UvMaaQ
	 iqD/h9mwR7BlvoWmM9xzNDAklUxfml6tWzVzxFL0lBZC8rR46a7f2gsGjGN83thTDp
	 ZFHXBBQOB6MxPJFkzx1tsyvs59TcqvXTjhTA7kjSQU4qRLuY695FnPsFnnm5SiWE6W
	 P9wl4tz3325k7NlMixDAQsNPkV7JmzBDMcLkW/RR6U81mb5n9y5KiM06yZZcVpJqFj
	 LVNc+AGFYqDVu/H4Ci75vDYBV7Ytv5/dag3Mfg0hHuxCwgCc7kk9w29HTOKpmMUeMd
	 pyKS79ySxhy+Q==
Date: Fri, 14 Aug 2026 09:11:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/5] perf dso: Replace assert with runtime check in
 dso__read_symbol()
Message-ID: <an8F4aeumUKOJN8x@x1>
References: <20260813151148.23169-1-acme@kernel.org>
 <20260813151148.23169-6-acme@kernel.org>
 <20260813152630.0D6E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813152630.0D6E71F000E9@smtp.kernel.org>

On Thu, Aug 13, 2026 at 03:26:29PM +0000, sashiko-bot@kernel.org wrote:
> > +++ b/tools/perf/util/dso.c
> > @@ -2038,7 +2038,12 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
> >  			errno = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> >  			return NULL;
> >  		}
> > -		assert(len <= info_linear->info.jited_prog_len);
> > +		if (len > info_linear->info.jited_prog_len) {
> > +			pr_debug("BPF symbol length %zu exceeds jited_prog_len %u\n",
> > +				 len, info_linear->info.jited_prog_len);
> > +			errno = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
 
> [Severity: Medium]
> Since this is a bounds check failure in dso__read_symbol() triggered by a
> corrupted perf.data file, reusing SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF might
> cause tools to incorrectly report that the BPF file is missing its BTF section
> instead of indicating a length mismatch.
 
> Could this regression result in a confusing message for the user?

Some other cases near here are returning this error as well, we need to
add more errors and update the associated symbol__strerror_disassemble
to print the more precise error messages, probably
SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_BTF.

I will add this to a TODO file for a new patch series improving this
situation.

- Arnaldo
