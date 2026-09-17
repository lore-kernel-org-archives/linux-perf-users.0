Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067003A7F4B
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661466; cv=none; b=G54Vk6GZnzpXkdZeoIqmPbzYKlenUDh6mzDEbTShk2y9GpizWLz1xvLHofn44XcK6HpPtjomGVZSvPW2r4+tMNT6vJCjJEnJmPfpX7jPlJDv01gnrPnE+D35YeHXMo61Dq0//uaPhqDmYcVHrxKrLrJ8tsBfwlWA8nkYqMYRZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661466; c=relaxed/simple;
	bh=V/hE/mkYll6QAsiPtQWrT6dxZswHA6BJAbiZfrm5OqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CDU6HWivE1PnfQiHaGK12Nc487a14wOUuYtmkwc+uryZp0yjJBEwbhXec32cBH4hhUF/7qZlZmouJK0adx3kMQBDDnohZqXyTSWHLSxOYl8ubphqafXDyu3YU11DHeHX3gvTojYi7rfSh7e7dI7Nt3vaf6vUIq9pZK+uf9OCEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7A2yaaq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7A2yaaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01E61F000FF;
	Thu, 17 Sep 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661464;
	bh=YwWN4I30jIG1WMax3Nrr2iI6T91z4O2OIWJLWQT+eJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7A2yaaqD9pzAQ2qRmSbhuKank6OYBFrYJGp9aMXPXkH4xg8JoQLfu9sZhd0cpjFg
	 6iyUnPjuUiVsS9IkKeumOqnSWX6Wjc89oJaDC0oGjHD4k8naQU0lFT7oj68qFCWvv5
	 huB0iQyLU5AM37vOQ6dCzyC1qpm8nWIH7z/juTHhkSCWDqanG5r7HsIf2fzsQ1yppt
	 aRZRKFNDf7a79GXiMBTIfgjk3Wbaje4QuE+H23U/QigUpz98zZ3gQ8X0c9KlKJdjdO
	 n+RmcgI0yz3AFuS/q7TOv2lwhPCJdTpCyK8QasLHgiWeGOJfR2fxCamE6Xs26X433Y
	 FlaoLtnj1A28Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/15] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-4-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:11:04 +0000
Message-Id: <20260917161104.B01E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf config: data loss due to non-atomic read-modify-write in se=
t_variable
- [Medium] perf config: memory leak due to lockless perf_etc_perfconfig() i=
nitialization
--

commit 836076e44736c46148a07294c62bef2cd50992f3
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf config: Move perf_config__set_variable() to util/config.c

This commit moves perf_config__set_variable() to util/config.c so that other
utilities can access it. It also serializes config parsing and rewriting
with a mutex to support multithreaded access.

> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
[ ... ]
> @@ -776,8 +788,13 @@ static int collect_config(const char *var, const cha=
r *value,
>  int perf_config_set__collect(struct perf_config_set *set, const char *fi=
le_name,
>  			     const char *var, const char *value)
>  {
> +	int ret;
> +
> +	pthread_mutex_lock(&config_mutex);
>  	config_file_name =3D file_name;

[Severity: Medium]
This is a pre-existing issue, but does assigning file_name to the static
global config_file_name create a stack use-after-free risk?

In perf_config__set_variable(), the stack array path is used as the filename
and passed into this function:

perf_config__set_variable() {
    char path[PATH_MAX];
    ...
    const char *config_filename =3D ... ?: mkpath(path, ...);
    perf_config_set__collect(..., config_filename, ...);
}

If the static pointer config_file_name isn't cleared after collecting, could
a subsequent config parsing failure in bad_config() dereference this dangli=
ng
stack pointer and cause a crash or output garbage?

> -	return collect_config(var, value, set);
> +	ret =3D collect_config(var, value, set);
> +	pthread_mutex_unlock(&config_mutex);
> +	return ret;
>  }
[ ... ]
> @@ -876,6 +893,83 @@ void perf_config__exit(void)
[ ... ]
> +int perf_config__set_variable(const char *var, const char *value)
> +{
> +	char path[PATH_MAX];
> +	char *user_config =3D mkpath(path, sizeof(path), "%s/.perfconfig", gete=
nv("HOME"));
> +	const char *config_filename =3D config_exclusive_filename ?: user_confi=
g;
> +	/*
> +	 * When rewriting the system wide file (e.g. with
> +	 * PERF_CONFIG=3D/etc/perfconfig) all entries are marked as coming from=
 it
> +	 * and must be kept, or the file would be truncated down to its header.
> +	 */
> +	bool system_config =3D strcmp(config_filename, perf_etc_perfconfig()) =
=3D=3D 0;

[Severity: Medium]
Can calling perf_etc_perfconfig() concurrently here lead to a memory leak?

Because perf_etc_perfconfig() checks !system_wide without holding
config_mutex, multiple threads could bypass the check simultaneously and
allocate redundant path strings via system_path(). This could cause all but
the last allocated string to be leaked.

> +	struct perf_config_set *set;
> +	int ret =3D -1;
> +
> +	set =3D perf_config_set__new();
> +	if (!set)
> +		goto out_err;
> +
> +	if (perf_config_set__collect(set, config_filename, var, value) < 0) {
> +		pr_err("Failed to add '%s=3D%s'\n", var, value);
> +		goto out_err;
> +	}
> +
> +	if (perf_config_set__write(set, config_filename, system_config) < 0) {

[Severity: Medium]
Can concurrent configuration updates overwrite each other here, causing
data loss?

The sequence of perf_config_set__new(), perf_config_set__collect(), and
perf_config_set__write() drops the config_mutex between each function call.
This appears to break the atomicity of the read-modify-write cycle when
multiple threads invoke perf_config__set_variable() at the same time.

> +		pr_err("Failed to set the configs on %s\n", config_filename);
> +		goto out_err;
> +	}
> +
> +	ret =3D 0;
> +out_err:
> +	perf_config_set__delete(set);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D3
