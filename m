Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69529296D0A;
	Mon, 12 May 2025 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070977; cv=none; b=B2v4eccvJMwwA5By+mgpZZFzNGChojkrceIPJZ1VWmHZZONPZjFTnhut/zXBW7viU4U5LlJ4D9ONmpRLImbzLEI3cNGVYG0aUiPn0YEjCQpdD7vweKPGPsHEhI+07rTuXLVtUEveIN7rwRO0vTcrSprX9qeBRroV+FE3ynPF3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070977; c=relaxed/simple;
	bh=+d4ARO8Vay5p5+K+ziVI7fR/yprqVjm+2uQ+B6um80k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6CQ2W7HMXCdXhPbMcU/zpV0Zig5dIP2/uIelNs9kkhMLG0Pc9oRRZSB0JNz7yQ6DtjZS+gw0Tsuk2Za+lJOPvfiWrHJit2g1/XuulJz7VDvSWUODc7SosyutHIcEqBXEx8ZiErDDIJ9AgOxXFNtD6HziEjRTV/tYyiSDf9dTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rfp5OYcT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rfp5OYcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72760C4CEE7;
	Mon, 12 May 2025 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747070976;
	bh=+d4ARO8Vay5p5+K+ziVI7fR/yprqVjm+2uQ+B6um80k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rfp5OYcTWVhbB7/6OtrOIdN8pAlt9IQpzcrprh6nyk0F/4fvKzQPoHLbQqDa+VnHv
	 7j5M3cknysEiSXXc7PLhROzNP/uFQ60pbj+wawKbCv5XAaZBBKA0lg2Ij4xJZFMB+8
	 RwvnwWIH5E7OQurBlQGkPVrwh6rhUeG6e/47e7bju7EpRGhuSW2tKFfHRtty28mPc8
	 4SKhtXEjiRJHXojSNZp1SjZEYeoNfSVvUFZ+MCHPF5pNaVz2VyS+q9akIcdENyUHw4
	 evv+uAy5f3rWuXpM7HxRnCqvKOUxqYLQqe2d92RTp2VZlmLz3MY5pndblIqDB9wkXb
	 zWQ0I5N7G0BXQ==
Date: Mon, 12 May 2025 14:29:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	John Garry <john.g.garry@oracle.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Metric related performance improvements
Message-ID: <aCIv_ZWji8xR02iq@x1>
References: <20250410044532.52017-1-irogers@google.com>
 <Z_dp7E2wtSek-KHo@z2>
 <CAP-5=fU6NM4LZWt9SdTFX9JKTgfghwAVvtXc-qBuUb0vpUeTQA@mail.gmail.com>
 <aCIkl8Skof--Of99@x1>
 <CAP-5=fWFRtnVjeNu97jW6DYyE8S7o8RkSn87jpQDE4zw==HVSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWFRtnVjeNu97jW6DYyE8S7o8RkSn87jpQDE4zw==HVSQ@mail.gmail.com>

On Mon, May 12, 2025 at 09:57:45AM -0700, Ian Rogers wrote:
> On Mon, May 12, 2025 at 9:40 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Hunk #4 succeeded at 451 (offset 11 lines).
> > Hunk #5 FAILED at 541.
> > Hunk #6 succeeded at 657 (offset 41 lines).
> > ⬢ [acme@toolbx perf-tools-next]$
 
> Thanks Arnaldo! Happy to send a rebase on tmp.perf-tools-next if useful.

Sure, I just pushed what I have:

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -10
255f5b6d060be5a4 (HEAD -> perf-tools-next, x1/perf-tools-next, x1/HEAD, perf-tools-next/tmp.perf-tools-next, five/perf-tools-next, five/HEAD) perf parse-events: Add "cpu" term to set the CPU an event is recorded on
168c7b509109fe26 perf parse-events: Set is_pmu_core for legacy hardware events
f60c3f44689ac2bc perf stat: Use counter cpumask to skip zero values
2e7a2f7f3c6e3a99 libperf cpumap: Add ability to create CPU from a single CPU number
365e02ddb65d443f perf tests metrics: Permission related fixes
f0869f31562bde2e perf evsel: Add per-thread warning for EOPNOTSUPP open failues
17e548405a81665f perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3
352b088164b5cde1 perf intel-pt: Do not default to recording all switch events
e00eac6b5b6d956f perf intel-pt: Fix PEBS-via-PT data_src
cd17a9b1a779459d (perf-tools-next/perf-tools-next) perf test demangle-ocaml: Switch to using dso__demangle_sym()
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo
