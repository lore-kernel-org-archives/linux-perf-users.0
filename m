Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1013019DE;
	Fri, 10 Oct 2025 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126547; cv=none; b=PllwvtcNv3FVm0O/4XyNlu+ofVE3Ze/LQRMRtKnk/NO+Kd7QGCwzSDW0moEEy/hn+OC2dwIcpHD0YtaBrQiEcVtSaYgm9U42MaFRf3myKvodBPaHA+Muv0Nj3u5E76f2lrobhC8QeDEYgNZXLkU1ZtnwrwdCNDosfAn5cRtua2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126547; c=relaxed/simple;
	bh=Gq8iru9xAslZ95vTaUJQXj6P7gEo738ViH0eAmET2Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EOoMcc7uTZTIHQWFcR3D9mx5m/RmaLGNMB3C5VdaHmUhSmnkznsnSYwGFGwEf/BBDMRiPUBxtlYa72RRFpDH4Sbn8a90FDkTuN0Ihvl9VQNC8jaFJQqHLD8APPBGoD45FbCWMr+H6r5LMipFjdiUoYdd6EzyXe2LgTW3MCL2te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Avo+7IaE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Avo+7IaE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=1uOItTL0KBTFqu9SxT/ohOMw6976arZ30lgBj7Y1/To=; b=Avo+7IaE91NLFjM4HOJOUnOGLL
	579y9RDwAw7L205S678TugPGGJueV/XNuSmkwxei4bF6/2W5x2VWUnbbqFLsBbXbeTAzX9Oa1uZld
	YjIbaZKfyuJOSs6+hja6mjaZfDPm2qk03Q/mtIgTM5vmnNklwo2byLo4ZYWpP4RF/H3JN7TSM/ka6
	2/InTtiMWRIs2bw+SE9iTahmLMs0c3T5iEQBBcJb9OjV5XJ4kyNWfuOf5SvoqqoBlyD4unvQNTRFh
	JFzLZKTphPb+Fw+WCUpW9lU986SZmFhw0U+sXf8mBU7+ecoo6KsCLQLI679yMaPn254rqJRJz6AZc
	y7T7E4/A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7JJb-00000009HMt-11L2;
	Fri, 10 Oct 2025 20:02:11 +0000
Message-ID: <c1b2ec8c-0c09-4356-819c-7d2ee28b47f2@infradead.org>
Date: Fri, 10 Oct 2025 13:02:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/23] docs: add KStackWatch document
To: Jinchao Wang <wangjinchao600@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Juri Lelli <juri.lelli@redhat.com>,
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
References: <20251009105650.168917-1-wangjinchao600@gmail.com>
 <20251009105650.168917-23-wangjinchao600@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251009105650.168917-23-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/25 3:55 AM, Jinchao Wang wrote:
> Add documentation for KStackWatch under Documentation/.
> 
> It provides an overview, main features, usage details, configuration
> parameters, and example scenarios with test cases. The document also
> explains how to locate function offsets and interpret logs.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  Documentation/dev-tools/index.rst       |   1 +
>  Documentation/dev-tools/kstackwatch.rst | 314 ++++++++++++++++++++++++
>  2 files changed, 315 insertions(+)
>  create mode 100644 Documentation/dev-tools/kstackwatch.rst
> 

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
