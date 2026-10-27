Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133586;
	b=rKSQEGBFDzmV/zqRQkeij9X6tUdCQccQQoOcSS2yyiFTMA6qwmP9OgQoTwIa49fgAuCx
	 Ag4MyjtTmZSBFbTvNGI8JpdJwawoQ0GYZF/6Vh2M6Q9YRnjblrjNB25+VJPIB0wj+yVYX
	 6BY9pwDPfzJylF8jFjLc6C3tmz75rhnBcll4Bx/R1vcYv0oMiINZ81iS6YGqGANHOvusw
	 yj+J3cBHnMSjpF4ThrFaiHWt6c35SA64yLyNRShxGhOFnEQK1Q/ptXK/z2yjA2wyVAn1U
	 1uoRHy9nUTQCEo+2ns3Ob3LcQblvoeWJ08WhGVxHFRSmvJNQERIyPPCiCtsIlNLRi9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133586;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0XiO9UdlKPvO9Od25ZU7uv870UVuHz4UbUNzzmJtAJQ=;
	b=Nifz/gnuvHRucURaGf4Cs2sD1uxk6hMCAsMGsYTmws1CjV9hk9DVgwecSs8+kWewCv5Y
	 v04NlpivrvABjGXkhH+nEe+P5tOk9dv0iFgfo9u1da2nXpdSZ5NOXaG8KFtiEFBC86jDS
	 BLWU7ig6IYqXSV2kpgo99pu4BRxnCoOHQFt7YL7LAIcc3SPNoiM8tEt1cRbxWNDE4Yfbo
	 eP/XCg6dTuz2f+/chj5V5ualZFIB5Clbrvax4ZAaOqvDFuJ1KLG93rDAF1mxK1rngeWrG
	 g8OMt7i7doznYn+R5Be/rNlsc6m1ak9GEM7TLubIAl+izGTywruidTnrwnJJMcyFcuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lc5n6gOF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1E606A323;
	Tue, 27 Oct 2026 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lc5n6gOF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED501F031E2;
	Tue, 27 Oct 2026 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133586;
	bh=0XiO9UdlKPvO9Od25ZU7uv870UVuHz4UbUNzzmJtAJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lc5n6gOFv+T3jwvrET1ilzd9TXkiWRL0whCU0wRbqrNjjSMLfg2apqLkmcDqe6dI8
	 HWaNgti/uToQ3LrbTIRCT9I/FIa7xKufq7yxKFYX88ooQwNxqvZS0g62bA6RhI3vAE
	 O/AnvVo0ATIlrZeiHqQ+0m33Er8Gsz1zsllCop4mNG2taAGX4u7YD+FnlutuZ66C75
	 xkZHVz39l9E6YqgQAH/WDUz1TiltQ7Dqehx17YhUV6blfTpMOn/EcN8K/YtFYFftpY
	 EYrcZmEDejDFQ+NRPDD8PlvdHpn+PY54qcd7TMT5TQy87L4d4k4fcKQpmL61iGZup5
	 afLMrpH+nRpSQ==
Date: Tue, 27 Oct 2026 17:39:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf print_insn: Include sys/types.h for ssize_t
Message-ID: <auEMDz98qPMsFXiu@phoenix2>
References: <20261026174535.3157580-1-florian.fainelli@broadcom.com>
 <297198e4-3179-4de6-b5c4-ede4faa92ebf@linaro.org>
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
In-Reply-To: <297198e4-3179-4de6-b5c4-ede4faa92ebf@linaro.org>

On Mon, Oct 26, 2026 at 06:27:25PM +0000, James Clark wrote:
> On 26/10/2026 17:45, Florian Fainelli wrote:
> > +++ b/tools/perf/util/print_insn.h
> > @@ -4,6 +4,7 @@
> >   #include <stddef.h>
> >   #include <stdio.h>
> > +#include <sys/types.h>
> >   #include <linux/types.h>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied for v7.4.

- Arnaldo
