Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C62258EF9
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096663; cv=pass; b=sgchRBDcY1vN/xKri03G2XxfBqxXay+VWncAYcw2x9DHRmeQAUGbuPEFuoZl9aKZdT4si1Iq2TU0oxox5Hpf1FtlDRuhguF68FnpEKy3f1k1U7xdVuAuUc3mytUywA8fbDduXNznkdXyGdEIWOOEkmT5pnF2NDLLyri/3IZM1aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096663; c=relaxed/simple;
	bh=kWd2ZlnaGIqOzhBDtr6CPo+wqxbzhTWntedFRzAihME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdLDemwrQuW51osbEC1x06+3PXYYcdg6LBcMB2kS29MkB0poGEXdbo6dGWYSaRKi0DCdK5g7vQNkY+F3R9TneWPy9tBxuM9z6xaEjcvANcLx29+9juk1BHFXtOmCGYBCgV93fFbzGPqnNKdy3PnsdI5BnaJj0QtOTDlNxbmDR2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWjNmrzf; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWjNmrzf"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso2892276a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 13:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785096661; cv=none;
        d=google.com; s=arc-20260327;
        b=GFcgLO1pc6budCA10ihARUJWam91yhNnVFU7jBOtl9Q4qgsQnvm/X2JZzufCOTBNDQ
         j0gTXulzmTVxJXkYXWDXZfpCVUOtyW55Gq26a+H66KX1id5MbYkt2auso9QCa3Ong9c5
         BjwJBmhWDz/9s64fmzGwK0gygYxffod/VObU54wQkGNJEnG2dz9ypZVozr5QzMeGnTaA
         g1M6q05yRUm1pihikyW8tUw2FBI73qbqHCb59hxEXjbglbPhRscI8T6y655MFLl0wxjy
         CCcxYfAQtAMJ0c+PPYwVhgRdKX5ecWMq/0P2HaS+Ogg82Pyyycpjp4ZffyqV08Oki8fj
         8yKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2+Bo0viCEB2m22FDhwGjICfsYsQ1DUFzTfnhxFo1SU0=;
        fh=uHfPaosE82ZfIRLcOUZkNzDQkfXyUvq8/lfZXuROD7s=;
        b=AKL2TQJzQo8CqOuCAL1cB21DX65eFY2Rpj6mPGs+YZ0iShX5DtXEDCzTGphkwwnZnC
         R9ZRc0US2vy7R/MMYaIe3v9pRq3oGYYofPG+rAbI42VsgHX6NP5WzW2s8v1bCO3Oj6u+
         GTLnUl4BizJoXWqAsavrvVxjjFT7NukQYgiUL4U21CG9aX7gKFXDLQW/9L6rJYjurALL
         hN4+Qm1BRiDm5bx77B7oADN2i9TN90AZdAPBBdw2Ov+JOSvFHB8xfvGk9MwJjzHyGzn6
         uDIbqHrjWKPO5SDoHLE9+TEMGUMS+CNAzWgnqZCsqCMZaLszcDODDNAE1rVFU1+/xBKF
         0JHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785096661; x=1785701461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2+Bo0viCEB2m22FDhwGjICfsYsQ1DUFzTfnhxFo1SU0=;
        b=bWjNmrzfOcznBPitgGj/HS0xLXFm9c9EvME+U9Y38WewNosDqzxcptmAggNl6jtEYm
         THi8L8kT7chED9bWcXg7+qUv/N7TMowQCnPZL3LwK7fkr6tym+6FhlhoxdYN4k1BD/Uf
         9qaSxmxHi4Sjq3UYpbzBwI0DQFesqVWoJqU2jiPsnBPApLeCtmNo0OUMuH18+2f9+5LA
         oo9hGHabcykOJDdvexQexzB4IBppCw9JBRQRZdnqM2zqJLAfzdlDvLn0nywYK8qtiGOj
         x9pUhyT/uAItjv0TDjAWjuOVo5/1tolIctW/xUEQ+wdpDz9bPsJdIrkZuxbm8Nu+sMBL
         pOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785096661; x=1785701461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+Bo0viCEB2m22FDhwGjICfsYsQ1DUFzTfnhxFo1SU0=;
        b=rSqPFhjYBAPxgbGxrLnaRbLLTJWVSiy+DCZSF6CQVr9OapXqcToUNNkrfayup2sud1
         6T91h/hDkHJ4E+35yVVESvJ0O3Yr1zI0HPqqCKM6h2CFOo0eq6BPNnfLApH4pVmyv8vg
         xYLefPrQY/XSnQbtQmrd4ZUjSAOPqyGSwDmtNCFkcFyEt2O/DsuyjwiVL65Rzcc/JrYk
         4Cb6ftP8mRW6laQMWKszvqI1qLR3ziQ+eaIELkqEwwcucq13BU+uaeNYAZ7bMieWUR50
         104h0wCDKiEtn6lcO9E38mv8TBqdEkp5V4d4ad7oqsFd1hASwnrEuLXVOu/6AcLVWt6I
         2uHQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAPdtnTenz+O80pgAiqsEuWU8plc/JcxI33BTyP+5m4Wvd5+gt72TKjgmwzCXd6rPBOLJ5kivmwKjaVj52S4nS@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpLnAQ4OkAi3d1omB6b2zL2IN2h8Vfjxe74ER9LiTDzqtynNL
	zhu8BEK4C4cPrwxptIMcxCdjTOHZJ0tf3VzwffGI1iP8eaxI4Od6LlVGS/YLTtbIHJejAwycj95
	fKUSeig+LAiYanbDGTJqTst7lg9PnZzM=
