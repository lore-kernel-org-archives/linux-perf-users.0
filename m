Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738884;
	b=ukFd+rSOIRZDWKuXoMfOgmEkCEcj2Co5ZxVQz76GWmZga1KB91NWia3qBjrI8WeMakIb
	 nWvlJK92o/NZmw4oZW3zGgxooImalB1/VsOf4LX336H7qVGdVEeGDMawuuyP/HynvGqaB
	 VBlNzesi/1T2VPHowjEEuUffxBZLo6VTuE+jtq54vogWbkg5aw+5UY3BLqqAzVyPB/0FF
	 0zbn4PiUMd3fT7j2VVB5MwtK56oY9HgW/TxrCLcWUmP+RDllyHwvfoovTfqiXEAoLnxEr
	 4Bi/1RJkaIjlrHEzb7w3RnSyY2zsTYzoi45YMwNpwmtOepUF7AAoDoasUQtY4w6B54A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hnVPE2voEVxZXh4OcMgrO36kJOKt/FUbku1rBnhTdtQ=;
	b=UbQ3iO8hYDlYdQcfiDNf9nPUUh6rPnEvz+nT4VXdb+UDLAsRGw9MGwbT74dT/mbzxOto
	 vr4LqBBmNRr+RLY9bsDzttc26JNG1kqwFng/K64MqClf8x4OhnDrIq4PLtX82XMpTNxR/
	 /8lOvEUrAfwID+UQeNyxamR1M1z+P1glq+3Fb4ZI8pEWpGnN6hMYyW9YEd1J78DlqnUWw
	 0JYYTz/D2wqcPFduchFuugOMJSEYvtkKsV8FaYbNq1JYWSO4Jc69dp91SYY4oQ8n3jRaI
	 PFPqtbuKTpQtmqI5a7BUxQe+nnjcJkPf7K8ma+kdkCciKDk01TKFueIf3wbbgEqHXEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5lmPwlt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7F606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5lmPwlt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692061F00919;
	Tue,  3 Nov 2026 20:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793738883;
	bh=hnVPE2voEVxZXh4OcMgrO36kJOKt/FUbku1rBnhTdtQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T5lmPwltTQOiCh5SSDDm9F+E+ZB5770yhSUgU53aW9UuCAkjUnWrPkxjc5j/OB0sx
	 UXCvu991dG4+t0P6XS7DeFeB4cvh7xL68bJ5y22rDv4MuMtnLG51K7y9JKkFemweOD
	 6Ls7oV3L+kTuiPKcDrPxA1GollRtEh1xCuH3iLReVouDNo1gIn/n1qzddwtAq0LFm6
	 BaezobkybCrdkocFUm2f/ruY6UVJ4SSvKKthNll4Cl+t1ePTcCtvnMIZq5punzbFMO
	 dkKs7gt1OyhN0M1V0mlyUKvsAV4gEtwlODr/twaqmp3fqBu4ZBntTctGaEUVNQ0kKf
	 aYjYNO0EKyFEA==
Message-ID: <sashiko-outbox-196015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/11] alpha/perf: sample only retired instructions
 for precise events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-alpha-profileme-v5-11-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <20261103-alpha-profileme-v5-11-bbe3937fbf3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:48:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> ProfileMe samples include instructions killed on a wrong path, which
> show up as hot spots in perf report although they did no work. On an
> EV7 loop with a randomly mispredicted branch, 19% of the samples were
> killed before being mapped and another 48% later.
>=20
> PEBS and AMD IBS op samples are of retired instructions only, so make
> precise_ip imply the retired filter, unless filters are given. The
> profileme bit still selects every sample. With cycles:p, both kinds of
> killed sample went to 0%.
>=20
> DTB miss samples, whose instruction is aborted, are then dropped too:
> their data source now needs cpu/cycles,trapped/p.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-alpha-prof=
ileme-v5-0-bbe3937fbf3a@gmail.com?part=3D11

