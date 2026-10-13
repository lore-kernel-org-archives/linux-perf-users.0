Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BE4ACC94;
	Tue, 13 Oct 2026 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872343; cv=none; b=Wg5wMwKF7U8Ms5GGUn5/3fg5Sg4MwWRtgwORK5ErL+k783MHY6kbLn9vzGf0mwMF0U2S6Xp4Rw+uL1p8G72WiGQEVkWwlyZNkDQQ5+CqkSs3PwnequTJ7qtsijb5c+sr5ndnxstsLjVMpfHeHpFnDVlTrIdHTN9r01e8ehh1K2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872343; c=relaxed/simple;
	bh=HtJBiEA4ucAvLpfC4a4n1A6tMLh+eQMfiLiFLLNUD5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7FunKyUMtTLsAAliJOaVPSCrDgF2GAGfE35Fp5/REUQG+JL6XQ1YcUXJuS0pdEx0TnJaCMmuwUhXkG6PWr9xjm69YqWYppJuvCr7F164P9wjAgoOY2KNCecLXNLq2NeulGQOw36RpyhB7hjPdo0LWtLR6N9RSYzu0vMpZYH4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aycQ4xCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aycQ4xCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FED1F000FF;
	Tue, 13 Oct 2026 06:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791872341;
	bh=F7ejl3Qk2kHBe5/UeSkwIn+slHSDKD72lOz9G5tCbZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aycQ4xCHkXgaaAy2pUxsJMWciAGHoV2hAGFQUfdrXP4yjjEuaIy/xS9oqFhL4kkjK
	 FmDWjH69CgBifEcuJ5ciCZVGCcC1MIo8KlbnELuwUBlquQeB+1fBKWk2gwkYuFluiH
	 5Dn2myW9bRnHRrUaBmDeSLK8m8QMZBXqUYIxI3dilwdDPSxb4BkTJxJkL1aTv5gP6+
	 zDi5Q+ww3Q1raR+03p4aXNNeomiBrLvJflkHI+jMQJXjSDcsVZQ1UHNvrvqoA4ZdRc
	 agD1Bv1VHftc5hv7a59EGdnl9TqVKoMkkO3+KY9NcuiKoq5Nsw858F0GCmfqrgL+m5
	 0/FAj7hfQMnYg==
Date: Mon, 12 Oct 2026 23:18:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 08/10] perf symbol: Do not set binary type from symtab
 type
Message-ID: <as3NUyJxJvIyFC50@z2>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-9-namhyung@kernel.org>
 <sashiko-outbox-168778@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-168778@kernel.org>

On Tue, Oct 13, 2026 at 12:08:12AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: fully stripped executables falsely rejected for data access
> --
> 
> commit 6b9e46855d4e0d8df1dcaaed600da2f693471adb
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Do not set binary type from symtab type
> 
> This commit separates tracking of the DSO binary type from the symtab type.
> It removes the explicit setting of the binary type during symbol loading,
> deferring it until the DSO is actually opened.
> 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 4a8c298039447..116870595f75c 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1943,19 +1943,6 @@ int dso__load(struct dso *dso, struct map *map)
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
> Will removing this explicit assignment cause fully stripped executables to be
> falsely rejected during data access operations like perf annotate?
> 
> By leaving the DSO binary type as NOT_FOUND here, disassembly paths are forced
> to fall back to dso__find_binary_type_locked() to identify the file type.
> That logic attempts to verify the file using filename__has_section() for the
> .text section:
> 
> tools/perf/util/dso.c:dso__find_binary_type_locked() {
>     ...
>     found = filename__has_section(path, ".text");
>     ...
> }
> 
> For stripped executables (which have had their section headers removed but
> still have valid PT_LOAD segments), this check returns false. Previously,
> because dso__load() set the binary type directly when locating the system
> path DSO, it bypassed the strict .text check.
> 
> Consequently, tools like objdump that can parse PT_LOAD segments are never
> invoked, and operations fail with COULDNT_DETERMINE_FILE_TYPE.

Hmm.. ok.  But I don't think this is a common case and we have many
places to check section headers.  So practically we require section
headers to support it.

> 
> Additionally, could this cause debuginfo files to be incorrectly selected for
> data reads, since their SHT_NOBITS .text sections might falsely satisfy the
> check?

The function never tries such debuginfo file types.  But probably better
to chek section types.

Thanks,
Namhyung

