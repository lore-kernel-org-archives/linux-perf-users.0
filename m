Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826901;
	b=czSxNoVPuq6HcGnfrpuISVNr9Zk/DPwnyboRXUhPZ+SEUXqVYx5BUhMznN9t44g9rwaV
	 BgRCC9gDMLUeNit+xE4PniNMNhdUQLuiL/iYK5i+VKc7ur3ToEDyhH5hMFlmGKx40vWsb
	 MKqTG5J0ehR/jIE2dnWgSi4ly4lGwiyg+MgcfpUofjyNia7HzCOqhsGekWuBkZCoiFZJc
	 Qqyj5WZ5L8zjIdvcuG3P4mqj/skfpuVl5qFnwp/ZIIhwY5r//fePHowzJQS986xNN6rvi
	 UxbvCwzXNwebZNw/KTBrOlM3r12xM85XJWGtIDNwcIKhsJPPPnjU1Ek067z3GKws2Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=twGHa1pF620mTWnHqaJhUFSkxVVz9r+1jf7TnwDdecA=;
	b=3c0SnN5IEywNsi4psC2zQafnpf2um4xA22J9QmTWStKD+1vlQRcOJZ8r8exlh/ldY4t/
	 mWQNC4lSbdvlhAjZtYp5tVpjn8YGO7YhY0TStTCB7wC4mjqTvUFS/9zDrC1J6Li1iVKyY
	 9reyOtUpK/v9z7FkNo+vnouIoorgymhUGnnS5bSoOXKtZsiNSnwb4f13+krPCi0ZuOffM
	 flpqRmL82ZWfJhC+XgPMtwGJudpQQLw2aNDI09d9QqMJjS4ZUtTb3hbRUf7+ntoBT61xX
	 aahp5oImVTYS3p6j4TfqdyACEJfHoysILl2VM9czrOtR9wHOHTLLuGioELqT/z128/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etQJ+MlA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D660B47AA
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etQJ+MlA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B6B1F00A16;
	Wed,  4 Nov 2026 21:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826900;
	bh=twGHa1pF620mTWnHqaJhUFSkxVVz9r+1jf7TnwDdecA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etQJ+MlA1cUkJEt3TmV7wcXvFVxCf7oa3txIejxTz1k4KjRIjpUWAZQOmf0zO4Wf6
	 Z7vzSrnYjChsGLcWYV4T8AYuwpEYSczBmK/50dx/NBiGojkfuMJXAHC7fimeAo6Tm4
	 wPg2tvQHdCbnSZB6V68KtJuzPPZGxn81AYvpQXOMFW/YA/kS9kARSEWKI9LQcqkaGD
	 PKbuAPH48D3SpGb1IrbUm16WQAo9yK6Rqt7tFui4EimC6fF1s6hXeg3SbR2Nf13Gxk
	 jVbnnUxE8FnbwR7SpwAjgWjjV/92wXWoSIOXkDE9aiw3yhPZ4Xxu3St1/Adkptku9x
	 yqhRGsRKubkCA==
Message-ID: <sashiko-outbox-198075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/19] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-6-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:15:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D5

