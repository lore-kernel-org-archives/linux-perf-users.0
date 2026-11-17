Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942493;
	b=cfyCbqh/wjHt5cK1d96P+ErcAiRbyx9bJoGCdBAKNiPH61W7+5AZT9dKikXytuElq3B2
	 q3/azDMpOX6bRi/eJWHpFj2qbv+Na+lJnV8Z48cSqHSoJk/aBFjjFxfjCTJ4QAfMRrv9m
	 IXryl2HP90lLOqfnJgfes2GR4icvuAmwJM8PAsjxkFpPmtHMaUt7968wVrVazAFbiPz+7
	 sbox1Q8Cr1nZ8NE+OlZnElAFEgJgu39Bvbus8h6vrUgi5JNCSzZRWqBXg9tK4wH2q4MP9
	 0B+haJz8k3NMUGSOgpJ8/RWDGP3ygXWJs3AkdV2+Xou5HNKBvgdeITl1pdSPJ8On8vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942493;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wOtBaQcJaHFYyjjm+9vwcxpVg75JPvFG1DikRq23gGg=;
	b=jhTnR2ubxK7vN5g+sC64F8WZT5CkTOzekpanIeO/p/z7oG6guf21YnYOPCwfz/EgqN91
	 NXqDoXLx+NyFb5r93M08k825mJ3WhuCUeupe09m+r7LEUzeTMZvyzfE0+bLroz5NNp3le
	 Z+re/vGrdlTwGv0shjbxh8MjTbur0zg4nwTF2oj3tYUWufuPOt2Hs4jIwrJvRmRRI9532
	 9hWJfaSXuMyVZtw2ymeB2I/w7D7gJQgHCXVW2uh9fG0yHhnmvVf+YzoL3FfcaiiuBhJCy
	 7wpcKVsXW8uAo4U6azU6aEBMTdK7hRYplUmdhCPI+wuw9wImbsTMzKPIieZ9PaPEYGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJtXOo6u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA6606A330
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJtXOo6u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B14D1F000C4;
	Tue, 17 Nov 2026 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942493;
	bh=wOtBaQcJaHFYyjjm+9vwcxpVg75JPvFG1DikRq23gGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jJtXOo6uUh/AiDfyOptEMyl3ASontx7k3V3PnrSpNRoI3SavjqLPvpCek4Hzfj2mG
	 mnqvpPq051Fmss5g0bp/AHKVTJymityX3jxbtW9u/CJTIcJVJLjUUxJpKMLOJsL2Ss
	 SXomGzaWbWxGeyIz3Pn4Cz5vuDyt0HCCrzQotpP91ovUTT4d+Nnpi5ipxz3YFD1HkX
	 sl9w230c1KypVQXfQyNnuuK970y8KoAM7aj9tlvlGAaFHKfxT9kH0LhbGDPMaXUJlh
	 1BC+gBVghHthZpjEESIlQR7yn1r8gCdP38lnyb3+rP9mhjCid5gJfqyRu5II89jrXI
	 8t3qH05mVsMuA==
Message-ID: <sashiko-outbox-219442@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 15/23] perf intel-tpebs: Fix race in tpebs_stop()
 and tpebs_cmd.out fd handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-16-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:08:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> intel-tpebs has two lifecycle bugs around the background 'perf record'
> process and sample reader thread:
> 1. tpebs_cmd.out is read without tpebs_mtx and closed by both
>    perf_session__delete() in __sample_reader() and tpebs_stop() (or
>    leaked if perf_session__new() fails).
> 2. tpebs_stop() reads tpebs_reader_thread after unlocking tpebs_mtx, and
>    tpebs_send_record_cmd() drops tpebs_mtx while writing undelimited
>    control strings and polling ack_fd, allowing concurrent open/close
>    calls to coalesce commands or race to close pipes, join the reader
>    thread, and reap tpebs_cmd twice.
>=20
> Fix (1) by initializing tpebs_cmd.out =3D -1, passing it to
> __sample_reader(), and resetting tpebs_cmd.out =3D -1 once ownership is
> transferred (and on start_command() failure). Fix (2) by preparing
> events under tpebs_mtx, reading tpebs_reader_thread under tpebs_mtx,
> newline-terminating control commands, serializing open,
> tpebs_send_record_cmd(), and teardown via a condition variable and
> generation counter, and ignoring late samples while stopping. Add
> explicit header includes used by the file.
>=20
> Fixes: 8db5cabcf1b6 ("perf stat: Fork and launch 'perf record' when 'perf=
 stat' needs to get retire latency value for a metric.")
> Fixes: bded0398ac19 ("perf tpebs: Fix concurrent stop races and PID reuse=
 hazards in tpebs_stop")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D15

