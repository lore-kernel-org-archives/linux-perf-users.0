Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22799189;
	Fri, 19 Sep 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311497; cv=none; b=W7IxhE5hMsneCoOa4TCtXDA049fvwRZrRePuAqQhVRBgG3inWLLx00jIK34IoZyS+R28Xw7Jty+1TEu8MQV02LQPZJwny9hifKWsax8SsNkub5riFkjxwnEIpCSdLO1T74WY1ajwaRAO4P0cxsmGLUH+Ihs38OoEkchGFx9GjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311497; c=relaxed/simple;
	bh=KybzcXPWi3sYZzfevroMDDwX/vP+N9D1rNARn6uAgTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vgt9O9rT6AUh50Fb5PprnE4eZHutXIni+OOICnd9OvHJ1sqr+Mi78i1uKH9xnAVcePfvfETC9fVb4BfRZSn1r3+knHKW4Ko9QFd2cwMaTaeVWkkyu2fcSCbuwxjW1Q1KeAJMzJ5or9dX02Nk5NQkVUqYur4duZa1AIWckiImX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McJXvVQp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McJXvVQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E61C4CEF0;
	Fri, 19 Sep 2025 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758311496;
	bh=KybzcXPWi3sYZzfevroMDDwX/vP+N9D1rNARn6uAgTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McJXvVQpiXEALNhl/5KQcG7gSufJVp9u9fsEezE482ConwP1tS6x9RPFcQxug90lT
	 7NJcv1SLecU59ApMwU9uiLY4bsFRR7N3OImcexEFbVKAoougDjYJgo9Nh4HjnQumdf
	 Q008oQ52XiLYwshp5J5QUyLJIjedU7OAwidjc9mkeuiwf93qrvBXXhJ5h7O4YR/pB3
	 bR8ej0Obkyn3xfFUZhsYDDl7MH/dVQP4WEYitDjk4koG1g1hHXSEPT0LgneGFqhvBQ
	 BJdUUzUmcqYEd02cpQZb/1lnzQvD+X7/39261vVz/VJOAhxnO5xlckn9l1VlDxrR/U
	 A+JSUHhZ1rwsw==
Date: Fri, 19 Sep 2025 16:51:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Chun-Tse Shao <ctshao@google.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Test/uniquification related fixes
Message-ID: <aM20RJuQLsY8kqdF@x1>
References: <20250918222202.1353854-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918222202.1353854-1-irogers@google.com>

On Thu, Sep 18, 2025 at 03:21:59PM -0700, Ian Rogers wrote:
> Failures discovered running as non-root and with v6.17-rc1 changes.
> 
> v2: Fix uniquification test when running as non-root. Rebase on
>     tmp.perf-tools-next where the first patch was already merged.

Thanks, all reproduced before/after and applied.

- Arnaldo
 
> Ian Rogers (3):
>   perf test: Don't leak workload gopipe in PERF_RECORD_*
>   perf evsel: Fix uniquification when PMU given without suffix
>   perf test: Avoid uncore_imc/clockticks in uniquification test
> 
>  tools/perf/tests/perf-record.c                |   4 +
>  .../tests/shell/stat+event_uniquifying.sh     | 109 ++++++++----------
>  tools/perf/util/evsel.c                       |  28 +++--
>  3 files changed, 71 insertions(+), 70 deletions(-)
> 
> -- 
> 2.51.0.470.ga7dc726c21-goog
