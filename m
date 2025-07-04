Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E432DEA6E;
	Fri,  4 Jul 2025 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651739; cv=none; b=fiYvu6RjHrEH/3jQO3hXA2ZQLePvCrELtpqzpNOgP2bxwR5/JMPE/WUoK/SLutDQRa+8m3FP74Bv7TxX/loTW/KbTtgV5QqEjyAbjLmGox49HB+xNVANxCPSYOhEzbC0aYNLReVv/BwFx7DFj66sk+/mnDl7apkuL1qChhlpo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651739; c=relaxed/simple;
	bh=TxfXG/TnoB5cS43y+ihelTbSmjlldl171h067YFIq4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rXeMYjF/ua+vCHytkrdS6vdEWG1FoTTSkkoy3tVjSvsiM69lUKicoQe876fIqHjk9HQF2q7bx2zjrxo/bJf665DRHUjEx4rviJoDTJhK0iJPtL5RIbDSPEoKHGZlCygP/bfWA0XVX29Z+M5kczVQCZ6D8f/h7TWtaSMdaRoQkxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQoWdP0n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQoWdP0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE14C4CEEF;
	Fri,  4 Jul 2025 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651739;
	bh=TxfXG/TnoB5cS43y+ihelTbSmjlldl171h067YFIq4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XQoWdP0n46aO7cE9bAlJ9Xmd41KhSMyFHf/sTDd2Le/upgWg4PjS/bc8URfqscOlj
	 g5plQ5SplVgm0zkMCJVGynb9IVLpd2862lcP6/kiMYYmcwHpH71aZOuMASiJpkAuut
	 lElyn31sAUj4R7mY7/3zOlXBk7SkFzzpRe8lQq4oFTovnYtjKNCz2xybpu24c+B2hk
	 4xmjQrgY0Y0OmA3o01JQ8tMPlaO/PttzapsieTOvhP4DYEAFW79O6eRkdTJANLbDG7
	 jtbGL/Rb3zDmVaJIqey55MeflwTyNdSiJMQ+1wgzPMorJ6M9+oweKH92W8gZMQKsal
	 vkp/1+IrjTi3g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20250703014942.1369397-1-namhyung@kernel.org>
References: <20250703014942.1369397-1-namhyung@kernel.org>
Subject: Re: [PATCHSET 0/8] perf sched: Fix various memory leaks
Message-Id: <175165173893.3149172.3930792821230111207.b4-ty@kernel.org>
Date: Fri, 04 Jul 2025 10:55:38 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 02 Jul 2025 18:49:34 -0700, Namhyung Kim wrote:
> While running the new perf sched test with ASAN, it fails due to
> memory leaks.  They comes mostly from missing thread__put() but
> sometimes it needs to release other data structures.
> 
> Fix those leaks and add more subcommands to the test.
> 
> Thanks,
> Namhyung
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


