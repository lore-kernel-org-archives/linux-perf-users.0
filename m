Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C2E36F8EF
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617996; cv=none; b=bD9a4km2c/+R9XEzOyYJDDDpIngHNIcI2dxjzTr5LSCoUXY6ouKJzbKOAogI2VJ9gNm+fpB9kNzOH3SVaVGWmmjiZdUjqpwrPsC0I2whB7q5UR0VG/Bbpe+Yi6KAbvKCkgkDBg0YfyEFKHLGUGpr2YnUYK8gjno/6OVgkYJfL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617996; c=relaxed/simple;
	bh=hfAFe6WW94xYWMj7rDZjIofFoSinLJRQteId9VzsTzk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OHlpyRt9jZgDRqXhdZd4CVMer5xZxluVijktVTDchdAX7AET0PVbjl+bV2SFeY2JBOtiWZ/ULtVrQ/GaNyo2Eixan9AO/yR+46+qHQWY6kPAy8nuMWOrmOdMBZHr3FeiiPzNvqk+oW8wqOizybmVUknEfWjKzdRPM/kqRsk0vE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDfgWJae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDfgWJae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2761F00893;
	Thu, 17 Sep 2026 04:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617994;
	bh=hfAFe6WW94xYWMj7rDZjIofFoSinLJRQteId9VzsTzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDfgWJaeny4qFkjYvNTUqjGM7P3q+x0mvrupWsG64nJRZR5lVqPRXZYHpdkoq9VcU
	 inKuj827836t9WpzZRlp1gorM0pAOUgkzzZgCSpmYx3F8z1HVI3b3IAQXVCoKMKxr2
	 V6POz5yCwms51zQMs1rPj/MnVz9fEHKQH59PW6i/hA2kgnCVVsdEUy/ya6NbpIAwHr
	 6eABstoJX3z0gk50wXyJPGpQhU/kM+iLshcxKIxzWcQWX4iE/Fg6FCYPV/UfZqQTSh
	 OUzhyedUEzwhO3ldvFvYzqaUz8N5OWkQ3I69waCHg52rsy7vXu3RHMGipbDMg2dm5S
	 1UN042UhYNCug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] tools include: Add missing stdarg.h include
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917040454.32916-1-irogers@google.com>
References: <20260917040454.32916-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:06:33 +0000
Message-Id: <20260917040634.5A2761F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Header file makes use of varargs but doesn't directly include stdarg.h.
>=20
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-perf-users/20260916062233.192271F00=
0FF@smtp.kernel.org/
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917040454.3291=
6-1-irogers@google.com?part=3D1

