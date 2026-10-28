Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211130;
	b=npAGXf8ppFJmxzdCMeGepCp0MSQNia28TRZkMKtJY3hayve3hbBxkWa5lzYmMk5kS8eN
	 GfYNmTtAumI/nj/tk8p2fLWaWHoiD5HLpHOQFvFa43w7R1iyJynzYXEc7wMpwBlbrj1rc
	 VvQibgrAfFAF6U2dsu7fGvonwhGZ35gbX4UqnU4ukh55lI7TIOe5yz2AjA4LpTJuRiEds
	 KP3eXlsXRFljd3RkwBGXE8JE+6fLjHzoR0zmzW8JmpeX+6/3xxFEUA0PWToxE32pWnVyF
	 eBTtGjTOy+6aR9455q3vQbrkEkMKhXCY6aMuPuJxrvXCMbmBWOnlbrfmVJqFQafdeqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211130;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eM2gObSRqmYlnxRpjuAPORqpiiD4DhtFH1SeLkg718A=;
	b=xT0SY9klhcuJOZTyMFGcLdK9mlx7cH4snxANwc4+JGUTQU/K9zcwljYXj4YwWPfD8kdk
	 JJPi198Tyw4UwT0D3jnzLOQyJwYgGXdU/s3HpVCznf0vdGuoI7yQguM1DnxkL5yykJJeM
	 12kOxkAc5U5egNfbug0/GkKP4f0jd1k0CHPcb6xq8Kq3YIXKCBkvEa9cORaFIpL7eZ4hd
	 AY1NuKfoC0ElXrMw/AtUBpeycilaFmb6l5lO/RDToO+ADlInzpD8yagll5h7R4Cr4PO6h
	 762XmLTz/FOg7K5l1QYtN4jyhXYBJX8ImyYKt8tdUpEnaIQpJorooCV1c5Bsld0cFQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ffs413XE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D108606B45B
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ffs413XE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B111F01829;
	Wed, 28 Oct 2026 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211130;
	bh=eM2gObSRqmYlnxRpjuAPORqpiiD4DhtFH1SeLkg718A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ffs413XEF84i5BcS7gWnRvOP0kVsH6ctPD3SrgOGSIqC8zexI3FJVAtG6ymPqQAiT
	 FRNGETm0o1PbDu1SLeKntHotOphm1/VhKFm2qQMPZlITzDsy8JloDjaG1lda6lQR8J
	 vU8SVkJdd0AASwaaPPW/inxzdgcpzsT914Sai4acx4kGCA8gcDS4ReZ/mTr3NzQ33Y
	 WFqpzZxvqIqepW++VHY3VzxkqcytqzWrB5yyDiQWq2TyBnIF53LGgUusHMWG9qj7m+
	 TnerEQvDNlIgIaPqgggs/3K5IxnRph4mcfoaHuOnPJUOS4GtX7YaKbkP3FG7HeAYx+
	 8NKmR6x71wBLA==
Message-ID: <sashiko-outbox-188267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the
 logging options call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-alpha-profileme-v1-1-d44b52bf2500@gmail.com>
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>
 <20261028-alpha-profileme-v1-1-d44b52bf2500@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:12:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alpha_pmu_enable() passes EV67_PCTR_MODE_AGGREGATE to
> PERFMON_CMD_LOGGING_OPTIONS. That constant is the counting mode bit for
> PCTR_CTL, which belongs in the PERFMON_CMD_DESIRED_EVENTS argument. The
> logging options call takes a flag in bit 0 where 0 means "count all
> processes". It works only because EV67_PCTR_MODE_AGGREGATE happens to be
> 0.
>=20
> Add a name for that argument and pass it instead. No functional change.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-alpha-prof=
ileme-v1-0-d44b52bf2500@gmail.com?part=3D1

