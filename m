Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351332;
	b=tJGuuJ06o7xtEnybyRymHAq8GE0ZSakTnb0EIjQiJaHSuudmbGBeIWHeWL/Jc0j6eiOq
	 Vb7WTR/rd+35lNEzNDLIrlIsZ3aidLZXOcJrip0/G5oK20/TFVc93SH7+WRiLJZ+VMh8q
	 LKprd+4UjAP5mCENcUYAU8dFYTsTLSHfKyKQHeMsvxwrHRydylMZqImtK/JnSTiAtJDRP
	 5yCODRLJiLY/2Jh+jfT3J0m0+RVxj3wyLg6yLGe3nCSyZI/ew7AR0XLjbMbpn75kW1wsC
	 994v/8uaNIfTkJqlo7FP3QQcEBIs2xkHapJH/rgCKGXEUVFU74GskQbiAfj0m+1/NpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AH0+UgvRlp8oFe7vYOdHWnbaS0gZDt2+/5F9ysfItXM=;
	b=yD/r07GCoPykVUuxFgt5S7blicr7aXf52RFEyrb/ECN8NendSl3qMiqszxWH2uxayAMg
	 MMX0meM+12e42LkwMixrq7dXHVKc396Lf2TJmc9D2rhTMMMPE/fgEe3VK96PwbWE8fdcY
	 sw+h1TUvrOlmnISD3ctDiZcPYu7M/L/JWhPaSflkhUf6BOBKMaV1YwBeZS3XkAWOlIc+5
	 hZXQ2K+SnhpAUnN76W8B70fCE7nvGlP3dlYB/QVFIgktWYnxuVBE7/VghE4V+jYcRiPCn
	 mMh11cizr9ohUQ6yDw/ey6PKvZLldNSczfkFL1H8VFUQIFpAB7qyMku3k4iMlcHPx7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YA4QIle6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339DE606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YA4QIle6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7911F0093C;
	Tue, 10 Nov 2026 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351331;
	bh=AH0+UgvRlp8oFe7vYOdHWnbaS0gZDt2+/5F9ysfItXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YA4QIle6KSrdS+wuxOuuSwRJ3IVAGZFOTGacV/+hiNcTN6nU8zlr7W/TIa4gyYGQ6
	 gnTsdFnk9hT1TEhxyeXSUJTW27aZgAmFM+0ZoqZbZJzh3XQUD1cD5eNPFIbWUUOo1N
	 UN/9+u7Jcje6sT4HiKz1BvjrqVT303ZNUHzkEPvBnl+3fOItqw/nDZQCmOx/lCwSFE
	 i7/iC98tlOoEbNf5tmzWfmr+v1W/wT+G3wcDuzYG5EfE3YzlRHeC8vYQAEEd0O9yYt
	 2FLCpiiFlx1vEL25/b+k1YJE0kRobEnoyyEwbuoPwhwQUP+LgdNm+h+VzPglprBvAK
	 uYvCZkB7/yn3Q==
Message-ID: <sashiko-outbox-207851@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/20] perf symbol: Use session allocation wrappers
 in symbol, DSO, thread, and hist paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-20-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:55:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf machine: NULL deref in __machine__findnew_thread() on
  thread OOM
- [Low] perf symbol: NULL session for split kernel DSOs in
  maps__split_kallsyms()
--

commit ae77bbd4b11902101ad3db4f72bc23f1b4972f1f
Author: Ian Rogers <irogers@google.com>

perf symbol: Use session allocation wrappers in symbol, DSO, thread, and hi=
st paths

This commit wires session-scoped allocation wrappers and shrink-and-retry
handling into symbol, DSO, thread, and hist_entry allocation paths.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index c89f47ba16f2c..489395b53c2e3 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c

[ ... ]

> @@ -598,7 +599,12 @@ static struct thread *__machine__findnew_thread(stru=
ct machine *machine,
> =20
>  struct thread *machine__findnew_thread(struct machine *machine, pid_t pi=
d, pid_t tid)
>  {
> -	return __machine__findnew_thread(machine, pid, tid, /*create=3D*/true);
> +	struct thread *th =3D __machine__findnew_thread(machine, pid, tid, /*cr=
eate=3D*/true);
> +
> +	if (!th && perf_session__shrink(machine__session(machine)) > 0)
> +		th =3D __machine__findnew_thread(machine, pid, tid, /*create=3D*/true);
> +
> +	return th;
>  }

[Severity: Medium]
Can __machine__findnew_thread() dereference a NULL th before returning to
this retry path when thread allocation fails?

When threads__findnew() fails to allocate a thread, it returns NULL with
created =3D=3D false:

tools/perf/util/machine.c:__machine__findnew_thread() {
    ...
	th =3D threads__findnew(&machine->threads, pid, tid, &created);
	if (created) {
		if (thread__init_maps(th, machine)) {
			pr_err("Thread init failed thread %d\n", pid);
			threads__remove(&machine->threads, th);
			thread__put(th);
			return NULL;
		}
	} else
		machine__update_thread_pid(machine, th, pid);
    ...
}

The else branch then calls machine__update_thread_pid(machine, NULL, pid),
which immediately dereferences th in thread__pid(th) instead of returning
NULL so machine__findnew_thread() can shrink the session and retry.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9d7c87bcbbea8..21f012252dcd5 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c

[ ... ]

> @@ -1717,7 +1727,8 @@ static int maps__split_kallsyms(struct maps *kmaps,=
 struct dso *dso, u64 delta,
>  		if (!RC_CHK_EQUAL(curr_map, initial_map)) {
>  			struct dso *curr_map_dso =3D map__dso(curr_map);
> =20
> -			if (symbols__insert(dso__symbols(curr_map_dso), pos) =3D=3D 0)
> +			if (symbols__insert_session(dso__symbols(curr_map_dso), pos,
> +						    dso__session(curr_map_dso)) =3D=3D 0)
>  				++moved;
>  		} else {
>  			old_symbols[write_idx++] =3D pos;

[Severity: Low]
Does dso__session(curr_map_dso) return NULL for split kernel range DSOs
created earlier in maps__split_kallsyms()?

When a non-module kernel symbol falls outside initial_map, ndso is created
with dso__new(dso_name) and inserted into kmaps via map__new2(), but it is
never added to machine->dsos.  Because ndso->dsos remains NULL,
dso__session(curr_map_dso) evaluates to NULL and symbol array growth for
those maps bypasses perf_session__shrink(); passing dso__session(dso)
would preserve the session.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D19
