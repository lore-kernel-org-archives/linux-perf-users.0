Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715973;
	b=Oj5Xbg+KUlxHZYUadvPolfNPGeZ75tMk2c7zAil+/aa449BIwVpRN6mFf+KnsxE3SP11
	 JbGS+GJKSbbJdCc2Zx5LerhrlmA5hfMCl/8MKhahLlWZERrvJm72ZXKVcFXtd1eBWgs86
	 0XPx3C7mgMhadKDhOgBlkBfZNbozpnxPgUcip6PupgUNvAT3xvHO9fs1Kk9FwcoBVKuN3
	 Upzv45ajXAQif98edw9ZZkS8/Nag2d1ltuqCfsEr4n+G/Hz6SmiEFotIXqLU5LnghchhF
	 8ZdNGN3k1YOhHvH3d1fzNeHUs91TzSdeXbzafMW685N1NKHqGBj7WeVXhyM/TDFwYTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715973;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=1YuiQpKv+xN1RPeOKtn7jz8amSmr5IUC14yWKE/UR/s=;
	b=iXF6Ssq3eap9HCmNuCcaf19JHhm+WGdKmoAEfW1UWspdMbHJVP5DCIhKZ523eysR0RmZ
	 p8AUTSudhaq5jVoNw55TT/TvKbz4Tdc6mRy26x+IY4LI921FJdyxTQN5Vv6X6Af6ZX3r1
	 zsLLtZbIxHR0XVFQDHSVkOuj+P8VhDLYLyeKd2eEar959+28a6Vsnj4cTvjHB1wxS/JyK
	 K9Z1E+7NRj6c8tm50/4Si6alb4qZpNK6pxD+BaonRAfuKcAuY5RSkAq0uit4a5+ZvKjWW
	 X2fgguwLFp8ZroNx4h/sJXjlPNaCGzu5xyWlSCfPf1oF89AYOSyD77qUOsfNxiNa8/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiSYfDQ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C0606A89A;
	Sun, 15 Nov 2026 04:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiSYfDQ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F311F000C5;
	Sun, 15 Nov 2026 04:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715973;
	bh=1YuiQpKv+xN1RPeOKtn7jz8amSmr5IUC14yWKE/UR/s=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=ZiSYfDQ8qKacbqrOlA7FOzPX7zYBb60o3LX+ZoRxMWmwinDKbhci1mv2ofyDhXqYf
	 gTZBl6UjVbWYltO/IKpU5Pf6dXvCPgVtChLG1O2qdjuJV8lGq+Acw4tICn6HjHAG5j
	 id/DgvVEMVVp0jzJu9TJ57KhVgH2TaL/S+S23P/twgiZiH35rbg5TP2yMXlgk0VlMp
	 mNZn58vzyGV05cSq7/7x8+4cAMGXxmYXMM/k8JFs7eAY9WwUspbimF7aZd2NZcSuru
	 7Ci5o+g5K/X7ukUuYqS5NVQvVlWm+7aHNFwNu3GUb5ufRDMXmZlnSXsiKWShJZiMSR
	 ZT1LoJxtmDHjg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20261025215056.1228120-1-irogers@google.com>
References: <20261025215056.1228120-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test switch-tracking: Fix hybrid cpu-cycles
 and spin timing
Message-Id: <179471597100.616307.9253802173471931122.b4-ty@b4>
Date: Sat, 14 Nov 2026 20:12:51 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sun, 25 Oct 2026 14:50:56 -0700, Ian Rogers wrote:
> On hybrid systems, parse_event(evlist, "cpu-cycles:u") creates multiple
> evsels (e.g. cpu_atom/cpu-cycles/ and cpu_core/cpu-cycles/), but
> test__switch_tracking() only configured, enabled/disabled, and checked
> evlist__last(evlist). If the test process ran on another core PMU during
> one of the spin phases, the tracked evsel recorded no samples and the
> test failed with 'Missing cycles events'. Additionally, the other core
> PMU evsels did not have PERF_SAMPLE_TIME set, which add_event() missed
> because __evsel__parse_sample() initializes sample.time to -1ULL rather
> than 0.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


