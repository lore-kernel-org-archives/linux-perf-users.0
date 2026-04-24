Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713E3E556D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051406; cv=none; b=nyDFfK6ngUiogQGM5rTGu0CTgQG22ALixAJYZnP0VIZHxpEY88sCS2yyN5i4Riq6kq3F+6wuHVIt4Q184c+Ln3tghLwxWJvZucH1pPVKMtxmEmO4GlwzpL0Y9r0htl+aNWO+4c4CDiNRx6v9zL4NN+7hUtI6zhIpXlUT5fu5q7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051406; c=relaxed/simple;
	bh=Cyd1qRpd21au0DQHZyUFXDXz549QH/rCMRrc65kWx5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZmKRAblDVdoGmuuAAWOmZUK6kdM40OhmMv0S4PpCIUx4nJGywP7TnkowL/f9TLcVjZ6os8NOE/q88vfzS7i00E6ZTNvkw5vhb/qHaECxjtrSmxobcMHmoaPqxB9S2FA4kp8akfH+BRqrR1ZaG3cNS8Z7vZ+R98mvzITUJdvmPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaIuQbE7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaIuQbE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBF5C19425;
	Fri, 24 Apr 2026 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051406;
	bh=Cyd1qRpd21au0DQHZyUFXDXz549QH/rCMRrc65kWx5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oaIuQbE77miwfYF5gyoKphLtQkvADzjT9yli4xTQCLXNCOnEythg/IWapJhijqCrB
	 4lEueJxO3+MGk92VnGLmA2CmUCREaLMJcpW+Z91dXYwrUMJV407iFOIrF5ZGwSNB3V
	 2q0TxbgRsHnwPK8EXzz8/0Kf67YnawjCQiHoVYlwNWKheWDrba2Y0xjpRX8HlBlhyT
	 92Vr8UH7sifOUJtA6sAHc0iVL3hGwL9koPgrkTdReHlTH0W1dL08RIm8AfuInGwySG
	 FWKdxtiKd21tKxTocGgceJ7aokapJJ51WuLUPY5KV1RXXPMdBoZkYbKRry0phx9u10
	 tCreQgzNPB1Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 45/58] perf stackcollapse: Port stackcollapse to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-46-irogers@google.com>
References: <20260424164721.2229025-46-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:23:25 +0000
Message-Id: <20260424172325.ECBF5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unhandled exception in stackcollapse.py when resolving missing t=
hreads crashes the script
--

commit ab838b6c5dd629db6581ba16f91528100745626d
Author: Ian Rogers <irogers@google.com>

perf stackcollapse: Port stackcollapse to use python module

This commit modernizes the legacy stackcollapse.py trace script by refactor=
ing
it into a class-based StackCollapseAnalyzer architecture. It uses perf.sess=
ion
for event processing and aggregates call stacks to produce flame graph outp=
ut.

> diff --git a/tools/perf/python/stackcollapse.py b/tools/perf/python/stack=
collapse.py
> new file mode 100755
> index 00000000000000..fae0f0f503a354
> --- /dev/null
> +++ b/tools/perf/python/stackcollapse.py
[ ... ]
> @@ -0,0 +1,126 @@
> +#!/usr/bin/env python3
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Collect call stack for each sample."""
> +        stack =3D []
> +        callchain =3D getattr(sample, "callchain", None)
> +        if callchain is not None:
> +            for node in callchain:
> +                stack.append(self.tidy_function_name(node.symbol, node.d=
so))
> +        else:
> +            # Fallback if no callchain
> +            sym =3D getattr(sample, "symbol", "[unknown]")
> +            dso =3D getattr(sample, "dso", "[unknown]")
> +            stack.append(self.tidy_function_name(sym, dso))
> +
> +        if self.args.include_comm:
> +            if hasattr(self, 'session') and self.session:
> +                comm =3D self.session.process(sample.sample_pid).comm()

Could this crash the script if a thread cannot be found or if its comm
string is missing?

If the underlying C API (pyrf_session__process) fails to find the thread
for the given PID, it explicitly raises a TypeError. Similarly, if the
thread has no valid comm string, pyrf_thread__comm() can raise a SystemErro=
r.

Since there is no try...except block around this call, will an exception
from a lost event or short-lived process propagate to the C wrapper and
abruptly abort perf_session__process_events()?

> +            else:
> +                comm =3D "Unknown"
> +            comm =3D comm.replace(" ", "_")
> +            sep =3D "-"
> +            if self.args.include_pid:
> +                comm =3D f"{comm}{sep}{getattr(sample, 'sample_pid', 0)}"
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D45
