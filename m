Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB224C98;
	Sat,  1 Mar 2025 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788442; cv=none; b=rVyMrCN7VXOxr3c0FeLmisQJqUilihm4Oliy6kg8W3iqwCkyn7trCELWpXGGFnl6KgKSwhgYi3sIVBtOz5wImskn9E/yf+xQEJ5gBnIrrtNJV9V6Voceh5Vgecf3U67N8ljxFDFyNc0zgKJEZ/myYAEsE+DGhOYxQoEeaQPJkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788442; c=relaxed/simple;
	bh=KiD7RunlUVt0MKCXSK3YEiHcDKUWIMvyIfV1XKCBRw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fny6Dw7HZpVo++ZcQZVOt6ZgQ5YCbC08/YfBAveEulfMsbdmC+WTm2dVT9tty+Sr+ah3p5+oS/cPagQtKpm1GJ/1MTMPXYlbzfCBLsVg+LhE2TYBHgAIcpQ/8slhICB2DeZxRqgVqdYVAq1qES0yp1sNuMbzqN2O1a2xX+zJZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt+bFeMt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt+bFeMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932AFC4CED6;
	Sat,  1 Mar 2025 00:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740788442;
	bh=KiD7RunlUVt0MKCXSK3YEiHcDKUWIMvyIfV1XKCBRw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zt+bFeMt5mslDlbmpCIEOyBj3iHYUrN01yrhsxl0ZKZzKG5JyepdEKZlYEIQMBvpt
	 nf6leOGUiZ9+FSKS9v9FKfp46RcOEDN/81/1V1isHu+Es/v023dFnl+lr9ge1vey1l
	 HH3YIF3y5Hrknnm+OLY8E/dz2olsPnWSoolS6/4RiaobCeSinWC++s8IHCYCZZKdeg
	 8cew16nKq6ooCOMrji29xJOpy7etpwp8VOcdLkuBUfPfpvTOyIGjD9eqpJ2s88Z5BD
	 1zGhloTdarG+EjDxTIEBVSsOfFluxvrw2pzmVUcF3QppGjiOV3PFX9pXXF8KxxWW/s
	 zGnK6XI/qvtNA==
Date: Fri, 28 Feb 2025 16:20:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v2] perf tools: Skip BPF sideband event for userspace
 profiling
Message-ID: <Z8JS2P-QwHcPUpTV@google.com>
References: <20250227051718.1176930-1-namhyung@kernel.org>
 <CAPhsuW6wuBjCo9ygCFhyYimEHg5ZNtN7-Yd+gWuMJPTU781vFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6wuBjCo9ygCFhyYimEHg5ZNtN7-Yd+gWuMJPTU781vFw@mail.gmail.com>

On Thu, Feb 27, 2025 at 10:50:26AM -0800, Song Liu wrote:
> On Wed, Feb 26, 2025 at 9:17 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The BPF sideband information is tracked using a separate thread and
> > evlist.  But it's only useful for profiling kernel and we can skip it
> > when users profile their application only in userspace.
> >
> > It seems it already fails to open the sideband event in that case.
> > Let's remove the noise in the verbose output anyway.
> >
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> This turns out to be more complicated than I thought. I actually
> like v1 better.

Sure, the complexity comes from moving the code to reduce the
duplication.  But either is fine to me.

Can I add your Acked-by to v1, then?

Thanks,
Namhyung

