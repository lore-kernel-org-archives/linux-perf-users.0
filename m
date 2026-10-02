Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6BA46C840
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932396; cv=none; b=BwwFKpZToA/9X8DA7n0GK6fa2smudxVq8MFN5nUuyko5GKBis9PEKykS/S2JEYrGnQHPCoysV02FQzf21pMuehtUiHpLage3/s4Sq0O+w+LU1hyX8w0fTXA7RAvfyaXHdldOwM8lwzYt8yjcX4jnYI5rptZ083QktecYU8OQUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932396; c=relaxed/simple;
	bh=jlDZbJgi3v7UCHwUNjI9s0VJzVptjbV5dzHZigtvygY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sG8Y68k4ywsdaAqL4oS8xCHjskym3SX7O+WqRt5SY9TNo45CM6y0p+ioF7vSp+9Sm9oFnDYMAWsyUOkGXS0iMThELkIlAsl9RMzSstdq14Xe1AVdhYkzE/ZqcsoMxrNKlfIQbYoHn3RmEDaLieXk/mZNj5Mv8touTPxUSaDYlDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRab4cq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRab4cq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6401F0089A;
	Fri,  2 Oct 2026 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932393;
	bh=/MQ+JFysrsURWz9svNPT14LcoFA8Wk9MsdvoI+kJDVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRab4cq6JcoQqvlhJyOvuDVAAbtOX9EwoQVIVW5dy1sGWc2dGCE7AIoZSms88IyTo
	 Q3iaXwLK+6y/qcH0K9RRLUMY57wdeoNi0F0WfAVMOwj322COe9h+eKqYNnRXlY9cph
	 87FzHOtmHbNYl2bCnvX0cfdcJ6zSqkRDDK24qt3IJo0J6Pa1M6TE5UEA3Da6C1PzIj
	 WZY5A0XYgveOItA+uFBBNti13wxisUjKdjYbeHX2dVBouZXISD2pX2y+BctuL1fAe+
	 /A/g9Ie2HLYpaxUfTNG5ScTlG7Bt/dRmheYYEMTWpZ4YL7pJtlZamAjBOxUMQE+c6s
	 /xMLKkuFGjrbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/9] perf config: Serialize config file access with a
 mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001185400.2754753-6-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
 <20261001185400.2754753-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:13 +0000
Message-Id: <20261002091313.6A6401F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: DO_ONCE lacks memory barriers causing double-checked locking=
 race
--

commit 0b6c61f1a2ea254be797a11efae079eb0c53f03d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf config: Serialize config file access with a mutex

This commit serializes perf config file access using mutexes to support
concurrent reads and writes from background features. It also replaces the
lazy initialization of system_path() and home_perfconfig() with DO_ONCE() to
prevent string leaks when accessed by multiple threads.

> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 6e0ff8a9140cc..287401f159e66 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c

[ ... ]

> @@ -565,21 +571,24 @@ static int perf_config_from_file(config_fn_t fn, co=
nst char *filename, void *dat
>  		fclose(f);
>  		config_file_name =3D NULL;
>  	}
> +	mutex_unlock(&config_mutex);
>  	return ret;
>  }
> =20
> -const char *perf_etc_perfconfig(void)
> -{
> -	static const char *system_wide;
> +/* system_path() allocates, so it is computed once. */
> +static const char *etc_perfconfig;
> =20
> -	if (!system_wide)
> -		/*
> -		 * ETC_PERFCONFIG is absolute, so its unresolved path is
> -		 * the same string, better than the callers crashing.
> -		 */
> -		system_wide =3D system_path(ETC_PERFCONFIG) ?: ETC_PERFCONFIG;
> +static void perf_etc_perfconfig__init(void)
> +{
> +	etc_perfconfig =3D system_path(ETC_PERFCONFIG);
> +	if (!etc_perfconfig)
> +		etc_perfconfig =3D ETC_PERFCONFIG;
> +}
> =20
> -	return system_wide;
> +const char *perf_etc_perfconfig(void)
> +{
> +	DO_ONCE(perf_etc_perfconfig__init);

[Severity: High]
Does this use of DO_ONCE() introduce a double-checked locking race?

The DO_ONCE() macro in tools/perf/util/mutex.h implements a lockless check
of the ___done flag without memory barriers:

        if (!___done) { \
                mutex_lock(&___once_lock); \
                if (!___done) { \
                        fn(__VA_ARGS__); \
                        ___done =3D true;

Because of the missing barriers (such as smp_load_acquire and
smp_store_release), a second thread can observe ___done =3D=3D true out of
order, before the stores initializing etc_perfconfig become globally
visible.

Can this result in returning an uninitialized NULL value to callers relying
on a valid string?

> +	return etc_perfconfig;
> +}
> =20
>  static int perf_env_bool(const char *k, int def)

[ ... ]

> @@ -637,19 +646,18 @@ static char *home_perfconfig(void)
>  	return NULL;
>  }
> =20
> -const char *perf_home_perfconfig(void)
> -{
> -	static const char *config;
> -	static bool failed;
> -
> -	if (failed || config)
> -		return config;
> +/* home_perfconfig() allocates and warns, so it is computed once. */
> +static const char *home_config;
> =20
> -	config =3D home_perfconfig();
> -	if (!config)
> -		failed =3D true;
> +static void perf_home_perfconfig__init(void)
> +{
> +	home_config =3D home_perfconfig();
> +}
> =20
> -	return config;
> +const char *perf_home_perfconfig(void)
> +{
> +	DO_ONCE(perf_home_perfconfig__init);

[Severity: High]
Could this similarly risk returning a NULL pointer due to the non-atomic
DO_ONCE() implementation described above?

> +	return home_config;
> +}
> =20
>  static struct perf_config_section *find_section(struct list_head *sectio=
ns,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001185400.2754=
753-1-acme@kernel.org?part=3D5
