Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B273E51FD
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415731; cv=none; b=A9ghW760zLDlxIoN6CsA8up1/aXljxJs0BaHzbT29SCj2rQqmc0InhtkwnmE58wg9n3NkaBTdBK6ywxi7E+RWHsI5Z1Fu8qjhEBqAOiPTpx6Iu+e73RWksMXhhHg9By5NMQ9FUj86RnfyRFwDSLZKp0cZ9doBDI8FoUhVNWweDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415731; c=relaxed/simple;
	bh=WhlyVm835evop7XOMvOPGHkTLWBfXEWwdt/VEldDhaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lMF1CUAv6fFrqD4fS3mSzGoVHky5iSPC1YIVYcpomQVsJ7Io5EkWp6cLwti85KvZ6vg/e3HGbi1FLV/ChZPQOdPSeiDlf3KhvB5RlbDjvl5X+3ZA19xSUgrsG7cYPMcI3UjqD3zBKKzXTieYeFIeFmS6+ftHWEOYwhW4FCsgLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeCB3fm7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeCB3fm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD4A1F00893;
	Tue,  2 Jun 2026 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780415730;
	bh=j0ji1Rm9OfbY3ID0Ts/IsZ20lHfTaJLXIpTqsadMhjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CeCB3fm79cy2IaU3/HgWB9xut82AHZWGsFLiAyya34QDx9D1fDqNMZAjcGmif+Zxd
	 hEhZZPZocZwwYEZMT4BUA6sk8xjOygVpOWx/UKa90wnCR7MQ4R6wjKCE6hHjROFtyi
	 75zDQI+NQM71Q7X3lxbGAB1u71Y4fatu/GR63r/Gqgx2q/iFA5dKqa1gUlrw5w90Qw
	 wOcu9Ky5GJnGqFo1e7mAg/uz+xs9UiApYxsJIvBzAo0eo+h2MGkH6Itbk/Z1dqEKs/
	 /A3XvJBe7j0nkojvtGLTe2bPt5dYwS/IH3s5K7klfkQWWQrjNkLOnIErXf26Gl57va
	 +rbGrChC6xyUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 17/19] perf env: Add helper to lazily compute the
 os_release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602152516.2831152-18-irogers@google.com>
References: <20260602152516.2831152-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:55:30 +0000
Message-Id: <20260602155530.7AD4A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Premature lazy initialization in pipe mode poisons `perf_env` with=
 the host's `os_release`, corrupting JSON/CTF exports and offline symbol re=
solution.
--

commit 1b9df6eca5b172acf3ec3492723767468d3b5ec6
Author: Ian Rogers <irogers@google.com>

perf env: Add helper to lazily compute the os_release

This commit introduces a helper to lazily initialize the os_release
string in the perf environment, falling back to the host's release via
uname when the environment indicates live mode.

> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-c=
onvert-json.c
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
[ ... ]
> @@ -296,7 +297,8 @@ static void output_headers(struct perf_session *sessi=
on, struct convert_json *c)
>  	output_json_key_format(out, true, 2, "feat-offset", "%" PRIu64, header-=
>feat_offset);
> =20
>  	output_json_key_string(out, true, 2, "hostname", env->hostname);
> -	output_json_key_string(out, true, 2, "os-release", env->os_release);
> +	output_json_key_string(out, true, 2, "os-release",
> +			       perf_env__os_release(env));

[Severity: High]
In pipe mode, feature headers are received as interleaved events in the data
stream, so the environment is not fully populated until
perf_session__process_events() runs.=20

Because output_headers() is called before the stream events are processed,
will calling perf_env__os_release() here trigger the uname fallback and
cause a regression that permanently writes the host's release string to
the json output instead of the guest's?

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
[ ... ]
> @@ -361,6 +361,44 @@ bool perf_arch_is_big_endian(const char *arch)
[ ... ]
> +const char *perf_env__os_release(struct perf_env *env)
> +{
[ ... ]
> +	/*
> +	 * If env->arch is set, this is an offline target environment.
> +	 * If the os_release is not populated in the file, we do not want
> +	 * to poison it with the host's release which would break guest checks.
> +	 */
> +	if (env->arch) {
> +		release =3D NULL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * The os_release is being accessed but wasn't initialized from a data
> +	 * file, assume this is 'live' mode and use the release from uname. If
> +	 * uname or strdup fails then use the current perf tool version.
> +	 */
> +	ret =3D uname(&uts);
> +	env->os_release =3D strdup(ret < 0 ? perf_version_string : uts.release);

[Severity: High]
Does this caching behavior cause a regression in offline symbol resolution
for unparsed pipe streams?

If the architecture string is not yet set because the pipe stream hasn't
been parsed yet, this helper assumes live mode and caches the host's release
in the environment structure.=20

Could this cause early callers, such as vmlinux_path__init() during symbol
initialization, to search for the host's kernel symbols instead of the
target's?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602152516.2831=
152-1-irogers@google.com?part=3D17
