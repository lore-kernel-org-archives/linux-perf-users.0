Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D82F5302;
	Tue, 17 Jun 2025 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750196958; cv=none; b=JscFfYxo3ccKg+7iQD+EsDnfyq01e8CyGYx3pQqL5nVnpqspdGZz55gwKbuDX5ySahccF1jb208asxF6H0XAEpbr5PU1afwvu5kUga6K0M/RJNhxAzcUUXKBK1sZkxtO14Dcagv/M5HcXfpOvEnotFGGWe1XUvvWgp217jc+mDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750196958; c=relaxed/simple;
	bh=7XpKNyduYd7HZ4lR7XtY36sozGh6y07qukvqZEHKC1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok6Ue94nhCZ/8f+OkaKEX6ACd6saHgMGfZFsBS1gPfDR/eCUmp9rxa5fHB5R2en1QKiJ2eupoJpv2JBDBZRGzkcAicG1KG5M+QRrjHComdjOWE+OBxZq3G3nr2rv1siiqaBTT7WaGVMCTdTWakGmAgMvkZmG9/3JcANVgNqY3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhavmyD+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhavmyD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B548C4CEE3;
	Tue, 17 Jun 2025 21:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750196955;
	bh=7XpKNyduYd7HZ4lR7XtY36sozGh6y07qukvqZEHKC1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhavmyD+hHibOpPUmDwZrtIx1P4Nolb+XiaK7K5mZRgmWLRTYkW/KRBxHkUZriGy6
	 hP6HFq6dhvEuXEZqEiPG0LUsDJzPFbDGek9dr+9ohjCiJfhTclR5ye8mnV4Js2Ip+6
	 kZAiyr1aHvR1d7V7CrZMK0PWB6Magkh9zMpk30Fh68aSPpIgMRcgvtSDMhmQXrWNvy
	 hFTx+m3AFsPyoDuiLlMz5OHPIuLfFLX2wsL2v8ae3ziOvQFHLVpnnEBK6N0VizqWB0
	 78j2IE2o4oyGzQQZNqTfQwVTCwMwtqnrX9Fi7lTRxecLXIE0GErR1p74Kxkqi7w3mN
	 2CgSuGrryxrDA==
Date: Tue, 17 Jun 2025 18:49:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Howard Chu <howardchu95@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <aFHi2FUDZy_cEA5A@x1>
References: <20250614004108.1650988-1-irogers@google.com>
 <20250614004108.1650988-3-irogers@google.com>
 <CAH0uvojjfOcoZmxPL+bG5NEid8xcAVth7UxOUc=aYjgF5nqs2A@mail.gmail.com>
 <aFBF1ejZQBBvX7F4@x1>
 <aFHeY_-hVNKtXPAD@x1>
 <CAP-5=fWXQBdg8Uq1hFgRPC4z4vQAvUuT6TnUkPHSBfdGPNaYwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWXQBdg8Uq1hFgRPC4z4vQAvUuT6TnUkPHSBfdGPNaYwg@mail.gmail.com>

On Tue, Jun 17, 2025 at 02:32:37PM -0700, Ian Rogers wrote:
> On Tue, Jun 17, 2025 at 2:30 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Mon, Jun 16, 2025 at 01:27:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Fri, Jun 13, 2025 at 5:41 PM Ian Rogers <irogers@google.com> wrote:
> > > > > Caught by leak sanitizer running "perf trace BTF general tests".

> > > > > Signed-off-by: Ian Rogers <irogers@google.com>

> > > > Acked-by: Howard Chu <howardchu95@gmail.com>

> > > Small enough, applied to perf-tools.

> > root@number:~# perf trace -e *sleep ls
> > anaconda-ks.cfg  bin  bla  commands  dtel  firefly  logind.conf  perf-install.txt  python
> > perf: Segmentation fault
> > Obtained 11 stack frames.
> > perf() [0x5c595e]
> > perf() [0x5c59f9]
> > /lib64/libc.so.6(+0x19c30) [0x7fd43ce27c30]
> > perf() [0x5dc497]
> > perf() [0x492d54]
> > perf() [0x49860e]
> > perf() [0x49890e]
> > perf() [0x413413]
> > /lib64/libc.so.6(+0x35f5) [0x7fd43ce115f5]
> > /lib64/libc.so.6(__libc_start_main+0x88) [0x7fd43ce116a8]
> > perf() [0x413a45]
> > Segmentation fault (core dumped)
> > root@number:~#
 
> Thanks, I'll take a look to see if I can spot what's broken. Seeing
> this stack trace makes me remember we haven't landed:
> https://lore.kernel.org/lkml/20250611221521.722045-1-irogers@google.com/

Yeah, I just pushed perf-tools to soak in linux-next/pending-fixes for a
few days and will switch to processing patches for perf-tools-next, will
try and pick that one, I also noticed that the backtrace wasn't
symbolized, thus your patch wasn't there :-\

- Arnaldo
