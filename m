Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68B2E847
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skGr+AUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A96C433C7;
	Mon,  4 Dec 2023 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701718877;
	bh=RXdn7YdWXNah7nltudb7qfhHrrahkAbHAZJ9llIwtKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skGr+AUrsXfkqS8yjxDbQcG1zzlrRlu6/XRbuE/W1hpt7mvk3YKmkmqnk0r1w4CcT
	 4WN2hCtnHymCJWtSmr2QbG4PbzJRvGlWkXTqiNiYPMQbOHiHiYG4Idp3vhRseXYdpZ
	 vo7P6CgJoQPm67QxvSMW4fGwefcYs1WyVhsF80C79Ymr7tmIb6GKKanV9QJorMqULn
	 xxosg2gN7/8TkIHIrcFHd5BfGo2Q4KvqMw9xFPl7WO5j0PACRfzCSqgbvvTjxZeSN8
	 YrQxgFn9RvTcKWsXSAXY98uzdE4ertHEuBks4tjh9SP6esxgRgOM5qqR7VbML6v9G5
	 gQsqAQio3ta+Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id D568240094; Mon,  4 Dec 2023 16:41:13 -0300 (-03)
Date: Mon, 4 Dec 2023 16:41:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf vendor events arm64: AmpereOne: Add missing
 DefaultMetricgroupName fields
Message-ID: <ZW4rWWiMkeLpRPXa@kernel.org>
References: <20231201021550.1109196-1-ilkka@os.amperecomputing.com>
 <20231201021550.1109196-2-ilkka@os.amperecomputing.com>
 <CAP-5=fWr0bmqZjyYiBuMuCD+sPCULmF_q7hU4J8ouvcvwb5Z6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWr0bmqZjyYiBuMuCD+sPCULmF_q7hU4J8ouvcvwb5Z6w@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 04, 2023 at 11:02:31AM -0800, Ian Rogers escreveu:
> On Thu, Nov 30, 2023 at 6:16 PM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
> >
> > AmpereOne metrics were missing DefaultMetricgroupName from metrics with
> > "Default" in group name resulting perf to segfault. Add the missing
> > field to address the issue.
> >
> > Fixes: 59faeaf80d02 ("perf vendor events arm64: Fix for AmpereOne metrics")
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> 
> Sorry, I just stumbled across this and sent a fix too.
> https://lore.kernel.org/lkml/20231204182330.654255-1-irogers@google.com/
> The patches are identical so I'd suggest taking this one and the first
> patch in my changes.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied the series.

- Arnaldo
