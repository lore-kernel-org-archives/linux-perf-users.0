Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133548;
	b=kWoOtiCqKLrZ+RP6YgFiYZ62rDFHU2heFGIZUg453ugY2Abd2oZxFmB8zN1kyOeTOSju
	 reoBdLnNUa7vcyttKwEdU/av863bQsK+TLsGP4hygQCGXLEMCCwuqjZoOqQOWXCkBUccj
	 ioY3Ozew/FEan+Yx2OILDmgUONQOYWHiO3T/IN8RhnWelsJpmDVYY2irlH83Z8W0OPrAF
	 YKlGB5Ojd9DdVzwujSF/pBlhocqwSLR8glecFgeUxyBafbEFFrcZBbR+U5p90zLbA2y4w
	 bDHi1BTf3bMz3zrDprywIPtPN152rPly0yzB9b6EVGPc0lA8yzYW3sMa2FXCJkE8juA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133548;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2mtsi7v8sG4XVP3B48E4lpS3lIjEkDF1OCHXEwO0g2Y=;
	b=v6QwvjGpfiDsMX2jERSbrIY2x9925J3oPTj/9wo7uXnDlr54hgJTsbNAK+hZm0vaIoq7
	 6VuB+Qv3t/+tkF/YFZSpXkGQqGHxVe2yKjywaU1C2iPqJUjBk2nOmTKjH7YY8m6Znggmz
	 mavx1LBNfvDI9dVpw38g+CJXmoeupfSs3xeGA5iSNyV4HH/RUurZ1jyQ6YAZtsVZqZnop
	 1fr495tIkYHFxa9Lo7oR3rxZcKuJDQzecWx79OnoonDXfI+dxwAbysUDEkBHsP6J4phMH
	 CWncEh2xf4usRLqevpx9dMNUn9jl18uUC45ncY9TR2SInTehr9WNkkE3mBMuPLSRX0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZtlBiy5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA2606A329;
	Tue, 27 Oct 2026 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZtlBiy5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9AB1F01825;
	Tue, 27 Oct 2026 20:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133547;
	bh=2mtsi7v8sG4XVP3B48E4lpS3lIjEkDF1OCHXEwO0g2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LZtlBiy5tJBEOWpzZw3R3uUtrnbNGtjPLxWuKn1fvnUB+uqJDrXO342Aju5jmeI9B
	 y3GsFpopHYXAwN5vJrycbYAFcXypqc7SYKYSF21llYhy6Ph0k75KSiaV727h5RZsbs
	 H7pjp/qXxBjZbKBMbKY9pr1Y6Wj3iAznRqkOd+/qqMSKyGKngEN3jsHJ0yxGnuGpC7
	 m4Wa/9cMEscuhivjKxJvOT8l+TJpi9zEbbym0VqhzCTuDOvhed6JpQf9fvuQmQZQBq
	 fxuJFZZnvXIIIpsHbYyVsxg07uUGD6cqnlTqM8RRKdFoIm1tPZsLv4WosrSU+/oFdG
	 jxy3FQSSisi2A==
Date: Tue, 27 Oct 2026 17:39:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Faisal Bukhari <faisalbukhari523@gmail.com>,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf parse-events: Include errno.h before kernel headers
Message-ID: <auEL6cB9ftd4CoHn@phoenix2>
References: <20261026174814.3158229-1-florian.fainelli@broadcom.com>
 <440f4ac1-28a3-42a1-a030-7a47b04c0d14@linaro.org>
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
In-Reply-To: <440f4ac1-28a3-42a1-a030-7a47b04c0d14@linaro.org>

On Mon, Oct 26, 2026 at 06:25:19PM +0000, James Clark wrote:
> On 26/10/2026 17:48, Florian Fainelli wrote:
> But maybe it's just as hacky as this fix.
 
> Either way:
 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied for v7.4.

- Arnaldo
