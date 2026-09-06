Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F143B28D;
	Sun,  6 Sep 2026 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721592; cv=none; b=QkOuPsr5AdfgtQM6+DbYRkwGf4qOkulrEU6NM+4DaBqB2GrTwnEM+81DmUFfvXo2fuxwZLvl8/U/GGz4LErtK48+R/gPSh2P1bCDgbR6FUkFGT/xhXsoC+EezfopjCNKgzuexTkaz7jNq+ug7TnrtjGsYc/GJZtaVu4AoM6aHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721592; c=relaxed/simple;
	bh=3scrYNJXVO/VviqGwzKEMpYo3fvJrjZ4cnc5eMb1BXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JmeCjdYR+TE6hKb1TsmbVtem+ZtMFmdev+3AsieR2avTDwfk/01Uda2gq9/lcII+Q2cpZHLHfRuKSJQvawx4y1yVeUSyoW0mppUpGVNDWEUDF59bDecz8fd0si+7+bA+/3RRdOMQJGIIzKx7ooapddIFMzlNtp1XOsLVA2LbWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owrNOHWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owrNOHWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC681F00A3A;
	Sun,  6 Sep 2026 19:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788721591;
	bh=3scrYNJXVO/VviqGwzKEMpYo3fvJrjZ4cnc5eMb1BXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owrNOHWCg2CpDyRrwJbuph+8W+JIBZu1R12w0XC4mhNOrVEJ0/JcFnEumz7/wvOyX
	 2I/5KW7kmO6qJK6H8m97m/2z+UH7thzRPviZHgJqCvDcdv9KFVfvv3xGHWXgRINRQa
	 hSbuCwMEZJXNHl8Pfh6mH4lyN6yMbEBxvF6aNi29avDJxjUozTfRNHOSQNXIagB8i+
	 FGLHwhZ0+LkoWvf7gZePRk9Tf4alG2CKeKBb4NWh27jq8J2ERYVA3oD9MDOp3A/sdW
	 TTxKlkUvJk2qT+mSXDTR1Ox5D9hi5Grc8g86DnQtigK0mBgo0yhBverLNGc13PbA+m
	 ZGRyuVxPrWxDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf tools: make the GTK4 report browser
 actually loadable at runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v6-2-695d1c01aaa1@gmail.com>
References: <20260906-perf-gtk2-v6-0-695d1c01aaa1@gmail.com>
 <20260906-perf-gtk2-v6-2-695d1c01aaa1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 19:06:30 +0000
Message-Id: <20260906190630.DEC681F00A3A@smtp.kernel.org>
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
v6-0-695d1c01aaa1@gmail.com?part=3D2

