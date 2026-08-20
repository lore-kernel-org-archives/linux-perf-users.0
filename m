Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBEC440632
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257065; cv=none; b=OSVUiHF6NqtiY+G3/xofZVIPeUieeu6KouKPQQzk6dPFuqd81ByCxcaqxfHA9rQanLsnbeV4fXx29w4BcczF04Ch826aORwOc8LWdD/3nJqW2Lakd6ZZqB3o52bPC2cjHAog1IJMmaQR5eHBvwoO3wn56YMjKQ2wCzwByLc77KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257065; c=relaxed/simple;
	bh=4hIAiB3FVe1e7YRlElfxuprGarzY5GbUns+IVa1Hjs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=snkDukFkIgkCiTZhofY9mrOcNuLhFVp2AmClDJx+fPzVelKxr/Yz/YDWYEUGQXZKTwYEW5Uv2SbONRhkAL6u8kmKeNn4Ryp3Z8SRGbRJfK8ZPMrkjttBelqPjhH+I3y/zRwf1QIJuaMa7Q6u/8Nf+zyJMj+mRJL6y62imhIUq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB4pLQ1m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB4pLQ1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB45A1F000E9;
	Thu, 20 Aug 2026 20:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257064;
	bh=aeLmLGcWMXxvbzBySunm66hdZK503xW5N1oofuq41kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jB4pLQ1my349Eh27+zzwUOuEF9XaAQi7XwVjUcKzxv8ZSNhdpBtI9/o5Gi0ugDjti
	 gSJ8/1HHM/1A82LRM9+Xd4pj6JdUrPUWh6qrP5CG2SvfhzpuV759jF+U7ioBD7MuCO
	 q7aVtXukvjGfaTLOKA+73xzvG5l33N5M3P9L04wrALHPyVCnzvfT8J8dl1EQAJf6Gj
	 1xiaqxKl9uQhfAkNNPUfCL/I16DQcFFyVQlb+skANV0QpVITSVdyjwTH97ZsZ/EXCh
	 7FJevcrccd55XoemVwjqTVWFMuAYtZgtjUQLC4FKgpj4u4oIU6zpB7lTmfPYGiBE/f
	 S6sc5A6qEJ3dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf record: Fix unhandled POLLHUP on non_perf_event
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260820200214.2865570-1-irogers@google.com>
References: <20260820164937.2734066-1-irogers@google.com>
 <20260820200214.2865570-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 20:17:43 +0000
Message-Id: <20260820201743.DB45A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch fails to fix the `-EINVAL` pollfd mismatch abort and int=
roduces dead code because it relies on an invalid assumption about `fdarray=
__filter()`.
- [Medium] The newly added unit test `test__fdarray__filter` asserts an inc=
orrect invariant about `fdarray__filter()`, causing deterministic test fail=
ure.
--

--- Patch [1]: [PATCH v7] perf record: Fix unhandled POLLHUP on non_perf_ev=
ent descriptors ---
commit c8946dae2d12736f0f97f47367d99aaa40d80c15
Author: Ian Rogers <irogers@google.com>
Subject: perf record: Fix unhandled POLLHUP on non_perf_event descriptors

