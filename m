Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555133BBBD
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759246; cv=none; b=NdtTOMa+7tHOZsvgpRKRnhKmyS+o1LnxINO7RxAFlFFiiJsvVd+VpwGD8E6JmL0U7OQrDl8hhxj0n0GphE80wN/LnDdEtyXLCdO4bjZPa7XvXIMyekii/YshcloqDKMkEDuVwEEL/jtFDLta+9FObpgWE2vfoCkVb43e7MbwzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759246; c=relaxed/simple;
	bh=z9jt1zIWIYp9WS6uXzDlhDb9j+6my6/8Ak9AfZ15FWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dCX5p1ESdQQ3aXiwSdVJeC+8G+tvJdRJCqTx2iEavfNMgUXpF49hS9pM6PXLWeJ5lOK2jVglTbBW1Y/dy7RZbsBGSgcCywsK+bBOqx4jwTgX2QmZPOXOvgqTT7fn++xgxW9Lym+EtfUvJLjVA2PcIQNVL3cVpIBTGr/vxsfZPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQsi4LSX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQsi4LSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D065C1F000FF;
	Wed, 30 Sep 2026 09:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759245;
	bh=z9jt1zIWIYp9WS6uXzDlhDb9j+6my6/8Ak9AfZ15FWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQsi4LSX3muGPg58NZn1DlIMDz9/68//nVsAOVOPuKK9wTdLBmp77if9lACajnbze
	 HODcOfN3zyIWhrRH4qXR7A8/4u4SAzeC5gvF8L0kc8zDp4sQRQqz8E5K82Nxf963Ig
	 X0is5hF6xTMpmJPGeY0mDZm8HJYIqU8z7l/GBFa2CFaS0sHOcbWRDOe5DDIX/s0mac
	 vsxaoFcU79d39h6eAPz5oE+lUw9XOcH8aKJxgVIK4SDSKigM9LzCZ4icQjUbf0VIxq
	 S1poi7giM5nEzJ+ZZC1uDQq8TEGY6RElUiV3STXQv3wwuj8IGoqgRRX5tT8+XqERQ0
	 REowfR3CG0QFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf build: Add the output Python directory to
 pylint's PYTHONPATH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930-perf_fix_pylint_errors-v1-2-f72151d8b255@arm.com>
References: <20260930-perf_fix_pylint_errors-v1-0-f72151d8b255@arm.com>
 <20260930-perf_fix_pylint_errors-v1-2-f72151d8b255@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 09:07:24 +0000
Message-Id: <20260930090724.D065C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Prepend the output Python directory to pylint's PYTHONPATH so builds
> using O=3D can also find the generated extension.
>=20
> Fixes: 5fe83fb352c8 ("perf build: Make pylint build test opt-out (NO_PYLI=
NT=3D1)")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-perf_fix_p=
ylint_errors-v1-0-f72151d8b255@arm.com?part=3D2

