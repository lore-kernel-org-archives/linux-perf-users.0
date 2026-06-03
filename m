Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4B36A02E;
	Wed,  3 Jun 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482377; cv=none; b=efsqbSMZYTU65KgvLA4Qda0mbcSiYFljNs9H8T9TZ5f1aEcCW+dSQLtvNFigNoQfMhIabgdVX4Xy6gPf/BWhn7HL22qsv7/i8x8cd21uVTjS9PetXT2jGUhLu5UtRb3q7FwbkxkMLMGy0tvLXC9EpRUaiKJ4EJK8n2pzaNmTvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482377; c=relaxed/simple;
	bh=7LMl1RmmHmLHGTxNVpL6o9mw85im8179sX4Kqq2GHdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrMc498RkC8cUGDlPT7LwScsVaEq/wJ3OpmBHS7LGZbXFI8aSk7DkAI0VfQcffMplh48C9nvZwO86CzunXghI+qCD9898TVIhhH2m4UEkASGocjov22ZqKCg4HNt+r6DU5OdBLkCs97JHKOipqiPTFRWbB15W+nQJ8sO3isQm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=oD2jI6Tz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="oD2jI6Tz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=QUMRMFgn8aTTa7poihcn8tq/G4CY+KcxD9jaU6R+DoA=; b=oD2jI6Tz4l7AP3ST1Ef2HHD49O
	2lg0JmkuKDsEnQdk6M4vNLZ+XwNMHDV07STzepq9uNKbMXaPX+0BFv7zuPAklJa1jpQfRx7A5xlJb
	q67WUv0ZIZtCqznOKFLKq0my9EFv2yfY5N7PE8aMsKsbnGhQPZ/HYBMee3dz6JRf+zWUaVOktTWAH
	XkIolE0i8fgcQ6Y7MTTfwX/yfLk+yRB1VSuB6flTB4xRzsb3mZxUpo2qbKHpP+3wwcrRpyQ0YB3ZC
	bsV1TA9Jd0XFsnCiAChjVH9WDhmQKEAf89EM+HLlKyjpKfp0DA2/QA6lgawi9IbXO5mm3r/0NpQdu
	knKK4r0g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUinG-003fM2-0C;
	Wed, 03 Jun 2026 10:25:50 +0000
Date: Wed, 3 Jun 2026 03:25:44 -0700
From: Breno Leitao <leitao@debian.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] perf bench: add --write-size option to sched pipe
Message-ID: <ah__hAGKk2B3nYCC@gmail.com>
References: <20260527-perf_bench_pipe-v3-1-9eee9465d673@debian.org>
 <ahcqXqbjNlU-viPj@google.com>
 <ah1nxw7jdbL69wvy@gmail.com>
 <ah-5-g2kRJG7qMPJ@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah-5-g2kRJG7qMPJ@z2>
X-Debian-User: leitao

On Tue, Jun 02, 2026 at 10:22:02PM -0700, Namhyung Kim wrote:
> On Mon, Jun 01, 2026 at 04:10:29AM -0700, Breno Leitao wrote:
> > Hello Namhyung,
> > 
> > On Wed, May 27, 2026 at 10:31:10AM -0700, Namhyung Kim wrote:
> > > On Wed, May 27, 2026 at 06:42:59AM -0700, Breno Leitao wrote:
> > > > +static inline int write_pipe(struct thread_data *td)
> > > > +{
> > > > +	unsigned int done = 0;
> > > > +	int ret;
> > > > +
> > > > +	while (done < write_size) {
> > > > +		ret = write(td->pipe_write, td->buf + done, write_size - done);
> > > > +		if (ret < 0) {
> > > > +			if (nonblocking && errno == EWOULDBLOCK)
> > > > +				continue;
> > > 
> > > Don't we also need the blocking part?
> > 
> > Just to make sure I'm reading this right: do you mean the writer
> > should epoll_wait() on EPOLLOUT before retrying (symmetric to what
> > read_pipe() does for EPOLLIN), so we sleep until the pipe drains
> > instead of spinning on EWOULDBLOCK? Or are you pointing at something
> > else — e.g. behavior in the blocking (!nonblocking) path?
> 
> I simply meant if it needs to check EINTR if !nonblocking.

Ack, thanks for clarifying - I get what you meant now. A blocking
read()/write() can return -1/EINTR if a signal is delivered while it's
parked in the syscall (e.g. the user hits Ctrl-C), so I'll just
continue on errno == EINTR in both helpers.

I'll respin with that, and also address the "medium" issue Sashiko
flagged on the same write path: instead of busy-spinning on
EWOULDBLOCK in non-blocking mode, the writer now poll()s on POLLOUT and
only retries once the peer has drained the pipe.

Thanks,
--breno

