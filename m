Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6138E5C5;
	Tue,  6 Oct 2026 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791268209; cv=none; b=gKel8KNWXjQhWjtxm5UCHSQkLX4A2g71+351ZC3sPh6gD5TCJYCAvbAFcXQD46conhKhaWmXtjXOeMtP/d9FZ+JZHdQGfjN7tRauLBZ+a5lb5F5cLt9V9hF27jYtaDHUFx6VGpXaCZc7TdHaAIF9JX6SJjtD9aWPYo/ewnulWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791268209; c=relaxed/simple;
	bh=jwoPCb40PHRjB/JbJDM7pzjd/aYTPrhh2U1KaE1sdEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbALZapqkvmuu+tBFaJ4WdQxroQCFH1xQtLAjqxhz3MRESkhUHu7Q7z8I+XJBL1G5EAG7rmwSNNTuBdxmbcMLqvpyXFIopBpnJ2/aHAy5SMBWOoR3mRLkv0AZu2qBAp8YdUL43ld0dYbS7nFMeFVdu1oOiDbCwen/Z/WxJ+cows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exP2GS07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exP2GS07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3511F000FF;
	Tue,  6 Oct 2026 06:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791268207;
	bh=9SraNlCgmlqkdCqyVFjtIVtViqosZwFtFJeb5UcyfSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=exP2GS07AMyytr3rA+1b2DaGYjWhO9cDoFjwJg3i5TaTmz4zLNTCMRISYpZ7WlT9T
	 M8kOID0iqH4KOzqoK+sUQ0RojrDD3e/5CBAAsAo3wPZOko9Sg8oNNlFkg5mGDTO+Zf
	 iewaAL6NKu01kpQcjHe2EVu/gYS9uXIPhI+upt0mP64Lt4cxDXjmJNE63du9hO56nq
	 ZP5RgdzMYRFiKDXuLwk2EB7XicUXmmDf4e/1ecXe2hy6UmyinBGZ3i1ZEgPQU/k1NL
	 CaofzlL7ErYCF0oZiF8U1vqIEOoxiAet/zy5kDrwOV27Pm4xWwO+AQDwNUzy+vIv+7
	 CRiHrUqb0u/Tw==
Date: Mon, 5 Oct 2026 23:30:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 7/7] perf symbol: Do not set binary type from symtab
 type
Message-ID: <asSVbjUvlehbLUwT@z2>
References: <20261005063411.114244-1-namhyung@kernel.org>
 <20261005063411.114244-8-namhyung@kernel.org>
 <20261005064531.2BD9B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005064531.2BD9B1F000FF@smtp.kernel.org>

On Mon, Oct 05, 2026 at 06:45:30AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: `perf annotate` and guest module data read broken by missing `binary_type`
> --
> 
> commit 7196d300589913af007226f7522345f0d46a1af3
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Do not set binary type from symtab type
> 
> The commit separates DSO binary type from symtab type and removes the
> logic that sets the binary type from the symtab type in dso__load.
> 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 389dbd7e5192f..1175cb60f8206 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1956,19 +1956,6 @@ int dso__load(struct dso *dso, struct map *map)
> >  
> >  		if (next_slot) {
> >  			ss_pos++;
> > -
> > -			/*
> > -			 * The binary type is used to find the file containing
> > -			 * the executed instructions, so prefer the types that
> > -			 * refer to the actual object over debug-only files such
> > -			 * as DSO_BINARY_TYPE__DEBUGLINK.
> > -			 */
> > -			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND ||
> > -			    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
> > -			    (symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
> > -			     dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE))
> > -				dso__set_binary_type(dso, symtab_type);
> > -
> 
> [Severity: Medium]
> Will this removal cause perf annotate and guest module data reads to fail?

I'm not sure if perf annotate would work well for guest modules.

> 
> Without this logic, binary_type defaults to DSO_BINARY_TYPE__NOT_FOUND
> for generic DSOs, guest kernel modules, or binaries using debuginfo/system
> paths. 
> 
> When tools/perf/util/dso.c:try_to_open_dso() is later called to read data,
> it only iterates over BUILD_ID_CACHE and SYSTEM_PATH_DSO when the binary
> type is NOT_FOUND, completely ignoring guest-specific paths that require
> machine->root_dir:
> 
>     enum dso_binary_type binary_type_data[] = {
>         DSO_BINARY_TYPE__BUILD_ID_CACHE,
>         DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
>         DSO_BINARY_TYPE__NOT_FOUND,
>     };

I believe guest modules always need machine->root_dir to access the
file.  It won't get the correct file contents without it so the current
code didn't work well.

> 
> Additionally, tools/perf/util/disasm.c:symbol__disassemble() explicitly
> returns an error if binary_type remains unset:
> 
>     if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
>         return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
>     }
> 
> Does this unintentionally break disassembly for binaries not in the
> build-id cache, or binary data reads for guest kernel modules?

As I said in other reply, it should be updated to use binary type of the
dso.  I'll update the code in v2.

Thanks,
Namhyung

