Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECF3195F9
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692412; cv=none; b=aTH1EIL/lvLQwm5DBnE5kocIiLfvSGrvIdpGohEjK+Xd+QyIDI7IhDvz02CQGe4NkqsksQkFLxe3xooLFx5Z8FdvRxNJshd6kg6L38WOt0egt8Ch7M6+FpeDt0MeYJC8Etpxc5Jrwlc06osJsMoM2SOUJRK3oRN9lc/WZp381yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692412; c=relaxed/simple;
	bh=Dk+N/1k2HXf90mhEonAB2ofaVRZRvJx48ogp30zo1Ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MUIUBTwRzOprt1qgu3V7A5cz9AsvGo/3Vkau6mig7fWhrneRL2JH6EfjiLhahs00h9iUz0TmCG67nBo2rSiI/TQMY6ddXoOkiyXERbRaE04r/xoIkcGMsvY4H44PmAOetkFK44s2kDDgMWdzNcZZt7LJ7lw0m2QbYyg7z+cHWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcfDW/My; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcfDW/My"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD831F00893;
	Fri,  5 Jun 2026 20:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780692411;
	bh=0giBxELnA/jDAVNs+QkG/1SWD6pwa/0+RpKdmKeuUZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jcfDW/MyRQcQ/3vvFMYbMV1OAC/wQeXdGuKqddwwoZMfgVHbpY4s31dv9pQOeYk2n
	 AtawFYZ0lY/UxPdQhjnEb9xGeBkfe82SDy+n4zUFkmhdJChw5xj9tDZcHK2O3icHB7
	 6Z0x9l/X6hUC6PQ14FqRQXy99O126yy1euxftJN0zG3v1In85LbPW32HUefBDjJij4
	 EokfbhGFp6h7xS+sTtp7iP78Rt7bkhBj/wJJ88aaL9F3RTHlx6x0e7IyY/7Xi5fKc6
	 lZtKdXcvOomlSlBNkZr1k4hVFGt6ov5kBg/SQTm/KPz8mjHbEdxznbTxvybFXZEuYu
	 AAOe1Wbzhm7Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] perf sched: Fix thread reference leak in idle hist
 processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605203316.1758661-7-acme@kernel.org>
References: <20260605203316.1758661-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 20:46:50 +0000
Message-Id: <20260605204651.2CD831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `timehist_get_thread()` leaks thread references on both success an=
d error paths when `--idle-hist` is active.
- [High] The callchain root tree within `struct idle_thread_runtime` is not=
 freed when idle threads are destroyed, leaking dynamically allocated callc=
hain nodes.
--

commit b5d8b3caa1d8b8f8fc2ff742e34d77adc37bf655
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Fix thread reference leak in idle hist processing

timehist_sched_change_event() sets itr->last_thread to NULL at the end
of idle hist processing without calling thread__put() first.  The
thread reference was acquired via thread__get() in timehist_get_thread()
(line 2581), so every idle context switch leaks a thread reference when
--idle-hist is active.

Use thread__zput() to properly release the reference before clearing
the pointer.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index e47db1c5c6020..e2df69a624765 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2890,7 +2890,7 @@ static int timehist_sched_change_event(const struct=
 perf_tool *tool,
>  			if (itr->cursor.nr)
>  				callchain_append(&itr->callchain, &itr->cursor, t - tprev);
> =20
> -			itr->last_thread =3D NULL;
> +			thread__zput(itr->last_thread);

[Severity: High]
This isn't a bug introduced by this patch, but while we are fixing leaks
around idle thread handling, does timehist_get_thread() also leak thread
references when --idle-hist is active?

tools/perf/builtin-sched.c:timehist_get_thread() {
    ...
		if (sched->idle_hist) {
			struct thread *idle;
			struct idle_thread_runtime *itr;

			idle =3D get_idle_thread(sample->cpu);
			if (idle =3D=3D NULL) {
				pr_err("Failed to get idle thread for cpu %d.\n", sample->cpu);
				return NULL;
			}
    ...
}

It appears get_idle_thread() returns a new reference via thread__get(). On
success, this local idle thread reference is never released. Also, on the
error paths returning NULL, it seems to bypass the caller's cleanup code and
permanently leak the task thread reference acquired earlier via
machine__findnew_thread().


[Severity: High]
This is a pre-existing issue, but does free_idle_threads() leak dynamically
allocated callchain nodes?

tools/perf/builtin-sched.c:free_idle_threads() {
    ...
		thread__put(idle);
    ...
}

The thread's private data destructor is set to free() via
thread__set_priv_destructor(free). While free() successfully frees the stru=
ct
idle_thread_runtime container, it doesn't appear to recursively free the
nodes embedded in the itr->callchain tree built by callchain_append(). Can
this lead to unbounded memory growth proportional to the trace size?

>  		}
> =20
>  		if (!sched->summary_only)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605203316.1758=
661-1-acme@kernel.org?part=3D6
