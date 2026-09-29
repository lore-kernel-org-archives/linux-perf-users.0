Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F03E1694
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718368; cv=none; b=FfIyCTPyQVR3+jzAp4Hi+N/xUGsmkoMQ1TvuFnEYI7qT6eTK4dOYItb0LJieR0Eda5UMuy8HJj1rPbN7tCYE85kj3sLt2L57934GpmAGnVOq2iaHk2kd81dQ8zgPGKWx6g+GqNoaiJflBBzlAmO85mrWQEzI1qLc6P9Nba4k9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718368; c=relaxed/simple;
	bh=586Tr+H5IAPhYIddI8H3s6+8TLykjOeIZnIaVEH8Z+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IHPw74OflYSeJQTQHff1U0OAXnuxl6SycOXUNztJXzYnqAu4gUOXPsVQsAV7/OFkx657hhmAS0864XZqq48/2tgB7CWx1RnQJ9zD5ZPZLfSt8ZGm/epssihtoxdelF/5reAmkAR5qguoRmnYpaU1rO7Gg/hWCdu5A6idrmnEsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEhEjVrz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEhEjVrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DEA1F000FF;
	Tue, 29 Sep 2026 21:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790718358;
	bh=l2Rw1NYR2CMBCg10pfki1QKC9M5nuyoA62U2P+lEgno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEhEjVrz/pXYW6ZfxU036sOas8yBBypIRnBo7egVLQztQ9e7bM1RoDUllZtihJuVf
	 qGQ/4+r5+MsPX+YjMd2FSAvAbIye/0N3YtggFhA3IiMRH1ovkUu6XWWaOMkfyJtd7h
	 xrGQCAq7+hziT0Q8pqkpJKA9berrlxQmnei1mWdVyySSB7+chQBMxFavbXFoTgFDDB
	 lM5ho6nSoezzIXVkqSID705OfXBr2RYbStDCAp5ooE+I1kwgWFEuFBhAUbkehiEKeT
	 s/sMRLB41/3ZL+4+v4Ifj4DPcTuA0a4BleHyDD0fGWEyt4/r8xetOO8BELjpLIvIOG
	 KW2VjGDssxpxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929212246.2532021-2-acme@kernel.org>
References: <20260929212246.2532021-1-acme@kernel.org>
 <20260929212246.2532021-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 21:45:57 +0000
Message-Id: <20260929214557.C5DEA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf config: data race on config_file_name causing NULL derefere=
nce in bad_config()
- [Medium] perf config: memory leak in perf_home_perfconfig() and perf_conf=
ig__init() due to concurrent access
--

commit 6feab70cc124ed967d7949683aa5b69b49d7b578
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf config: Move perf_config__set_variable() to util/config.c

Move perf_config__set_variable() out of the perf config builtin so
that opt-in features can persist their choice from outside it. All config
file access shares the static parser state and can now run on more than
one thread, so parsing and rewriting are serialized with a mutex.

> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 8fe43b032e9af..b33964be0c14a 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -549,11 +551,26 @@ int perf_default_config(const char *var, const char=
 *value,
>  	return 0;
>  }
> =20
> +/*
> + * Serialize config file access: parsing and rewriting share the static
> + * parser state and can run on more than one thread, the debuginfod
> + * fetch writing core.debuginfod=3Dfalse while perf top reads it.
> + */
> +static pthread_mutex_t config_mutex =3D PTHREAD_MUTEX_INITIALIZER;
> +

[Severity: Medium]
Since this patch enables multithreaded access to the configuration state,
can concurrent calls to lockless lazy initialization functions leak memory?

For example, in perf_home_perfconfig():

tools/perf/util/config.c:perf_home_perfconfig() {
	static const char *config;
	static bool failed;

	if (failed || config)
		return config;

	config =3D home_perfconfig();
	...
}

If two threads evaluate config as NULL simultaneously, could they both call
home_perfconfig() and overwrite the first thread's allocation, leaking the
allocated config path string?

Similarly, in perf_config__init():

tools/perf/util/config.c:perf_config__init() {
	if (config_set =3D=3D NULL)
		config_set =3D perf_config_set__new();
	...
}

Could concurrent threads duplicate the parsing and leak the resulting global
configuration set structure?

[ ... ]

> @@ -783,8 +819,15 @@ static int collect_config(const char *var, const cha=
r *value,
>  int perf_config_set__collect(struct perf_config_set *set, const char *fi=
le_name,
>  			     const char *var, const char *value)
>  {
> +	int ret;
> +
> +	pthread_mutex_lock(&config_mutex);
>  	config_file_name =3D file_name;
> -	return collect_config(var, value, set);
> +	ret =3D collect_config(var, value, set);
> +		/* Don't leave the static parser state pointing at the caller's buffer=
. */
> +	config_file_name =3D NULL;
> +	pthread_mutex_unlock(&config_mutex);
> +	return ret;
>  }

[Severity: Medium]
Does this temporary modification of config_file_name introduce a data race
with unlocked readers?

While config_mutex is held here, another thread might execute perf_config()
and call bad_config() concurrently:

tools/perf/util/config.c:bad_config() {
	if (config_file_name)
		pr_warning("bad config value for '%s' in %s, ignoring...\n",
			   name, config_file_name);
	...
}

Since bad_config() does not hold config_mutex, if thread A evaluates
config_file_name as non-NULL, and thread B immediately sets it to NULL in
perf_config_set__collect(), could thread A then pass a NULL pointer to the
%s format specifier in pr_warning()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929212246.2532=
021-1-acme@kernel.org?part=3D1
