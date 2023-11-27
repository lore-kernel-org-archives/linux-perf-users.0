Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619D2D7BE
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv0EazDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E4DC433C7;
	Mon, 27 Nov 2023 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701091250;
	bh=BM2l69clFzuDzEVVhytXVUK2DJxV/0d206kvjSJINks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xv0EazDbL5w497ShYfaO6O4fNO3gSTJkF2A2hgKPWQvK3qdpYmsJBsPkoINsEVvDi
	 CmZb57F8xzqqTfBqUeHF/evGsAj0Y9zXPXXDE799sfWDaZJM8JRhX6/EDsTaBxfjaT
	 0FiasSKE2LFArvU2OnBbPgxrLs1zO0Sa1E9Mdmg8LjqUpYxlqwOHUQ1sDxISrZXaAa
	 YQTR2jYSaHBQySKthYmKSchxflkzdf0RAzONuHRUkAT8iv1VGh6QZD/hJq0W81H6U7
	 lcW/TQH4Ne4uDhHoAt+qjCyZL2QWhSE7gLOC6tNnaSbCioO8HyVz9kEXSzGrTTb+3W
	 J/izWbOrAq8sw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id E5A3940094; Mon, 27 Nov 2023 10:20:47 -0300 (-03)
Date: Mon, 27 Nov 2023 10:20:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: Nick Forrington <nick.forrington@arm.com>,
	Michael Petlan <mpetlan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, vmolnaro@redhat.com
Subject: Re: [PATCH] perf test: Remove atomics from test_loop to avoid test
 failures
Message-ID: <ZWSXr7e5KxM79Z0l@kernel.org>
References: <20231102162225.50028-1-nick.forrington@arm.com>
 <alpine.LRH.2.20.2311242037260.11297@Diego>
 <20231125030529.GB178091@leoy-huanghe>
 <f0ac7523-edce-4b0b-a142-14c03c912720@arm.com>
 <20231126074030.GA647134@leoy-yangtze.lan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126074030.GA647134@leoy-yangtze.lan>
X-Url: http://acmel.wordpress.com

Em Sun, Nov 26, 2023 at 03:41:14PM +0800, Leo Yan escreveu:
> Maybe the commit log caused a bit confusion, the problem is after

We'll have the Link pointing to this discussion.

> enabling "-moutline-atomics" on aarch64, the overhead is altered into
> the linked __aarch64_ldadd4_relax() function, test_loop() cannot be
> sampled anymore, but it's not about stack tracing.
> 
> Anyway, the patch is fine for me.

I'm taking this as an Acked-by: Leo

But probably this could be even a Tested-by, ok?

- Arnaldo
