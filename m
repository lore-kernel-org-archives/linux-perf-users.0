Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5CB24FC0D;
	Wed, 19 Feb 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000010; cv=none; b=Qu5zNFX0KVit4Jf3yaIhI4XMe9sjrnHNZyncPurtu3GNcqfcMUfkTkUaFHIBYilx5qItLLcxBgPulqqTBmklOVTpaWtAs1upjofH1jKaZ6wYGQygQGcpSWMbtYt6m1Xo/LzA/4FtUB7+Mwo07oGy0gHyzHKcXl0QM7JfAMkVuYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000010; c=relaxed/simple;
	bh=Z0rIEzHSNJzDYz0lpdKgc1HXdQuUbUWngzVqExCfsqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYKrOU6GcuyzGP44ZnKtexvQGLhptLcBy77PoBS0UPH5iPc4E89njGDPMvFwvK32cVRAdb4+uDRQBB1/9ZQ6f3il56i2r4UH97xfmB/pGXKIzgJ93PoxJJ3AhZhSeMbYLiprwzzzuvKXjgHmlGWwO9GE6LJEuKnQs4lFj2MLtuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGSzxpem; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGSzxpem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5653CC4CEDD;
	Wed, 19 Feb 2025 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740000009;
	bh=Z0rIEzHSNJzDYz0lpdKgc1HXdQuUbUWngzVqExCfsqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGSzxpemh8Udu9H28hUtPpbAS5D1OG7CZLOG08m1vN+KtIknrfHJkE0sfF2SJ7k0Y
	 CnIDA5SkHy+nJm2xQjVbiIXbMeUu8eOJXFTifq4hubnyKzsVAom2f9ZA9107HMMHYb
	 M4fljMwLPqmf+CV0phFLWgEsH+5xzoWUc51MiRs7QpN2Ugu5JFXi9LA60y3MHJQVxy
	 LAurVZhsuYPMjmHSlhZDNe7LXi4uGFHCflPsEoIABdgqtjE1miiTfYvxFvJmlCPbEK
	 Dum7nXv5EOCZ4rKrn9QEW1PLKH7GE+PtmVVTQVVPDJnNGnBAm9u9t5pW01H/67+0HG
	 /vQv2ClCRtHVA==
Date: Wed, 19 Feb 2025 13:20:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU
 PMU events
Message-ID: <Z7ZLB-wZY9wTZSBZ@google.com>
References: <20250213220341.3215660-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213220341.3215660-1-samuel.holland@sifive.com>

Hello,

On Wed, Feb 12, 2025 at 05:21:33PM -0800, Samuel Holland wrote:
> This series updates the PMU event JSON files to add support for newer
> SiFive CPUs, including those used in the HiFive Premier P550 board.
> Since most changes are incremental, symbolic links are used when a set
> of events is unchanged from the previous CPU series.
> 
> I originally sent this series about a year ago[1], but received no
> feedback. The P550 board is now available (and I have tested this series
> on it), so it would be good to get perf support for it upstream.
> 
> [1]: https://lore.kernel.org/linux-perf-users/20240509021531.680920-1-samuel.holland@sifive.com/
> 
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

It'd be nice if anyone in the RISC-V community can review this.

Thanks,
Namhyung

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
> 2.47.0
> 
