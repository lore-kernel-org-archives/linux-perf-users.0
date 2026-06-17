Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAEA481FC5;
	Wed, 17 Jun 2026 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711056; cv=none; b=OpWULjjRJuqe5ZEOGW892Jc5mDajAdplIhpCj4/7bn3Jxb0RVap3qrlHVAzNsYAVvT6Pcg21CthJQtGzKyjHPyRVwx+EEGCbxHewz2Z0M5+gsWLA/Aydi1kT9C7RZzkNUWhLl19s6Ys295CUBeVUiyaYhVy+LtPayXYMpIyY0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711056; c=relaxed/simple;
	bh=1HQ4a4Dl85pAwQ1Dgb7hZ6w8jgNc8M+D6z1LaNkHaic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eY5P7LkSFr/B27Xcb+C5Ya3aMPNC+/f8PdeanedXNxA2/L/WEOzqxax+BKSWRVi0EZIBUCBNB6NZ7R15vJ1/0EffaXl2olfJlxSZ4QNc7N1syoKbmv+u13LbR2G4Tj479YJW95rrU43zXg0IlWybbdOpVm0HfS55VuvfgelPzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vui+RbKz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vui+RbKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80071F000E9;
	Wed, 17 Jun 2026 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781711044;
	bh=1TAgFApN80fcmmNyjyNMlPTWUGq7LZN46gw2nsxQugA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vui+RbKzz4Ax+sB8/mbY8K3M2wJl6s4Ce8o1di1sEhMyEmYMjIcgQBOrM3xVpRlR1
	 XJo+wzrHWo4lh7+mcRfyWTxRkGFLOnxcQ3pWHybkaYQCKE1P/pzzM6BR2GPvGlt+Eu
	 xPmKwi8P96e4e8zOp6ShkY2GAoYdue0hh/6YiLTa4GenHELBBnjjQkbMPEnh6AndG9
	 1R90EBQlKFh8KsY0IjwB3V5AJJYoGpoYqYzWsmVYF37guPMXEtF5B0W/okYFN24Qo5
	 w4Xf/w8Quj4bOiwO9KoB+K63HvQb3PBTwp/4T7B7Ip1+2KeIZiOCU1Kd5gwN9D0fCF
	 7+l2Ewdge9QFQ==
Date: Wed, 17 Jun 2026 12:44:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] perf: Fix up build failure due to bpf changes
Message-ID: <ajLAwJpkG8Lt7daP@x1>
References: <20260617130038.34534-1-broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617130038.34534-1-broonie@kernel.org>

On Wed, Jun 17, 2026 at 02:00:38PM +0100, Mark Brown wrote:
> Fix
> 
> util/btf.c: In function '__btf_type__find_member_by_name':
> util/btf.c:19:43: error: comparison of integer expressions of different signedness: 'int' and '__u32' {aka 'unsigned int'} [-Werror=sign-compare]
>    19 |         for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
>       |                                           ^
> 
> builtin-trace.c: In function 'syscall_arg__strtoul_btf_enum':
> builtin-trace.c:967:27: error: comparison of integer expressions of different signedness: 'int' and '__u32' {aka 'unsigned int'} [-Werror=sign-compare]
>   967 |         for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
>       |                           ^
> 
> by making the variable the same type as the function.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> v2: Fix a second error.
> 
>  tools/perf/builtin-trace.c | 2 +-
>  tools/perf/util/btf.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 48615ddccd93a..4b23b82732e74 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -964,7 +964,7 @@ static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_
>  	struct btf *btf = arg->trace->btf;
>  	struct btf_enum *be = btf_enum(bt);
>  
> -	for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
> +	for (u32 i = 0; i < btf_vlen(bt); ++i, ++be) {
>  		const char *name = btf__name_by_offset(btf, be->name_off);
>  		int max_len = max(size, strlen(name));
>  
> diff --git a/tools/perf/util/btf.c b/tools/perf/util/btf.c
> index bb163fe87767c..50d98f3e83bf0 100644
> --- a/tools/perf/util/btf.c
> +++ b/tools/perf/util/btf.c
> @@ -14,7 +14,7 @@ const struct btf_member *__btf_type__find_member_by_name(struct btf *btf,
>  {
>  	const struct btf_type *t = btf__type_by_id(btf, type_id);
>  	const struct btf_member *m;
> -	int i;
> +	u32 i;
>  
>  	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
>  		const char *current_member_name = btf__name_by_offset(btf, m->name_off);
> -- 
> 2.47.3
> 
> 
