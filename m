Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800A32B103
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546333; cv=none; b=hrZ+KO7dHz+zrOEgxuuOy9xK2hpSCrz7wps1f8J/c0RXBBI8KSDhKhV7hAbMDBHF2+Lu+u6FFCNiXReX7adozQv3woYn52wPVj1LzTqPa5jJa/q4se021TcLn6n2byvqOUkA+DvuYtcJNORZLV5C1EZiweF6VoSQ5eS1syF9VSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546333; c=relaxed/simple;
	bh=ExTC89VAqD74bjmXO9T6yQQEG93o7sQJ1bx4O5XbOl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t8GPlIGXhJKDbNAqDS2d4xzGfy4Anzpn8m26HfMMbgqKLP6omoqnSxGX2I1vM1VHYea6kqI9BBWjDFS6nhdwh/EjxBnE6c0AxX+jW1Dj0oBoKdrRvUjgt+6iRtiX16eI4rAmOhOl6B0D0L4Sk67pkhHMHmYgmNEAZpgiykNst/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di7SQlCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di7SQlCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DEF1F00A3A;
	Mon, 20 Jul 2026 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784546332;
	bh=oDBA4WZGEWF38hOXfZmSfWTkxlxLICrqREPlTKgpLaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Di7SQlCybBpfTWl7muBu1g8Xdapv3ChjRYyTTrLlYLboZjApR3FAUIhzGdERNzfos
	 lFH+2yYFm5LQ0mXEWJyau7e97ctV2Kked30IVE1bJ3ppQr2CirV6NtIiQgQMstZIOS
	 KtNxDA5VWnuopn1xKxRQZFUnN1BPHs7gReFElitEiC6Mk+hI6tHZ8ve7VDeXn88Vps
	 ktY10+ICDha/5yKoXh2J+DUZJpmkfrfSgPSWsX3WjW8iLbiyFWPA9gQnPwJaKAKy9F
	 4CjwEqss6uoBHQXN52ktzafK+HfZzMKZCr1jy5EYrJsMr8o3jAyW/z/VG0Mef0ThRr
	 5TYL+7YuIw3TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 5/6] tools/perf: Add powerpc HTM auxtrace event
 processing support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720105218.14277-6-atrajeev@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-6-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:18:51 +0000
Message-Id: <20260720111851.C7DEF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Implicit truncation of `__u64` to `size_t` on 32-bit architectures.
- [Low] The `auxtrace_type` field in `struct powerpc_htm` is declared but n=
ever initialized.
--

--- Patch [5]: [PATCH V2 5/6] tools/perf: Add powerpc HTM auxtrace event pr=
ocessing support ---
commit 87b8929025f59e2555a76806a3d33736b3cb7f18
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add powerpc HTM auxtrace event processing support
   =20
This commit adds the PERF_AUXTRACE_POWERPC_HTM enum value to auxtrace.h and
wires the dispatch in perf_event__process_auxtrace_info() to call
powerpc_htm_process_auxtrace_info(). It also sets the auxtrace_info->type
in htm_info_fill().

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> new file mode 100644
> index 0000000000000..8d28d02031d6e
> --- /dev/null
> +++ b/tools/perf/util/powerpc-htm.c
> @@ -0,0 +1,115 @@
[ ... ]
> +static void powerpc_htm_dump_event(size_t len)
> +{
> +	const char *color =3D PERF_COLOR_BLUE;
> +
> +	if (dump_trace) {
> +		color_fprintf(stdout, color,
> +			". ... HTM PMU data: size %zu bytes\n", len);
> +	}
> +}
[ ... ]
> +static int powerpc_htm_process_auxtrace_event(struct perf_session *sessi=
on __maybe_unused,
> +					      union perf_event *event,
> +					      const struct perf_tool *tool __maybe_unused)
> +{
> +	if (dump_trace)
> +		powerpc_htm_dump_event(event->auxtrace.size);

[Severity: Low]
Does this implicitly truncate event->auxtrace.size on 32-bit architectures?

event->auxtrace.size is a __u64, but powerpc_htm_dump_event() accepts a
size_t. This isn't a critical bug since it's only used for debug output,
but could it result in printing a truncated size if the trace exceeds 4GB?

> +
> +	return 0;
> +}
[ ... ]
> +int powerpc_htm_process_auxtrace_info(union perf_event *event,
> +				      struct perf_session *session)
> +{
> +	struct perf_record_auxtrace_info *auxtrace_info =3D &event->auxtrace_in=
fo;
> +	struct powerpc_htm *htm;
> +	int err;
> +
> +	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_inf=
o) +
> +					 HTM_AUXTRACE_PRIV_FIXED)
> +		return -EINVAL;
> +
> +	htm =3D zalloc(sizeof(struct powerpc_htm));
> +	if (!htm)
> +		return -ENOMEM;
> +
> +	err =3D auxtrace_queues__init(&htm->queues);
> +	if (err) {
> +		free(htm);
> +		return err;
> +	}
> +
> +	htm->session =3D session;
> +	htm->machine =3D &session->machines.host;

[Severity: Low]
Is htm->auxtrace_type intentionally left uninitialized here?

It is declared in struct powerpc_htm, but unlike other fields, it is not
assigned auxtrace_info->type after the allocation.

> +	htm->auxtrace.process_event =3D powerpc_htm_process_event;
> +	htm->auxtrace.process_auxtrace_event =3D powerpc_htm_process_auxtrace_e=
vent;
> +	htm->auxtrace.flush_events =3D powerpc_htm_flush;
> +	htm->auxtrace.free_events =3D powerpc_htm_free_events;
> +	htm->auxtrace.free =3D powerpc_htm_free;
> +	session->auxtrace =3D &htm->auxtrace;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720105218.1427=
7-1-atrajeev@linux.ibm.com?part=3D5
