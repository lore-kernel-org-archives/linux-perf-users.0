Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6A274B37
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778035216; cv=none; b=Eaf08FvUziWvOnaGbdQA8hHEI2BPRFZNgIDGaL6lr+Y+Ze+TD1v0FIQQdb9IUOE8AfV0eiQG6CNU95pvxIe7Iu0pHQuxmgNTMrZijjKWF+iCjRitKu7FthL68gt6HVX7uAXMQCxcwTMITsBiQIssi9G46jHnPeS7qlHyyOMH0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778035216; c=relaxed/simple;
	bh=Dlhh0fAxxol+UV/W61AiDyLWJc6Bea+XLpz8u1JiiZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bhjCKvzkKES3t3xkghVgqExx1EvzlgxOFAxkPrhzvYKKTSK6f+uajhybdNNycrAMGGC/OXTGPyJYbt0E6DvqqzC+hbu5f5V1d29+MpBnJcGCI69QyOMgThOwN+tEZrsHUTnEx3zGrL1m93WOCPs5dn3zaTvP/OPAFurU1zKXfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZMcj1M7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZMcj1M7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6405BC2BCB4;
	Wed,  6 May 2026 02:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778035216;
	bh=Dlhh0fAxxol+UV/W61AiDyLWJc6Bea+XLpz8u1JiiZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EZMcj1M71oCMDTcnD9mBqgxRThDniNH6EJnmwQwDiMU1YPE6AddUUrhFkWZjoqEKw
	 ssWPSYuGd3JQq6fbS1ik4fHaCS0co5S3eg1cI/uFoP9S9GI45BmdhomEcTwg44ya8D
	 w2DsNXqfO04pR56ObyTEsLBKv0ewReadkmrEzi+QVwrqcn295OuRRSozpG6KTR4e4A
	 z8hPQG4KKB1416B29Uo+1kMgR9Wn1T0MvAGCktsOqBnKlOPDfaET8OOJc8XSHetO5b
	 tV+zP2nnkwv4BEgPevjPjew0tU2YZUmsiRRmLFaq6k9eZOMvX/9vgrdFlz55pyR+sQ
	 LpBAHHg72NBZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] perf inject/aslr: Add aslr tool to
 remap/obfuscate virtual addresses
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260506004546.3140141-5-irogers@google.com>
References: <20260506004546.3140141-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 02:40:15 +0000
Message-Id: <20260506024016.6405BC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Cross-VM Isolation Failure in ASLR Remapping
- [Medium] Callchain Parsing Omission for `PERF_CONTEXT_USER_DEFERRED`
- [Low] Fragile Alignment of `event_copy` Buffer
--

commit 1b2fdd3058f351673614b5537a0bdcbb471a964a
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses

This patch adds an aslr option for perf inject that remaps all virtual
addresses to prevent leaking host ASLR information. It uses a struct
machines instance to isolate host mappings from KVM guest address spaces.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..effdcbec0db0d
> --- /dev/null
> +++ b/tools/perf/util/aslr.c

[ ... ]

> +struct remap_addresses_key {
> +	struct dso *dso;
> +	u64 invariant;
> +	pid_t pid;
> +};

Is there a missing machine identifier in this struct? If host processes and
guest processes share the same PID and map anonymous memory at the same
offset, it appears their keys will collide, causing the guest to reuse the
host's remapped address.

[ ... ]

> +struct aslr_tool {
> +	/** @tool: The tool implemented here and a pointer to a delegate to pro=
cess the data. */
> +	struct delegate_tool tool;
> +	/** @machines: The machines with the input, not remapped, virtual addre=
ss layout. */
> +	struct machines machines;
> +	/** @event_copy: Buffer used to create an event to pass to the delegate=
. */
> +	char event_copy[PERF_SAMPLE_MAX_SIZE];

This isn't a bug, but since event_copy is declared as a char array, it only
guarantees a 1-byte alignment. While it currently happens to be 8-byte
aligned because it follows struct machines, could future additions to
struct aslr_tool break this alignment and cause crashes on strict-alignment
architectures when it is cast to union perf_event *?

> +	/** @remap_addresses: mapping from remap_addresses_key to remapped addr=
ess. */
> +	struct hashmap remap_addresses;
> +	/** @top_addresses: mapping from process to max remapped address. */
> +	struct hashmap top_addresses;

Since top_addresses tracks allocations by pid alone, will host and guest
processes with the same PID share the same allocation pool and intertwine
their memory layouts?

[ ... ]

> +static u64 aslr_tool__remap_ksymbol(struct aslr_tool *aslr,
> +				    struct thread *aslr_thread,
> +				    u64 addr, u32 len)
> +{

[ ... ]

> +	hashmap__for_each_entry(&aslr->remap_addresses, cur, bkt) {
> +		k =3D (struct remap_addresses_key *)cur->pkey;
> +		if (k->pid =3D=3D kernel_pid && k->invariant =3D=3D key.invariant) {
> +			v =3D (u64 *)cur->pvalue;
> +
> +			if (al.map)
> +				remap_addr =3D *v + map__pgoff(al.map) +
> +					     (addr - map__start(al.map));
> +			else
> +				remap_addr =3D *v;
> +			addr_location__exit(&al);
> +			return remap_addr;
> +		}
> +	}

Because both host and guest use kernel_pid (-1), will this loop match the
first entry regardless of dso identity and cause guest kernel symbols to
collide with host kernel symbols, leaking host kernel layouts to the guest?

[ ... ]

> +static int aslr_tool__process_sample(const struct perf_tool *tool, union=
 perf_event *event,
> +				struct perf_sample *sample,
> +				struct evsel *evsel, struct machine *machine)
> +{

[ ... ]

> +				case PERF_CONTEXT_GUEST_USER:
> +					cpumode =3D PERF_RECORD_MISC_GUEST_USER;
> +					break;
> +				case PERF_CONTEXT_USER_DEFERRED:
> +					/*
> +					 * Immediately followed by a 64-bit
> +					 * stitching cookie. Skip/Copy it!
> +					 */
> +					CHECK_BOUNDS(1, 1);
> +					out_array[j++] =3D in_array[i++];
> +					cntr++;
> +					break;

Should this case also update cpumode to PERF_RECORD_MISC_USER?

Without it, subsequent user-space addresses will be processed using the
preceding CPU mode (usually kernel). If a user address overlaps with a valid
kernel map, it looks like it could be erroneously remapped as a kernel
address.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506004546.3140=
141-1-irogers@google.com?part=3D4
