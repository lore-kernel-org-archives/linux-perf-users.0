Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E125B09C
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595995; cv=none; b=qHxjWILcB/jAO0qRMsWtbs1XNBwwfiSsbK3j0HWEqRv8mS+OqqKfBVUGgEN6TRE5rLDSPsqXJ7czGCeuDF1R4uhPWxXgDZ/BdNVIue8w7Z2lZ9mV+aM+vMQuOihjRZxG6yw2c+a618Tu4KOABa6x4WdQKvUubUjcLVa7b64EyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595995; c=relaxed/simple;
	bh=xTu/iN1ft/ZcSlAX3mnvAmMR7eJUbtwJbK3WaBwBplw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CB8/AV4IGSxlMPHcvGD/ibNDaB0YNxbj6kEIshHB+dkujdjgx/joG1oaV1sjFtq901Nqn3zNtIdbDV86ueqtGazGCUn2v+5w0XB3th46+dq3OYp9o6SPaCjGULdlP77m6KxD+iBfXARNMGVNZc1ez+fhM2A7q3xi21cf7NLMDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jceUqRsF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jceUqRsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D1C1F000E9;
	Sun, 24 May 2026 04:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779595994;
	bh=n01LfVbXl5wTahkyHeyh47Ksp1bauKKP5yZHZP1NsL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jceUqRsFKLyw6zRhpFI7pJsIZRawhStthIfSpC+dXOfD9DLeR5mbPD4omWlMWHVpj
	 GCqLVZ65UUD+UMBJD5Q0e/qjM4EOKzedSOfqx60+CqBvL7Y7kzMzInN5ryJ+FCeTIG
	 ZkHXEy5gZ43kdykyNYO+kKuDApqYU6XwR1RcuukOE1oRLdW4tzjWsmF82G4Nxrxy2z
	 fXIwwCpDng4LCdrEaiBIjxbdvSvew+/zbNwRP9qcoQENUGmhE+N59l2WVeefOKq+Z+
	 zhEnqfQLZc3LXXVkLs+RjpDfcmh+JJyxgK7ju71s6cNY0NUVMgQ282b6S0o+QT2nZU
	 k0+WU5unyzzrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/29] perf session: Add minimum event size and
 alignment validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-2-acme@kernel.org>
References: <20260524032709.1080771-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:13:13 +0000
Message-Id: <20260524041314.59D1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Callers of `perf_session__peek_event()` completely abort process=
ing on undersized events, breaking the intended 'skip' behavior.
--

commit b42afb24726ad9701717fde2cf945b69f1cdd644
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add minimum event size and alignment validation

This commit adds a per-type minimum size table for perf events to prevent
out-of-bounds accesses during swapping and processing. It enforces this by
checking event sizes before swap operations and verifying that event sizes
are 8-byte aligned.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 1e25892963b78..0523fd243e02c 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> +/*
> + * Read and validate the event at @file_offset.
> + *
> + * Returns:
> + *   0  =E2=80=94 success: *event_ptr is set and safe to access.
> + *  -1  =E2=80=94 error; check *event_ptr to decide whether to advance o=
r abort:
> + *          *event_ptr set  =E2=80=94 event header was read but the even=
t is
> + *                            malformed (too small for its type, or byte=
-swap
> + *                            failed).  header.size is still valid, so t=
he
> + *                            caller can advance past the event.
> + *          *event_ptr NULL =E2=80=94 fatal: couldn't read the header at=
 all
> + *                            (I/O error, offset out of range, pipe mode=
).
> + *                            Caller must abort.
> + */
>  int perf_session__peek_event(struct perf_session *session, off_t file_of=
fset,
>  			     void *buf, size_t buf_sz,
>  			     union perf_event **event_ptr,
[ ... ]
> +	if (perf_event__too_small(event, &min_sz)) {
> +		pr_warning("WARNING: peek_event: %s event size %u too small (min %u)\n=
",
> +			   perf_event__name(event->header.type),
> +			   event->header.size, min_sz);
>  		return -1;
> +	}

[Severity: Medium]
The API contract for perf_session__peek_event() was changed to return -1 on
undersized events, requiring callers to inspect *event_ptr to advance.

Does this break bisectability if the callers (such as
perf_session__peek_events()) were not updated in this commit to perform
this check?

If a caller hasn't been updated, it might completely abort the file parsing
loop when encountering a single undersized event, breaking the intended skip
behavior.

I see this is resolved in a later commit (37f83323fcf82: "perf session: Add
validated swap infrastructure with null-termination checks"), but wanted to
ask about the intermediate state in this commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D1
