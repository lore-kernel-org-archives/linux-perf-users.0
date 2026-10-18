Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1312D77F5
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331173; cv=none; b=tcklU8uAZZlAa9qNvJgI0oD11McM35b50EHl/ILYH2D6CwxgGjMIkfOW4gIDgODxak4zGludP44MYTy3MMNYpMor6Co+XEvCG2yXy56WFTo95KjCTQf5fqAZfwznz7wLTTnNauXOz3WZplYm6T+2WR30tQx2H45RWsiE9GHxvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331173; c=relaxed/simple;
	bh=M7IgLbIUjkv3tuOkZ+7jb0D/43BVRDwLT4nmzrJxSUk=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=WcJoLlHHso4oLs62vLlmslbUyMD224k0Uiwkj+wFwn74eSK7fkMsPu5SnCUYlH5KqYob64tsUVLcS1DtuYgirVDNnbbHLDU6/DT51eA3xOeHLFjooUaJoBH6o61F8Q1Hu1uk90AKweJDfXAxIY68ScI/j1rONaIZBStLKgw8GHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3oyEJh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3oyEJh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8722D1F000C4;
	Sun, 18 Oct 2026 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331172;
	bh=M7IgLbIUjkv3tuOkZ+7jb0D/43BVRDwLT4nmzrJxSUk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=D3oyEJh7zkkZF/LJbtUrpcgcmsePDSFTV967V2uRhBCr9m3dY3e52K008ynJjRTQL
	 Wmxx0lkxmP+K9EB51LjutsWNu2EKt72837HJjrNs88/6zImndHJwpQTxjn3oQGQmlZ
	 DlpbadxoXHUaoH5nOXRNcZ6yVdBT9d4gJvTAgCI/fQOpCM5e9SfoUiC/6flFQwMTY6
	 t/S3RPhvum6rkDCBu4B6KgKuEsccH2Rg0W/0880Ra+CnzzKQ5l/d/QV0+3X0o0ikYs
	 D7+PYddtCIJ2k0o61X7KTCtMCZOs5tyrtV0nKbPOQLpEcYb3pwy4UCU0MYoIUATTwe
	 txl4Pe/F4neqg==
Message-ID: <sashiko-outbox-176159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/2] perf/kselftest: convert prefix.pl to Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261018134322.26445-2-breno3011alves@gmail.com>
References: <20261018133032.24467-1-breno3011alves@gmail.com>
 <20261018134322.26445-1-breno3011alves@gmail.com>
 <20261018134322.26445-2-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:46:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Faithful re-implementation of tools/testing/selftests/kselftest/
> prefix.pl in Python 3 (stdlib only). Same unbuffered stdin-to-stdout
> processing, same "# " prefix behavior.
>=20
> Update runner.sh to invoke prefix.py instead of prefix.pl, update
> the install target to install prefix.py, and remove the old
> prefix.pl.
>=20
> Verified byte-for-byte identical to the Perl version.
>=20
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134322.2644=
5-1-breno3011alves@gmail.com?part=3D1

