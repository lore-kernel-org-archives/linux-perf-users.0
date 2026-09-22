Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB43B71A3;
	Tue, 22 Sep 2026 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080609; cv=none; b=C7WuhT9Wk0/8i4c0ibiL9Zk5p1qT+oxnLHdIZGw2RWgbLXskmR4HqzpdZbXZ6/Xs+KlxONGe/jUpnpKWe50ziq3atLST+ZfzK1geTvG5uVUWad298/RihwQdWessJvMPUap0o2GbHWUNopfYg6cTB1E6RaP9uxLR/bIuyk8GfyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080609; c=relaxed/simple;
	bh=ExLBZViTpuU9dnt0XoWwD/qM1jLDhFU/A+9KurkkuDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEJYVhSU+IJGNlZ9kcs14GvBaz2FS6+OYRU7oOUz8ISZ4Jv5Si8Nx/tjNRIYo5Ycha+0NvAS1YXhBZ1YKbbClN0zfPI71qM0lP37UA/UUn2+R0k9n+q84WDaYdwqKGdy8SIr8iGIq6XmSSm8lGXwPyQ0OJAgrsZM5O8Q3XiNW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOVlX6nV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOVlX6nV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8321F000FF;
	Tue, 22 Sep 2026 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080608;
	bh=u+ngg0GV6tuDyNJVD/QZTEerhV7QTGxQCJgCV02nNyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YOVlX6nVd1SklbpfpfKwu4l/SP7rd6J3+wM9fXnHfk9/Xk0IMCDxB1iCHPPWmBUD5
	 KgEDVOUo/xOlB36uSHDh0m166VzK9H4uDraeLwavhYH9LiscsCi1HyJkt5UDzZHUzN
	 /ybZWOjM13dzsMSdTUkjJLX+7XzPcnXoAbtXDOdZuOEYF4RhcVpQaII+VxqZrQD5Xo
	 BvJOonASr2W1HwqHsGqK8ACLRzfntIyAPBbomC8gWmfepz7m6GOohiMbRSfJMCEP/H
	 5VtcFk5hF4zTjSc9ECSS45YsjwRq0Osbn40lmbJsJJnys9VAjJsuGobZFQU+rcMYKp
	 L83ZJsqZj6pHw==
Date: Tue, 22 Sep 2026 14:36:40 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Hui Su <sh_def@163.com>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf synthetic-events: Fix schedstat event lifetime
 handling
Message-ID: <arJ2WB3wUc8Jn7XY@x2>
References: <20260912055619.2284443-1-sh_def@163.com>
 <CAP-5=fUCDeC+mAi_cVpNr+WoUXvpMG8948GVnb8OQV95PhVQ6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUCDeC+mAi_cVpNr+WoUXvpMG8948GVnb8OQV95PhVQ6A@mail.gmail.com>

On Tue, Sep 15, 2026 at 12:41:03PM -0700, Ian Rogers wrote:
> On Fri, Sep 11, 2026 at 10:56 PM Hui Su <sh_def@163.com> wrote:
> >
> > perf_event__synthesize_schedstat() has two event lifetime issues.
> >
> > After a successful iteration, event is freed but retains its value. If
> > the next iteration starts with an unrecognized schedstat record type,
> > neither synthesizer assigns a new value. The stale pointer then passes
> > the NULL check, may be passed to process(), and is freed again.
> >
> > In addition, when user_requested_cpus filters out a synthesized event,
> > the continue path skips free(event), leaking the event.
> >
> > Make event local to each loop iteration so it always starts as NULL.
> > Also avoid the filter continue and unconditionally free each synthesized
> > event at the end of the iteration.
> >
> > Fixes: c3030995f23b ("perf sched stats: Add record and rawdump support")
> > Signed-off-by: Hui Su <sh_def@163.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
