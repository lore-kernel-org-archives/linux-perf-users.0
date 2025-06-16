Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD929AAF4;
	Mon, 16 Jun 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069793; cv=none; b=FRJG8i2UCuXHMDknrp9st2GWYDDjXYGyMTYzU/okmvswrX7dKXAu4ilduWc8otTYduJAw4xGvMCF54ScQCZhLMgPcZLz6vGOuMkbp3wyWTbxOj5IaniGz2qh28X76scjIOvUCC65qrH1eRQcPTuvEIIO9i4CkpR5v3PwBkj/MmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069793; c=relaxed/simple;
	bh=qCjn4b3dsxaZ0m4CPz/s3LvG4e9wRnwEuVYtfzCD6X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQopjN9KBNvsYAmkQBkcR+VaRHNRfGSeqD8BceNsZzRqfnxzdRerBqFesh8+8zD89Tio1LQCsW9oSYbIc0J7sOXW3hc5jplAZ7PrRJ1JSCccet+cU7CWK+c5drUVCCgz99Oki7IwGBVNk8BpD4QADdIEE8xkafmECG8QBMl76hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjMUBDw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjMUBDw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C15CC4CEEA;
	Mon, 16 Jun 2025 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750069792;
	bh=qCjn4b3dsxaZ0m4CPz/s3LvG4e9wRnwEuVYtfzCD6X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjMUBDw+/Ua2rbyhJ54OcZlayTfHW5nD/Vam8begoOIVspIuvQJ/613VosV+A9Tac
	 WmtrssHkU1lDpRU3M3Y/ORM5fAObZ+0g6Pz/dIBH59L9G8PGAqC4rCMkxx4Ku+BA5J
	 EtPvpkDnhEWzRcIaqrrW503SyWf+84eLrIHP6yvVbFGJZp9udfRNSX3jOSmJm7sy04
	 K4V4c1p6LxNnI0leyQqrZqPi4Z6sZ0MnrrkPZb+i0vJA2noWvfayvLK+Haa8sAwSHI
	 impnIP+dCQkSbCOIg0NuPpa9DtiCJDIMVtc6Us32PMfVhs9fVwJfpJ93dBZe9Ne/pB
	 gI60azjGBU7aA==
Date: Mon, 16 Jun 2025 11:29:45 +0100
From: Will Deacon <will@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Nick Chan <towinchenmi@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>,
	Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v7 00/21] drivers/perf: apple_m1: Add Apple
 A7-A11, T2 SoC support
Message-ID: <20250616102945.GA17431@willie-the-truck>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <CAP-5=fXSwgxMc+uh=PBAFh4Zm96tL5RDyKPOJ8Q40O4s=EaArA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXSwgxMc+uh=PBAFh4Zm96tL5RDyKPOJ8Q40O4s=EaArA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jun 16, 2025 at 02:36:18AM -0700, Ian Rogers wrote:
> On Sun, Jun 15, 2025 at 6:32 PM Nick Chan <towinchenmi@gmail.com> wrote:
> >
> > This series adds support for the CPU PMU in the older Apple A7-A11, T2
> > SoCs. These PMUs may have a different event layout, less counters, or
> > deliver their interrupts via IRQ instead of a FIQ. Since some of those
> > older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
> > be enabled by the driver where applicable.
> >
> > Patch 1 adds the DT bindings.
> > Patch 2-7 prepares the driver to allow adding support for those
> > older SoCs.
> > Patch 8-12 adds support for the older SoCs.
> > Patch 13-21 are the DT changes.
> >
> > Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> 
> Hi Nick,
> 
> This is substantial work and it looks good to me. Do you know why
> there's been little progress on landing these patches? Buggy Apple ARM
> PMU support in the kernel has led to reworking the perf tool. It seems
> best that we can have the best drivers possible.

You reworked the perf tool to support these things? Why? These changes
are targetting chips in old iPhones afaict (as opposed to "Apple Silicon").
I think that (a) most people don't particularly care about them and (b)
they're not fully supported _anyway_ because of crazy stuff like [1].

Will

[1] https://lore.kernel.org/r/20240909091425.16258-1-towinchenmi@gmail.com
