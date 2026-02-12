Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594BC29993E
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923622; cv=pass; b=MR7h7cVZlVRfKYbeH1kRxratE9I5Ha00hDnWkJbfX7+02hokRQNDBxu0JLykOwurnFhXUApjTTEIvYEF1hYlxm27fwiMcUtnJEdgmro40+6pj16NfR+rSV2+UQttYjpXXp0kWTvxco03UTE4D6kwWQJ8JASkyFfiqIoXX+S3r7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923622; c=relaxed/simple;
	bh=WrAU5zrjcCn1BNqI30iviL/tAjy/fZDO2FGkV8Y+Dv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7ir3UYgPxxzj9szYRR9+sHTm94+GXje120fh4GSAYnRT8AmAreioJWIYJsIBSkcRcoYstKPATpsinMMc+FS3yT+Hu2uS4jc71xlPYA8Il9Ldz9zZpJgBvfFXIlsPymDOHtyx7MY+hhbcCuISBiY+fY9tQv6ZQMC5HuZzk7lB1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHjKdxuT; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHjKdxuT"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124713e4244so6045c88.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 11:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770923620; cv=none;
        d=google.com; s=arc-20240605;
        b=W1yQKxV7v4vOjqjyj5m2fjsL0i+g0iARU+q6WJl+HAO7vrSyWpZDL+LrFg6yojpIT0
         SIcM+OEG6sgf1rXaRPTuBsmQFal8WALr/wvnqp6TDmx/nIBmS/ex+J+Hy+f973cntfus
         nvEhmB7Z4lbFubA0D3TaoYexuxMuBz7O/8Tren0hGXPPhhMsJ2+ufa+AvlmJUWNY3ije
         PIF+mVwMkJWSA1McKviknMtO9D7+imrpB5Yw8CLtsb24JcyftBceCt0etXq/oB0OtDSH
         J/vx1WYLL3qxMLMECL7wqyqsb1KPoBeRmK3n3dJ8Evcu9L1lWzY4XoHArchArkBjnsmo
         4vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WrAU5zrjcCn1BNqI30iviL/tAjy/fZDO2FGkV8Y+Dv4=;
        fh=n5TOB7WmJBcHj89NSHZKtMqkTitm0QxoXin2iEoq98w=;
        b=TETFGCtaMZSysDGONalYWYwLQMtUGgpIWm29nQIwMB5RqyWeUOKTpmJFmtYUzSB0F0
         a4wpPaUgruKON7X1ZcUblVWuC6PQPAOhjx1A2KFG5Qhlet0ySzrH8gzX3fci/CzzA7LS
         qNwYzYr16lnoLVEcaQYBNGMGPRY/JzUqsPoToscYnIbI8RBPwmDzsiJSu6uoDUbE5BgA
         FS1AAzIfbawUDN/5SBxyZiLX13McAomesOUWEK4vINfedJSHrhon+FNHCPqiS46KzkW8
         rwHvRYk5Efk8nPky1SVlf/dxiij5XAE1vgInuxAcm92LTpnjspEk0SKLLkMS9DoZ0klK
         48wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770923620; x=1771528420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrAU5zrjcCn1BNqI30iviL/tAjy/fZDO2FGkV8Y+Dv4=;
        b=WHjKdxuTIk+Mm/qHn62GlcK5S1Svf7wfP7HBiD4rh3I87DPvGWnPathsSn9FNolcl/
         ezvVnu/H1fLxN3uhUNTAoGCs0AvZCPwQsJZ/s73HujLrC6UXAOKPgOAkTlucSPs3BMcK
         Nn9Xfo83/ccAQ3zWYt/4vAzDfDqc9lYVe8eZ+wcct6MN0WasjX3m07oG+n9B9ap3Myha
         AB3HV8Q9XavAtDD3TOOkIYvUFpIBrbmPMClYTL5t6l/B22T+0y/bQDDoAApheFPJ6hLi
         5V/joKBMLt8BAk1YnEhTqctern32QJn+VrEIHX0pm+e6LGFFpUSS8NFUcq0liKYVwTzo
         eEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770923620; x=1771528420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WrAU5zrjcCn1BNqI30iviL/tAjy/fZDO2FGkV8Y+Dv4=;
        b=fhTFsMGDSH7PkZHJFHZjIu/jeG6efBEy1Tt59qez7J+BVxj3v9Kh8UI8+oQBZ4iuNw
         ODmlWlDwEhHBXudPjScVPYn350xL25J9aZKXSFXghkvlJTaViH/BZ27ZpCNZZstA224v
         Z1sEddOrIy2JNNzk0sxr2H8ZMD1TqH2xWlGBJcifuoCRM5mbQBinj9kblP8tO8lHN36X
         AbVtad6EBv8F3/giz3AhaRMs0CgBQ+CYRWLjFYqwiGwinteua5/cheSupmAeg3hTtkrI
         XEQS/P85GqfMmxXWmT4tPKYjTiVszQdBc2TYbBs1hnwnRyqeoHrGWZQWb4ouXviH6yDH
         cbYg==
