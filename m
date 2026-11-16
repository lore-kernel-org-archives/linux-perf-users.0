Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811127;
	b=hL60NZe4zGybompej02gnqx9qO6BZYjYLwf3YloOXSNXz9AHfhXk2RqtkM9kcx33Gzq2
	 7pux9FhZQyfvMwQYSplajgbqBapC1revSUrZIbGjPVqSVL7Q+XEARr4/K2/0rp9OXP9/6
	 pgdKyFcLsw0Is27Ry2huvv7STWBT9Sp/1ZccglcNDLh3QfpENpUg/Q4bLyRyBM20ti5aT
	 0VaTe6A2cGx1DZkEJratiVssG6YtYy9vMkuXygHgZk6+612Y5xUqvAOB22FE7GfePA4Av
	 JtoQ4kys2QpxoUdwiZ/Lo+wo4SJoZrKVY00t3mQCjuw2RgCRaXFk9U0qwxfX/W4k89A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811127;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZtGPouJctwIM4fDjpb3K1uBg5TmVaEl1XmKwcdl+gzI=;
	b=WvZqsO5UoMX65ETcuZHIGDUu+KZASh4OExaNTuc/p+K94753cjLslCdL4otQEdW4gBMt
	 YJtGaYIcsOLj4FFXnXw78Z7/Pt+t1DTTmfyNx5Z6+psFyhLhK+Po6tvLJeaCObYahVc8w
	 7x55hnWMm4cXiMtttDU7scGElnH04jfRY6e2s8xWWLpMXEbcHi5pc0CaNxKY8Z+BGQYjh
	 6uZtQuSWF52dTD/dNPfXY3fnw1IVwVWNaFFOuLKgWvezNCNEeVeTNngOm4lkL5GjZB2qD
	 xK0dIVIcNZN9PT4Sp+3I+nNXQ68Z1lYKlqLr+ZbZhhwO9xuGI+enzzmHtxovmyhucbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAmFXgj8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D6606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAmFXgj8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBF01F000C4;
	Mon, 16 Nov 2026 06:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811127;
	bh=ZtGPouJctwIM4fDjpb3K1uBg5TmVaEl1XmKwcdl+gzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FAmFXgj8jw7LrPbBNocm4I2FjpbieTRKqh5QdN8X82ckPG4PdafA0LYTIZpcCYc5n
	 CXIBndKlAT3x6xZB8SdZeaTo/OgE/LXHdgZ+n7X1QfRVjmWmUfPttu0ktPCsZ8dzPr
	 62Yj5UM5cNqwQ1IGPRZx389l8VM34D78aDrb0MXjno+RvNGN5RwflAe3E26JctiAYU
	 /drKvGdBpiVYcaIfyh/2KnHv/EZ/4ELIxN23LutqKWbICq89aAabwhnjhufejLMmz+
	 klFBwArAThPaqo8AghoQ6KQ/0TTjUZeQwFGXqaPE/S667BjCdT0MzGd+s1CQuYo/Wj
	 phoGsjy4tF2bg==
Message-ID: <sashiko-outbox-216287@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] perf tools: Check thread liveness when
 accessing /proc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-8-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:38:46 +0000
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
- [Medium] perf tools: nsinfo__check_proc() in
  dso__filename_with_chroot() inside mntns
- [Medium] perf tools: thread__init_maps() marks pipe-mode threads
  exited in perf inject
--

commit e4d060b6fbe7a9b1256d33ec34cd9b157fb2e968
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Check thread liveness when accessing /proc

This commit adds thread__exited() and thread__is_alive() to track thread
liveness and propagates thread exit and boot ID mismatches to nsinfo so
/proc accesses can be skipped for exited or offline threads.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index ce98613868e7d..0a3e40aeadbbb 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -587,7 +587,12 @@ static int do_open(char *name) EXCLUSIVE_LOCKS_REQUI=
RED(_dso__data_open_lock)
> =20
>  char *dso__filename_with_chroot(const struct dso *dso, const char *filen=
ame)
>  {
> -	return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filena=
me);
> +	struct nsinfo *nsi =3D (struct nsinfo *)dso__nsinfo_const(dso);
> +
> +	if (!nsinfo__check_proc(nsi))
> +		return NULL;
> +
> +	return filename_with_chroot(nsinfo__pid(nsi), filename);
>  }

[Severity: Medium]
Can calling nsinfo__check_proc(nsi) here mark a live container thread's
nsinfo as exited when dso__filename_with_chroot() runs inside the
container's mount namespace?

dso__load() and dso__get_filename() call dso__filename_with_chroot()
between nsinfo__mountns_enter() and nsinfo__mountns_exit().  When
dso__load() probes distro debuginfo paths that do not exist before
reaching DSO_BINARY_TYPE__SYSTEM_PATH_DSO, nsinfo__check_proc() looks up
/proc/<host_pid>/task/<host_tid>/status inside the container's mount
namespace.  If the container has its own /proc mount for a PID namespace,
that host PID lookup fails or matches a different task, so
nsinfo__check_proc() calls nsinfo__set_exited(nsi).  Because dso->nsinfo
is shared with thread->nsinfo, this clears need_setns and breaks
subsequent mount namespace entry and DSO loading for the live thread.

> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 5d1c886add3e6..fda718ea5d7e6 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -37,6 +37,16 @@ int thread__init_maps(struct thread *thread, struct ma=
chine *machine)
>  		}
>  	}
> =20
> +	if (thread__pid(thread) !=3D 0 || thread__tid(thread) !=3D 0) {
> +		if (!machine || !machine__is_host(machine) ||
> +		    !perf_env__is_same_boot(machine->env)) {
> +			struct nsinfo *nsi =3D thread__get_nsinfo(thread);
> +
> +			nsinfo__set_exited(nsi);
> +			nsinfo__put(nsi);
> +		}
> +	}
> +
>  	return thread__maps(thread) ? 0 : -1;
>  }

[Severity: Medium]
Does checking !perf_env__is_same_boot(machine->env) here (and in
__thread__reset_nsinfo(), thread__is_alive(), and
machine__update_thread_pid()) mark all threads as exited during live
pipe-mode sessions such as "perf record -o - | perf inject -b"?

When __perf_session__new() opens a read-mode pipe, it sets
session->header.env.offline =3D true and perf_session__read_header()
returns before reading any feature records.  In cmd_inject(),
inject.tool.feature is set to perf_event__repipe_op2_synth rather than
perf_event__process_feature(), so HEADER_BOOT_ID is never populated in
machine->env->boot_id.  perf_env__is_same_boot(machine->env) then returns
false for every thread, disabling mount namespace entry, chroot
resolution, and /proc lookups during pipe-mode build-id and JIT
injection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D7
