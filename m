Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6021D596
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673511; cv=none; b=sfs3nVKb6iR/BNYNDZsxSLxeMHO3MAoFz6zerhbrZ3qwYIBJt/uwkqyKfg5bw3+kEjNFk60bKyv5sl/Q1ddpEjJQr+2lxD1MqsAVJMVFVu77UNK7H4IyTXohDkaF2gIrO3HcIUSaKA5znM66nJBX0KyVGatg8tQ/MXMfkKzen1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673511; c=relaxed/simple;
	bh=7zPNlXivNYTph/OBev2OhE9izvinj7qCoeo5RicGgx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p3afIpGDLVlJTaIFYCvoa3F0sp8WVqltg4mL9rpVLEscbDVPI/UrUXmyyIb/oi4ErHQ8EBpV0HaEMI9myRocPsuf8iihoWC7fcrbvSLfM9KfPlTfC78maCJjXunE5kX9kbGFsSDdVXjPwb+9EEaL1prxn851X3bh58O6ZTyNcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV0PQQEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV0PQQEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3951F000E9;
	Mon, 25 May 2026 01:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779673509;
	bh=/ie1dbZGvKIomxo4fpok03AxplwwUViIx4qZ2YLUL/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CV0PQQEH0OGdsdb4nrl5eIliREjZ0xiWjYCchpUmMRh03EOZUYMqykkl8th+IJvSv
	 DT3dty4tPnQe/hBnLtcGnF4GgJpcXNjm6EoILXBgo3eO2uex3yTQszqK+pGd2+qNEj
	 /yHg6pizR5OO/cxPawVmdUhWlJW1cGW4mn1PNAAQeHd5k4ANK7Arn60vv7fKC6t6l+
	 ej+37j10ySnoVZuAC3spP/w9dhT31krfiMq/XAjcIelOqcJkeHgXC2ezTI3w27Ml+r
	 QhieIXIy21FPSi0mdrlML47/0APdlV19W5zMo3WtkpdDqdOY4dV1pRGEoQklbuqgu9
	 1+JV0bH3tFIVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/29] perf session: Add minimum event size and
 alignment validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-2-acme@kernel.org>
References: <20260525010550.1100375-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 01:45:09 +0000
Message-Id: <20260525014509.BD3951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf_session__peek_event returns -1 for undersized events, prema=
turely aborting peek_events loops, whereas process_event skips them.
--

commit 8d4b5789ad1a0d60851429197cd2d50673cbbabd
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add minimum event size and alignment validation

This commit adds per-type minimum size validation for perf events before sw=
ap
and processing to prevent out-of-bounds access. It enforces 8-byte alignment
on event sizes and rejects unaligned sizes to avoid corrupting the event
stream. It also updates peek_event and process_event to handle undersized or
unknown event types.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -1775,52 +1881,85 @@ int perf_session__peek_event(struct perf_session =
*session, off_t file_offset,
[ ... ]
> +	if (event->header.type >=3D PERF_RECORD_HEADER_MAX) {
> +		pr_warning("WARNING: peek_event: unsupported event type %u, skipping\n=
",
> +			   event->header.type);
> +		return 0;
> +	}
> =20
> -	if (event->header.size < hdr_sz || event->header.size > buf_sz)
> +	if (perf_event__too_small(event, &min_sz)) {
> +		pr_warning("WARNING: peek_event: %s event size %u too small (min %u)\n=
",
> +			   perf_event__name(event->header.type),
> +			   event->header.size, min_sz);
>  		return -1;
> +	}
> =20
>  	if (session->header.needs_swap)
>  		event_swap(event, evlist__sample_id_all(session->evlist));

[Severity: Medium]
Does returning -1 here cause peek_event loops to prematurely abort?

In the updated perf_session__process_event logic, undersized events are
safely stepped over by returning 0, as they are 8-byte aligned and won't
desynchronize the stream.

Since callers of perf_session__peek_event typically abort entirely on any
error rather than inspecting the returned event pointer to advance, returni=
ng
-1 for an undersized event might permanently abort processing for partially
corrupted trace files.=20

Should this return 0 to skip the undersized event, matching the behavior
introduced just above it for unknown event types?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D1
