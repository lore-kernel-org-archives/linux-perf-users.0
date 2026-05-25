Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F02DAFCB;
	Mon, 25 May 2026 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740066; cv=none; b=G4dHJK22ZI9/zI+aVszuTbg3ZIqhkBactbPJMbDoPrcBkZRwutr45DkrY4lXrev4PhMGPn0P7u9vmgXYU4qtIo/kPT2LMuC6bREvMnkg5HluP59cCK8ihOZynk1Gw8WkYVhpp7caYWv+xd/00anMxI4YFcT/13rkPRDbrfNHjyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740066; c=relaxed/simple;
	bh=zSWlLZhwdFJUAHdoiSFFiPnunTxNQAbB1qSNP7QJ9GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK/b0ElmOdOof1YjjDvUebvpLcPkb+aqUU5jvW9w6WVTN9UXiPbAcIJ94Chmd+t2a5jYjWrcSiY1d4eIEf1/YgvrVyiBnu0C5B7vokHfsgV6391sMFHnKwcZI0cmwsZXLJjKgWplS4Z4ylWBzdyh6lk+6fs3Ct13NsEmPgckVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diR2+1wb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diR2+1wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43801F000E9;
	Mon, 25 May 2026 20:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779740065;
	bh=vKMrNHjeXL1DWvgeu+GECwrasTsPYGvFygFpV8a+a+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=diR2+1wb5Lg99h3bffkc8h2xgx8OC8HOI643EMKVYMO4a/VHJ7mUr01BD7WIlLs2D
	 YMD8PpJ0U3NUf2N8zuFLIViF/Ei+V5dE1lneMPjYhH1TsLwgtg8eXZOsTe0oQp32SM
	 b0cByFiZTXGWe2LtA7PKEHg0VWqVMlkyi2cYlHG7PFZ5PYAuj55uk4lJUCdfTkozZY
	 o1Rl99Y3tz/Ndp4nx5447jB9O0TdDEHq0eQa8cQUmWsaNBTluuihgyMmcj9OEzlSkr
	 unSFld5Hpeigk80kFh1683p3mouu0pCY2tejlz02ZhUtcTBFfnwZQXYBp7/W95pTue
	 f98Njn6Ipt5EQ==
Date: Mon, 25 May 2026 17:14:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com,
	alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, leo.yan@linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v9 00/23] perf python: Modernize and extend Python API
 (Phase 1)
Message-ID: <ahStntuCibNk-IjO@x1>
References: <20260428071903.1886173-1-irogers@google.com>
 <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>

On Fri, May 22, 2026 at 03:04:11PM -0700, Ian Rogers wrote:
> The perf script command has long supported running Python and Perl scripts by
> embedding libpython and libperl. This approach has several drawbacks:
>  - overhead by creating Python dictionaries for every event (whether used or
>    not),
>  - complex build dependencies on specific Python/Perl versions,
>  - complications with threading due to perf being the interpreter,
>  - no clear way to run standalone scripts like ilist.py.
> 
> This series takes a different approach with some initial implementation posted
> as an RFC last October:
> https://lore.kernel.org/linux-perf-users/20251029053413.355154-1-irogers@google.com/
> with the motivation coming up on the mailing list earlier:
> https://lore.kernel.org/lkml/CAP-5=fWDqE8SYfOLZkg_0=4Ayx6E7O+h7uUp4NDeCFkiN4b7-w@mail.gmail.com/
> 
> The ultimate goal is to remove the embedded libpython and libperl support from
> perf entirely, expanding the existing perf Python module to provide full access
> to perf data files and events, allowing scripts to be run as standalone Python
> applications.
> 
> To make the review process more manageable, the original 58-patch series has
> been split. This v9 series represents "Phase 1: API & Infrastructure" (23 patches).
> It contains:
> 1. Missed explicit dependency cleanups and header sorting.
> 2. Crucial core safety infrastructure (reference counting for evlist/evsel)
>    to support safe lifecycle management in garbage-collected Python.
> 3. The core Python API extensions (session wrappers, perf_data wrappers,
>    sample accessors, stubs, and LiveSession helper).
> 
> The subsequent "Phase 2" series will contain the actual porting of all
> existing Python/Perl scripts to the new API (which yields up to 35x speedups
> as demonstrated previously) and the final removal of embedded interpreters.

I tried applying it now and got this:

Cover: ./v9_20260522_irogers_perf_python_modernize_and_extend_python_api_phase_1.cover
 Link: https://lore.kernel.org/r/20260522220435.2378363-1-irogers@google.com
 Base: not specified
       git am ./v9_20260522_irogers_perf_python_modernize_and_extend_python_api_phase_1.mbx
⬢ [acme@toolbx perf-tools-next2]$        git am ./v9_20260522_irogers_perf_python_modernize_and_extend_python_api_phase_1.mbx
Applying: perf arch arm: Sort includes and add missed explicit dependencies
Applying: perf arch x86: Sort includes and add missed explicit dependencies
Applying: perf tests: Sort includes and add missed explicit dependencies
Applying: perf script: Sort includes and add missed explicit dependencies
Applying: perf util: Sort includes and add missed explicit dependencies
error: patch failed: tools/perf/util/evsel.c:11
error: tools/perf/util/evsel.c: patch does not apply
Patch failed at 0005 perf util: Sort includes and add missed explicit dependencies
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbx perf-tools-next2]$ git am --abort
⬢ [acme@toolbx perf-tools-next2]$ git diff
⬢ [acme@toolbx perf-tools-next2]$

I agree with the intent and plan on reviewing and testing it.

- Arnaldo
