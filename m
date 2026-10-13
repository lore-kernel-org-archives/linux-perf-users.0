Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C948FF8E;
	Tue, 13 Oct 2026 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871925; cv=none; b=Hy3bf7XiXBOzhwpCAdwGgNuowWZ2O82l8BqjWW+yWMz1JdD3dG1SDC6bANYxFJeBLSK92lPpuGLRi33Zet8hkLU+vWZlID5Y/bCZDm/lAw3Y1HYguRZfewv8jPJeej2Kn6JSLD6nzbOx/zsiS/LNKKB+LamvJizfQ36GAwmBXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871925; c=relaxed/simple;
	bh=b6MvNpFXEObBiq5CA+Gf1P0Jl1RL8SJBVRArPNr8Fl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOfdNquKorM28uy9SCS6lW4wkRrDYzl3xNn5xcCCpJ7pqkw1pEP/vKCD+j3h1RvBIwzDFdOkEcm2aa08yfIzeaJtUg4E9jNtXnpO3JXxIGJauBn0Vh2vBB1kppvCz2MBWsaktR0dA3GHwe6KnE8BXAm9bJ3Vs0dhT2WmxKBHqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCpWK1SX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCpWK1SX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7731F000FF;
	Tue, 13 Oct 2026 06:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791871917;
	bh=VVvB9PbNSwKcmJ/R/qjFJVO/hR+RbVDtIyccYc+dWR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCpWK1SXzJCmxkjppYqz9Ut9KdZ1B8F1iIVVol7iqNscStZCvF6Aj6rMSYdPMspGs
	 qMGDJDQqujZTRTmAaLO+22RdH99MsaqdncPo5k9fVlRzsJUjueIoJ94DjSTauZ2DSZ
	 0JCz+/D3Upn/Q51o5uk3wFWITB9VoMDZw6NPgGoeR3TCRXUn3lkZiVoUkzckmnuj9h
	 i79cxnzx9AdIu5Bs6IzEdIi1XQue7cVB7rhdyaz2kiehM/uuNDIREhBUYIB/4SU+D+
	 kjVS1hq9j5nvgTOa/qdGAUq/PqSO6yp+oazIlKLMR9pkXgt+MfWZBtCe7ykm7f5Yjt
	 fU3ujUgRn0C2Q==
Date: Mon, 12 Oct 2026 23:11:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 06/10] perf tools: Factor out dso__find_binary_type()
Message-ID: <as3LrGychTiScvBE@z2>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-7-namhyung@kernel.org>
 <sashiko-outbox-168759@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-168759@kernel.org>

On Mon, Oct 12, 2026 at 11:58:48PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: spurious FD-eviction and DSO failure due to uninitialized errno
> --
> 
> commit 00af7deeab2857b031fe6b82dcee452b2fe4afb8
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf tools: Factor out dso__find_binary_type()
> 
> This commit separates out the logic to detect the binary type of a DSO by
> checking if the candidate file contains a .text section. It ignores
> data-only DSOs and adds handling to retry with the DSO data open lock if the
> search fails due to hitting the open file limit.
> 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 913877b84b2d4..c42ad0c5c66a7 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> [ ... ]
> > +	do {
> > +		dso__set_binary_type(dso, binary_type_data[i++]);
> >  
> > -		dso_data->fd = open_dso(dso, machine);
> > -		if (dso_data->fd >= 0)
> > -			goto out;
> > +		path = dso__get_filename(dso, "", &decomp, dso__binary_type(dso));
> > +		if (path == NULL) {
> > +			if (errno == EMFILE)
> > +				goto open_err;
> 
> [Severity: Medium]
> Could this lead to spurious FD evictions and failure to find the binary type
> if errno is already EMFILE from a prior, unrelated operation?
> 
> If dso__get_filename() returns NULL for a normal reason (such as a missing
> build-id cache) without touching errno, it appears a stale EMFILE would cause
> an early abort to the open_err label.
> 
> Since the caller __dso__find_binary_type() evicts a DSO and retries up to 3
> times, and errno would remain EMFILE across those retries, it seems this might
> permanently mark the DSO binary type as NOT_FOUND.
> 
> Would it make sense to clear errno before calling dso__get_filename()?

Ok, I'll add that too.

Thanks,
Namhyung

> 
> > +			continue;
> > +		}
> > +
> > +		errno = 0;
> > +		found = filename__has_section(path, ".text");
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261012234654.60666-1-namhyung@kernel.org?part=6
