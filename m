Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349549;
	b=vpvgPTFh/v+kEHZwBAvRfeaMVrB0Dg4MzP326Nc7q/C8vHL1tJCW3eZikJ5rJ5TJGMC3
	 oSgYy3EBcaItn1oXXcwtTwmKLcs8QEDSexP8r9zoP3e2JTrkIPSAGL4asyDkr7Zfjvh5e
	 1iDlM8L51fZfQahlNNV3nZxfSIrRAQ4MFP4UE0rQT0+2FEwi7fPmJfw5/nGMcQnsOiSoD
	 HYsG2lpAS+I1e07/cVxXq1x5kjJVfvMUa/3ej/T0vXAw1maKC0rCycjb0hOJtAp1HwO1i
	 axDmI3FZBlrqw3H4VVMY+mmrW5XDhwpbdAXUk/u/r5kMdsHsp/M3fvg8nQx7R8pKRcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349549;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rztw/43RNrIoS72HIu0dgTUg0nd7o4dTEA+uK3bSW5w=;
	b=UOxu9/A+f5OrWMGS01RpcYNZA6bd7cYkAdMDEYMbaulaLtX7ccHJOMlvgJ6xXwKKV8pW
	 BLZLDqR33akHvAq1jbH9NXCd22KtjZ2NvMSVjffxKbiM6NX7F07VFyAkX+F8fpznE445Q
	 vE2UlgmntIdnnrLKKQOBOeROVd4rUEz9qudLd0FrPYzP7rTv15461WlogIt+rGIC/BBgZ
	 SoLZmyoQsvRfGBsccFyxeSEldhA31FLstMp+dtlrAUyX7OdVElFmsi1wEqeo3whvQArzi
	 DZJS/yI93z3izFsWD0FnqVLFTqBWvTrRwGqMJI5e/RAF1qXwmNsjKW2Pd40bPElLstA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UE/OqCBh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2B606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UE/OqCBh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CAB1F008AB;
	Tue, 10 Nov 2026 22:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349549;
	bh=rztw/43RNrIoS72HIu0dgTUg0nd7o4dTEA+uK3bSW5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UE/OqCBh1nRGXXwKIDv7vKn2fdp0KrFlEErs9Qid/gHeJJel1XjRNveQfsdAEUsA+
	 RcP/1aUlEjKyzLcll50aKnwLZ5bzJZxbyHdCkJfSmnfX46oLdmLbEf1/DxcFuCvo7r
	 uEKJo3atniKHqW1oL52sgopGAc+rYRegZIrsbDMqoNRoQOKa+lSS4+nAjv8a/dpe3+
	 AJeqoSeoKyf2zPOTsgPAtB+nKWQ9DOKzmkjdqVt1ybVReftHpDAqtNbWA7EDglkYHS
	 +QY1WItTy+ixw9N5hvgTqA7tPwN/7GtxQPLGbICP4pcRrEHxsSokEbg0FaBuP7dPaZ
	 /Tn/OzmUAs4bQ==
Message-ID: <sashiko-outbox-207826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/20] perf db-export: Store symbol database IDs in a
 hashmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-8-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:25:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently, db-export reserves sizeof(u64) bytes ahead of every allocated
> struct symbol via symbol_conf.priv_size and accesses the database ID at
> a negative offset via symbol__priv(). This adds 8 bytes to every loaded
> symbol across all DSOs even when only a subset of symbols are exported,
> and relies on negative-offset pointer arithmetic ahead of struct symbol.
>=20
> Store exported symbol database IDs in an on-demand sym_db_ids hashmap in
> struct db_export keyed by struct dso_symbol * instead of using
> symbol__priv(), and retain exported struct dso references in db_export
> until db_export__exit() so exported DSO and symbol database IDs remain
> valid across the export session.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D7

