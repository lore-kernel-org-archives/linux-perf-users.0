Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0037383C84;
	Wed,  3 Jun 2026 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514869; cv=none; b=D14NCT+Z7DUSoL709Yy/sLhOFtyldE6MS7RbipW06Q7yeIZtRaUWKRwfnPUqCe0WDTOlhXzH/ARsA6APkfcBRTKpaocgYFYbeWlA8RBuC2hONpGM+ZeIVxu97jePoPNucTgtxyf4aidN3KrUXExuOlGqkAbWkcOFXZIF4Q52TjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514869; c=relaxed/simple;
	bh=o/22M7P+INoioOOArzYLVw3IKuJUjL29vLeAVZyXON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj7H3iM0s8LxXJkDxHtKMPXYOFWwwU4R8Tr8ksRwCywybsMoFpmuJuHUFtAfE/j9Y1qbZgjIb356BLzmdM1NE/Qm2hztx+SM3lQWGBWPNyAuL8nmOnh9mzuCJPWTT8x+8tpCdCvgDemdeZHj6waushEd6uSU2g9ZnJb1Iq1yD/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofN8r4OM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofN8r4OM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5472A1F00899;
	Wed,  3 Jun 2026 19:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780514868;
	bh=rZerQptZ5vemt8600ZPlZNRBVKRMnrDaBTnaGv+LyP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ofN8r4OMYdh71bgaDRRnEQAr+5dsBPvG+dWVnIZf4At4Kc8KEyt9ZWaSBU/qAuOq1
	 TcnuWPvZXpkhJFpPwrfCRhCL4pQ2dalAmMJYdyP+0X+WZnBV95SIy1M/VqaFhpIalV
	 kApaPjgVp3k0TusZbQVOODm22ViPW2PxInxYXkA+KwPmMQZcsqgRiePplEa6IBqS91
	 RpEBhOnfMU8moWRsmFqoMgkYPQv/H6cvDzFxKUmasP9fp68mkaEeLfpDlvqq5tin7L
	 hnrAq1QPDWkdtGTWtt7hsMMsQzMc6ZswiS9PtaSzktDhYy48igSYc7Gki5x4kJkZ8+
	 RvDPz5xWo895g==
Date: Wed, 3 Jun 2026 16:27:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES 0/8] perf tools: Diagnostic offsets in skip messages +
 two hardening fixes
Message-ID: <aiCAMLNG_VBvUZy9@x1>
References: <20260602235709.1541603-1-acme@kernel.org>
 <CAP-5=fVR5zLokhki3CnQTkG1Lb0C2y=BYVRUEYG9fsCXWVfZ5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVR5zLokhki3CnQTkG1Lb0C2y=BYVRUEYG9fsCXWVfZ5A@mail.gmail.com>

On Wed, Jun 03, 2026 at 08:06:48AM -0700, Ian Rogers wrote:
> On Tue, Jun 2, 2026 at 4:57 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > When perf report, perf sched, or perf timechart skip a malformed or
> > unprocessable event, the warning message doesn't say where in the
> > perf.data file the problem occurred.  This makes it hard to
> > cross-reference with 'perf report -D' output or to locate the
> > corrupted region with a hex editor.
> >
> > This series adds a file_offset field to struct perf_sample, set in the
> > event delivery path (including the deferred callchain path), and
> > retrofits all skip/stop/error messages to include:
> >
> >   - The file offset where the event was found
> >   - The event type name via perf_event__name() with the numeric
> >     type value in parentheses
> >
> > For example, instead of:
> >
> >   problem processing 10 event, skipping it.
> >
> > a user now sees:
> >
> >   WARNING: at offset 0x1a3f0: MMAP2 (10) event size 24 too small (min 64), skipping
> >
> > The peek_event() path, which validates events during initial file
> > scanning, also gains file offsets in its three warning messages
> > (misaligned size, unsupported type, undersized event).
> >
> > Two pre-existing bugs found by sashiko-bot are fixed:
> >
> >   - builtin-timechart.c cat_backtrace(): use-after-free and
> >     double-free when an invalid callchain context triggers zfree()
> >     before fclose() on an open_memstream buffer.  The open_memstream
> >     contract requires fclose() before the buffer can be freed — see
> >     open_memstream(3).
> 
> Fwiw, I've also been around the timechart code prompted by AI review
> and also trying to clean up tests with address sanitizer:
> https://lore.kernel.org/linux-perf-users/agzWqrn6XPEwTAsb@google.com/

Thanks for all the reviews, I'll merge this series since sashiko found
just one endianess issue with the new 'perf test' entry and the other
comments are for pre-existing problems that we've added to TODO lists,
then you can rebase that timechart leaks on top of it, ok?

- Arnaldo
 
> Thanks,
> Ian
> 
> >   - builtin-sched.c: three BUG_ON(cpu >= MAX_CPUS || cpu < 0)
> >     that abort perf sched when PERF_SAMPLE_CPU is absent from the
> >     sample type and the CPU sentinel (u32)-1 is cast to signed -1.
> >     perf.data is untrusted input — a corrupted or truncated file
> >     should produce a warning, not an abort.
> >
> > Arnaldo Carvalho de Melo (8):
> >   perf sample: Add file_offset field to struct perf_sample
> >   perf session: Include file offset in event skip/stop messages
> >   perf sched: Include file offset in event skip messages
> >   perf timechart: Include file offset in CPU bounds check messages
> >   perf tools: Include file offset and event type name in skip messages
> >   perf timechart: Fix cat_backtrace() use-after-free on corrupted callchain
> >   perf sched: Replace BUG_ON on invalid CPU with graceful skip
> >   perf test: Add file offset diagnostic test for corrupted perf.data
> >
> >  15 files changed, 261 insertions(+), 101 deletions(-)
> >
> > Developed with AI assistance (Claude/sashiko), tagged in commits.
> >
> > Best regards,
> >
> > - Arnaldo
