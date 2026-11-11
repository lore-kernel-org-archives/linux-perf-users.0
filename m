Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396800;
	b=uSQUFboiB14KkbpU7cVvic3V3xSL71ycVqlAX9t0ys0M+NAAZB6vRAteJcse6ODvjcRQ
	 xWg+LMs8l/FGqwcZr8830iS7DmwblWlSQ0hOaccTAnRIb2mTbpw+mAUelQ2ujJgc8xgr0
	 l7/DKJtrvTpaa9OKMU/gj59a5oe1N3xk+hvt6UWUAg46s7YN6mD2one6CtEUD9Dwm4eEt
	 oF9rFuj/rpQsFsNVGXAqHmmp1ykk9MeVhJhaPU0iKCFp0ZTW1wJCf/TIfpW3GNMsa88DH
	 e9FuiMGdkVMihxNQf4tCkMV0sMH0kPGUPH0E/AqjZBTUi0iYTXE8VLVhi3iUWya4ZQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396800;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7xoCqPs9xS4R/pbtc5UVr/jM7Lrae8advgryyJ65YxQ=;
	b=22IyW5temmFgpsOe/wRFmDp0K1ImsssZz3tGBkLPynrCdXH+uONWlKr7I5ysYYNOhpgG
	 hbNcHFFPGNLWBouGARPyvJnFNnFeD69W/ERKbhg/L6H/npMxXD72EhwrT9+Rbs3CCfF4n
	 GUj6napN/bkjOLthzvsuPf6ecPg94kFNc9yx6hFLzb4Z0VGhm4VrFLwrZRmCSupVzn36y
	 8HIemTKj1xvg99gfvsuZ9T4//JUkJsB8V8oYPQzrU+GhEGfFaWWyae/zoxI2ZMlE14Z7j
	 lKY2I5BnTOXak0UZyormUF75DqKOOytqAwXmgUXOt46z4M1rnzt9XOnCb5XDLMtdtzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a57s14s+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF6606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a57s14s+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB3B1F00A05;
	Wed, 11 Nov 2026 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794396800;
	bh=7xoCqPs9xS4R/pbtc5UVr/jM7Lrae8advgryyJ65YxQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=a57s14s+8e1E87Tna6D+AU2q/jCrLAdmNlPZcwOBMQES+PX5oUqOqaA9tgXibqeOC
	 DJGT7cbpn7uPCac4hMSY5CMQ4rV/xYhAde1HN1LZR1LDeepivQRd7rhkx1N0dE/l5A
	 89VBhtsU5eLgq0Z7XgHh0uOcdRat3Q/QbD8isqDQR+VypDS7EDnZdsCAXSdk2o3oB0
	 5SZIaqvJ8ilZsoC3upwEFIyuRhx+vJbkZly3CLNZVI84P4tuPG89CRyxLiqYZrrrny
	 xSBzYCfU3Dxj2Hme7JRe9i8oE5I7hZStagNr5nNVYvYeWDe8kU2/mvoeg4JXRG2a39
	 o6j5mMK4f+7rw==
Message-ID: <sashiko-outbox-208886@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf stat: Count kernel events in a group led by a
 tool event
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111110616.2249764-1-takano32@gmail.com>
References: <20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com>
 <20261111110616.2249764-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:33:19 +0000
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
- [Medium] perf stat: broken tool event enable/disable for -D,
  --control, and exec in create_perf_stat_counter()
--

commit 0e981d5b2ece1f32ac47445309993697c6cdb096
Author: Hang Zhengyang <hang.zhengyang1010@gmail.com>

perf stat: Count kernel events in a group led by a tool event

This commit opens members of a group led by a tool event on their own
with group_fd =3D -1 and without PERF_FORMAT_GROUP, while opening kernel
event members initially disabled.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 37752d6bfef45..57956f55ea09b 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
[ ... ]
> @@ -748,9 +749,16 @@ static int create_perf_stat_counter(struct evsel *ev=
sel,
>  	/*
>  	 * Disabling all counters initially, they will be enabled
>  	 * either manually by us or by kernel via enable_on_exec
> -	 * set later.
> +	 * set later.  A kernel event that a tool event leader has as
> +	 * a member is not in the kernel's group either, so it has to
> +	 * be opened disabled to start together with the workload.
> +	 * A tool event member counts from open and is only stopped by
> +	 * an explicit disable, so leaving it enabled here keeps its
> +	 * count; disabling it would leave nobody to start it when
> +	 * perf relies on enable_on_exec.
>  	 */
> -	if (evsel__is_group_leader(evsel)) {
> +	if (evsel__is_group_leader(evsel) ||
> +	    (evsel__is_tool(leader) && !evsel__is_tool(evsel))) {
>  		attr->disabled =3D 1;
> =20
>  		if (target__enable_on_exec(&target))

[Severity: Medium]
Does conditioning attr->disabled on leader vs. member rather than
target__enable_on_exec(&target) leave tool event members enabled during
-D / --control and leave tool event leaders disabled during exec
workloads?

In evsel__tool_pmu_open(), attr->disabled sets evsel->disabled =3D true and
start_time =3D INVALID_START_TIME; otherwise evsel->disabled is false and
start_time is sampled immediately at open.

When !target__enable_on_exec(&target) (such as with -D or --control),
enable_counters() calls evlist__enable(), and evsel__enable_cpu() enables
each member of a tool-led group via evsel__tool_pmu_enable_cpu():

tools/perf/util/tool_pmu.c:evsel__tool_pmu_enable_cpu() {
	if (!evsel->disabled)
		return 0;
    ...
}

Because a tool event member in a group like '{user_time,system_time}' is
skipped by !evsel__is_tool(evsel) and opened with attr->disabled =3D=3D 0,
evsel__tool_pmu_enable_cpu() returns early without resetting start_time,
so the member counts continuously through the disabled delay window.

Conversely, when target__enable_on_exec(&target) is true (such as
'perf stat -e "{user_time,cycles}" -- sleep 0.2'), enable_counters() skips
evlist__enable() because kernel events are enabled on exec.  A tool event
leader still matches evsel__is_group_leader(evsel) and opens with
evsel->disabled =3D true; nothing enables it on exec, so
evsel__tool_pmu_read() returns 0.

Should tool events instead set attr->disabled =3D 1 only when
!target__enable_on_exec(&target), regardless of whether they are the
group leader or a member?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111110616.2249=
764-1-takano32@gmail.com?part=3D1
