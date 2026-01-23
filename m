Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC21A95E;
	Fri, 23 Jan 2026 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186976; cv=none; b=cyQzzI73/2h9+YvncTHd16o5IUA4loCH6/R0Zg1TGtEi8uMEWtPpO+z9tJxAJ4BtcdjYkeAxavEliUjEL2oHalNT7vT+mzidTkefv+8/HhZmwsFuZjcCVVSEWFGHl1XlxbbvWEToLDFbyTyoTvgiIxhs0TK+9RCmPkk3zW9kCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186976; c=relaxed/simple;
	bh=A3mZicZpLC43KCYr7mVEjwdTkXIw+XfFMwvyAZ81vDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7B7WP389+dh3p4mA9H4bHJwuGAeDBFZAzXoiMzrt7SzQXst5RmIcp+tGSj2DEN/UpqtWe9KVDDgPeOJofPVC3CagNaOANB1k06LHKOhKH+EUVJpTPqwCmPnVdjpQyGAYT8U0Gv10rS432RdBFQVQpcwazZw9/L30iI3il5G3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5sghdH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5sghdH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9996AC4CEF1;
	Fri, 23 Jan 2026 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769186976;
	bh=A3mZicZpLC43KCYr7mVEjwdTkXIw+XfFMwvyAZ81vDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5sghdH9AeMXsQZ2lwLmFRttD0egvL82Z51wIQ/jJq7wKuKlkdCHyue91kQLWQBso
	 P6y5aIV9SWhzYitm8prJkRreCdpAb0psiBR0AnWR4/0TEofFCosR9/FLEeEGi4RZPW
	 +WZCuNc7Y7exYhGxMnZsgBljYmYH0NkRiX3KCxDpmAn1L/se0D0WbMcLdfN8mOfzmn
	 SdSnp2+sw4En+yH7zCIQgLgsmshxjg5tiTaW6oJkdZyZ1KR75ylBmxXdSHdjJJq0LH
	 qYI3eTADFpFyAH/p5uld27Ix77LZFsPMBICH+xIHznRCXYE51DK5PuyBiriChHEWHJ
	 Ie+DU8lRL1m4g==
Date: Fri, 23 Jan 2026 13:49:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf inject: With --convert-callchain ignore the
 dummy event for dwarf stacks
Message-ID: <aXOmnRBG6W4MjQuP@x1>
References: <20260122175846.592786-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122175846.592786-1-irogers@google.com>

On Thu, Jan 22, 2026 at 09:58:46AM -0800, Ian Rogers wrote:
> On hybrid systems there is generally >1 event and a dummy event. The
> perf inject --convert-callchain option is failing to convert perf.data
> files on such systems reporting "--convert-callchain requires DWARF
> call graph." The failing event is the dummy event that doesn't need to
> be set up for samples. As such ignore this event when checking the
> evsels.
> 
> Fixes: 92ea788d2af4 ("perf inject: Add --convert-callchain option")



Thanks, applied to perf-tools-next,

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index c89ac85ec112..ea3ac35256ce 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2727,7 +2727,7 @@ int cmd_inject(int argc, const char **argv)
>  		}
>  
>  		evlist__for_each_entry(inject.session->evlist, evsel) {
> -			if (!evsel__has_dwarf_callchain(evsel)) {
> +			if (!evsel__has_dwarf_callchain(evsel) && !evsel__is_dummy_event(evsel)) {
>  				pr_err("--convert-callchain requires DWARF call graph.\n");
>  				goto out_delete;
>  			}
> -- 
> 2.52.0.457.g6b5491de43-goog
