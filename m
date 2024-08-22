Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E843165;
	Thu, 22 Aug 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349633; cv=none; b=GzajsWZyIy7Px2a4N0iEnI+Kj0yGFbrDTqQd3WsbvWXEPBFreG6GIm0/bn+IjvLOLzqZ1dO5OTMnhv7vGrd55qWIRGHbHhZrpxISEfxX1OdOXZr11Fn7bkvYvxgVc52oLacxzwedFQYCyG5fmxXe8bYjEdflAzH38cuQGKmU/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349633; c=relaxed/simple;
	bh=2LRLD1VjSGIIrLODHUeaVY/X8DApvobgeDY3JxiBQlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiIDVdSdhRlfb5i7ntIZoe2yHYlNWPzFeFdcsTfYekOBJRpsW8JIZlB97CQMTvpic0ZN8BOvbW7IAjVnB/26NZD8XJ0T7CRT1y4itz0j0weTTptsPO6BQCRUm0foV+JKEPGvm+qUh7XsEqMKkGRC/TIaDgmn1aiXpWm1RXvGGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRO3bAHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRO3bAHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE01C32782;
	Thu, 22 Aug 2024 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724349633;
	bh=2LRLD1VjSGIIrLODHUeaVY/X8DApvobgeDY3JxiBQlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRO3bAHntOBIvbWQaygBaR3HROUyfNRIlQwn663Zng4discspRFQMloXl4ylAZ74d
	 VpNOnYbuya/7dzObK13TuexCoTuiFY5ZVsZ8nEfQq6qWk3d+59BK3n5HqU5zGFPw+3
	 KVwhuN5GZ5rwfJfh1C4K8afIKm8qi/VIrmcXChuD0mSHR6XONyL0VZfow6i9yd01aB
	 dHaEF0a78vS6MrGFugQ906i/G6QwpItrSrKTcseSkpLckqYx7T39vjzmBLpfeP+cA3
	 9Ax2Duuz61pkYfhzxr2vshkNBrMkBiMhhQKL3qmWTX5N8w5R2jUjSaJ35TtB7W8e+I
	 7gjTr/7nsuWkg==
Date: Thu, 22 Aug 2024 15:00:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] perf trace: Add a new argument to
 trace__btf_scnprintf()
Message-ID: <Zsd8vqCrTh5h69rp@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-6-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815013626.935097-6-howardchu95@gmail.com>

On Thu, Aug 15, 2024 at 09:36:21AM +0800, Howard Chu wrote:
> Pass the struct syscall_arg, so that we can use the augmented_arg later
> in the struct augmentation.

Breaks the build with:

builtin-trace.c: In function ‘trace__btf_scnprintf’:
builtin-trace.c:1011:78: error: unused parameter ‘arg’ [-Werror=unused-parameter]
 1011 |                                    size_t size, int val, struct syscall_arg *arg, char *type)
      |                                                          ~~~~~~~~~~~~~~~~~~~~^~~
  LD      /tmp/build/perf-tools-next/util/perf-util-in.o
  LD      /tmp/build/perf-tools-next/perf-util-in.o
  AR      /tmp/build/perf-tools-next/libperf-util.a
  GEN     /tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-linux-gnu.so
cc1: all warnings being treated as errors

So we either use __maybe_unused at this point or combine it with the
patch where it really gets used. I think the later is better, will do.

- Arnaldo
 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 84c7398312d8..4bde40f91531 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1007,7 +1007,7 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
>  }
>  
>  static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
> -				   size_t size, int val, char *type)
> +				   size_t size, int val, struct syscall_arg *arg, char *type)
>  {
>  	if (trace->btf == NULL)
>  		return 0;
> @@ -1030,7 +1030,7 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *
>  #else // HAVE_LIBBPF_SUPPORT
>  static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg_fmt *arg_fmt __maybe_unused,
>  				   char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
> -				   char *type __maybe_unused)
> +				   struct syscall_arg *arg __maybe_unused, char *type __maybe_unused)
>  {
>  	return 0;
>  }
> @@ -2284,7 +2284,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
>  
>  			btf_printed = trace__btf_scnprintf(trace, &sc->arg_fmt[arg.idx], bf + printed,
> -							   size - printed, val, field->type);
> +							   size - printed, val, &arg, field->type);
>  			if (btf_printed) {
>  				printed += btf_printed;
>  				continue;
> @@ -2986,7 +2986,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>  		if (trace->show_arg_names)
>  			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
>  
> -		btf_printed = trace__btf_scnprintf(trace, arg, bf + printed, size - printed, val, field->type);
> +		btf_printed = trace__btf_scnprintf(trace, arg, bf + printed, size - printed, val, NULL, field->type);
>  		if (btf_printed) {
>  			printed += btf_printed;
>  			continue;
> -- 
> 2.45.2
