Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3481EFFB7
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775628017; cv=none; b=KqD+DsSzmsmZbtjJe7pil6vdEiEUK2i+aqQlZJlJIgfRedL3+wSoeSaUYmC4+A1eB+NyeVFc5IOXBJwGYUHz4SmEgWiT9+uQUBAHsEN0CnsTMmeIII+Ga2JDVTdsfcUoK5YuUjF57U/vey/mYqNVL9LhM79jPYdA43qGAzqEpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775628017; c=relaxed/simple;
	bh=KLzMbgUv7fLheMwxhxjwx03I3Q6JvonPKH7O+6roEK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DLp71Likxcg18R7jvELetgLWMLi/QDHx7q9w1brSgMdaHZLcIZn1Y+KNJwz+eFSVY69u6h7GNi3hQLKEfA7EfOXQg0EYtKdf/3gvumYNYGWSROQUII6lgPf6IdOHtCOPMNyW5OTTCMhAqI6wdcm85sdBJZMy60G6cMSXCIM1k0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duO6bnhb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duO6bnhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F21DC19424;
	Wed,  8 Apr 2026 06:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775628017;
	bh=KLzMbgUv7fLheMwxhxjwx03I3Q6JvonPKH7O+6roEK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=duO6bnhbwpSh9bg3P0KS6a35f5nYLNbdmGQ3XjopEhk82SRsMcfF2AcUC4F/ca8I5
	 oG+LlbLE8ZkWfJKN8uo7wwDJzRMjBtOa+aZ7OzPuH0kzRfxmrLzjudYTdjul118PhT
	 k1Ck/kOl7OlyKEdbnjz570P0b6LoxXqyOWAxf416zv3Y8dSy8/XlPniKJP+prx+4J0
	 k4Ma703D0E93L620HtX/Gyn96GIc5Im+BUE/R/Kqb3xbZkPvD8fvY8rmChwC2ZT355
	 zxVTeTdzJwh8cP0cn1i6C29CP8yAqJTAVECAOAOoWkr/S6kRMpfsMdaX/QmCnC2QUj
	 AjgxXVbLsRDvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf build: Add -Wno-missing-declarations for
 GEN_VMLINUX_H=1
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408055259.374744-2-namhyung@kernel.org>
References: <20260408055259.374744-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 06:00:17 +0000
Message-Id: <20260408060017.9F21DC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Suppressing the missing-declarations warning instead of enabling=
 Microsoft extensions causes Clang to silently drop anonymous fields from s=
tructures in `vmlinux.h`.
--

commit 93aff8b1d8d6d53f0451d4c78852fef0b06314df
Author: Namhyung Kim <namhyung@kernel.org>

perf build: Add -Wno-missing-declarations for GEN_VMLINUX_H=3D1

This commit suppresses the missing-declarations warning by adding
-Wno-missing-declarations when compiling BPF skeletons in perf.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1249,7 +1249,7 @@ $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LI=
BBPF) $(SKEL_OUT)/vmlinux.h
>  	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=3Dbpf \
>  	  $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLU=
DE) \
>  	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_versi=
on.h \
> -	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
> +	  -Wno-missing-declarations -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@

Does suppressing this warning instead of enabling Microsoft extensions cause
Clang to silently drop anonymous fields from structures in vmlinux.h?

bpftool generates anonymous structs in vmlinux.h using a Microsoft extensio=
n.
Without -fms-extensions, standard C treats these as empty forward declarati=
ons.
Clang ignores them, effectively removing them from the struct layout and
altering the structure's size and offsets.

By passing -Wno-missing-declarations instead of enabling the extension, cou=
ld
this hide the layout corruption? Any perf BPF programs relying on the size =
of
such structs or performing non-CO-RE offset calculations might compute
incorrect values, leading to verifier rejections or incorrect tracing
statistics.

Would it be better to pass -fms-extensions and -Wno-microsoft-anon-tag to
properly support this in Clang, mirroring the fix applied to BPF selftests =
in
commit 835a50753579a?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408055259.3747=
44-1-namhyung@kernel.org?part=3D2
