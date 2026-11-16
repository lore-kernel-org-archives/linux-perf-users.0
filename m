Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809767;
	b=k4qoQ2le7WwfWDpsJ6NyNqNggyqKtT7P7nQnpXINHQxaRz3l90vL9uU2xzPRKH7JmyXg
	 XNLeGQqiogvCujH9AkazfL/LuYuSr3wMgSS0qQr9trZ3lPZkh4WI7kCFs8smnmZgoOX7T
	 zIOwER38v/dVIGBQWuP3IutMm6adr/cfdyiG0nY2rk92Sz6yn1DsZVx4SFDeFbRBNT53H
	 KvH+lJiC9kCvnKMU4tSkXN7bPaQ7efGjX2UiFrCcjQSSbR9nwZn510IagmaqSz2FilRU9
	 2102MXJ/SBuWrTMJE2emgKygNswj3yQpElmobKU11uorlVaIRWk2e2iU1Nl27RNOGBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809767;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RGWdQ/GMy8QOS0R7cR1rEfbwZxSklTAX5rvX+KHqP20=;
	b=VkGx0RLeXFERWfj6+qaMePbgl3RXCowdR1prVtPS95QKyYMut6R8uGfqbMWausT+xC0c
	 9JmZI867jMeIj2T7Eoc5PFXijhCodyeAW7AInD18Yw4kUJSvM7exdflHfNLTeBmpCrLsw
	 Z3dAtjdGPFKCQwZFOC4hs6DHZDyVJKFcw6AesugMfmD+42BmOXR4FnjY0uP2aOxp25Bvj
	 HDP0tS9udtvwnfgInZbXoF6QWF8sq/6AIlyfIBKzaAPqpKNYdMtXvn7PT25SKRdhMGMig
	 fqSqjxNPCNT3xL6YKXlW83mJiwlt+zmT5OfgfHvdQzRN7H/jjhC9sryMu1rLEzQyOBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDwnUFq4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1ED606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDwnUFq4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2167B1F000C4;
	Mon, 16 Nov 2026 06:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794809767;
	bh=RGWdQ/GMy8QOS0R7cR1rEfbwZxSklTAX5rvX+KHqP20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDwnUFq46YmPXb162k+wnGdqVcPmziyiIqUzco7T9clCK1SV/T8qq7pot79WXVppX
	 3iqxO8iSdzKxIw+x35zDwucvcWdcJMxNDZhi+ho63mOvihXur95lq2GYL34MI2Zl37
	 MsSvVAUEfecNOZn1X6ViqBtKaHL5K9RGygFBYfIaioPJ/pQ1CXsxd9wgVpw9ianSZB
	 FT3yVqzXLiX+sSJhawP94JBBDKVWzhJS4DHdxjZzrtbAhxPJvm2ac0OfYWPKGImk+m
	 y5SWSo25FT9XVsQHoD85NI7GrgxPHCb62o0wnQ3bGkbvWWnXYBQDYxPORISfd/X+YO
	 vuufI1upDNmyA==
Message-ID: <sashiko-outbox-216252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] perf tools: Export
 filename__read_build_id_ns()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-9-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-9-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:16:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf build-id: filename__read_build_id_ns() checks host /proc
  inside mountns
--

commit 32054987b7b4b030ff39e7d9b8a53cb7044261a7
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Export filename__read_build_id_ns()

This commit exports filename__read_build_id_ns() with a chroot fallback
and uses it in dsos__read_build_ids_cb() and perf-inject's
dso__read_build_id().

> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 02233ef0eafff..ff083a594b405 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -847,15 +847,23 @@ int build_id_cache__remove_s(const char *sbuild_id)
>  	return err;
>  }
> =20
> -static int filename__read_build_id_ns(const char *filename,
> -				      struct build_id *bid,
> -				      struct nsinfo *nsi)
> +int filename__read_build_id_ns(const char *filename,
> +			       struct build_id *bid,
> +			       struct nsinfo *nsi)
>  {
>  	struct nscookie nsc;
>  	int ret;
> =20
>  	nsinfo__mountns_enter(nsi, &nsc);
>  	ret =3D filename__read_build_id(filename, bid);
> +	if (ret < 0 && errno =3D=3D ENOENT && nsinfo__check_proc(nsi)) {
> +		char *new_name =3D filename_with_chroot(nsinfo__pid(nsi), filename);
> +
> +		if (new_name) {
> +			ret =3D filename__read_build_id(new_name, bid);
> +			free(new_name);
> +		}
> +	}
>  	nsinfo__mountns_exit(&nsc);

[Severity: Medium]
Does calling nsinfo__check_proc() and filename_with_chroot() before
nsinfo__mountns_exit() look up the host PID in the target mount
namespace's /proc?

When profiling a container with its own PID namespace and /proc mount,
any ENOENT from filename__read_build_id() (for example on [heap] or a
deleted binary) causes nsinfo__check_proc() to inspect
/proc/<host_pid>/task/<host_tid>/status inside the container's /proc:

tools/perf/util/namespaces.c:nsinfo__check_proc() {
    ...
	scnprintf(spath, sizeof(spath), "/proc/%d/task/%d/status",
		  nsinfo__pid(nsi), nsinfo__tid(nsi));
	if (nsinfo__get_nspid(&tgid, &nstgid, &in_pidns, spath) < 0 ||
	    tgid !=3D nsinfo__pid(nsi)) {
		nsinfo__set_exited(nsi);
		return false;
	}
    ...
}

Because the host PID is absent or belongs to a different process there,
nsinfo__check_proc() calls nsinfo__set_exited(nsi), clearing need_setns
and freeing mntns_path on the shared struct nsinfo, which disables mount
namespace entry for subsequent DSOs of that thread.  Moving
nsinfo__mountns_exit(&nsc) before the fallback (or resolving new_name in
the host mount namespace) would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D8
