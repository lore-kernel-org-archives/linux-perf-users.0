Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783358;
	b=2K044Ka2gM/u3BflHF5683ywMLYS+yt7tqrLkNFg7rYW8JvEzgAoFMe6xwo1mDl3Mr3F
	 5Id39eXadDKtA3hH3cVOdU9GxW4JtX64AQFyan/yVKTlca8ar4DJNTcGqq7IP+Oeo34cS
	 mFgeYyJzaKAAfPqqURL5fo/FkCB3HvnND6M0wTVF37wm4gdQrfL8zcAPlksvHCoG4gDwV
	 yvH9Q0yazVscYFSX8wG0i/2331LImRByrISvxl1R8eEQo2xoyWFQ9Hx8lfxis2o56YOWn
	 Gn6FuvoJ0gYtB6WcgXzXoH6oMBPjrWyGP+31O+n+9+/ubAPR1eqgNk3jYdxGFL73sSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783358;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ii6ruMovvGBZisq5/39/6Y3bC/i2rEDElblpeO8EuVs=;
	b=jxLxcg9+ibKUCo5mDH3B/J7ipD49itLBKYTgmZNTn5UjJxMb+xND61lW3OB9OR2Lsp6E
	 FZCATosy3Fc4t4rLRAh37fJxq3HCbdGF0RSgUWRyVMBOu6ts6igbxbzQioZGHtMagq2fP
	 DAks4VJ9BXxoB139yd8ZOBaEBTuaYNLoSaWdsZDDvN/NOHKIumLz7syehzj4CHHnboxR7
	 319A5hDD5JfSuYCGenZStydsYdwBkV1Et7ufRprBnm8Ji+EWzrS1lSJ/zci2k8QQQFq35
	 Sum19HP9AImCuM/gsy7ARkC+zBgdYF6Yue1sfPDi6CfO04//fcxeEzWh/N3YGWrhlYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pq1Gky4W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280B606A31B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pq1Gky4W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF5C1F01825;
	Fri, 23 Oct 2026 19:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783358;
	bh=ii6ruMovvGBZisq5/39/6Y3bC/i2rEDElblpeO8EuVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pq1Gky4WIm8JbzwLKxAdjZG3THoMr6TqYEcNvvvQ7QHxLDU3ViWfFX2774yL/27x0
	 MTGmFBHrjm8ydgEqLUYGBtQ2k5+btT/rgF+Xiesww5jcqiFhilPZ0WjlZoMc0WjER4
	 ikzG1APQUAFTQb/WWXLymzftAzaS8yrHxyDqKemMX5W16vLXqRGV2YPV2YP6n2p8hH
	 rHklfHHZBMttDAlbp/VBmjsO6ayX81TE6hvX0LqwOBxC9MeJW3VkIj8IcCvMo+oP5z
	 QH5JcynWs5s346+UXNMVim83HrB898FIZFAdHROGgfioM2v1x32mpv8M1Wk/R42SaR
	 agbWc8hbWMnFA==
Message-ID: <sashiko-outbox-183109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/11] perf bpf-filter: Support BPF sample filters on
 tracepoint events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-3-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:22:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Commit 466db4275edd ("perf parse-events: Add parse_uid_filter helper")
> updated set_filter() to route non-tracepoint filter terms (such as uid
> and gid) on PERF_TYPE_TRACEPOINT events to evsel->bpf_filters instead
> of the ftrace tracepoint predicate filter.
>=20
> However, in the kernel's __perf_event_set_bpf_prog()
> (kernel/events/core.c), attaching a BPF program to a perf_event fd
> branches on perf_event_is_tracing(event):
> - Non-tracing events (hardware PMU, software events, breakpoints) call
>   perf_event_set_bpf_handler(), which requires BPF_PROG_TYPE_PERF_EVENT
>   (SEC("perf_event")).
> - Tracepoint events (event->pmu =3D=3D &perf_tracepoint) reject
>   BPF_PROG_TYPE_PERF_EVENT with -EINVAL and instead require
>   BPF_PROG_TYPE_TRACEPOINT (SEC("tracepoint")), which is attached to
>   event->tp_event->prog_array and executed in
> [ ... ]
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.024 MB perf.data (42 samples) ]
>=20
> Fixes: 466db4275edd ("perf parse-events: Add parse_uid_filter helper")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D2

