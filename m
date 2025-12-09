Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49718DB37;
	Tue,  9 Dec 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765302310; cv=none; b=XFwqa9hUTB5KbZs+2nL6u+cDML13hCt7Pg5GePEM/cV+P8KLi9z7Huiova0jDF+stjtdXSHjC6PFsZA5LUsX8B4BCB97p3XXHQEUvGdRowRf7gqta1NrXkgRdGUw4xLyTfy0gvU1DIgLVD28kdu1SXJ8MlFY7kzyPFMQPgpYR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765302310; c=relaxed/simple;
	bh=skAXoBpHNTkKVU3U3eBAL5ATWHlYgImp9C9SB4TysIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC8Q2afpkqS/Uyofpf6B8TLv6p8WHRGHCioET4qqqg8kAm1fOXdkpfQekLOWe9F+RBdrCP1h1ntcMdUa/sD7aBGWMhJCPvGWtXjhEzB5v5zbrwxiIqPsCxzHXBqTLanZoBlGieA83MoXIYEA88LW/FDa8aYoizm/FfUtprAw9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftoFdza9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftoFdza9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751C9C4CEF5;
	Tue,  9 Dec 2025 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765302310;
	bh=skAXoBpHNTkKVU3U3eBAL5ATWHlYgImp9C9SB4TysIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftoFdza9VhCFN0FTA/waYr9c3NFBxEm9xNt7rjEVxovtf4+IndCufz1t9S9KSQkir
	 8+p4zOcr6MJDTnEr4no3vtlKPNoSWTZH8yKeKGATBIGPn+X5FPu9sMCRZ2fGH8e5+q
	 GlkbV3GLEPAHc/eObtOxoOgqoKZ7hq6hcglDy0md+afh1HcHhXPPbek1L8yuLotiW5
	 o2KUQMYfwJrz1yY0Q80XauuoaKU9522Qra9CLsXtv0gsLolQ1QD21i71EYuxCL2Dq1
	 0nT8Bktnvp418OwXILPiGTIunPnpSLOg7cZuATXoSFqdolg/wYqfEYPCruBnT216Xm
	 ajuHAlz6mZ3zw==
Date: Tue, 9 Dec 2025 18:45:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat display: Make %f precision consistent
Message-ID: <aThgIB2VQdAtEXKm@gmail.com>
References: <20251209173610.2033973-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209173610.2033973-1-irogers@google.com>

* Ian Rogers <irogers@google.com> wrote:

> Commit bc22de9bcdb2 ("perf stat: Display time in precision based on
> std deviation") added multirun workload elapsed time. There was an
> effort to make the precision in the output most useful for the user,
> however, when gathering over runs it means the formatting varies. This
> change just makes the output format fixed.
>
> Before:
> ```
> $ while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 | grep elapsed; done
>           0.101140 +- 0.000149 seconds time elapsed  ( +-  0.15% )
>          0.1011396 +- 0.0000218 seconds time elapsed  ( +-  0.02% )
>           0.101331 +- 0.000124 seconds time elapsed  ( +-  0.12% )
> ^C
> $ while :; do perf stat --null --repeat 3 sleep 1 2>&1 | grep elapsed; done
>           1.001317 +- 0.000146 seconds time elapsed  ( +-  0.01% )
>           1.001377 +- 0.000172 seconds time elapsed  ( +-  0.02% )
>            1.00253 +- 0.00131 seconds time elapsed  ( +-  0.13% )
> ```
>
> After:
> ```
> $ while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 | grep elapsed; done
>        0.101406408 +- 0.000064778 seconds time elapsed  ( +-  0.06% )
>        0.101367315 +- 0.000027253 seconds time elapsed  ( +-  0.03% )
>        0.101434164 +- 0.000084750 seconds time elapsed  ( +-  0.08% )
> ^C
> $ while :; do perf stat --null --repeat 3 sleep 1 2>&1 | grep elapsed; done
>        1.001525467 +- 0.000051703 seconds time elapsed  ( +-  0.01% )
>        1.001375093 +- 0.000116200 seconds time elapsed  ( +-  0.01% )
>        1.001141025 +- 0.000046361 seconds time elapsed  ( +-  0.00% )

Perfect, thank you!

Tested-by: Ingo Molnar <mingo@kernel.org>

	Ingo

