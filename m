Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B44A92DD
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363337; cv=none; b=e5xZo+6WizSDVWeX9Gq2mqkI9WN5I9fHFn6g77yYKJrXdPU4WngsvO+uyu1Wo8Bk6KLUd4hLu5ZhUGEAiDitbjAvfrU3FJljmZQy6zuWWWIIcAWJLcJIjhd21WUd+bt8OVC9hi7gubEtlQSrD8Qc2+h4FgQAEH/P/j0k7Xa1iAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363337; c=relaxed/simple;
	bh=nLKqfmAPktl0uva8rKi1dW/oJw40gvZMGsNR+njCrDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sKp0rlwf1qox+Si9h8pcXgjpz5+b9uo6ug8dJYL4zIJYUmkkQ7CbgaC7wnhf6xC/cp83JTQJ57welFSe712BWZYRWuC0Yax3zFoK4NUJTG+HXx4Ef6CSlcrL2H2DmIZ4laZfBT60opdXEUjRfUCljWWCI4Joemx1NUwAJLMZHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj/Z6Hmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj/Z6Hmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661D31F000E9;
	Wed,  2 Sep 2026 15:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788363334;
	bh=nLKqfmAPktl0uva8rKi1dW/oJw40gvZMGsNR+njCrDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kj/Z6HmuseEoWtPYA91P5LtTc1jUuFTe3psgPwVOF4Jw9fnz0QuMU/XxqqMIwfOnN
	 pFBJeICdY0GlFuahNCic1PtrYoLOi88BvI6IcgvFjtas3c6M6NG+o2PWCzlOYt+s25
	 /xAKWHgWeOaeqz6XYt5JmXIgxEFAYJ2QjczMy1OmUuFhB9L1zzEdA88hctfiz3pLj6
	 tD4UdaO9Y/op81kCZQO2Kqj0Kzxiqc3etEgR8XsrZ2UDwyMD/xvckpan+vejeq4cjc
	 zTfhCd/dfY7RUJhuGxINeGWaLGJr6SJ+Y4x5BbeNTWTgVadQsk9KoToA0Yo0vjR7mC
	 k1/G8aai9VIVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf tool: Align structs in arrays in .clang-format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902153420.2069344-1-irogers@google.com>
References: <20260902153420.2069344-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:35:33 +0000
Message-Id: <20260902153534.661D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Configure clang-format to ensure structs within arrays maintain left
> alignment inside tools/perf/.clang-format. This prevents standard
> formatting runs from arbitrarily squashing tabbed initialization pillars.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902153420.2069=
344-1-irogers@google.com?part=3D1

