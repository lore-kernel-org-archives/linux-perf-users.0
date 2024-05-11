Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6D56472
	for <linux-perf-users@vger.kernel.org>; Sat, 11 May 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715442817; cv=none; b=cGjYkQUT7K+N9bFw2YkvPCsTiKYI+PT89S9PVLbT2OrGq/XbEu3mV16LTQQaUxM+KgrZ27oHYj+paLGla1qo9KvYv5gDb44XKckNNAF4fJ/CZFGqvCmrxuku80EZ27hB49yBYOCFAMKf64x9AH8mEG5NLpfFf+Rgz3cNj2yAEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715442817; c=relaxed/simple;
	bh=UR/VsrTdMlyPZLDRdN7JoKoF84p0t4BrgH/b0Ff6W2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXLfB2fdjMYLvKzQLl45DlP324FXSrP0yuNWOJ7hfCcrsXa6OZJJrPxZIQcD4i7+bIBeBHyHP2JGFaFEIl/sm7S/R5Y4QnhR0enJ27QUWjesEGDp7MHx/xgWCr9+vD3wDtn0brOPf/7zVjrbuoe4RntG0PaR1dcAEzmkfWiDuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQCZRjOZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQCZRjOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8383C2BBFC;
	Sat, 11 May 2024 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715442817;
	bh=UR/VsrTdMlyPZLDRdN7JoKoF84p0t4BrgH/b0Ff6W2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQCZRjOZEGrkz9vpUCJPTojbzl2lxjt3/1yPe4s419rz7erkQfnjOb+5Mk7dBt+BQ
	 yc8kWmhgweFPZSndKM1HaL2K5qb3k8auRovB4ur9FzNtq9vEpi4IC3DhlHmPxwWKYB
	 MkcBJqT3Fa6e+qEQZoRioGlb+9zBsrIuLTZZEHannVyqRGqeehjkooBG5AFKoqltAm
	 00V4TqA+0UIdmLI3DU2cGE4xURNR16/yIC9q5Zii0eJ5aOQHHZpbId9B+ckSUSIWev
	 afvdTd9xUo3/3q277A3TTchmoAjrmMCuOc9SoV9Kt4WznOkxJWJGEIGP351xosm+Ce
	 3/BqRQyJqPwTg==
Date: Sat, 11 May 2024 12:53:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 0/7] perf vendor events riscv: Update SiFive CPU PMU
 events
Message-ID: <Zj-UfsmiG3GU4S88@x1>
References: <20240509021531.680920-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509021531.680920-1-samuel.holland@sifive.com>

On Wed, May 08, 2024 at 07:14:53PM -0700, Samuel Holland wrote:
> This series updates the PMU event JSON files to add support for newer
> SiFive CPUs, including those used in the upcoming HiFive Premier P550
> board. Since most changes are incremental, symbolic links are used when
> a set of events is unchanged from the previous CPU series.

Ian, are you ok with this? Someone with such systems can provide some
Tested-by?

- Arnaldo
 
> 
> Eric Lin (5):
>   perf vendor events riscv: Update SiFive Bullet events
>   perf vendor events riscv: Add SiFive Bullet version 0x07 events
>   perf vendor events riscv: Add SiFive Bullet version 0x0d events
>   perf vendor events riscv: Add SiFive P550 events
>   perf vendor events riscv: Add SiFive P650 events
> 
> Samuel Holland (2):
>   perf vendor events riscv: Rename U74 to Bullet
>   perf vendor events riscv: Remove leading zeroes
> 
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  6 +-
>  .../cycle-and-instruction-count.json          | 12 +++
>  .../arch/riscv/sifive/bullet-07/firmware.json |  1 +
>  .../riscv/sifive/bullet-07/instruction.json   |  1 +
>  .../arch/riscv/sifive/bullet-07/memory.json   |  1 +
>  .../riscv/sifive/bullet-07/microarch.json     | 62 +++++++++++++
>  .../riscv/sifive/bullet-07/watchpoint.json    | 42 +++++++++
>  .../cycle-and-instruction-count.json          |  1 +
>  .../arch/riscv/sifive/bullet-0d/firmware.json |  1 +
>  .../riscv/sifive/bullet-0d/instruction.json   |  1 +
>  .../arch/riscv/sifive/bullet-0d/memory.json   |  1 +
>  .../riscv/sifive/bullet-0d/microarch.json     | 72 +++++++++++++++
>  .../riscv/sifive/bullet-0d/watchpoint.json    |  1 +
>  .../sifive/{u74 => bullet}/firmware.json      |  0
>  .../arch/riscv/sifive/bullet/instruction.json | 92 +++++++++++++++++++
>  .../arch/riscv/sifive/bullet/memory.json      | 32 +++++++
>  .../arch/riscv/sifive/bullet/microarch.json   | 57 ++++++++++++
>  .../arch/riscv/sifive/p550/firmware.json      |  1 +
>  .../arch/riscv/sifive/p550/instruction.json   |  1 +
>  .../arch/riscv/sifive/p550/memory.json        | 47 ++++++++++
>  .../arch/riscv/sifive/p550/microarch.json     |  1 +
>  .../p650/cycle-and-instruction-count.json     |  1 +
>  .../arch/riscv/sifive/p650/firmware.json      |  1 +
>  .../arch/riscv/sifive/p650/instruction.json   |  1 +
>  .../arch/riscv/sifive/p650/memory.json        | 57 ++++++++++++
>  .../arch/riscv/sifive/p650/microarch.json     | 62 +++++++++++++
>  .../arch/riscv/sifive/p650/watchpoint.json    |  1 +
>  .../arch/riscv/sifive/u74/instructions.json   | 92 -------------------
>  .../arch/riscv/sifive/u74/memory.json         | 32 -------
>  .../arch/riscv/sifive/u74/microarch.json      | 57 ------------
>  30 files changed, 555 insertions(+), 182 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/cycle-and-instruction-count.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/firmware.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/instruction.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/microarch.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/watchpoint.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json
>  rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/firmware.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/firmware.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p550/memory.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/microarch.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-and-instruction-count.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/firmware.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/microarch.json
>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/watchpoint.json
>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
> 
> -- 
> 2.44.0
> 
