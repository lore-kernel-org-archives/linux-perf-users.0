Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470542188F
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818138; cv=none; b=bxtUAyopCYEZZ5P2UDLE1e8MMP3+EEHBcWIr+EdHHVoewsg6jZx1JdrSKUP3gzUHs5ZFvI0yH8cptq7lvrdY/tqs3UaukbDI6nq1H1IODFnmw0j045AiNoMtVjPVYSQi2oNcdmX0omYO8gGzS8CjQsgGr89plU9VyqF5zlHg++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818138; c=relaxed/simple;
	bh=DGbGprOejO1JyZgVGWwttMJBI4w1MQ6AcyVoxjtIeJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqf60X82Z78Ce7N+5/JiiR7Bawi4PPUBliHW/Y/XAbV8HlxkYSWiWBENCOkGlD5mCopmJoECz/wUPzWAsmzqavEyafH7TmrdUtSVMUTyHpbirhzAFqqRp8hgzthfITMJ/CasTls7UVAMY6tiPHPOo5yKevJx+2CT7lgM6PN/eII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4903974854dso46581475e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 10:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818135; x=1780422935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=az8w1SBKxR0VeFE6GKHEec3/Op4ln2y/HZZ5hj4Zcl4=;
        b=mLODTWybcx4jy9iPegIU/z7ebpoSz++LRuS5yYDFxK9j+goftT4YqU3N1z1MChLqyw
         OpK1DNgnnyUeOLKu5XGyutMAS4cACHRaKRyprkc+n+QBrJ822ygG25LEnvFhZsrdmsK8
         ehlp835bJQrI4Dld+9r/O+miqKLBto/QLS8P+KrTPij6SaPVyNAIEOFqDmwqlKHMSOs0
         WKKF7p8WAAltXtaoKhgfu7oaIuoc41bxuWWFmV9IsZGpxhC4YtYwIRNwJ7HAS7jIlDdz
         isCKW24kd8GmEnhhXUqWEM+DJ2ALm2iNjqqu+34IE82xlRCOd/tWFvWKRQH8eWAoV1TP
         CxYg==
X-Forwarded-Encrypted: i=1; AFNElJ9ESdbR1eqM0LAoCIPxP2E6iP2Iw7q+XQ4n0kw0Anetz7XT14e0qZZx8ciXs6dxfiWfG3H2GeaxsZrm32zmYtdA@vger.kernel.org
X-Gm-Message-State: AOJu0YymmbrGj9nirUFnzCBk0WgSL9Fr7XYarcHScaMfawAVC2JYQziM
	M7ggMx0syQmq3/0Q0k/k9kYFbMCuHZHH2ih61eHqKeMvdpS0XW8y3udg
X-Gm-Gg: Acq92OHqnJkSaztFndAIolWmeCUxzXIzt1pqOcc4wnHaQhs9urUnaYfySlqq+70cV7v
	txeRI2/9hOFNHpkjfm2UXutzF0/AqRzSXFzAH2EUsaOdjwCyzhKAFnHSxbd1KV2/ReN4hWrajYM
	Y9KcJkOiexr9Kivzlt1KaXtdoECKEIuB3t1nm2PfEftYIXWztfvTcPEN+CgIwQ8VlvqUS27/8hD
	c8kOUFzaF+bkvMbfK8rMsdkJIt2tZHRst9VZ3j+doUONNzDeNBQ2wT88RKGM6XEyW83tdyHMQNj
	yvLCXDzB+KXW3Ya7nxhlI6UVDrYnDpFTwYkowkgGTBRHQAD0MSD2caaZA66+hkhM2MHeaTtRQLb
	XEnrqHvhFBeulhuFw1RY2gwdTS2xBOJgVeJApHCK1kwle1M1KE1+AX82hpOMPdPC9hxHSWyeHUR
	bWfilMWRLzC+DqSnGi1AS06IBNFA==
X-Received: by 2002:a05:600c:8217:b0:490:51e9:deba with SMTP id 5b1f17b1804b1-49051e9e233mr248777025e9.27.1779818134620;
        Tue, 26 May 2026 10:55:34 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907e7d0967sm1014105e9.11.2026.05.26.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:55:34 -0700 (PDT)
Date: Tue, 26 May 2026 18:55:33 +0100
From: Breno Leitao <leitao@debian.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] perf bench: add --write-size option to sched pipe
Message-ID: <ahXWIrGvsC3_gIkC@gmail.com>
References: <20260521-perf_bench_pipe-v2-1-720b6ff7f0fa@debian.org>
 <ahUCyRwNPKV1VAZ8@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahUCyRwNPKV1VAZ8@google.com>

hello Namhyung,

On Mon, May 25, 2026 at 09:17:45PM +0000, Namhyung Kim wrote:
> On Thu, May 21, 2026 at 09:15:37AM -0700, Breno Leitao wrote:
> > +		ret = write(td->pipe_write, td->buf, write_size);
> > +		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
> >  		ret = read_pipe(td);
> > -		BUG_ON(ret != sizeof(int));
> > +		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
> 
> Is it possible to return smaller values than required due to signal or
> something?

I tested this on a VM with the patch applied, running the ping-pong with
write_size from 4 B up to 1 MiB, including multi-process and single-CPU
contention runs (millions of iterations). I observed zero short reads or short
writes.

Looking at fs/pipe.c, this matches the kernel behavior for this access pattern:
the bench has a single writer per pipe and the pipe capacity is set to
write_size, so the writer never has to sleep mid-write, and the kernel does a
sync wake of the reader only after the full payload is queued.

EINTR is also not reachable today because the bench installs no signal
handlers and nothing in the call chain delivers signals to the workers

At the same time, I understand the concern and If you'd still prefer defensive
handling (short-return loop + EINTR retry) I can add it in v3 — happy to either
way.

Thanks for the review,
--breno
