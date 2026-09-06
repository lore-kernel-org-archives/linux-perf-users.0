Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7537FF75;
	Sun,  6 Sep 2026 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788726207; cv=none; b=hmPpw7N1lMUwyJLzu85pJYypX1MwHs/MHXSSdGCg2M93ed6PWlo7k3JoVSxXSald1NFDxS/eunOKBtwHLaJuYiRFtJXnSeOMxgbaEto2DX7uznxlfndscDhDVw5+YfURFO2JucLL4cELrBavZeKA0TqKqeY8UJxzt67U3uW1OnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788726207; c=relaxed/simple;
	bh=K8KjHxmM9knZLD52ok2FqfLL7JZA89zsZmMNATsb8xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IIgOJfoh4g/EK0LENBv9oWPYwfRQb31lJK4KGqnJnyfFYIyQqvDXyLSPa1cc+uMExLiC+gipq1KRNHFU8b3y9kP1r7O9onWgmeDejco8977ufbN100Sbt+jkbqCsoKXaISK1K7Cg1+zlrgUaE6ZfSzR67fde1b2pxHC+OuYwDYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBA53sQz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBA53sQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6791F00A3A;
	Sun,  6 Sep 2026 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788726206;
	bh=K8KjHxmM9knZLD52ok2FqfLL7JZA89zsZmMNATsb8xc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fBA53sQzHkt3olgsEE0eU31IdMG3m7E3Uu/lvTeW2lx84fpERld/Ecmda9yAV6rB1
	 lzBBVwKvDPwkuSmPM0QPWTJgmatu+PC/BEnTXifTUYeDm/J4iXz0jC6dR1oFs0Ir61
	 TjNsBPknBp34NSCIQeUrUXhQiBZSgsXjAAshxXfzCB1vBeGvpUqnQ70VEvWPx0GwhY
	 5oLuOKJs67/wSWWqnvnCbGSel72+/WFUL2yiQeEgCHpX521pVrGxx5Ci05awL8XAk1
	 QCV0Y1evoIc5oerEwNvGcHm2Kekwze3p/R63K9ZK3OGaYIZ6QTk/GwYtmg0nZJXe1O
	 iMNoh8t/VUkaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] perf tools: make the GTK4 report browser
 actually loadable at runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v7-2-1ece839fbca0@gmail.com>
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
 <20260906-perf-gtk2-v7-2-1ece839fbca0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 20:23:25 +0000
Message-Id: <20260906202325.EB6791F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v7-0-1ece839fbca0@gmail.com?part=3D2

