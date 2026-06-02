Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD5C3EFFC2
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414950; cv=none; b=YyULfb74apQooBO7/E8qn0MhfjCnzpZXjlL0ZZMRVfj9ij9j7JVsW7XZxUwKbUnd0hexvUwR9X45IHbnnCpaz9AwnGpygnAbLpH1d31g1Xu0QmQP/UAt+1p0wOIIi1bPrZorfz1vlm/UE/6BlnzxTAiBIv/Snn7HTDbb8B3kTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414950; c=relaxed/simple;
	bh=1Rzn1j0RLyzdKcCKN42BwBQv4lJ/3hr9q3Q/+nzNwHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TUx7Py+xAAx6UKv54gmipZuzWf5yRdHLIYrBVNTe4llaZ8phJg7X0lO2mG1dsCh1V6jDQ17EqZT36KINoogWaWJsZZ9B8df6HaHExEnMpjSNMkHdxTdYtn+u6skVf3fzkIBeWZdGMazkbVv+jcDINOVeRroVbvW+IEgM5uk8Te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwilyULy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwilyULy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB511F00893;
	Tue,  2 Jun 2026 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414947;
	bh=YGMH6Cz6Psl8CMPUmsKhWf/xxfzBeemx1nqKFiT0VcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JwilyULyVQ62PI7QbtdSUvmvO74NtPa90uF3q+ZaJIyNWkTVN0FDXm4+MMbKln6TM
	 2gV5jiG2xchOO8NCzZa4UJpy7DkmYxN7b9mFWKdgtAItnf2UviWPbNPBEFQQPT9+wb
	 JanLXU19aZo6S7lWHQGznl37ppUAET13WEHwKRzVlXcR/QFsI7nWoraybKgBfbBasA
	 k2T9834JTkgW7d8ojg4arBPkZuRiBmk0uuNYC3JJpv0Lh0JT/oJmU8lyzDx4q/slKr
	 dpMPUKr4qr1J/fqFfKrnhtgwhEOQGFP7pi31lpARgcbt58Q/+pu/vtuXAmp5BYMtri
	 lVm0f/MlRYi9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/19] perf env, dso, thread: Add _endian variants
 for e_machine helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602152516.2831152-4-irogers@google.com>
References: <20260602152516.2831152-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:42:26 +0000
Message-Id: <20260602154227.2AB511F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `maps__machine()` with a NULL `maps` pointer causes a segm=
entation fault.
--

commit 53562e7c68bd480e23dc08ba72db35bfbe234752
Author: Ian Rogers <irogers@google.com>
Subject: perf env, dso, thread: Add _endian variants for e_machine helpers

This commit adds new _endian variants for ELF machine helpers to support cr=
oss
architecture analysis and bi-endianness. These additions allow querying the
absolute endianness of a DSO or thread, which is required for external tool=
s.

> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
[ ... ]
> @@ -483,6 +500,7 @@ uint16_t thread__e_machine(struct thread *thread, str=
uct machine *machine, uint3
>  		struct maps *maps =3D thread__maps(thread);
> =20
>  		machine =3D maps__machine(maps);
> +		args.machine =3D machine;
>  	}
>  	tid =3D thread__tid(thread);

[Severity: High]
This is a pre-existing issue, but could this dereference a NULL pointer if
the thread lacks attached maps?

If thread__e_machine_endian is called concurrently while a new thread is
being initialized (for instance, via a concurrent iteration like
machines__for_each_thread), it seems the thread might be visible in the
machine's thread hashmap before thread__init_maps sets up the maps.

If thread__maps returns NULL here, will maps__machine attempt to
dereference the NULL pointer and trigger a segmentation fault? Should we add
a check to ensure maps is valid before looking up the machine?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602152516.2831=
152-1-irogers@google.com?part=3D3
