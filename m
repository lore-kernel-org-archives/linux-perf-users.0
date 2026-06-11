Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691935504D;
	Thu, 11 Jun 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190395; cv=none; b=kRTmwnN4guDrZZJaLeshljNjjBdh549iVh95lrEA5r4KhezrhfoWP/2v32WVfmh3Z3vzyy8f/vkaC9gqWWn/+QKMuPsJEIyoFwcOdK0ICO96WFjcxkuoE53JGJyg6OtA/DmJ26ie5RDMZB2i6aC+bExId5ynGDAeilQ12Ma/FFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190395; c=relaxed/simple;
	bh=2N8unc6ahWLvzQCpuNunWTX0dzhRU2Qtf69RPevIBRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWgWveO7aL2WDTQ2Yh1A0+xgrIj9yMwUEFsoaXtFiFtQYq8ZfwtMDqPA4SQ7XdKENd6OACEFaNZP6lVBWv21nx6decfeie1QtOF/VyWHc1/TZemCQzW96WpbRUUfNXwTEKoFRvw433+CmCuxl8tGAWvwwdtZHXLOceXC252cfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDha3PL/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDha3PL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477B81F00893;
	Thu, 11 Jun 2026 15:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190393;
	bh=1wSYg0D8F1G9cN3LzGBZ3/PbNUN8uV9X9skaQ/iflVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LDha3PL/lvXOw26oLsijSZ6CHI/iGGNAdjAFRolZbfeQ/VUgwaK869EVh9nilU+3x
	 esTvQexQSOdTRg8i1PBT/A12Y1VxxNxqxTGPtbRgy5eQOQx38izEW3vTDVmLvrbrmo
	 t41OtIwlfPi1CQsTwGtnT41l1YWoWy7Zvx7I2Pq0BOeZMyUTs+0wiWYQjuKOuEsT6E
	 bauR3ufWDciH2o+8+7th4AnOTUNTMt/dPTlhCzpeLlqAYzzom3zMPlPYu/mlzplv34
	 XfrEKb6SCzK1hObh+79XnoiUvpoTgOgoK3udQ7BECnjjWlG4MGqGxi5q2UUMXDyxrW
	 48lAIP7mmYTlw==
Date: Thu, 11 Jun 2026 12:06:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v10] perf test: Truncate printed test descriptions
 dynamically to avoid terminal wrapping
Message-ID: <airO9qXTIGltt3-Q@x1>
References: <CAP-5=fWtK6tGzJaWRz4SZ8_sK=tz39+-5im64Yzt47B0e+X_PA@mail.gmail.com>
 <20260604220627.902635-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604220627.902635-1-irogers@google.com>

On Thu, Jun 04, 2026 at 03:06:27PM -0700, Ian Rogers wrote:
> When test descriptions are extremely long (e.g., the truncated perf.data
> graceful handling test is 103 characters long), they wrap across terminal
> boundaries.
> 
> Because the ANSI escape code to delete the line (PERF_COLOR_DELETE_LINE)
> only clears a single terminal line, visual wrapping leaves orphan
> wrapped lines on the screen, which results in the test description being
> printed multiple times.
> 
> Resolve this by checking the terminal width (get_term_dimensions) and
> dynamically truncating the printed test description to fit within the
> available columns, leaving safety space for the prefix index and status
> suffix.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
