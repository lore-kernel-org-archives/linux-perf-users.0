Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D238F92D;
	Fri,  5 Jun 2026 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701558; cv=none; b=kI7veCAokyrZnAaH2T22ngZqXv5YxjfiqIxaBkn0qf4VNur4rY6e6aSx71TVhp/yT+bnmz6J1XQPA6cyvyd2e2gp0cLMDgFM3CVnI8SAzXJbJ+x4xxW90jFhVPdCEHbDPFObaRTIvg7Hj39FfuPnhGzT2HUO63QgDRc50pcbgL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701558; c=relaxed/simple;
	bh=r00M4GtxeP87BpQCO1R8oK3dXRD/QgWYJU9qS8mIjTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pULXiH39SdEM4oEoRysIq3D6cGZq7TYM2sjON9jIIqblYIC92IznrFeS9We59Ahc7jhIv6x4X8dNLgMMgzxK/BQrvofnakHZgIDBGFw0Dg5NLmskvMrTWDQZB2bF1q/A0Gspun8KQo2ab0aWIHqjGKHlryA4E9EBafyPDJVGLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ofjm3cqb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ofjm3cqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB951F00893;
	Fri,  5 Jun 2026 23:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701557;
	bh=jS1vZ0/FVda5sfw2wV1UTY7oByPx8Ni+5ZJHJlg5aRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ofjm3cqbb5Ay/liM+VNUBwZuocUHnVRmKmk7/MEkWf5Jm/f/TSlALIYzhk3QhlYG5
	 5HkWYmDVCDGOujVWe6e7ReRtuUZHuBNORktErDYyhGtD8DX5ZwsoGrOOQq8vrXjqTk
	 ca+83Qs9UQMnT23BSn7/wTWOMb0LrkrZc0BX4ZJyh745Z6FV+EM6+oS50BowlqIfx7
	 aA4rlfmp5b1aQhTwTdyapJla1djDme6PhD7xXCe9D7sWZuBCuJ/q61tJe47sd0t1az
	 +FABvNz71Ew7HnDDmWgOl0ny5C0snCtr7fqzSUQBpNieFvnIgCoiUuf9gBBnU3HZuA
	 6YSY+w5LORZ5A==
Date: Fri, 5 Jun 2026 20:19:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf timechart: Fix memory leaks
Message-ID: <aiNZcZosyvKQnQk1@x1>
References: <20260605231155.2415760-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605231155.2415760-1-namhyung@kernel.org>

On Fri, Jun 05, 2026 at 04:11:51PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This patchset fixes memory leaks in the perf timechart code.
> I've extended and verified the timechart test with ASAN.
 
Hi Namhyung,

	You submitted a series for timechart before, so I had to go on
looking if this was a second version or a different series.

	I suggest you always have a version in the cover letter, i.e.:

[PATCH v1 0/4] perf timechart: Fix memory leaks

	To avoid this brief distraction :-)

Regards,

- Arnaldo

> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf timechart: Release event samples at the end
>   perf timechart: Fix memory leaks during record
>   perf timechart: Fix memory leaks in draw_wakeups()
>   perf test: Update perf timechart test
> 
>  tools/perf/builtin-timechart.c      | 93 ++++++++++++++++++++++++-----
>  tools/perf/tests/shell/timechart.sh | 24 +++++---
>  2 files changed, 94 insertions(+), 23 deletions(-)
> 
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
