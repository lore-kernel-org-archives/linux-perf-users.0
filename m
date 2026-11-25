Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631895;
	b=YiXuZyqlD4G4F6Eg/PfMxEtjiWHMgwRmd3Drbl5BZtHHmosWWQlzx1v7Usj1dDfEl4jH
	 X1obYaLE7xuEKVHNM0TuK9+XyVQMebhy9p0qVbw9wS6kEKGoKr70VEaCv5/ljSBoD1koy
	 IkjQ8s5vfXT5uxakgk0Bq9gplP1rTV/H+GgBhWxTWqJsZAwj9QEwJXDZkC31RQrIAMeD2
	 j3r2x7gJ0AZtjyb8eahUJbnjwrgoktnZc/+Js1ggtcxsVGVUOOCP7CV6AlJmXXUvX+oFQ
	 M2giZlCh6EpUUhtE5NLDDUBvrLP/zzVBSC1I2GgeU5FETbCzfyqSnvp+gWizi/WLhbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631895;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=LBXfaNtpxMx3TkkX4gfbHV0iMPOegU1w1tIaTd7J1dE=;
	b=jxPy0Q/VvG2PTTLDc2itgvdpbAy5kd2uWN0WgR7+G9IzWUR2ngokeLanaK99d+R5o8R9
	 MbD3sjSLEUj/T1B/aLAJcW/Nk5uAXcr8oDJfGRqspEPmnQsXBALC//mXufB9TPitvf/iD
	 1WxRqdE6mRJ8I+UM95KEdBp9TcKLrfexg+di9rGclDkXZZPHltIV6jjW/dSSLeNuNQSF9
	 ReMNI8H95+kHrWNZz1E/VErS94FF15lhcgN8F4xB5sEkhiq62DsAU3WjjO2GPlT5Hu2Sn
	 y55fv5zycHZBgp8IM2o83PJ/RBQjzJwOBsvcsyucBgmEtUAs4nJYTBc2thN2kwQT87w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUUP65x9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8C606A329;
	Wed, 25 Nov 2026 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUUP65x9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922D61F000C0;
	Wed, 25 Nov 2026 18:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631895;
	bh=LBXfaNtpxMx3TkkX4gfbHV0iMPOegU1w1tIaTd7J1dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YUUP65x974U8Qt7ijSvC0EL+AddB/NBrvM4wk4AowrpLEVk1ctJMIMcgFCfmR5CgP
	 vRyHK/nrkRrQr3wrtBCisKd3RNrsZwbiFlMVvE9N9vTrlOarLbBM2YDl0WkUZGIFTJ
	 9osB6/+ZUwFM3nnDXayQQH92kro9cNSFAe5VMGh8R7flsDL8fU3TJkeKQn38qwj+ZD
	 BUyoxUN9na4/OWNGzEOxyrVKCUSHNFs8czkYkbtnKamDNCxWhOwr0hFOMcj1yuSmvh
	 ND3oQiQ5ekH+MBMnwsfePGt7uLTDURj9kFZ4aMNZiuradPZ6RxCXZfnr74Onfx0I+Q
	 sL/ITheczVthw==
Date: Wed, 25 Nov 2026 15:38:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v12 19/19] perf scripts: Add a coverage table
Message-ID: <awcrE211m2HtJy4h@phoenix2>
References: <20261123220024.14891-1-acme@kernel.org>
 <20261123220024.14891-20-acme@kernel.org>
 <awYyPRudKyzS5lUF@google.com>
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
In-Reply-To: <awYyPRudKyzS5lUF@google.com>

