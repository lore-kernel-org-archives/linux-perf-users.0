Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783954146A
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080691; cv=none; b=M78MtlfMDzt7P9bBGk53cdcDktANe3xiBKvr6S2XOYLLvgZFPiXlvaoHKRJW9zpFwDtrdykPDygr89xu6dfIu7OpZ6gQUTtN51k826vfVacl8V4j56HsOsQVX/Uf9goOvoP9RDpkYhYI/a9R7m035VTyFqDg64/vfIdxfGPOdCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080691; c=relaxed/simple;
	bh=6CqxSAyZ4tPsjHtVe5duxjJQS5UhzZ2OpyeH9Nq38jc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nvJ9wOq09P4y1e3kbRqaRkNMCcfZrerkMfndGe3UNmaeOBZA+xvgwov1YHe1Rxv/H1I+TUp11AguTEwlsvesnnZEMzmRIsrzZ5DxkNoc+MzpKEYmk89O1kRI41PV0k0zwFrvKBU/eTEDRjrO542hLrUv+aA/rQh11teN7Cag+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofDEg8qx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofDEg8qx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7943A1F000FF;
	Tue, 22 Sep 2026 12:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080689;
	bh=mv5nmCs3nHlKO0m5zm8yMiUE1q79vgFG0RdwFlVWfO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ofDEg8qxmc42FA1ETlJD6orjKBH8v/TCmTp82XeDEyxqmAmHGe/uQK2xPTZLhKbE2
	 oCZe5oDaMm62/Cx34o7SrVjaVMkgNcloDkG2ZlcqRgzz/Oac/C5GxiZq0as7L/fT09
	 XoQUjFlDaIrwe06ObGptgtXCTcJ4V4Z42KrjdZdnr1O9IAf/YvQEXYcQojgb+WIbOL
	 O75z30LbiOXjzC/vGKqEfhJvrpVfnzJQI+nw5CKF99E6pF7FxEXVhHxrvbQ5/W1KjK
	 tq3qz0WXT/fSTBgIseWtzONYDFg4Cx6ajfavfdr/lDXiOb/Q2mIA9FRBZuVilJ/RJM
	 XTlmFgYJfmaXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] perf mem record: Use the IBS swfilt filter when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922122623.1029132-8-acme@kernel.org>
References: <20260922122623.1029132-1-acme@kernel.org>
 <20260922122623.1029132-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:38:09 +0000
Message-Id: <20260922123809.7943A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> IBS events with exclude_{user,kernel} bits, as used for per-thread
> recording when kernel samples are not allowed, are rejected by the
> kernel on hardware without the privilege filter, so per-thread 'perf mem
> record' fails on AMD:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
>=20
> Kernel v6.14 added swfilt, a software privilege filter exposed as the
> 'swfilt' format term, making those events usable per-thread:
>=20
> [ ... ]
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922122623.1029=
132-1-acme@kernel.org?part=3D7

