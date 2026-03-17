Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D7334688;
	Tue, 17 Mar 2026 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775484; cv=none; b=cGy9kT0z1fQAXyHo5/dYIlWEzy1x0ew7uQo/8FlVMN+SXnuvVZlwy0dOcvMbZQNP+Ntbe4sdIglLrQ8WNg5QDOdTvdTMeHs7CrUh/g8SGDMVXWdQ+e/ZRxGs0Fw+ZyhxcYt3uKj0FyKJcFnp95116LgXL8IZer/L5xkBbf39/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775484; c=relaxed/simple;
	bh=OrWX52PPbNUvRTPuD1SlUTOd1+2mrpIom7I+UmRKyqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo5+H3t5S64gN5WXiOt7R9gK2hMherg5gkfn4s3a0u+lFKpi0UOi5WzDiGkDFqIMnHftU02Ikti1pUaN57rFkT9RCTxoce/TxSWRWNROw80forU63QQQaH2HhM08VS35r456qAhWrAl3iTYDazmkHYbH/79w3l8xs+mweqtC6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOS6ORhd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOS6ORhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F253DC4CEF7;
	Tue, 17 Mar 2026 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773775484;
	bh=OrWX52PPbNUvRTPuD1SlUTOd1+2mrpIom7I+UmRKyqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOS6ORhdl95Eu+xYUFBUBu5rVlLaevMqvMTem/PD1LWzkbGQlr/WiTWx/fxwkNH/h
	 ywMoSW6Oh3CrT1GPldlDdqRSC2OrfVrj462Z5+Q8X37LQHZ1z0+wtI4SkFBBa4S00x
	 raJhi/C4oXo9gY0vT2qd4KYyYAQp1Ng0+mEQMAV111PaCAOVBkn9ZWMrfHKZ4C9fPq
	 gh3smjMUbmwaziQ9AeSd17ZYr8LZJ7MzfFysvDHraDuI+1SBdI7amjE9h2+Kt2Od85
	 jKtZr4NHgRS2hwPERyJ1TsfuGRJinMTKPZyqUbJoC2BBrxNyWiqB6abkcK5v06p0yP
	 Dmcg/gTMsUBXQ==
Date: Tue, 17 Mar 2026 16:24:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools headers: Skip arm64 cputype.h check
Message-ID: <abmqeZEogMN9a3TI@x1>
References: <20260316-tools_remove_sync_cputype-h-v2-1-07c9cdb7b2f7@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-tools_remove_sync_cputype-h-v2-1-07c9cdb7b2f7@arm.com>

On Mon, Mar 16, 2026 at 11:11:57AM +0000, Leo Yan wrote:
> Some definitions in the arm64 kernel's cputype.h are kernel specific and
> cause perf build failures when the header is synced into tools.
> 
> Stop checking arm64's cputype.h.  In the future, the header in tools
> will be updated manually when teaching tools about new CPUs.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks, applied yesterday to perf-tools, for v7.0.

- Arnaldo
> ---
> Changes in v2:
> - Explicitly states that update cputype.h for new CPUs (Mark).
> - Link to v1: https://lore.kernel.org/r/20260316-tools_remove_sync_cputype-h-v1-1-9f0dc5931f09@arm.com
