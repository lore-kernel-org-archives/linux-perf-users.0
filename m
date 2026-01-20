Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906E394496;
	Tue, 20 Jan 2026 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941332; cv=none; b=PZ+ZuMhWF4rTmOjVEatwqhs7iyli5d4vxtKe/rA56aKG+Utnmpax0DYvENuEPtKU2szxDXjm2/maViU0lJfT+e2DJJmlghvpY7IoIYy4uPqVQa3FAZcwe4U6qsTVHTqnSZkFOrG31Dzr6Hou5EEcXnT4FMWB2EhVTdUc5H4/f0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941332; c=relaxed/simple;
	bh=rV20FWvamcZ4xO+JjGuifrVIO2baDGds+ixxEFJCddo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMbrXTbNls3YI3Bj2ToSTg9oJ9GCidkdiLAPsVavF5CylZf2DP67muaznkEXA0MX3xRNNH2cl1+n5qaLf3UALUaZFElbyOQgrNzapUcNwNAT/AyDqEWVTluy4vf71kp5uIAKF8+Upn/YEa2FmrW3IlyPE28UUNOCX9HamCBScg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6cNt6Lv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6cNt6Lv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A58C16AAE;
	Tue, 20 Jan 2026 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768941331;
	bh=rV20FWvamcZ4xO+JjGuifrVIO2baDGds+ixxEFJCddo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6cNt6LvAbPuLpdxzFXHyyJgs7rMcAoqeM/Bxm2LArPySRhn8IW40IW8UaozIZxyd
	 CT/u30533Rpf6yuNTpOVDLO72kGHfbIbKX62zX4Djs6l/8wvG/rLceUgTd5LGGIAQJ
	 hNU0v/zzAschcRsNNp0Pjh93P9qw+GbiAjl4HeF07whcJgIqSB4Eo6cuh5kOHK9Hg7
	 8K6MfG7+gZINFctNli+Llnrxo6qebEKyHZawBLR1yAo7fZxflOUZwKUBTeQ7l1H94Q
	 cyp6+cB1QP8W9bdrEpmEqNDlvKkxZhbPt6iLY9tu0AMgTXbTyuy8R9CfFILJogVQ1H
	 ix2tnUwruJN2g==
Date: Tue, 20 Jan 2026 17:35:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf tools: Always uniquify event names
Message-ID: <aW_nEbDbmsVxjjfW@x1>
References: <20251204-james-parse-events-test-v1-0-e6f922ca395e@linaro.org>
 <20251204-james-parse-events-test-v1-1-e6f922ca395e@linaro.org>
 <CAP-5=fUJM5GYjSQafR+c_u19PF4_SS=1zFq0nGUHC3=XYYQ+VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUJM5GYjSQafR+c_u19PF4_SS=1zFq0nGUHC3=XYYQ+VQ@mail.gmail.com>

On Thu, Dec 04, 2025 at 08:34:34AM -0800, Ian Rogers wrote:
> On Thu, Dec 4, 2025 at 1:11 AM James Clark <james.clark@linaro.org> wrote:
> > evlist__uniquify_evsel_names() only gets called in __parse_events() if
> > verbose is > 0. This means that the auto added "slots" events stay as
> > "slots" rather than being expanded to "cpu_core/slots/" unless Perf is
> > run in verbose mode. This is invisible to users when running Perf stat
> > because evlist__print_counters() always calls it regardless of verbose
> > mode before displaying.

> > The only thing this seems to affect is the test "Parsing of all PMU
> > events from sysfs" which fails when not run in verbose mode.
> > test__checkevent_pmu_events() always expects event names to be prefixed
> > with the pmu name, but this only happens for "slots" events after
> > evlist__uniquify_evsel_names() is called.

> > One fix could be to relax the test to accept the non prefixed name in
> > normal mode. But seeing as Perf stat uniquifies unconditionally, make
> > parse_events() do the same.

> > This fixes the following test failure:

> >   $ perf test "Parsing of all PMU events from sysfs"
> >   5.2: Parsing of all PMU events from sysfs                    : FAILED!

> > Signed-off-by: James Clark <james.clark@linaro.org>

> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
