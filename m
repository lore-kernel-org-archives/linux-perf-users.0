Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933281A275;
	Fri, 10 Oct 2025 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760057470; cv=none; b=Z/VNNpIlRKgpMXsb0Dk91G0100yA6PuCUuFqBCZV/1BenAtJna7lByg3ByYDc6xedaj5PwQ+bbFaBbZGFeBsHdfaer5mMX0HyMYvI7wDF9BeBRSeQ+26UoEDAACSzCGqjrxWDcQT+pwNa6hodoTSW5DvufmqKA7KUYQUUxskqAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760057470; c=relaxed/simple;
	bh=A3UrofGwAstq0M2Uw/J4CU3Y1letTXoVhhSuZWoGGb8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VIcx6jeqEOLAHTEOLuGbUcIbZQKWBi0qImk8Cz26SsFPTkOVtVNWcdVmnH9ej7QUt7S41OAV6MVOMk9X9nF8f5v306gkAcVCiRpzvKXBt/5fxPHurLeRVkNSPAyxc7m/dc2OxNZTmNavXOmK0FnSFeg2afZASJDyEJ5DQFNGv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2JktYbzm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2JktYbzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24497C4CEE7;
	Fri, 10 Oct 2025 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760057470;
	bh=A3UrofGwAstq0M2Uw/J4CU3Y1letTXoVhhSuZWoGGb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2JktYbzmhzcnUjZxn4TJsLrCa4CdQmyNAz48GhTm60ifXFoRmbMF9Tc/M9RRLbvJV
	 OTvz7R6JSbLUT9mEhQjhUsNNq5Xpz4vLivUTBLXDvZAdv81wS0YgNddSVET7bP2mj+
	 E2cRLHzPEXFAzCsftZVpoY141RGvPOXXQkXJVlZA=
Date: Thu, 9 Oct 2025 17:51:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>, Alexander
 Potapenko <glider@google.com>, Randy Dunlap <rdunlap@infradead.org>, Marco
 Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Sami Tolvanen <samitolvanen@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Rong Xu
 <xur@google.com>, Naveen N Rao <naveen@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Andrii Nakryiko <andrii@kernel.org>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Nam Cao <namcao@linutronix.de>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, llvm@lists.linux.dev, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/23] mm/ksw: Introduce real-time KStackWatch
 debugging tool
Message-Id: <20251009175107.ee07228e3253afca5b487316@linux-foundation.org>
In-Reply-To: <20251009105650.168917-1-wangjinchao600@gmail.com>
References: <20251009105650.168917-1-wangjinchao600@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu,  9 Oct 2025 18:55:36 +0800 Jinchao Wang <wangjinchao600@gmail.com> wrote:

> This patch series introduces KStackWatch, a lightweight debugging tool to detect
> kernel stack corruption in real time. It installs a hardware breakpoint
> (watchpoint) at a function's specified offset using `kprobe.post_handler` and
> removes it in `fprobe.exit_handler`. This covers the full execution window and
> reports corruption immediately with time, location, and a call stack.
> 
> The motivation comes from scenarios where corruption occurs silently in one
> function but manifests later in another, without a direct call trace linking
> the two. Such bugs are often extremely hard to debug with existing tools.
> These scenarios are demonstrated in test 3–5 (silent corruption test, patch 20).
> 
> ...
>
>  20 files changed, 1809 insertions(+), 62 deletions(-)

It's obviously a substantial project.  We need to decide whether to add
this to Linux.

There are some really important [0/N] changelog details which I'm not
immediately seeing:

Am I correct in thinking that it's x86-only?  If so, what's involved in
enabling other architectures?  Is there any such work in progress?

What motivated the work?  Was there some particular class of failures
which you were persistently seeing and wished to fix more efficiently?

Has this code (or something like it) been used in production systems? 
If so, by whom and with what results?

Has it actually found some kernel bugs yet?  If so, details please.

Can this be enabled on production systems?  If so, what is the
measured runtime overhead?
