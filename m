Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855561;
	b=of+q2251YrTsJ5cAz1OLuo4sVdkoBYhN1s9Z49dALmcdCC1Y1uJjayNRr3Jqad/ayYuf
	 VB9+Llq0baMEUkdPZxDFzWPEfL+BI8RyfrMbCMoT939RlIKweZj6XNYhu7l7bGmu8i3SS
	 hT6Grag5kHDUgcHaSLvkfhJWCS0TrharGsb78IcudjOB6/hRXqe7wtjbMT5QjSSSZ2CIJ
	 0uPcKu4CYEOBDQXACqBl7sLgBUWSo9SZUS6FuT8KU5eLlm9HekPKMot8RuiYPzqlusebx
	 13QVTpczx/zGi9y6O8ZqaOBYwL2VbnsfTBe/3VeL83A79js+VHjMi3y3x6bJXahXpqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855561;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zBipnjUh+a03qSX7TJO5K5pogIYLCb0BKkuRilRGRYs=;
	b=NGCvRzz1Y6sXfV/VZgX/V9wm0fRoUZgJ6gvMEcCBtJSWSv8FDGYT4dEiGnzP3eIFiZMS
	 lU9k5WXLBJGcZ1p22FYtFkfjNMoOZrfBVd6Cr9oC/cHPYcT2PG0wWoHNN7AIac5xnYBKS
	 VhFOnsPZgqT79P7hj3CzeVYDFMRV+D5+q3I4AtqcErlUqvYoeao+jopRbyATmbo5ijlET
	 4HUkXEBoaxjWSbpWHhAFK2tf9Sz41Jfi9KoU1y6x2OkZxBqVd98x/5wmhxNlGpQCB6HNP
	 Q/ann75zA2fz28DX4g4/uiupNBjNYV8yTO1px65BBWKX1Afkyq8iqG7M7Pmzyad27Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Smne0HCg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94EB606A326;
	Thu,  5 Nov 2026 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Smne0HCg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EF91F00A16;
	Thu,  5 Nov 2026 05:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793855560;
	bh=zBipnjUh+a03qSX7TJO5K5pogIYLCb0BKkuRilRGRYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Smne0HCgAqesY+t/84icmhLBt777b+deNKzsSVpzA60bZV9qobodiiv/0aEVbIYAc
	 uHXTlcR05C3MYopEFR3rXZt3d428/98iCto7vd3+X1RFdGLpnu1cvqH8H2kFfvYZaz
	 gX1xtpjqujCh6HCUSfWXVK38sSix0WdZbrJnElVS8dEvHb2qx40xQYa3LlAGEiRbSv
	 6RfSUChJY5Kk6vIVBxtP9Je7nRP8Ono665gkhOzMnV8fZ9HkNaANej0W9JC6J+jhj/
	 NMMvUkeqmNf9cbH81Xv2zq5ESwuRhLKL3Jv3DMw95+YwqRn4cX66lSgnz2VXlsLRkw
	 wETgGAEotUlOA==
Date: Wed, 4 Nov 2026 21:12:38 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf: support zstd-compressed kernel modules
Message-ID: <auwQRrlxzuTg4dDN@z2>
References: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>

Hello,

On Wed, Oct 14, 2026 at 08:34:06PM +0300, Ivan Shapovalov wrote:
> This extends in-perf zstd code to add an interface for streaming
> decompression of an entire file, and uses that interface in dso.c to
> support handling of zstd-compressed DSOs (e.g., zstd-compressed kernel
> modules, as shipped by various distros including Arch).

Can you please address comments from Sashiko and the bot?

Thanks,
Namhyung

> 
> Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
> ---
> Ivan Shapovalov (4):
>       perf: zstd: zstd_decompress_stream -> zstd_decompress_buffer
>       perf: zstd: factor out zstd_init_{c,d}stream()
>       perf: zstd: add streaming decompression and format probe functions
>       perf: support zstd-compressed kernel modules
> 
>  tools/perf/Makefile.config |   2 +-
>  tools/perf/util/compress.h |  22 +++++-
>  tools/perf/util/dso.c      |   5 +-
>  tools/perf/util/tool.c     |   2 +-
>  tools/perf/util/zstd.c     | 188 +++++++++++++++++++++++++++++++++++++--------
>  5 files changed, 183 insertions(+), 36 deletions(-)
> ---
> base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
> change-id: 20261014-perf-zstd-279017105eb3
> 
> Best regards,
> --  
> Ivan Shapovalov <intelfx@intelfx.name>
> 
