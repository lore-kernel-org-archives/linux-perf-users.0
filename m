Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11734AAE2;
	Thu,  4 Dec 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875450; cv=none; b=EZpSLHZzBbheZYGP+isRWMICYHXHTZkpH7T9yTWgyBLY24hZ8j/UYDv+BgDpnioCgmlCyUTN7tqGtD0bz5TgZXOEFZhUkpL3zdJ6aROFvfx8LNCqhhm3ZqADRNypSh0qaADLjz/dkigbnrPZacQ8xphH0apDJzZ18x7Kij4huqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875450; c=relaxed/simple;
	bh=CFWsJfr3fP39HGmtCGaF7ehnwfFGxX9jbDd9MyItYjI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NOexOgoR/hLqbbyKcFj4sAIU6TNrfLZmClhHeUBbm9PyTVF6PLCz5OmV1fgGCKEGMAltey/L8T1fZxwGINfXHxm+Lu8CegYwd53+9QgTuefHZB5wXL+L/38CJkooRqhKKpco/UWgI7RkA5IgSKNWSGt5lfCoM28q1+PZjrdO0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzdZq7hO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzdZq7hO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDD5C19424;
	Thu,  4 Dec 2025 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764875450;
	bh=CFWsJfr3fP39HGmtCGaF7ehnwfFGxX9jbDd9MyItYjI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=uzdZq7hO4hzz2BrHFKOpP8B4S0QZfWGrs/UkahCc4Kmh2PM0wGUrFMbT2Xy3CpfRT
	 74eyRoJu4wjByQH7A5qP+Q9QwJfQuti6RSjxph85RqQ0kwIN0wmodztWU+iFCEc8/Q
	 P9QDLZbRdNcBMGFVdhyyrDLcJ1/nTo0/jRhsKOgXSL5QzMMYRd1YSU8TXzZnz6z/Wf
	 58VnEnc+lSxjZSk8M7Tld0Wz7Q8ODoxUJIJ13+yCtpH1wor/J4qPKotYqMXqpd5IKF
	 Z/XqrfSzPQpKsR+pfgMUuWHQpbtMMvjEH3UWUyLHanfGaLzN7cLiObSSlzxdX+YH59
	 5TYDsV5hiO8ew==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
 Stephen Brennan <stephen.s.brennan@oracle.com>, 
 Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
References: <20251122081929.7588-1-irogers@google.com>
Subject: Re: [PATCH v1 00/17] perf: Small fixes and new tests
Message-Id: <176487544861.182574.4835277830514985189.b4-ty@kernel.org>
Date: Thu, 04 Dec 2025 11:10:48 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 22 Nov 2025 00:19:12 -0800, Ian Rogers wrote:
> Pushing for additional test coverage exposed minor fixes, a missing
> timechart option, and a number of reference counting issues. Fix the
> issues then add the new tests. The new tests cover c2c, additional
> build-id tests, perf top, timechart, kallsyms, perf script with
>  --dlfilter, evlist and kvm.
> 
> Ian Rogers (17):
>   perf kvm: Fix debug assertion
>   perf timechart: Add record support for output perf.data path
>   perf symbol-elf: Add missing puts on error path
>   perf symbol: Add missed dso__put
>   perf probe-event: Ensure probe event nsinfo is always cleared
>   perf hist: In init, ensure mem_info is put on error paths
>   perf mem-events: Don't leak online CPU map
>   perf jitdump: Fix missed dso__put
>   perf c2c: Clean up some defensive gets and make asan clean
>   perf tests c2c: Add a basic c2c
>   perf tests buildid: Add purge and remove testing
>   perf tests top: Add basic perf top coverage test
>   perf tests timechart: Add a perf timechart test
>   perf tests kallsyms: Add basic kallsyms test
>   perf tests script dlfilter: Add a dlfilter test
>   perf tests evlist: Add basic evlist test
>   perf test kvm: Add some basic perf kvm test coverage
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


