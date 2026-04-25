Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5A34B43F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140055; cv=none; b=hT2Gvuu4nEIKTTedSfeFc+e0cXSwpodd6GzKG/eB+SgOQNiu4kmlWkvlLOlBUPLEstkSZ+KRte5egyUgkP0z9CKlqcrGdIuiZbzN+EVBFunEbcZsZzFPG8dUbQ5xzOdVHvV5znpJ3Vy5kv2KsX1hZpopv+Nd3tctb2XZ9GPaUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140055; c=relaxed/simple;
	bh=mkBOBY8DKwSNyO9IsZ9qmxVqtSDXok/SI9ARDtUbrAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vB2PI0mnmIibzkA1XBO/H3mYcnJ1g0ORqPmWQ0782XI7sgzqOEk00CpJDGFNXaoyf5Ao3nU0P3/LON029+27ja2r4MAKH/y9JZSzWekbNVnXMVGisfdo7tjmNcK08npdHGvgwgZpaU3vRY4Ckts8+wuFYm+2d0kVl9lxvgB6jIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8wox0Hw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8wox0Hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5A3C2BCB0;
	Sat, 25 Apr 2026 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140055;
	bh=mkBOBY8DKwSNyO9IsZ9qmxVqtSDXok/SI9ARDtUbrAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Q8wox0Hwv/gnHWYUFR7S4OBn1WjGzITVcN7ltEtC7X3/KuIqxvbyl9u8ULSIjBHBF
	 PeL0x2viz/Wtk9n9JDnhwnE+yFRBA1xC6cPo8Pu7CnQifhDZg5fIRa7Nsm0VJn5wPw
	 0HoQXk1CniOUpkNoJXrfHPt9eQFnIBbgGilgCNRl5ob7Ct5G2xU6bFMWXRVXr2M0xS
	 LAxESeZtE5W7dTz43I0Nu3BHop5bNbVfjpW8FYBUce8YRgJ6o2DjS1QqOLvElqXtf2
	 a0ORupkcP/AkQgA9V27+Bduv+JQc31W66AqWFD5YEaEYvvq9g15hqLZobSqqWl3Czm
	 hVR0aq3qsOo7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 40/59] perf net_dropmonitor: Port net_dropmonitor to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-41-irogers@google.com>
References: <20260425174858.3922152-41-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:00:54 +0000
Message-Id: <20260425180055.0E5A3C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Functional regression: script attributes drops to the tracepoint e=
xecution site instead of the actual drop location.
- [Medium] Missing `/proc/kallsyms` logic contradicting the commit message.
- [Low] Unreachable `except AttributeError` block due to `getattr` defaults.
--

commit 2c6558b3bdb56c40c812f2bf2afa2daa4406fa15
Author: Ian Rogers <irogers@google.com>

perf net_dropmonitor: Port net_dropmonitor to use python module

This commit ports the net_dropmonitor python script to use a class
structure and the perf.session API instead of legacy global handlers.
It also cleans up Python 2 compatibility artifacts.

>     - Maintained the manual /proc/kallsyms reading and binary search for
>       symbol resolution as in the original script.

The commit message states that manual /proc/kallsyms reading and
binary search for symbol resolution are maintained. However, the patch
replaces this logic entirely with sample.symbol and sample.symoff.

Is this description accurate, or was the commit message not updated to
match the code?

> diff --git a/tools/perf/python/net_dropmonitor.py b/tools/perf/python/net=
_dropmonitor.py
> new file mode 100755
> index 000000000000..25ea2a66ed3c
> --- /dev/null
> +++ b/tools/perf/python/net_dropmonitor.py
> @@ -0,0 +1,58 @@
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single sample event."""
> +        if str(sample.evsel) !=3D "evsel(skb:kfree_skb)":
> +            return
> +
> +        try:
> +            symbol =3D getattr(sample, "symbol", "[unknown]")
> +            symoff =3D getattr(sample, "symoff", 0)

Will this use the instruction pointer of the event itself (typically
within kfree_skb) instead of the actual drop location?

The original script aggregated packet drops by examining the location
tracepoint argument, which points to the network driver or subsystem
that dropped the packet. Using sample.symbol and sample.symoff
attributes all packet drops to kfree_skb itself rather than their true
source.

> +            self.drop_log[(symbol, symoff)] +=3D 1
> +        except AttributeError:

Is this exception block reachable?

Because getattr() is used with a default value, it won't raise an
AttributeError if the attribute is missing. Events without symbols
will be recorded under the ('[unknown]', 0) key in self.drop_log
instead of incrementing self.unhandled.

> +            self.unhandled[str(sample.evsel)] +=3D 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D40
