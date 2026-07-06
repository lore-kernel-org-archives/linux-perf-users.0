Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903229AB05;
	Mon,  6 Jul 2026 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340076; cv=none; b=Fyb4GqGap4pzmS3fGd5XmDcVZ0pfCPL5+7GwmwQuvERPE01pcHPK7Nqoh1IxtzhbpoRwneakdkz/AJMQOwtXBypEH8OzldqJf9wTYfKKO+53Hg19UPo9TspzxKboPXkxy9iOo8kJBjAY9fAm4JxtSmDKKfN8AX/a4ZvpHh8n674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340076; c=relaxed/simple;
	bh=xWzats+EK6ssbvYN9fdIA0pIZDrSTzWqsSsZcSc5Tl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R3OMYTi/S0nRgdmIO4CHpc7chgx2C0cs4oXpqwQCxEK6l04OOkyPIcsZDuQdL0Vt+03/jlnA5T40gJ5oOZy2x1rUwli68cSXwanMg5xF0HFXIY92QO6JdniQgtn1rgqV1zK8Gs2hEulXs6ILndnJLZUQtvpSx8nIzyDsEoaxOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1jNcB0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1jNcB0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F39A1F00A3A;
	Mon,  6 Jul 2026 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783340072;
	bh=XiZ7gDQr09wnI0GDoQNVRyEAJFw89yx47ok+VTqCVFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D1jNcB0pmPRiBJZpjDf8sogUMQlAiOE7XHJUMQ62m0Kj7KWomStVhjrpNMCjWd3Oy
	 oBRioOPNUXY7vzBFU02Aw3m8QpIoI7CLLAvOOB9a6ZdV6sIytd+znYSJ/3WV3d6+un
	 DeF5KG625lKFaNag4GrZ0qfk6fA9LxvwzAjihmyL+6dEW2+EPuMlUkRcboRIy13Xi/
	 9yHS4/6PIEMZRE/wtJiHJquvu+81wZ78n5dta4HN4r8plpoj/nnIsn8HUhWE8KE5kc
	 QfkQ7Ajpc0HFiL+ppukfgFps0uwttabExgb/rJHCe9+aX9UE7Nv+lan5owDE23DhP0
	 H2kuMVFOYzT3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf trace: Refactor augmented_raw_syscalls
 using bpf_for
Reply-To: sashiko-reviews@lists.linux.dev
To: "Viktor Malik" <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <fdf56026e442e44b2374119c21babde4910f3b6e.1783339165.git.vmalik@redhat.com>
References: <cover.1783339165.git.vmalik@redhat.com>
 <fdf56026e442e44b2374119c21babde4910f3b6e.1783339165.git.vmalik@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:14:32 +0000
Message-Id: <20260706121432.8F39A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The fallback standard `for` loop will fail to load with `-E2BIG`=
 on older kernels when compiled with Clang 15-18, breaking backward compati=
bility.
--

commit be9035b8b528902be67522e81fa232a2f597b164
Author: Viktor Malik <vmalik@redhat.com>

perf trace: Refactor augmented_raw_syscalls using bpf_for

The commit replaces the standard `for` loop in `augment_sys_enter()` with
`bpf_for` to fix BPF verifier `-E2BIG` errors on newer Clang versions. It
drops artificial verifier workarounds in `augment_arg()` that were previous=
ly
added to fix these errors. A fallback standard `for` loop is kept for backw=
ard
compatibility with older kernels lacking `bpf_for`.

> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index bc036a348079d..215516df5d2a3 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -440,10 +442,11 @@ static inline int augment_arg(struct syscall_enter_=
args *args, int i,
>   */
>  static inline int augment_arg(struct syscall_enter_args *args, int i,
>  			      unsigned int *beauty_map,
> -			      struct augmented_arg *payload_offset)
> +			      struct beauty_payload_enter *payload, u64 offset)
>  {
> -	int index, value_size =3D sizeof(struct augmented_arg) - offsetof(struc=
t augmented_arg, value);
> -	s64 aug_size, size;
> +	int index, size, value_size =3D sizeof(struct augmented_arg) - offsetof=
(struct augmented_arg, value);
> +	struct augmented_arg *payload_offset;
> +	s64 aug_size;

[ ... ]

> -	} else if ((int)size < 0 && size >=3D -6) { /* buffer */
> +	} else if (size < 0 && size >=3D -6) { /* buffer */

[ ... ]

> @@ -522,14 +529,30 @@ static int augment_sys_enter(void *ctx, struct sysc=
all_enter_args *args)
> 	/* copy the sys_enter header, which has the syscall_nr */
> 	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args)=
);
> =20
> -	for (int i =3D 0; i < 6; i++) {
> -		written =3D augment_arg(args, i, beauty_map, (struct augmented_arg *)p=
ayload_offset);
> -		if (written < 0)
> -			return 1;
> -		if (written > 0) {
> -			output +=3D written;
> -			payload_offset +=3D written;
> -			do_output =3D true;
> +	if (bpf_ksym_exists(bpf_iter_num_new)) {
> +		bpf_for(i, 0, 6) {

[ ... ]

> +	} else {
> +		for (i =3D 0; i < 6; i++) {
> +			written =3D augment_arg(args, i, beauty_map, payload, output);

[Severity: Medium]
Will this fallback standard `for` loop fail to load with `-E2BIG` on older
kernels when compiled with Clang 15-18?

Since the `(int)size < 0` cast and `s64 size` verifier workarounds were rem=
oved
from `augment_arg()`, it appears the unrolled loop in this fallback path wi=
ll
once again fail the BPF verifier checks when evaluated on kernels older than
6.4 (where `bpf_ksym_exists(bpf_iter_num_new)` is false). Could this break
backward compatibility for `perf trace` on those older kernels?

> +			if (written < 0)
> +				return 1;
> +			if (written > 0) {
> +				output +=3D written;
> +				do_output =3D true;
> +			}
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783339165.gi=
t.vmalik@redhat.com?part=3D2
