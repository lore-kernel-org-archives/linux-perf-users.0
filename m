Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795568192;
	b=a8JKEX/aYD8U76iHv3dy7WQvf3VJ2JvEKfvYGO0KNqOwyWuovyEtBOx5CrlfcQL9zVvm
	 kOWNp6Oo9cMw+12NBfQYkaMPsA6pJjaZuFHR221+IAI0TxOcrYESav4fhtmTaXwPKILuZ
	 V0VzMjPML0FLIhf3b/Y8fPXUHjisTogjwExgBVKG98fxwugcxW08lgFGBP0J1uFoQteot
	 OeD9p/0hx0J3Lm5bw6awGW9Zn3MQuKl2djJFY3cZmxPZB7C/3k1FBicFZiDNijmJuNnlm
	 1oLeYvEg1GvRToPkyPU6W+KyD2X2vZ4bY5HcmFyIjZ4vXb2ycqKq1RPRVPyN44BcYYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795568192;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Hc0h9khN0wdquEvDB59Dx9r7wT6/QzO2Usuek1GHLTc=;
	b=oR5ph56CZOOLqWvXtTR7MN2gDNRZY9Ws/WNOG+yxej/Bf3pP6p8F/vhj1ABz07KOEAJF
	 66OTAJgZOn/578s0Rpqej2rnSkvH9YbhnwZWFaZY2bacTMOfeBaY8zSGuiyApJtw1HZtr
	 RKy6EgUf0cLVDriROzGBIRiEkt2SarQlVUrrB3uOvvMKHpW07ihaG663gU27iGGvpRndz
	 ZpkZKWzB6u5WNWn7uCrU5V42pp+RDU6hOsPOIgcI8bgQMu95Hdx5qQAJu7e8epLOdgVM5
	 O/mAt/LBNhmclT1Qw/l+rlvGIOoW1fOXA1pGocdv1Bmp/R+KjANgMMiok1Eggd0LGOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lG6VIqBJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55036606A321;
	Wed, 25 Nov 2026 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lG6VIqBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425091F000CA;
	Wed, 25 Nov 2026 00:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795568191;
	bh=Hc0h9khN0wdquEvDB59Dx9r7wT6/QzO2Usuek1GHLTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lG6VIqBJlM6+eMYB/4ldEnVFOi8G4SyxERRPYIbJfYlBHUjMPifnTmxkffcFkQnNQ
	 kv7eDVfSstk3pSI06YbavzOVdgyKNJq5XfUbxx3CqbutQisgb3mWwOdemVFoRgZbt2
	 6J2BwlFh/9Ygl4mF9C00K9oepLMO/jUsW/4tJpMVWOplDcltzhJ4f4B/JKmcFaRaC5
	 72zh9n3fV0TJHwgNh1gy0ylk0APhnAP7LAu6G45jzum2lEtE9vxcy2qmX/arCYuDl0
	 Xco+EtC9sHd12rOtv93+6EQ0/+85PWPyrV3f/8x0yTndZaqzKV5oQbEh+I03VFQ9Ie
	 EM9mgWhgWT+Xg==
Date: Tue, 24 Nov 2026 16:56:29 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v12 19/19] perf scripts: Add a coverage table
Message-ID: <awYyPRudKyzS5lUF@google.com>
References: <20261123220024.14891-1-acme@kernel.org>
 <20261123220024.14891-20-acme@kernel.org>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261123220024.14891-20-acme@kernel.org>

On Mon, Nov 23, 2026 at 07:00:24PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Render the report of the last coverage run as a table of the files with
> the most uncovered lines, biggest gap first; --all lists every file and
> -f picks files explicitly, failing when a requested file has no coverage
> data.  coverage.sh prints the table when a run finishes; it is also wired
> as 'make -C tools/perf coverage-table', to print just the table.  It only
> reads coverage.sh's report.txt, so the measurement and the table are
> reviewed and changed separately.
> 
> For example, with --top 4 on a full test suite run:
> 
>     $ make -C tools/perf coverage-table O=/tmp/build/coverage \
>           COVERAGE_ARGS="--top 4"
>     tools/perf (no tests/ or bench/), 100+ executable lines:
>     the 4 biggest uncovered gaps, start here when adding coverage tests.
>     --all for every file: make -C tools/perf coverage-table O=/tmp/build/coverage COVERAGE_ARGS="--all"
> 
>     ┌──────────────────────────────────────────┬────────┬────────┬────────┬─────────────────────────────┬─────────────┬──────────┐
>     │ File                                     │  Lines │    Hit │   Miss │        Line Coverage        │       Funcs │  FuncCov │
>     ├──────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
>     │ util/intel-pt.c                          │   3237 │      0 │   3237 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/142   │    0.00% │
>     │ util/intel-pt-decoder/intel-pt-decoder.c │   3208 │      0 │   3208 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/119   │    0.00% │
>     │ ui/browsers/hists.c                      │   2742 │      0 │   2742 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/124   │    0.00% │
>     │ builtin-sched.c                          │   3737 │   1543 │   2194 │ ████████░░░░░░░░░░░░  41.3% │    62/141   │   43.97% │
>     ├──────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
>     │ TOTAL (perf)                             │ 174097 │  86374 │  87723 │ █████████░░░░░░░░░░░  49.6% │  5650/9358  │   60.38% │
>     └──────────────────────────────────────────┴────────┴────────┴────────┴─────────────────────────────┴─────────────┴──────────┘

Maybe you can use similar format both for line and function coverage
data.

| File               |       Lines | Coverage     |     Funcs | Coverage     |
| util/intel-pt.c    |      0/3237 | ##      0.0% |     0/142 | ###     0.0% |
| ...

Thanks,
Namhyung

> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
