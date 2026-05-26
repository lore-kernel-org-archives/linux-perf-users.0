Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA99A18DB1A
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834681; cv=none; b=VIvNvAjT34B+Rt0n2OO2CLMlQFa3SnOtZdAGX4V+UExmpeGiOKQr2B8bhjRc4I1e6jsIMqM4uBTcac3xBB3jrvehFk9wszgkRkFVodU7j9OipOyS48G9FcKzIFb5mx95zpcDvIFG7LUQ5o906ngHZE4NzjccYwkFgptdH0yLbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834681; c=relaxed/simple;
	bh=FfNyBBZG9Ji89gOCie+tXRC9uogAnOwn9ZMT/WFiFBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PkE5xej23EoWET0cL6plA9U2alRHZUic1s4bmpUr8qMoWYLA3OWZTdPPkKUsZILA0l6awTz/Lw6L3mIo9FwssCbyUw7VO+7+mIaronb1khipHqD/wptnsmFZUf15ZS3FGcvsPpt+l1MV5rXID3l37RdyCDXNqIqqapu5bLq/K+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyMtsqrE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyMtsqrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CF91F000E9;
	Tue, 26 May 2026 22:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779834680;
	bh=qf8AFiYie2AZ7bXFKIn3R67B+5WN/SRwd0Vz/0m7mTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyMtsqrEFL3AgkmKrPdQJzgi904HG0WLbTKZtSzyFs/e5bymJn3bit4AXetGoC7PL
	 xIa4G1G8FeraCbfvjdYDQbYR41T4Ws8M0Ud54HTk/qo912LJ2w0nbG7M+RQnTaI4VK
	 NQPYmVUmWmZmBGfIWB9nWGd58DO1xaCqtYyXW7hkPWNpDqIzFbKweTb/iMCfLe9jfI
	 8RHrtD4bf1UrDonvElKse9JlPBtkwcBvGWqptOfojRe4P7l7kQz5mc88hKI8RselQk
	 T88D3CrSB36n7a8kJZCABiUgr+EaSvG+IRU3CYiUQiJyeAvVhYk9dtZhZgJpc67fZH
	 2oF0f6g0kK7eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/29] perf session: Snapshot event->header.size in
 process_user_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-29-acme@kernel.org>
References: <20260526211806.1193848-29-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 22:31:19 +0000
Message-Id: <20260526223120.02CF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Vulnerability Fix / TOCTOU Bypass on event->header.size
- [High] Type Confusion / Validation Bypass (TOCTOU on event->header.type)
- [High] TOCTOU / Bounds Check Bypass on Payload Array Counts
- [High] Incomplete TOCTOU Fix / Unprotected Reads in Other Event Paths
--

commit 80788dea311fbc98ef2cb9a00824d6f40689bd54
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Snapshot event->header.size in process_user_event()

This commit attempts to fix a vulnerability where multiple reads of
event->header.size from MAP_SHARED memory could return different values.
It snapshots the header size into a local variable using READ_ONCE() to
ensure a consistent value is used for bounds calculations.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 6de665d3c9054..e2e821b77766d 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2230,6 +2230,7 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>  {
>  	struct ordered_events *oe =3D &session->ordered_events;
>  	const struct perf_tool *tool =3D session->tool;
> +	const u32 event_size =3D READ_ONCE(event->header.size);

[Severity: High]
This is a pre-existing issue, but since structural bounds validation is
performed earlier by callers like perf_session__process_event() calling
perf_event__too_small(), can the size be modified in MAP_SHARED memory
between that caller validation and this READ_ONCE() snapshot?

If the size is shrunk concurrently, could subsequent subtraction operations
like (event_size - sizeof(event->stat_config)) underflow, bypassing array
bounds checks?

[Severity: High]
This is a pre-existing issue, but does this function also need to protect
event->header.type with a READ_ONCE() snapshot?

If an attacker sets the type to a small struct to pass the size check in
perf_event__too_small(), and then concurrently overwrites it to a larger
struct type, will this function process it as the larger struct using a
size validated for the smaller one?

[ ... ]

> @@ -2271,7 +2272,7 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>  		break;
>  	case PERF_RECORD_HEADER_BUILD_ID:
>  		if (!perf_event__check_nul(event->build_id.filename,
> -					   (void *)event + event->header.size,
> +					   (void *)event + event_size,

[Severity: High]
This is a pre-existing issue, but does this READ_ONCE() pattern need to be
applied to other execution paths that process memory-mapped events?

For example, perf_session__deliver_event() delegates to
machines__deliver_event(), which appears to still read event->header.size
directly from memory to calculate string boundaries before calling
perf_event__check_nul().

Could concurrent modification of the size allow the string checker's
strnlen() to scan out-of-bounds unmapped memory?

>  					   "HEADER_BUILD_ID")) {
>  			err =3D 0;
>  			break;

[ ... ]

> @@ -2304,14 +2305,14 @@ static s64 perf_session__process_user_event(struc=
t perf_session *session,
>  	case PERF_RECORD_THREAD_MAP: {
>  		u64 max_nr;
> =20
> -		if (event->header.size < sizeof(event->thread_map)) {
> +		if (event_size < sizeof(event->thread_map)) {
>  			pr_err("PERF_RECORD_THREAD_MAP: header.size (%u) too small\n",
> -			       event->header.size);
> +			       event_size);
>  			err =3D -EINVAL;
>  			break;
>  		}
> =20
> -		max_nr =3D (event->header.size - sizeof(event->thread_map)) /
> +		max_nr =3D (event_size - sizeof(event->thread_map)) /
>  			 sizeof(event->thread_map.entries[0]);
>  		if (event->thread_map.nr > max_nr) {

[Severity: High]
This is a pre-existing issue, but while event_size is snapshotted, are
array count fields like event->thread_map.nr still vulnerable?

If event->thread_map.nr is validated here against max_nr, but downstream
handlers like thread_map__new_event() re-read the count directly from
MAP_SHARED memory, could an attacker overwrite it with a huge value after
this check to cause out-of-bounds heap allocations?

>  			pr_err("PERF_RECORD_THREAD_MAP: nr %" PRIu64 " exceeds max %" PRIu64 =
"\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D28
