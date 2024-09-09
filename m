Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB5B641;
	Mon,  9 Sep 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893207; cv=none; b=igTj/ZWhp9062AxLQsacZTQ9Kh+XSFpvgsJeehSuzNoP54lUxnA9dxkdfGJUGEsYzw8xW9Prx67tNlSCriobBYHNfqvyBD6GLyadujSw29NLGnaXmHE1yNHXH3nKzq9jIpbpbOLH2EBbK90PSFvNqtpj44YplUig7NmQ/PeCt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893207; c=relaxed/simple;
	bh=vt3/zY+w/72VdyeZwvCfYhiseVM9iQz7GprY+4GWGvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfeZRKAWadch1H8KBljrEfZVjbt3hSxa3RD2lzbJrROI6BAmcUIcleBBw2khWLseGcqB74zdcKSfML1RJjSf8tF62hGj0DG1Wmq4gKdonX0a06asN16VUAeKnfCUC/Be/0v/ZQiR1rMzM/Kpz/N2kMThfyJwLVoJoXQZuTX4ROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2IBQ5/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2IBQ5/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC56C4CEC5;
	Mon,  9 Sep 2024 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725893207;
	bh=vt3/zY+w/72VdyeZwvCfYhiseVM9iQz7GprY+4GWGvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2IBQ5/ux8mxZwfdjtNpFztXnypYdhXtistleS08KXrlJRAKSMBGjHbFHX+ib0V9f
	 65Mv+AdVXjg5B3ipucjBXaAeXRwxI33Z8piFd/KBK0NEHFAqSAUPyn+ME6LxFUi/zL
	 oU231jTNCdn1ZgZLuQTucNXQjS8h2xcW9MixroNfohjKU1kX9uMdw+/qUye8uxHs7p
	 Gjs6AXjXzKPeNyQKUoaZuLhggAjo/04R82dGB0oZSUo2pR04akXN1LgHavyqntue7J
	 EG5yCVWtaRrL3f0FwBSS4SJha7nOr/cwmVMCirnNsd40Uegp/5dOjZ9rbLSXoyhmIu
	 RCyCWiodmA2Wg==
Date: Mon, 9 Sep 2024 11:46:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 4/8] perf trace: Pretty print struct data
Message-ID: <Zt8KVFmh0JXD_VhX@x1>
References: <20240824163322.60796-1-howardchu95@gmail.com>
 <20240824163322.60796-5-howardchu95@gmail.com>
 <Zs-Q-ZyZKd_NzsIv@x1>
 <CAH0uvoge5QUsioZ-j8OS+VoxJAXuP9CyXOJbBkJPwUXWhEryMg@mail.gmail.com>
 <Zt8IypiWo0OuK5cR@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zt8IypiWo0OuK5cR@x1>

On Mon, Sep 09, 2024 at 11:40:14AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 30, 2024 at 08:16:38AM +0800, Howard Chu wrote:
> > On Thu, Aug 29, 2024 at 5:05 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > I.e. isn't this a change in the protocol of the BPF colector with the
> > > userpace augmented snprintf routines?

> > > If I remember we discussed that first you make this change in the
> > > protocol, test it with the pre-existing BPF collector, it works. Ok, now
> > > we have a new protocol and we then use it in the generic BTF-based BPF
> > > collector. This way that option of using the BTF-based collector or the
> > > preexisting BPF collector works.

> > > I'll try to do this.

> > Thank you so much.

> Now that I have:

> 6b22c2b502a1c21b (x1/perf-tools-next, perf-tools-next/tmp.perf-tools-next, acme/tmp.perf-tools-next) perf trace: Use a common encoding for augmented arguments, with size + error + payload
> 5d9cd24924f57066 perf trace augmented_syscalls.bpf: Move the renameat aumenter to renameat2, temporarily

> And also:

> 7bedcbaefdf5d4f7 perf trace: Pass the richer 'struct syscall_arg' pointer to trace__btf_scnprintf()
> 8df1d8c6cbd6825b perf trace: Fix perf trace -p <PID>

> I can move to this patch, but then it doesn't build as it uses things
> that will only be available when we get to adding the new BPF components
> in a later patch:
> 
> builtin-trace.c: In function ‘trace__init_syscalls_bpf_prog_array_maps’:
> builtin-trace.c:3725:58: error: ‘struct <anonymous>’ has no member named ‘beauty_map_enter’
>  3725 |         int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
>       |                                                          ^
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/build/perf-tools-next/builtin-trace.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> 
> It will only come when we add:
> 
> Subject: [PATCH v3 6/8] perf trace: Collect augmented data using BPF
> 
> Where we have:
> 
> +struct beauty_map_enter {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, int);
> +	__type(value, __u32[6]);
> +	__uint(max_entries, 512);
> +} beauty_map_enter SEC(".maps");
> 
> 
> So I'll try to combine the addition of the map with the code that uses
> it in the builtin-trace.c codebase.
> 

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 9c7d2f8552945695..4ebce67637435192 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -124,6 +124,13 @@ struct augmented_args_tmp {
 	__uint(max_entries, 1);
 } augmented_args_tmp SEC(".maps");
 
+struct beauty_map_enter {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, __u32[6]);
+	__uint(max_entries, 512);
+} beauty_map_enter SEC(".maps");
+
 static inline struct augmented_args_payload *augmented_args_payload(void)
 {
 	int key = 0;
This did the trick:
