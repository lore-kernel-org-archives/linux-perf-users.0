Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C712E1E9;
	Fri,  3 Oct 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518529; cv=none; b=rWH9uQv6nem+3kcGCnjPuoXBWCuyUB6sl5svIwKDl6smGWqBARbFkyrlaGzq2ixPhzXXaCrsPgrkKBZAV2ZQGKHbGsDh8JHfvvjoOqvLGavM6KPfM8BO+8WRbkSTBwQdyrk2uosWXyuKPaKOdNcaP1S7RXaf3Pk0zkiE9qlGSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518529; c=relaxed/simple;
	bh=SvicWixvmtaisHnyIjAhGh98L1PP/Omq7cJXMJ22NqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a98dLHu4lTIh143ZPB4pf1W3YBzMaiZ3A2zYU2iS5Uw+dQY0NyW2xuMzi09j6p6Ch5KPTLOzsGo/792h3r71E+xU/rQcGJxn6Rxe2lnEFnS3/lbkuirZe719zMlVUfIe+mEVJkeSBKa/W6f0eouHuiuYQarLI0IZ8h+gUxz1tEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxPPwvrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxPPwvrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153CEC4CEF5;
	Fri,  3 Oct 2025 19:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759518528;
	bh=SvicWixvmtaisHnyIjAhGh98L1PP/Omq7cJXMJ22NqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxPPwvrwNh3qCMdqVAQr0dzPHgXk5pq7o3gI5L6Fz2C9Y+IrtQ/DnyqoumIEpGU8N
	 2lok/p2YAn8E4B7urzpXvScJB+hIBiIDvvZGBtyDep3bKTO+yncASyn2MP5ae1d569
	 rTu+dlitwXcvYV6vYCLVTCCyrBjnQxyHy6FTtUI4AmWA4ULmRAtNiITNLxvly2xm1h
	 UG/6D+0EFmvFhp+f7WWdQiaJw8XaIC0iYCpBZnaoP/bC7Lrfaf5wFNtJtx2BBamaFO
	 f0vrIBpeExsifIHNWOA5Sv3SO/TyO17ZK95AlFTPFcB0qcC+N/cw6u0aLek/DCjzJQ
	 YkJSMC/Or97tg==
Date: Fri, 3 Oct 2025 16:08:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf stat: Refactor retry/skip/fatal error
 handling
Message-ID: <aOAfPZch7tqNy9Pn@x1>
References: <20251002220727.1889799-1-irogers@google.com>
 <20251002220727.1889799-2-irogers@google.com>
 <4a49c58a-4b07-456c-a2e6-67d04b905944@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a49c58a-4b07-456c-a2e6-67d04b905944@linaro.org>

On Fri, Oct 03, 2025 at 01:03:25PM +0100, James Clark wrote:
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
