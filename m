Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2E309EEC;
	Mon, 13 Jul 2026 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783983618; cv=none; b=Veahd88DfL1yRy1rbdz1+ctV6eoNJfmM9amklI5LMuIN08Sum/AB+vriqtpXeNINRHW6Qm0PZDPzANQvtInf7qT1t2LwmVE3bCNJroWbNOgl6qhiXDDHhMPYAX1p1oZ/rBm+uZXDsuVvSAQfPGGn7LFnnHUCn923Cr4Zni/X0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783983618; c=relaxed/simple;
	bh=LMoLRui/EtXQj6mQo2dUqv7rxflL8LRCeb9Db32J+Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK5pEIDhjVZHQA6di0PSN99J8tvIhXwZvXeR2REj5pfzOG30NdxLC4sbNQIDWKzyn+zAw0slWETbBkDjdOgETjs7lHd7c0Y8VMu8M9e4258QYxet4fIVi3HyOOQQoNRZHwS5WQVZtne2RDhNYOoInbpXw8mASk4Uh6vCxcVvbFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDjyuQkm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDjyuQkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4AD1F00A3A;
	Mon, 13 Jul 2026 23:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783983616;
	bh=msrD+pBuJUOZyD+C0lZnluFwc5+BBCL/UKHUchTd5e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RDjyuQkmipttQJOY1OYSP4qwhKB0BjZ0y4d7+0kom4W8AUHJT8ri/wy4vHgDc22z2
	 P6JVrhWYXc4iZXQe9Xl7IdBI9FJeNEShUJm1Fwtf4URCkLRWjtfRlAPObRa3ONyq05
	 n3hi3mpn8ziEr2Ycn0rmYU4X6F88CVUZ2IuQNDEtr36EBO01CUIrcbhb73QYCr9gyo
	 3XdPvv/P6eRzUMhk9M7ZioygFRCWX6dcvx6Uy36u/vw4pRq10zzXs2rvtkuUVdEBzP
	 RiG2UebC7b+Iizgdv6y5t5i2q3KfURty1JmME+I6mf/VowZ9Gr3UsE5N+tvI13LLxW
	 aP9VO4rG6mZqw==
Date: Mon, 13 Jul 2026 16:00:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/3] perf sched: Add missing perf_session__delete()
Message-ID: <alVt_4Oaj8SvqAlv@google.com>
References: <20260713204707.2181098-1-namhyung@kernel.org>
 <20260713204707.2181098-2-namhyung@kernel.org>
 <20260713205907.77D4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713205907.77D4F1F000E9@smtp.kernel.org>

On Mon, Jul 13, 2026 at 08:59:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch introduces a double close of the file descriptor `fd` because `perf_session__delete(session)` inherently closes it before the explicit `close(fd)`.
> --
> 
> --- Patch [1]: [PATCH v1 1/3] perf sched: Add missing perf_session__delete() ---
> commit 2da9bd6a7ce8e17e442d8be81b1b57837aaee6e1
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf sched: Add missing perf_session__delete()
> 
> This patch addresses an ASAN-reported memory leak in the perf sched stats
> record command by explicitly deleting the session before returning.
> 
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 6e0d8f4d270e2..68147a0be5c71 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -4027,6 +4027,7 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
> >  	else
> >  		fprintf(stderr, "[ perf sched stats: Failed !! ]\n");
> >  
> > +	perf_session__delete(session);
> >  	evlist__put(evlist);
> >  	close(fd);
> 
> [Severity: Medium]
> Does adding perf_session__delete() result in closing the file descriptor twice?
> 
> Since perf_session__delete() internally closes the file descriptor associated
> with the session data, the subsequent explicit close(fd) will attempt to
> close it again. This could return EBADF or erroneously close an unrelated
> file descriptor if another thread opens a file in the meantime.

Hmm.. looks right.  I think I can just remove the close().

Thanks,
Namhyung

