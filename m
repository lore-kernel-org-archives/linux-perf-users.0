Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705347;
	b=x61mAPh0MNXLao0/4KYNSAtnsVr3iUOqnWWU/xEKd1ZjjYh0uf1W4vjR4Ul38gdcZoHO
	 fXatu/cSsu3VQYfaQ0EKaNLyTHYV83sHWySEJ1pIcnAQNu51m3JGKf3I+ZV4tLlXDuAbd
	 bQ6kMtqzixgwryWOJTEic1bsSyU/NBzlEex1PT1AJDYTYsnM4m/BQGcelSEhuXw5QCU8o
	 XQtXz+XC6XgIqL+qaYszVyt0+BMnsect29pZkYV6xts0BAIMbXb3phfi+DhLFzByFamID
	 FUNAnSGHM+Q6/kJ40p46+yhWt9wBq371hA8nmtIgoo4n2NlaC+kcflBuGQ9ZohO27yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O9yPucFsAp1LGkeV7KUIYzpXUb2YChHJ/2q2z34RJlw=;
	b=WnK875/FkeX30BHFxSV0bfCb90gPgZaRdaOq9LgVHzQKlKBHjXItq1Z4X81lR77PgxK+
	 fF5YmG/GLT5fYOOYcXhqu0pzIJ+xUa5uzKGaqqLXvFs6cRanv0Jn7n4IenE+uLCvFpUVT
	 DKBY7ckhwYvYt82PM3wVEWuvzIT0OoRPDEyAFiieAcb+Yp5RvheHlfYe8rsA9M22G9T+W
	 mA4ZyQGqUZ5f6xjD/Baasxe82g3zQvkvHbq73y2MQwOSAuPVB1vql0GE1ppfqb7Dhq2gK
	 NR/7IhnpgqzyntBLvNgMu8Jd0ObpKnMWwTkZoXDKZI1lRHBQsl+fO+roRXSIYC551KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWiCtStK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ECF606A815
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWiCtStK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069DA1F0093A;
	Tue,  3 Nov 2026 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793705347;
	bh=O9yPucFsAp1LGkeV7KUIYzpXUb2YChHJ/2q2z34RJlw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TWiCtStK5k5PHSaCSZCIt0+p0P0ilM2Iu1Yzzoa5gkwGaFhMk2NDy467DWp9JDM9W
	 j+MNv5MsxOjOp/4Pu9B8euRF5Pw7d2vQSiuV0vsli3JduuqPr+NrNCVNcvMNFNn+4s
	 DU2RDzc4jkNTY7Ck5mTNZoJTrEzVdGVmoRCt6EHHVI2+2onOKa+Quwlwn+bEqc4hzX
	 mE0ySl8vgGGyHLmMszaFfD+YmrqODFslbFGEf/wkSW40Nc8hPMkDkJTVUml4odD2bp
	 FFSOaxqeeezvh2E8I0ja5Di8HUUbF9xqex5kyvJdgn8vDfgGzXXL1asZZsqRpe5xQ6
	 misr05/AuYyeg==
Message-ID: <sashiko-outbox-195150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf vendor events arm64 AmpereOneX: Deprecate
 BPU_FLUSH_MEM_FAULT
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103112609.3772250-1-takano32@gmail.com>
References: <42801873-8908-07a6-aed1-c7076c689e8e@os.amperecomputing.com>
 <20261103112609.3772250-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:29:06 +0000
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
> release since v6.8, so deleting it would break scripts that use it.
>=20
> Mark the entry deprecated instead of deleting it, as Ian Rogers asked:
> perf list then shows 0x121 once while those scripts keep working.  The
> x86 tables use the same wording, and
> commit eda39f98bbc5 ("perf vendor events amd: Reintroduce deprecated
> Zen 5 core events") brought back deprecated AMD events for the same
> reason.  The flag is only read when listing; the entry still registers
> [ ... ]
> Link: https://lore.kernel.org/20261021224527.167637-1-takano32@gmail.com
> Link: https://lore.kernel.org/CAP-5=3DfX+2eRGCHcU43sqU=3Dgi9iKvxqyS6ipwRS=
nvFcap3D+QzQ@mail.gmail.com
> Link: https://lore.kernel.org/42801873-8908-07a6-aed1-c7076c689e8e@os.amp=
erecomputing.com
> Acked-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103112609.3772=
250-1-takano32@gmail.com?part=3D1

