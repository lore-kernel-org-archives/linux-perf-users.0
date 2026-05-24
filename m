Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067A1CD1E4
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779597070; cv=none; b=WK0yuyKCcvZzC9/dr6KjZA3YoQQnlgR2A4shsuVpB3R3mc30cSz6Z1cZA1Q2YAjxaf6tiio8i4YPuWRpuuApGce4op5gATFEpIWCLZ/OhGvagyR3+r5+okY1kkZF3VyLjdSrttyV8/NoDyhYQnSIDK/95nv09jsIx90UaFdPTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779597070; c=relaxed/simple;
	bh=l3Zw7RZdh+Zd54ILYAA7YqyjNR6PmJ5ckzF7EgbQpf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ph5/U4pvjnPCyoyURGZ4aDB0J2JGnvZqv8YSFb8Qabnf7ADrin1E6bmqHDw5/QbWRK/83BkJ7qh4zdRkxeFo0drA2Q6/J4E0i0nxZ6Lgsw+vm2/I8PB1uaD9UuzcAPEJD47MFxctPKg4fbK4FJi+twkkMtLPbJVeGS650MpeFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpwKSMQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpwKSMQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F771F000E9;
	Sun, 24 May 2026 04:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779597069;
	bh=O5ZyCWQRkPlufvuuw4bB6bb//77r4t89GUgSjPQLyyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LpwKSMQ2OrwD+j4vbBVyXt2Bp8Xvcm8sbqZ5cSlB65XBRX8JQLHkajvtlObguFimi
	 bwjFVhGDgp/nCLA0Ws1oq/KG+pYOOq0zhZWSmmgOp0t9QoOCBKvs7/oiDsj0CjYGKI
	 e2Y92xU1yivtQ+FAhPbsTJMuKl58CpS1nj9tFUyjJAsvbR83FxtZFksaLir3zztqBF
	 Y4iezjBTK1/LNNYuQW2s1e1HBQqwHSU/iCrR0BFGDvJNkTQMO0+sUspPvMLZSXjvwk
	 FGqElQQmZCrddOlTyHlQy8rPawbWo7UQCAMkvJa3HLiJHLsTMWwsprdyQUy6PC2hL1
	 o2uM+TmLTtrMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/29] perf session: Snapshot event->header.size in
 process_user_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-29-acme@kernel.org>
References: <20260524032709.1080771-29-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:31:08 +0000
Message-Id: <20260524043108.E7F771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch attempts to fix a Time-of-Check to Time-of-Use (TOCT=
OU) race by snapshotting `event->header.size` into a local variable using `=
READ_ONCE()`, but takes the snapshot after the size has already been valida=
ted by the caller. This allows an attacker to concurrently shrink the size =
in shared memory, causing integer underflows in length calculations and byp=
assing bounds checks.
- [High] The patch leaves downstream event callbacks vulnerable to Time-of-=
Check to Time-of-Use (TOCTOU) attacks because it passes the original `event=
` pointer, allowing downstream functions to re-read loop bounds and data di=
rectly from untrusted shared memory after upstream validation.
--

commit b0c86c3be4ebfa2c805c53d8b33cdd8c93b7408a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Snapshot event->header.size in process_user_event()

This commit snapshots event->header.size into a local variable using
READ_ONCE() at function entry to mitigate Time-of-Check to Time-of-Use
(TOCTOU) issues. It then replaces various reads of event->header.size
throughout the function with the local snapshot.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 69eb404f805d8..d62cb21920e04 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -2378,8 +2379,8 @@ static s64 perf_session__process_user_event(struct =
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

[Severity: Critical]
This is a pre-existing issue, but is it safe to snapshot the size into
event_size at the start of this function after the caller has already
validated it?

If the event is read from shared memory, an attacker could concurrently
modify the size between the caller's validation and the READ_ONCE() at
function entry, causing it to shrink.

Since this new unvalidated event_size is used in later calculations, couldn=
't
event_size - sizeof(event->stat_config) underflow and bypass the bounds
check?

>  			     sizeof(event->stat_config.data[0]);
> =20
[ ... ]
> @@ -2410,7 +2411,7 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>  		 */
>  		memset(&session->time_conv, 0, sizeof(session->time_conv));
>  		memcpy(&session->time_conv, &event->time_conv,
> -		       min((size_t)event->header.size, sizeof(session->time_conv)));
> +		       min((size_t)event_size, sizeof(session->time_conv)));
>  		err =3D tool->time_conv(tool, session, event);

[Severity: High]
This isn't a bug introduced by this patch, but does passing the original
event pointer to downstream callbacks leave them vulnerable to Time-of-Check
to Time-of-Use (TOCTOU) attacks?

Since the event points directly to untrusted shared memory, couldn't
downstream functions like tool->time_conv() re-read loop bounds or data
directly from the event, bypassing the upstream bounds validation?

>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D28
