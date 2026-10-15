Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC3559C8F
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080564; cv=none; b=By17S4lA2JtnLjYiIxZA2x1P3NfQKhmB7fNJXzUEZuIU91U+OFU8D6apUPL3QsoH7j3+xegFc33blNVQom6WipF6HB1A7OLdNYnMK+PH3Ygg11eWkRvPeG0mH8VlS8p6K5CvJrl/QArCTy89uvsDXgRA6CdzQ0Cu//ybIDDd37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080564; c=relaxed/simple;
	bh=EBpDDl3tvb949wGjUXXLHozwHby1Jv0DIBnS0G36mkA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nubYFsA7qNyoCjX3QB6M4vrwn8xM75WGLiY4UbaZvtXgIJNAZErXSq7rwVE0D9SYiKs8m3U9NYlIIbYuRjS0SHkPgJ9YKb6bG7fXxbjPICxuj/o5yqNa9yWfnNier6/4yGYbL2hDiCpaZOnkVB57GDteucy+oEG+kqD/PJgA568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY3KVeHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY3KVeHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87E41F000C4;
	Thu, 15 Oct 2026 16:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080551;
	bh=EBpDDl3tvb949wGjUXXLHozwHby1Jv0DIBnS0G36mkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mY3KVeHQ1+BLaAGwqx4OdQ+tqTCjzDfYyfqImruaxJqDyq3VwymruzayBHZoTK3WY
	 OwgItBQuO9IOYN+/S7G2DricP8l3CBeH5WLkBdH27aKEQ+lHpZxErSSNS1WoAqkzuJ
	 x4duWeINJYSxZERZvfnim7WMmgcCtSxPn1pbaZ1kkWy5RQu48wQWqmxYYvlDDcEAof
	 jSrD1Tr4rKJ8X/BTDS9vgp34shWWA7PcrLVSolW3NV2IyTbnlRfTYTWMTPh9BCDu49
	 SlyWOB4oGkpFhgdpFABGuHwkWUPMHJz6x0rIvjShI+cavzeCkjujd5Ybn6llsMwGrs
	 rkNaizgETSaxQ==
Message-ID: <sashiko-outbox-173140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] coresight: trbe: Order padding before publishing
 AUX head
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015-add_barriers_for_perf_aux_output_skip-v1-2-5847d0578859@arm.com>
References: <20261015-add_barriers_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com>
 <20261015-add_barriers_for_perf_aux_output_skip-v1-2-5847d0578859@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:09:11 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> TRBE fills gaps in the AUX buffer before advancing aux_head. Neither
> perf_aux_output_skip() nor perf_aux_output_end() guarantees ordering of
> these CPU stores before publishing the new head.
>=20
> Add smp_wmb() after memset() in __trbe_pad_buf(). This covers alignment
> padding published by perf_aux_output_skip() and the overwrite erratum
> padding written by trbe_get_trace_size() before perf_aux_output_end().
>=20
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
> Assisted-by: LLM
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-add_barrie=
rs_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com?part=3D2