On Tue, Nov 24, 2026 at 04:56:29PM -0800, Namhyung Kim wrote:
> On Mon, Nov 23, 2026 at 07:00:24PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Render the report of the last coverage run as a table of the files with
> > the most uncovered lines, biggest gap first; --all lists every file and
> > -f picks files explicitly, failing when a requested file has no coverage
> > data.  coverage.sh prints the table when a run finishes; it is also wired
> > as 'make -C tools/perf coverage-table', to print just the table.  It only
> > reads coverage.sh's report.txt, so the measurement and the table are
> > reviewed and changed separately.
> > 
> > For example, with --top 4 on a full test suite run:
> > 
> >     $ make -C tools/perf coverage-table O=/tmp/build/coverage \
> >           COVERAGE_ARGS="--top 4"
> >     tools/perf (no tests/ or bench/), 100+ executable lines:
> >     the 4 biggest uncovered gaps, start here when adding coverage tests.
> >     --all for every file: make -C tools/perf coverage-table O=/tmp/build/coverage COVERAGE_ARGS="--all"
> > 
> >     ┌──────────────────────────────────────────┬────────┬────────┬────────┬─────────────────────────────┬─────────────┬──────────┐
> >     │ File                                     │  Lines │    Hit │   Miss │        Line Coverage        │       Funcs │  FuncCov │
> >     ├──────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
> >     │ util/intel-pt.c                          │   3237 │      0 │   3237 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/142   │    0.00% │
> >     │ util/intel-pt-decoder/intel-pt-decoder.c │   3208 │      0 │   3208 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/119   │    0.00% │
> >     │ ui/browsers/hists.c                      │   2742 │      0 │   2742 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/124   │    0.00% │
> >     │ builtin-sched.c                          │   3737 │   1543 │   2194 │ ████████░░░░░░░░░░░░  41.3% │    62/141   │   43.97% │
> >     ├──────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
> >     │ TOTAL (perf)                             │ 174097 │  86374 │  87723 │ █████████░░░░░░░░░░░  49.6% │  5650/9358  │   60.38% │
> >     └──────────────────────────────────────────┴────────┴────────┴────────┴─────────────────────────────┴─────────────┴──────────┘
> 
> Maybe you can use similar format both for line and function coverage
> data.

Like this?

⬢ [acme@toolbx perf-tools-next]$ bash tools/perf/scripts/coverage-table.sh --cov-dir=/tmp/opencode/cov-more-cov --top 4
tools/perf (no tests/ or bench/), 100+ executable lines:
the 4 biggest uncovered gaps, start here when adding coverage tests.
--all for every file: make -C tools/perf coverage-table COVERAGE_ARGS="--cov-dir /tmp/opencode/cov-more-cov --all"

┌──────────────────────────────────────────┬───────────────┬───────────────────────────┬───────────────┬───────────────────────────┐
│ File                                     │         Lines │         Coverage          │         Funcs │         Coverage          │
├──────────────────────────────────────────┼───────────────┼───────────────────────────┼───────────────┼───────────────────────────┤
│ builtin-trace.c                          │      155/3661 │ ░░░░░░░░░░░░░░░░░░   4.2% │         1/198 │ ░░░░░░░░░░░░░░░░░░   0.5% │
│ util/intel-pt.c                          │        0/3237 │ ░░░░░░░░░░░░░░░░░░   0.0% │         0/142 │ ░░░░░░░░░░░░░░░░░░   0.0% │
│ util/intel-pt-decoder/intel-pt-decoder.c │        0/3208 │ ░░░░░░░░░░░░░░░░░░   0.0% │         0/119 │ ░░░░░░░░░░░░░░░░░░   0.0% │
│ builtin-sched.c                          │      737/3737 │ ███░░░░░░░░░░░░░░░  19.7% │        16/141 │ ██░░░░░░░░░░░░░░░░  11.4% │
├──────────────────────────────────────────┼───────────────┼───────────────────────────┼───────────────┼───────────────────────────┤
│ TOTAL (perf)                             │  75546/174407 │ ███████░░░░░░░░░░░  43.3% │     5044/9362 │ █████████░░░░░░░░░  53.9% │
└──────────────────────────────────────────┴───────────────┴───────────────────────────┴───────────────┴───────────────────────────┘
⬢ [acme@toolbx perf-tools-next]$

?

- Arnaldo

> | File               |       Lines | Coverage     |     Funcs | Coverage     |
> | util/intel-pt.c    |      0/3237 | ##      0.0% |     0/142 | ###     0.0% |
> | ...
> 
> Thanks,
> Namhyung
> 
> > 
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
