Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E020E702
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774107631; cv=none; b=Riym/mGWVwRWU1TXqoFX7gWVIqudN8oj1XvgJUf+NGzr1VAXkVa07vhKSpEqQvq67w+h53OxEKJ/BFV5Yj8e2LPlrCkyfRW6pOzpTXq7TeGy6rjQ1vNyER2r3719W6Uqhdks3CVW1LgVryNxwm8s4nFfxYuwL9FzaXZyZZQGkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774107631; c=relaxed/simple;
	bh=xeifeO8z3MuDy4wz8FY0AraYOOq9oBCxeUZOl9PPdGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YrYmpz6ZbYNnuxEwagObeGUKC4HAXr6Noa3tIE/avwU0WvlZO3b6rQVyNNxPRISQtpfB+LWXSCG/E9FS+Q2bhJOxGNPfxrxOdon4xotWtmQk+0wxqU1ofz/n2FadrIayA1UGvzB4Iqv0NginG4uN6bBo3B8ypj0TqC3E59rszdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FOZ7wN5j; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FOZ7wN5j"
Message-ID: <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774107617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1xbV5lFfC6JBplJ0yW6J+xSG/V2oZ+k7p4c0Lgblks=;
	b=FOZ7wN5jzEjmcPeHEMEzRELlraaK56uAqnRB4wDB+FTkkMN0PvWbe832ZM0t9+yudAWslS
	6qfvEjP9ys/Nn5dqYa/bgWtIRiB8cSmyD7uTD0uVykscneE5z8rSUruBpAoznQRrv2Erry
	SV9qvXNXF743EF154iYCQ/0chrxGKOI=
Date: Sat, 21 Mar 2026 08:40:05 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
Content-Language: en-GB
To: Ian Rogers <irogers@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20260321024446.692008-1-irogers@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260321024446.692008-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/20/26 7:44 PM, Ian Rogers wrote:
> The hashmap implementation contained strict aliasing violations.
> Specifically, the hashmap_cast_ptr(p) macro was casting pointers (such
> as void **) to long *, and these were subsequently dereferenced in
> functions like hashmap_insert(), hashmap_find(), and hashmap_delete().
>
> C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
> through an lvalue of an incompatible type. Dereferencing a long * to
> write to a void * object is a violation, even if they share the same
> size, as they are not compatible types. This can lead to undefined
> behavior, especially with aggressive compiler optimizations.

Potentially this could be a concern. Did you actually find an issue
with it?

The linux kernel build has
    KBUILD_CFLAGS += -fno-strict-aliasing

The libbpf does not have this flag. Maybe we should add '-fno-strict-aliasing'
for libbpf as well? This way, we can avoid any future potential
'strict aliasing' issues.

Note that bpf program (tools/testing/selftests/bpf/Makefile)
also has '-fno-strict-alaising' flag.

>
> Fix this by:
> 1. Updating hashmap_insert(), hashmap_find(), and hashmap_delete() to
>     take void * for their output parameters (old_key, old_value, and
>     value).
> 2. Modifying the implementation to use memcpy() and memset() for
>     accessing these output parameters. Accessing an object as an array of
>     characters (as done by memcpy) is a permitted exception to the
>     strict aliasing rules.
> 3. Updating the hashmap_cast_ptr(p) macro to return void *, ensuring
>     compatibility with the new function signatures while preserving the
>     static assertion that ensures the pointed-to type matches the size of
>     a long.
>
> Input parameters (key and value) remain as long, as they involve value
> conversion rather than incompatible pointer dereferencing, which is safe
> under strict aliasing rules.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/lib/bpf/hashmap.c | 21 +++++++++++----------
>   tools/lib/bpf/hashmap.h |  8 ++++----
>   2 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
> index 140ee4055676..ef50d262a126 100644
> --- a/tools/lib/bpf/hashmap.c
> +++ b/tools/lib/bpf/hashmap.c
> @@ -8,6 +8,7 @@
>   #include <stdint.h>
>   #include <stdlib.h>
>   #include <stdio.h>
> +#include <string.h>
>   #include <errno.h>
>   #include <linux/err.h>
>   #include "hashmap.h"
> @@ -153,24 +154,24 @@ static bool hashmap_find_entry(const struct hashmap *map,
>   
>   int hashmap_insert(struct hashmap *map, long key, long value,
>   		   enum hashmap_insert_strategy strategy,
> -		   long *old_key, long *old_value)
> +		   void *old_key, void *old_value)
>   {
>   	struct hashmap_entry *entry;
>   	size_t h;
>   	int err;
>   
>   	if (old_key)
> -		*old_key = 0;
> +		memset(old_key, 0, sizeof(long));
>   	if (old_value)
> -		*old_value = 0;
> +		memset(old_value, 0, sizeof(long));
>   
>   	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
>   	if (strategy != HASHMAP_APPEND &&
>   	    hashmap_find_entry(map, key, h, NULL, &entry)) {
>   		if (old_key)
> -			*old_key = entry->key;
> +			memcpy(old_key, &entry->key, sizeof(long));
>   		if (old_value)
> -			*old_value = entry->value;
> +			memcpy(old_value, &entry->value, sizeof(long));
>   
>   		if (strategy == HASHMAP_SET || strategy == HASHMAP_UPDATE) {
>   			entry->key = key;
> @@ -203,7 +204,7 @@ int hashmap_insert(struct hashmap *map, long key, long value,
>   	return 0;
>   }

[...]

