Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4DE37E5D8
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172303; cv=none; b=H+rI9E9r31w5wCLS3r8PZylja7YZQI2Y9BJuQ7hCXomVM92cxXfYwK+vuMuEfeYuZiK66yS10iyMWPz9OWdqM+evJMLL5DeyOvUW88aDuX3b6zeTmQxGXpJiDv6uBHUZjl43VleJBIXWqa19o1/RgJPcctQ3E+DMcc5FQxGi+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172303; c=relaxed/simple;
	bh=19sQSlHMpUhyrJRvW2cbZRKAzvv5qzYgrE0Ysvup2eA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fAnbQRtwD3K+h8qnz7nxCDPUgi49WRiOmT54vCsk3K+2hYzaG3rsxfX3xoUUHbZeYA1ZngIeV5VcsJyW2mC98YC+r//iQ9wb3wIxOyXk8e0ceI757q9ZsB1McswOTnDD8HIEri4GsIe+dxgnmzNWFoYAtje++CzSRM9XZOdI8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJZIAMCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJZIAMCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14331F000C4;
	Fri, 16 Oct 2026 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172302;
	bh=19sQSlHMpUhyrJRvW2cbZRKAzvv5qzYgrE0Ysvup2eA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJZIAMCKXJREnga2y0NzDP+23I/A+8Mcpux9YOrlQDBiBIl3dhhtgNTMiKD+EYo3C
	 xV7JJ7Q7iBSKWjlJNJVwjjpeCStrwwuR3P5+Rrv0jizh0T8M3+gqdWDZsK7QYASmB8
	 2CWhbx4PgHeXfCzZwCWnFePwop4Kz+OAwXicUWwt9O5YWlsWd98Rzifo2OrTMfviQy
	 qN3pxHWSa4k4G/Tm7cnKM2lgokCYo6I1lbEi5P6b9whYXnlZwyNri6MbRswnMgz6wx
	 x2yogfC4bFbJ9i54IUfX2zYlwf4kQVVxq3Q7PFRfKPhLj8tSFZyTaJ8gUz3zuFXljp
	 zobuvoZm9L6zg==
Message-ID: <sashiko-outbox-174729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/17] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-3-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:38:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Synchronize the non-__KERNEL__ sections of
> tools/include/linux/compiler_types.h and
> tools/include/linux/compiler-gcc.h with the kernel sources (including
> ___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
> ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
> __signed_scalar_typeof, __native_word, compiletime_assert, and the
> __diag pragma helpers required by compiler-context-analysis.h), and
> remove the duplicated definitions from tools/include/linux/compiler.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D2

