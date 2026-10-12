Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C104DDB33;
	Mon, 12 Oct 2026 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833763; cv=none; b=CqLCST0xquPoautQdwKohrZqOhSMwG+DWtSrrNSBweK03L9CzLkr9ColpWBbxoNWJjbajnt6jI7IzrtU40OOfmdTf4IPnY/nC7IzyLwGi5Stkc0QvM/2nIWD8m+VU+Rpyt+3zm06ZwP7PJJR9rDEel8m7XjiAl5qZEXqW8vhXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833763; c=relaxed/simple;
	bh=cBwFoXJ7fChr8OFj+afkxN5KvUrg1SdkP2YO3nJhOmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHIiSm8lRTh5HQwLMS+VJWusV2x3Xg/FiQ6ulCv8Mo+nZSD2enTVLNKXmKHv/5twg+Bfpq58mFn5vNFMB6X5mcPvPPQuO78zjVt8O7Vs8Rgr0pa7tmfCCHFSAMzSMXlLUp0CBOiGggeNxi0JrEGsxxALqu4kgnUJaD0QxkuVNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOlDsAjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOlDsAjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B891F0089B;
	Mon, 12 Oct 2026 19:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791833761;
	bh=aTbW3/77MISykCtlyKhG4ZHfABQ7Uv/bg13VODAXfwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VOlDsAjUwkXacGb2HAmpFHb43oY5JgoWg965E7b/2OwzwTSVuH0hHLo7dUFpmkwGg
	 it71p0nw4m2GRXakswqpGJklVPITMiQre7t9RQ/BBQV09DiQZTGkjnly9p8plcnM5K
	 9+yf3jPd3o4sCXRnkTGmq1TtGqScRYM2j70Q+xM4nyuLtbU0nbAx7edp6Qs1kz1EdC
	 SaJWfiiqJrjUnZWOERtea29OCzSAdtcqCXdO1QlvlrWp4wwW0K0jSwNWj3cX0lX6yr
	 nrTuTRHxoRvbLsKn6SygYC5kxnOo8Htoah8tTPkWnZmuxyRdzU8CkFC7KmI5eEIC20
	 vmM5uTdnBVVSA==
Date: Mon, 12 Oct 2026 12:36:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf symbol: Set dso symtab type for libbfd
Message-ID: <as02oPr4pZWF4oM7@google.com>
References: <20261012053013.14378-1-namhyung@kernel.org>
 <20261012053013.14378-3-namhyung@kernel.org>
 <sashiko-outbox-167684@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-167684@kernel.org>

On Mon, Oct 12, 2026 at 05:40:08AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf symbol: incomplete dso state initialization for libbfd causing annotate/unwind failure
> --
> 
> commit 5475c2801d673496a1fee31f44ca921eca39f20c
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Set dso symtab type for libbfd
> 
> It missed to set the dso symtab type when the symbols are loaded by
> libbfd.  When it happens both syms_ss and runtime_ss may not be set
> and won't call dso__load_sym().
> 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 4878d4292eb85..a90ce714b174b 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1925,6 +1925,7 @@ int dso__load(struct dso *dso, struct map *map)
> >  			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> >  
> >  		if (bfdrc > 0) {
> > +			dso__set_symtab_type(dso, symtab_type);
> 
> [Severity: Medium]
> When dso__load() takes this early exit to out_destroy, it bypasses the rest
> of the loop which normally initializes symsrc_filename and binary_type:
> 
> 		if (!syms_ss && symsrc__has_symtab(ss)) {
> 			syms_ss = ss;
> 			next_slot = true;
> 			if (!dso__symsrc_filename(dso))
> 				dso__set_symsrc_filename(dso, strdup(name));
> 		}
> ...
> 		if (next_slot) {
> ...
> 			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND || ... )
> 				dso__set_binary_type(dso, symtab_type);
> 
> Does skipping these initializations leave the DSO's binary_type as
> DSO_BINARY_TYPE__NOT_FOUND?
> 
> If so, could this cause perf annotate to fail later on, since
> symbol__disassemble() checks for this exact condition and returns an error?

This is what I'm working on in another patchset.  It'd be totally fine
not to set symsrc_filename and binary_type with that change.

Thanks,
Namhyung

> 
> tools/perf/util/disasm.c:symbol__disassemble()
> ...
> 	if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
> 		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
> 	}
> ...
> 
> >  			ret = 1;
> >  			goto out_destroy;
> >  		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261012053013.14378-1-namhyung@kernel.org?part=3
