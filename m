Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4881A2C11;
	Wed, 24 Sep 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733593; cv=none; b=nd5Utn10XP8GmlDKnwMXV6IX6xYZBQupIey3EvcdVLvHgSsMoXbrHl8LOhRl2BIe93S+n0rjHyc9nYIrU43yofxoq9fpHbx8uU1HHYhT+EL81Vcl0C8eLmG5B9Hx+Kt4UlES7PclPFrKaq4xKDKSC2pv3RKC4NLAI0NluUXdMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733593; c=relaxed/simple;
	bh=UHknWmUfVJmkxwSKbBmantXcg7nJDEjwNFGWpWAZZfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QeYkqXClOvpqHK7p/vs5mauvrKWwk8nalUFAoR4ieJwsDRrMrlRgZ4Q+E83i/ZlNYCHjQuX1dL7QvhQlktmXxYQz9AaILnKJzpChtPvNF/nrkKvS7V8r2pjb/QEu9ZUnNkug8Rv0loNE0LDG6xKVcSlUV3aOmEWRFnZx+4AwLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yMVBBGhb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yMVBBGhb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=IYQIoIaOKCIxSPFzuBjsQ4uTXQsp3WYZ5kAt8a5vPEc=; b=yMVBBGhbm0CLYR9iFKaFxB3NzJ
	FXsEMYpXS5BwrQo17beyxJiRF2eVpGI37E9rSScck4hHw7aBHt5YlROsnbqzqNynVBbOpBK+bH4xA
	d4oSxLXDN+d1N4dURwP2zisz/dR1m1MfYNw52WiMxW4vz4mLOMWOKB0Wa7U7jG3vPDZ/fDAtkynDe
	/yChEJFGyaVg0aegV7Xclx32TR9w6OXlJSugh0eeEuBAmJUWTbXUouRNbYmBC26Ch6S9bG4KkD/JN
	0sJx+0tCnHqSZtp844pJs4qAs3W/+Y2If0aodsX3aSvG4UBodN3W37nDPJ172u5zEg0HNdRMsOaW/
	z06hMXNQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1SwW-00000001yYJ-3ITs;
	Wed, 24 Sep 2025 17:06:12 +0000
Message-ID: <3504b378-4360-4e55-b28d-74aabd4308d7@infradead.org>
Date: Wed, 24 Sep 2025 10:06:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/23] mm/ksw: add build system support
To: Jinchao Wang <wangjinchao600@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Alexander Potapenko <glider@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kees Cook <kees@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sami Tolvanen <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Rong Xu <xur@google.com>,
 Naveen N Rao <naveen@kernel.org>, David Kaplan <david.kaplan@amd.com>,
 Andrii Nakryiko <andrii@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Nam Cao <namcao@linutronix.de>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 "David S. Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
 <20250924115124.194940-5-wangjinchao600@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250924115124.194940-5-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/25 4:50 AM, Jinchao Wang wrote:
> Add Kconfig and Makefile infrastructure.
> 
> The implementation is located under `mm/kstackwatch/`.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  mm/Kconfig.debug             |  8 ++++++++
>  mm/Makefile                  |  1 +
>  mm/kstackwatch/Makefile      |  2 ++
>  mm/kstackwatch/kernel.c      | 23 +++++++++++++++++++++++
>  mm/kstackwatch/kstackwatch.h |  5 +++++
>  mm/kstackwatch/stack.c       |  1 +
>  mm/kstackwatch/watch.c       |  1 +
>  7 files changed, 41 insertions(+)
>  create mode 100644 mm/kstackwatch/Makefile
>  create mode 100644 mm/kstackwatch/kernel.c
>  create mode 100644 mm/kstackwatch/kstackwatch.h
>  create mode 100644 mm/kstackwatch/stack.c
>  create mode 100644 mm/kstackwatch/watch.c
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 32b65073d0cc..89be351c0be5 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -309,3 +309,11 @@ config PER_VMA_LOCK_STATS
>  	  overhead in the page fault path.
>  
>  	  If in doubt, say N.
> +
> +config KSTACK_WATCH
> +	bool "Kernel Stack Watch"
> +	depends on HAVE_HW_BREAKPOINT && KPROBES && FPROBE && STACKTRACE
> +	help
> +	  A lightweight real-time debugging tool to detect stack corrupting.

	                                                         corruption.

> +
> +	  If unsure, say N.


-- 
~Randy

