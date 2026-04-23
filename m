Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5429729992B
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917262; cv=none; b=KYg0rbKA1D1OI+vJQBGBIdgS4R6kpT9PPtgVcA7HlB3Z9UBansiHtWMt//VLQ27v9LeN31oiLQpSTjGbdvfF295TmWP9b3N5bl4DOAMfNwdmqc5bG6z6roSPpA/pf7YvDdG6m7Q3Q1CYEHPCgFECC9WRxSvyheEpXr0rSvC4fUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917262; c=relaxed/simple;
	bh=zcfxboQtdeVxNUf8526gCKsoUus08yPOryXPQrfNUJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lE5yp0I3Zw46t87945zOXE9yA5R3vCcpHMHf3+QquWRdvuhVFCBJhtORztHNZZhh8Ws3XWMTPBhMSafYItr2cEKtd6PKa26YDlVp4nG7DvEj6GIHKHBDNg9Ih2ZHyzCzw5h/wkEcRq/NZDZ9uU9z0z/RuLOO5if/twfIXzLwDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7nP5U/C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7nP5U/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F07C2BCB2;
	Thu, 23 Apr 2026 04:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917262;
	bh=zcfxboQtdeVxNUf8526gCKsoUus08yPOryXPQrfNUJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=K7nP5U/CdMYuwPVLCExgnrWNL9ok2GSYlscGngaUyvzRyHh7RL2Uxwe5gQtZK1wnO
	 oSyZL22FwxFDcXRI1ozjPdyXRrDN5m5ZBAOc3eVa1oqxEOjUijAY9kgStWyKP3arK0
	 WqJXej3ICtQ1B4JQ3Zk6l+DV9MTB7ZkoDx+6GDtIoNWkVcEi1/a9VW4IwFSIdvgDgO
	 ZZv7wr9iy2r+4eqIPjZlcP/jWnqoKBr8gNzyLXeQPZ9O0hAldn1d7dOgJPHLjjhr61
	 GXGjmqaMB3gFzta6mRNhXRUO/XyNqjhCLQ0K7JMebA24Y8vBobGGoqRkb5c45I8Ar+
	 q2GBExaL4W0kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 40/58] perf net_dropmonitor: Port net_dropmonitor to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-41-irogers@google.com>
References: <20260423035526.1537178-41-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:07:41 +0000
Message-Id: <20260423040742.17F07C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Functional regression: script incorrectly aggregates by tracepoint=
 IP instead of the packet drop `location` payload.
- [Medium] Severe mismatch between the commit message and the implemented c=
ode regarding `/proc/kallsyms`.
- [Low] Dead code: Unreachable `except AttributeError:` block in `process_e=
vent`.
--

commit dd6738be8f63dfa72dba012e8f9cf02a2cba183b
Author: Ian Rogers <irogers@google.com>

perf net_dropmonitor: Port net_dropmonitor to use python module

This commit ports the net_dropmonitor script to use a class structure
and the perf Python module for event processing.

> - Maintained the manual /proc/kallsyms reading and binary search for
>   symbol resolution as in the original script.

Is this description accurate?

The script doesn't appear to contain any logic to open /proc/kallsyms or
perform a binary search, instead relying directly on the symbol attributes
from the perf sample.

> diff --git a/tools/perf/python/net_dropmonitor.py b/tools/perf/python/net=
_dropmonitor.py
> new file mode 100755
> index 0000000000000..25ea2a66ed3c8
> --- /dev/null
> +++ b/tools/perf/python/net_dropmonitor.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        if str(sample.evsel) !=3D "evsel(skb:kfree_skb)":
> +            return
> +
> +        try:
> +            symbol =3D getattr(sample, "symbol", "[unknown]")

Does this read the instruction pointer where the perf sample was taken
instead of the packet drop location?

The core purpose of net_dropmonitor is to track where packets are dropped
by inspecting the location payload field of the skb:kfree_skb tracepoint.

Since the tracepoint resides inside kfree_skb_reason() or kfree_skb(),
will using the sample's instruction pointer attribute all dropped packets
to the tracepoint hook itself rather than the caller that actually dropped
the skb?

> +            symoff =3D getattr(sample, "symoff", 0)
> +            self.drop_log[(symbol, symoff)] +=3D 1
> +        except AttributeError:
> +            self.unhandled[str(sample.evsel)] +=3D 1

Is this exception block reachable?

Since getattr() is provided with default values ("[unknown]" and 0), it
suppresses the AttributeError for missing attributes and directly returns
the default.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D40
