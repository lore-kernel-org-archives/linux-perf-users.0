Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3973135F5ED
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776982489; cv=none; b=XjUOdCQ/HnL97lhZK/kBUOgb3UOlWpa4S8BVZ/haiyXvIjUp6d4ajdlO/aeWwAnCAP5Ry+auPAv/Y+TlnEC0D2UMr3dxwPQyqv1M9xXerU54lrSi0jMP8887i/hTkYZclE/USVR3GvwsebaumeQ8SAxfkO8tb0EAkhHVx5seElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776982489; c=relaxed/simple;
	bh=Q0JdrW8tgsOvokf/6hAkeP2/FQgCVGjlZIq1+Yos+BU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nXlug+2cA2Qpc/FRrMvQOcbDKmY+qEzqnbMvtjBMbBylZ4v7BDaNn9t3frTWTIaFrzSTnKxHyN6ir8yfr/nlKyu/JeM7d4nip+wjDLoeSjYPpX6LFNTxFRDTXLKJLxWJbqdA1+22AxqCyvpVrh6yQl5j/mlFafP9TNHcX0p6ZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4rb8V4I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4rb8V4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB01C2BCAF;
	Thu, 23 Apr 2026 22:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776982488;
	bh=Q0JdrW8tgsOvokf/6hAkeP2/FQgCVGjlZIq1+Yos+BU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Z4rb8V4IFSur7FX0P4Hu8BNPQEIo2p6xYWBGBrFQEbWwqATl62evkpMnwibEwpsyt
	 mEG62BUT3Klg7kPERLHV0wvRgjDvku3c3uy2fx41UVj3rOySu91fQmftCjyFeBV3Gy
	 WB0k7dl9rHp7spMCRNU5LJq4zjfJ/A93/t4EaPvwsAe0DtxIrRZYsQjyr4yIB7Tb8X
	 kzpiZZbgEsDbjml8+gsLXHgLhDJNsoxgtXbUnngLQ5XaIEcj09eyyqNZoKXt8npaGb
	 89i8s+GicVMmKzxjVjfWnukyA7kAI+vXCB4N2bSLEBjTgvdvRfu10GAiWQk5QgWJ9t
	 ZtFstWHND44aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] perf evsel: don't set PERF_SAMPLE_IP for
 unprivileged tracepoints
Reply-To: sashiko@lists.linux.dev
To: "Anubhav Shelat" <ashelat@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423151746.16258-2-ashelat@redhat.com>
References: <20260423151746.16258-2-ashelat@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 22:14:47 +0000
Message-Id: <20260423221448.9BB01C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Unconditionally dropping PERF_SAMPLE_IP for unprivileged tracepoin=
ts breaks user-space dynamic tracing (uprobes and USDTs).
--

commit 06030eb0792514412c01e8660eaafa6292e09335
Author: Anubhav Shelat <ashelat@redhat.com>

perf evsel: don't set PERF_SAMPLE_IP for unprivileged tracepoints

This commit conditionally drops the PERF_SAMPLE_IP bit for tracepoint events
configured by unprivileged users. It aims to prevent exposing kernel addres=
ses
that might reveal the KASLR base offset.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f59228c1a39eb..a1091d937ff92 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> @@ -1503,7 +1503,9 @@ void evsel__config(struct evsel *evsel, struct reco=
rd_opts *opts,
>  	attr->write_backward =3D opts->overwrite ? 1 : 0;
>  	attr->read_format   =3D PERF_FORMAT_LOST;
> =20
> -	evsel__set_sample_bit(evsel, IP);
> +	if (attr->type !=3D PERF_TYPE_TRACEPOINT || perf_event_paranoid_check(1=
))
> +		evsel__set_sample_bit(evsel, IP);
> +

Uprobes and USDTs are also registered as PERF_TYPE_TRACEPOINT events, but t=
heir
instruction pointer is a safe user-space address indicating where the break=
point
fired, rather than a kernel address that could leak KASLR.

By unconditionally skipping the IP bit for all tracepoints when executed by
an unprivileged user, downstream tools might fail to resolve symbols
or attribute hits to specific instructions for user-space events.

Does this inadvertently break user-space dynamic tracing?

>  	evsel__set_sample_bit(evsel, TID);
> =20
>  	if (evsel->sample_read) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423151746.1625=
8-1-ashelat@redhat.com?part=3D1
