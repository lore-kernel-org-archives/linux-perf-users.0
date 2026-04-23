Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AD8F49
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917905; cv=none; b=iq1/dfj95m10s4NSTSCDcFa/I+US0v48lUUYkRbbpJ85NafLazAT28fnubkUom3Sr2/0Y3vIEVb7UqPAkZh9MVPpxF+R5D0HiCD5Lr0voDSq+hdI/l9XeuDjeqgBsnV6r+xmA+zvUF/MaIVeLnPnXH0hmXbCwLpYlOMs03mAXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917905; c=relaxed/simple;
	bh=/PGzGvrhTyv/K/7bPPZQe8nYO+aq6VGIJEyFKJqC0o4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hOCw0qZHnl/JW8yjv1E+m3NZInrh+jF9Z8Knnm10C2Bm1PO/yL17p08AZyn7eChPa3b9GSWEsFkc5iILt+m/0D1MdV5pddoorqn99RAG6s6vhUrF2vNGQd3Tu0Wi2FLgGf/N2qh6P8a8dj05MJnzyCA7zWheEJMFQlRU5qeML58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad1z8e9H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad1z8e9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9A4C2BCB2;
	Thu, 23 Apr 2026 04:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917904;
	bh=/PGzGvrhTyv/K/7bPPZQe8nYO+aq6VGIJEyFKJqC0o4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ad1z8e9HkHV6cNfp0qyi8RapoFQxIpuqgTcdI0iDSD1C8nmVretbdP/uaFrA/kw9K
	 +/sb8d8wh+C3k+XbfXEhUngcvkfTf2Y8kK3wF9BvGB2ow5Qydr3iBC1HYQJBFwnIrJ
	 upn2m4Pv46iPWdZehRTYu5ZOzzAcUzalG/zO4gSaLYp4L20CvSV5zyqKqqabEWkLVb
	 6mn0HJk+aPPZEuiu0rF2FEg74w0gc60KQ2utox5uro4ECUDo72mhzfsVPsQWL/TFPr
	 1HgnPfTcQYJL2ynWjOq2EFZ68f98WSNfDT3JN/dI1v+ITRIWZ4teWykL1/orYig7Xz
	 55yMGOHWo4UYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/58] perf stat-cpi: Port stat-cpi to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-26-irogers@google.com>
References: <20260423035526.1537178-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:18:23 +0000
Message-Id: <20260423041824.7D9A4C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Double subtraction of counter values in live mode leads to mathe=
matically meaningless CPI metrics.
- [Medium] Missing `evsel.read_format` configuration silently disables even=
t multiplexing scaling in live mode.
--

commit 382086625819b9250d682672f3e663444a565126
Author: Ian Rogers <irogers@google.com>

perf stat-cpi: Port stat-cpi to use python module

Port stat-cpi.py from the legacy framework to a standalone script. Support
both file processing mode and live mode. Calculate and display CPI per
interval per CPU/thread.

> diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
> new file mode 100755
> index 0000000000000..4b1f1f69c94a6
> --- /dev/null
> +++ b/tools/perf/python/stat-cpi.py
> @@ -0,0 +1,151 @@
[ ... ]
> +    def store(self, event: str, cpu: int, thread: int, counts: tuple[int=
, int, int]) -> None:
> +        """Store counter values, computing difference from previous abso=
lute values."""
> +        self.store_key(cpu, thread)
> +        key =3D self.get_key(event, cpu, thread)
> +
> +        val, ena, run =3D counts
> +        if key in self.prev_data:
> +            prev_val, prev_ena, prev_run =3D self.prev_data[key]
> +            cur_val =3D val - prev_val
> +            cur_ena =3D ena - prev_ena
> +            cur_run =3D run - prev_run

In live mode, evsel.read() relies on the C extension function which already
computes and returns the count delta since the last read.

Does subtracting the previous interval's values again here calculate the
acceleration of the counts instead of the velocity, producing incorrect
metrics?

[ ... ]
> +    def run_live(self) -> None:
> +        """Read counters live."""
> +        evlist =3D perf.parse_events("cycles,instructions")
> +        if not evlist:
> +            print("Failed to parse events", file=3Dsys.stderr)
> +            return
> +        try:
> +            evlist.open()

perf.parse_events() generates an evlist with default attributes, which do
not include perf.FORMAT_TOTAL_TIME_ENABLED and perf.FORMAT_TOTAL_TIME_RUNNI=
NG
flags.

If these flags are not added to evsel.read_format before calling
evlist.open(), will the kernel omit timing data and leave the ena and run
fields at 0?

Since the script relies on run > 0 to apply scaling:

    def get(self, event: str, cpu: int, thread: int) -> float:
        ...
        if run > 0:
            return val * (ena / float(run))

Could this bypass scaling logic and produce incorrect CPI calculations if
hardware PMU counters are overcommitted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D25
