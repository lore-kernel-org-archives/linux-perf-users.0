Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C3188591;
	Fri, 23 Aug 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420547; cv=none; b=jetnRM9VtTu6vKDXnKWvxFm7Z7GbA0xmO2cXfJJzHZmYUMqHohcncAr31Ilnm0d5oV1d+AUXPwJnHxxO0wZgh472rfzAFFGdL3alTAFyrRN72QiF+FFYn/jzI5cJILRKBfl5wYrWUpm4MWaqCoRYOPsUdSQZ1cKAZua7ZxgGRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420547; c=relaxed/simple;
	bh=dCj6bF2nA2GRixqyvPE/0f13PcD/enz+/Phadf1/f3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qse47AkYXrntTkR75m6ctRiiJAmdp6iBEsdlXOlfDQ/DgolRxQF5s8ADyRuG2o0jijNbyBSTQeJldAf9x2+irP76BzOqPPuHpuDpE8FQ0N9TtePn70tfEGGo36SWx45E17gEjBQyDl4GoUQXsmmr1ZHHR32YYDiqctgoiRz8CAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mankESo1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mankESo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8C3C4AF09;
	Fri, 23 Aug 2024 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724420545;
	bh=dCj6bF2nA2GRixqyvPE/0f13PcD/enz+/Phadf1/f3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mankESo1CNmQtgGMz++7Ug3Bm1vjKtGPd2LSLkL4x6PWHB5ZPAVMRThPuTwU2LtDU
	 s5ioHuIOl39Fa8+knwm17ifYkrY09p9+XEyv0/IfdJN7Kg1FFsFm927jcE9CBbTi5h
	 LHraRL7jl1WDx6LmLfvsV3vMDArbjjdXcAeJ5pGqoUXULdmbNJLKEwNSYwBRKFnhtE
	 8PQxHIFwX9oBsvMbOBNThmD8m3ghX1c3dG9z1uIxJH1LcliuSpoZvVq+hel7FtLlBp
	 /TNrPxE/2PF4tm3jwugUF7tjIk5Qy/AfC1Rmu8euSgX883T7Uw26uD6nPoYUHNbqBf
	 zzudNKj3ZC+fg==
Date: Fri, 23 Aug 2024 10:42:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] perf trace: Collect augmented data using BPF
Message-ID: <ZsiRvQiaIK4qN9Vs@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-10-howardchu95@gmail.com>
 <ZsiNef72pSLnQO_c@x1>
 <ZsiQyahfNYCAmbZq@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsiQyahfNYCAmbZq@x1>

On Fri, Aug 23, 2024 at 10:38:21AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 23, 2024 at 10:24:09AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Aug 15, 2024 at 09:36:25AM +0800, Howard Chu wrote:
> > > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > @@ -427,7 +538,8 @@ int sys_enter(struct syscall_enter_args *args)
> > >  	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
> > >  	 * unaugmented tracepoint payload.
> > >  	 */
> > > -	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> > > +	if (augment_sys_enter(args, &augmented_args->args))
> > > +		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> > 
> > We shouldn't do that, instead we keep doing
> > 
> > 	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> > 
> > And userspace will setup the syscalls_sys_enter map adding the generic
> > pointer collector (augment_sys_enter) for syscalls that have pointers
> > _and_ are not serviced by a pre-existing, specialized handler, this way
> > we keep the ones we have already and that already take into account
> > pretty printing network addresses based on the network family, knows how
> > to pretty print flags (the perf_event_open, etc).
> > 
> > I'll try to do this now.
> 
> So, step by step, first this, and then hook it to the syscalls that:
> 
> 1) have a pointer to collect and no handler, i.e. as a last step in
> assigning the functions to be tail called from the syscalls BPF map.
> 

Sorry, sent the wrong patch, this one is the right one:

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index f29a8dfca044649b..4c8176f9a77ca5bb 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -398,7 +398,11 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
-static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
+// Will be tail called for syscalls with pointers, the setup is done
+// in builtin-trace.c as the fallback for syscalls not handled by specialed code,
+// like the network ones that need to look at one field to then decide how to
+// pretty print a network specific address, etc.
+int sys_enter_augmented(struct syscall_enter_args *args)
 {
 	bool augmented, do_output = false;
 	int zero = 0, size, aug_size, index, output = 0,
@@ -480,7 +484,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 	if (!do_output)
 		return 1;
 
-	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
+	return augmented__beauty_output(args, payload, sizeof(struct syscall_enter_args) + output);
 }
 
 SEC("tp/raw_syscalls/sys_enter")
@@ -511,8 +515,7 @@ int sys_enter(struct syscall_enter_args *args)
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
 	 * unaugmented tracepoint payload.
 	 */
-	if (augment_sys_enter(args, &augmented_args->args))
-		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
+	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
 
 	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
 	return 0;
