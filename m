Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA83345EA6
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 03:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922885; cv=none; b=WIqYd64hGHfAjB2TEI6X/cc2204IBTYcEB+mXVz9+5wejEmZzqlbWoMc56oi5hy5WvGdo5uLmt+uY35df45HCO1tzCn6ggbzgu+vOsiaKbQ1Nm1uaJ9GLFYxV+NOOIIS3M4/pxmB4ek/AGHhNjcAcYe3y04TGil9IzVg5X1JXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922885; c=relaxed/simple;
	bh=WSWeQEUS4HdId/PVru1pckf+Sx9qq7G0WjKTsz2eR7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lF6O8LAYUypxu3urZEcWtzmbcoqlIMQ3ZP3orXgtQ1F6dMx5w5a8GXPHnpOag8Y7AABpqeR5icN82UKCTYG8ZFxLu2cvX3QBuCjdqLsO5XaQqDZICJZbbpTswjjRAu3bIO6GYvzE64uvZG9w92J3uukKE/yF6P1CjO2xwsyLwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjNzYcpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjNzYcpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204B41F00A3A;
	Wed,  9 Sep 2026 03:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788922882;
	bh=WSWeQEUS4HdId/PVru1pckf+Sx9qq7G0WjKTsz2eR7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjNzYcpJ+by46r7UrePXt+ANkLUaqRSU1GofYk8W/WWO4OjehWiXaSbomjZ3fR0GF
	 YaInkDc47tqMq/VibP0KbFBlun+stgjZyVafm/t1i7DXMLTnxWXFchExSCrN5/Eu11
	 lHwTGJAdO9BaLQ8IETOClvUCi6cJHqKrki4uQjyxP+Yzk4rMrs/ofk+r6dAtzPDh4j
	 xeb5TZ5VR0kAs6Bl0rofGjcmTGZtSvougVgvYSKwSpUEeI4IxySKdy2kdbzNULhInv
	 Y3AU69Up2g1ooJ9ERm/8zlb7cf7BBlVZ32Rjzy8KkbT5oOHwIRQpqymGnWPOZfe2AO
	 Y3BFuC3U4IxuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] perf tools: make the GTK4 report browser
 actually loadable at runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260908-perf-gtk2-v8-2-e90d5d155f0d@gmail.com>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
 <20260908-perf-gtk2-v8-2-e90d5d155f0d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 03:01:21 +0000
Message-Id: <20260909030122.204B41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf report --gtk dlopen()s libperf-gtk.so, which expects to resolve
> symbols back against the running perf binary (callchain_param,
> symbol_conf, evsel__name, and friends live in perf, not the plugin).
> Two things broke that after the GTK 4 port:
>=20
> perf never passed -rdynamic, so none of its symbols were in its
> dynamic symbol table for a dlopen()ed plugin to find. Add -rdynamic to
> LDFLAGS when GTK4 support is enabled.
>=20
> annotated_source__hist_entry() was a static inline in annotate.h, so
> ui/gtk/annotate.c calling it pulled hashmap__find()'s expansion,
> hashmap_find(), into libperf-gtk.so as an undefined symbol. The only
> hashmap_find perf links against normally is libbpf's internal one
> (tools/lib/bpf/hashmap.c), built with -fvisibility=3Dhidden, so it can
> never be exported to a dlopen()ed plugin regardless of LDFLAGS. Move
> annotated_source__hist_entry() into annotate.c as an ordinary exported
> function, so the plugin depends on it the same way it already depends
> on evsel__group_desc() and friends.
>=20
> With both fixes, a default 'make GTK4=3D1' build (libbpf statically
> linked) can dlopen() libperf-gtk.so and open the report browser without
> NO_LIBBPF=3D1 or manual LDFLAGS. Verified with perf report --gtk against
> real perf.data on a GTK4 desktop.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-perf-gtk2-=
v8-0-e90d5d155f0d@gmail.com?part=3D2

