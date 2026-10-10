Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD5204C31;
	Sat, 10 Oct 2026 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791611345; cv=none; b=te7+w8pb3lDq+s5YWcKZLqK2VYiIWYu310F338oBjQRFCDHnVNDrw3vylFejtOB3w1IHqgdY/T/Gzw2GA74UxQ/DvdhFGRbHUPSm2aBY7RibopwZCcIZyLUcBYH8hniboGsCctc8pqHRqKHSVaaOF3gAjiA1dVdeF07wvGQTF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791611345; c=relaxed/simple;
	bh=BePRHxtOlE8Eauis2jA2kluMjih1rzRDCRXNBiI+a2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clxEUP6mzhQuyKFC6CqtfrD+T/QbEOtv3QEErjjmD5yLT08yeAHx5IJzXLHNKmJhcB8Q9/O/j7TjFxDb8VT4jzy+5TXc8Aev2un3GUpyG8wIbmp4sXmKc2HF5UBvjM7hgrjacxq1XrZkl6pfXd8f8CYW6ldkV4zltsTTgDBEZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC7yQ8vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC7yQ8vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6C21F000FF;
	Sat, 10 Oct 2026 05:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791611344;
	bh=VOqIGtiMJlr5ZaL4pzuL9dPER6p5rTr/hUVOs5rDfCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XC7yQ8vqYXx5TqjGn1IzOaVhZr300ijzuvYH1VMaKmL288//jPstoKfRCtwePkoBF
	 Z/X9rQOEQPH0NyTDNPLMMzn5wKN7EgpXrP0vf4p2PHQETpC0H47bPjIMyadB6jZ4W0
	 95ZQ3aS89fOeOPMxpxO1DBQ+QqItiX6gZEl85J9sZm65XRvYuPM8K3Q2ckZrdpc/dY
	 UHHGPFQMWoZ5SHTwunbtLNDMkRch1NE7nJktbrcNyAj3VshuN0F9w9zeRGWTCNByvt
	 NRIQTuUMoj+fk8Gk07f00hECp6x66CRMA3Ek3gQzSDqInsBEGbKXZ43BiifVH5DwaL
	 oAMco8OaZ/v5A==
Date: Fri, 9 Oct 2026 22:49:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 05/10] perf symbol: Set dso symtab type for libbfd
Message-ID: <asnRznNZsETU-_Xg@z2>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-6-namhyung@kernel.org>
 <sashiko-outbox-162540@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-162540@kernel.org>

On Tue, Oct 06, 2026 at 11:57:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] perf: dso__load() returns 0 on libbfd success causing map__load() to discard first sample
> - [Low] perf: unintended fallthrough to dso__load_sym clobbers libbfd symtab type
> --
> 
> commit c31089cce4c931915ffad7363dd2a84096e2a4cf
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Set dso symtab type for libbfd
> 
> It missed to set the dso symtab type when the symbols are loaded by
> libbfd.  When it happens both syms_ss and runtime_ss may not be set
> and won't call dso__load_sym().
> 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index fc6e4dff282bc..02b096ccbc60a 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1933,6 +1933,7 @@ int dso__load(struct dso *dso, struct map *map)
> >  			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> >  
> >  		if (bfdrc == 0) {
> > +			dso__set_symtab_type(dso, symtab_type);
> >  			ret = 0;
> 
> [Severity: High]
> Does returning 0 here cause map__load() to discard the first sample?
> 
> Unlike dso__load_sym(), which returns the number of loaded symbols (> 0),
> leaving ret = 0 causes dso__load() to return 0. The caller map__load()
> strictly checks "if (nr == 0)" and treats it as a failure:
> 
> tools/perf/util/map.c:map__load() {
>     ...
> 	} else if (nr == 0) {
>     ...
> 		return -1;
> 	}
> 
> Because dso__load() correctly calls dso__set_loaded(dso) before returning,
> subsequent calls to map__load() hit the early success path and return 0.
> As a result, does the very first symbol lookup for a libbfd-loaded map
> spuriously fail and cause perf to discard the sample?

This is a pre-existing bug.  And I think it should return a positive
number for success.

> 
> >  			break;
> 
> [Severity: Low]
> Does breaking out of the loop here unintentionally clobber the libbfd symtab
> type if syms_ss was already set?
> 
> If a prior loop iteration populates syms_ss (e.g., from an ELF file) and a
> subsequent iteration successfully loads libbfd symbols (bfdrc == 0), the
> loop breaks here to return the libbfd symbols.
> 
> However, since syms_ss is non-NULL from the prior iteration, the post-loop
> cleanup bypass fails:
> 
> tools/perf/util/symbol.c:dso__load() {
>     ...
> 	if (!runtime_ss && !syms_ss)
> 		goto out_free;
>     ...
> 	if (syms_ss)
> 		ret = dso__load_sym(dso, map, syms_ss, runtime_ss, kmod);
>     ...
> }
> 
> Because execution falls through to dso__load_sym(), does it unconditionally
> call dso__set_symtab_type(dso, syms_ss->type) and silently overwrite the
> newly added symtab_type, mixing the symbols?

Correct, but this is also a separate issue.

Thanks,
Namhyung

