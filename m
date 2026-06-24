Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46979350D74;
	Wed, 24 Jun 2026 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330877; cv=none; b=MqSK04Zt1sbcigOH2QJLc2b4M9IRMrIG8iwiPZkM3qsbSbqOmwMKGLyvdlffEzfxGRhTfUNI7Li1CXw9uIURf5yTLDw6AIkqu0s865o5DSVww6KI80/xTsVYx9QYULUErG0EGU2+VAPKLAtlLuZWsgSyGLL03ENh3QCCKCOsMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330877; c=relaxed/simple;
	bh=rQA2bVRDUoq5updBuj5BPOpEGdkrSd0MTk5fOIC5tcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8aivgLn1P/PKUFn0vRrIVTDi5mUPbP6tKmMtyObm2EQ9CzXPDQ+uCN5qLDCpfKi2cOsg7LqISoHErhfy047Z6PH1TLWtwOtc+1mw8WD8ooCFsD9AkPxFLlZVH+VuOEakQtJmdpWz7eH1S0jAoP1y37ykcymc2Yh1p3A0UchC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKsnhegv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKsnhegv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECDB1F000E9;
	Wed, 24 Jun 2026 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782330875;
	bh=l52T1hPqpsabcP9Ij/Sys/hFGIxfnjOY+cKaKZ5TXVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AKsnhegvjnyfZU3OQbnuysBi+koDN1Nuq2c5zlD8zb1C4FFnWvvzv49edfKlMGKv7
	 yuVNxf3Qc0/ooNYqKP02LVJk5GlG7pMmRigXXXtj/C8pe6GbQqp13BCl2c15bOs+hb
	 lBQdhoeSvm6R1Yk8S2/yM9KqHDEh3ObCp8tH7F+cODGaCbRggItVaJS6qu2jgTjoR5
	 kIhhLxsPaDds8zsp8pbIXKx4JtKx0FTinyjgooUoJb5ELwIudmzHxPE/oQb7geQydn
	 9aPN86mA981Itj7JAdeauCzsKH3pFXfrWpFLr4nepA+CFHiElJTs2REuUuDctDBCNI
	 LdxiRMBojd/EA==
Date: Wed, 24 Jun 2026 12:54:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: sashiko@lists.linux.dev, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf dso: Fix kallsyms DSO detection with fallback
 logic
Message-ID: <ajw1-ivLfQo3psZa@google.com>
References: <20260416091657.578429-2-tshah@linux.ibm.com>
 <20260416110905.3A68AC2BCAF@smtp.kernel.org>
 <714f2022-879e-4f6a-9b1c-cce06be6db65@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <714f2022-879e-4f6a-9b1c-cce06be6db65@linux.ibm.com>

On Thu, Jun 11, 2026 at 06:04:23PM +0530, Tanushree Shah wrote:
> 
> 
> On 16/04/26 16:39, sashiko-bot@kernel.org wrote:
> > Sashiko AI review found 2 potential issue(s):
> > - [High] Path Traversal and Information Disclosure due to `strncmp` matching any prefix.
> > - [Medium] Incomplete fix: Fallback logic is missing from `dso__is_kcore()` and `dso__is_vmlinux()`.
> > --
> > 
> > commit 9ee80283f13c6a0a5235a2add7a94736c1dfcbba
> > Author: Tanushree Shah <tshah@linux.ibm.com>
> > 
> > perf dso: Fix kallsyms DSO detection with fallback logic
> > 
> > This commit fixes an issue where kallsyms DSOs are not correctly identified
> > during build-id injection because the dso_binary_type is not yet set. It
> > adds a fallback string matching check against the DSO's long_name.
> > 
> > > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > > index ede691e9a2495..515ab6e95b0e4 100644
> > > --- a/tools/perf/util/dso.h
> > > +++ b/tools/perf/util/dso.h
> > 
> > [ ... ]
> > 
> > > @@ -915,6 +917,14 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
> > >   {
> > >   	enum dso_binary_type bt = dso__binary_type(dso);
> > > +	if (bt == DSO_BINARY_TYPE__NOT_FOUND) {
> > 
> > Since the fallback logic was added here because dso_binary_type(dso) is
> > DSO_BINARY_TYPE__NOT_FOUND during perf record and inject, do dso__is_kcore()
> > and dso__is_vmlinux() require a similar fallback?
> > 
> > Looking at dso__cache_build_id(), it relies on dso__is_kcore() to flag the
> > DSO for special caching logic. If dso__is_kcore() returns false during
> > build-id caching, kcore DSOs are treated as regular files, which causes
> > nsinfo__realpath() to fail and breaks perf archive for kcore sessions.
> > 
> > > +		return RC_CHK_ACCESS(dso)->kernel &&
> > > +			((strncmp(RC_CHK_ACCESS(dso)->long_name, DSO__NAME_KALLSYMS,
> > > +				strlen(DSO__NAME_KALLSYMS)) == 0) ||
> > 
> > Does using strncmp() here allow a path traversal if long_name is
> > intentionally crafted?
> > 
> > If a malicious perf.data file contains an MMAP event with a filename like
> > "[kernel.kallsyms]/../../../../tmp/leak", this prefix check evaluates
> > to true.
> > 
> > Could this allow build_id_cache__cachedir() to construct a cache directory
> > using this malicious path, causing build_id_cache__add() to unconditionally
> > copy the host's /proc/kallsyms into an attacker-controlled directory?
> 
> Hello,
> The current code relies on dso_binary_type to check if its a kallsyms dso.
> While running perf archive, the code calls dso__is_kallsyms check to create
> a build-id dir. But till that time, dso_binary_type is not getting set yet.
> Hence, this patch introduced usage of dso->long_name to check if it is
> kallsyms. But based on the above review from Sashiko, it seems that this may
> create a security concern.
> 
> I tried to check for the possibility to set the dso binary type before
> dso__is_kallsyms gets called. But, I found that dso binary type is getting
> set based on dso__is_kallsyms only.
> 
> So, I am looking for suggestions/approach that we can take here.

Can we simply check with strcmp() for the whole string?

Thanks,
Namhyung

