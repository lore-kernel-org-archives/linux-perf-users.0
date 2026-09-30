Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1853C3D1A97;
	Wed, 30 Sep 2026 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795687; cv=none; b=WTbXHIQ0uUTnSeTr7ldg5oQFommcxnWn5MQ0E0wnIvB0nejJsvu+4okG9DiGvLiOXelWWTNXDBF6HpS2PGelduJb4XoCXdl1cn6vxJK2H2dANG21k6/LBnTfK5qF90UngWPS5288fTp8fHBHeMfIl02YFxrpiAZNW5jEgPmBrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795687; c=relaxed/simple;
	bh=Bt9C70NQRLI1lLUFR6TJPPnnD3XYBOz5O1BWHzwQ5oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcsVYK6O1PR82JzuWwVY9vw4O3sLtRqPhlyxNymKeNFZFMXNC+7Fx1U5jOEemZAGi4D9wbN2YGBjkOR7j9eqEEd5uzbS3Oqc7t8qdjkW8ASA7z/jVmohSIPsqs8gsiaXM0+4ZHyKWNcFZhLZtqY5tHO6J480fI3GbB7JlN8a3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3HWBzZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3HWBzZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455141F000FF;
	Wed, 30 Sep 2026 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790795685;
	bh=CPkOd7/2MOCd1481qdelnJoCv5niJgOW5Kl95Ne6ScA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a3HWBzZyPlEt6CTsktmAcOb6wb4STm3Ht4Vj8u97bNB49Zw6B9/4uFpvMy1cKa6U+
	 SIgyXYnneHb/PalWG2bjeihPf6CjlLsM+Bws/z5LeWdB5fjJ7PFPcjjsGuA5LvkR3q
	 X7u+L2ZJpdxs/HAG3fE2FN9lhNLbucfH/wBoDAM89amAE9VBMAG4OPzr+3wt/EWjta
	 EIKkmoLcAmMke2fbLkbbWOort64vStKjyaKFQsOhcXrJ4SOKOu7dqqIQ4aiOCgsfqd
	 sibhs+cHeEbTGS7pxmexkCgSfoOslzlKobixxG1ENA+KnNtPVdEgOg+RP0Ne8ttz24
	 slAqlPdqRWXLw==
Date: Wed, 30 Sep 2026 21:14:42 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/26] perf trace: Copy sockaddr arguments by their
 length
Message-ID: <ar1fon_Z4uT3Cd22@x2>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928182605.3649015-7-irogers@google.com>

On Mon, Sep 28, 2026 at 11:25:45AM -0700, Ian Rogers wrote:
> The BTF augmenter copies sizeof(struct sockaddr), 16 bytes, for the
> sockaddr arguments of connect, bind and sendto, and runs before the
> sys_enter_connect and sys_enter_sendto programs that copy their length.
> An IPv6 address needs 24 or 28 bytes, so the rest was read from past the
> payload, and now that the printers are bounded only its family is shown.
> 
> Copy them as buffers sized by the length argument after them, up to the
> 32 bytes augmented buffers are limited to. That holds an IPv6 address
> and doubles the AF_LOCAL path shown.
> 
> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 85db74965280..f94745a60f4a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4159,7 +4159,12 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
>  				continue;
>  
>  			bt = sc->arg_fmt[i].type;
> -			beauty_array[i] = bt->size;
> +			/* Copy a sockaddr as a buffer sized by the next argument, e.g. addrlen. */
> +			if (strcmp(name, "sockaddr") == 0 && field->next &&
> +			    strstr(field->next->name, "len"))
> +				beauty_array[i] = -((i + 1) + 1);
> +			else
> +				beauty_array[i] = bt->size;


Humm, I thought that this would be called in BPF handlers like:

SEC("tp/syscalls/sys_enter_connect")
int sys_enter_connect(struct syscall_enter_args *args)
{
        struct augmented_args_payload *augmented_args = augmented_args_payload();
        const void *sockaddr_arg = (const void *)args->args[1];
        unsigned int socklen = args->args[2];
        unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs

        if (augmented_args == NULL)
                return 1; /* Failure: don't filter */

        _Static_assert(is_power_of_2(sizeof(augmented_args->arg.saddr)), "sizeof(augmented_args->arg.saddr) needs to be a power of two");
        socklen &= sizeof(augmented_args->arg.saddr) - 1;

        bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
        augmented_args->arg.size = socklen;
        augmented_args->arg.err = 0;

        return augmented__output(args, augmented_args, len + socklen);
}

And it knows how many bytes to read by looking at socklen
(args->args[2]), i.e. not use the generic BPF handler that uses this
beauty_array, because knowing how many bytes to read in this case is
dynamic, varies with each syscall, according to one of its arguments :-\

What am I missing?

- Arnaldo


>  			can_augment = true;
>  		} else if (field->flags & TEP_FIELD_IS_POINTER && /* string */
>  			   strcmp(field->type, "const char *") == 0 &&
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
