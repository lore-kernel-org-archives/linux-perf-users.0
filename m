Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09043385B2
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780869139; cv=none; b=Lt4cz/6cfHfWcx18w5T2/r7heAaQRn+A7ld9mDusPw8Gi47Y9aQhNzDTvsjAjNVbDoHuayEH0FCB2BrUGlABhkWOsfIzKdVgia+dGgKQBH31HxYT7uyY35TBNgxZ5smsC/SJPWRnIgrors1U8YxGkXew4VL+vXBKoXXvZ/wSVgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780869139; c=relaxed/simple;
	bh=VMCntcUVCvWrr0+uRoDPyrAihNwsTFoxDzs3+9RLdVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OFl0uRwDjmypee6HOV0h78pcCqnF0Tu1LFpUrDdJAwLEy6kaPsEar0oHsH1+Mh6jpPkdm0fUeHm1AgqzOwV61x2xfJPtL4aHFWZLqYweLAcTZapPbsBP7SU/AJrUG8lE5ebE+QSBM1STV+EonqvnCzx+SulyLUHYA11FSidzAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX4KCIYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX4KCIYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181981F00893;
	Sun,  7 Jun 2026 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780869137;
	bh=44bAFxZ2YQZICVE1qzhKVZTxknk+fndNciW260FMUVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kX4KCIYsRNsrwCP5CwxJkPHKYCe6k+yxFBBwrhgDQRW9ES0mdVPPS8lG88Fjlmd3Y
	 QvXFQml4Q9yovVnQtfjCE/IwGqueBOBXGz8OqHMnmCvaKq9ByLd0MSbgYp935ld6f6
	 KMtZPBl8yplXwyKUn7Gd0sRaCtq06xqqKMcvk0ICpqg4GRC0HVYQybw9wnn6zLuvep
	 5K2DHaxrzo4P64fSNzmEWY4TINAXS/IH8a5Xojjo9Pmt3CAf5RN16/cou+eabOnPAE
	 5kxXoVh7C9hDykDq5AI4es+0GUfJsWzM+ZmfjSc1v6ZD+w2xRDWguHTLjieL0obOon
	 C60F4RCkpU1pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607213700.3563842-3-irogers@google.com>
References: <20260607213700.3563842-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 21:52:16 +0000
Message-Id: <20260607215217.181981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect `pgoff` overwrite for kernel modules breaks symbol resol=
ution.
- [Medium] KSYMBOL REGISTER and UNREGISTER events receive mismatched remapp=
ed addresses due to incorrect lookup ordering.
--

commit bea273ddc97f1917658141d7ddbe3f4f2db6086b
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking

If perf.data files are taken from one machine to another they may
leak virtual addresses and so weaken ASLR on the machine they are
coming from. Add an aslr option for perf inject that remaps all
virtual addresses, or drops data/events, so that the virtual address
information isn't leaked.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..e45f68c604937
> --- /dev/null
> +++ b/tools/perf/util/aslr.c

[ ... ]

