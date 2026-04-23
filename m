Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524635957
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918620; cv=none; b=dHa8qCUzB6hOC2zVDdUO2K5baGTmWW/8XXVyEraEgi0ZAHFV8qNGTXhlXf4xIIp6BeRCZEBxR8QH4SXCOpQKENOYUCnSNrS8uWuwAvDbWi/ecAfXC2nzhbmRu7J9ppDf35gpCnvz04+T5hART8lNmcXzPAWbOfSDkAI4XkgnsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918620; c=relaxed/simple;
	bh=VD93gwBstEHa824Y/mM/egQgPq2d0aZmH/R2SNWgR3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cdKC6IOJRA3b4vfV01LpNCFjNDnBdsv/5eEq3XZWGfLgcEwhsV+vJe/H20PsnCxek0JRMpL2on5KZfdJZS1MpCrQqhL4taHrLCKsPjsduM0l0AK34rwHCBuyaliamuz0HlDnnNBXdIZLO2C+BUHh1NEJxHiRsZa/Je/o6tN6zJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqbhi8sn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqbhi8sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBC3C2BCB2;
	Thu, 23 Apr 2026 04:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918620;
	bh=VD93gwBstEHa824Y/mM/egQgPq2d0aZmH/R2SNWgR3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aqbhi8snWCnpCzIWAAZARLu72tmq4Gn2DhAhVqJRGJiKe2fX3jebWO/BacYeuN38P
	 XyCKccaYWhl1rgFFs1PBn8NtJdGwK4aOW728efkQZRC3Q7KmR41JkccpO5rhW7f6Qb
	 htIIWe1zXM3SFBBN2OKqB5jTvVUVvvvYlAnyQFm398WyUfOnbIMrj9Q3NT5NEsxmtO
	 TsHZuiir//6SywBrPTCihsOoIqLAYBIJgr/F/DVANEbrwOUMfBnuFFncQxoBB3HHcV
	 8gFkJ5pkq/TJ9Lf5l4HZLju8C13zno8pOFR814PsQsZpqDeqvW1kiybHl6zfgreAE/
	 uroSpL5gLB6YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 46/58] perf task-analyzer: Port task-analyzer to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-47-irogers@google.com>
References: <20260423035526.1537178-47-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:30:19 +0000
Message-Id: <20260423043020.6FBC3C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Missing TGID resolution and latent AttributeError / TypeError cr=
ashes.
- [Medium] Complete removal of the Summary statistical calculations.
- [Medium] Task histories are truncated to 1000 items, destroying statistic=
al accuracy.
- [Medium] Missing validation on --time-limit argument causes a ValueError =
crash.
--

commit b1158a9f3441697ada0878a8420611a7d0a649b3
Author: Ian Rogers <irogers@google.com>

perf task-analyzer: Port task-analyzer to use python module

This commit ports task-analyzer.py to use a class-based architecture in
tools/perf/python. It adds support for file and live modes and updates
testing to run the command directly instead of using perf script report.

> diff --git a/tools/perf/python/task-analyzer.py b/tools/perf/python/task-=
analyzer.py
> new file mode 100755
> index 0000000000000..869168c59207b
> --- /dev/null
> +++ b/tools/perf/python/task-analyzer.py

[ ... ]

> +    def _record_cleanup(self, _list: list[Any]) -> list[Any]:
> +        need_summary =3D (self.args.summary or self.args.summary_extende=
d or
> +                        self.args.summary_only)
> +        if not need_summary and len(_list) > 1:
> +            return _list[len(_list) - 1:]
> +        if len(_list) > 1000:
> +            return _list[len(_list) - 1000:]
> +        return _list

Does truncating the task history to 1000 items destroy the statistical accu=
racy
for tasks executed more than 1000 times? To compute summary statistics acro=
ss
an entire trace, the analyzer needs to retain the full runtimes list.

[ ... ]

> +    def _is_within_timelimit(self, time_ns: int) -> bool:
> +        if not self.args.time_limit:
> +            return True
> +        time_s =3D decimal.Decimal(time_ns) / decimal.Decimal(1e9)
> +        lower_bound, upper_bound =3D self.args.time_limit.split(":")

If the --time-limit argument is provided without a colon, will split(":")
return a single element and cause a ValueError crash?

[ ... ]

> +        # Task finish for previous task
> +        if self.session:
> +            prev_tgid =3D self.session.process(prev_pid).pid  # type: ig=
nore
> +        else:
> +            prev_tgid =3D prev_pid # Fallback

Is self.session ever assigned? It looks like _run_file() and _run_live()
instantiate session as a local variable.

If self.session were assigned, would self.session.process(prev_pid).pid cra=
sh
with an AttributeError? The C extension perf.thread only exposes a .comm()
method, not .pid.

Also, can session.process() raise a TypeError if a thread is not found in t=
he
perf session (e.g. the idle task)?

[ ... ]

> +    def print_summary(self) -> None:
> +        """Calculate and print summary."""
> +        need_summary =3D (self.args.summary or self.args.summary_extende=
d or
> +                        self.args.summary_only or self.args.csv_summary)
> +        if not need_summary:
> +            return
> +
> +        # Simplified summary logic for brevity, full logic can be ported=
 if needed
> +        print("\nSummary (Simplified)", file=3Dself.fd_sum)
> +        if self.args.summary_extended:
> +            print("Inter Task Times", file=3Dself.fd_sum)
> +        # ... port full Summary class logic here ...

Were the statistical calculations intentionally dropped here?

The original script computed Accumulated runtime, Mean, Median, Min, and Ma=
x.
The shell tests currently pass because they only grep for the word 'Summary'
instead of verifying the table contents.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D46
