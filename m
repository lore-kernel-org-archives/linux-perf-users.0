Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884356;
	b=i9lrMrT/qHp6XFIO6hM7AEQZah6CbgDlSdGc8LnCydXAOrSedXEUaK0A6bA8CzRYTTee
	 OOsIVCNDj+I+R2vKLUkfiTEbyRjLDgyNB3Z8wGT0zmBP7Vykbzr4QamR4G4IMq2/+cx/Y
	 fbDt0SdaOeDGJF1UL7L+Gs/TcjGDOR/KJdfjr2Zk2kZZ1mB5W+kKl/bDZObDWDWEagig3
	 E7OIV+cJLH6JLXln1IyZMi3w+htORQQnAkxlwv4URsJDXNY1NQRsO6lBIOBPE9GjfWN6l
	 WLmVclIm37f5fk1Yptm1DM2NXImw7W6ELXiyaxxVLR50kwRTO2OK+Zkr0dtHvrSWUPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884356;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5lAqJ8FoEni5NQXO7TBuQlh6wEtYy3vNMGyetkXsNig=;
	b=EtgZRMNkWj2OOwkdxToFVALxlDdvcAKzNOJIZ6sE5w0oHwoWvGpuhQmMdqVyY8ogXsyh
	 BRTMknEBETkEfM/UYwQEIPUGWvvLsdqQtnYhIq9Wf/P1MvNRCdddIUuNYC/2OcbT8J1AW
	 XJvm2mQgeKB7Mb7AM1exm+37XTcO2sQ7FT93JuRu4FR/iJuFh9GwCh/+JeDMy5nzwChF1
	 cPnpbi3SpjDomGF+rW7h/PwCGw/U0djDWI0bEDhMEB9Qz/XelH35jqxTXHscuCFKPCoEu
	 7a8Hp8t1C1593LoLKEvJ+XJPPj5bMc5tTAD9EbN2Uptxcx90E9CWhiohCckrNIqjXZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDCf84LP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD65606D82D
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDCf84LP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7531F00919;
	Thu,  5 Nov 2026 13:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884356;
	bh=5lAqJ8FoEni5NQXO7TBuQlh6wEtYy3vNMGyetkXsNig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DDCf84LPUGpyotbEAlkIYC2mjsjN0fgSECj5N2/M7jHdBir+L21KaUTRwe8a43CMb
	 VBdeRLDB4zcErvbMt7e7amiaYvmPk9f1BDf8RqGYZ2j1fVQL39+Zo01zvwhOBoPVfF
	 VAT0w4WOy7V3zlhYOf34C8lZSahwcy4lJYER3MLSvYMGWajtAVxAuiUKzOvxbaxxTl
	 9thS3h0BzT/1mE/jLl67KmFLQh9I4WO2EB1/J3C4TQChXGJuS0/ttczkBz4F4WmeVd
	 PMY2NWDqK/QaCwytaSMqgZJgSfbNCH5AeSRAiR5cgSQQ3AhmJWFfyBhCeH9KSKd4NF
	 jHsas5hurXqAg==
Message-ID: <sashiko-outbox-199126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/19] perf auxtrace: intel-pt: Use common snapshot
 pointer fixup
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-12-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-12-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:12:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Intel PT has its own wrap search but the same pointer fixup logic as the
> generic auxtrace_record__default_find_snapshot(). Replace the duplicate
> code with auxtrace_record__snapshot_fixup().
>=20
> No functional changes intended.
>=20
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D12

