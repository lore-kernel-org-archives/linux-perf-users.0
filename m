Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE06426694
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303501; cv=none; b=OlBuuWIsHNK9ndcJ5+Myjw8jZDVLUMcbx+U1Qo1FhmkA1mST4WpuNFysjnlTY8Xp6WngbwgBiCcRh7P0UI3hLd9dhWQqSUJQsLRBMQA3VTYBXxC9xJgwEekJ0xgk0Hp6vkVs2swMMle7u9sPVoTKUMc920za6UWfQ77b98vEWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303501; c=relaxed/simple;
	bh=WPVCciZdp1NuBrC5SS5ul10/fxKUhu2SarirsL+XgHo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=imDKp7nACkTVkmMeb05t6EivBGoQa219OaMRtGmk2b8lwMVi2u/6ygj+1CBpokEJfDhaYQMJsudJd5gm8B+szOcZ1LTRxRk20kwecVKTCvU1+3MO2dqPQJu6/v0rC3co5Ir/01IcD/qmwReNALEASXcNsdbkohjWjCo9Y7TjEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFUVEVc/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFUVEVc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141A61F0089C;
	Tue,  6 Oct 2026 16:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303500;
	bh=Z8n4004Z5QNxkd/QSNez5B43ZlGpFM1sQoB9IK8cgX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PFUVEVc/c66Uucz6rvlkBtjFb4M709wHJ58zHzgQ8FSHvzVZjfLlXPWOm+O7FmXod
	 VWJ+kk6rXLn4lPUWcBckpQ6yNV4ZeKXu/faH1EmQbKp6uQumkkXBWEOuvTubQJV77a
	 6hzWa8AUdCaxo8kxmi8L0NjRBK4nIPUtbWhmai8TSQNz18f1OPPM7sIfAWGyfwzRO6
	 L6gdFRoNGoQgbIQ7Fxt+2OVdopWa4rHu5jZJdIlKbm6biODomd6la094OTGKduWkdd
	 r2yKGwq202bSHHuhNt+b9ci7Tt8D3HU5clfI9PVvD0Vu2B7LYoo1Lbo7oVijfP/eI6
	 gVy4hzempyoEw==
Message-ID: <sashiko-outbox-162234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] perf test attr: Fix record dwarf sample_type
 expectation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006161309.3078488-4-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
 <20261006161309.3078488-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:18:19 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since bdd051e249141c79 ("perf record: Split --data-mmap option"),
> record_opts__parse_callchain() sets record_data_mmap instead of
> record->sample_address for the DWARF unwind mode, so -d/--data and its
> implied PERF_SAMPLE_DATA_SRC are not enabled implicitly anymore.
>=20
> As a result, --call-graph dwarf no longer sets PERF_SAMPLE_ADDR and
> PERF_SAMPLE_DATA_SRC, making the test fail:
>=20
>   expected sample_type=3D45359, got 12583
>=20
> where 45359 (0xb12f) is:
>=20
>   IP|TID|TIME|ADDR|CALLCHAIN|PERIOD|REGS_USER|STACK_USER|DATA_SRC
> [ ... ]
> value from the test to the wrapper").
>=20
> Fixes: bdd051e249141c79 ("perf record: Split --data-mmap option")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006161309.3078=
488-1-acme@kernel.org?part=3D3

