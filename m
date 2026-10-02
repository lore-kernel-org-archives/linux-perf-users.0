Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122A4E3259;
	Fri,  2 Oct 2026 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957842; cv=none; b=mFPAFBxt9Wkb+wz1CaSPrj/j6Jru47BMORPtXB62J48P5XBgs7sfm6xWunzsDptNvizzLUfwLPau1sa3sxxZhhaZ0bLGb81CAUz0NVb6Fv/mDJkE1U5umO6OLXGq+c9RgaYRnmn+QlnoxK9o2hpnqbun4vFjsY3lqqaepOUcNwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957842; c=relaxed/simple;
	bh=7KZCFvKm+b+K+u6GwHqW+UpEcbSm4wGhlvkIvWsYoQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4mtJpIjgh+T8Do14dgfrO59UIj1OYuq+UPcl+RwsAopqcS8qN8Y1zloE/KA1JKYgR9mP6tGw7cWkNFf4c37KMTUl1NZtIiJvzdAEhY3vLCa0Ka4BCGyWhpoqNNM9BzaQBlvVcLGM9rohccJwvp/luHt4cpdoM3pGTXlRlYvUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sowa075W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sowa075W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A3A1F00893;
	Fri,  2 Oct 2026 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790957840;
	bh=NpzoYDSIrYMJBSmUGDfAe3nxtL+kqV99j9xz34JxBI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sowa075WaK/403zLdKGJIdu6BkJHte5GM84lUjV6vBSBG/6jtX26KXOhfIkfQYVgY
	 Lyk0oi7AQ+e5u4GXQH4zzOfkeTd6BIEE5FtO9nWCHY6N/iTb+ahUELDtECWRmK5Ciw
	 vsvDrt/bWKD0rH51e29h3PgdDQuT0UHXjKBEWE1T17irrKrSJe6dZPBsFSkHIM4Ll3
	 XaPNWeyuLw+tCooxP/4NTiX5tcNGPLj7KkCPM8wh8nv4eSkF1C4LyYCGk6dyh5kTMD
	 uZrmq6AxQI+dTmK+lAE8K5KllbhPb/Z31eaHhIEYlWS2aVIEBedQAg4wPBos/qPf2Q
	 N67k8Lk6lp4dA==
Date: Fri, 2 Oct 2026 18:17:16 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, atomlin@atomlin.com, howardchu95@gmail.com,
	james.clark@linaro.org, jbrnak@redhat.com, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 2/2] perf trace: Increase TRACE_AUG_MAX_BUF to 128 and
 document beauty_map encoding
Message-ID: <ar_ZDG16S_lyZ8Ol@x2>
References: <ar6nzTSj17IxCy0j@x2>
 <20261002065440.2781176-1-irogers@google.com>
 <20261002065440.2781176-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002065440.2781176-2-irogers@google.com>

On Thu, Oct 01, 2026 at 11:54:40PM -0700, Ian Rogers wrote:
> With sockaddr arguments copied as buffers via beauty_map_enter, the
> 32-byte TRACE_AUG_MAX_BUF limit only held 2 bytes of sa_family plus 30
> bytes of AF_LOCAL sun_path, truncating longer socket paths such as
> "/var/run/.heim_org.h5l.kcm-socket".
> 
> Since struct augmented_arg already reserves PATH_MAX (4096) bytes,
> increase TRACE_AUG_MAX_BUF to 128 (SS_MAXSIZE, the size of struct
> sockaddr_storage), which covers all 110 bytes of struct sockaddr_un
> without changing map sizes. Also document the 1-based negative
> -(arg_idx + 1) encoding used in beauty_array for paired length
> arguments.
> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks, tested and applied.

- Arnaldo

> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c                            | 8 +++++++-
>  tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 8 ++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c34c9f129836..4094141461f9 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4174,7 +4174,12 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
>  				continue;
>  
>  			bt = sc->arg_fmt[i].type;
> -			/* Copy a sockaddr as a buffer sized by the next argument, e.g. addrlen. */
> +			/*
> +			 * Copy a sockaddr as a buffer sized by the next
> +			 * argument (i + 1), e.g. addrlen. A negative entry
> +			 * -(j + 1) encodes the 0-based length argument index j
> +			 * as 1-based so arg 0 is -1 rather than 0.
> +			 */
>  			if (strcmp(name, "sockaddr") == 0 && field->next &&
>  			    strstr(field->next->name, "len"))
>  				beauty_array[i] = -((i + 1) + 1);
> @@ -4210,6 +4215,7 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
>  				     strstr(field_tmp->name, "siz") ||  /* size, bufsiz */
>  				     (strstr(field_tmp->name, "len") && strcmp(field_tmp->name, "filename")))) {
>  					 /* filename's got 'len' in it, we don't want that */
> +					/* 1-based negative index of length arg j. */
>  					beauty_array[i] = -(j + 1);
>  					can_augment = true;
>  					break;
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 0b2ef9541f84..28ebb9a72776 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -28,7 +28,7 @@
>  
>  #define MAX_CPUS  4096
>  
> -#define TRACE_AUG_MAX_BUF 32 /* for buffer augmentation in perf trace */
> +#define TRACE_AUG_MAX_BUF 128 /* for buffer augmentation in perf trace */
>  
>  /* bpf-output associated map */
>  struct __augmented_syscalls__ {
> @@ -514,9 +514,9 @@ u64 ZERO = 0;
>   * value in the beauty_map. This is the relation of parameter type and its corresponding
>   * value in the beauty map, and how many bytes we read eventually:
>   *
> - * string: 1			      -> size of string
> - * struct: size of struct	      -> size of struct
> - * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
> + * string: 1			          -> size of string
> + * struct: size of struct	          -> size of struct
> + * buffer: -(0-based index of paired len + 1) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>   */
>  static inline int augment_arg(struct syscall_enter_args *args, int i,
>  			      unsigned int *beauty_map,
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
