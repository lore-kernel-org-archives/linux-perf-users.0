Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E0A186E51;
	Fri, 23 Aug 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420301; cv=none; b=GgowFfdr0WT7frHgERDzO1N9lzKAULC4nEU2t+tzMiAOdRA7r4ZAUXUQwjMrchaOmhJQFK+pxZGzYzh2YYqsGk0lxL8HD+x3UDagmUFfKVfFHqs+ZLExSeVRaKf5o0TP03s+cqTVPFxTMXdoMIfp7UVyCYez5l91SnNthMLuwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420301; c=relaxed/simple;
	bh=a/OiFD247/+nojA5CTQ430KoiqEMvylvNIFkd9r7htM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/f1/VpItfXUbqdr57hsr38GkuyfTeKY7aW9GsGn2ErayskAb1vpbJ8elidc6JUxgfI6AvLPSyHtcscijUgxx8vcIofe9/9nldcee3MejqjLu2i5Kq9i3M1VmrsD2wTRpbB3F2TuigbK0evm4CnXbdDUuqcunRCZRpOB00y43mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc22AyWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc22AyWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF03C32786;
	Fri, 23 Aug 2024 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724420301;
	bh=a/OiFD247/+nojA5CTQ430KoiqEMvylvNIFkd9r7htM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dc22AyWHhhGJJJmflDhshA+3lNWhEzG8e1A4eR41o/6top4axGWMel9pL8id9qQI/
	 g+dtQAH1In2B6liZiflFOAG3xykpRcxoyxL+2IQ3sZKXOTERAalk/Vy9RVr1A4HMXn
	 t8pxOC/5a77goMIZ5wVJweCatRFdu0PUY2ryXY/s07k/puB4Rf1xHFTfOi6UnGBXEx
	 KdcM5q+sgQxWN9y0E2J+s0QdLY9jfwPyJtpKcjZQEEwCqzbwk9Niyvj2jl8irX/RNe
	 5exvWIms9TCFfKcTV+5NeydiFEvURuFBpcEIoWBPtR/zeHeRmc01T5BoseyBaIgLdU
	 FQ6YnRSTcMXnA==
Date: Fri, 23 Aug 2024 10:38:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] perf trace: Collect augmented data using BPF
Message-ID: <ZsiQyahfNYCAmbZq@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-10-howardchu95@gmail.com>
 <ZsiNef72pSLnQO_c@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsiNef72pSLnQO_c@x1>

On Fri, Aug 23, 2024 at 10:24:09AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 15, 2024 at 09:36:25AM +0800, Howard Chu wrote:
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -427,7 +538,8 @@ int sys_enter(struct syscall_enter_args *args)
> >  	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
> >  	 * unaugmented tracepoint payload.
> >  	 */
> > -	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> > +	if (augment_sys_enter(args, &augmented_args->args))
> > +		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> 
> We shouldn't do that, instead we keep doing
> 
> 	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> 
> And userspace will setup the syscalls_sys_enter map adding the generic
> pointer collector (augment_sys_enter) for syscalls that have pointers
> _and_ are not serviced by a pre-existing, specialized handler, this way
> we keep the ones we have already and that already take into account
> pretty printing network addresses based on the network family, knows how
> to pretty print flags (the perf_event_open, etc).
> 
> I'll try to do this now.

So, step by step, first this, and then hook it to the syscalls that:

1) have a pointer to collect and no handler, i.e. as a last step in
assigning the functions to be tail called from the syscalls BPF map.

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 37ca96e130a5862d..a909880bd25e51d1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1007,9 +1007,11 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
 	return 0;
 }
 
-static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
+static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg, char *bf,
 				   size_t size, int val, char *type)
 {
+	struct syscall_arg_fmt *arg_fmt = arg->fmt;
+
 	if (trace->btf == NULL)
 		return 0;
 
@@ -1029,7 +1031,7 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *
 }
 
 #else // HAVE_LIBBPF_SUPPORT
-static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg_fmt *arg_fmt __maybe_unused,
+static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg *arg __maybe_unused,
 				   char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
 				   char *type __maybe_unused)
 {
@@ -2284,7 +2286,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-			btf_printed = trace__btf_scnprintf(trace, &sc->arg_fmt[arg.idx], bf + printed,
+			btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 							   size - printed, val, field->type);
 			if (btf_printed) {
 				printed += btf_printed;
@@ -2987,7 +2989,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (trace->show_arg_names)
 			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-		btf_printed = trace__btf_scnprintf(trace, arg, bf + printed, size - printed, val, field->type);
+		btf_printed = trace__btf_scnprintf(trace, &syscall_arg, bf + printed, size - printed, val, field->type);
 		if (btf_printed) {
 			printed += btf_printed;
 			continue;
