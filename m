Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523C367B98
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189761; cv=none; b=Lf7hc5KtojuSA8wXBixSi7frZJ7VmG5HeGCFVVJq9JomdZQjeJTtd4M3dUTqU/T7eXBduS1Rxf9O5uRTCrA95nL/mI48LPw/seGgoiDcAeG8n+b7oXN/OtqOAQVe9WuVKZYOCONhIwPJKKxbm6bvyDtHLGf66T8GVMKPJoS0EN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189761; c=relaxed/simple;
	bh=GEW0seDegkduedoNn6fGF7pwjM3U/zAStEHntMBNnUw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Km/foFV00WV25eEfWlYRmd8updacSSB+L5vQxGBFh6tQQbAdOBxC2eORJyTBldZ9waII/7WYZVEU4L+5RS5Lcz82Zv8TeCPK3yINMcrRoYwnF2iAaeZpBQa7cX62aJOm5rKzTMihyDqGsxB7pfcxXL6CvPsigCI+/itWVntpOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEWjEriE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEWjEriE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276DA1F000C4;
	Fri, 16 Oct 2026 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189760;
	bh=mBdT3I5DiDa3zJic0jU/5Jc4Q3SVnHl+ex/95RIjECg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oEWjEriEx1Ub95uk3u/0Z5tCzYRr8gHftiXvpjTu/zJcvFku7GDzs7LCDCdb5qI8w
	 /MkqHq0eonvhIJRcW1SGN9KByY2I+6oMz24BwPwndeM7FyY4/LCjfsFarDfYWXN6lb
	 EMPRvcTN1CA0+LP8KgK624dZroOtXYjpTP64JbwjWWtu8lFFbRsuFJmCtkrSUWw54H
	 ZQI/1GJNf4uZvcv/4XawiF5TNSSztbXYstmMlvT78g3lQSHHmVubHhUwoDo3eXNMOw
	 FQ0cSIVDtQJJHKpvMaftmgGQlADOrxDLpq5UbOdlGQGnOaRO9WAytqeck65S1yj3y1
	 Io6AtwDtrqiWw==
Message-ID: <sashiko-outbox-175020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/17] perf vdso: Fix unlocked __dsos__add() and race
 in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-8-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:29:19 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf vdso: unlocked vdso_info and get_file() race in machine__fi=
ndnew_vdso()
--

commit a9b1f4c5120b2f5d63a8c9e9ad23dc250184a018
Author: Ian Rogers <irogers@google.com>

perf vdso: Fix unlocked __dsos__add() and race in __machine__addnew_vdso()

This commit acquires machine->dsos.lock in write mode in
__machine__addnew_vdso(), double-checks __dsos__find() to avoid inserting
duplicate VDSO entries when racing with another thread, and sets the DSO
long name before calling __dsos__add().

> diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
> index c12f5d8c4bf69..dca4f683be9b7 100644
> --- a/tools/perf/util/vdso.c
> +++ b/tools/perf/util/vdso.c
> @@ -127,13 +127,26 @@ void machine__exit_vdso(struct machine *machine)
>  static struct dso *__machine__addnew_vdso(struct machine *machine, const=
 char *short_name,
>  					  const char *long_name)
>  {
> -	struct dso *dso;
> +	struct dso *dso, *existing;
> +
> +	down_write(&machine->dsos.lock);
> +	existing =3D __dsos__find(&machine->dsos, short_name, true, /*write_loc=
ked=3D*/true);
> +	if (existing) {
> +		up_write(&machine->dsos.lock);
> +		return existing;
> +	}

[Severity: Medium]
Can concurrent callers of machine__findnew_vdso() still race on
machine->vdso_info and vdso_file before reaching __machine__addnew_vdso()?

The callers of __machine__addnew_vdso() are machine__findnew_vdso() and
__machine__findnew_compat():

tools/perf/util/vdso.c:machine__findnew_vdso() {
	if (!machine->vdso_info)
		machine->vdso_info =3D vdso_info__new();

	vdso_info =3D machine->vdso_info;
	if (!vdso_info)
		return NULL;
	...
	file =3D get_file(&vdso_info->vdso);
	if (!file)
		return NULL;

	return __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
}

tools/perf/util/vdso.c:__machine__findnew_compat() {
	...
	file_name =3D vdso__get_compat_file(vdso_file);
	if (!file_name)
		return NULL;

	return __machine__addnew_vdso(machine, vdso_file->dso_name, file_name);
}

When two threads enter machine__findnew_vdso() while machine->vdso_info is
NULL, both can call vdso_info__new() and overwrite machine->vdso_info,
leaking the first struct vdso_info allocation and any temporary file it
creates.

Even if both threads see the same machine->vdso_info while vdso_file->found
is still false, both can enter get_file() (or vdso__get_compat_file())
before acquiring machine->dsos.lock:

tools/perf/util/vdso.c:get_file() {
	if (vdso_file->found)
		return vdso_file->temp_file_name;
	...
	fd =3D mkstemp(vdso_file->temp_file_name);
	if (fd < 0)
		goto out;
	...
 out:
	free(buf);

	vdso_file->found =3D (vdso !=3D NULL);
	vdso_file->error =3D !vdso_file->found;
	return vdso;
}

Because mkstemp() mutates vdso_file->temp_file_name in place (replacing the
trailing "XXXXXX"), the second thread's mkstemp() call on the same buffer
fails with EINVAL, sets vdso_file->found =3D false and vdso_file->error =3D
true, and returns NULL before ever reaching the double-check in
__machine__addnew_vdso().

Should the machine->vdso_info initialization and temporary file creation in
get_file() and vdso__get_compat_file() also be synchronized under the lock?

>  	dso =3D dso__new(short_name);
>  	if (dso !=3D NULL) {
> -		__dsos__add(&machine->dsos, dso);
> +		/*
> +		 * Set the long name before adding to machine->dsos so that
> +		 * __dsos__add() inserts it in sorted order without needing to
> +		 * re-take machine->dsos.lock.
> +		 */
>  		dso__set_long_name(dso, long_name, false);
> +		__dsos__add(&machine->dsos, dso);
>  	}
> +	up_write(&machine->dsos.lock);
> =20
>  	return dso;
>  }

=E5=AE=8C=E7=BE=8E=E7=BB=93=E6=9D=9F=EF=BC=8CWait=E2=80=94remove non-ASCII =
text at the end! Let me make sure I don't output anything after the blank l=
ine.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D7
