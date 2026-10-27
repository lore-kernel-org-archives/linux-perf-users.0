Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133494;
	b=KywkME73kAf522uff2QakQ6bBzUEXcbZ96hF4McJpTLVQW31WoiQJIjeSEk3BXduPzGv
	 R00eMXj06UbdBBvI/qlVre0DZwi7A4y+owWllAGjOSMjWs79T1uZZKur1uBB2n4xpPVbC
	 nfJ4TVFljeEEwMuIO9nLysCqaMyG+I/TcAWD0JtnQ5MFIt1adSOHkDzeSchLsftgRzCdF
	 PncyWz5y9BLn3cwsGOyZ6JO8pfSbsoT/+GLDoPwpBRT4WTc9MNihKLi5TpXZa5PrebOU9
	 px7f22SU6izsa645RPmiH0fuNuVIDBf4H+8V1pNuhYvi29WChljMHBQy+BHc3P8ovjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133494;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uzz4zOvj1TxfoTJnqyPvRmjcEb2+LbPyugLNXQrzEU4=;
	b=zNEoTf+trISktB56bGLnxPiaCrFpCH8lzEdIwPDvGMnPpgyhcUy9wyT/bxvAMteUPfZb
	 EdwxYwqPifZnXCdFF2dl+e3Lw76fo/RUNVJc9orGCQdgAmwVcs6yo8uKvIlUbLVnC6SCs
	 n1mj0akfCca93VPZ8GZRceWjKgq7STNpP/lRn7BjMKYePjxMbUrbkvVLSzrnQpXsAh8uw
	 AuCDs6jYs/CGFTHmEEysILDt3mgsBR4kIdXXwVF2aq5A053mQHo9mmmShKH3mQd0K3n1M
	 JOsfZbEobRafGkMinoUHRclfgVACGnVGTprIb07KV+rRfj8cnbIMltT8QIvHkBZoRKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLm6Pgvw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC023606A31E;
	Tue, 27 Oct 2026 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLm6Pgvw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F9E1F01828;
	Tue, 27 Oct 2026 20:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133493;
	bh=uzz4zOvj1TxfoTJnqyPvRmjcEb2+LbPyugLNXQrzEU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kLm6Pgvw6NhWfBtSVwU2jJInIdWhgdE9rSNi6gtqYd7OJhE0TGmVBfuC/Xw++faKj
	 OjpfFAzvjchBn2oPtpxF0gDHK5U54iyI3JEA8uEKYvBlfKw8Tjb1t9aQgKc7nAQkHS
	 hErNH8SvRR8UMf9OxU+D1Gnvmt7vasEwydxI5XjeUTs7D82kOU4dqnnP5iPaC4Vf1m
	 zfj031ZmFtlv96NmdljRZuTitebqQ1IHZWj5tFB9elZSKv3dhVuGNIhZJTAEjaKhQr
	 4LCkb1/mtjrutkLTZ30Eb1/N1CEmMmW3viL+lOKNLSnmGU987USmdvi/wxSbMP4x1i
	 wV7WBDMT1M5QA==
Date: Tue, 27 Oct 2026 17:38:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Lalit Maganti <lalitmaganti@gmail.com>
Cc: irogers@google.com, namhyung@kernel.org, james.clark@linaro.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf pmu-events: Fix jevents.py type annotations for
 mypy 2.x
Message-ID: <auELs_5MK1Z3_78c@phoenix2>
References: <20261018065345.918176-1-lalitmaganti@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018065345.918176-1-lalitmaganti@gmail.com>

On Sun, Oct 18, 2026 at 07:53:45AM +0100, Lalit Maganti wrote:
> Since the build runs mypy whenever it is installed, the perf build fails
> with mypy 2.4 on 7 errors in jevents.py, e.g.:
> 
>   pmu-events/jevents.py:542: error: Item "None" of "str | None" has no
>   attribute "replace"  [union-attr]
>   pmu-events/jevents.py:563: error: Item "None" of "BigCString | None"
>   has no attribute "offsets"  [union-attr]
> 
> Both come from wrong annotations rather than from code that can see
> None:
>  - unit_to_pmu() is annotated as returning Optional[str] but always
>    returns a string, so JsonEvent.pmu is typed as optional where it is
>    used as a str.
>  - _bcs is set to None before the BigCString class is defined and only
>    assigned an instance after it, so mypy types it as BigCString | None.
> 
> Correct the return type and declare _bcs with its type instead of the
> None placeholder. The generated pmu-events.c and pmu-events-string.c
> are unchanged, and mypy 1.9 still passes.
> 
> Fixes: b3e9c396d0ac ("perf build: Make mypy build test opt-out (NO_MYPY=1)")
> Assisted-by: LLM
> Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>

Looks ok,

Thanks, applied for v7.4.

- Arnaldo
> ---
>  tools/perf/pmu-events/jevents.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index cc143f7e7cdf..080e04b51b8c 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -35,7 +35,7 @@ _pending_metrics: list["JsonEvent"] = []
>  # Name of metrics table to be written out
>  _pending_metrics_tblname: Optional[str] = None
>  # Global BigCString shared by all structures.
> -_bcs = None
> +_bcs: "BigCString"
>  # Map from the name of a metric group to a description of the group.
>  _metricgroups: Dict[str, str] = {}
>  # Order specific JsonEvent attributes will be visited.
> @@ -262,7 +262,7 @@ class JsonEvent:
>          return fixed[name.lower()]
>        return event
>  
> -    def unit_to_pmu(unit: Optional[str]) -> Optional[str]:
> +    def unit_to_pmu(unit: Optional[str]) -> str:
>        """Convert a JSON Unit to Linux PMU name."""
>        if not unit:
>          return 'default_core'
> 
> base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
> -- 
> 2.56.0
> 
