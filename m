Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FB275AFD
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967900; cv=none; b=D4lwWM3z1am6Yf/lrUFANg0ni7VgFJRfziDWMfX1fCCrp954TlYzGB2dO04jFvl8V3cFXxclt9aO+2fSzsiPkTX8Cyf0SksZwSVgJQK8/p/R6+6tBlkJd3DooC9N3o17KWwlXssPhA/Pa6c5zmba3DJx+4D7h9Pd0GscmNK5abc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967900; c=relaxed/simple;
	bh=GfdD7ZZWNDRX6Xla/H1jsF8nBOuiRb2FuNtuUhwQy5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZqnJ+uDhjoVo4Mc7a9eJPJeEta7ib2ulo5oGez1vxEJ00sAgoPQPbLDMbbmfHin+ykx9R1zPnIVNcOl+C/I3hro38+q5/w7AHqw8Fg9PHyYNY0fowSErly79iFvTSqOgxQE8Gyq6uS+6Oo9b+5TdfkWI0ckzIPgXBYy0Xo34JcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMycmAmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMycmAmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAEB1F00899;
	Tue,  9 Jun 2026 01:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967899;
	bh=HTViNwkt8WLXmAvel8z2/RqnFCHRgCuyfOVxxNhk32Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMycmAmVLzLWORcJPC1RgW3E3YG0E30Ut2pgEyJrduqQo7Z0tb2abVrlNzpUzp9HG
	 OMbFsSASqqwdkxo8m0TmAxLOPcc7a2gx3wUOTPSnEgi2cE9yc/kyCjqVkSFTDP8HaL
	 8htvViVICIuaPe5ApABRNqQxlIoLYO59M0L6TRE8LmxzKXDHRzE432Uvu8Guk8Mj82
	 8DiXLj16psKqYWYGPuYqPUtiKMLyeAIYFNPwFeqBBkj9jhFPP8XnT4OeZpP0WrmH4o
	 NNM0wq4jR5vAdDPxKqnO/q2IfUGXT9GLD1+u1gU7EYWbq+oiqMAGaJpM0W93b5QGr1
	 R64U10wyWif1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] perf sched: Fix idle-hist callchain display using
 wrong rb_first variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609010526.1998472-7-acme@kernel.org>
References: <20260609010526.1998472-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:18:18 +0000
Message-Id: <20260609011819.3FAEB1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `perf sched map`, using the `--color-pids` option causes a segm=
entation fault and an invalid free due to type confusion on `thread__priv()=
`.
--

commit 52b25a8ed38e1c2d458f164827bbcfd55e08f69b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Fix idle-hist callchain display using wrong rb_first variant

This commit fixes a bug in the idle-hist callchain display where
rb_first_cached() was used on a tree populated with rb_insert_color(). The
tree lacks the leftmost cache, so rb_first_cached() returned NULL and dropp=
ed
the callchain summary. The fix restores the original behavior by using
rb_first() directly on the rb_root.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index ded511d851880..85f11d388392d 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3130,7 +3130,8 @@ static size_t timehist_print_idlehist_callchain(str=
uct rb_root_cached *root)
>  	size_t ret =3D 0;
>  	FILE *fp =3D stdout;
>  	struct callchain_node *chain;
> -	struct rb_node *rb_node =3D rb_first_cached(root);
> +	/* sort() uses rb_insert_color() on rb_root, not rb_root_cached */
> +	struct rb_node *rb_node =3D rb_first(&root->rb_root);

[Severity: High]
This isn't a bug introduced by this patch, but does the --color-pids
option in perf sched map cause a segmentation fault and invalid free
due to type confusion on thread__priv()?

When --color-pids is used, map__findnew_thread() sets
thread__priv(thread) to the scalar value (void*)1 to mark the thread
for coloring:

tools/perf/builtin-sched.c:map__findnew_thread() {
    ...
    if (thread_map__has(sched->map.color_pids, tid))
        color =3D true;

    thread__set_priv(thread, color ? ((void*)1) : NULL);
    ...
}

However, the rest of the perf sched code expects thread__priv() to
hold a valid pointer to a struct thread_runtime. When
map_switch_event() calls thread__get_runtime(), it retrieves the
(void*)1 pointer and skips initialization because it is not NULL:

tools/perf/builtin-sched.c:thread__get_runtime() {
    ...
    tr =3D thread__priv(thread);
    if (tr =3D=3D NULL) {
        tr =3D thread__init_runtime(thread);
    ...
}

Then map_switch_event() attempts to read tr->shortname[0], which
dereferences the invalid address and causes an immediate segmentation
fault:

tools/perf/builtin-sched.c:map_switch_event() {
    ...
    tr =3D thread__get_runtime(sched_in);
    if (tr =3D=3D NULL)
        goto out;
    ...
    if (!tr->shortname[0]) {
    ...
}

Furthermore, because cmd_sched() registers free() as the destructor
for thread priv data:

tools/perf/builtin-sched.c:cmd_sched() {
    ...
    thread__set_priv_destructor(free);
    ...
}

Tearing down the session will attempt to call free((void*)1),
corrupting the heap.

Could struct thread_runtime be expanded to include a coloring flag,
or could the color state be tracked outside the thread__priv pointer
to prevent this type confusion?

> =20
>  	printf("  %16s  %8s  %s\n", "Idle time (msec)", "Count", "Callchains");
>  	printf("  %.16s  %.8s  %.50s\n", graph_dotted_line, graph_dotted_line,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609010526.1998=
472-1-acme@kernel.org?part=3D6
