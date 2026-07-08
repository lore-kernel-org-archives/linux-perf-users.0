Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464C38B12F;
	Wed,  8 Jul 2026 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554066; cv=none; b=d7h4kWVFS5I9U7oqgdqNcAErP4mTz9Y7pzui6KKdqRFHnrIopIjg5ACZu/bVBb/gZrlvOB13QqUYXr5XJfL+CmBcTWq11JrB1vVHv8O0hDYlQsMjWm3uB8GIcA3GDCVlF+PQjDqsrpnsGc0abRPUlMrGIxwdrWZklf5y/2IrFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554066; c=relaxed/simple;
	bh=MqgnQR2IhngHT0tSVjp0X8uJaVghyFuxobtWUdkIOHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl+lF3RhkQVlFPJbTFtuEKb1lA1jSVMhhlgK1ilIJ5d07iv4I7QegDdAQjfzh1oozyllxPbuHhnQd82qeoMJTZbS518AROdD2OQmEndxElHPvNDGZ3stcYV59Gaa1sk+qE+GP3yHUFpTxAcsBMgOv2xtorV0qFZ6qbhREeJFAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXr1Ww1W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXr1Ww1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ADF1F000E9;
	Wed,  8 Jul 2026 23:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783554065;
	bh=lrlgyio4LLb/bAWF+O2R0MU6fah4CsfXynnnc8OZ4uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aXr1Ww1WaQDbSpVRc8BociBWboqWjijuIT2mNWqsfkqh0iK47jtyLS27ACKVCmCf7
	 lUHhzN+ijGjM0f2mquLI5jFzYVyXc5ICAd1xRmBz84naTpPiAcHBpCZhZtQjbP03xD
	 0wWJ8nYTTDqm3FUfWSeBApFivqTCgSuHKWz7FDJLXXyiWLowGOywu5BjK7CBNJAk+2
	 jPOpOq2NhBh5XvxNtwxMnrDeMMprLzvrjIuAE0+b6NB1eRIJUtZlMSd4zcYgj95LYS
	 lbzzbZqUNeDF3iqkUia8MlA/3KxNageF43BqxtY5mpsfY3cK2e7xOqRael/iwl8zmY
	 E/+7nKlKxEgNg==
Date: Wed, 8 Jul 2026 16:41:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf tests: Restore -p flag to lock contention test
Message-ID: <ak7gDlPRhIL3MviB@google.com>
References: <20260708175311.858850-1-irogers@google.com>
 <20260708175948.567701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708175948.567701F000E9@smtp.kernel.org>

On Wed, Jul 08, 2026 at 05:59:47PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Adding the `-p` (pipe) flag to the global workload unconditionally disables the stack filter tests.
> --
> 
> --- Patch [1]: [PATCH v1] perf tests: Restore -p flag to lock contention test ---
> commit b4bb7054950dea7123c601308622ddcd596c94cf
> Author: Ian Rogers <irogers@google.com>
> 
> perf tests: Restore -p flag to lock contention test
> 
> This commit restores the -p flag to the perf bench sched messaging workload
> used by the lock contention test. By defaulting to pipes instead of
> socketpairs, it ensures architectures like s390 generate sufficient lock
> events for the BPF trace filtering logic to pass.
> 
> > diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> > index ba598370be738..5df9a0cd48a34 100755
> > --- a/tools/perf/tests/shell/lock_contention.sh
> > +++ b/tools/perf/tests/shell/lock_contention.sh
> > @@ -11,7 +11,8 @@ errout=$(mktemp /tmp/__perf_test.errout.XXXXX)
> >  
> >  # Workload to generate lock contention.
> >  # Using 1 group (-g 1) keeps runtime low while generating sufficient lock events.
> > -msg_workload="perf bench sched messaging -g 1"
> > +# We include -p (pipes) because socketpairs don't generate enough lock events on s390.
> > +msg_workload="perf bench sched messaging -g 1 -p"
> 
> [Severity: Medium]
> Will adding the -p flag cause test_stack_filter() and 
> test_aggr_task_stack_filter() to unconditionally skip?
> 
> These tests explicitly verify filtering behavior by searching for unix_stream 
> locks in tools/perf/tests/shell/lock_contention.sh:
> 
> test_stack_filter()
> {
> 	echo "Testing perf lock contention --callstack-filter (w/ unix_stream)"
> 	perf lock contention -i ${perfdata} -v -q 2> ${result}
> 	if [ "$(grep -c unix_stream "${result}")" = "0" ]; then
> 		echo "[Skip] Could not find 'unix_stream'"
> 		return
> 	fi
> 
> Since pipes use pipe locks instead of AF_UNIX stream socket locks 
> (unix_stream), the shared perfdata profile will no longer contain these locks. 
> 
> Does this mean we lose test suite coverage for the --callstack-filter option 
> across all architectures because the grep will always return 0?

I think it's a valid concern but it didn't come from this change.
Maybe we need to check different symbols like "pipe_".

Thanks,
Namhyung
