Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5B3290AD;
	Thu,  4 Jun 2026 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585959; cv=none; b=twuSWR4gS2BklTTrrjENV8F93fFNFm4wryxSsz9eLnrgM4AaUPvzx7HfdRC8vZLW86pC42v2TPjh0tpcj6kCTofUCIAMs48nd85RX+LqMY8p35FCBafrnsCJVKo7+C1swrPWmewuivkTTXkBEqs1LBNe1BzShBrAOSyDPbcAlF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585959; c=relaxed/simple;
	bh=nccuy9mVDfyv10B4G5A/259ZokotX2ZzMjHSFWP/8Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD+BCiHmaU7FCC8OYIrBMvl9qxrA/QBS//WNv2Pnkw1dCJ/2b5kXBymNGPDPpYdPBZsWAbAZ0i+LVKkd2b9BdYlW11dQ6iS0w3pktzcfxpMjYWSLODaMREw39UmgkVI9g3dNZK6GaiGxoF338TozApdpj0QPuTCmQRL7OtTnpMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MuXd8UBi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MuXd8UBi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OJEsWaJMkmXwcrfhWHy1DALdoIQEZ7S/5/cBQ7zsCj8=; b=MuXd8UBiOUtgHEzGZ2nB8sBrEI
	ccwjgWhciTwKGqVZGUdAPRuawCOxB8mijdbRNT0TGv4ocO/zvwRTXc6kMG6XfNvxxHzfwf6UuXls7
	RAKc9GU6btp8w+dvwHSxq248nzEvu0XYmqnmVq2m619Y4vBMKo4M4zvZ0VxIs078/on6ktRG1+1Zx
	y1OPT+RDiTY5i4b41zhy+ieHRsuQZhnungn5vllPy1oK3kv5uIeXtkh1lU13PqX/Hcn0ykDCwcJxu
	HN+uvu59ErN6qYt2JT08UERlzvvNV+rUMG4vYVie7PFJ1cPAWu2JyQOyJFCgKuIztAFjfzgR5mFZX
	/jnhCwQg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wV9k3-004bMk-06;
	Thu, 04 Jun 2026 15:12:19 +0000
Date: Thu, 4 Jun 2026 08:12:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4] perf bench: add --write-size option to sched pipe
Message-ID: <aiGVuVHCiA96IKqF@gmail.com>
References: <20260603-perf_bench_pipe-v4-1-f48c0ba6d6cb@debian.org>
 <aiC6DA3o4L7mx0S7@google.com>
 <aiF7vEJNyxJcluC2@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiF7vEJNyxJcluC2@x1>
X-Debian-User: leitao

On Thu, Jun 04, 2026 at 10:21:00AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jun 03, 2026 at 04:34:36PM -0700, Namhyung Kim wrote:
> > On Wed, Jun 03, 2026 at 03:35:07AM -0700, Breno Leitao wrote:
> > > The default ping-pong uses sizeof(int) (4 bytes) per iteration, which
> > > exercises only the pipe-buffer merge path and keeps allocation entirely
> > > out of the picture. That makes the bench a useful scheduler / context-
> > > switch latency probe but unable to surface anything from the pipe
> > > page-allocation hot path.
> 
> > > Add a -s/--write-size option that sets the bytes written and read per
> > > ping-pong iteration. The buffer is allocated for each side via
> > > struct thread_data and replaces the on-stack int previously used. The
> > > default remains sizeof(int) so existing invocations are unchanged.
> 
> > > With --write-size set above PAGE_SIZE the bench drives anon_pipe_write()
> > > through alloc_page() (or the bulk pre-alloc, if the relevant patch is
> > > applied), which is what we want when measuring pipe locking and page
> > > allocation work.
> 
> > > The bench is a ping-pong: both sides call write() before read(), so a
> > > single write_size payload must fit entirely in the pipe buffer or both
> > > sides deadlock waiting for the other to drain. Resize the pipe via
> > > F_SETPIPE_SZ to match write_size (skipped at the sizeof(int) default),
> > > and error out cleanly when the request exceeds
> > > /proc/sys/fs/pipe-max-size.
> 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks, tested and applied:

Awesome. Thanks Arnaldo.
