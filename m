Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4191374E57;
	Wed,  3 Jun 2026 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464125; cv=none; b=oqG1HlX22e5FpvUvdg6Xe3QDApZFq8urCnEcfGId7/Qk5RTYkJNcddzHAfSa3ihi+lMyVj/FBPcmICDhRf5u7OGSQjIjOHJiVk/IN7YcnBMeDonhnCjGOQ4Kk0LY5ztTSgloDx6Lv+uGWsoqWX58dYamG0/j7/c698L7CYM8GyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464125; c=relaxed/simple;
	bh=YMI8hYDJ9klKbNE1NQMfFIglugDYo1WXX//7EYJo82M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NweqWWNMni6kSMlCIG5RtHjDg6fIjyXSILJYP43VGcBCnRujJPCoeOUfDACa16MBoEta2GIWEzaVColmiNwuu1RQ8r80+8MCpdv1AU1SfOgtZ2gb046seluI/HpTpuJEsSR7dDa+mDywUPd678D1piSojIHX9XJ8aSuXzThgtY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go8ZQ5o7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go8ZQ5o7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43821F00893;
	Wed,  3 Jun 2026 05:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780464124;
	bh=PcWK6xN56B7QeEZGSQjTflCKScfiVbaQW+oOwCyQN/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=go8ZQ5o7Jcr+fstG275yfw4zokzIlvCG6qCnw5lsplSwS5uxZO7eWIWLSODpSZK31
	 5cG+rva8T4JRv6+v1l689AB1eP7rSgJFa3HG9SqqZXXC0y5HwutY+pYAq+wejFyQ/O
	 GbGAS9rPV2V1bJFrKfecyMyma1MBtdc4mzKUTwwr10A7+ecEEgN6ssea25aVCaob5n
	 RRv/ytfP1el54EDDR+MJirapMyH+TRNC9GA+2nJhlaAR7HGFuW9e/gAP2RHdtFx0+6
	 aaadGn9cQAU0UXyj3v3SRboDc1lLPjFkVUWNK8ssaDoGKG2n4hOni0KtbMcNeS/wOY
	 QtF7oBzC06+0Q==
Date: Tue, 2 Jun 2026 22:22:02 -0700
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
Subject: Re: [PATCH v3] perf bench: add --write-size option to sched pipe
Message-ID: <ah-5-g2kRJG7qMPJ@z2>
References: <20260527-perf_bench_pipe-v3-1-9eee9465d673@debian.org>
 <ahcqXqbjNlU-viPj@google.com>
 <ah1nxw7jdbL69wvy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah1nxw7jdbL69wvy@gmail.com>

On Mon, Jun 01, 2026 at 04:10:29AM -0700, Breno Leitao wrote:
> Hello Namhyung,
> 
> On Wed, May 27, 2026 at 10:31:10AM -0700, Namhyung Kim wrote:
> > On Wed, May 27, 2026 at 06:42:59AM -0700, Breno Leitao wrote:
> > > +static inline int write_pipe(struct thread_data *td)
> > > +{
> > > +	unsigned int done = 0;
> > > +	int ret;
> > > +
> > > +	while (done < write_size) {
> > > +		ret = write(td->pipe_write, td->buf + done, write_size - done);
> > > +		if (ret < 0) {
> > > +			if (nonblocking && errno == EWOULDBLOCK)
> > > +				continue;
> > 
> > Don't we also need the blocking part?
> 
> Just to make sure I'm reading this right: do you mean the writer
> should epoll_wait() on EPOLLOUT before retrying (symmetric to what
> read_pipe() does for EPOLLIN), so we sleep until the pipe drains
> instead of spinning on EWOULDBLOCK? Or are you pointing at something
> else — e.g. behavior in the blocking (!nonblocking) path?

I simply meant if it needs to check EINTR if !nonblocking.

Thanks,
Namhyung

