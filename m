Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49131A045
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883976; cv=none; b=ZofVG01SnPgdT6TB+Di9FiwvI7EGb/W93dI4BZAzL9Nt8ZNDPDe5VAxUAQRw2fvSCRe771Z4sm7lEeuI7g8AOtosWrpsuReTIOb250KYwlpTepL+6OBX846ozPQzeE6x8tPiBRk4c9u9sl4vVGvMQ71whMKM4JcF714+fcTkMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883976; c=relaxed/simple;
	bh=Q1LhCA0SuYtlvlpBxhcX/mvx5kbx02Cbuv5kWmfcK/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0qP22JJ8a4qd6VNA7ogjmsWbka9+12udXNML+XfiEGOnylTIZOX548Z7gbeAQ7OaoenjtFqteYKIOEh6cCoORtR9Fqc6EJskg6iRG9ZBs7uViL699107VC1yxB7GrdChfqY48yENgR40SkYstTATRtk4furMDYx5kIKq9ifanA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwE6rYJ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwE6rYJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC3BC2BCB9;
	Mon,  4 May 2026 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777883976;
	bh=Q1LhCA0SuYtlvlpBxhcX/mvx5kbx02Cbuv5kWmfcK/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AwE6rYJ53asecvMPxgaRqLtv6LjKaBRH8Ed3gvY4mc13jlVyxcjDGTw6R6pzXyTue
	 CJz8q3eWirGgZ3cYxVwuHBiaJST64peE2X7r4z1HL3RL2AqDN41Aq87UMev0mVHzQq
	 UXcxYgyFXfBjblFNhBC0X5jx1cBX8pFNHPvVUlVQPhpbcpXP3aAkYcplSqRwP7B6w1
	 SVGUFQgk5VIpvUOAeqmwlhDgZDKI76rFM/aD3+ddchbmdz2K3+rjbUDRtND2pQ6lt6
	 Ahf2IG0tSi1yol/1dxXMoS05mceMo57lASK/c1TqkZOjvk2Srflb+MgDlwxcWaa26T
	 AOhUiMm/fPGmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] perf inject/aslr: Add aslr tool to
 remap/obfuscate virtual addresses
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504072937.2103453-4-irogers@google.com>
References: <20260504072937.2103453-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 08:39:35 +0000
Message-Id: <20260504083936.4DC3BC2BCB9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Kernel ASLR base is leaked through unmodified mmap `pgoff` fields.
- [Medium] The 'targeted tail-word clearing' logic for STACK_USER and AUX f=
rames is dead code because the entire sample is unconditionally dropped imm=
ediately after.
- [Medium] The `skipn()` pipe helper lacks retry logic for `-EINTR`, riskin=
g spurious aborts.
--

commit 0794ff7942de3e0dd56f299d7bfb0e61ba3fc97a
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses

This commit introduces an '--aslr' option for perf inject to remap virtual
addresses in perf.data files. This prevents leaking virtual addresses and
weakening ASLR on the source machine. Events with unknown or unhandled
addresses are dropped to remain conservative.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 000000000000..27b642c91eb9
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
> @@ -0,0 +1,1161 @@

[ ... ]

