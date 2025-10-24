Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB234C147
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332234; cv=none; b=VZCaCwjtihMPGr1uSifZh82PCuDWf/mwXjiJ+UOTHF8cCA0SwNKETQvo1kKTsgcfBP4518pASWzI488auUxm8+92HpQm2MyVqCpibXukwgUkfIPmz0/65Yeo1MFCYMUW0/O19apm9JYH0UaShizo1Gfambbs0fly1XpJ0WUjCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332234; c=relaxed/simple;
	bh=F6sAvOGHNl4pLZVKMsc1wcVztQ8yBEOvaYtnPjPeRCA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MvlnHV/1XRci6skMC9fcdCiRDKRUKSUcOU8oZtEsQ7p2GUb95whNu5DtiFFarBHNyzAogiiNlmWjJR2Uy4N+ogdg9xSJC0KrSKQtjiBlBGXdcSnXLyOIyXB3CzD6pkvkIXzhK4srNea+V0649jMc6wK94sxFq3hryqEFsLZYQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXeYOark; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXeYOark"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE61C4CEF7;
	Fri, 24 Oct 2025 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761332231;
	bh=F6sAvOGHNl4pLZVKMsc1wcVztQ8yBEOvaYtnPjPeRCA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=XXeYOarkIdMzTofm5V401CY0ZT+c+I2DajCJRNOsDOm/nMqTBDB2T6EgDePxNSPYs
	 cQO+//UCkwZ1MbT/0qdOLGvLCfjTZwQNWNZTyUfFK4oaqyvJ7tWTCf8o0v2DEX32H5
	 8FfEJWt5A3oxAiJxCaTf2IQC0j9Cinb88CYdYOEp8XjK71pUXX3mbBZ/HoFTIqRHP2
	 olNQkHmse/hoOcmhxNNDnM0o+9Hy90T29I+EXX/1QBWTtxCbnMKIJxJtOSaPQAAJvq
	 Fk98zjhGFInRv9KbLKdYslWicA/dqSyF3VsMGjnWaHcvOygbo3MzBbC44UnilGw1FA
	 Rm8YovR5Whlsw==
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, 
 Leo Yan <leo.yan@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877bwnyh6f.wl-kuninori.morimoto.gx@renesas.com>
References: <877bwnyh6f.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [resend][PATCH] tools: arm64: Add Cortex-A720AE definitions
Message-Id: <176133223085.3710582.9720560648208610370.b4-ty@kernel.org>
Date: Fri, 24 Oct 2025 11:57:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 21 Oct 2025 23:21:48 +0000, Kuninori Morimoto wrote:
> Add cputype definitions for Cortex-A720AE. These will be used for errata
> detection in subsequent patches.
> 
> These values can be found in the Cortex-A720AE TRM:
> 
> https://developer.arm.com/documentation/102828/0001/
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


