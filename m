Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831826D4E5;
	Tue,  2 Dec 2025 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764651156; cv=none; b=Itg86dHBYpnhr4h6zSI00P+gLx/A89dampRH2Bplf0UFRcpTBxpj0dKB6kapkLnV+sUx5DHtMsOcelA13iURcKvR/JFqcqpkcST1FpyVm7ALsCI3cqz6XWogNvqTXi3SH3Uh848Y2PGAGw8hDNDr2JEy1REErKoRQ5XykAOBBio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764651156; c=relaxed/simple;
	bh=WClWem7m6PcEoPPhzHb90N/2hEOUA1s0vWbVVK/4kKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiHFk/buLcC+13o0XF4hdL92hj6+eETTMmIy34zN5KLjfAB/XIypcVjqx3ote0aEWeAS2e+c4zwhPn04+T4ZaXSjt+1Y80aNlA/d/07IMf7XrkjvysbKJz2XdUmlf2uwNZBnnFYwGQgefpA+koa68AzWkcx7UNfVLGah3eilMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDtjBCii; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDtjBCii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D12C4CEF1;
	Tue,  2 Dec 2025 04:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764651155;
	bh=WClWem7m6PcEoPPhzHb90N/2hEOUA1s0vWbVVK/4kKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDtjBCiizQbNOo8MgxH81F44TbOnpJK6ykdsq25KDX6WC7LdRuaM8tsph0CPBGu9G
	 shZeSi/6bjhedtc0Z/HkKsthS6BQ+pAPxp8ZAmKy9aDr48zxFQQtG9etx4kO9elQ9L
	 xHBYv4d7OjRcqNnaoWbmk5h/795qG8YzTR6IJIW5EIRboaUwKMEg0usbOyrhoDeDPo
	 15vwVm8ynmhVvAgxBTLRA6h9ov3BSWrV4tBuQ09rqbCoR3NO2qkyPGqAkrOqg0/EnR
	 8gqGXqeiWQxZOoHyMWWQBvZIlNxzv9TSPfMhodZjkR7mLZWE6ZllrpAbefgwJCN0EX
	 enyA+ZRvfu5yg==
Date: Tue, 2 Dec 2025 05:52:30 +0100
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
Message-ID: <aS5wjmbAM9ka3M2g@gmail.com>
References: <20251201230904.290733-1-irogers@google.com>
 <aS5tRnf801Sm3z8P@gmail.com>
 <aS5t5hCk0vde4QvY@gmail.com>
 <aS5u7BkXnA2Q19-8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS5u7BkXnA2Q19-8@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> With all 4 patches applied to v6.18 'perf stat --null' 
> works fine:
> 
>   Tested-by: Ingo Molnar <mingo@kernel.org>

BTW., there's a long-standing perf-stat --repeat bug 
where signals don't seem to get properly propagated.

The following command takes 10 seconds to run, as 
expected:

  starship:~/tip> perf stat --null --repeat 10 sleep 1

   Performance counter stats for 'sleep 1' (10 runs):

           1.0026669 +- 0.0000503 seconds time elapsed  ( +-  0.01% )

But if I try to interrupt the test:

  starship:~/tip> perf stat --null --repeat 10 sleep 1
  ^Csleep: Interrupt
  ^Csleep: Interrupt

   Performance counter stats for 'sleep 1' (10 runs):

              0.9250 +- 0.0543 seconds time elapsed  ( +-  5.87% )


The Ctrl-C only propagates to the <command>, interrupts 
it (as can be seen from the shortened total runtime 
that is less than 10 seconds), and otherwise results in 
both an incorrect measurement and a misleading output 
of the partial results.

Furthermore, the test runs to full completion - which 
can be annoying if you happen to use high --repeat 
counts like I sometimes do. I have to Ctrl-Z and 
killall -9 perf to kill such instances.

Thanks,

	Ingo
