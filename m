Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F636654C;
	Mon, 12 Oct 2026 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846455; cv=none; b=Y4K6koTIJraoyOd55V3EtdCgEL7m4vKNfXBp0UTGuyamUiEm6JrkllNLcHAYop+8Rp0jkhVEEaULZCl1NV3wXxVIPi3yefbZDUeYvx6vt9R7vAlR4Ge06rNjDbhZPC/wiIgyZzHrgSPrWbxOzMub0jvZepmJCBXovlOaCP2heOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846455; c=relaxed/simple;
	bh=H41z7BmKixqDzEnvklSzCpluKC/WvXmxm8SAeIsZHMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSCJSHbmqmDEmENWqtw9E3bbfdvE3V6H3A6BQ2QBrB79iaiktKD0tjwQFSX04SHaQHOyB4Cx4gOwmQzw4hBgs0qRUMsFu+l7ruxalqNcOt4OBfeOkWZpgT0kpVv65P35jCxJefFVPsOeCa9OLk+OrrSLEOLI47ZYdQ0ASoICP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUCFuJRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUCFuJRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340961F0089B;
	Mon, 12 Oct 2026 23:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846454;
	bh=wJS2B9GgJJFuT3P2fJjeuAuAmR13t3MU4e+AN/L0jsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dUCFuJRq4WkIlkPpPWlSV30M+wTqMtpP/JS5y9nP45+Gn+tLoaWtpvQEzZ2eb4BWv
	 XTLhv+MmS9vUHljkY4sS1aUN5k3zcUsd/3HZmmGwFvusvfzd9kjvb8JxNq1Rn+8kmT
	 G/4hx/QFa361WsNaB7OUkY0q18ZKwAnqmKfdNXtKkp2ea4mM55JCDQACD91taVlH+9
	 SBSTsb7+9V3x4AcVT3YYztmuQy4+2rkbCnDLN9kTl/sfZfUnWd1KJCMge9dns+yPBx
	 9iVaKTDi3WH3/fEdd9wmvtuRE0j30YeawnxDSzLfPo5L6NGm7Jsh0lHzhit1mSC8tM
	 SwHPL9afbnYog==
Date: Mon, 12 Oct 2026 16:07:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 00/10] perf symbol: Properly set DSO binary/symtab
 types
Message-ID: <as1oNTq4Fqv_wgag@google.com>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <CAP-5=fXg3LYS0ftt1WjDXgEh6DLjZcYQiVNv=ym7CAA9PyiQ1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXg3LYS0ftt1WjDXgEh6DLjZcYQiVNv=ym7CAA9PyiQ1A@mail.gmail.com>

On Mon, Oct 12, 2026 at 02:41:27PM -0700, Ian Rogers wrote:
> On Sun, Oct 11, 2026 at 10:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > Currently we have 3 types for a DSO.
> >
> > * binary type: determines where to read binary instruction or data of the
> >   DSO.  Basically used by annotate.  Some (special) DSOs like kallsyms or
> >   JIT may not have the data though.
> >
> > * symtab type: determines where to read symbol tables.  Set when symbols
> >   in the DSO are loaded.
> >
> > * debug info type: determines where to read debug info.  Used by srcline,
> >   DWARF unwinding, data type profiling and so on.  Often debug info is
> >   saved in a separate file.
> >
> > Some DSOs may have the same type for 3 and others can have all different.
> > Previously it generally assumed binary type would be same as symtab type
> > but now I think we should not and only set the binary type as it's used.
> >
> > Also it should make sure that symtab type is set properly after loading
> > symbols in the DSO.
> >
> > Probably this patchset won't make any practical difference in runtime
> > behaviors but I think it's good to track them accurately.
> 
> Except for nits and resolving the remaining Sashiko feedback on patch 6.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for your review!

I'll sent v4 with the fixes soon.

Thanks,
Namhyung

