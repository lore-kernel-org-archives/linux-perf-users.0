Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D818DB26
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110290; cv=none; b=lVSHNbdbiEAvXcnOJ5D5Slu3HYg23ff6ksmkKRx0WPRDTY6LV2/JJPwCn82Azw2PjeJ9XQ/pdngldKUev5slKqhf8Dxshscfa6ihtt8FQxT29lfx4doVuNIFq63Bt2qw0zvbp/73NA3YFWlTe6QkuEyPliUnG5NrQoOe6jhype8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110290; c=relaxed/simple;
	bh=gp2O06VhCkbLjCHECD+I2mhazBU5EfYYBUZFQNqPL6o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TDwoKP5VVuIrAxSw8eTmW44bnduQoY7QNL914C7BaDqZ8985J8x4Ho8prqS1joEQfSWBEn8fusYk7j1ZGgffqzUJID1wB/AZAUtdr0TNcxP5EaCczxfjvU2AowlfVW6QGHUmJilLqjYpyxz3j53F/mAOJVgPbHY6CLeWz/NV/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glbVfET2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glbVfET2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C39C1F000C4;
	Fri, 16 Oct 2026 00:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110288;
	bh=gp2O06VhCkbLjCHECD+I2mhazBU5EfYYBUZFQNqPL6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=glbVfET2zXL3/OkKCLyxaJKMGbUIlR2ug0Clb3JYDmnnYFF4vt5FGNg0DKMSSlcI7
	 bl7/M3u66FUxDzCKlWifghJTOP8sE6WZ1an+33NQdT2TOkKfe2+1dfJv0vm9IbNaKN
	 VPoTIKhph0qSjV0WaRMArtdAaom3oPfzR2kdlc5eH+IuT5t0mcYLj8Gx0welLzoTF+
	 Omppil/mkSosCeTnlIFf5HQ/MdltnzzJ4K2+q92meswKR+DA93kx+gPg07ywH7NBtq
	 QaIoYPR1P8h1DDOFYfUQTdKO7Ekw4lS9pkbi4jgqq33p0yH6JtwTSWqfgYNYvNwsir
	 1xaJjMbYQMHug==
Message-ID: <sashiko-outbox-173521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/19] perf tests: Mark the C tests mapping perf ring
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-17-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-17-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:24:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The C tests that run 'perf record' in the test process itself map ring
> buffers and so need room in the per user budget set in
> kernel.perf_event_mlock_kb: mark them with the new 'needs_mlock' suite
> flag, read by the turnstile added later in the series, so that they
> take turns using that budget while the tests that don't map them keep
> running in parallel.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D16

