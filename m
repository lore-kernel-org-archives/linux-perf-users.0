Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E6E31960B;
	Sun, 26 Jul 2026 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785043438; cv=none; b=rjxO8i7M47U915XLW8ZPr0PIbNMj1PohMZljBFkjqQn7ry63BJgmDc7hajIazFcQaUAmYIMX+3D/A4rz6kY1owZ/n2OcAN8nhaZzQ3/dsIcyJvRwms80nxAGqabP/0XamK3ZIK4kLcPHtJUscB9l9l/DhP0D2acuU469Yv4D4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785043438; c=relaxed/simple;
	bh=Tn82WsBWCa0UbZxHoLncq6ZPCgmSXNXTcOeFwIbDAX4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nHUQ3GpN75R/Q7MCsWEDLFvcGd54al2jomy/gFfLELePfIQVpVj2vWMLHjQFj2350MlRPia8CouXJZyZuQ8gHPZ2/J0l6bEo+db5AFswe15LYGQxQFFnR6MxA6x524HE+hFzg6PvMv6DRY4+9q8nE6NIp/E/ABoPcg8toSb9Qt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HioXxm6w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HioXxm6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E85B1F00AC4;
	Sun, 26 Jul 2026 05:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785043437;
	bh=8CZdKIycBm6cwd2zsAyOhseVPTrweSnuop6RSGFKBRg=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=HioXxm6wwlR1o7Ovh21LoJDyXJrjgfvvbD/AOXyBmqFl4CZsy0hIK5HizDjs9xAuN
	 GEenguGSMjZq9f/BrPKvKUnAvluYw7Ibj4woC4u+riH41AR48MTS0lt1mODKEoM7ca
	 caAtUVtECKZcoz36vJf/gl+ZcFTG604LBF+6C84WLHA0EGA5xiaJDqoqcZCfwtNv3M
	 wyp7lbMvKaiA44FtGrtoMKfqWXyz9CjQ5ZhT0SX03etfCftrvCPQoOnHt85A/vZaG5
	 SJKt6AVhzlaev5MgjWNPBriqoQ8coRfFM6+r6dN1d2h34nUA5ZF8YQEC0Co0/NTljN
	 za3gHNHryqwNg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20260722173138.720586-1-irogers@google.com>
References: <20260722173138.720586-1-irogers@google.com>
Subject: Re: [PATCH v1] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
Message-Id: <178504343734.1075259.10134324476190064322.b4-ty@kernel.org>
Date: Sat, 25 Jul 2026 22:23:57 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 22 Jul 2026 10:31:38 -0700, Ian Rogers wrote:
> Currently, jevents.py parses hundreds of JSON event and metric files
> sequentially across all CPU architectures during Kbuild startup,
> taking ~3.5 seconds of single-core execution time.
> 
> Refactor jevents.py to pre-populate its internal JSON AST cache in
> parallel across all available CPU cores using
> ProcessPoolExecutor. First gather all the paths with ftw and
> collect_json, then spawn _parallel_read_json_events that starts
> workers to just read the json events. Define the worker process
> initializer _init_worker so that _arch_std_events is available under
> spawn multiprocessing semantics.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


