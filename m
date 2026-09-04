Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF573D0BED
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788493083; cv=none; b=eCkZBzafkNzfAOrIoWIPP/iSVMSIRF4Vi31sxfoP+VFMBkEy0pYAlgeptrC3Eg6MUDwPaYK6I7Eakmw8y5o6j2X7NFT6Mt+tFXPDpdUkiL5Y9OhezPVGaZ3Faycv1J4uFImJagktgaNbvknYJpTtlUJc8MbkKAyO1IVv817hI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788493083; c=relaxed/simple;
	bh=NdyeOGK/4LLwgD+2A0q0PSttT7SbYP6YOsX/rIqzzfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HgJaQOwr4DMJSyZ85VfVat6c1aUqqktD5SKOt6Z5hpO3/Ob7NvfWZWoRvYCfK8g5NrPIf7q1xNXM+xO0gIs48aGdgYhxwYmVKuxt5dq+VI7kbxx4lwH2OHhYI1KZWqHUA1q4vzoNAk8Sw8Q83tb7RbrT/SDwToODuZ1XbCfbMcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfFCS669; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfFCS669"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0761F00A3D;
	Fri,  4 Sep 2026 03:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788493080;
	bh=NdyeOGK/4LLwgD+2A0q0PSttT7SbYP6YOsX/rIqzzfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SfFCS669sh9j7xQ78V30PgJqbniRIHkIVX420CkYwzXax8AtJ63pEslkLrw0XnNmk
	 seNgGnJskqZpwB1sLla0o9pvPMQ45ZNU0II7nvDyb6Q1WpoZ5SsBlR7/Ru2k/YFdsQ
	 X9JA850fuLaigHir2P6zeyDNvFSenHf3sVvYdduslavHLedDiqb+kwFAJznPeRVSnp
	 W3TsK6cjqOvvN2qqK2WCUWmzb8ew/LYceqz5Y8rxVHiDM/Ff+RN4QD2u8naEYdNUyu
	 mEeAt5SqklewP0th2jl0CDObClQVeHbkDDsEF0FnxXmp2Ntk04dsH3iqTcksyPJ5f/
	 NZ9xg3/nHovow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] perf/x86/uncore: Add L3 PMU support for Hygon
 family 18h model 6h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fu Hao" <fuhao@open-hieco.net>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d45936ac077e5a62dae6f40edcafa13644620ed5.1788404433.git.fuhao@open-hieco.net>
References: <cover.1788404433.git.fuhao@open-hieco.net>
 <d45936ac077e5a62dae6f40edcafa13644620ed5.1788404433.git.fuhao@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 03:38:00 +0000
Message-Id: <20260904033800.AE0761F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Adjust the L3 PMU slicemask and threadmask for Hygon family 18h
> model 6h processor.
>=20
> Signed-off-by: Fu Hao <fuhao@open-hieco.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788404433.gi=
t.fuhao@open-hieco.net?part=3D4

