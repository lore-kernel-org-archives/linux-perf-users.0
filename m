Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D112D1F1
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560106; cv=none; b=Fq7N27tbhLMclQHpFXnyexcM5M++GpAVnNmhXmyzxfHKzMpeKrJDhtr3Bf1/TGkLfVeD5esotkuK84BLeRRD2v4ps1Y2/d/dyY1soQd9jF88r9yIK0JA6NSioQKBSix6gB7O/2kyd5yBh1u4DR955YwtUf7AhojW/7nCNsDocFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560106; c=relaxed/simple;
	bh=IDgP9hFKwaV02R/GDgsO5B/S5BjlvgePgYg3h/L3SVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ECD6OS2mqX29oGFaX1AwqUtZaGsrFzmsoOlx9BNb2Mk/Hkr6Z/AJWg6VsOykwniuTimahl96Ta/XJW+PpJFmBGLGh6e2WcIJgiC6oDTqkPrHplmW2eM80a0JmJheZqjQ7ebOVjv02bH8ZWrPzVJbRxsEM2WnKI2LP4xKQgmyUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEXEt9GC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEXEt9GC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22991F00893;
	Wed, 16 Sep 2026 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560098;
	bh=DW8K83nEtopkIl/ftA1gjV38a/VVnX+xVlyJV9HaGAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UEXEt9GCxwXeJRuRE+6VUoGdOs2Rq9qXPm8h3ypSlQkOoi5f66Xr5UQOFXrwvuqgG
	 7MTD3h7LWt8mQkiBlsiOvLa9sHabrltJxYiKeZHW5gzdTfUMFCUh1rMJD2BTYQhlbk
	 OHSSvliB/pWrlvBHRBk/WNVUqkkUdp6akBV2dVDd8/X+c+cLKOwfhm1ALlNWnf6lJh
	 JY89HvjZRkSAZExkduXuccUzpOPiUsviAsncDF/nZBlfRYxaWL0cpGguTLogkG+6Vz
	 dLuCEEgFv4eypm8mo8oRVfVNZJ6cwTpnF+raySAvRkuvEYD7jqHoGNnrGVDs/oViTZ
	 MRK+ibqCkYJ9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-4-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:01:38 +0000
Message-Id: <20260916120138.D22991F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: hardcoded system_config=3Dfalse wipes out system config file
- [Low] perf: missing limits.h inclusion for PATH_MAX causes musl build fai=
lure
--

commit dd0d85968ed396c9cbcce556b124511aed73efb9
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

    perf config: Move perf_config__set_variable() to util/config.c
   =20
    It is code from the 'perf config' builtin to set a variable in the
    configuration file perf is using, the user's ~/.perfconfig, or the file
    named by the PERF_CONFIG environment variable when it is set, rewriting
    that file from the config set, the same rewrite 'perf config' does,
    i.e. the comments in it are not preserved, as the config set carries
    just the key-value pairs.  It has to honour PERF_CONFIG, that makes perf
    read only that file: the config set is loaded from it, so writing
    ~/.perfconfig would replace it with the exclusive file's entries.

> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 31c6618d3b3da..3f9753b2a7bdf 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c

[ ... ]

> @@ -876,6 +876,76 @@ void perf_config__exit(void)
>  	config_set =3D NULL;
>  }
> =20
> +int perf_config_set__write(struct perf_config_set *set,
> +			   const char *file_name, bool system_config)
> +{
> +	struct perf_config_section *section =3D NULL;
> +	struct perf_config_item *item =3D NULL;
> +	FILE *fp;
> +
> +	fp =3D fopen(file_name, "w");
> +	if (!fp)
> +		return -1;
> +
> +	fprintf(fp, "# this file is auto-generated.\n");
> +
> +	/* overwrite configvariables */
> +	perf_config_sections__for_each_entry(&set->sections, section) {
> +		if (!system_config && section->from_system_config)
> +			continue;
> +		fprintf(fp, "[%s]\n", section->name);
> +
> +		perf_config_items__for_each_entry(&section->items, item) {
> +			if (!system_config && item->from_system_config)
> +				continue;
> +			if (item->value)
> +				fprintf(fp, "\t%s =3D %s\n",
> +					item->name, item->value);
> +		}
> +	}
> +	fclose(fp);
> +
> +	return 0;
> +}
> +
> +/*
> + * Set @var=3D@value in the configuration file perf is using: the user's
> + * ~/.perfconfig, or the file named by the PERF_CONFIG environment
> + * variable.  The latter has to be honoured as it makes perf read only
> + * that file, so the config set came from it and writing ~/.perfconfig
> + * would replace it with the exclusive file's entries.  Rewriting the
> + * file from the config set is the same rewrite 'perf config' does: the
> + * comments are not preserved, as the config set carries just the
> + * key-value pairs.
> + */
> +int perf_config__set_variable(const char *var, const char *value)
> +{
> +	char path[PATH_MAX];

[Severity: Low]
Does this file need an explicit #include <limits.h>? The function uses the
PATH_MAX macro, and while glibc may implicitly include it through other
headers, strict musl compilation might fail without the required
POSIX-specified header.

> +	char *user_config =3D mkpath(path, sizeof(path), "%s/.perfconfig", gete=
nv("HOME"));
> +	const char *config_filename =3D config_exclusive_filename ?: user_confi=
g;
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
> +	if (perf_config_set__write(set, config_filename, /*system_config=3D*/fa=
lse) < 0) {

[Severity: High]
Could hardcoding system_config to false here risk wiping out the system
configuration file?

If a user sets PERF_CONFIG=3D/etc/perfconfig (setting config_exclusive_file=
name),
this call to perf_config__set_variable() will read that file. Because the f=
ile
path matches perf_etc_perfconfig(), all loaded items are flagged with
from_system_config =3D true.

When perf_config_set__write() is then called with system_config=3Dfalse, it
checks:

tools/perf/util/config.c:perf_config_set__write() {
...
		if (!system_config && section->from_system_config)
			continue;
...
}

This actively filters out items that originated from the system config, whi=
ch
could effectively truncate the file and cause data loss for the system-wide
configuration.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D3
