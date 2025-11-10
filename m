Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF02D949C;
	Mon, 10 Nov 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796030; cv=none; b=RvFGxNMP0mYG5mfnwrx3s01YvzitCDJCDoxp4O/SJ8pcuFQDvEVv6f510c5VkgUU5Yk/TNYb+p+ZZb9dFLpPr2gmMaws5amZ9yDTkC5uff+94/DO7iDDkrovDQkx3zkjPi2ajlLqFvLMM23uQFwesCzD3VOLpRb1oIxTnu7dkJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796030; c=relaxed/simple;
	bh=Z65kV1Uw8YhvpmxyXTmJd7OOEOvEvS3Dp6tVF1Yvh40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3xLci0Fjt7dsIWrwiUi6WCqftEccWbR/+72XOBahwF6Hl5BpwTwSbKb35kLRosK5i+CizI54yoeqv9nUXkTeweasZLxtXDecMHTXzVf0H0C+mcjORktS85ZVUkGU61S3Ejel/AS3H9iE3KPmZ/eGP5Xlvatm4l4Ov8m250jesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hDu5eaBS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hDu5eaBS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ag6LW6hemevws8YrksBMYRPO4jlV1oMVj+5QJ4bp/14=; b=hDu5eaBS1pVnzx5mZNWnb8VpqO
	VFIdXUQKfLY8jwIzevEr+VfCN/w6HRq94VSeLELvL0tCdMRmTaKp+OoyCquDJ1YKftqgTXnGuXivN
	e7G1fRZ4akwXOIQlabKzKhURAD4V49v5AvJZjhK7oI11kCGjD6M+HDEdDojgdSauv5/UUlrCYfnMm
	VAEBeFyDxGQHEYv+LH8xct0W4ckP/Ijd7RaaLXzyI8yN0V8JTcE+DuFgiFbC9Kj8GA4O/wX2rCojR
	GDrtV0Zx8uqP60OizixU9gPweGirxQv8fXvN0WQKr4ad6yRB5QhoGbajemapDE6BEyY/3ih/ECIDt
	Ia90NZoA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIVla-00000002xxn-1bOm;
	Mon, 10 Nov 2025 17:33:22 +0000
Date: Mon, 10 Nov 2025 17:33:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>, Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>, kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>, Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 00/27] mm/ksw: Introduce KStackWatch debugging tool
Message-ID: <aRIh4pBs7KCDhQOp@casper.infradead.org>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>

On Tue, Nov 11, 2025 at 12:35:55AM +0800, Jinchao Wang wrote:
> Earlier this year, I debugged a stack corruption panic that revealed the
> limitations of existing debugging tools. The bug persisted for 739 days
> before being fixed (CVE-2025-22036), and my reproduction scenario
> differed from the CVE report—highlighting how unpredictably these bugs
> manifest.

Well, this demonstrates the dangers of keeping this problem siloed
within your own exfat group.  The fix made in 1bb7ff4204b6 is wrong!
It was fixed properly in 7375f22495e7 which lists its Fixes: as
Linux-2.6.12-rc2, but that's simply the beginning of git history.
It's actually been there since v2.4.6.4 where it's documented as simply:

      - some subtle fs/buffer.c race conditions (Andrew Morton, me)

As far as I can tell the changes made in 1bb7ff4204b6 should be
reverted.

> Initially, I enabled KASAN, but the bug did not reproduce. Reviewing the
> code in __blk_flush_plug(), I found it difficult to trace all logic
> paths due to indirect function calls through function pointers.

So why is the solution here not simply to fix KASAN instead of this
giant patch series?