This commit attempts to fix an abort during perf record teardown caused by
index mismatches between a thread's localized poll array and the core evlist
poll array when handling POLLHUP. It propagates the finalized -1 state from
the core evlist back to the thread's local array before the equivalence che=
ck.
It also adds a unit test to verify that fdarray__filter preserves nonfilter=
able
items.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e915390556752..1ddf3ad2808df 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1180,6 +1180,21 @@ static int record__update_evlist_pollfd_from_threa=
d(struct record *rec,
>  		int e_pos =3D rec->index_map[i].evlist_pollfd_index;
>  		int t_pos =3D rec->index_map[i].thread_pollfd_index;
> =20
> +		if (e_entries[e_pos].fd =3D=3D -1 || e_entries[e_pos].events =3D=3D 0)=
 {
> +			/*
> +			 * If the control file descriptor was closed, then evlist__ctlfd_proc=
ess()
> +			 * will have called evlist__finalize_ctlfd() on the PREVIOUS loop ite=
ration
> +			 * to cleanly set the core evlist's e_entries[e_pos].fd to -1.
> +			 *
> +			 * Since nonfilterable items are skipped by fdarray__filter(), the
> +			 * thread's local t_entries[t_pos] retains its original state.
> +			 * We must explicitly propagate the finalized -1 state to t_entries
> +			 * BEFORE evaluating the strict equivalence check below.
> +			 */
> +			t_entries[t_pos].fd =3D -1;
> +			t_entries[t_pos].events =3D 0;
> +		}
> +
>  		if (e_entries[e_pos].fd !=3D t_entries[t_pos].fd ||
>  		    e_entries[e_pos].events !=3D t_entries[t_pos].events) {
>  			pr_err("Thread and evlist pollfd index mismatch\n");

[Severity: High]
Does this fix actually resolve the mismatch? A POLLHUP event on the control
descriptor causes fdarray__filter to unconditionally clear t_entries[t_pos]=
.events
to 0.

Since e_entries has not yet been processed by evlist__ctlfd_process, its ev=
ents
is still POLLIN. This means the e_entries condition evaluates to false, mak=
ing
the new block dead code.

Consequently, the strict equivalence check below evaluates to true (POLLIN =
!=3D 0),
causing the function to abort with -EINVAL.

> diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
> index 40983c3574b12..23860edb8ef09 100644
> --- a/tools/perf/tests/fdarray.c
> +++ b/tools/perf/tests/fdarray.c
> @@ -80,6 +80,38 @@ static int test__fdarray__filter(struct test_suite *te=
st __maybe_unused, int sub
>  		goto out_delete;
>  	}
> =20
> +	fdarray__init_revents(fda, POLLHUP);
> +	fda->priv[2].flags =3D fdarray_flag__nonfilterable;
> +
> +	pr_debug("\nfiltering all but fda->entries[2] (nonfilterable):");
> +	fdarray__fprintf_prefix(fda, "before", stderr);
> +
> +	/*
> +	 * Note: fdarray__filter() in tools/lib/api/fd/array.c evaluates the
> +	 * fdarray_flag__nonfilterable flag at the very top of its loop via an
> +	 * early continue. Therefore, it completely skips all processing for th=
is
> +	 * descriptor, guaranteeing its fd, events, and revents fields remain
> +	 * entirely untouched by the filter mask evaluation below it.
> +	 */
> +	nr_fds =3D fdarray__filter(fda, POLLHUP, NULL, NULL);
> +	fdarray__fprintf_prefix(fda, " after", stderr);
> +
> +	if (nr_fds !=3D 0) {
> +		pr_debug("\nfdarray__filter()=3D%d !=3D 0, should be 0\n",
> +			 nr_fds);
> +		goto out_delete;
> +	}
> +	if (fda->entries[2].fd =3D=3D -1) {
> +		pr_debug("\nfdarray__filter() illegally modified nonfilterable fd!");
> +		goto out_delete;
> +	}
> +	if (fda->entries[2].revents !=3D POLLHUP) {
> +		pr_debug("\nfdarray__filter() illegally modified nonfilterable revents=
!");

[Severity: Medium]
Will this test pass? The fdarray__filter function in tools/lib/api/fd/array=
.c
actively clears events and revents prior to checking the nonfilterable flag:

if (fda->entries[fd].revents & revents) {
	...
	fda->entries[fd].revents =3D fda->entries[fd].events =3D 0;
	continue;
}

if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))

This implementation contradicts the test's assumption that the fields remain
untouched, causing the fda->entries[2].revents !=3D POLLHUP assertion to
deterministically fail.

> +		goto out_delete;
> +	}
> +
> +	fda->priv[2].flags =3D 0; /* reset flags */
> +
>  	pr_debug("\n");
> =20
>  	err =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820200214.2865=
570-1-irogers@google.com?part=3D1
