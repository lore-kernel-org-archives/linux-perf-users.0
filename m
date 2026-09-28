Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2595B2EEE9E
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633967; cv=none; b=F0kINvJtmRfo4snmUB1G1TgrRxM2JR8iTak8BlOwWvk/DFFaEm3Qok20HiEpoFyJVCHfI4x0Eh+WkI0vnWCYXqmLTDmTY2sP0y40P91FaaSx1aR7yNAFjEycNoxMNKqWhiQM60GxF6BY19czk3WNsfo5XhqO+jYbwRar9DI/8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633967; c=relaxed/simple;
	bh=x6e0Q9pcXiODx/vgSe3/rWcTV3ShDz6z4M9kb2ToI2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A0NjP1PO65l5IT0bo+yhPzfQlW3Es3gucs7TRNnw7ndk62/Cg4y8wlIbTDyCHYt7pFuV9419hvAhrF3w6eGZ3rN2i/1IY6diebmRohJJwyLLg7sW6ADIokCKuH+hTOl5wZHgOyoSdZ5P1nyJQHI+wVgggYCerqEm3tW3nbAKIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7hvAyqx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7hvAyqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D751F000FF;
	Mon, 28 Sep 2026 22:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790633965;
	bh=zR4X5U/6v9IfftlKC9CFkzptUszbVQ9CcoUJIs2PINs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7hvAyqxE2IbFSl5xiSqG5Q+ecPiHoi/Jo4DI8lBEvrgKLcfeWBtdt6fEI8Wg5vdK
	 v9bQFJdIPLOntg0hSCgOkqvwB31qct/S1KTI8zYHMkXeu+vXgRnNPV2j9txKadB6E8
	 UtwJeotBiEQp1dZZKmBSPqijiAfFnVGVh2yV7j4bZ+gEM5hHtcPj/+hHQ8u2ed3qCs
	 V19qfepCJqpo//Bkbl3HZLGjEcB+BXJ+LDYxTls8OpfUJG+BqsElescfw2ar/JKt7z
	 uMBdtk+Uf/M1RrhI6PdxsBRG3k3DjpLbQelt9ZxpajQeXRu40DVOWV7UWv+LaQ89Na
	 s/x3wGb2cEz/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928220634.2451784-2-acme@kernel.org>
References: <20260928220634.2451784-1-acme@kernel.org>
 <20260928220634.2451784-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 22:19:24 +0000
Message-Id: <20260928221925.76D751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: data race in bad_config() causes stack UAF
--

commit 861fbcb5738f68f4bf3fa7cf60e666d3e7639e45
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf config: Move perf_config__set_variable() to util/config.c

This commit moves perf_config__set_variable() out of the builtin so opt-in
features can persist their choice from outside it. It also serializes
parsing and rewriting with a mutex since config file access can now run on
more than one thread.

> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 8fe43b032e9af..da4213a704899 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
[ ... ]
> @@ -926,6 +926,84 @@ void perf_config__exit(void)
>  	config_set =3D NULL;
>  }
> =20
> +int perf_config_set__write(struct perf_config_set *set,
> +			   const char *file_name, bool system_config)
[ ... ]
> +int perf_config__set_variable(const char *var, const char *value)
> +{
> +	char path[PATH_MAX];
> +	char *user_config =3D mkpath(path, sizeof(path), "%s/.perfconfig", gete=
nv("HOME"));
> +	const char *config_filename =3D config_exclusive_filename ?: user_confi=
g;
> +		/*
> +	 * When rewriting the system wide file all entries are marked as coming
> +	 * from it and must be kept, or it would be truncated down to its
> +	 * header.
> +	 */
> +	bool system_config =3D strcmp(config_filename, perf_etc_perfconfig()) =
=3D=3D 0;
> +	struct perf_config_set *set;
> +	int ret =3D -1;
> +
> +	pthread_mutex_lock(&config_update_mutex);
> +	set =3D perf_config_set__new();
> +	if (!set)
> +		goto out_err;
> +
> +	if (perf_config_set__collect(set, config_filename, var, value) < 0) {

[Severity: High]
Can this lead to a stack use-after-free during concurrent config parsing?

A writer thread running perf_config__set_variable() assigns the global
config_file_name to point to its local stack buffer (path) under config_mut=
ex
in perf_config_set__collect().

Concurrently, a reader thread iterating cached configurations via perf_conf=
ig()
might encounter a malformed value and invoke bad_config(). bad_config() rea=
ds
config_file_name locklessly:

tools/perf/util/config.c:bad_config() {
    ...
    if (config_file_name)
        pr_warning("bad config value for '%s' in %s, ignoring...\n",
                   name, config_file_name);
    ...
}

If the reader reads the pointer locklessly, and the writer finishes and
returns before the reader executes pr_warning(), won't the reader dereferen=
ce
the destroyed stack frame for path?

> +		pr_err("Failed to add '%s=3D%s'\n", var, value);
> +		goto out_err;
> +	}
> +
> +	if (perf_config_set__write(set, config_filename, system_config) < 0) {
> +		pr_err("Failed to set the configs on %s\n", config_filename);
> +		goto out_err;
> +	}
> +
> +	ret =3D 0;
> +out_err:
> +	perf_config_set__delete(set);
> +	pthread_mutex_unlock(&config_update_mutex);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928220634.2451=
784-1-acme@kernel.org?part=3D1