> +static int aslr_tool__process_mmap(const struct perf_tool *tool,
> +				   union perf_event *event,
> +				   struct perf_sample *sample,
> +				   struct machine *machine)
> +{

[ ... ]

> +	/* Remaps the mmap.start. */
> +	new_event->mmap.start =3D aslr_tool__findnew_mapping(aslr, machine, thr=
ead, cpumode,
> +							   event->mmap.start,
> +							   event->mmap.len,
> +							   event->mmap.pgoff);
> +	/*
> +	 * For anonymous memory (and kernel maps), the kernel populates the
> +	 * event's pgoff field with the original un-obfuscated virtual address
> +	 * in bytes (i.e. (addr >> PAGE_SHIFT) << PAGE_SHIFT).
> +	 * We must overwrite pgoff with the new remapped byte address to prevent
> +	 * leaking the original ASLR layout.
> +	 */
> +	if (cpumode =3D=3D PERF_RECORD_MISC_KERNEL || cpumode =3D=3D PERF_RECOR=
D_MISC_GUEST_KERNEL ||
> +	    is_anon_memory(event->mmap.filename) || is_no_dso_memory(event->mma=
p.filename))
> +		new_event->mmap.pgoff =3D new_event->mmap.start;

[Severity: High]
Will unconditionally overwriting pgoff with the remapped start address for
kernel maps break symbol resolution for kernel modules?

For kernel modules synthesized by perf_event__synthesize_modules(), mmap
events are emitted with pgoff =3D 0 or relative file offsets. By overwriting
pgoff with the remapped start address here, the correct map offset is
destroyed.

When perf report calculates the map ip (ip - start + pgoff), would it
yield the absolute remapped virtual address instead of the correct relative
offset, causing symbol lookups in .ko files to fail?

> +	err =3D delegate->mmap(delegate, new_event, sample, machine);
> +	thread__put(thread);
> +	return err;
> +}
> +
> +static int aslr_tool__process_mmap2(const struct perf_tool *tool,
> +				    union perf_event *event,
> +				    struct perf_sample *sample,
> +				    struct machine *machine)
> +{

[ ... ]

> +	/* Remaps the mmap.start. */
> +	new_event->mmap2.start =3D aslr_tool__findnew_mapping(aslr, machine, th=
read, cpumode,
> +							    event->mmap2.start,
> +							    event->mmap2.len,
> +							    event->mmap2.pgoff);
> +	/*
> +	 * For anonymous memory (and kernel maps), the kernel populates the
> +	 * event's pgoff field with the original un-obfuscated virtual address
> +	 * in bytes (i.e. (addr >> PAGE_SHIFT) << PAGE_SHIFT).
> +	 * We must overwrite pgoff with the new remapped byte address to prevent
> +	 * leaking the original ASLR layout.
> +	 */
> +	if (cpumode =3D=3D PERF_RECORD_MISC_KERNEL || cpumode =3D=3D PERF_RECOR=
D_MISC_GUEST_KERNEL ||
> +	    is_anon_memory(event->mmap2.filename) || is_no_dso_memory(event->mm=
ap2.filename))
> +		new_event->mmap2.pgoff =3D new_event->mmap2.start;

[Severity: High]
Like the issue in aslr_tool__process_mmap() above, does overwriting pgoff
here similarly corrupt map offsets for mmap2 events from kernel modules?

> +	err =3D delegate->mmap2(delegate, new_event, sample, machine);
> +	thread__put(thread);
> +	return err;
> +}

[ ... ]

> +static int aslr_tool__process_ksymbol(const struct perf_tool *tool,
> +				      union perf_event *event,
> +				      struct perf_sample *sample,
> +				      struct machine *machine)
> +{

[ ... ]

> +	memcpy(&new_event->ksymbol, &event->ksymbol, event->ksymbol.header.size=
);
> +	/* Remaps the ksymbol.start before process_ksymbol potentially deletes =
the map */
> +	new_event->ksymbol.addr =3D aslr_tool__findnew_mapping(aslr, machine, t=
hread,
> +							     PERF_RECORD_MISC_KERNEL,
> +							     event->ksymbol.addr,
> +							     event->ksymbol.len,
> +							     /*pgoff=3D*/0);
> +
> +	err =3D perf_event__process_ksymbol(tool, event, sample, aslr_machine);

[Severity: Medium]
Does calling aslr_tool__findnew_mapping() before perf_event__process_ksymbo=
l()
cause ksymbol unregister events to receive a mismatched remapped address?

For a bpf register event, the map does not exist yet in aslr_machine, so
aslr_tool__findnew_mapping() records the new remapping using a key with a
NULL dso.

When the corresponding unregister event arrives, aslr_tool__findnew_mapping=
()
executes before perf_event__process_ksymbol() removes the map. It finds the
existing map, extracts its dso, and looks up the remapping using a key with
a non-NULL dso.

Since this lookup fails, could the unregister event get assigned a
completely different remapped address and break bpf symbol tracking?

> +	if (err) {
> +		thread__put(thread);
> +		return err;
> +	}
> +
> +	err =3D delegate->ksymbol(delegate, new_event, sample, machine);
> +	thread__put(thread);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607213700.3563=
842-1-irogers@google.com?part=3D2
