Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2872D838E;
	Sat, 10 Oct 2026 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614467; cv=none; b=MB55s9dfVwbw7AaCcMKP84itt1JRIMACLIBUmeyCY9qjvbD8eHjEojwGQntoGoYt8YzLew5Oq9wm9ozHomWThznv6Lgd2fkdJoKNrj8wN2Tp4LkbCup8lTU3HwKaO0r5ov2LIxWT5eZwndLI9w2jjkAbXmGNNsy8VevxxvkzW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614467; c=relaxed/simple;
	bh=9dTbTQ7B9z7wcqJ2Y4hk2OLEFF9Kdb3PBg36sCW8qvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbSXm1bINFzZuNoadDHM7uDZZGNlN1kk/n5bMOl/AY3prtemmjaVdU9TR3H25qVAttv+f90hZ5zZI+hPhUlcDQt7aSjyzcGrI90+/uvty2EemtkCCjHVoLfqk36iQiZ/cokcpyw8b+D5LITBBVzJ2gRHc6n2OQzKUrc3tAmlzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmSqIuB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmSqIuB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D397F1F000FF;
	Sat, 10 Oct 2026 06:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791614466;
	bh=+xVO9ua1ArWLHW8m/vz8BxYWetuMi3Kkcc9WO8z3bRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JmSqIuB+8bbziGCIJFRjoi0Dtm4n601xaosAtkDyIJ98YQre9IfuWpWNhE0yb3aMN
	 O0ThyVilqdj2FRDUHxparTEQBXKe5VZHMJlL58MoWRzc+j2LOaQWB6b/UjRnSx2ePF
	 3upLd3Pv93rdZYt2HezHKmuzBrDhK/9D91gCxS61V6mtO14jJrAffTcXmeLKy2bNtf
	 CuFxikpoGZfNKtded8Il95KOnrdL+OuAHbQX1zhWn/irsD6evL3K3unAM9agQeFYN0
	 ErGn0E1mF8StLsS49p1LtFLsc/+ystpC4g5BrW3K/SM+zGx0ogH13sg8EWaLWMWCM/
	 oU4C3BYrR4j7g==
Date: Fri, 9 Oct 2026 23:41:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 08/10] perf symbol: Do not set binary type from symtab
 type
Message-ID: <asneAEt9S1ZJaeR5@z2>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-9-namhyung@kernel.org>
 <sashiko-outbox-162539@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-162539@kernel.org>

On Tue, Oct 06, 2026 at 11:57:13PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] perf: data-only DSOs fail to open due to strict .text section requirement
> - [High] perf: compat offline DWARF unwinding broken due to missing binary_type
> - [Medium] perf: redundant double-decompression of compressed kernel modules
> --
> 
> commit 0528580a893b2b2066f28586347977aa4bf1e268
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Do not set binary type from symtab type
> 
> The DSO binary type is to access the binary (e.g. instruction) data
> while symtab type is for the symbol table.  They may or may not be in
> the same file.  We should track them separately and correctly.
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
[SNIP]
> [Severity: High]
> Could this removal also break offline DWARF stack unwinding for compat tasks?
> 
> Because user-space maps now have a binary type of DSO_BINARY_TYPE__NOT_FOUND
> during early processing, when thread__e_machine_endian() calls
> dso__e_machine_endian() to determine the architecture, it hits the fallback:
> 
> tools/perf/util/dso.c:dso__e_machine_endian() {
>     ...
>     switch (dso__binary_type(dso)) {
>     ...
>     case DSO_BINARY_TYPE__NOT_FOUND:
>     default:
>         if (e_flags)
>             *e_flags = 0;
>         return EM_NONE;
>     }
> }
> 
> It immediately fails and returns EM_NONE without attempting to open the file.
> Consequently, thread__e_machine_endian() fails to extract the architecture
> from any map and falls back to perf_env__e_machine(), which incorrectly
> applies the host architecture to the compat thread.

Looks possible.  I'll add dso__find_binary_type() before.

But probably we can cache e_machine and e_flags in the DSO when loading
symbols.

Thanks,
Namhyung