X-Gm-Gg: AR+sD11OVJwmhaagiceNKeT8sIvXQqeswPkEFQSj7lD1GM6nZs6miFunmgG07FkHv8K
	Wt0dTWKk70ho51w5OKX4mbUV69WNw8qtIeUaaq0i7wOutp++uyVa5Vf9Xb4wvjf1vnmdeTWCp3Z
	fmKLEQMictXsnxa3nOtqnl3QGC7XntkWf74jrpRHEtmwL8yb32tB7mUp3culwd0UY55JJgd/up/
	Mj5iY7lT0rHj6tx1n2jhaZIiUWa31Jv3G6Y277clJocl9iWOM7E++RpcJGEEjT4QrI1Hibm
X-Received: by 2002:a17:90b:384b:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38f294ea3c5mr6088330a91.10.1785096661118; Sun, 26 Jul 2026
 13:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
 <20260603133312.12848-1-freude@linux.ibm.com> <amOGWwdjnJqyxH5L@codewreck.org>
 <20260724160034.GB2032@sol> <amOTjPW__CNZui3_@codewreck.org>
 <CAFLxGvy+ec3nQLrQtwFZgGELhT2pKBDnHdD0pMvEGh-Mf3rjgQ@mail.gmail.com>
 <20260725220443.GA41199@quark> <CAFLxGvyBGzfwh61F5YkYqctNPCQJCpFOwTtKfDs4L+iK8WJZpQ@mail.gmail.com>
 <20260726155024.GB1673@sol>
In-Reply-To: <20260726155024.GB1673@sol>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 26 Jul 2026 22:10:48 +0200
X-Gm-Features: AUfX_mwZurnXooec2A3FqadK1K8O_igYrMZGYhDFbqwtbTaFK-ATjGnI_bmWgHQ
Message-ID: <CAFLxGvzaAH+ZGr-OFo=Li1aOxgwBjjR76T7m1CjFaL-6w3KPPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, demiobenour@gmail.com, 
	Harald Freudenberger <freude@linux.ibm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ardb@kernel.org, axboe@kernel.dk, 
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, io-uring@vger.kernel.org, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, willemb@google.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 5:52=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
> Then I would suggest that skcipher_bind() should check if the name is
> "cbc(paes)", and if so use 0 instead of AF_ALG_CRYPTOAPI_MASK.  Please
> go ahead and send a patch against mainline (for v7.2-rc6) if you're
> interested.

Patch sent.

> On cryptodev/master (future 7.3) it should get an entry in the new
> skcipher_allowlist as well: { "cbc(paes)", true }.  That would be a
> separate patch.

Do you mind a new field in struct af_alg_allowlist_entry which indicates
that  AF_ALG_CRYPTOAPI_MASK should get bypassed?

bool bypass_apimask;?

> With those it will keep working as root.  (And you mentioned in your
> other email it's used only as root anyway.)

Agreed. While I don't know whether others out there using it in
non-privileged mode,
let's be conservative. If something breaks, users will speak up, I hope.

--=20
Thanks,
//richard
