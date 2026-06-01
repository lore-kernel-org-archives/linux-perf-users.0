Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8E373BE8;
	Mon,  1 Jun 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312258; cv=none; b=pk1pseiIkt7YPYstt1JuTSq50xryUypJVAWzXYaY5YV7jxAV+cQXP7AUqOij9zTxwM3Sf9P0DsSm5/SYUMOvSdAhDUVAClKIxF8tyuZ/t2neujX+IqbLeXV6fnaYj7y+Mr8eJHV2G+uJRhydwTgnlyx0UNQ6Owu9BUb7rqh1yxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312258; c=relaxed/simple;
	bh=AAaQlp1NHWyxzZXDZ1v/PqnpILfTh6x3WiVpUi83TC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZBR/Jlh3t6Fy+YWu4gU0CihQZ7z17ejxer540jht6nKX+x9Yq9Wz/3qw6FDsK6s66Lw7SZUA2GE/hFXrCH9LXrGEgWsoTsGt/7OYfEwftcWtN85Pca/6w4myH4U4OrjUpKFtHQro2A0MRda3jtnpt77L622JYD74UJuSP48e2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vj7/5Bva; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vj7/5Bva"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=rYylCAhafzMk2X08mlGH5u2yTJ6BJW5IKrUwG4KJpLY=; b=vj7/5BvaptjdiQvKVmMBZO4q6p
	5i/7zgomOK83fqJ17RjZHJoOX6dtwwK0Kw9YcGWg7mNgdwXgZuC9STdCvpk1bFYwd3IxmOUDRWdYj
	B4Xb+XyzzLUMJL3aRO7IIt9LwioA/SUyMAfa8hlfdV8/kUlw5Dfgk4plkYKo59v68s9oFIJxA+9xv
	/It9R1dwy8U8kQIBvpuc2X7DwgglthBUAd8q8iEyjJqXYCaavsHJOnzK/f79OJt31Q6l4Kkg5mvjp
	mKMmBqW4psavSdChxZNHsJcbgfHbbe9Vo45MiBkVu86acmQFpiJDsKl730BBvOV8lO1VrdVdsp25E
	Hf5pNgBQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wU0XT-0028M5-0E;
	Mon, 01 Jun 2026 11:10:35 +0000
Date: Mon, 1 Jun 2026 04:10:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] perf bench: add --write-size option to sched pipe
Message-ID: <ah1nxw7jdbL69wvy@gmail.com>
References: <20260527-perf_bench_pipe-v3-1-9eee9465d673@debian.org>
 <ahcqXqbjNlU-viPj@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahcqXqbjNlU-viPj@google.com>
X-Debian-User: leitao

Hello Namhyung,

On Wed, May 27, 2026 at 10:31:10AM -0700, Namhyung Kim wrote:
> On Wed, May 27, 2026 at 06:42:59AM -0700, Breno Leitao wrote:
> > +static inline int write_pipe(struct thread_data *td)
> > +{
> > +	unsigned int done = 0;
> > +	int ret;
> > +
> > +	while (done < write_size) {
> > +		ret = write(td->pipe_write, td->buf + done, write_size - done);
> > +		if (ret < 0) {
> > +			if (nonblocking && errno == EWOULDBLOCK)
> > +				continue;
> 
> Don't we also need the blocking part?

Just to make sure I'm reading this right: do you mean the writer
should epoll_wait() on EPOLLOUT before retrying (symmetric to what
read_pipe() does for EPOLLIN), so we sleep until the pipe drains
instead of spinning on EWOULDBLOCK? Or are you pointing at something
else — e.g. behavior in the blocking (!nonblocking) path?

> > +		if (ret == 0)
> >  			return ret;
> 
> Maybe it doesn't matter.. but shouldn't it return 'done' instead?

Ack!

> 
> > +		done += ret;
> >  	}
> > -	ret = read(td->pipe_read, &m, sizeof(int));
> > -	if (nonblocking && ret < 0 && errno == EWOULDBLOCK)
> > -		goto retry;
> > -	return ret;
> > +	return done;
> >  }
> >  
> >  static void *worker_thread(void *__tdata)
> >  {
> >  	struct thread_data *td = __tdata;
> > -	int i, ret, m = 0;
> > +	int i, ret;
> >  
> >  	ret = enter_cgroup(td->nr);
> >  	if (ret < 0) {
> > @@ -204,15 +241,38 @@ static void *worker_thread(void *__tdata)
> >  	}
> >  
> >  	for (i = 0; i < loops; i++) {
> > -		ret = write(td->pipe_write, &m, sizeof(int));
> > -		BUG_ON(ret != sizeof(int));
> > +		ret = write_pipe(td);
> > +		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
> >  		ret = read_pipe(td);
> > -		BUG_ON(ret != sizeof(int));
> > +		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
> 
> Nit: maybe comparing to the write_size is enough as it cannot be
> negative or bigger than INTMAX.

Ack, the following should be enough:

	BUG_ON(ret != (int)write_size);

Thanks for the review,
--breno
