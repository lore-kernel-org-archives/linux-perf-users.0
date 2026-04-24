Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89A3009CB
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070192; cv=none; b=JeNuGj9eOcHiqDEGiWeLsmLdrRn5XU87q9ykokH0/kTMgnzkS+PpL23eRLdMEGD2FNe3njsq3/huAOf3OXAGWdbrmJnLb1qe3DoCk7Yxfmbcy4k7UfMdeOIhSahR235dS+k9RDB7cBgqL5V/ihMENWTlFo43qCSQsbmCZokTQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070192; c=relaxed/simple;
	bh=L9oPiIgYYpKwCBZuF/oXpPUaFb6uJeQ3JfmgyhADMks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=quBRE+baXv1HMb8wGKkpBV+TfdKkluxfsHJ22/a2fvtcBaDvU2p9pWh/uV4X6nI30nseaL2uSA4yU21IMZUWhnOccZKJ63DZTgLgUAjIfx7u4tZkaWhopz2ellASiL6s8SRojXeG3S3ogipkQJd7GwkLEs65109/RZl9gTTkIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbgz0aT2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbgz0aT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDD1C19425;
	Fri, 24 Apr 2026 22:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777070191;
	bh=L9oPiIgYYpKwCBZuF/oXpPUaFb6uJeQ3JfmgyhADMks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Jbgz0aT2TfSpguo4aGrUvl7F5SfAhtzH3SiJpD/3nCvC3bJyx/0zurJSVlNbldn2i
	 tjEjFUl8N6xJeXLiVdj8MpT2dQwL2QVKFW0F1uvKR/b8pUgF1ubT0RCUZvk+mT0Axt
	 6wDFtIYBq2KP/ujvMcNQSErjVGP7/Ec2yNdjQkkTIVaJ7467pyut83QVQajctCoZjt
	 bfHEiL4w78cPI+pR3WbjjZpxhYNPDORNe/sJrPCdklUgNS+PG4vswVeLFarQ566j+2
	 EENJUKgYYwPZdM4EYKhXFoFF5+kkf8gyhZIqwq34e0+qMk4HZyGPUp+Mc8Z1WCKfa3
	 3ZtXIUq6AKisQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf inject/aslr: Add aslr tool to
 remap/obfuscate virtual addresses
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424220519.2743472-1-irogers@google.com>
References: <20260424220519.2743472-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 22:36:31 +0000
Message-Id: <20260424223631.BEDD1C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 8 potential issue(s):
- [High] Missing `thread__put()` causes severe memory leak of thread object=
s per event.
- [High] Incorrect bitmask check for branch stack flags causes catastrophic=
 sample parsing failure.
- [High] Incorrect size calculation for `PERF_SAMPLE_RAW` causes parsing de=
synchronization and uninitialized memory leak.
- [High] Off-by-one error in `copy_u64()` bounds checking allows out-of-bou=
nds memory reads.
- [High] Unconditional zeroing of union fields in `perf_event_attr` corrupt=
s PMU configurations.
- [High] `hashmap` usage causes 32-bit compilation failures and silent 64-b=
it address truncation.
- [Medium] Unhandled guest callchain contexts cause valid samples to be dis=
carded.
- [Medium] Missing integer overflow checks on `branch_stack->nr` allow boun=
ds-check bypass.
--

commit cb2629f8e0c5449ea2cd944df7889ca64868a5eb
Author: Ian Rogers <irogers@google.com>
Subject: perf inject/aslr: Add aslr tool to remap/obfuscate virtual address=
es

