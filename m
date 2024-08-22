Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4971C9ECE;
	Thu, 22 Aug 2024 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360982; cv=none; b=GDjpcL090jLVy1ZfXJ0BoKyPO2mgxEQhoOurSlsD8MTqGli+8XIc6gsoVQOgK93q4CFTYYOqw/+OUfdLa8VgkXQkK9WLSXkE1Hz4di2Ft3b2cnZjxuEV06E+t36AYjYId73xjBqadP0aNbsgEv4R/fDR3ffHDMOfFlIKgtmH9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360982; c=relaxed/simple;
	bh=8iBDpoxfMgDUeOxD63UGaKxo3EyWxDxolFmv468LCfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5Gz/zaaxTfmQhjMcHDikUZXTjxPToZXJiNiW/fyTltCPBROf+F7IIUPPTbbEKGaSabtL2/aZNhAteXvv5/fzvHDIOnC67liA5IBC0LqYA3/gqGeH02+OAJhQysJY9VtrDnFITdndpubR+3mxQliIVWDaLybe6Gnqu+FFGDzDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1wVX/nH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1wVX/nH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1088BC32782;
	Thu, 22 Aug 2024 21:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724360981;
	bh=8iBDpoxfMgDUeOxD63UGaKxo3EyWxDxolFmv468LCfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1wVX/nHs2zAdvWu+r9zFRP/apRq/b/+ryhzSm1No8U7QdXqE7tGoggTrjvSyu8DO
	 ei0o7FtzqdyX41lNzOQa2TeoyyfLJ/dbNFwtATXggZNQfqCQiSoETkJ4XcppK7Q6Pw
	 4FBLdqn4f00J4jEJ9Ee6CIty+oWwT9lLxvMJGug5LWn0PGKSYx/4xkiYUmMoF3aXKr
	 Pg32345iyScXOHkgSYFjuwUIAKBgIOl4SD5Fbbo7WRxy46uTLX6mB0DBWNPZ9w6CaI
	 Rz1nZDWMN+kyDx/PS1Fsr7q1JbrtnU+8ClZ+cej6Ib2w8i+/Q6e9KWaVgWHQ6kVTZb
	 xBb4zDHZ2kvMw==
Date: Thu, 22 Aug 2024 18:09:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] perf trace: Add
 trace__bpf_sys_enter_beauty_map() to prepare for fetching data in BPF
Message-ID: <ZsepEpr-hGXkI8Vw@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-4-howardchu95@gmail.com>
 <Zsd6MgrCs0ybQ9EW@x1>
 <Zsd7Ep6H24Qq-h5F@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zsd7Ep6H24Qq-h5F@x1>

On Thu, Aug 22, 2024 at 02:53:22PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 22, 2024 at 02:49:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Aug 15, 2024 at 09:36:19AM +0800, Howard Chu wrote:
> > > @@ -3624,7 +3719,9 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
> > >  {
> > >  	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
> > >  	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
> > > +	int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
>  
> > At this point we still don't have that, right? I.e. building with this
> > patch, without the ones following it in your series, I get:
>  
> > builtin-trace.c: In function ‘trace__init_syscalls_bpf_prog_array_maps’:
> > builtin-trace.c:3723:58: error: ‘struct <anonymous>’ has no member named ‘beauty_map_enter’
> >  3723 |         int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
> >       |                                                          ^
> >   CC      /tmp/build/perf-tools-next/tests/code-reading.o
> >   CC      /tmp/build/perf-tools-next/trace/beauty/clone.o
> > make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/build/perf-tools-next/builtin-trace.o] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > 
> > So we need to squash the patch that introduces beauty_map_enter in the
> > augmented_raw_syscalls.bpf.c file to this one, so that we keep things
> > bisectable, I'll try to do that.
> 
> So just this did the trick, I'll remove it from the later patch in your
> series:

But then you added syscall_arg_fmt__cache_btf_struct() ifdef'ed by
HAVE_LIBBPF_SUPPORT to then use it on trace__bpf_sys_enter_beauty_map())
that is ifdef'ed by HAVE_BPF_SKEL, so when building with
BUILD_BPF_SKEL=0 we get this splat:

  CC      /tmp/build/perf-tools-next/builtin-trace.o
  AR      /tmp/build/perf-tools-next/libperf-util.a
builtin-trace.c:930:12: error: ‘syscall_arg_fmt__cache_btf_struct’ defined but not used [-Werror=unused-function]
  930 | static int syscall_arg_fmt__cache_btf_struct(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  GEN     /tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-linux-gnu.so
cc1: all warnings being treated as errors
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/build/perf-tools-next/builtin-trace.o] Error 1
make[2]: *** [Makefile.perf:762: /tmp/build/perf-tools-next/perf-in.o] Error 2
make[1]: *** [Makefile.perf:292: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢[acme@toolbox perf-tools-next]$

I'm moving syscall_arg_fmt__cache_btf_struct() to the same block where
trace__bpf_sys_enter_beauty_map() is.
 
> - Arnaldo
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 0acbd74e8c760956..c885673f416dff39 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -79,6 +79,13 @@ struct pids_filtered {
>  	__uint(max_entries, 64);
>  } pids_filtered SEC(".maps");
>  
> +struct beauty_map_enter {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, int);
> +	__type(value, __u32[6]);
> +	__uint(max_entries, 512);
> +} beauty_map_enter SEC(".maps");
> +
>  /*
>   * Desired design of maximum size and alignment (see RFC2553)
>   */
