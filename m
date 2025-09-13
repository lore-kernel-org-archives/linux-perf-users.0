Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658A13AD05;
	Sat, 13 Sep 2025 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757736801; cv=none; b=Kkjuge7HR53z1NDlubOh2GtCXMMRPYALblRq0iVfA1Cu3/sTbpq4EHLepEg9qXuLqKvHbaOZGpkl8OuX+4xVbeWwlxvvzs9RBmhwydJip0Bd2/XPe7z80s/RUqtlY/7GYctLTOF2vU9mS0zhE9AeH99LsAj0rJ2/zDEzyHRuU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757736801; c=relaxed/simple;
	bh=U9kKsshevJqGszGf9fsgE68j9TrfFI4hVI82DPtJMYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BNmrP0addK4CP3H/iEFOIlC4+bIVxOWgcTrQIiWe9xC6eC1smiXzuZluCmV0yY6AdHa2IbiZ3TDqCKa/5ulxXKf/Hc0uyWl2+wXMNKPZ5dBmyG2pYh4MghILqz/cnvfWaAqpoiDaCSPS4zlX9sv5LJ9ExYzUrFpoeZ64FYNtljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xPzy07H5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xPzy07H5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=u7ndZnQxyXKvcCzhFli8oZf0PjWLBirdplU5n0FJmLw=; b=xPzy07H5oLyRzMkKUDnRYxRbA8
	FB9s/mgtYrIEncNja4JJjGye+zGOM5arCPaXRnqY0vBLCsFj8oDAeoSE0UqBh4+bDiLKE1WlvVIGg
	KVrxlIQZrGV8DB3SCKRdz/WridjNvy5CXv+SD1Va6LVYxjNBA+mGHiEbQRiwSEI+cHvjloDDoXglj
	0dK5WfUej0zVDXKQOXKsr5DuKq3kr+d9vFJrusNVKTTSLwcsCky4pU6kPywtug6qim/3Nk3gXwtyf
	vbw1VCU9MqDSbqZvzBQzA1VgqzMvxCdl5wn99ll+PJEWgdoqb2XafQieoBP+l+brAtdIBvxrTKifR
	pUY01Pvg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxHdN-0000000D6om-3RkA;
	Sat, 13 Sep 2025 04:13:09 +0000
Message-ID: <6b5e5d3e-5db8-44f2-8dca-42f317be8e0d@infradead.org>
Date: Fri, 12 Sep 2025 21:13:07 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/21] HWBP: Add modify_wide_hw_breakpoint_local() API
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
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
 <20250912101145.465708-4-wangjinchao600@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250912101145.465708-4-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 3:11 AM, Jinchao Wang wrote:
> +/**
> + * modify_wide_hw_breakpoint_local - update breakpoint config for local cpu
> + * @bp: the hwbp perf event for this cpu
> + * @attr: the new attribute for @bp
> + *
> + * This does not release and reserve the slot of HWBP, just reuse the current

                                                 of a HWBP; it just reuses

and preferable s/cpu/CPU/ in comments.

> + * slot on local CPU. So the users must update the other CPUs by themselves.
> + * Also, since this does not release/reserve the slot, this can not change the
> + * type to incompatible type of the HWBP.
> + * Return err if attr is invalid or the cpu fails to update debug register
> + * for new @attr.
> + */
> +#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
> +int modify_wide_hw_breakpoint_local(struct perf_event *bp,
> +				    struct perf_event_attr *attr)
> +{

-- 
~Randy

