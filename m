Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C0A358373
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245223; cv=none; b=sQXz5Xco8uV4FbzcehhmOWekzgUM89iyuXGGNVY5KJO8Lv1A8brkwNg4thFPBNlRVuLjTrgvn2fM1lhTreHm1HF0+sBHxT/g0SfY9oORjfdK51K7je+ozgulqse5HL2pwt8/sE5xOzbXqSR8x9aHFOdTlcj09XcEq8h7euOR0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245223; c=relaxed/simple;
	bh=lY+gW9CX7a4UzgtmaEBTiNjqZJBTfWITIhL5GVe6elo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pHTnBX3mwHYHo1cZPCdtoyBjeVO88nzXERlggk0hB83a0dEsMLriiYoe0olHJbGDKYv2PEfTR05aq/kLedKiyVG5aFSD5R2U/WYwW726ZBfJtDQUdva7Fi4crYE2uAiDyAEfmY+7h5N7tAmoQMGewq2tf0Na0kGrH660p5VBFNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAC9mpPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAC9mpPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151081F000E9;
	Thu, 20 Aug 2026 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787245222;
	bh=xbD/tZlE2H5AfffB1MbyHDQwVvPZNdyvXZHWR/z7Dck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EAC9mpPCrkhAcr0jIOmxD9n3/bxcIvHUCRytzvg4uPxSkJjLAJjB5zTSP98/SHLW9
	 qjiL2juLX0LTdan0STfI40kZ202xIjg3Mrb1aIGlMkrje2SVT9EEu+qeWu771ZubQA
	 cWPeFmlTC7LgzzF0kbLGBIR2giiR0HOt3EgnmrPWlt8AtI+OGp+/RaCRwC+w93VnEl
	 /X8+NzmbWUqHc3dg8vNr9lvwHuYfBPOdZOyRtI6GSZ0tQZUZcHKDVewpZZ9v69J+M4
	 I6g5sgXrdQqjNYkWvLWrYJkDaG2UaXbF5Ib4sNd9THMSXpG9D0rNRo8dr5lSc0P+jm
	 GSQ/rJ+GgEEmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] perf record: Fix unhandled POLLHUP on non_perf_event
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260820164937.2734066-1-irogers@google.com>
References: <20260818003101.520874-1-irogers@google.com>
 <20260820164937.2734066-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 17:00:21 +0000
Message-Id: <20260820170022.151081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The synchronization logic added to `record__update_evlist_pollfd_f=
rom_thread` is flawed and fails to prevent the `-EINVAL` index mismatch abo=
rt on `POLLHUP`.
- [Medium] The newly added unit test `test__fdarray__filter` fails uncondit=
ionally, breaking the perf test suite.
--

--- Patch [1]: [PATCH v6] perf record: Fix unhandled POLLHUP on non_perf_ev=
ent descriptors ---
commit a78a902826b55b27b98ff151dcb9dd5753ba4611
Author: Ian Rogers <irogers@google.com>

perf record: Fix unhandled POLLHUP on non_perf_event descriptors

This patch attempts to fix a premature teardown during recording sessions b=
y=20
propagating the finalized teardown status (-1) from the core evlist back to=
=20
the thread's local pollfd array when a POLLHUP is received. It also adds a=
=20
unit test to verify that fdarray__filter() properly preserves items marked=
=20
as nonfilterable.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e915390556752..719869efdde59 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1180,6 +1180,16 @@ static int record__update_evlist_pollfd_from_threa=
d(struct record *rec,
>  		int e_pos =3D rec->index_map[i].evlist_pollfd_index;
>  		int t_pos =3D rec->index_map[i].thread_pollfd_index;
> =20
> +		if (e_entries[e_pos].fd =3D=3D -1 || e_entries[e_pos].events =3D=3D 0)=
 {
> +			/*
> +			 * e_entries might have been finalized by evlist__finalize_ctlfd().
> +			 * We must propagate it to t_entries to avoid index mismatches
> +			 * and to prevent a poll storm on the next iteration.
> +			 */
> +			t_entries[t_pos].fd =3D -1;
> +			t_entries[t_pos].events =3D 0;
> +		}

[Severity: High]
Does this synchronization logic happen in the correct order to prevent the
-EINVAL index mismatch?

Looking at the main loop in __cmd_record(), fdarray__filter() mutates the
thread's local pollfd array (zeroing events) before
record__update_evlist_pollfd_from_thread() is called:

tools/perf/builtin-record.c:__cmd_record() {
    ...
    if (fdarray__filter(&thread->pollfd, POLLERR | POLLHUP, ...) =3D=3D 0)
        draining =3D true;

    err =3D record__update_evlist_pollfd_from_thread(rec, rec->evlist, thre=
ad);
    if (err)
        goto out_child;
    }

    if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
    ...
}

Because evlist__ctlfd_process() hasn't finalized the core evlist's array
yet, e_entries[e_pos].events will still be POLLIN, bypassing this new check.

Since the thread's events field was just zeroed by fdarray__filter(),
the strict equivalence check below (POLLIN !=3D 0) will still fail and abort
the session with -EINVAL.

> +
>  		if (e_entries[e_pos].fd !=3D t_entries[t_pos].fd ||
>  		    e_entries[e_pos].events !=3D t_entries[t_pos].events) {
>  			pr_err("Thread and evlist pollfd index mismatch\n");

[ ... ]

> diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
> index 40983c3574b12..2d3db7b754a17 100644
> --- a/tools/perf/tests/fdarray.c
> +++ b/tools/perf/tests/fdarray.c
> @@ -80,6 +80,30 @@ static int test__fdarray__filter(struct test_suite *te=
st __maybe_unused, int sub

[ ... ]

> +	if (fda->entries[2].fd =3D=3D -1) {
> +		pr_debug("\nfdarray__filter() illegally modified nonfilterable fd!");
> +		goto out_delete;
> +	}
> +	if (fda->entries[2].revents !=3D POLLHUP) {
> +		pr_debug("\nfdarray__filter() illegally modified nonfilterable revents=
!");
> +		goto out_delete;
> +	}

[Severity: Medium]
Will this test fail unconditionally?

Looking at fdarray__filter() in tools/lib/api/fd/array.c, it appears to
unconditionally clear the events and revents fields for any entry matching
the filter mask before the nonfilterable flag is ever evaluated:

tools/lib/api/fd/array.c:fdarray__filter() {
    ...
    if (fda->entries[fd].revents & revents) {
        if (entry_destructor)
            entry_destructor(fda, fd, arg);

        fda->entries[fd].revents =3D fda->entries[fd].events =3D 0;
        continue;
    }
    ...
}

Because revents is unconditionally zeroed, won't this check always evaluate
to true and cause the perf test suite to fail?

> +
> +	fda->priv[2].flags =3D 0; /* reset flags */
> +
>  	pr_debug("\n");
> =20
>  	err =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820164937.2734=
066-1-irogers@google.com?part=3D1
