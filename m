Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FAC8F45
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508755; cv=none; b=nRIPzAre+X/65g8q+Jpr+KyNRi7Hv1PIOLfv+w6wZBIeGGMm9yd8jpm2eh4nkafgdR6wU8AJRPvln6107J9DuOH/rzcsCl7+nHtlXVEb9oWvrZp6SqFgh70LApbHNw95yFrN/rwBcK4PmTzZs3xSIf0fO63hmxX8qR0V4wTI3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508755; c=relaxed/simple;
	bh=WewsGCTb6OuR8cIKCvGfvFyAG4DnQbqQ6RFozhuidE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOPzljAgnKcm6dQXxChcEgktfrlLTnHhC7fD7LR/ZZKan2ULneWR4ISOqdWH7WChVSIIXByxwCx2pKLIVLtGzLoO9ot6aQtfJSMikk8gzd0W4TOdgv6KHlDxK6ilz7g7eRd7nE7L1Los10UN54uweAgBtIZAESumRGUUboFjYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG8OmPPe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG8OmPPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED56C2BBFC;
	Tue,  4 Jun 2024 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717508755;
	bh=WewsGCTb6OuR8cIKCvGfvFyAG4DnQbqQ6RFozhuidE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HG8OmPPeyVN0BqwbgOsnO6kE3Nw6nJ7MWrikBsH8ak2L6VQCIJWXk9xBjx052et/2
	 7i9aMKxDxZlz5IcM51wnwG3eFzczXvN28rXQ47s/8LzUm1/47keRrust0iAG5kRZK1
	 v/2VxzECdamWZuvKD7djGaP5LXgW2ZjkwnxZuMaimDYRUAJW2NkC/IytLF3+AJ9cIm
	 nJJv2emWo6YgKOYFc4sLpyt2YFZiyPVFq6W3Db6JAPYeekCfWLRwrZohPRshf9Nmab
	 /Jro6XtpgnJjE5otXkD+29KHObuCu2beWLYwAEhlX1kRnlBk5kMUkl/vTnR9hCkG5V
	 t46bi3rSTYKOw==
Date: Tue, 4 Jun 2024 10:45:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: perf FTBFS due to -Werror with gcc 14.1.1
Message-ID: <Zl8akMdx92DdF7C_@x1>
References: <11178410.LHx4AX4RY1@milian-workstation>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11178410.LHx4AX4RY1@milian-workstation>

On Tue, Jun 04, 2024 at 01:40:19PM +0200, Milian Wolff wrote:
> Hey all,
> 
> I cannot build the acme perf/core branch on Arch anymore with gcc 14.1.1 and 

perf/core isn't being updated for quite a while, we nowadays update just
the perf-tools (current merge window) and perf-tools-next (next merge
window/devel).

Also I still keep my tree uptodate when I'm updating those branches, but
nowadays the trees/branches to be used are:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next

As Namhyung Kim is a perf tools co-maintainer and keeps one of these
trees+branch while I keep the other.

Right now I'm taking care of perf-tools while Namhyung is managing
perf-tools.next.

> Linux 6.9.3 due to multiple -Werror issues. Is this known and if so is anyone 
> working on it? Otherwise we can try to get this fixed ourselves and upstream 
> the patches then:

Can you please check if the problems are present in the above
trees+branches?

- Arnaldo
 
> ```
>   CC      builtin-record.o
>   CC      builtin-top.o
>   CC      util/metricgroup.o
>   CC      util/hist.o
>   CC      util/synthetic-events.o
>   CC      util/bpf-loader.o
> tests/bpf.c: In function ‘epoll_pwait_loop’:
> tests/bpf.c:36:17: error: argument 2 null where non-null expected [-
> Werror=nonnull]
>    36 |                 epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
>       |                 ^~~~~~~~~~~
> In file included from tests/bpf.c:5:
> /usr/include/sys/epoll.h:134:12: note: in a call to function ‘epoll_pwait’ 
> declared ‘nonnull’
>   134 | extern int epoll_pwait (int __epfd, struct epoll_event *__events,
>       |            ^~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97: 
> tests/bpf.o] Error 1
> make[3]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:140: 
> tests] Error 2
> make[3]: *** Waiting for unfinished jobs....
> util/metricgroup.c: In function ‘setup_metric_events’:
> util/metricgroup.c:289:39: error: ‘calloc’ sizes specified with ‘sizeof’ in 
> the earlier argument and not in the later argument [-Werror=calloc-transposed-
> args]
>   289 |         metric_events = calloc(sizeof(void *), ids_size + 1);
>       |                                       ^~~~
> util/metricgroup.c:289:39: note: earlier argument should specify number of 
> elements, later size of each element
> cc1: all warnings being treated as errors
> make[4]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97: 
> util/metricgroup.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> builtin-top.c: In function ‘prompt_integer’:
> builtin-top.c:360:21: error: allocation of insufficient size ‘0’ for type 
> ‘char’ with size ‘1’ [-Werror=alloc-size]
>   360 |         char *buf = malloc(0), *p;
>       |                     ^~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97: 
> builtin-top.o] Error 1
> util/bpf-loader.c: In function ‘config_bpf_program’:
> util/bpf-loader.c:551:29: error: ‘calloc’ sizes specified with ‘sizeof’ in the 
> earlier argument and not in the later argument [-Werror=calloc-transposed-
> args]
>   551 |         priv = calloc(sizeof(*priv), 1);
>       |                             ^
> util/bpf-loader.c:551:29: note: earlier argument should specify number of 
> elements, later size of each element
> cc1: all warnings being treated as errors
> make[4]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97: 
> util/bpf-loader.o] Error 1
> util/synthetic-events.c: In function ‘perf_event__synthesize_threads’:
> util/synthetic-events.c:1042:44: error: ‘calloc’ sizes specified with ‘sizeof’ 
> in the earlier argument and not in the later argument [-Werror=calloc-
> transposed-args]
>  1042 |         synthesize_threads = calloc(sizeof(pthread_t), thread_nr);
>       |                                            ^~~~~~~~~
> util/synthetic-events.c:1042:44: note: earlier argument should specify number 
> of elements, later size of each element
> util/synthetic-events.c:1046:29: error: ‘calloc’ sizes specified with ‘sizeof’ 
> in the earlier argument and not in the later argument [-Werror=calloc-
> transposed-args]
>  1046 |         args = calloc(sizeof(*args), thread_nr);
>       |                             ^
> util/synthetic-events.c:1046:29: note: earlier argument should specify number 
> of elements, later size of each element
> cc1: all warnings being treated as errors
> make[4]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97: 
> util/synthetic-events.o] Error 1
> builtin-record.c: In function ‘cmd_record’:
> builtin-record.c:4091:62: error: ‘calloc’ sizes specified with ‘sizeof’ in the 
> earlier argument and not in the later argument [-Werror=calloc-transposed-
> args]
>  4091 |                 rec->switch_output.filenames = calloc(sizeof(char *),
>       |                                                              ^~~~
> builtin-record.c:4091:62: note: earlier argument should specify number of 
> elements, later size of each element
> cc1: all warnings being treated as errors
> make[3]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97: 
> builtin-record.o] Error 1
> util/hist.c: In function ‘hist_entry__init’:
> util/hist.c:494:49: error: ‘calloc’ sizes specified with ‘sizeof’ in the 
> earlier argument and not in the later argument [-Werror=calloc-transposed-
> args]
>   494 |                 he->res_samples = calloc(sizeof(struct res_sample),
>       |                                                 ^~~~~~
> ```
> 
> Thanks
> 
> -- 
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt, C++ and OpenGL Experts
> 