> +static int skipn(int fd, u64 n)
> +{
> +	char buf[4096];
> +	ssize_t ret;
> +
> +	while (n > 0) {
> +		ret =3D read(fd, buf, (n < (u64)sizeof(buf) ? n : (u64)sizeof(buf)));
> +		if (ret <=3D 0)
> +			return ret;

Will this cause spurious aborts if read() is interrupted by a signal?

Since this is reading from a pipe, if read() returns -1 with errno =3D=3D E=
INTR,
skipn() will return the error immediately rather than retrying.

> +		n -=3D ret;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int aslr_tool__process_mmap(const struct perf_tool *tool,
> +				union perf_event *event,
> +				struct perf_sample *sample,
> +				struct machine *machine)
> +{
[ ... ]
> +	memcpy(&new_event->mmap, &event->mmap, event->mmap.header.size);
> +	/* Remaps the mmap.start. */
> +	new_event->mmap.start =3D aslr_tool__remap_mapping(aslr, thread, cpumod=
e,
> +							   event->mmap.start,
> +							   event->mmap.len,
> +							   event->mmap.pgoff);

Does this leak the kernel ASLR base?

For the main kernel mapping, the perf tool synthesizes mmap events where the
mmap.pgoff field is set to the original kernel start address. Since pgoff is
left unmodified here, the unobfuscated kernel base address will be copied
directly into the output stream.

> +	err =3D delegate->mmap(delegate, new_event, sample, machine);
> +	thread__put(thread);
> +	return err;
> +}

[ ... ]

> +static int aslr_tool__process_mmap2(const struct perf_tool *tool,
> +				union perf_event *event,
> +				struct perf_sample *sample,
> +				struct machine *machine)
> +{
[ ... ]
> +	memcpy(&new_event->mmap2, &event->mmap2, event->mmap2.header.size);
> +	/* Remaps the mmap.start. */
> +	new_event->mmap2.start =3D aslr_tool__remap_mapping(aslr, thread, cpumo=
de,
> +							   event->mmap2.start,
> +							   event->mmap2.len,
> +							   event->mmap2.pgoff);

Similarly, does this leave the unobfuscated kernel base address in pgoff
for mmap2 events?

> +	err =3D delegate->mmap2(delegate, new_event, sample, machine);
> +	thread__put(thread);
> +	return err;
> +}

[ ... ]

> +static int aslr_tool__process_sample(const struct perf_tool *tool, union=
 perf_event *event,
> +				struct perf_sample *sample,
> +				struct evsel *evsel, struct machine *machine)
> +{
[ ... ]
> +	if (sample_type & PERF_SAMPLE_STACK_USER) {
> +		u64 size;
> +
> +		CHECK_BOUNDS(1, 1);
> +		size =3D out_array[j++] =3D in_array[i++];
> +		if (size > 0) {
> +			size_t u64_words =3D size / 8 + (size % 8 ? 1 : 0);
> +
> +			if (u64_words > max_i - i || u64_words > max_j - j) {
> +				ret =3D -EFAULT;
> +				goto out_put;
> +			}
> +			memcpy(&out_array[j], &in_array[i], size);
> +			if (size % 8) {
> +				size_t pad =3D 8 - (size % 8);
> +
> +				memset(((char *)&out_array[j]) + size, 0, pad);
> +			}

Is this tail-word clearing dead code?

> +			i +=3D u64_words;
> +			j +=3D u64_words;
> +
> +			COPY_U64(); /* dyn_size */
> +		}
> +		/* TODO: can this be less conservative? */
> +		pr_debug("Dropping stack user sample as possible ASLR leak\n");
> +		ret =3D 0;
> +		goto out_put;

Immediately after clearing the trailing heap padding in the output array, t=
he
code unconditionally jumps to out_put with ret =3D 0, skipping the sample
delegate call. This drops the entire sample from the output stream.

> +	}

[ ... ]

> +	if (sample_type & PERF_SAMPLE_AUX) {
> +		u64 size;
> +
> +		CHECK_BOUNDS(1, 1);
> +		size =3D out_array[j++] =3D in_array[i++];
> +		if (size > 0) {
> +			size_t u64_words =3D size / 8 + (size % 8 ? 1 : 0);
> +
> +			if (u64_words > max_i - i || u64_words > max_j - j) {
> +				ret =3D -EFAULT;
> +				goto out_put;
> +			}
> +			memcpy(&out_array[j], &in_array[i], size);
> +			if (size % 8) {
> +				size_t pad =3D 8 - (size % 8);
> +
> +				memset(((char *)&out_array[j]) + size, 0, pad);
> +			}
> +			i +=3D u64_words;
> +			j +=3D u64_words;
> +		}
> +		/* TODO: can this be less conservative? */
> +		pr_debug("Dropping aux sample as possible ASLR leak\n");
> +		ret =3D 0;
> +		goto out_put;
> +	}

Does this code also unnecessarily calculate and clear the tail padding for
AUX frames, given that the sample is unconditionally dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504072937.2103=
453-1-irogers@google.com?part=3D3
