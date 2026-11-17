Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942242;
	b=E+h4yaCPQYkiE4Pu1Gjbf8eycvJ+GMRwNulbYKotslcOkEFLmH1Odp6Un7icLuwcmXpF
	 ZsouWsvOr4HEtn91juHiJ/8myxSrb0AzF8nUqUpv/agaHs9jfq5nqaIpq3HY5gTcFr3Ey
	 L4v/OBXRp8pnqnIO1sb+ELv5jpv/TV1OCo54NAHcVQH/swNBgatomkymTHHq9ndZMBKbF
	 +RVyolCiDBSBd2UT4sia4KNrSAwPwbZook9W2swXp5axXb3t86+t6qtzevJS1+YTEBSC0
	 /yM8wxul8+JkjQTuiHkrz8UZui5iBfBdKQxxafWbqr9QJqBfyRIsHr53MwpZLVGI0SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w2oCwhNqGhRhBeEvtVv2fHvdwDE70yfrVXtuzw7mgiI=;
	b=YhyienqMtIo6VoqHmEQPPsXDVPVKvmlqmscZyrIZYBJFGpwgDtMivjXoLxVcjrzG3FXQ
	 1hwKjXzLP6p1YnkzMvzoOvB8bl4mbCLehXtEFUnpUmmu5gS8Y5v2o0WPeK9+6XSfW0A6P
	 Qma0974mudX6dfeI2GYo2+iIVgTFKdz8XX659ECjVgmBgq2uA9/Jp1dz/Llu5IBhnmry5
	 Th8ivAA1oLg3yBXZwf2W4POrF4KMcVZDewtMnRvq0TdVv7YyXjEPgsfRukRZsADsdqRE+
	 IY98Dcv+lZGG5sjW6KSMTXRcSvSYEZvQLaCiSjQ08wznYBKpLuH57K2ILpFUrfmUe1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4GaD4k4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBD606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4GaD4k4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269021F000C4;
	Tue, 17 Nov 2026 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942242;
	bh=w2oCwhNqGhRhBeEvtVv2fHvdwDE70yfrVXtuzw7mgiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4GaD4k4k7uTf+vyGstRjhVmvjESq+F2hzeBxmW9WYyPbOxCXEtKfJELR13geyG5l
	 +WYQHuTE+DF7GkVBZDzDAZLSKppKRB/MehjYjR3WfAAD+qskOAWOHDQuME4VTag7Bv
	 lceavq8jTR0Hdv0xSC/Utooq+6TUDQ1IdaaviskVV4XMxTdcpNHPkHB2nXap5GF3pz
	 KgW3qhrbuKdd0DHiXFpH6rWNMwnifssAqB6slH/S9LsqbdskmImv7kcEOkyVxfhxgD
	 bWjTjz0SfPmpYNJZXdRgtRWTL4N6KaHb0J1h319cUUt0gNxsn3iVnEv8cUyViHt/36
	 hK+T77TbexDww==
Message-ID: <sashiko-outbox-219432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 21/23] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-22-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:04:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __returns_ctx_lock() to maps__lock(), annotate DECLARE_RC_STRUCT(maps)
> members protected by lock with __guarded_by(&lock), and annotate
> internal maps helpers with __must_hold() and __must_hold_shared().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D21

