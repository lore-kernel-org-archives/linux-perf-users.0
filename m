Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792624531;
	b=Cq8v7hJL+ATUg5oTZ27gKOZbetdpcISp1UWuTSjfK9geVKP2IWbxEJed/smv3f42edX6
	 updEAADGgI7DUjDm9xOhyyfddlAwzZaVyFfmH4Fpx9prTqgXWe7esKc2eC/fsETB0N5fq
	 Fhc4lWSEVWYlbgRjGOiBnqW4+KsoDUmPP1IrnyEiYT9FvXseuEF2ZDIso825Jx0vqHK/r
	 iQvhQ4r25o7alSYY32z5fAccYoJe/8/hgCaAp4n43QuB/2crTkik17+u2BikDtmFHYrK1
	 xjt97KsngKjUqiRw9BFr+X00d9iq+LIlbtT7UAjcIQHaF78ZllnwLZ9aMyFJeYvaRog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624531;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lC78Z80wSYisl+l+lVyIEgFGEtJkwbpKzc2/+mDgrNg=;
	b=SqAjiXSNpww01cvZrf4WeCbP0cE5spJnv0RsPc2d3gtG7PErNZoaP/ysDPutD8gMwerY
	 Drmu+kD+Bu9zAALnt9kk+4TKUGnogDrm8KmxnZi1E5aUiPO7ecKqXRJLFowJ4TE4HMzos
	 OSDgE6XFl8m40hNEqUfm80M0KD17/yOBU5+pBF/c5OGrMj+oe/iH9L6s++dVuhWN49R1x
	 3Natz0VzuYZq0aKhDs+aF+qCSlAgn1TWeayDna94SbCKOKIVE6876PfTVCobaAHSXp+jR
	 TiN6cEpP2MJqsEAHypCSBfdAscUjsEImTikD3e4DKNMgffN5ucSTxieVHly64rbhtSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UX21qrou;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7B606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UX21qrou
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4DF1F000C1;
	Wed, 21 Oct 2026 23:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792624530;
	bh=lC78Z80wSYisl+l+lVyIEgFGEtJkwbpKzc2/+mDgrNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UX21qrouOx1pFeXPEpSH1lSjEV0zOup5BVoYgG/dMtRiv1X8GQbe2SsUhnwRg01jr
	 CN9E3tLnabk51YpNrQlRgr4/0w/aKact43Y4j7/fvkSyxr7SagRzFVTqxDSGyTzYDB
	 e49w16h+k2hUivOGqXxC3VP9FP0zARgOEcNLPNLYCVDRJfb3G4PUoz7lRdgcH0wfSL
	 Lzx1PRsCSO1LUnUXOW6r8jtXLHuP+CJau0/Fh4U1WtwvUWiCEj3pGpfIQ559Gy11Yv
	 uJXv/KVIeEFRx8ygiLikGnvTwNpOP1VxhCRiGG+4mGpWexT6jcKyu84wyTBDwaBrE6
	 epWS/AD7Md2NA==
Message-ID: <sashiko-outbox-180773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/17] perf dso: Pass dso_data to close_data_fd() and
 dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-9-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 23:15:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf machine: ksymbol DSOs in machine->dsos break dsos__find_ker=
nel_dso()
--

commit ee6de697254c2c11b0b98867463c4f6682315113
Author: Ian Rogers <irogers@google.com>

perf dso: Pass dso_data to close_data_fd() and dso__list_del()

This commit passes struct dso_data pointers directly to close_data_fd() and
dso__list_del() so close_first_dso() does not need to recover a struct dso
pointer, and adds newly created dso instances in auxtrace, machine, and
symbol helpers to dsos collections.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 1d9d3bf577200..4507f82548e3e 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -771,6 +771,15 @@ static int machine__process_ksymbol_register(struct =
machine *machine,
>  			dso__set_loaded(dso);
>  		}
> =20
> +		if (is_bpf_image(event->ksymbol.name)) {
> +			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
> +			dso__set_long_name(dso, "", false);
> +		}
> +
> +		err =3D dsos__add(&machine->dsos, dso);
> +		if (err)
> +			goto out;

[Severity: Medium]
Could adding ksymbol dso entries to machine->dsos in
machine__process_ksymbol_register() cause dsos__find_kernel_dso() to return=
 a
ksymbol dso instead of the kernel dso?

In tools/perf/util/machine.c:machine__process_ksymbol_register(), the newly
created ksymbol dso is marked as a kernel dso and marked loaded:

tools/perf/util/machine.c:machine__process_ksymbol_register() {
	...
		dso =3D dso__new(event->ksymbol.name);
		...
		dso__set_kernel(dso, DSO_SPACE__KERNEL);
		...
		if (is_bpf_image(event->ksymbol.name)) {
			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
			dso__set_long_name(dso, "", false);
		}

		err =3D dsos__add(&machine->dsos, dso);
		...
		dso__set_loaded(dso);
	...
}

Because __dsos__add() sorts machine->dsos by dso__long_name(dso), a bpf ima=
ge
dso with long_name set to "" is placed at index 0 ahead of all non-empty
names, while other ksymbol dso entries use event->ksymbol.name as their
long_name.

When tools/perf/util/machine.c:machine__process_kernel_mmap_event() later
looks up the kernel dso via dsos__find_kernel_dso():

tools/perf/util/machine.c:machine__process_kernel_mmap_event() {
	...
		struct dso *kernel =3D dsos__find_kernel_dso(&machine->dsos);

		if (kernel =3D=3D NULL)
			kernel =3D machine__findnew_dso(machine, machine->mmap_name);
		if (kernel =3D=3D NULL)
			goto out_problem;

		dso__set_kernel(kernel, dso_space);
		if (__machine__create_kernel_maps(machine, kernel) < 0) {
	...
}

dsos__find_kernel_dso() iterates machine->dsos from index 0 using
dsos__find_kernel_dso_cb():

tools/perf/util/dsos.c:dsos__find_kernel_dso_cb() {
	...
	if (!dso__kernel(dso) ||
	    is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN=
))
		return 0;

	*res =3D dso__get(dso);
	return 1;
}

Since is_kernel_module() returns false for "" and for ksymbol names like
"bpf_prog_...", wouldn't dsos__find_kernel_dso() match a registered ksymbol
dso (when ksymbol events are processed before the kernel mmap event, or when
a bpf image dso with long_name "" is sorted at index 0 ahead of an existing
kernel dso) and cause __machine__create_kernel_maps() to bind
machine->vmlinux_map and the kernel build-id to that already-loaded ksymbol
dso?

>[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D8
