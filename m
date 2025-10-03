Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFCB253B40;
	Fri,  3 Oct 2025 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524666; cv=none; b=ihjNQWrNKjhHS2PEqT+nJXA+18HL67c64WfueG1/r7SxXCWW/cwPpHc3uleIlse8/vVAfXgK+CvvG5C8f+fsaOzqvcKCH4if/1OktBpzW89+/rq5MOtC9RfkqBQKupbwWhiZJYXEGDg8he1tZhnrzxQE4RuoNXvBjayVEdZGt7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524666; c=relaxed/simple;
	bh=bZr+Lvkb5M6Ufx0akrIYv+VR8dkYeZRAOvoeF3RPvsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ArnWUhXLUdvRaJOD1J2q2n6uL+3EDuWDBk3lcB4ZdorhZv5xvImhhD+vK1Cr7o60sGAv9gqlIHwuHWKOchkNqVDUHY+ZhddyGtxZZgraHq0kMrEUYFb9JDr5SP2o5JIEN+B1cRLV4FCNiysNQYEoZKz6XrwC5NAr3TzsuKoO0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lrx+Opa8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lrx+Opa8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=oIs3ppVLk6gw/qZXypZLZcOfa+yCn//X21VZFkDaLYU=; b=Lrx+Opa8kAlfEXuyu8nZrskDYS
	RMEVW1K3EtHWtp/TNPMDl4+TZidS8rII6LOpnPv0qEvXnZn1PtaWNoVRLLHkzUnhbCR3Tfh1MpEHf
	ZkZd/NEu3t0eSIf0IaCZTwNSp4G961ZaVD/mJjLljb3ViiQ31g8H8jJABJOEx687ZtuOQgxZ+AsqI
	LmC9fUttLZOzjyJF2FAdnCTKBCeWjOa6Rmq3x9FU9+hZojGWXCUyKadvy1un7W8qu/DrpcU76pUyT
	OX6o9m0+7SucZJP87UviQ0UOsMWHeilEIIYasmiArPjulk9Jci/3QFC7WnJj9QL3uPYwy+SzCuC2Q
	D0kAwH9A==;
Received: from [50.53.25.54] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4mjl-0000000D7bQ-0Z25;
	Fri, 03 Oct 2025 20:50:45 +0000
Message-ID: <3913273d-12e2-426f-aec7-263b7f49008a@infradead.org>
Date: Fri, 3 Oct 2025 13:50:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/23] MAINTAINERS: add entry for KStackWatch
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
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
 <20250930024402.1043776-24-wangjinchao600@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250930024402.1043776-24-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/29/25 7:43 PM, Jinchao Wang wrote:
> Add a maintainer entry for Kernel Stack Watch.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 520fb4e379a3..3d4811ff3631 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13362,6 +13362,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
>  F:	Documentation/dev-tools/kselftest*
>  F:	tools/testing/selftests/
>  
> +KERNEL STACK WATCH
> +M:	Jinchao Wang <wangjinchao600@gmail.com>
> +S:	Maintained
> +F:	Documentation/dev-tools/kstackwatch.rst
> +F:	include/linux/kstackwatch_types.h
> +F:	mm/kstackwatch/
> +F:	tools/kstackwatch/
> +

Add entries in alphabetical order, please.

>  KERNEL SMB3 SERVER (KSMBD)
>  M:	Namjae Jeon <linkinjeon@kernel.org>
>  M:	Namjae Jeon <linkinjeon@samba.org>

-- 
~Randy

