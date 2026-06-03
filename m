Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B038734D;
	Wed,  3 Jun 2026 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529679; cv=none; b=D1yptungPYIqYkJfRxeBHYqtPDP5felwldFtfgk/mVqCmv3dgdw67NNRpSw0oNyDiZ92AJ15iD9Ae6aaNzGxqS3u8zOLK6hN6aJbyMnVPBdZdjQ55nMRA/8wX5ss+ae48H8ijdS48xV6y9TCBFRXTp+1s1F9noipQzQIq0gfwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529679; c=relaxed/simple;
	bh=MoSi0iugHJ0m46DZ75sGscH+dBGeYIu5jH2c6jZ2P5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7lmDq/RolwctjVbUWodGK6uUoyoqO+1rYMw04b/91akydL9pl5QXGUnzQd1W19vxkggnz5Sbh90Z2GfrddGd8myGaF268OYrheODhF6cNbZhZOSVxCPS2CutGy/v1xrNO0w4ypVyHPE6jVf6DUu2qLTh313n5tzLBNydiN2OaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N10+TDw0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N10+TDw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916851F00893;
	Wed,  3 Jun 2026 23:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780529678;
	bh=6cCwYgAkNPrf7vLCg/dYplYz2x3eUTQN3J3u2BEzz0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N10+TDw0e7XrxuqpSv+dL1tBLFMtyyYNJGIsw6eFt1i5VmfFJ1Oyk4S110JJdT2Ik
	 h93FeuhMGNLIAj/LNCLXsS+6Y6YRjr/U1NS09YRhXJwX1PbYR4rVs012AKJABgAzKl
	 yCxDMB0Bj/uWRFebWDfZyLzbjQtx4w2IMM8Dp/S3GBp7T4HylYmx1/95ZfxwzNmbts
	 MvCuKh/eyuB6kwzG3+KsEFuabMeuvtcxsXUOCizffHC4QpuzbkWbSOLQxDUOlQ7D92
	 XLBSwcJq2JGBctedNQbntX0nPoTMuhd6jXfnInJ13m0k4fUReoftTFef+q5jSY7/v9
	 GZqr++dGxAvaQ==
Date: Wed, 3 Jun 2026 16:34:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4] perf bench: add --write-size option to sched pipe
Message-ID: <aiC6DA3o4L7mx0S7@google.com>
References: <20260603-perf_bench_pipe-v4-1-f48c0ba6d6cb@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603-perf_bench_pipe-v4-1-f48c0ba6d6cb@debian.org>

On Wed, Jun 03, 2026 at 03:35:07AM -0700, Breno Leitao wrote:
> The default ping-pong uses sizeof(int) (4 bytes) per iteration, which
> exercises only the pipe-buffer merge path and keeps allocation entirely
> out of the picture. That makes the bench a useful scheduler / context-
> switch latency probe but unable to surface anything from the pipe
> page-allocation hot path.
> 
> Add a -s/--write-size option that sets the bytes written and read per
> ping-pong iteration. The buffer is allocated for each side via
> struct thread_data and replaces the on-stack int previously used. The
> default remains sizeof(int) so existing invocations are unchanged.
> 
> With --write-size set above PAGE_SIZE the bench drives anon_pipe_write()
> through alloc_page() (or the bulk pre-alloc, if the relevant patch is
> applied), which is what we want when measuring pipe locking and page
> allocation work.
> 
> The bench is a ping-pong: both sides call write() before read(), so a
> single write_size payload must fit entirely in the pipe buffer or both
> sides deadlock waiting for the other to drain. Resize the pipe via
> F_SETPIPE_SZ to match write_size (skipped at the sizeof(int) default),
> and error out cleanly when the request exceeds
> /proc/sys/fs/pipe-max-size.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
