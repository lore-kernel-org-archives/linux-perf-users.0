Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9935968;
	Sat, 13 Sep 2025 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757736470; cv=none; b=a40kHDTc1CUdRoaw7jYIuKPN2mfPtR3Vq3wJ6UwBIdFttwlHSmf2j+O0sjxG3xx1BdAP3etWEevwYOPeuAQ0bC2AuTDNzORMwUCpJ/tdgFA/qjdtlTL6tqQE2XqlRCQU45IB64eWgIWRf9p/CZzkPURvmFe9srWpLLn/XupVVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757736470; c=relaxed/simple;
	bh=bzsI36RMc40NVQUbrU8x0jkLVmvncWaugvL4iQIAccU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KQTb4wel1AMHpvEzk2ene8+rTsIjJxUYZfnQnsN9E2FuNxo63SmV+EazmyT11B0oI/2b96lxEg7MpbFcn7pUKGRittBESIPfnawMkD98Jk/A6bCht3Qb/MXrHsqNDmZUL/zuCUo2yxNkVop2GdTje1tw0bKNyZE75ynX+hkhzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zvj7+2VJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zvj7+2VJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=ZkZpc5dBMnXI4POCZ2TCFFqEd7xijX/+QZHk6h+vWnA=; b=Zvj7+2VJQP1AUrM1oc0jI4D0df
	kZLbrgoF6tWC1TSXrQCzaRwf64BcIFqWM9jqgctShxRWwA64Z3cH3ZJp9xtz/vExBAcClQcmfIZn7
	yCcLB+AesJzDmEPSjA8I8PqMwPg+QtoHLtCCGQwR4t8mmkzazK/OjVldlPQMX7eK39OikaYuiFAkS
	f3j34JKAUXKzXllob2T5kCBHPFSR85WlWQfJBGW6vvdYMXS8Z3QXIbkl5YsAeQ69QGvyvU6VGYXVL
	zapYbucIouJWo+hLXEvQIBUIuwgelZEWHzU6JUYSd+NcP/fFDMoT6FMSctoEiTHXQLnPtkJJ7TQUx
	RnGJ92cg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxHXd-0000000D5gz-1paw;
	Sat, 13 Sep 2025 04:07:13 +0000
Message-ID: <69198449-411b-4374-900a-16dc6cb91178@infradead.org>
Date: Fri, 12 Sep 2025 21:07:11 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/21] mm/ksw: add test module
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
 <20250912101145.465708-16-wangjinchao600@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250912101145.465708-16-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 3:11 AM, Jinchao Wang wrote:
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index fdfc6e6d0dec..46c280280980 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -320,3 +320,13 @@ config KSTACK_WATCH
>  	  the recursive depth of the monitored function.
>  
>  	  If unsure, say N.
> +
> +config KSTACK_WATCH_TEST
> +	tristate "KStackWatch Test Module"
> +	depends on KSTACK_WATCH
> +	help
> +	  This module provides controlled stack exhaustion and overflow scenarios
> +	  to verify the functionality of KStackWatch. It is particularly useful
> +	  for development and validation of the KStachWatch mechanism.

typo:	                                        ^^^^^^^^^^^

> +
> +	  If unsure, say N.

-- 
~Randy

