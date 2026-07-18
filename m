Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3725A354;
	Sat, 18 Jul 2026 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344791; cv=none; b=cO+CF9mG5WvGVbaiVmWjkiQBZQ1M7WrRyG2XrAGefLhbH88vYI8BNKOcncol+RW4Ndq7JvnFO3gGPaBeukMTFtcUOxD0V0AVpI/7wpBByamxkcRj1zP6ZQbGg9uxUP1x99kC53ie+M974UtmY3+giix0xpdwax3wagJznhywxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344791; c=relaxed/simple;
	bh=fMT/LjMCvJayK4qO3ZazMFCTeIoDQLQz+2dxdinStNc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=M4K2v7MzS1qdyJ3YadFEP9did5mYmqpVBmNQtvRWeZ29b52j8z51vPjQtOl8n4ee7uwZyraMfuTOfoYRJpafNpMLEwApcRNP4bGqRw4pMn7CUMEUxB1PN4RmlLnlhdOROllWk/v/+D143yGIGsgAr0QBF0I0Jy08v0zvsrOh2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dKQGOsHw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dKQGOsHw"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 05A9240E02B0;
	Sat, 18 Jul 2026 03:19:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WgF-xEK_hTFV; Sat, 18 Jul 2026 03:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784344774; bh=fMT/LjMCvJayK4qO3ZazMFCTeIoDQLQz+2dxdinStNc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dKQGOsHwPy4QXE1v3glznCWHJx6ke1lQiw0EfBGSgD6zbzQdW8Lsqr2tRsIj82oC3
	 oKWyqSmQl8nuOFFdHZ4FfJhc5tvx8bC4Limt7LXG4mmA3ZNCnlVeNF8hNrGQrSfGIZ
	 k0U3tfltTDEGaA1W509xu7RSdoVtqm7q8axg1ABpxTZbnCOi+dvy5T/eeQsO9JsytT
	 fZJqRv0q/R7mJ+j4dwpHTsWEJV4HLsStEXdL83WPDyUUCpjhhGEigFD54Hsw9g+MYb
	 Gea6GgiODKDSjPaJqBONifqQT7r06OatQVseJYSf0SfoGIFpeIRCtOflNjqiXWNHS+
	 wHBtQopBol/0xGIqUyMZSkHndwZgTx6halScg5Kt2tVXTch0VsT1Lyk3e6zy9sYd/A
	 7kJq6DfnjxNTLynZzYtAJObB0KT2/FqXO10X+QtOjk4CEBfB2MeYB//SZluGzDncqt
	 WHKTKL2mngtfxrUvSQDWEsW2OxdETt7qDQnTl+W9f9/2rgpZ8jhSlTaqNdWQpUxfpB
	 oj53ATtddu9z4yc0kTUsD8IWA24cqhksaP1Y6j5GmJ7Cbuj2xIAfbakVxfV2KMxc6F
	 GLk3waBdGdgEdUTb3E0wGqeLJJvCL84Z0HyDhWlNCJU7rlgRPCjj9sTquiwGHlZNiA
	 prMN44APIBlsxti+A9Ak86S8=
Received: from ehlo.thunderbird.net (unknown [12.110.208.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CE7540E0031;
	Sat, 18 Jul 2026 03:19:17 +0000 (UTC)
Date: Sat, 18 Jul 2026 02:51:46 +0000
From: Borislav Petkov <bp@alien8.de>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 00/10] tracing: wprobe: x86: Add wprobe for watchpoint
User-Agent: K-9 Mail for Android
In-Reply-To: <20260718084741.c2ae6e41f2a1510ffa06d12e@kernel.org>
References: <178429796992.157981.3393977217853767915.stgit@devnote2> <20260717162857.GAalpYSaZ_emTMUEEW@fat_crate.local> <20260718084741.c2ae6e41f2a1510ffa06d12e@kernel.org>
Message-ID: <644AE756-0203-44F0-ABF1-9C35B9707492@alien8.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 17, 2026 11:47:41 PM UTC, Masami Hiramatsu <mhiramat@kernel=2Eorg> =
wrote:
>On Fri, 17 Jul 2026 09:28:57 -0700
>Borislav Petkov <bp@alien8=2Ede> wrote:
>
>> Hi,
>>=20
>> On Fri, Jul 17, 2026 at 11:19:30PM +0900, Masami Hiramatsu (Google) wro=
te:
>> > Here is the 9th version of the series for adding new wprobe (watch pr=
obe)
>>=20
>> any chance you won't blast out your patchset every day?
>
>Ah, sorry about that=2E I'll rate limit myself this weekend on this serie=
s=2E

Once a week is perfectly fine=2E=20

--=20
Small device=2E Typos and formatting crap
