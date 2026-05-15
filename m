Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F13B531A
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778813774; cv=none; b=WqjTkM8mpIofkUQq2pM3vsUPHx++HFHFxtOCDwYWjdoK9YF3lFkyYSUBTH+Km2jaHOehBm4qMRounnafSAymwhBX6DEYntO8brWZdbnSGSEd33bBBtmGYktdok9TCvPGg/Hr7QsPgDbeZjY5tw0Ss1xypxEbjByUAb0S2HuNSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778813774; c=relaxed/simple;
	bh=e61X65j8+zhxTEL9i7ZI9xs8PZ8xolUNK80iv/ytM8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hK4Eew41xaTZRJkLsFm3rKiorSMZx8dkTxIAADf3iZS7EJH9FbrzyO4NTkblioq7gx8Wbj/NuyGGOP298V20qpJulsgJ36yWBwnWbXCr7jZwFKgduSgfp9g2VGJjPcuNaQYHNy1u5hLhOuVAQuUjzwUwr5S81gFLDinCGjAJGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXLqsrqd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXLqsrqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0656C2BCB3;
	Fri, 15 May 2026 02:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778813773;
	bh=e61X65j8+zhxTEL9i7ZI9xs8PZ8xolUNK80iv/ytM8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sXLqsrqd+goA3w2EbLOXEWStMkmLITHEUF8IGwMtHDLRnLN/ZP6bzWzgmquUydnp/
	 9t53D3E5arzQMnYrKkzvxx1dOJsQIemkpcof5wx+AHbK1GmzIF4xgqS2fX9cmfgral
	 1TfL3WBWVZ6wn370y3aImid0rBVAggaMcV4891MatDSrqjaLWoSRKoCqo6d5XHhlp1
	 nns2KqxUNGYWMySnSjB4zoEpnnbJXaNT2EGUmlTkkX2Op06ulBJfc/hAtHw01Ma0j+
	 SnZBVCcHTR7p42YKJfWoOX/E78su6t3LUAsXscnkmAvDgoCassfqYO2+QH5tMnz4MR
	 y2xhTBI+9ci/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 29/32] perf timechart: Bounds check CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512223001.2952848-30-irogers@google.com>
References: <20260512223001.2952848-30-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 02:56:07 +0000
Message-Id: <20260515025612.E0656C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Information leak via out-of-bounds read in topology_map during SVG=
 generation.
- [Medium] Silent abort of trace processing on malformed events due to retu=
rning -1.
--

commit 57170a57885573f1b4010e365798000c26749777
Author: Ian Rogers <irogers@google.com>

perf timechart: Bounds check CPU

This commit adds bounds checking for CPU IDs across various sample
processing callbacks to prevent out-of-bounds accesses in arrays tracking
CPU state. If a CPU ID exceeds MAX_CPUS, the callbacks now log a debug
message and return -1.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 64f69bd67c6b7..64903b54e8a73 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -607,6 +607,10 @@ process_sample_cpu_idle(struct timechart *tchart __m=
aybe_unused,
>  	u32 state  =3D perf_sample__intval(sample, "state");
>  	u32 cpu_id =3D perf_sample__intval(sample, "cpu_id");
> =20
> +	if (cpu_id >=3D MAX_CPUS) {
> +		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
> +		return -1;

Will returning -1 here abort the entire trace processing loop?=20

In the perf session infrastructure, returning a negative value from a
sample callback propagates up and causes perf_session__process_events()
to immediately exit. Since pr_debug() messages are hidden by default, this
could result in a silent, unexplained failure for the user.

Would it be better to return 0 to skip the malformed sample, or use
pr_err() to make the abort reason visible?

> +	}
>  	if (state =3D=3D (u32)PWR_EVENT_EXIT)

[ ... ]

> @@ -1517,6 +1544,8 @@ static int process_header(struct perf_file_section =
*section __maybe_unused,
>  	switch (feat) {
>  	case HEADER_NRCPUS:
>  		tchart->numcpus =3D ph->env.nr_cpus_avail;
> +		if (tchart->numcpus > MAX_CPUS)
> +			tchart->numcpus =3D MAX_CPUS;
>  		break;
> =20
>  	case HEADER_CPU_TOPOLOGY:

Does this leave the topology_map array vulnerable to out-of-bounds heap
reads during SVG generation?

The bounds checks added in the sample callbacks restrict the cpu_id to
MAX_CPUS (4096), which protects statically sized arrays. However, it looks
like the topology_map array is dynamically allocated in
svg_build_topology_map() based on env->nr_cpus_online.

If a perf.data file specifies a small nr_cpus_online but contains trace
events with CPU IDs that are larger than nr_cpus_online but smaller than
MAX_CPUS, these events will bypass the MAX_CPUS check. Later, when
functions like svg_cstate() or svg_cpu_box() call cpu2y(cpu), it seems
they could index out of bounds into topology_map[cpu]. This might scale a
garbage value and embed it into the output SVG, potentially leaking heap
memory.

Should there be an additional check to ensure the cpu_id does not exceed
env->nr_cpus_online or the allocated bounds of topology_map?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512223001.2952=
848-1-irogers@google.com?part=3D29
