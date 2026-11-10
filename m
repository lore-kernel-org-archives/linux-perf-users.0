Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279144;
	b=cWZLK8XXfKaIVNym1RQC/kfkdNkwEAU+HjJyHIR/j2VvVNoIGjrP+l1xoz7QVSyJDuI/
	 S91zvH1qd8DZl44R2viVsBFgKoyvpl28ic7y77wOYCZYfjPkZXJoj87/2RF0jwnTcegQu
	 aJwCIozNbjRT8xaxpI6ooMIfx1gRJzNFdhEqwWb9H0d0UDPzLpV0Xxn+P7w50bbV7CTgN
	 w+6YwgMVGO+85e5nwTpzJGlQwcKbHknzWKha5zeGnwBx8VvNme9iv5bNYozj3hkWXhOvb
	 RI8d5ISSPHbetCoVwDVhBZ5sil8xPmwHNKTEVlHqWsGyZwMrRba9Uta4ZO5qOZsID6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279144;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=F8p40prgOjcf7Cr1A1mpKzFS1rOkrh+mPMiwVxEyQMM=;
	b=zyEbJg33sy+kn7u20IlzeQAGCYfRoQeuN1+tuDsi96kB6YIfl61RmHCoC9woHY6HjjTr
	 zp/rkmLt0O9PEEgPHIJncmHx/mbROFKZwEeoyQpuVteHMS+UgJvKdpPQoCs+bDZO2im1C
	 nq/aUy8hbIGrkke06tRI6y9uyA9rJpI5qbdxxF7t4JGauxJFutc48KpZ4pEQ2X2zwTuxY
	 5fBgOJO+tqA07DHIHW3UfX6mf30uBgjNHs0P79/5+XVeMjq8eVTK9nZkwCnSLp5YT7eDr
	 uvxbNQwoNgEOgJ/uPX0V35GBteJ8pi7H7gopvchWNQTtcUU4vhC35NJ84O5slIZbaww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7YIehtK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519C606A33E;
	Tue, 10 Nov 2026 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7YIehtK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6441F008A3;
	Tue, 10 Nov 2026 02:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279143;
	bh=F8p40prgOjcf7Cr1A1mpKzFS1rOkrh+mPMiwVxEyQMM=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=K7YIehtKQL2guZyN7Sv/egLXJykqXGmM6XxvBpRJ4meC+lvngPWyXhWTW1yDI3vXp
	 3WahClvB2ESzp5sSKwXcgVd6DZh9+HDMgtk+ovlPt+fGcttU+9JKlCPIi07+3grfuz
	 PbTFFFR7JqKyuUAo9fDAk1pvBwmeC8fwWv1CYnrF+FXOepc2UvMgrqyLNkFiJEiotw
	 w81ORjAhJ5vTDLIgKEUV3y0ZKkZ4LQD0mf7SE9uTtz9y6TARDZCU4Q92TvOZXZ2H16
	 /93SDgBGmsyQZPhfN6vFp7qAHWmmaeVuisITd1eboNKesbxdAUyIhEWlwIukC2byDL
	 W2vdDvfGfzYSg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Alexander Antonov <alexander.antonov@linux.intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lirongqing <lirongqing@baidu.com>
In-Reply-To: <20261106022027.2413-1-lirongqing@baidu.com>
References: <20261106022027.2413-1-lirongqing@baidu.com>
Subject: Re: [PATCH] perf iostat: Reject incomplete and out-of-range port
 strings
Message-Id: <179427914333.13444.13334589119500754663.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 18:52:23 -0800
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
X-Mailer: b4 0.14.3

On Fri, 06 Nov 2026 10:20:27 +0800, lirongqing wrote:

> The root port regular expression accepts trailing characters and an
> unbounded domain field. A nine-digit domain matches it but makes the
> subsequent width-limited sscanf() stop before the bus. The parser still
> returns success, allowing the filter to use an uninitialized or stale
> bus value. A three-digit bus is silently truncated as well.
> 
> Match the complete notation within the documented domain and bus widths.
> Check regular expression compilation and propagate conversion failures
> instead of treating a warning as successful parsing.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

