Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510928852E
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051763; cv=none; b=RQhpArhaIAcaBRw2s3vkABghbp+W2Kh3WsQu5oSOEmN0qXbWwdxuNPb7fcAR0veO7x+O5Otqh4JndWZ8usEGxCVNKU7yugT+MqNxZPoh3aX2DYlZqhffEl4N250kMAwH6zAuMZ9IoHn8zS+gsVECbgk7zVyZ53NU9nyQLr5+Cpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051763; c=relaxed/simple;
	bh=s65QL85890Iacfx6swi4sxVqsQ/RkOjwy7ngRB+v5wU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OOwUe8XxGDSnI8iiW3MP2LreppmFxVn712QKk5bALnmU5J8T0doisJE8EVCPWmOuc4xpvx9IA5PNwh5dqcBs5E0s/ASsuJ8SO0XBRryU2QWjdHi7mo0jvI3/qe5by4ToQ+YPqEaqilNsyr/9Om/2gR4bNJNxj0jEvZ3N3es36Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ8zPUJd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ8zPUJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CA8C19425;
	Fri, 24 Apr 2026 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051763;
	bh=s65QL85890Iacfx6swi4sxVqsQ/RkOjwy7ngRB+v5wU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lJ8zPUJdlKydjm4IDjJfRc3PBj7QJpveWXM7ZS5YypRIunMRDRwJE3zhow+ukXiYL
	 O1/oFDR0XnPp7WtQ/22FfQe0c/SNJ7jHgwKolgKY0ekQ9C8EbdNRFAT0b1Xoz3GYfh
	 lzLY7kH8VKo2qhgfQI9G7Qkrzgt98pt761+Au8K4E604+RCi9cqexX9tdXPfbOHoLN
	 Fj+7Uh1KuooEDkmNEbXJohWuv7JGwRAb+YEiFN0pDEbWrrnRlMEv+V+MaBXq/zYkIi
	 s6j9itUBw8EWw3Jbej8gjO14POLOtRJYg0eeG/OKB0cF948RxSq9hPl8wlOJgjX1tt
	 8/NPta9MkLZWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 25/58] perf stat-cpi: Port stat-cpi to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-26-irogers@google.com>
References: <20260424164721.2229025-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:29:22 +0000
Message-Id: <20260424172923.85CA8C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Live mode produces mathematically incorrect 'delta of deltas' be=
cause it subtracts previous interval counts even though `evsel.read()` alre=
ady returns interval deltas.
- [Medium] Loose substring matching for event categorization (`"cycles" in =
name`) misidentifies unrelated events and overwrites their counts, corrupti=
ng metrics.
--

commit c55f90f4c4dcd6e961de218774905ee84760602d
Author: Ian Rogers <irogers@google.com>

perf stat-cpi: Port stat-cpi to use python module

This commit ports stat-cpi.py from the legacy framework to a standalone
script. It supports both file processing mode and live mode, calculating
and displaying CPI per interval per CPU/thread.

> diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
> new file mode 100755
> index 00000000000000..4b1f1f69c94a63
> --- /dev/null
> +++ b/tools/perf/python/stat-cpi.py
> @@ -0,0 +1,151 @@
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

Are there potential issues with this broad substring match? If a perf.data
file contains events like bus-cycles or stalled-cycles-frontend, won't
they also match cycles here and overwrite the true core cycles measurements
in self.data?

> +                else:
> +                    return
> +                self.store(event_name, event.cpu, event.thread, (event.v=
al, event.ena, event.run))
[ ... ]
> +    def read_counters(self, evlist: Any) -> None:
> +        """Read counters live."""
> +        for evsel in evlist:
> +            name =3D str(evsel)
> +            if "cycles" in name:
> +                event_name =3D "cycles"
> +            elif "instructions" in name:
> +                event_name =3D "instructions"
> +            else:
> +                continue
> +
> +            for cpu in evsel.cpus():
> +                for thread in evsel.threads():
> +                    try:
> +                        counts =3D evsel.read(cpu, thread)
> +                        self.store(event_name, cpu, thread,
> +                                   (counts.val, counts.ena, counts.run))

Does this result in an incorrect delta of deltas calculation?

The underlying C implementation for the Python binding (pyrf_evsel__read in
tools/perf/util/python.c) explicitly subtracts the previous counter values,
so evsel.read() already returns the delta for the current interval.

If store() is then called, which computes cur_val =3D val - prev_val, won't
this subtract the previous interval's delta from the current interval's
delta and result in incorrect CPI metrics for all intervals after the first?

> +                    except OSError:
> +                        pass
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D25
