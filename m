Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B54CCDE5;
	Sun,  6 Sep 2026 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707493; cv=none; b=CknFV/RNhvK2miLcjVHA5BJh4uKpqW+atoMprkBroxnVdXiS6gxF7Jg/o3zrINywWYDiFAvrzbFID/OxDFKiMxQ9XMStWGARRYEmcvQ22iHYiws8vkt3kOkCz23tMd9M92p3nkeSD31fZMDFLh8cAGrBsFY0Biu/MlRKEIqfLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707493; c=relaxed/simple;
	bh=ovpXhmzquV0SlWMDnqHvH5ZWMXne9slaWf4KPfqtihI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bnx1bHWshGyILk+82MRu1XtJLEpfSzcHLUM5tINQfENNZDvu1RiIIOHAXgwvGUNw/YySPa9o2xaH9mpknCyJVBsL4HGlIxBX6IipRO+NTfbT4KEC96cyyFATSPF0lYjeow/nz1mLyfH06MNSIqfOhtOaBPgtFEo3puhIDgnavew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL1ev6Zz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL1ev6Zz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B09D1F00A3A;
	Sun,  6 Sep 2026 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788707492;
	bh=ovpXhmzquV0SlWMDnqHvH5ZWMXne9slaWf4KPfqtihI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fL1ev6Zzn7eYNz/gMeOnp7dh2e5s8/XMEvJ1YL34j2WglHXIylboUJ7HIIJnsQdSB
	 A2WqiosZN+Sm7MOxA/uwU9ZDvX6IMn36U680GhTojpBldZG9g4j+5P5NGsv8qy/8bh
	 PsEVXWQqFTUk1Cn8Bsg4ewcN4bjwMLA8DPX23Y2lYf+m+9z9idazWcT8D8lFSeMCRS
	 /ICdIQ+p2b3r/yBjRaCD7Py1xFU7vQDBeSw6DDr7okBQet+FUz4jzyE/+Ai9kqgSPp
	 x0sEuMgCNiA52fbzYtlp3+ml+ijVY0fZoi7C163IPdkscfl3DFOhHHViGCIt4mmtFK
	 y1NXv4B4aOeDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf tools: make the GTK4 report browser
 actually loadable at runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v2-2-3eccff053cd1@gmail.com>
References: <20260906-perf-gtk2-v2-0-3eccff053cd1@gmail.com>
 <20260906-perf-gtk2-v2-2-3eccff053cd1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 15:11:31 +0000
Message-Id: <20260906151132.0B09D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf report --gtk dlopen()s libperf-gtk.so and expects it to resolve
> symbols back against the running perf binary (callchain_param,
> symbol_conf, evsel__name, and friends all live in perf itself, not in
> the plugin). Two things stood in the way of that after the GTK 2 to GTK
> 4 port:
>=20
> perf never passed -rdynamic, so none of its own symbols were in its
> dynamic symbol table for a dlopen()ed plugin to find at all. Add
> -rdynamic to LDFLAGS when GTK4 support is enabled.
>=20
> annotated_source__hist_entry() was a static inline in annotate.h, so
> ui/gtk/annotate.c calling it pulled hashmap__find()'s expansion,
> hashmap_find(), directly into libperf-gtk.so as an undefined symbol. The
> only hashmap_find perf links against in the common case is libbpf's
> internal one (tools/lib/bpf/hashmap.c), which libbpf compiles with
> -fvisibility=3Dhidden; a hidden symbol can never be exported to a
> dlopen()ed plugin no matter what LDFLAGS perf itself gets. Move
> annotated_source__hist_entry() out of the header and into annotate.c, as
> an ordinary exported function, so the plugin depends on it the same way
> it already depends on evsel__group_desc() and friends, instead of
> reaching for hashmap_find directly.
>=20
> With both fixes, a default 'make GTK4=3D1' build (libbpf statically
> linked, as usual) can dlopen() libperf-gtk.so and open the report
> browser without needing NO_LIBBPF=3D1 or manual LDFLAGS. Verified with
> perf report --gtk against a real perf.data on an actual GTK4 desktop
> session.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v2-0-3eccff053cd1@gmail.com?part=3D2

