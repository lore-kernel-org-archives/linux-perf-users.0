Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7A15A864;
	Thu,  4 Jun 2026 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579266; cv=none; b=jOCblEI7MF54mcdcPFIpAND6MiOO7vz5K5idoJI6uxeG87psiAUET8XFdYqbExF3HY/SiT8l50c/Wzlo5tM9NRezIHT5uKs4+8D576rdsNfklOF22l7Xbf1YBsZN8qYXFm+/tY75zZl4gF+Us8B0HewuYaNxsakAuxD3BhhLIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579266; c=relaxed/simple;
	bh=L/46g8GHywuaVZ9yIHv6XGDKSGRu550Q6sP/k1hQdvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyY0KX3NHlKiX/wwI3lyachpOb7gjU3fl/1V85W7UZlIEAmOrmei1aYXGMez06hZ6FRmC8/gMAJsLmAI8kQw0fzsWJgVmOXebNnXTk6O2kVAx0Qb+a7sAp1sND2eZSjPZfnGt9/d1j3CcyHf2nxf1TLvKrC7h+07EpmKEZYSue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrzJn3Qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrzJn3Qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666851F00893;
	Thu,  4 Jun 2026 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780579265;
	bh=LHtlAw67LmoBkjlPK60ClPJkLav6FvjUMd5r03cVj/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OrzJn3QggCdBVs3Kjl2TZO9gacwJ1SwheLAVkpw//OOAr+09dUWDUw7owW48cxEof
	 jQirL5o9gw6oDX9oyX+JUmMobyvgGXrlAKqI+aJepEjVj4zxiBc5bMBkIF3eB/lVYf
	 docxvXB/jGpEKGRZ9m/U68OA/NZ7T+ZS5UlI5qacR2/AOlr4bCTNExIK19u3PTVDeG
	 jjtnIyCWuYwIZtj0q9/c++Jr7ZCEQ7XH2KgB7Nq3XjXpeFi6cPd1MJNTb9B+BG/+ZK
	 iiJzaJGdmZzxRNEaYu8nfwigIl6uV5CO+QUZDgFfQctyIGvQ2kCriRzReiTqFSfbTs
	 4HdqxnJnoZs6A==
Date: Thu, 4 Jun 2026 10:21:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4] perf bench: add --write-size option to sched pipe
Message-ID: <aiF7vEJNyxJcluC2@x1>
References: <20260603-perf_bench_pipe-v4-1-f48c0ba6d6cb@debian.org>
 <aiC6DA3o4L7mx0S7@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiC6DA3o4L7mx0S7@google.com>

On Wed, Jun 03, 2026 at 04:34:36PM -0700, Namhyung Kim wrote:
> On Wed, Jun 03, 2026 at 03:35:07AM -0700, Breno Leitao wrote:
> > The default ping-pong uses sizeof(int) (4 bytes) per iteration, which
> > exercises only the pipe-buffer merge path and keeps allocation entirely
> > out of the picture. That makes the bench a useful scheduler / context-
> > switch latency probe but unable to surface anything from the pipe
> > page-allocation hot path.

> > Add a -s/--write-size option that sets the bytes written and read per
> > ping-pong iteration. The buffer is allocated for each side via
> > struct thread_data and replaces the on-stack int previously used. The
> > default remains sizeof(int) so existing invocations are unchanged.

> > With --write-size set above PAGE_SIZE the bench drives anon_pipe_write()
> > through alloc_page() (or the bulk pre-alloc, if the relevant patch is
> > applied), which is what we want when measuring pipe locking and page
> > allocation work.

> > The bench is a ping-pong: both sides call write() before read(), so a
> > single write_size payload must fit entirely in the pipe buffer or both
> > sides deadlock waiting for the other to drain. Resize the pipe via
> > F_SETPIPE_SZ to match write_size (skipped at the sizeof(int) default),
> > and error out cleanly when the request exceeds
> > /proc/sys/fs/pipe-max-size.

> > Signed-off-by: Breno Leitao <leitao@debian.org>

> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, tested and applied:

    Committer testing:
    
      ⬢ [acme@toolbx perf-tools-next]$ perf bench sched pipe
      # Running 'sched/pipe' benchmark:
      # Executed 1000000 pipe operations between two processes
    
         Total time: 0.915 [sec]
    
           0.915493 usecs/op
            1092307 ops/sec
      ⬢ [acme@toolbx perf-tools-next]$ perf bench sched pipe --write-size 1024
      # Running 'sched/pipe' benchmark:
      # Executed 1000000 pipe operations between two processes
    
         Total time: 0.891 [sec]
    
           0.891915 usecs/op
            1121183 ops/sec
      ⬢ [acme@toolbx perf-tools-next]$ perf bench sched pipe --write-size 4096
      # Running 'sched/pipe' benchmark:
      # Executed 1000000 pipe operations between two processes
    
         Total time: 1.366 [sec]
    
           1.366073 usecs/op
             732025 ops/sec
      ⬢ [acme@toolbx perf-tools-next]$ strace -e fcntl perf bench sched pipe --write-size 4096
      # Running 'sched/pipe' benchmark:
      fcntl(4, F_SETPIPE_SZ, 4096)            = 4096
      fcntl(6, F_SETPIPE_SZ, 4096)            = 4096
      ^Cstrace: Process 17840 detached
    
      ⬢ [acme@toolbx perf-tools-next]$ strace -e fcntl perf bench sched pipe --write-size 1024
      # Running 'sched/pipe' benchmark:
      fcntl(4, F_SETPIPE_SZ, 1024)            = 4096
      fcntl(6, F_SETPIPE_SZ, 1024)            = 4096
      ^Cstrace: Process 17845 detached
    
      ⬢ [acme@toolbx perf-tools-next]$ strace -e fcntl perf bench sched pipe
      # Running 'sched/pipe' benchmark:
      ^Cstrace: Process 17851 detached
    
      ⬢ [acme@toolbx perf-tools-next]$
      ⬢ [acme@toolbx perf-tools-next]$ perf bench sched pipe --write-size 1048577
      # Running 'sched/pipe' benchmark:
      --write-size 1048577 exceeds /proc/sys/fs/pipe-max-size
      ⬢ [acme@toolbx perf-tools-next]$ cat /proc/sys/fs/pipe-max-size
      1048576
      ⬢ [acme@toolbx perf-tools-next]$
      acme@number:~/git/perf-tools-next$


- Arnaldo
