Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71EA3093BA;
	Wed, 19 Nov 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575969; cv=none; b=QsP4/NuMoKrNoakh8JNUgCPebIDKEd5PdYXYhqz8EKRLjTzjEOdVuPwSnl4cUVBY/tCrkC9SshQpeecbslmXJOz13vd9Hjc8A2UMzJO9k9gS9VUrBEVEgPt8Y/jvd9EFcszsk/0s6Cal/6Ce5MSAYPZrnu2LyzKGZzUd4m1e9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575969; c=relaxed/simple;
	bh=OHasDwXVZSRxpr6jtY7/Ffw4Sj7MjVLrZNQrAqDltZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av7a3/685j83m6qVBkPScERvZG1cAbaD33sqICNJ0pWFbPndthKRfSHXj/grMbNCGBc/7WRzxcllOMLayPUAzQmxQUjMcP/gCK/SqhZn/PFAgW1hoWQosaycAUk3WYQqVKcAKHt1c1dkGVs/wfJv7BRx+BxoHL4cc0rlJ8afjzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tH+oA6Rg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tH+oA6Rg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EB3C4CEF5;
	Wed, 19 Nov 2025 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763575969;
	bh=OHasDwXVZSRxpr6jtY7/Ffw4Sj7MjVLrZNQrAqDltZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tH+oA6RgFv0/1TCBtIibP6SIeGaGzCPkrHfcfKKjW9zxAo6Rca4vX3Oq5uYlJliLe
	 JRNQEnOssC9OjmdnzpPOPghXH70R7DRSzfw56Y6BRYadYiTP1gsIeVBrMXc38VaKIS
	 XiXIRK+ZIUB1GVpzEm51MTSOS1GCkemTnqf1GWNEw25IAh7EuedtTO5x154zUrmJjf
	 eIV61z2sfwWyVbiwJzHkGQceqti1EoWsKqqyzTSUL6OMsqnbprF5mq2h5vlI9RwPN2
	 3EQmsY7S4rpJ/enx67hmFGAUTmGubL3CbCYR1pj/s/j7XVH26mOT1rtZCt7OfVe+6q
	 x1gLJIZOcZLYg==
Date: Wed, 19 Nov 2025 10:12:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v5 1/3] perf stat: Read tool events last
Message-ID: <aR4IneHUTlFuyRhe@google.com>
References: <20251118211326.1840989-1-irogers@google.com>
 <20251118211326.1840989-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118211326.1840989-2-irogers@google.com>

On Tue, Nov 18, 2025 at 01:13:24PM -0800, Ian Rogers wrote:
> When reading a metric like memory bandwidth on multiple sockets, the
> additional sockets will be on CPUS > 0. Because of the affinity
> reading, the counters are read on CPU 0 along with the time, then the
> later sockets are read. This can lead to the later sockets having a
> bandwidth larger than is possible for the period of time. To avoid
> this move the reading of tool events to occur after all other events
> are read.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied this one to perf-tools-next first, thanks!

Best regards,
Namhyung

