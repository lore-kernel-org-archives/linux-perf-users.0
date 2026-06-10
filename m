Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0D37E2F2;
	Wed, 10 Jun 2026 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121708; cv=none; b=Z4hFTXACH6jKKb+po5SgZI9Z7DeBJoKsqIMRPGcS0SadvPC5xwjCp2RzaURofhMsAxpyBorul8hLK84iOR5x5SZCCh/kUcp/x6/bu17wVQnYhrZeX9s8sR8VEoDWyPf0LiBXLdZyr0T7zooY0czuRGZJ2qGrOEv4HHWQfYryo9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121708; c=relaxed/simple;
	bh=BYH7DvAQe4W47RkpaU9kOyDqppZB+u9IETBlqlRq76E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7QZTtpcJ7A/DCph8e13UAI5zf71FgFSHoy9D1pzewAvGYQxdRwv9TPTWMLSPJUwBsygRLRQQw4JDU5FrbAuuRtHWj9OaZfH5caqlkfJpl6JFCKffkNultHfpTHhVs+JPWJ2fCdKlH2POOlyVq/U/TZGuLzm9tPrVgLymTpf7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPAJlN3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPAJlN3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619D01F00893;
	Wed, 10 Jun 2026 20:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121706;
	bh=vWxfL8K2S6Dq2oRRt3wuuTd1fXAn3e66jYJW3XSoiO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BPAJlN3D9jHSTp+UiOa9gBUEHwkv6E/fV76NEmezl8YfCDYYBAd6GNVYmEx3JcX+I
	 fQ6st8XfLIbiyGQ4YzSE9bkpCvBslxVUMuGOphZBI6VYRwuHKjU4i15NOSi3csb1uB
	 sGxrCMGsgfqjTalJQA1dNyzEIZfLyNxvp43dFru4L/BRcAP2C85J3p1t0hkU326W1l
	 tKb7mLFtcs0eS4cIfPp2ZK/5TEqoGOy81mmeqq1IlKVD86+ncks49uv+htgxnOiDIV
	 rq9LlG7YjLblDqrzhB2KlNrA9HSShNwQHP+7Jho+1jd5ma+GoEdO5pF9Get/M6qbcx
	 nVgAv0KHpx1bA==
Date: Wed, 10 Jun 2026 17:01:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jens Remus <jremus@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Polensky <japo@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v2] perf build: Respect V=1 for Python extension builds
Message-ID: <ainCpsgwEHLnLnZ-@x1>
References: <20260608160613.3153795-1-jremus@linux.ibm.com>
 <CAP-5=fVWuGKVT+g7RVkQy3zYYWVnHs7Ar76e+-RCJe0ZoZVsug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVWuGKVT+g7RVkQy3zYYWVnHs7Ar76e+-RCJe0ZoZVsug@mail.gmail.com>

On Mon, Jun 08, 2026 at 09:15:36AM -0700, Ian Rogers wrote:
> On Mon, Jun 8, 2026 at 9:06 AM Jens Remus <jremus@linux.ibm.com> wrote:
> >
> > Make util/setup.py respect the verbose build flag (V=1) by conditionally
> > passing --quiet only when not in verbose mode.
> >
> > This eases debugging of Python extension compilation issues and aligns
> > with the existing perf build system behavior.
> >
> > Tested-by: Jan Polensky <japo@linux.ibm.com>
> > Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