This commit introduces an ASLR tool to perf inject. It allows remapping
virtual memory addresses to prevent leaking ASLR information when sharing
perf.data files. Unhandled events are dropped to remain conservative.

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
--- /dev/null
+++ b/tools/perf/util/aslr.c
[ ... ]
> +static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
> +				    struct thread *aslr_thread,
> +				    u8 cpumode,
> +				    u64 addr)
> +{
[ ... ]
> +	if (!hashmap__find(&aslr->remap_addresses, &key, &remap_addr)) {

Will storing and retrieving 64-bit addresses in this hashmap cause truncati=
on
or build failures on 32-bit architectures?

The underlying hashmap API stores long values. On 32-bit systems, long is 32
bits wide, which might truncate the upper 32 bits of the remapped address
during hashmap__add.

Additionally, passing a u64 pointer to hashmap__find triggers
hashmap_cast_ptr(), which contains a static assertion that the value size
equals sizeof(long). Might this result in a build failure when compiling on
32-bit platforms?

[ ... ]
> +static int aslr_tool__process_mmap(const struct perf_tool *tool,
> +				union perf_event *event,
> +				struct perf_sample *sample,
> +				struct machine *machine)
> +{
[ ... ]
> +	thread =3D machine__findnew_thread(&aslr->machine, event->mmap.pid, eve=
nt->mmap.tid);
> +	memcpy(&new_event->mmap, &event->mmap, event->mmap.header.size);
> +	/* Remaps the mmap.start. */
> +	new_event->mmap.start =3D aslr_tool__remap_mapping(aslr, thread, cpumod=
e,
> +							   event->mmap.start, event->mmap.len);
[ ... ]
> +	return delegate->mmap(delegate, new_event, sample, machine);
> +}

Since machine__findnew_thread() increments the reference count of the
returned thread, could returning from this function without calling
thread__put() leak the thread reference for every processed event?

This pattern appears to be repeated in aslr_tool__process_mmap2,
aslr_tool__process_ksymbol, aslr_tool__process_text_poke, and
aslr_tool__process_sample.

[ ... ]
> +static inline int copy_u64(__u64 *in_array, __u64 *out_array,
> +			   size_t *i, size_t *j, const __u64 max_i)
> +{
> +	if (*i > max_i)
> +		return -EFAULT;
> +	out_array[(*j)++] =3D in_array[(*i)++];
> +	return 0;
> +}

Does this bounds check allow reading past the end of the input event buffer?

The max_i value is calculated as event->header.size / sizeof(__u64).
Since in_array points to event->sample.array[0], which starts after the
8-byte perf_event_header, the array contains max_i - 1 elements.

Should the check be if (*i >=3D max_i - 1) instead?

[ ... ]
> +static int aslr_tool__process_sample(const struct perf_tool *tool, union=
 perf_event *event,
> +				struct perf_sample *sample,
> +				struct evsel *evsel, struct machine *machine)
> +{
[ ... ]
> +	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> +		if (copy_u64(in_array, out_array, &i, &j, max_i))
> +			return -EFAULT; // nr
> +
> +		for (u64 cntr =3D 0; cntr < sample->callchain->nr; cntr++) {
> +			if (i > max_i)
> +				return -EFAULT;
> +			i++;
> +			addr =3D sample->callchain->ips[cntr];
> +			if (addr >=3D PERF_CONTEXT_MAX) {
> +				// Copy context values as is.
> +				out_array[j++] =3D addr;
> +				switch (addr) {
> +				case PERF_CONTEXT_HV:
> +					cpumode =3D PERF_RECORD_MISC_HYPERVISOR;
> +					break;
> +				case PERF_CONTEXT_KERNEL:
> +					cpumode =3D PERF_RECORD_MISC_KERNEL;
> +					break;
> +				case PERF_CONTEXT_USER:
> +					cpumode =3D PERF_RECORD_MISC_USER;
> +					break;
> +				default:
> +					pr_debug("invalid callchain context: %"PRIx64"\n", addr);
> +					/*
> +					 * It seems the callchain is corrupted.
> +					 * Discard sample.
> +					 */
> +					return 0;
> +				}

Should the switch statement handle other valid context markers like
PERF_CONTEXT_GUEST, PERF_CONTEXT_GUEST_KERNEL, PERF_CONTEXT_GUEST_USER, and
PERF_CONTEXT_USER_DEFERRED?

Falling into the default block here abruptly discards the sample, which mig=
ht
break profiling workflows involving KVM guests.

[ ... ]
> +	if (sample_type & PERF_SAMPLE_RAW) {
> +		size_t bytes =3D sizeof(u32) + sample->raw_size;
> +
> +		if ((i + (bytes / sizeof(u64))) > max_i)
> +			return -EFAULT;
> +		memcpy(&out_array[j], &in_array[i], bytes);
> +		i +=3D bytes / sizeof(u64);
> +		j +=3D bytes / sizeof(u64);

Will the integer division truncate the padding bytes if the raw sample size
is not perfectly aligned to an 8-byte boundary?

Because the kernel pads raw sample payloads to an 8-byte boundary, truncati=
on
might cause i and j to fail to advance past the padding.

Could this lead to the tool misinterpreting the padding bytes as the next
fields in the sample, and also leave uninitialized heap memory from
aslr->event_copy in the output?

[ ... ]
> +	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> +		if (copy_u64(in_array, out_array, &i, &j, max_i))
> +			return -EFAULT; // nr
> +		if (sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)
> +			if (copy_u64(in_array, out_array, &i, &j, max_i))
> +				return -EFAULT; // hw_idx

Is this checking the correct bitmask?

The PERF_SAMPLE_BRANCH_HW_INDEX and PERF_SAMPLE_BRANCH_COUNTERS flags
belong to the branch_sample_type bitmask, not the sample_type bitmask.

Because the sample_type enum uses those bit values for
PERF_SAMPLE_TRANSACTION and PERF_SAMPLE_PHYS_ADDR, could a sample with a
transaction or physical address field cause the parser to incorrectly assume
the presence of branch hardware indices or counters?

> +		if (i + (sample->branch_stack->nr * 3) > max_i)
> +			return -EFAULT;

Is it possible for sample->branch_stack->nr * 3 to wrap around and bypass
this bounds check?

If a crafted perf.data file contains an exceptionally large nr value, the
multiplication might overflow and result in a small number. Could this
allow the subsequent loop to perform out-of-bounds reads from in_array?

[ ... ]
> +static int aslr_tool__process_attr(const struct perf_tool *tool,
> +				   union perf_event *event,
> +				   struct evlist **pevlist)
> +{
[ ... ]
> +	memcpy(&new_event->attr, &event->attr, event->attr.header.size);
> +	new_event->attr.attr.bp_addr =3D 0;  // Conservatively remove addresses.
> +	new_event->attr.attr.kprobe_addr =3D 0;  // Conservatively remove addre=
sses.
> +
> +	return delegate->attr(delegate, new_event, pevlist);
> +}

Could clearing bp_addr and kprobe_addr unintentionally corrupt PMU
configurations?

In struct perf_event_attr, bp_addr is an alias for the config1 union field,
and kprobe_addr is an alias for config2.

Since many hardware PMU drivers rely on config1 and config2 to store
critical event configuration data, could clearing these fields break
configurations for non-probe hardware events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424220519.2743=
472-1-irogers@google.com?part=3D1
