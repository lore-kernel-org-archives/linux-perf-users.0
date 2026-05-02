Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754C2F6596
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777708411; cv=none; b=H4lTS+OuwwYhKqryuAY8kQzC1MpC00G0a8KQAmk+QYLv6ym1e6K3VGE0b30hB/oMXxh6Fz2MiGMxqMwDK561BP+vsPBeUvJPvCtGVBb/VOmILLoiEa/VlM2hNjcy1Hbuaka2lF+YKJ65jx5sYiC6ABwrsUhmnx61AVGSlZGlHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777708411; c=relaxed/simple;
	bh=xcMZZzFJoqrCub1O3rouN9biIvDKQwMYLo5J8yiw9P0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fSvAJs9OzMsjeSKoXmLaS0RvSBtgEZ4H5zUhtrurDqwcfVik0IgUpg7eIlbaj0KU2PG2dVKrnF1Oatg0G8+NnL0vdVwYXH7en2qPKVEgM01jN9T/Fh+iysmjo9gLqnjbReH8khcNtrreH6+LwqNLct76NDMnzQz4b0ZBmh6cu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP+8SLLG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP+8SLLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD1EC19425;
	Sat,  2 May 2026 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777708411;
	bh=xcMZZzFJoqrCub1O3rouN9biIvDKQwMYLo5J8yiw9P0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sP+8SLLGJ4xFjmIeo4guiAcnaWWvb6mVW+NhMM8MAcXfsqctgsMQn3zV5I72mNMSw
	 brDGcE+I0K3lcmljov7q/rfxzyug2ECRFnXnzYHKi+eJmZCuWj0Io7HvyamqXe+iF+
	 wccS9SaVgpWVnvn5V59d/nlTgCPerx0BSe1t6UbwF3V5IhgcypUMkLmOuqjlftffSd
	 g8e+pdPYh+HSXKgSX/IVGtyZIe4z4Rr0/bqD8QYpqaXEoNRNlCXgIch1LZ5M9VK8hP
	 EfW4tPd57/rH7LtsHq0p0M0DnwT9u9yDkZqa67SzCgvN1prdQLtaLM5ULFw23RPwjC
	 kdpbz6lXX0c7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/17] perf env: Add helper to lazily compute the
 os_release
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260502065935.291960-16-irogers@google.com>
References: <20260502065935.291960-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:53:30 +0000
Message-Id: <20260502075331.0AD1EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incomplete refactoring: The JSON data converter was missed and d=
oes not use the new lazy initialization helper.
- [Medium] Context leak: Assuming uninitialized `os_release` always implies=
 live mode incorrectly pollutes offline trace conversions with the host's k=
ernel version.
--

commit a08c8b8c77a407cf0d562bc6f755d7e0c00f4156
Author: Ian Rogers <irogers@google.com>

    perf env: Add helper to lazily compute the os_release

This commit introduces a helper function, perf_env__os_release(), to lazily
initialize the OS release string when it is not populated. It updates the C=
TF
data converter and other sites to use this helper. The helper assumes that =
if
os_release isn't initialized, perf is running in live mode and uses uname()
as a fallback.

> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-con=
vert-bt.c
> index 3b8f2df823a9..2c88420fe33e 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -1414,7 +1414,7 @@ do {									\
> =20
>  	ADD("host",    env->hostname);
>  	ADD("sysname", "Linux");
> -	ADD("release", env->os_release);
> +	ADD("release", perf_env__os_release(env));

Was the JSON data converter missed in this refactoring?

The CTF converter was updated to use the new helper, but the JSON converter
in tools/perf/util/data-convert-json.c still accesses the field directly:

tools/perf/util/data-convert-json.c:
    ...
    output_json_key_string(out, true, 2, "hostname", env->hostname);
    output_json_key_string(out, true, 2, "os-release", env->os_release);
    output_json_key_string(out, true, 2, "arch", env->arch);
    ...

This leads to inconsistent behavior where the JSON converter outputs an emp=
ty
string or null if os_release is uninitialized, while the CTF converter
outputs the host's release string.

>  	ADD("version", env->version);
>  	ADD("machine", env->arch);
>  	ADD("domain", "kernel");

[ ... ]

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 5944acd28996..1090aaa2985f 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -339,6 +339,27 @@ int perf_env__kernel_is_64_bit(struct perf_env *env)
>  	return env->kernel_is_64_bit;
>  }
> =20
> +const char *perf_env__os_release(struct perf_env *env)
> +{
> +	struct utsname uts;
> +	int ret;
> +
> +	if (!env)
> +		return perf_version_string;
> +
> +	if (env->os_release)
> +		return env->os_release;
> +
> +	/*
> +	 * The os_release is being accessed but wasn't initialized from a data
> +	 * file, assume this is 'live' mode and use the release from uname. If
> +	 * uname or strdup fails then use the current perf tool version.
> +	 */
> +	ret =3D uname(&uts);
> +	env->os_release =3D strdup(ret < 0 ? perf_version_string : uts.release);
> +	return env->os_release ?: perf_version_string;
> +}

Does this fallback to uname() incorrectly pollute offline trace conversions
with the host's kernel version?

If a perf.data file was recorded without the HEADER_OSRELEASE feature,
env->os_release will be NULL.

When running perf data convert --to-ctf on such a file, this helper will
execute uname() and write the host machine's OS release into the trace
environment.

Prior to this patch, a NULL os_release was safely omitted from the CTF
export.

Injecting the converter's host kernel version into offline trace metadata
falsifies the environment in which the trace was originally recorded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502065935.2919=
60-1-irogers@google.com?part=3D15
