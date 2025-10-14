Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEB1D555;
	Tue, 14 Oct 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450670; cv=none; b=bSF3iDYCBjPL0G3oNFrVddT7cpFEmZoEbibQw3wNL5uWEE48YD+zlAS88lWisTabqUWXymec6RgVwsZwMcN7Wj0cYa1BamfcTnDkYkGPFF3Ws3mTts/ogdhAKXnzAyrdQtABSJFKwm79waHrgi9Isrv2EDyeeFbii/9ERgoXq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450670; c=relaxed/simple;
	bh=frZy9oGFvGHgFZBr5Y7kQCzcpftquk7efK652Jvx0iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9Pb+MuEJfNo7SYTTPN43p5NAR6RZcnEwACrCyYKl/02UWteslkzyQ6tJFL0MccvehgQ+QMVtQhu+wk/5WwicZFVvsGbzK8N5W/nsZXmwZBmXBvfG3E1vHzfb/8RCnqH0MlunYKysTFEJp4MdhGjY9lSckT8hc3VEVi4JnaeIW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsmibqZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsmibqZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3B2C4CEE7;
	Tue, 14 Oct 2025 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760450670;
	bh=frZy9oGFvGHgFZBr5Y7kQCzcpftquk7efK652Jvx0iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsmibqZPDtQvyJ03XUnrYjHoCl7S0+/xSDHq2noNIXb+9hkAu21HfJ+oVu9ES2lIU
	 qc7F2qQY/QpyClDV0pCgB5/deUrenKah63hy2z9ZtIvwbKW+n1y07EXDWJ/+LUuGfD
	 ZUdWID+VqPi8bP13uCtY5VkGfwzxd6wdWatnctbM/++uVksB7Ca2Xgw8XpjvGUDWGD
	 vV9pdKFjFVPVxgknAGNW5dlHWor17pyW4vCfalA35SNp+6sg6jHt1o7ra+5zWkGcsz
	 I1XcgOEDTgTDtr+1fYpKpn0Prd4r2R7CQSYcBSYiXDGUUY68ehO4TR8bSljW0Cg/je
	 GzL6MfIHy1CLQ==
Date: Tue, 14 Oct 2025 23:04:25 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Additional verbose details for <not
 supported> events
Message-ID: <aO5YaR_B8ZYMdHa_@google.com>
References: <20251005181421.2787960-1-irogers@google.com>
 <aOYkRdU5pn_jTOq3@google.com>
 <CAP-5=fUqYeaE_P3ApXvq7j9SRuNXpLf+mK-4XBsvv2R=OTccbQ@mail.gmail.com>
 <aOdNWrIAQMkaVsqR@google.com>
 <CAP-5=fVERf8jf3MrwiEfQtChvC1KUe0EEASK1aVk-UKkk=Pb0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVERf8jf3MrwiEfQtChvC1KUe0EEASK1aVk-UKkk=Pb0w@mail.gmail.com>

On Thu, Oct 09, 2025 at 06:31:51AM -0700, Ian Rogers wrote:
> On Wed, Oct 8, 2025 at 10:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Oct 08, 2025 at 09:31:53AM -0700, Ian Rogers wrote:
> > > On Wed, Oct 8, 2025 at 1:43 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Sun, Oct 05, 2025 at 11:14:21AM -0700, Ian Rogers wrote:
> > > > > If an event shows as "<not supported>" in perf stat output, in verbose
> > > > > mode add the strerror output to help diagnose the issue.
> > > > >
> > > > > Consider:
> > > > > ```
> > > > > $ perf stat -e cycles,data_read,instructions true
> > > > >
> > > > >  Performance counter stats for 'true':
> > > > >
> > > > >            357,457      cycles:u
> > > > >    <not supported> MiB  data_read:u
> > > > >            156,182      instructions:u                   #    0.44  insn per cycle
> > > > >
> > > > >        0.001250315 seconds time elapsed
> > > > >
> > > > >        0.001283000 seconds user
> > > > >        0.000000000 seconds sys
> > > > > ```
> > > > >
> > > > > To understand why the data_read uncore event failed, with this change:
> > > > > ```
> > > > > $ perf stat -v -e cycles,data_read,instructions true
> > > > > Using CPUID GenuineIntel-6-8D-1
> > > > > cycles -> cpu/cycles/
> > > > > data_read -> uncore_imc_free_running_0/data_read/
> > > > > data_read -> uncore_imc_free_running_1/data_read/
> > > > > instructions -> cpu/instructions/
> > > > > Control descriptor is not initialized
> > > > > Warning:
> > > > > kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> > > > > Warning:
> > > > > kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> > > > > Warning:
> > > > > kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> > > > > Warning:
> > > > > data_read:u event is not supported by the kernel.
> > > > > Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
> > > > > Warning:
> > > > > kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
> > > > > Warning:
> > > > > data_read:u event is not supported by the kernel.
> > > > > Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
> > > > > cycles:u: 351621 362833 362833
> > > > > failed to read counter data_read:u
> > > > > failed to read counter data_read:u
> > > > > instructions:u: 156184 362833 362833
> > > > >
> > > > >  Performance counter stats for 'true':
> > > > >
> > > > >            351,621      cycles:u
> > > > >    <not supported> MiB  data_read:u
> > > > >            156,184      instructions:u                   #    0.44  insn per cycle
> > > > >
> > > > >        0.001584472 seconds time elapsed
> > > > >
> > > > >        0.001811000 seconds user
> > > > >        0.000000000 seconds sys
> > > > > ```
> > > > > where without this change only "data_read:u event is not supported by
> > > > > the kernel." is shown.
> > > >
> > > > I think what you say is:
> > > >
> > > > Before:
> > > >   data_read:u event is not supported by the kernel.
> > > >
> > > > After:
> > > >   data_read:u event is not supported by the kernel.
> > > >   Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
> > >
> > > I kept things verbose as unfortunately the
> > > "kernel.perf_event_paranoid=2" is important as is the use of
> > > per-thread mode. Different paranoia levels lead to different errors
> > > and unfortunately a lot of the time the error gets reported as "
> > > data_read:u event is not supported by the kernel." and I'm not sure
> > > all users will get that the key part there is the :u modifier.
> >
> > Yep, I'm ok with the change.  But the changelog was a bit unclear what
> > is being added exactly.  IIUC we already have the paranoid message with
> > the verbose level 1.
> 
> I thought the line:
> """
> where without this change only "data_read:u event is not supported by
> the kernel." is shown.
> """
> covered this?

Yep, I've updated the commit log a little bit and applied to
perf-tools-next.

Thanks,
Namhyung

