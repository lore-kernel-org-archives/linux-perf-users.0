Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5C3911B5;
	Fri, 25 Sep 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350547; cv=none; b=Hx1eDn1QhuqRWJF2TJpKEJ7wLJsi6WB94QMwCMvs/jcUMoyNWIx8Ey0QGzCip8GicnUhfApmCi/+yKRU/wFQ474t6YdvNN90r//2BCbIYzUhTQUYCZmRzLBTs/sh7fA/mOGaZ7SJd0RXzo5P+semLTGEhY4RfrS16c1zPWy1sFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350547; c=relaxed/simple;
	bh=aDfKdjzQm3vyUHFNnWu4PiIDKuEX8i98zrpL7PvteKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAkVFyNkWSZzTajm3BxLPXObZmeMppjG4Wwp13KvFmUoRcRvlGdEtpWDn3EB/glGjkLhrNSr3TebJNqJj/s8WvWghXkbvZfGOoQN0tszCQjwY3daUwdKMvZCBf4YCU2hhXEyvVYsrNpDzz8WSbwGpCCCR7DH7NapKHE5/uxyec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmYlQObY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmYlQObY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEA31F000FF;
	Fri, 25 Sep 2026 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350545;
	bh=Aa9cYFJ37ytJHCRoA2y3rb4veOJl4gMOjRaDQrcSfkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NmYlQObY+W9YYYxtEy03Qd/AWbDPYq2yo7/Z5QyR5sm2TZL3BCfWGM99dQyBCpYhv
	 ycFlHX7k3fWrl5V0+LPuFBzK+160XWn4hH+K+ukIZa3Gq08ygescwaPsaTH74NhoRG
	 GVQcOV29+IgqxB9flAy/vN2wOz9zF0EDMUJHIXUBupOQ5Ded2PfC/RjKP1G6RGufAg
	 TfPKc4XQxO0dxjjCv95uYGF5cV/NbRBxkog4Myi573xzUHsyJZ1+vY4/CCljvFreOk
	 BJO4LEWOIgmUi4ca0xPnfwDKhHiqcwpv+lJSr0vuCB35aHJsdF+ZiJvjzenKbXbOih
	 nnuRgO16HDvvQ==
Date: Fri, 25 Sep 2026 08:35:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: stat metrics cgroup strip possible slash
 from cgroup name
Message-ID: <araUzxox2c-e_pOA@z2>
References: <20260917061312.820074-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917061312.820074-1-irogers@google.com>

On Wed, Sep 16, 2026 at 11:13:12PM -0700, Ian Rogers wrote:
> The grep to match cgroup name in metric output assumes no leading / on
> the cgroup name, however, cgroups in /proc/self/cgroup may have a
> leading /. Strip the / if it exists to avoid failures to match the
> cgroup name in the perf stat output.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/stat_metrics_cgrp.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tests/shell/stat_metrics_cgrp.sh
> index d4226ee0ae98..0728f48f21fa 100755
> --- a/tools/perf/tests/shell/stat_metrics_cgrp.sh
> +++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
> @@ -86,6 +86,13 @@ check_metric_reported()
>  
>  	for cgrp in "${cgrps[@]}"; do
>  		# Find metric lines for this cgroup
> +		case "$cgrp" in
> +			/)  # The root cgroup, leave unchanged.
> +			  ;;
> +			/*) # Strip any starting slashes.
> +			  cgrp="${cgrp#/}"
> +			  ;;
> +		esac
>  		# We use exact cgroup match with surrounding commas
>  		local cgrp_lines
>  		cgrp_lines=$(echo "${output}" | grep -F ",${cgrp}," | grep "insn_per_cycle" || true)
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
