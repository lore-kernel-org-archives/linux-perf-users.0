Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0373346B8;
	Tue, 10 Feb 2026 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757139; cv=none; b=s5vEFWf1+Ua32PftRObS2aCAT6cnP55xdWIiNWp9fxNelhX+AuHhiputkQsO0HAEiPL78j58tppjLI5tIffzDw/W3SLSXaWQ/MPOPhtKLti2FBAkUj4Rj9Br9cU5URd3T5qPbDEUuiC3RoS01MCltYr9Cs6hKB3r2z8XI637HS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757139; c=relaxed/simple;
	bh=zkiIluwdFBgJBVBieVMh0iO/NRT3+xJrUDtKDho8zz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju3qzHXOquG8rkbFEiQua+RfrFd8z4d2BpwvG9UuGF/ReKaPda+YAeF2P9VK/hvwWH7A0aj4bkrV7g22K6sJCs+rRWw/EIaGf0e+5wQXzKOXDDCe3NyPTvzUyfk9eKLtgbiFzi0LYrezFaI6Rqjs3Q+MMbt/PsKA+MhPfBfDgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqy1IBex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqy1IBex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5A8C116C6;
	Tue, 10 Feb 2026 20:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770757138;
	bh=zkiIluwdFBgJBVBieVMh0iO/NRT3+xJrUDtKDho8zz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqy1IBexCME7PY33CnUAxg9gaADI4kZpuYGinSR83P4Ux2voM4g/FolnXbvrpWlje
	 ckGcIIvFzcH9oRaDevb3tzJAkRHRBHWVVYiJbfRyrLufcEZZeUGyeMlshW9uT7YYdp
	 KwrfutQTZ60OhrUngmwL6pn6WBI36QpLo+Qkw3XVQ6+iOb6//ZtHB9FIb5T57MfMBr
	 nRhRqRbB6G6B086UHO8IZM685gDIL7JYbwtQhh1B5HMJMpXNFoMnJ3huCfyIoIpQXn
	 BT0VL5XAfyzVpQ77hqMHZiIAS/157V/8yx/nJXOLFfmJtdWtKWRixNrKiAXe5QVTav
	 Ps8Aiy1jckxWg==
Date: Tue, 10 Feb 2026 17:58:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernel test robot <lkp@intel.com>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v1] perf tests workload: Formatting for code_with_type.rs
Message-ID: <aYucDuJDvxUBj79O@x1>
References: <20260209140533.194251-1-9erthalion6@gmail.com>
 <CANiq72mW=hcvUGt=WENRiYVeVbb2bnYzizE00Eo-MW3b_MwRrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mW=hcvUGt=WENRiYVeVbb2bnYzizE00Eo-MW3b_MwRrg@mail.gmail.com>

On Tue, Feb 10, 2026 at 09:56:36AM +0100, Miguel Ojeda wrote:
> On Mon, Feb 9, 2026 at 3:05 PM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > One part of the rust code for code_with_type workload wasn't properly
> > formatted. Pass it through rustfmt to fix that.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202602091357.oyRv6hgQ-lkp@intel.com/
> > Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> 
> Could this please be applied (or fixed in-place)?

Its merged and pushed out, should be clean now,

- Arnaldo
 
> It is now in next-20260209, and we check this in different CIs. It
> also makes LKP give spurious reports, e.g.:
> 
>   https://lore.kernel.org/all/202602100751.ldfRitCJ-lkp@intel.com/
> 
> Thanks!
> 
> Fixes: 2e05bb52a12d ("perf test workload: Add code_with_type test workload")
> 
> Cc'ing Mark since I think the plan is to check in linux-next.
> 
> Cheers,
> Miguel
