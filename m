Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018298;
	b=o0sQjxt9KMUu8uqvOFAxVj0ScRoNi9HThTfimedde3wZdloPheh6JyWNnpfbN8uHZfFO
	 JPPniIRVSzGOJafWyntA1VwZOAonVM5A8oMIJDrVA1FKWPQ+GwzytPsaebteL7Hjtn/nO
	 qbJk+1IDKSe7BfNhfYMnJTfuzDfutMy1rZ+ufm67FN9X19v/jQnTGJ9E9ju73f/UZS4nP
	 t/qD4Rfact3224gUZQkpj9TvwOJ0tuN7jDbTffJvT6D5hy8W+Ee35DFLHJwfFyzjANMSo
	 Ua0SVfOWY3Ou/WgGBOz44KO8OM8Zo45d1pCEBJ5u44cHCTMwKMbfLxUQ7Z49WQgTecQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018298;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X4puLfhWgrXjo5SlhH32++tVywpuYFJmFBiMgY8hhgU=;
	b=12219wGgxW814xtqOA1LeDON8gjAEUORZAAADqjot3Nc0HaVpy9lGYyOR41MngRn7hDH
	 G9vfYUwvcuZ16I3I8Rs93zTWKC74f1dlutoe6rfQC5zRSlDRCYu4F6ie2wG5TKvZ1OBxp
	 +4/EemNf9t3S6QCLzeHfDPuKl4fdnrA7ekB5x/8Lppf59lZsvX2UmNVEqcagoOI6T6hDe
	 J6qksxJGjQ9a9N2/hGLrZ5SEwEhi8YVGIoIxUhVk7UWXBLYrQtWWVuSDGrQrTS6wNPqoI
	 Mrvk44yhIxFFEUOODEeLWzsiDFtIdA/4AxvUrAbMaOWf3DtHvSym+hKeCG/tM1KXL6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1YAP4zW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2172606A326
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1YAP4zW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7237D1F0089F;
	Sat,  7 Nov 2026 02:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018297;
	bh=X4puLfhWgrXjo5SlhH32++tVywpuYFJmFBiMgY8hhgU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=l1YAP4zWn9zw0mPCOoAZvwT9bEkAVLzcXPDWPQG0FHkS9cGDmpd9f1X68xSMDfBcD
	 Rebnh9jDcWCn4tKrby855evTkkxzrd1PnF3CK3LPkqnvJMe7xL9TxcIISQXEjbIg1P
	 VZtFIauzpKm+uQ99GFTzd9v0hfjUXgRInOfu161AJti2z9g/ZzF6C0K3ycc7gzJ2vh
	 1XeBHc7MJe2Y25QF/8177jWP2afTm26YbGkayfjgPA5RZPg0vBSI8uk3sqnhLoseZ3
	 sZ95/SBMNY4EYWkKBDwaKzhdQmY3/wqwgQhL5MzPA9wnsrKuwHPgZk6lCSUCDLx+Pl
	 Wo2AANH5ujMnw==
Message-ID: <sashiko-outbox-202506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf vendor events arm64 AmpereOneX: Deprecate
 BPU_FLUSH_MEM_FAULT
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261107022145.1713159-1-takano32@gmail.com>
References: <20261103112609.3772250-1-takano32@gmail.com>
 <20261107022145.1713159-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:24:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> AmpereOne named event 0x121 BPU_FLUSH_MEM_FAULT until
> commit 10a149e4b4a9 ("perf vendor events arm64 AmpereOne: Rename
> BPU_FLUSH_MEM_FAULT to GPC_FLUSH_MEM_FAULT") renamed it.  The next patch
> in that series, 16438b652b46, added the AmpereOneX tables with the old
> name in memory.json, so 0x121 carries two names: GPC_FLUSH_MEM_FAULT in
> core-imp-def.json and BPU_FLUSH_MEM_FAULT in memory.json, and the
> default perf list output shows both.  The old name has been in every
> release since v6.8, so removing the name would break anything that
> refers to it.
>=20
> Mark the entry deprecated instead of deleting it, as Ian Rogers asked:
> perf list then shows 0x121 once, and perf stat -e bpu_flush_mem_fault
> keeps working.  The x86 tables use the same wording, and the same
> reasoning brought back deprecated AMD events in
> commit eda39f98bbc5 ("perf vendor events amd: Reintroduce deprecated
> [ ... ]
> Link: https://lore.kernel.org/42801873-8908-07a6-aed1-c7076c689e8e@os.amp=
erecomputing.com
> Link: https://lore.kernel.org/a188c604-46c0-48fb-9cbd-9eacad88b5c9@linaro=
.org
> Reviewed-by: James Clark <james.clark@linaro.org>
> Acked-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107022145.1713=
159-1-takano32@gmail.com?part=3D1

