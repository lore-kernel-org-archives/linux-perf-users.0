Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A532F0036;
	Tue, 17 Jun 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195816; cv=none; b=H6FdBRFxeW821iyiHXuOXkk1s5oUPueRLzL14pBl24iXVC71Mhikyj2cY+hoLicFbuXVjRH53qbd+xYTH26egrMGp5T9lFXVn3UUpdMn14wZXlhAEIehGaE/Y87lhBjfF7YDq7TKybY8LL6hde6aq+A0pPaFOaOVcvgOiFmFu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195816; c=relaxed/simple;
	bh=X19Ye8EF8Rp89W90Ce0baJd8El5CfJxp6Ir6ZXClc/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRd8cMk9lXt+eFhy/50dlxXGJAMMj2ZJ+vuwhuG/LaReai6wg5uGohMEt22MQnbHvz+g7xq4VmFn7hM1fGykpvlB4Rk4+O+bcN3okUgkd7ZeZVGbpnjgPUILWs0Z60mfZTdGgK4Vg3Aov3K2ajz2aDLh4h6e6HMHxQkHVAYcX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEe9XWYB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEe9XWYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA016C4CEEE;
	Tue, 17 Jun 2025 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750195814;
	bh=X19Ye8EF8Rp89W90Ce0baJd8El5CfJxp6Ir6ZXClc/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEe9XWYBVvyAvv4Fi9EM3m7sdLSGIQwMgIQ9JTKHs6YpvA4QuVe+sgMFMHM+ulGXI
	 s+mni8kQW3N2AHIXnpdtC4Az6vwD7dfUdH/K5kIY5V11beZ/f7ErWyfdsil7mS0ihV
	 70WLEnaL8dZqYsmaEtC7n1Jq7fABTQSskV9hDf3UW3M6d+lpmTmdIWXE08b72B8YxP
	 nmtKygaQEpxKU3Ez7gg9eaOyka5YHnaWPbx1vNpPQwtvyAFzZ0ldhWfvXp1GcJ1ObE
	 2MHm9Ei6ID2ewED7Hr/fcrOU8bLMmNgNayulySp3ZWxJEQ+i3oJzRFnu2dKSUjmfii
	 k8Cjs4JaamgfA==
Date: Tue, 17 Jun 2025 18:30:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] perf trace: Add missed freeing of ordered events
 and thread
Message-ID: <aFHeY_-hVNKtXPAD@x1>
References: <20250614004108.1650988-1-irogers@google.com>
 <20250614004108.1650988-3-irogers@google.com>
 <CAH0uvojjfOcoZmxPL+bG5NEid8xcAVth7UxOUc=aYjgF5nqs2A@mail.gmail.com>
 <aFBF1ejZQBBvX7F4@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFBF1ejZQBBvX7F4@x1>

On Mon, Jun 16, 2025 at 01:27:04PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 13, 2025 at 09:16:26PM -0700, Howard Chu wrote:
> > TL;DR: (definitely lost: 5,248 bytes in 17 blocks, 3,586 bytes in 12
> > blocks) -> (definitely lost: 4,992 bytes in 16 blocks, indirectly
> > lost: 0 bytes in 0 blocks), the leak of thread__new() is fixed.
> > 
> > Thank you so much for fixing this.
> > 
> > On Fri, Jun 13, 2025 at 5:41 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Caught by leak sanitizer running "perf trace BTF general tests".
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > 
> > Acked-by: Howard Chu <howardchu95@gmail.com>
> 
> Small enough, applied to perf-tools.

root@number:~# perf trace -e *sleep ls
anaconda-ks.cfg  bin  bla  commands  dtel  firefly  logind.conf  perf-install.txt  python
perf: Segmentation fault
Obtained 11 stack frames.
perf() [0x5c595e]
perf() [0x5c59f9]
/lib64/libc.so.6(+0x19c30) [0x7fd43ce27c30]
perf() [0x5dc497]
perf() [0x492d54]
perf() [0x49860e]
perf() [0x49890e]
perf() [0x413413]
/lib64/libc.so.6(+0x35f5) [0x7fd43ce115f5]
/lib64/libc.so.6(__libc_start_main+0x88) [0x7fd43ce116a8]
perf() [0x413a45]
Segmentation fault (core dumped)
root@number:~# 

⬢ [acme@toolbx perf-tools]$ git bisect good
e340815ea559052d8d590a145bab7d7105608e7d is the first bad commit
commit e340815ea559052d8d590a145bab7d7105608e7d
Author: Ian Rogers <irogers@google.com>
Date:   Fri Jun 13 17:41:06 2025 -0700

    perf trace: Add missed freeing of ordered events and thread
    
    Caught by leak sanitizer running "perf trace BTF general tests".
    
    Signed-off-by: Ian Rogers <irogers@google.com>
    Acked-by: Howard Chu <howardchu95@gmail.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Michael Petlan <mpetlan@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
    Link: https://lore.kernel.org/r/20250614004108.1650988-3-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 tools/perf/builtin-trace.c | 2 ++
 1 file changed, 2 insertions(+)
⬢ [acme@toolbx perf-tools]$

Removing it:

root@number:~# perf trace -e *sleep sleep 1
     0.000 (1000.057 ms): sleep/2693449 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7fffedc43ab0) = 0
root@number:~#

- Arnaldo
