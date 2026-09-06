Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF03BB12B;
	Sun,  6 Sep 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715622; cv=none; b=jUJJhGXWPDLRovAoD+BVxJN9kVYVDbGAFGMDM938IXG3QwwL69G5FWRQ47E6I0lNvZUtwWcDug9RCl+XJTVnNpPkjqVDvnXBuuy7cQFCwPJDHA5n5T+jRUWOZFTSVOYLh28wrJTp2UZ79opuP69M79RgCIjpLWr+HMz6FO5FkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715622; c=relaxed/simple;
	bh=aNSJwZJhkRy0HLv4pno1HHbISmY060lBslnSlJ+A1G8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DTQ+vqCPsHo/LY6dA6LlYQN88+a7Ca2RWU5ya/LuFJmtwg4QtMtcwGZJTh5pS1gjjnxV1kdmt/GDQDmkEML15dCfNX/XKDiVYrRMRZxzI0K2WQr16Sx6qpJ/1K+DtWP8ZXMbWqlX9AofDq4J412+GRlzfWoQrqFXS8gng2xAWNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTpEaWLU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTpEaWLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3211F00A3A;
	Sun,  6 Sep 2026 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715621;
	bh=aNSJwZJhkRy0HLv4pno1HHbISmY060lBslnSlJ+A1G8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LTpEaWLUB6hfeOAJYYtEJCvtgpaPUqVoJ+IoskgyjGtKQTcyRBkFQ970wkWBKTqSx
	 uLU8b2AYTXyFCuQLMy8bnwSjikT1ooQwjqg+mLE8nURu+M6rR5N57fnN78EcnEMmLr
	 LSo9WIeKg5nDe2bepeMudrtE0+F/paD50owxJIphBuQAgOo7ga8RtbfzUbdT6TNs9u
	 wuKXQgdFPT7ZSRTGjP6NQTi9qnaN9ubfSzjkM1F1l1IPEa9Cw7Zlhd6huQ4peKJbAT
	 lXwRZ+dc0IQAeFttfubcS1qtHOlHXXpbn+jInOlCWGqiD0KXpJ0BjttZnucqNTe69Z
	 4mi7NaOW8xWFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] perf tools: make the GTK4 report browser
 actually loadable at runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v4-2-97e92ee07214@gmail.com>
References: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
 <20260906-perf-gtk2-v4-2-97e92ee07214@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 17:27:00 +0000
Message-Id: <20260906172700.BB3211F00A3A@smtp.kernel.org>
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
v4-0-97e92ee07214@gmail.com?part=3D2

