Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599704;
	b=40AXHPJ3JykrUqeHpIxdHEYcPRjiDG9YZBeKfvBcbF0V/BD39uf4Nt0QvY7mqMFjFGEE
	 nULTTZi4VE9etdzadmJY94OoaLC3otHGhrhGSTwsORR7X7SUo6MZrssnzZXnm3ox0EBjV
	 86NRG3UZfwwV0C9xRHzKLfB3raGsFgswISvDq9BK8TFK2O8jaH5GWYEg4V2wz13eMilMg
	 OyLrDp3AdvgPUdImowIMMQyNXRHYZb9SZfY990xyjoiNOQaOPt8byhwA7QV5U+Fh4Vebd
	 WngUDeOdU5PToXC3O0aaY7mggt9LxBvYRiPqPDWo6wbJL3PdNt3myGQyIJlf7an6pDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KCN9Aykrfa9ugCInTklXxAGVv2K+6wIXtwpAoiT7f/U=;
	b=FdjrwQKKJuoaioPgZhX6B2Vj5hVcuShdceZ0YzoZ5w9U+/uTlyT9oxq6H2z0FNQ5b0Nj
	 aBSLwNb5OfMYTCreN4RqCe3XAM6nwwA2Cc11fpZ5bXvK1oUixbv/ycgzZClyxcp30M+PX
	 67vQNPd3TSMD0ApSu+9JAW6fxe02LVKz4IVCJDIob1douLq0zktvq/LOQS0KXhiUPpUKE
	 xjM23pgdsbiiGDg+5wkPvvdqCY+ATirjUb65fIPp0nQXTRRZkSWyxo5/Kf3/MF+U+IvXI
	 79V0+tabJPSysXM9vYLoumJO0zHl3gUTB9xFP1bnRcR5S07fMRfAnV9Izzlg7HYEoeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V56a/UkD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA0606BCF2;
	Fri, 13 Nov 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V56a/UkD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B131F000CB;
	Fri, 13 Nov 2026 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599704;
	bh=KCN9Aykrfa9ugCInTklXxAGVv2K+6wIXtwpAoiT7f/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V56a/UkDnV0Q5RR/XdsyCikMwq8Ik/Ay4BaJxBQvRqkcBDcPuo9Bgcqm4Pw0ivSR1
	 JovanZsDfaNN6/PXsCsQ6bN2K8QzCfD0FXYpqnfjRzLjPKQtcPTHh+UOl3yCXchzOU
	 bMfi1NXgJKXuQ9IDeXU60KtZqU4QU2alKEWNjXdrhpXbKn+lPxAJUQ6Bel/GL2vlSG
	 wuTDb23yxTZ0rGdthaMvqDvyRc2ZcBTzGx2hLRcFFKAWNEYWpB0c25uwutvj4bAOH5
	 KLYBHW+pyOOmmGFF7lXdo+qma8yUKujAOk/99k6qLkjTNKysAobjceBkfWpUccm9+o
	 NumYrAN4iKnXQ==
Message-ID: <sashiko-outbox-213584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] kbuild: add "make tools_build" to build
 userspace tools from tools/
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Cc: "Shuah Khan" <shuah@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Andrew Morton" <akpm@linux-foundation.org>, "Thorsten
 Leemhuis" <linux@leemhuis.info>
In-Reply-To: <20261112195427.3411746-3-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
 <20261112195427.3411746-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:55:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] kbuild: USERLDFLAGS in LDFLAGS is ignored when building
  tools/dma
--

commit d48c343f29bb15ff9a8fc256221e365cbc49ffb2
Author: Sasha Levin <sashal@kernel.org>

kbuild: add "make tools_build" to build userspace tools from tools/

This commit adds a CONFIG_TOOLS_BUILD menu and a tools_build make target
to build selected userspace programs under tools/ into tools-build/ in
the object tree.

> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
> new file mode 100644
> index 0000000000000..7a26e7c3d5769
> --- /dev/null
> +++ b/tools/Makefile.kbuild

[ ... ]

> +# The compiler CONFIG_CC_CAN_LINK was tested with. The tools take linker
> +# flags from LDFLAGS.
> +tools-cc :=3D $(CC) $(USERCFLAGS) $(KBUILD_USERABI)
> +ifneq ($(USERLDFLAGS),)
> +override LDFLAGS :=3D $(USERLDFLAGS)
> +export LDFLAGS
> +endif

[ ... ]

> +tools-$(CONFIG_TOOLS_BUILD_DMA)		+=3D dma

[Severity: Low]
Does building tools/dma drop USERLDFLAGS?

tools/Makefile.kbuild passes USERLDFLAGS only through LDFLAGS, but
tools/dma/Makefile compiles and links dma_map_benchmark in one step
without referencing $(LDFLAGS):

tools/dma/Makefile:
	$(OUTPUT)$(DMA_MAP_BENCHMARK): prepare FORCE
		$(CC) $(CFLAGS) $(DMA_MAP_BENCHMARK).c -o $@

When USERLDFLAGS is needed to link target userspace binaries (such as
--sysroot or -fuse-ld=3Dlld validated by CONFIG_CC_CAN_LINK), building
tools/dma with CONFIG_TOOLS_BUILD_DMA=3Dy will ignore those flags and can
fail to link.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112195427.3411=
746-1-sashal@kernel.org?part=3D2
