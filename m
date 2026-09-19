Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D093A7F6F
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780138; cv=none; b=mSO2UyChUpLG7WMEUQ7aamCdLOmoAUe8F8cNUCe3wJMORlCsFbXax+C3q+M3oUNk39R7QQg0MbZEyXnwjeD/8BWKF0TQrC+3/Kcdn0IEosnoa8O1VAUXw3cirYzgKpoSmDiVTCCnYHDgVdxCm+rhE3TW12Q6GeRGNActV5X5hqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780138; c=relaxed/simple;
	bh=Jvx9eKuoIHC6l0ve78mfr3HgtEaaGgY+sKlFx8UtMKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ahEp1/HHQO3G0JR4/UAFGfLaLGYaDhhR4mT6I34CwZk1YYPkjmy/j8a5n3TgvNoQYIgm5lWus6UcwORV34azEmcae91CYrnIFyW9p/uNWZvx2yQP+gi/EEhBOcGH7Zsy0KHU+Wqj8+IKY68kTvrWIwFIcxrS4d6q0dBMmIDRWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WifuL0nY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WifuL0nY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74071F000FF;
	Sat, 19 Sep 2026 01:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780130;
	bh=59Gutw9hZs40EdAWASzJgxTyCW8eiqJu6KI3YWrEFjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WifuL0nYW8/6E4/jmCsyOn3/BKWIY/mfYCQpoa57NuI/vyWsvZDBmdt8tgxy2ZyvB
	 ikOcAIr46Jbx5XT0bv5HjLv2VcH2Ca3PAmox3xsz/fPBcv+NZgakUdM5ceUuYvKWwY
	 pPb9TQHD7dqZSZikh5HY2MsawrzBDrlxRJ7+5JwHHRA6ziNTAJiYfSMt6mUoDbPQQ1
	 PlbV6pC9bS1oXKBOuYVloTVL+n6gPtcKHUmIQEAN4IKCn4b/TNNP8oPvo33A3kbYzK
	 omKRyfuamfUQjU/z6i2DXi9GlgPVxsx2A73LjRQCQHeYu1pw6HAGXqHpKDxBWpxzmx
	 WYYy9Md7MzdHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 perf-tools-next 3/7] perf trace: Align pointer
 advance in augmented string beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919005530.728615-4-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
 <20260919005530.728615-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:08:50 +0000
Message-Id: <20260919010850.A74071F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf trace: unpadded augmented arguments corruption due to uncondi=
tional PERF_ALIGN
--

commit edc9d58d23d30decc9c0076b0136df1e5ab01c70
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Align pointer advance in augmented string beautifier

This commit updates the augmented string beautifier in perf trace to
round up the consumed payload bytes to an 8-byte boundary using PERF_ALIGN.
It also adds bounds checking to prevent reading out of bounds if the aligned
consumed offset exceeds the remaining buffer.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1912,10 +1912,15 @@ static size_t syscall_arg__scnprintf_augmented_st=
ring(struct syscall_arg *arg, c
>  	 * So that the next arg with a payload can consume its augmented arg, i=
.e. for rename* syscalls
>  	 * we would have two strings, each prefixed by its size.
>  	 */
> -	consumed =3D sizeof(*augmented_arg) + augmented_arg->size;
> +	consumed =3D sizeof(*augmented_arg) + PERF_ALIGN(augmented_arg->size, s=
izeof(u64));

[Severity: High]
Does this unconditional alignment cause corruption when reading arguments=20
produced by the generic BPF tracepoint?

The generic BPF producer, specifically augment_arg() in=20
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c, emits unpadded,=20
tightly-packed arguments. When tracing syscalls with multiple string or=20
pointer arguments (such as linkat, symlinkat, or move_mount), the BPF=20
program packs the strings consecutively.

Since PERF_ALIGN skips non-existent padding bytes here, could this=20
over-advance the pointer and misalign the reader for the second argument,=20
causing it to read arbitrary payload bytes as the size and value fields?=20

Additionally, might this affect backward compatibility when analyzing=20
older, unpadded perf.data files where augmented string arguments are not=20
aligned to an 8-byte boundary?

> =20
> -	arg->augmented.args =3D ((void *)arg->augmented.args) + consumed;
> -	arg->augmented.size -=3D consumed;
> +	if (consumed > arg->augmented.size) {
> +		arg->augmented.args =3D NULL;
> +		arg->augmented.size =3D 0;
> +	} else {
> +		arg->augmented.args =3D ((void *)arg->augmented.args) + consumed;
> +		arg->augmented.size -=3D consumed;
> +	}
> =20
>  	return printed;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919005530.7286=
15-1-atomlin@atomlin.com?part=3D3
