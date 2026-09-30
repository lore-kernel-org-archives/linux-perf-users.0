Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD24CC63A
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800002; cv=none; b=YCcGPeS9rjRVZqsAyMlIH1KsJwJ4/XdRxmDk4enfpNj0AvbFxb7NrqC2bLdt29xh98sUOuVVcHeLOLiwO8UqqzXdEo8HEmeJPhPkhepaA1jncMbeERrF11ggmHtZblIpjpZuAgx5KUdx8HwRHfnKCe/Ce7wbzPPDMJx6JCe//D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800002; c=relaxed/simple;
	bh=m/4WZpGcjI4WKt4MZlKGUEtXwXCYRIjBPVNtTauX6b4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bRbg+HYjf7fX+7a1ArOYXcPXTSckNt6slxsoS6r8OE8s+BTyU6wTCUTUZ5w7ssULO3gnZPB0KsCABE1FGWx1yLs2AkDh89IbeH6Xn9QEGHY4SnLsCsFcKnW+b1XGYnlqIVXiri3Cif8+4JBHi4krKFNrxlUbFOBjxJKBCKDojuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP+9jLsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP+9jLsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DE61F000FF;
	Wed, 30 Sep 2026 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790800001;
	bh=m/4WZpGcjI4WKt4MZlKGUEtXwXCYRIjBPVNtTauX6b4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kP+9jLsax7EgYlFs7ZoIUYfH6XGizMfT0hUA4U6QCx08OVzi9N8OYxcst3RNoELXm
	 q9zk6ssJRtdz3BrwD2B8J49gd+Rr4HbjmMFhZdFGjr+wYhxY7MwdMnGnTkLaqY2qdE
	 KiMdmizPBHddciLHG7RmGyUMlIZfS9xE8tsxUMdfAtqukvN0vYFXsAxdMUZF0x9VJd
	 dxBFzgP8TQ35Qhlwk8vjoOHpZ0IM0Lhka0GotTYrleZ1O8oH2Ix4XPX9d6foerUdBc
	 IoAsurqZJJMlPaCQS7j4MDYfg6RkV+wAZDcGk6BQ9a4fp9JhnUwEVziFBR5AazvxsY
	 LI4e3q8/W++0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] perf/x86/core: Simplify hybrid PMU registration
 failure path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930202016.111577-3-blum@kernel.org>
References: <20260930202016.111577-3-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 20:26:40 +0000
Message-Id: <20260930202641.01DE61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Handle perf_pmu_register() errors directly instead of breaking out of
> the registration loop and checking the index separately. Reuse the loop
> index i to unregister any previously registered PMUs in reverse order
> and drop the extra index j.
>=20
> Also log the failing PMU's name and error code.
>=20
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930202016.1115=
77-3-blum@kernel.org?part=3D1

