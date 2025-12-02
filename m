Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270F1E7C08;
	Tue,  2 Dec 2025 04:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650738; cv=none; b=jI0faStZhJGHG+BQzRZDeeU1CAw2MgV/yMS7CbPJl+W48yi2pZ29iDiDBLrC/Qq2eoR/74XZ4p8UHGc+GbwfDHsiGJWV2VRSDQIJmJtwoa8oNFvbH+l5Sx+LAH5hlon+B7tMPC8Hm/dhlrgLOxhoYOnG64fXAM0YUUbnA8oXamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650738; c=relaxed/simple;
	bh=xA9fCVj9cAF3TgJoyv2A3iCV6Ovgc0j6hj3/OWH0q50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnRc3bhUXxz1PYU1W/rC+DADUEPR05aCy3pIORQ28H3n0NS097g2wRwmNC0XIGVSMF+6+HthnaKqh1hJ2IQB3FOoFGgl0x/KYIqKzxFsTkFEb3B0vi0sjvRh/P51yaQH2VzrKZVdmDodnF7mLJx0+UwmjCgsRPC6od767ZvQgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxN6aFOl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxN6aFOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DFBC4CEF1;
	Tue,  2 Dec 2025 04:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764650737;
	bh=xA9fCVj9cAF3TgJoyv2A3iCV6Ovgc0j6hj3/OWH0q50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxN6aFOlzUCwMYEBYQTMpG2yua/Z3VyZ1KVPR53E+JxFIgamsN3jTZn9YjB5/8I4e
	 vNg4MaWi5J8mr3M5A2iu9/aF+HdNr8bRrVRmCVumucG5H0yahF7LjUa1DOjQEVSsxq
	 RzxDp2jn5AcvU14JsKym1B9EGaDaxuplztU5PsGFqyfBu8pIQ1eLoGDLf+2vSOtpS5
	 Ku4d+yAcss0JqiSpL4Yfkl0zP6pCblTdzyxbECierHYLF5tHARnHZAGgKYM7MepFSW
	 5H0ZsepdwshVDU/C2Tcd3RVeG2olrJQq7oHaCd8icYTgGsdleMXAfuXU+Ef+/0WLXl
	 vI0mhsoZA152A==
Date: Tue, 2 Dec 2025 05:45:32 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] perf stat: Allow no events to open if this is a
 "--null" run
Message-ID: <aS5u7BkXnA2Q19-8@gmail.com>
References: <20251201230904.290733-1-irogers@google.com>
 <aS5tRnf801Sm3z8P@gmail.com>
 <aS5t5hCk0vde4QvY@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS5t5hCk0vde4QvY@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > Note that without the cpumask workaround patch I sent 
> > 'perf stat --null' still segfaults on perf-tools-next 
> > even with the above patch applied - I suppose that's 
> > expected, right?
> 
> Ignore me, I just saw your fix series:
> 
>   git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next

With all 4 patches applied to v6.18 'perf stat --null' 
works fine:

  Tested-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
