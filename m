Received: from mail.kxxt.dev (mail.kxxt.dev [74.48.220.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BB308F33;
	Wed, 18 Feb 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.48.220.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412734; cv=none; b=tDvfKLoJNpRC2AkVSS/dyrVK/diVjmqluLqsQxCOvfx6QW+gvMpFzmWZ8UqwzE681392u6GJ32XlCfnaGWBKNyd7uUxi99KoX1XooV0vWJgxHuAEWc8Xy1atyMyR5ZA3F08QbPPFWn+KQGrGtg8OJDdNW+wFxGELb1sTV6vfevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412734; c=relaxed/simple;
	bh=y4QkE3CZUnu/oKIHxzrejHqPBUCOGyUkRqc61SSuP3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skWVEki6+jEI+I+9LXNEJS0oca3rZkr8xAwBxafTei2g3qJSXX4HH/brEHQsJF9GNTyE5uDE9lsa7VQgL/MbgVvECqsvL49bC1VcNqzPODDHBC90tvqt8zsIEHLAqDRRh7ipUHNPT/ka9Sg7DqOeK9ifvsfuG1p8zmCUP+9Ic8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kxxt.dev; spf=pass smtp.mailfrom=kxxt.dev; dkim=pass (1024-bit key) header.d=kxxt.dev header.i=@kxxt.dev header.b=Ei5r45Rj; arc=none smtp.client-ip=74.48.220.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kxxt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kxxt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kxxt.dev header.i=@kxxt.dev header.b="Ei5r45Rj"
Message-ID: <d1a55d2d-b2b6-4763-a6b6-c7aa843c43ac@kxxt.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kxxt.dev; s=mail;
	t=1771412244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4ZvNDH5CJF2VNxy9ozaokK1FVsUVUjM80vtniXkAvY=;
	b=Ei5r45RjyWpWrKxmfWpBe+frKH6AtJb7HfbAl1xlnDBUuyCkWLcTCDtMNmeoG4kFzaJuT4
	Ex0hOprzR4jJSgZDhx9vxP0hKJnJsbG/cQKlfOZRMtMD8noNexGfgFFoKgqDVaKnfwyYuU
	CIP1Ez4LX66PQn37+zh2LVAbowvaJGs=
Date: Wed, 18 Feb 2026 18:57:18 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] tools build: Fix rust cross compilation
To: Dmitrii Dolgov <9erthalion6@gmail.com>, linux-perf-users@vger.kernel.org,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
References: <20260218084736.33114-1-9erthalion6@gmail.com>
Content-Language: en-US
From: Levi Zim <i@kxxt.dev>
In-Reply-To: <20260218084736.33114-1-9erthalion6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/26 4:47 PM, Dmitrii Dolgov wrote:
> +    RUST_TARGET_FLAGS_riscv	:= riscv64-unknown-linux-gnu

riscv64-unknown-linux-gnu is not a valid rust target triple.
It should be riscv64gc-unknown-linux-gnu [1] if this is applied to build user-space Rust binaries.

[1]: https://doc.rust-lang.org/beta/rustc/platform-support/riscv64gc-unknown-linux-gnu.html

Best Regards,
Levi
