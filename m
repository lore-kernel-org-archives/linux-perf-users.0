Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B74E020C
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774301; cv=none; b=YsGWptUEUZ1Hbph0UXYJp9CZt0/6z3+iO9vdno6mU3F+PGz2ZdGoLGjef2Te0sAKN6FxmIjypT6E83sj1V7N7McuoBuynhTWNahFqiRTW4XrTpti6S65f8rCXpYWlopN5VOeg48Hz7RDcWGNjV3GBHa8yySLH8EVnOgbbAMVAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774301; c=relaxed/simple;
	bh=gMY8VcyaGhLH4EhTQIVw45P1fWHAHkpbKxRMqNze8vk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mrtq3MU4GsC2+uh2DVXPvddxrSNPle0VY9zlcT+H+NLOKyTZiYGgBkN67ksbXvC6BUWqkFMf7xGnVEkpFfJvG/Cgm767vP9wDa8IsVX9rFjLO3Jq8FhAF/aVlyNspkcANVjIBjRMArkLxiAeCelL2Zb9/ITD5/fYzez4ipfu40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+3NI9f8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+3NI9f8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3311F00893;
	Wed, 30 Sep 2026 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774285;
	bh=gMY8VcyaGhLH4EhTQIVw45P1fWHAHkpbKxRMqNze8vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+3NI9f8TW6Xba16WU+AlfrUxrd2iuiWfSibwjuyUoSkBEBEpMlOOA0ZMyD5VN4ur
	 SvzL5brK/ZUz4gUi51PeSeKLyTbdmY7n9DAU/t4E/gaHkF5m4+WUCXSKm7wPwyZCfB
	 D/I3W5Ql2qizTNw7myvuHUkvQBHrfXeIaOj7ixE4+uYooJi7g3QiMIgK1WRZrTzkzg
	 qKzkB0BqEeHm5TwVUhDUFZX3VMD+8qDBZ3MfruVSXhlMeWUszrR5QNYKR4R1swYm/H
	 OuD35GUxmBoledvdxqv311jKwfM+tu1BmdIoBApIAFGhThr2gDqH3geAKs5LPPCHOC
	 1uVc/qBeMF7CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] perf build: Add the output Python directory to
 pylint's PYTHONPATH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-2-945cd526576b@arm.com>
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
 <20260930-perf_fix_pylint_errors-v2-2-945cd526576b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:18:04 +0000
Message-Id: <20260930131805.2E3311F00893@smtp.kernel.org>
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
ylint_errors-v2-0-945cd526576b@arm.com?part=3D2

