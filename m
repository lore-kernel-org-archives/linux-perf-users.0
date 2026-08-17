Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E03EDAC1
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009293; cv=none; b=tKHxVi3ilHXVAmNeT9zRn+y26pgOwXDdJwNWGrEOHfiiaWbx+tRhJ1+YMfiMyKrega4GTIe6I1IJcb46k6HdYM3vhhizlMAbv2ZyMTdqokjkW09sQ4tTkkjQaVOXJTfHgfCBN/xOGDXDGJUIWcv+LbdogDkUGgRbN839JclOzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009293; c=relaxed/simple;
	bh=ovQxwxhLk3T9WvHqIQGKahXxafZhEq8WNUK/TsZVShE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cmjy9/zIaw1XVgMdrRoNPGOf/e2nnBPUKQt0l4DH4k6Hd0jTiMBJKKcZsQzWa98hFC7IoW+zkAP6C8V1aRzistXkt5mYs+XEig2BaYjQB4GVgnK5CuGcChlkNnx/jn4W25oRZ7tgL+kT7Hg2gkKQEbC/505NjUdiLFIRhXE88NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4ycAAx/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4ycAAx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DB11F000E9;
	Mon, 17 Aug 2026 23:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009291;
	bh=qqN4NCXzZgZnIMXSRD0js9ieZGV0Ui4CrUlIoJWuaJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4ycAAx/yIDxF6gY3+AOU3Om5MIZdX5OBzUiLLjgVDSPJvIPgkF3QvLt889vf3YXk
	 Sft1M3nZFrc/fibZOSyk3Ii8EucIZa6bKG7/EvH9GY8RQ56gMspBwTsk4V/CKLjX71
	 L2cKeuHb+b5UiS2rZsH+HVm11N8QdwNlpIu4DsKM3rKU/tiWsRlV/jrnpsLyxF/WU+
	 6RgK2zbmmwMDCPXCOCsN9MjQh4ew+WI9L/mqYzFZdLRtrtLwWn3zZgvBQj+xjy3Ewz
	 kMZ07/mDQiIdMgp8p9dY3mLzRLaaXBzWRFz4UtpMZCPfLr2Sd5RcgEKZ/D2HCuvM5u
	 XJ2KliOuXBMog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] perf fdarray: Fix destructor invocation and event
 counting in fdarray__filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817230431.424646-1-irogers@google.com>
References: <20260723050409.991665-1-irogers@google.com>
 <20260817230431.424646-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 23:28:10 +0000
Message-Id: <20260817232811.58DB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The refinement to fdarray__filter causes an immediate 'pollfd inde=
x mismatch' error and premature termination on control descriptor POLLHUP b=
y prematurely clearing fd and revents.
--

--- Patch [1]: [PATCH v4] perf fdarray: Fix destructor invocation and event=
 counting in fdarray__filter ---
commit 495f184eb7be01a8af2c7157e4d7f142c89228b0
Author: Ian Rogers <irogers@google.com>

perf fdarray: Fix destructor invocation and event counting in fdarray__filt=
er

This commit refines the early continue filter in fdarray__filter to only sk=
ip
system-wide perf events. Control descriptors now fall through to have their=
 fd
values unset to -1 on POLLHUP while avoiding their destructors. It also ens=
ures
the active event counter increments strictly for completely filterable even=
ts.

> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 67b73481df27e..3681ad7c65278 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -116,14 +116,23 @@ int fdarray__filter(struct fdarray *fda, short reve=
nts,
>  		return 0;
> =20
>  	for (fd =3D 0; fd < fda->nr; ++fd) {
> -		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
> +		/*
> +		 * System-wide perf events are nonfilterable but not non_perf_event.
> +		 * We want to skip them entirely and never process revents on them.
> +		 */
> +		if ((fda->priv[fd].flags & fdarray_flag__nonfilterable) &&
> +		    !(fda->priv[fd].flags & fdarray_flag__non_perf_event))
>  			continue;
> =20
>  		if (!fda->entries[fd].events)
>  			continue;
> =20
>  		if (fda->entries[fd].revents & revents) {
> -			if (entry_destructor)
> +			/*
> +			 * Control descriptors are non_perf_event and don't need
> +			 * their perf-specific destructors triggered.
> +			 */
> +			if (entry_destructor && !(fda->priv[fd].flags & fdarray_flag__non_per=
f_event))
>  				entry_destructor(fda, fd, arg);
> =20
>  			/*
>  			 * Set fd to -1 so poll() ignores this entry; otherwise
>  			 * POLLHUP/POLLERR are still reported for events=3D0 fds
>  			 * (POSIX: always checked), causing a poll storm.
>  			 */
>  			fda->entries[fd].fd =3D -1;
>  			fda->entries[fd].revents =3D fda->entries[fd].events =3D 0;

[Severity: High]
Does unsetting the file descriptor to -1 and clearing revents for control
descriptors cause a pollfd index mismatch error during teardown?

When __cmd_record() handles a POLLHUP on the control pipe, it calls
fdarray__filter() which now mutates the thread's control descriptor:

tools/perf/builtin-record.c:__cmd_record() {
    ...
    if (fdarray__filter(&thread->pollfd, POLLERR | POLLHUP,
                        record__thread_munmap_filtered, NULL) =3D=3D 0)
        draining =3D true;

    err =3D record__update_evlist_pollfd_from_thread(rec, rec->evlist, thre=
ad);
    ...
}

Immediately after, record__update_evlist_pollfd_from_thread() compares the
mutated thread array against evlist->pollfd, which retains the original
valid file descriptor. This strict check fails and returns -EINVAL, causing
an early ungraceful abort:

tools/perf/builtin-record.c:record__update_evlist_pollfd_from_thread() {
    ...
    if (e_entries[e_pos].fd !=3D t_entries[t_pos].fd ||
        e_entries[e_pos].events !=3D t_entries[t_pos].events) {
        pr_err("Thread and evlist pollfd index mismatch\n");
        err =3D -EINVAL;
        continue;
    }
}

Furthermore, does clearing revents to 0 here ensure evlist__ctlfd_process()
will never see the POLLHUP to perform a clean teardown via
evlist__finalize_ctlfd()?

>  			continue;
>  		}
> =20
> -		++nr;
> +		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))
> +			++nr;
>  	}
> =20
>  	return nr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817230431.4246=
46-1-irogers@google.com?part=3D1
