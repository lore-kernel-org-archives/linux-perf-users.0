Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133292;
	b=o9irWP49oOA+qzvzjJjfY5Ru0X09OkUZckVt385EuZZdJlFroGljAOyzUJi4Djbt18ZA
	 J45sUrKfXfjU4sCH1sSEqY/jgp4fLdtjpgfBnII9mjnbur10C2xpzWkcU2BiyhCOIMu9o
	 3ijwRe8vyrlYEgUnGxVpllK4YhI+ZUKDsanrZi/fJ13W2dGH3ovF2DRttVQjly8mJJXfT
	 bzc7VXtPnR+PAXqfGhESSgwMO+CPpQyBv2kyy+B3/rv1g4w4c/YtCib1bOsBIrPGZycgK
	 +zkeYsxxIQcnLFeQNJxRO3gZMxc7wKZ3+MFh0HrawFsqjC6Q314/WFVpxSgXG5W8A/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133292;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Jg3dAtp+gEQ8TJgbywQ+F/EtAoNNgFn4vT8jAZyRUok=;
	b=eWfIjSlXv/lHxAfBXAxThMeS5JktTl9E65BfPzh0b4q5Bmine9e2Lz2UmYgr8kpTIbmZ
	 Vl1jbMmDqYbDhZW4qQoOplSLE/G/flKyqWaaVhGc+QEtjHRbkUeFyMuHro0//DgR/X9ic
	 Jip+xfLspl6gbxjGoq8X0kc7cy4ZkmkxBidHwZKhhx1LoO57mL+1Hs/C8ltcWH2C5QUsf
	 b8oT9a9a7veshKmNuRgodgjUIW4OE+Pb8hkTJlejqF7g8s6spUIRYQuIhU+1QxYGMrBdL
	 +FRChH/IgXPr/FH7icylP4UAlD8K/jiJJpsJQQLpi0D0w580p22E7hmBf5GNpfnJURQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kphSUMe8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CB606A31F
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kphSUMe8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363A41F01825;
	Tue, 27 Oct 2026 20:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133291;
	bh=Jg3dAtp+gEQ8TJgbywQ+F/EtAoNNgFn4vT8jAZyRUok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kphSUMe8xZO6rGp9xO8f/rjEFu/r7wCNM3c6jrD8rDUGKiTSF94TxKwlDXlYBqiZi
	 SQEaU4IuI/AQ53ts+WrWcdjvQ4NDB/l1FK8XJidqGjDaM2ylzQfWTQZ2ISml9+1Y23
	 Y7r3gcTk+CG75BRPz7w+VzdZwU5OC+oD1JoRQx9YpyUn1bJrZQixaxsckkxi83HwNv
	 4g6mvD5BFW83iN9g76/2TWnkq2OqbwpN5IAqGec0A66AcIOL1sDun9PlcKwWBtXoA2
	 RRx+hHRidrSdou3de/7K5ERzhtpwbFDnu3ekDt36qXTRmsNo+TEpHQ4W932oE6bEXt
	 mg0N4B3QDto6A==
Date: Tue, 27 Oct 2026 17:34:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: TAKANO Mitsuhiro <takano32@gmail.com>, linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	John Garry <john.garry@linux.dev>
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Drop stale
 BPU_FLUSH_MEM_FAULT entry
Message-ID: <auEK6E-jX12Bi8u_@phoenix2>
References: <20261021224527.167637-1-takano32@gmail.com>
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
In-Reply-To: <20261021224527.167637-1-takano32@gmail.com>

On Wed, Oct 21, 2026 at 10:45:27PM +0000, TAKANO Mitsuhiro wrote:
> AmpereOne carried BPU_FLUSH_MEM_FAULT for EventCode 0x121 until it was
> renamed to GPC_FLUSH_MEM_FAULT in 10a149e4b4a9; that rename and the
> AmpereOneX table were patches 3 and 4 of the same series, so the new file
> kept the old name.
> 
> The result is a table that names the 0x121 counter twice:
> ampereonex/core-imp-def.json has GPC_FLUSH_MEM_FAULT, and
> ampereonex/memory.json adds BPU_FLUSH_MEM_FAULT with the same code and
> the same description.  On AmpereOneX perf therefore lists two events for
> one counter, one of them under a name the documentation does not use.
> No metric and no other file refers to either name, so removing the stale
> entry cannot change a metric.
> 
> It also leaves memory.json holding only the ArchStdEvent aliases the
> other files of that kind carry: AmpereOne's memory.json has no raw
> EventCode at all, and neither has any other file of the AmpereOneX set
> except the ones where raw codes belong.
 
> Nothing catches this at build time.  jevents.py asserts on duplicate
> event names, but x86 repeats an EventCode for many events because the
> code carries umask and unit bits (3756 times across its tables) and
> powerpc repeats five codes, so a duplicate-code check is not possible.
> arm64 is the only architecture where no table but this one repeats a
> code.

Maybe a followup improvement to jevents.py?
 
> Not tested on hardware: there is no AmpereOneX machine here, so perf was
> not run against the real PMU.  The change only edits a JSON table; the
> perf build was verified and the generated table for this PMU goes from
> two names for 0x121 to one (rebuilt, counted in pmu-events.c).

Ilkka, can I have your Reviewed-by or Acked-by?

Thanks,

- Arnaldo
 
> Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
> Assisted-by: LLM
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
>  .../pmu-events/arch/arm64/ampere/ampereonex/memory.json     | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
> index 6c06bc928415..2a83782f51b0 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
> @@ -33,11 +33,5 @@
>      },
>      {
>          "ArchStdEvent": "MEM_ACCESS_CHECKED_WR"
> -    },
> -    {
> -        "PublicDescription": "Flushes due to memory hazards",
> -        "EventCode": "0x121",
> -        "EventName": "BPU_FLUSH_MEM_FAULT",
> -        "BriefDescription": "Flushes due to memory hazards"
>      }
>  ]
> 
> base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
> -- 
> 2.53.0
