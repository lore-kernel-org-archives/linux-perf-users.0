Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16898346E7A;
	Sun, 13 Sep 2026 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335785; cv=none; b=QYJzsta82ey1qPECiLXmU4htzycp48B7n2iXQ2/mDDmpmBnB11pjVJ/JP1MH17E5MFEdC4VK1mOWiez9t/F3VG0E+xbVNkBB9rMi0CHoyizGIe1T2e7Vw1PsjsvybJ8csWsbxUrRIl3bV8zINimD8T5CC6Cl63MLiS7jyp0eRH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335785; c=relaxed/simple;
	bh=HjFa4B3eCX5guWy2r9yClsjwETQF7i3PKCnH+yU4O04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+9Y4cMjZnoSugCLpJIEig5zwWnKbeSIBz0JoIAsLvO+mnZNrsqboWmQ+eW61JIwUDTIULTzW8lEPXDkyHD5XYenOFPNPwlUpKrXtRmzWQZJI0DFc/GONpK8VAy1HlOl4UKkTzswED4jfJbAUqFXHLvriFPl0dI1Golvo/KQ/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk7/FnzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk7/FnzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184721F000FF;
	Sun, 13 Sep 2026 21:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789335783;
	bh=jRscbPnOSPwRB4FXS06UmMhDuaIDpK52PhUJvYsmEIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xk7/FnzHgH/2OFItC92Y04zRjwZ5HE7wHw8OMXPXTRwQ1Z76HSnaVt3GjcXh0Bo7A
	 73DxQcbFGqalsz4F9TYL8Q9s00ScSoLfULGVMHKGEhgEbT1qEseWxxFy4AQYgZ0P4q
	 M3J/aO6WXOf2KheR92sVP1maYAEitY9rUjTuqVmoW+dhbO+AYHWdB+xdGxYVTUKpq4
	 aZUmRiU7+L9a5oh+3cM52MZYW86dHLrqe3ZGWPFB4D955/SM8klwT/ajC3873+oE4F
	 PsyAPLhpuwsOaLFa5snUlJgWgovaDD3LUoMfyjnxvFcTm7/K9G0+A0/NrHw1AhroWL
	 uzrm1Wgb0yroA==
Date: Sun, 13 Sep 2026 18:42:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] perf header: Fix memory corruption and
 unnecessary warning
Message-ID: <aqcY426CLXDPOWSU@x2>
References: <20260910175634.3014018-1-irogers@google.com>
 <20260910211221.3154261-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910211221.3154261-1-irogers@google.com>

On Thu, Sep 10, 2026 at 02:12:17PM -0700, Ian Rogers wrote:
> Some minor fixes that have shown up during testing.
> 
> v3: Fix Sashiko include nit. Accidentally posted wrong 1st patch in v2 (sorry :-( )
> v2: Fix missing newling for pr_warning:
> https://lore.kernel.org/linux-perf-users/20260910175634.3014018-1-irogers@google.com/
> v1:
> https://lore.kernel.org/linux-perf-users/20260910173715.2996571-1-irogers@google.com/

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> Ian Rogers (3):
>   perf header: Fix HEADER_COMPRESSED validation for comp_mmap_len
>   perf header: Fix potential memory corruption in cpu_cache_level__read
>   perf header: Transition WARN macros to debug.h equivalents
> 
>  tools/perf/util/header.c | 122 ++++++++++++++++++++++++---------------
>  1 file changed, 74 insertions(+), 48 deletions(-)
> 
> -- 
> 2.55.0.1007.g17ff1f9808-goog
