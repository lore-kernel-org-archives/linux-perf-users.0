Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BCD14B950;
	Mon, 20 Jul 2026 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784522661; cv=none; b=ufIMGxEaEx/qKWZfnNPZohokzO3oMntMZ+5qqgRG7J0Jl43c79CZJIUM9UqvR5+RVLD7pHRcpTZW+YVYXvgRkr4ZXjj5v2rh3wAvzYm4ituNnpC6yzNk1yjjFoosb8NRmnSvbuJwIjgoNzSifEl8u8pRdJvRw0OV2oxEtRdSl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784522661; c=relaxed/simple;
	bh=3Glh5ojivcvqKMydjB6etvVbr1AgmhFP7jwcNCTL7yw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u1bIq4HU3uy+xoQ3rC/hj9MjDs0m/2VWDp47re9PMU50sE+h8gZCAKE/1ABkMJ61gvq6r0OY7qOIyfHW5xEU7AIu9oyD3VotNPYzKkaWD2aN7Us0NJwfNRLlyEg6ioAL6d/J+jDdWs0qNDpM+I7FNCAtzA22PuwLazC2yGk4uTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMiEfAvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMiEfAvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED191F000E9;
	Mon, 20 Jul 2026 04:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784522660;
	bh=8pfwsQmLsrsJczYjEO08XcpimJa/kae9gFKJVM8JDws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fMiEfAvjM9Dc3XX3FTPn3hdf1rHdw6VkmGadYOQmsLmi0kBk4M5KkoObtCi551cBy
	 c93YUHg3Lkaltd3F/x7OlH68btMpvUwLBpbCTu/+e/6YG3ZyvnYXgCxvGpVKRrA96k
	 kGK4taaLuS+Y7XAxBLdV3OSBFm3Kn/LX4O2OsAJWg1EK0zmy8jfmvEYXiYM8EX9Stj
	 QpeuCxwpX8B2z1qYL6qDFvfs3E54gfu4WimqiwfMNHWrEfurM0sKxFITolK1ahGL4Z
	 FijESkpt6IP4KkJf+lAakI9xqT6u4NWkO+cSbsOHzS4qSKR/BNSZ6w0JjYPthznxIp
	 ooxJW8RJ+m4vg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260706234836.815254-1-namhyung@kernel.org>
References: <20260706234836.815254-1-namhyung@kernel.org>
Subject: Re: [PATCH v2] perf build: Fix compiler errors with old capstone
Message-Id: <178452266033.1975204.3526412179442806410.b4-ty@kernel.org>
Date: Sun, 19 Jul 2026 21:44:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 06 Jul 2026 16:48:35 -0700, Namhyung Kim wrote:
> It seems RISCV was added in capstone version 5 (released Jul 2023).
> Unfortunately they are enum constants so cannot check with #ifdef but
> anyway we can define the symbols.  Let's do it using the version
> number to avoid build errors.  It'll fail at runtime though.
> 
>   util/capstone.c: In function 'e_machine_to_capstone':
>   util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function);
>                                   did you mean 'CS_ARCH_SYSZ'?
>     186 |                 *arch = CS_ARCH_RISCV;
>         |                         ^~~~~~~~~~~~~
>         |                         CS_ARCH_SYSZ
>   util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