X-Gm-Message-State: AOJu0Yxis4e9HBrVZLhSk/4e5ZoO4uox68toMcvChjChqNXFaqoPuihP
	bRPZTjBw/aD+JyKNHqPL7Rq87hQq+OcTw9fSamffZ0ddoK4wp7iX+nGME3K85mEH6r4k6FJ/pI8
	nY7ElUmagBEHPXd/33W8k3wih3aDlMb0=
X-Gm-Gg: AZuq6aKwTbG0Kldwd5tqzeO2w7rINiL2by0Jms/3kPU68174Boa3grHkQfLsMNy2Xns
	aIPQIOzzjUy4kCDFcxWEUHFSom2w70RNaqz/2a5otZklRqKI7Xpl7KQQxYsKLUlWTrNo9ZQb2NY
	rvh9YeOSEjVIlofEB6D2UB5BwS0rU4OYyfGkLfoKgck74G2/aWTPGrrSYMPMEbeeuqCVoM33U2V
	JJDxVMFYhv0Xl04tuA4v65PbR3ZJ3N3904CtqiCnrGSDbXm8lKBntoIviQ3K6G06yPfkWFSWdmc
	xD5U7XCQ5xe8lyJsNZqdi3ytqaDOccHMN8C1qG09BycNjf+PgyZ1hD2v2ewmt5Zqe39pPJdNA5o
	Lvi3Tsa6mnHIsbgADLrLfG04i
X-Received: by 2002:a05:7301:1299:b0:2ba:6978:2b0 with SMTP id
 5a478bee46e88-2bab861518amr148339eec.4.1770923620251; Thu, 12 Feb 2026
 11:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212185810.648364-1-9erthalion6@gmail.com>
In-Reply-To: <20260212185810.648364-1-9erthalion6@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Feb 2026 20:13:25 +0100
X-Gm-Features: AZwV_QhZnAoZ1Pw8ot2wsf-1EvRj4OOkK0rQDza5R2-O6LTu3qN5n9BNcMnTarY
Message-ID: <CANiq72nmzYkHpLTwWxn71TKKTPxWprjPHxBau7Yat32P0zE3pA@mail.gmail.com>
Subject: Re: [PATCH v1] tools build: Fix rust cross compilation
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 7:58=E2=80=AFPM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
> Note that CROSS_COMPILE might be different from what rust compiler
> expects, since it may omit the target vendor value, e.g.
> "aarch64-linux-gnu" instead of "aarch64-unknown-linux-gnu". Thus provide
> an explicit RUST_TARGET_ARCH, and if not specified, try to match
> the CROSS_COMPILE value.

I would suggest explicitly doing the mapping automatically, rather
than guessing or requesting users to provide one more variable, like
we do for the non-tools side.

Perhaps using a "table" like we do for LLVM and `bindgen` -- see for
instance `scripts/Makefile.clang`.

Cc'ing Kbuild and rust-for-linux.

Cheers,
Miguel
