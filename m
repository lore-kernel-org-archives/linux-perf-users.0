Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95012DD95;
	Tue, 13 May 2025 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169194; cv=none; b=ZMN/eJddLmpuaXLjfxMs+X7H2gEm0lfcHqXMrhp6NQQN7pvxsU/jzVFUY7uCyDuyiRnpZtWY44md+1K0RNAE7btgYv0tjR0OA8K/Hx6Hbgx4ntMNQMHQjGTx8wCbWc7pOleTFTB9soaLbigELvlXhz6zONV0+6whdCHcoTjk3H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169194; c=relaxed/simple;
	bh=iNYXwGdie6s9H3tf/OQ0GlhvsYZI0vpta/O/nlr0LRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxFmgbfnMjVmKdA3/oLC95AQip/vAmZZcYBYQyDOJ2p4tICnQvCev2/tSmUcEN0Cds0maV803253hYxoi91Ki0GeOFpVusqLCTQF7E8QoNBAe/E1qRPgJklkKXsV7+xp14abb8r4d2/k6ZZWKKJJRHQUy2ntd6t0oSZx7J//A64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJAGs9h7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJAGs9h7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E1DC4CEE4;
	Tue, 13 May 2025 20:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747169194;
	bh=iNYXwGdie6s9H3tf/OQ0GlhvsYZI0vpta/O/nlr0LRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJAGs9h7G/jHx15vjirkpgmHB5q+SSHosWpyx5WbqLv1FIH8ys0wW2HyhJKHLrG1E
	 urewg9KSpFMoxm1D8EG5zO9uqSeFrdDVSNxEwK38/rLMzvk3igF1ennA54C4LOdhIt
	 5K+KLCSuHgihuAu8Nq2bhulNElCVopzHkTSevSWCx83wRUtHhY34XmmWbX9xw2V+eR
	 tDKD3qublc22x98Vgjls8vMs7bKPGXPS8x4bef0zvS9WgKuGjWsD0WuPhZKyz33r4W
	 RO+LpB8rl2vqFENiUATf3T3H2AGVdR/1YiTiUOh4ZmQHP3Kgox+ZZrUIU6Q+VtxW7q
	 1EwiwwvN+BBgg==
Date: Tue, 13 May 2025 17:46:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf test: Fix LBR test by ignoring idle task
Message-ID: <aCOvp9CRhmdwD5yK@x1>
References: <20250509213017.204343-1-namhyung@kernel.org>
 <CAP-5=fVQ1L2yD3F+XLg4-U57wVVDFhkfb3QRD34ie01JjmijJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVQ1L2yD3F+XLg4-U57wVVDFhkfb3QRD34ie01JjmijJQ@mail.gmail.com>

On Tue, May 13, 2025 at 07:58:07AM -0700, Ian Rogers wrote:
> On Fri, May 9, 2025 at 2:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > I found 'perf record LBR tests' failing due to empty branch stacks.

<SNIP>

> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
