Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDA3064B5;
	Mon,  5 Oct 2026 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240284; cv=none; b=g+8fvJYJtARLoOMsfgDqXz0ScN2yxEGhp9cd9pvJ1if1w6/gf0zVMIrNUaKbaXNlMYkAP7FnT3ChDsP9eXe7j70vrbRNRjXT0c7K9hZCm47pq2GKwAIX9PVdN3KpSlYc/bXkR4cy1kBuru/uy3C9sPCpdJjTn1omjopCAepZroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240284; c=relaxed/simple;
	bh=dwYzbdQ1B/JSGSGnEmkLzad5oUP224aEmrBywC4kFgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrrCop/UpgoEkznB71CcAKIaA8THjniGOo5BPOjjmjnP340LKJ4NxYwbSAAWXKIdMVw8P8PXTL+WN5+Di9uQ4LQYY1WAIPHRaSYtkrWInsO/g0qSj1a1MKylwrLQUucsieaGNWLwXrKQescaEkhKNZOAqOZ7evshZGKWsejpk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN/tvqZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN/tvqZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE3D1F000FF;
	Mon,  5 Oct 2026 22:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791240283;
	bh=mAif6fUSfIAXR2mzufrQU8zeL0ZREPraNNRHJZ03CMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lN/tvqZhtdxKX5S2ROMoBmcM1sFpSKQsOl/ZxWbRbrhyXfZa1ULSH4lOtG2Dr8sj1
	 PGyPVVNXZx3LWMOu4VJAswnUcZlfejU+R+2pbVC5S0aCObGJ7iEPZu9ZE/d061mRpe
	 45dhu+d3bt6DgY1qmklgAuPkYcas/tmvmmyF3AYslic+9APKoQqugUSELClpBqDwNX
	 PgeKqWQyOs7qhS4c+xTI8LSUuzXiVRlrTJw6jKZK9ZtwGV4UASwipQFexELjXEBugp
	 rYNxz2vaH0nlbpUtqTU9IoiZzKxCKdjN08fCbKTR36ZGy1j47zTkNA/Hjd0UyyAhhF
	 QowCv2iV9gfRw==
Date: Mon, 5 Oct 2026 15:44:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, 9erthalion6@gmail.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v3 1/2] perf test: Add per-test timeout support
Message-ID: <asQoWrGYmM-lGx5G@google.com>
References: <20260929011837.4157334-1-irogers@google.com>
 <20260929025345.88829-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929025345.88829-1-irogers@google.com>

On Mon, Sep 28, 2026 at 07:53:44PM -0700, Ian Rogers wrote:
> When a test hangs in 'perf test', the entire test run hangs and makes it
> difficult to inspect output from other tests.
> 
> Add a new TEST_TIMEOUT result category and a per-test timeout (default
> 60 seconds, configurable via '-t'/'--timeout', with 0 to disable). When
> '-F' ('--dont-fork') is specified, timeouts are disabled.
> 
> To enforce the timeout:
> - Place each forked test child into its own process group via
>   setpgid(0, 0) in the child and setpgid(pid, pid) in the parent so any
>   subprocesses spawned by shell or workload tests can be terminated
>   together.
> - Arm an ITIMER_REAL periodic timer with a SIGALRM handler (using
>   SA_RESTART so /proc status reads in check_if_command_finished() are
>   not interrupted by EINTR while poll()/usleep() waits still wake up).

Do we really need this timer?  I think poll() already has a timeout so
it'll wake up on every 100 msec anyway?

Thanks,
Namhyung


> - Check elapsed child runtimes against test_timeout in finish_test() and
>   finish_tests_parallel(), sending SIGTERM first and escalating to
>   SIGKILL after 1 second if the child process group has not exited.
> - Report timed out tests in red ('TIMEOUT!'), track and display them in
>   the test summary, and emit '<error message="TIMEOUT" type="timeout">'
>   counted under the 'errors' attribute in JUnit XML output.
> - Document '-t'/'--timeout' and '-F'/'--dont-fork' in perf-test.txt.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
