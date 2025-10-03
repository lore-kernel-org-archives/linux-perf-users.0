Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0D1A9F9B;
	Fri,  3 Oct 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759519678; cv=none; b=PMX8ntYBhvGqz2m7pHjrE5/xwFMFABeo5zfdNrNaK3GEQJGkJxuPqWnUZNnT2d5Egb3b+Ao6bhMrq9PoC5VZg1YWlzYii/6ITbalr7Yz9I2JnVccFpgcOzlDe3VPXt5azvHFdNewoqgGnhc800Dm9kraXlQh+HLD00f/mo/t7NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759519678; c=relaxed/simple;
	bh=+3/SNgTkdPUgDjGUiVYWGQyYCU3vEkAv+rXQrlV99TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWmX5LU01os8e/To22hCwabb2BUxjKpOk4QD4zW0U6uSMApkQlR4C7m+1oe2a+V9NrpMpCHlOyDP1X9dD6Hb2b/D+yuV3bo8Kohp6bbuYkdPk3LZhTt5k2NT3WUhbJWJQowhFR78wbl2GmspCxkMf4SjUyZ+fDwDiRP0iGS8j0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNjj6Kis; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNjj6Kis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C12C4CEF5;
	Fri,  3 Oct 2025 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759519678;
	bh=+3/SNgTkdPUgDjGUiVYWGQyYCU3vEkAv+rXQrlV99TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNjj6KisEUlG1vevBXkFRZwxHBTDAf6+BT8+bIPLC5FAZpZWU/+RIfWetfw6hsIIE
	 3g0TeQWhQ3rRPYUM1ycRh3qj4bApdhucgIpz5pEN6WYTZ5VOyKRfj9uR6E3nqStNyX
	 uhHHGIAkWHlbTi+RTkZrJyCPpeyP2qJcftjTstqr4D2rt6b5t2POsYxTPst0kJbsUW
	 Dl/C/qDa/kRgjLLWCUB/cVLl+KLJt9g8A54hOl9r1e/unHX5+Sw0y+rzDOtcLPCgFf
	 P0WNR9h177Wm//ElDAxRmph3rlVdhJ1VrldGIIXPlCW5D/LbKmtViTamluyby2tzNt
	 vELMsOVcGoUEA==
Date: Fri, 3 Oct 2025 16:27:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: thomas.falcon@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [Patch v3 0/2] perf record: ratio-to-prev event term for auto
 counter reload
Message-ID: <aOAju-lDNHBFnYWx@x1>
References: <20251002234308.64218-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002234308.64218-1-thomas.falcon@intel.com>

On Thu, Oct 02, 2025 at 06:43:04PM -0500, thomas.falcon@intel.com wrote:
> The goal is to limit event sampling to cases when the branch miss rate
> exceeds 20%. If the branch instructions sample period is exceeded
> first, both events are reloaded.  If branch misses exceed their
> threshold first, only the second counter is reloaded, and a sample is
> taken.
 
> To simplify this, provide a new “ratio-to-prev” event term
> that works alongside the period event option or -c option.
> This would allow users to specify the desired relative rate
> between events as a ratio, making configuration more intuitive.
 
> With this enhancement, the equivalent command would be:
> 
> perf record -e "{cpu_atom/branch-misses/ppu,\
> cpu_atom/branch-instructions,period=1000000,ratio_to_prev=5/u}" \
> -- ./mispredict
> or
> perf record -e "{cpu_atom/branch-misses/ppu,\
> cpu_atom/branch-instructions,ratio-to-prev=5/u}" -c 1000000 \
> -- ./mispredict
> [1] https://lore.kernel.org/lkml/20250327195217.2683619-1-kan.liang@linux.intel.com/
> v3: rebase to current perf-tools-next

Thanks, applied to perf-tools-next,

- Arnaldo
 
> v2: (changes below suggested by Ian Rogers):
