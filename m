Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465855;
	b=FjwkdorBnv/kuMJPx0j+t5zwr1Hu1O/gVqYPVZm3vOrk8tHpbg/5R1npkBXNYPVEyMLw
	 jQcE0j0ZiLcCIDt7Q7m5Dv4s4gfGsepX8x53IxU1mcE2gaAFlEX6J54mdu4A4UR/nmMgX
	 Zghd3ZBgmn1drIPV+q01vzb2NVRuH4dzq0CgyHeDZqHG9ASNIbeKzbMg52AOxfvHZ/0vh
	 NZncDI6rd6RyCvLf1zF38j5xdgqghrC1ra0mmfIY+z7xIJd1i0P/WtrzoPmmh6b+nX7XK
	 c9IfvT2ymFRoeX6BsKd2w8llKO1Njn5GYOsf05kgfLzOWC5aJr2wB8DPr3FOb0L7o2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465855;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LF9n98QRNcI8KcKRc0NfOW1JF05UjKGzVQmJu0n7DWY=;
	b=kSWocrNYAJKtBcjdITh2d4SRO2HP4JqT3+sCFuLskpFXb+hJHjBNstGTuTGdkBktVChA
	 IM+iQcCCbfhiP+F714yVOZqlxnhBWGPejlbJTy50dxtD+JrI+/yrgUN8bQuFvsgYOrsAy
	 Cnm7vhZ3NMlvfXU3qVrOMQyNSjBLfmR9eNmTYDfg+XAhc85xRvE1VJ+R+96myfidEM2YA
	 n6ArncVspz0noP7yaINP41TUkHQj9gyPafVZiIteH+KDSnSzsrkbfhSLBle2g4GsmBTG+
	 Q93RTcccYngmMAa9Xq+FHOWXHMpSpO3+pEUnf43Kp8ppWhpzgc2tS+gUyehcMlU2DSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bj60Ge9A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913C606A31C;
	Thu, 12 Nov 2026 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bj60Ge9A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1881F00A05;
	Thu, 12 Nov 2026 06:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794465855;
	bh=LF9n98QRNcI8KcKRc0NfOW1JF05UjKGzVQmJu0n7DWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bj60Ge9AVK+3dwjfAY1gUJrzOEcUB2z1s3qgudnaKaeNT5tzJl7YtFxPtDJNSuHak
	 nuM1F3e+9KpE+q8QKR0U9w8kxH6WkzplTL68tVs4bbrM4KuAbfGObLj6mvHln7yQcf
	 llkcYDcgUL5DDGhYtUITqBHj/tvGX6dyOVKgXYYlATt0eZL17r/QeUmIVC9ZJcedVM
	 aQgUDPzQzCyAeZ3DdLaJEdbmxq1xNhbjkugk0XT+gu8BvsD0P3Zg382FM8RS3GgSK8
	 8zkWrvxaYfixSIKUXomXjE1rHbEN7U3vBwTRk3gXG2ozHJTmUYfo+Mt/14qt9IViYj
	 BsJcNJcSs56qg==
Date: Wed, 11 Nov 2026 22:44:13 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org,
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	mingo@redhat.com, morbo@google.com, nathan@kernel.org,
	ndesaulniers@google.com, peterz@infradead.org
Subject: Re: [PATCH v12 08/20] perf dsos: Skip BPF and OOL DSOs in
 dsos__find_kernel_dso()
Message-ID: <avVgPUFGCPycCWSI@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-9-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111174213.3526604-9-irogers@google.com>

On Wed, Nov 11, 2026 at 09:42:00AM -0800, Ian Rogers wrote:
> In machine__process_ksymbol_register(), set the binary type of non-OOL
> ksymbol DSOs to DSO_BINARY_TYPE__BPF_IMAGE (which
> machine__process_bpf_event_load() upgrades to
> DSO_BINARY_TYPE__BPF_PROG_INFO on PERF_BPF_EVENT_PROG_LOAD), and update
> dsos__find_kernel_dso_cb() to skip DSO_BINARY_TYPE__BPF_PROG_INFO,
> DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
> dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/dsos.c    | 3 +++
>  tools/perf/util/machine.c | 9 ++++-----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 1574c8885d78..fbbf98c4ccae 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -475,6 +475,9 @@ static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
>  	 * is_kernel_module() treats it as a kernel cpumode.
>  	 */
>  	if (!dso__kernel(dso) ||
> +	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO ||
> +	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE ||
> +	    dso__binary_type(dso) == DSO_BINARY_TYPE__OOL ||
>  	    is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN))
>  		return 0;
>  
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 5eb5efa4eb90..0334cb01349a 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -769,6 +769,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  			dso__set_binary_type(dso, DSO_BINARY_TYPE__OOL);
>  			dso__data(dso)->file_size = event->ksymbol.len;
>  			dso__set_loaded(dso);
> +		} else {
> +			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);

Shouldn't this move into the if statement below?  At least it should
check if the ksym_type is BPF.

Thanks,
Namhyung


> +			if (is_bpf_image(event->ksymbol.name))
> +				dso__set_long_name(dso, "", false);
>  		}
>  
>  		map__set_start(map, event->ksymbol.addr);
> @@ -780,11 +784,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  		}
>  
>  		dso__set_loaded(dso);
> -
> -		if (is_bpf_image(event->ksymbol.name)) {
> -			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
> -			dso__set_long_name(dso, "", false);
> -		}
>  	} else {
>  		dso = dso__get(map__dso(map));
>  	}
> -- 
> 2.56.0.542.g3ef89b7020-goog
> 
