Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE33192590
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645213; cv=none; b=c1P7CBDtXHeF6mZ8oEA4npLGV81cFo/xhog1BYPe41M67FCR1VllrRtsXMIadbvQt2KflQ0a6HTUOZMhnbO7MSVydew6PmpIqHdIZumR14YArD7LOYqyZdAZLz7jlkm92wNKNz/ztiMkwNxNATpZt/QKbvQthBVmPcWBePf+a4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645213; c=relaxed/simple;
	bh=JK28fRfZz6fKEuJtPNgA6hX4SCL3TASgxsnnsTd0ang=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FnjyL1al4MxNiOTvuuAqJZae4jBwC+JNwHHG9/4IdgfpArw/knjSEHwu7b0JZgzzhaDzYQ+1bFlBgWZSMI5NgzhdgfpYH/pdeVx2vzsJjeAjPwpsoXCXSdfdCjvp4SXl5fAPMvlGcFWYTtAsPl+ZdsOcuQ4PCJcb31SKPk+DWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erwmYjSX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erwmYjSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF69BC2BCAF;
	Mon, 20 Apr 2026 00:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645212;
	bh=JK28fRfZz6fKEuJtPNgA6hX4SCL3TASgxsnnsTd0ang=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=erwmYjSXgMgkC8gEA32we8g7iI51c+NeMT24AevhkwRE9+OxzyU5We4cJbUjSU2TG
	 Xs6CUHu18Yp6DB6ge7X5ZAjO0Lu6EeDL6NSmqFchrO2Dky3JE49i+iLMesjadL62H9
	 KZyMtMMdOipEr0kYL1i28POBbR0/imFQLB+PYWm+XBLUbC7eQIyvAovJ8jPem4Ji3k
	 gbNnMpLkCQMXTOr6L9NQBKfYt+NlOhwI6dSSwDLz69YriO7nepLpTuwelFggC4YLYG
	 tGiIOdlQiYTXGD9tuHpONBj7AzchjQfNZ9B9OMYijSPSrxSypBo1GT+Gt2yJZNa//0
	 HsHiMpeItWf9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 25/58] perf stat-cpi: Port stat-cpi to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-26-irogers@google.com>
References: <20260419235911.2186050-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:33:32 +0000
Message-Id: <20260420003332.AF69BC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] File processing mode computes cumulative CPI instead of interval=
 CPI.
- [Medium] Counter multiplexing scaling is ignored, leading to inaccurate C=
PI calculations on overcommitted PMUs.
- [Medium] Cartesian product iteration prints incorrect dummy entries for n=
on-existent CPU/thread pairs.
--

commit fd94c65a2036aa00a6bb9e2487402df6f491024c
Author: Ian Rogers <irogers@google.com>

perf stat-cpi: Port stat-cpi to use python module

This commit ports stat-cpi.py from the legacy framework to a standalone
script. It supports both file processing mode and live mode to calculate
and display CPI per interval.

> diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
> new file mode 100755
> --- /dev/null
> +++ b/tools/perf/python/stat-cpi.py

[ ... ]

> +    def get(self, event: str, cpu: int, thread: int) -> int:
> +        """Get counter value."""
> +        key =3D self.get_key(event, cpu, thread)
> +        return self.data[key][0] if key in self.data else 0

Since store() saves the tuple (val, ena, run), does this get() method
lead to inaccurate CPI calculations by only extracting the raw count
value?

If the PMU is overcommitted and counters are multiplexed, they might run
for different fractions of the interval. Without scaling the values
(e.g., val * (ena / float(run)) when run > 0), the script appears to
compute CPI using unscaled partial counts.

[ ... ]

> +    def process_stat_event(self, event: Any, name: Optional[str] =3D Non=
e) -> None:
> +        """Process PERF_RECORD_STAT and PERF_RECORD_STAT_ROUND events."""
> +        if event.type =3D=3D perf.RECORD_STAT:
> +            if name:
> +                if "cycles" in name:
> +                    event_name =3D "cycles"
> +                elif "instructions" in name:
> +                    event_name =3D "instructions"
> +                else:
> +                    return
> +                self.store(event_name, event.cpu, event.thread, (event.v=
al, event.ena, event.run))
> +        elif event.type =3D=3D perf.RECORD_STAT_ROUND:
> +            timestamp =3D getattr(event, "time", 0)
> +            self.print_interval(timestamp)
> +            self.data.clear()
> +            self.cpus.clear()
> +            self.threads.clear()

In file processing mode, PERF_RECORD_STAT events contain cumulative,
absolute counter values.

Because self.data.clear() discards the previous interval's state without
subtracting those previous absolute values from the current ones, does this
result in calculating the cumulative CPI from the start of the trace, rather
than the "per interval" CPI described in the commit message?

[ ... ]

> +    def print_interval(self, timestamp: int) -> None:
> +        """Print CPI for the current interval."""
> +        for cpu in self.cpus:
> +            for thread in self.threads:
> +                cyc =3D self.get("cycles", cpu, thread)
> +                ins =3D self.get("instructions", cpu, thread)
> +                cpi =3D 0.0
> +                if ins !=3D 0:
> +                    cpi =3D cyc / float(ins)
> +                t_sec =3D timestamp / 1000000000.0
> +                print(f"{t_sec:15f}: cpu {cpu}, thread {thread} -> cpi {=
cpi:f} ({cyc}/{ins})")

Since self.cpus and self.threads are independently populated as lists of all
unique CPUs and threads seen across the interval, does this nested loop cre=
ate
a Cartesian product?

If some CPU/thread pairs fail to read (for example, if OSError is caught in
read_counters()), it looks like this will query get() for pairs that were
never recorded, polluting the output with zeroed dummy entries.

Would storing and iterating over recorded (cpu, thread) tuples prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D25
