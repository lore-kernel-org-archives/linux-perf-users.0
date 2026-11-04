Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826995;
	b=Xxoo5R4YAweeW7pFyBpo3XxpbVCrG+5di8Y0CealzsMi2gprEtROklKS0D5JIp8vQ2VT
	 Ev5oPVuUvY/w7ZMjF408FWVLrHWF+Vp3FehLNwByt1MQsrBUR1rsPqOLwvCb46xWpRwht
	 NrN/25NHBG+/Hc9pCTJ9DKe38Mmmy6xmIyjcrgKrpXutwV9/Uq1tIiNugJNkzr5v0AkZ+
	 YD9zd0KIT1d45c2usAhT4RbvK9M0kwnTNTk07eCNyJAXwtO9CxEt1ibqUrLNTK0A29OOz
	 csjX69Zs/l4nLsW7XhxJNEdoxHV6NXbZL3XS6eWmuesrgtnxMvjKfCOElFOeYsC319g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826995;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GWxglhdAWvx4URkaomVg38Xn9hLra4HP+Lq6Rrgyzig=;
	b=Pz9GQ/Y6vaH6z8dj2pXWJXhpIEAcTBegYAh5Hp9HiwoA+rmiTIeDUUSkcrc8mr7/Jiiw
	 gz4h0mMfnaaAjiukDXGAHI+/r8upPXUJqxSUiF5SEFLAdNWdIugrZE8ddBX94gGe6Ikpi
	 gx/jXlLyPNlNa6v0n2f+anY/iEoK46n9NK5t2EfiEfz1wa2Gl2KioMU4SlhAK6gc9zChX
	 KZGNO2UfK5ED105TxC0gAHojKSDC3Hl9N7pkvtyHS8KupyKxVzDRyn5QfrP6BLqxjih91
	 u5NO5HD/9lBaEa3gVxHD0djT2+VpF08YHPEGkJLqUpdmVYCfIszIXAJ//zsy24Z/tMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kR7wcsxJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADD60BDA3C;
	Wed,  4 Nov 2026 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kR7wcsxJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955231F0093A;
	Wed,  4 Nov 2026 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826995;
	bh=GWxglhdAWvx4URkaomVg38Xn9hLra4HP+Lq6Rrgyzig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kR7wcsxJHsHLN9lXrbFHPfy5QhoLmF5ujuJsfdOEQP2EtHPrawy/EcHS50mshPc+R
	 X8lchu1HOKIxSijFelPCMOn9vzCy2w8ZIQf2Uo1hD4l70ifJhPOf+JuSLedW0EvisY
	 P4weXD9sB7v6rV7n3LCGL6U/N7RnV6SCbJuglG63OUT9b2yNlJURNryn5+85UWLgur
	 Q0a382AreOrhF0+A0Y0YuXJt9Vl3AQqDvvp5g1sGtxLzuqIRZre0OdmlxRnshztCHb
	 Izxhcj/pAwtyODv1bMDR4NbyDgTg0mY6onVpaQTqUUNYCa7h9osXxS8Ar8ObZf0LpZ
	 89YI6ruEcRo5Q==
Date: Wed, 4 Nov 2026 18:16:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alice Rogers <alice.mei.rogers@gmail.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf python: Fix pylint warnings without Textual
Message-ID: <auugr4_wlpdtaSy2@phoenix2>
References: <20261023-perf_fix_pylint_warning-v1-0-b9da8dae2fe9@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-perf_fix_pylint_warning-v1-0-b9da8dae2fe9@arm.com>

On Fri, Oct 23, 2026 at 02:20:23PM +0100, Leo Yan wrote:
> An arm64 cross build without Textual on the host reports W0201 warnings
> in treport.py and ttimechart.py, causing the build to fail.
> 
> Initialize the inherited attributes in their constructors so pylint can
> recognize them without resolving the Textual base classes.

Seems simple enough, applying for v7.4.

- Arnaldo
 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Leo Yan (2):
>       perf treport: Initialize the subtitle in the constructor
>       perf timechart: Initialize Textual attributes in constructors
> 
>  tools/perf/python/treport.py    | 2 +-
>  tools/perf/python/ttimechart.py | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> ---
> base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
> change-id: 20261023-perf_fix_pylint_warning-58408f0b6c91
> 
> Best regards,
> -- 
> Leo Yan <leo.yan@arm.com>
> 
