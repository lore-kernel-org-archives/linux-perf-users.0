Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC43603DB;
	Mon, 25 May 2026 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779752371; cv=none; b=tOWxnBiPgZw8wuwApy+Le9U4RCC05B84rpnINnHlo1tMM2vNitCNewrx39p98jR3ZtGemTpBMkmqtedD28sQF0qOTI40++8RoQq+KoqdxvMiX7tFVPtPSQzchzaqdufga3J+A+kSUNBoOlff7PiCX28XLVrux//O5UlqDovPRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779752371; c=relaxed/simple;
	bh=0Y4Q0W1Ot7DmIMDNrYrHfqur+67S47nkT5WcFJ/ct5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5gZ29xENzGqOuUaMtk1XhOKqtSSBxufXfjaulNnbVdGyno5HA2J/cLo6fB1P3DLfecsS0jpAe8ieyHkFJ56ubFgu/JLeGtnz/0LIZfSPTooEhLSYHai23ckrTl2syCjn+OlJpwXm53Zrz5NcrgHwrDi3ii53odLlRPbwIbQvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BENO6N7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BENO6N7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9552E1F000E9;
	Mon, 25 May 2026 23:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779752370;
	bh=CFmr9KVkZqMfd1Tg/0bgoiJDC1D9d12me9OaZodSwyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BENO6N7Tv8g2n6PZCr0vdGGUMECZch8wjJgdGXuT6Ymrg8xHMxuEViFRDOm9KE+lF
	 /qB1VV5PHF02zkqCW4+692QN0lAfmoCY4AEWAb+zymZVIDdVHzCV1xXdd7rl7lSgyC
	 cvGktLryuflj1xzd1zR4Io9OpNxGyS6CTIO3v0pVCWgmXv/SeQ9n3zpxP4DmZcQVHz
	 qP6g8XLz/wMJExsjL8caj1pmXnppQiFwYVeBcHkqrDdEa/9kLCLYgIeLcCG7JNYP5P
	 sEhfTKktwq05Sh6W+ANPz2lokJ1IdDgYCchOaTvQqU+dKT8TF2m9ZgjdYTvXXU7Y3N
	 d+wbNg6BaiTnw==
Date: Mon, 25 May 2026 20:39:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [RFC PATCH v2 03/14] perf stat: Extend STD output linter to test
 basic New API checks
Message-ID: <ahTdrpOC6omvEHg7@x1>
References: <20260522223342.2393553-1-irogers@google.com>
 <20260525231900.3527228-1-irogers@google.com>
 <20260525231900.3527228-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525231900.3527228-4-irogers@google.com>

On Mon, May 25, 2026 at 04:18:49PM -0700, Ian Rogers wrote:
> This patch extends the standard console (STD) output linter script
> tools/perf/tests/shell/stat+std_output.sh to run the basic no-argument
> check a second time using the --new print flag:
> 
>   perf_cmd="--new -o ${stat_output}"
>   check_no_args "STD (New API)" "$perf_cmd"
> 
> This ensures that standard console outputs produced by the decoupled
> printing callbacks are formally validated by the test suite.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.5-flash


Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> ---
>  tools/perf/tests/shell/stat+std_output.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
> index 9c4b92ecf448..233e0a50eb33 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -118,5 +118,9 @@ then
>  else
>  	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
>  fi
> +# New API basic checks
> +perf_cmd="--new -o ${stat_output}"
> +check_no_args "STD (New API)" "$perf_cmd"
> +
>  cleanup
>  exit 0
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 
