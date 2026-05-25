Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561726ED37
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779676793; cv=none; b=liCq7NMSvIsn2eB8OboWdNTEHz3sYw6Vzph5ev4+dvz/sOdF3uVLyv62v2pFfm7vJqiZF35keGWwNpmPCZ4dlj9T3zAkVuiXvSmGOsbCmj7HumTrn1s1PHctEMnZ4M0vZ2XG7hpqjOQCFKj1gipOMVmv3LSQyFnyiSG4kaimmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779676793; c=relaxed/simple;
	bh=Tbs4shTOX92VyKXqUNb5GXBa3NoB1hBDrI1WTNsl094=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BCL7z5AQgNsSJqzx2WPdC3iBVB86haWWjk+k9WykB4WQNlA1GiXg5ZGb7wk/c19lBlUvCsj27WnpYmj0xFRTTm2SDBxLePSYT5czXeplLij4+qrINMN3OV3QRTUeuTL/1hp4JvYjZPDjfdG4yR4R/SVl47t35Kcrc/DfvBZLZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8uTDE4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8uTDE4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD511F000E9;
	Mon, 25 May 2026 02:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779676792;
	bh=R5zobf5v6lZzA6O/Roh178H26037VI59kQKbd3YY7Go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K8uTDE4v5owvjHD8pAcahvhveoAWAXQiyW9nsoDfgAqTU/JVqFmDM57J40IDDqeL+
	 XC+nu6dO8eaghcjPbZyskRn3CI/+YRqvqdtu7lH3x/kNHrDUGNcgJ9dygcO6mDT++f
	 BUGzCtzyVlWPkEWxQKeMqQSDoUniYRzkI1cgXhv/7rqcMe3dwiFlNXT/eC64U5bi/N
	 bDaVes4TATCw4GSmqipmCE3vknkfW62NS0jeWAjaboVC1JHHiXMcuZ/abh/oaCv7j0
	 NlVVyEZ9SLgWKmmYOPgAC7Nq/sD6O+ifyEPPfJaPrXAF3JavNU/tr0eoEeFqcNbQWO
	 TRNA7tqdfkIXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/29] perf session: Snapshot event->header.size in
 process_user_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-29-acme@kernel.org>
References: <20260525010550.1100375-29-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 02:39:51 +0000
Message-Id: <20260525023952.1CD511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The TOCTOU fix introduced by the patch is flawed: the snapshot of =
`header.size` occurs after validation, and `header.type` is never snapshott=
ed, allowing bounds check bypass and integer underflows.
--

commit 36fac76844a65514769993cd4f5609b5d5df553e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Snapshot event->header.size in process_user_event()
   =20
This patch attempts to mitigate a TOCTOU vulnerability in perf session event
processing. It snapshots event->header.size using READ_ONCE() at the
beginning of perf_session__process_user_event(). The snapshotted size is
then used for subsequent calculations to prevent concurrent modifications
from bypassing validation.

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
This isn't a bug introduced by this patch, but since the snapshot of
event->header.size happens here, is it possible for an attacker to shrink
header.size after the caller (perf_session__process_event()) has already
validated it via perf_event__too_small()?

Additionally, is it possible for an attacker to modify event->header.type
concurrently?

Since header.type isn't snapshotted, could an attacker swap a valid small
event type to a larger one (such as PERF_RECORD_STAT_CONFIG) after the
caller validated the smaller minimum size requirement?

[ ... ]

> @@ -2389,8 +2390,8 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>  		break;
>  	}
>  	case PERF_RECORD_STAT_CONFIG: {
> -		/* Cannot underflow: perf_event__min_size[] guarantees header.size >=
=3D sizeof */
> -		u64 max_nr =3D (event->header.size - sizeof(event->stat_config)) /
> +		/* Cannot underflow: perf_event__min_size[] guarantees event_size >=3D=
 sizeof */
> +		u64 max_nr =3D (event_size - sizeof(event->stat_config)) /
>  			     sizeof(event->stat_config.data[0]);

[Severity: High]
This is a pre-existing issue, but if the type is swapped or the size shrinks
after the caller's validation, could event_size end up being smaller than
sizeof(event->stat_config)?

If so, won't event_size - sizeof(event->stat_config) integer-underflow into
an enormous value, bypassing the max_nr bounds check and leading to
out-of-bounds reads when processing the event payload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D28
