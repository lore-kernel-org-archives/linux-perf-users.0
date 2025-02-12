Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000220E326;
	Wed, 12 Feb 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368764; cv=none; b=WI0RSveKx6oOWLbbR1KewAlrpK0MUclQAcPW7R8kHkm9r2LQN1rMKdi8YPQX9RtEXbK/7e42/Y9Ht/Los9wVTUpbhFgTBoJR1URQOxFlo8ycAXeyl/zEdIueC2MK4aST9pDLJQl7Z/IbI6mRPmd+7rNkrtKj2/goE8AaRtU3BqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368764; c=relaxed/simple;
	bh=UMusHU1t5zzmDkuA9Xf7Kq0KXr1+7v+GF+RicmDuKyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgTxa2Hm2x/vTQffbU5MX2jjHvuTIpoLEf4ALstjjANlcQXuEzcg0yyJiJyNloG+wof//pG6r89bsxfOcAY0QQPVIakKfG5ODLue0x+9XZU8o8HBVwL89JAjQEq4blhy/hn9Jgdz+y5/SFgGSJK3/6DdUn59g+ydqOX2Ya/OrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foJGN7wR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foJGN7wR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dcb7122c1so4572215f8f.2;
        Wed, 12 Feb 2025 05:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739368761; x=1739973561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+ede4RrUjYL6rNcNJR8w+SRtlFFhYFYyooGZI9RRMA=;
        b=foJGN7wRFOn6VD5JkJBT5YP9/BgO4pxIDislSwcPkemPIJIh214JQEfXuDn/KYKhBt
         Sdt36uY2dC4iIIe40biz/UiHuDr3pqEwCDGV1blQw4lnPa0DBzwKz6blxNjkG86FN5hC
         DmGUvokgRLcJa1h3W+lGUJPg7VunNB9ayxh/N9A5Lu4WnI1UCCycDw4ewIYnZa/tOLVe
         b3jSSTsqu6kjRhPThzrGVImbOOCG5er56XMcKuLbEwlyRSKK+e7+TH0WD+/AUy7m6ZC9
         UAxoUZQMhM+hSMMLogE4N5FEPMUNchOONwnoU+3TGfirrGdyCtCzj8hNQgeDpVYZbNHM
         od7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368761; x=1739973561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+ede4RrUjYL6rNcNJR8w+SRtlFFhYFYyooGZI9RRMA=;
        b=SFgb0T73Ofvdf6UetX9vskfgPrLtW6ib5AHYTe0JecNwksWv8YIyzVXH26TqH+YZXq
         hFQW0hCFrbD5fkDp2lZgdsU6HLCVfisaUzu2AwEDDwWxSE6y9OA/TAPU/dU+Q9byfw21
         4O0sj0HlAvjYQIKDr18IFQbJds5gFA7Y4i2TUR5UNn4JVu3+aCnSZ9qe7TDfkvMTSdfB
         AwZhw9SlMsR2FdFo9ymeUROXLHtO9+s+fZvYw8Yfz5/mXyUBzAd5RJ/g/VsNzt1wRwmS
         HvMJmv4K6FMAE8gwamRuApGnFMPobQ2MV1riJHM9E3kc2noAet4KiZZUYh2Htx8AR9GX
         qiZg==
X-Forwarded-Encrypted: i=1; AJvYcCU8ulQHsBR4O8o1u0nUsxgf8wDKw7TU2+vnrqrrPw11vq/cw8NzjA7gnjfhExm1OyfW8eKAzaJi4WzNTCgzY0CQxQ==@vger.kernel.org, AJvYcCWfZfFseLlKIN3xh3/DwkOYiq6vmYzxbGJPh5UU1fKNNzayh/Sod7ZRXWXtNtN78gmQT21To1ytaXUbaWgV@vger.kernel.org, AJvYcCXrvHfWiaxUTrXotPy/ViS7Tsv+DavjLXYj0XZ0TQQnDLV33zn/fLY6HbdWLYBUDVZeWxNHoq0uHsC4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr4cl7JPz/I6rTgwxioLVZDdoZk0XMNtb3FUEmVV8eiohOMKqf
	whzLexMzaN7mNurcHUrT+FkDwgtknJtkZThhwEHNdC3e44Uj8v0r
X-Gm-Gg: ASbGncu0TWWEy22yZFTV6zCsAC7KYLj6xSspqCvGK6fhkBabUHheUCZMSsoxAFczEqW
	xUw61vpTzr4igRcfXuDzJaNqKUs3i4rWQi4vRnvLTxIw+grmGC2FBzO9I1WzkmkBOx42WKv93u5
	Jw35Je3Mr837NKiOaHlQtM6/OPYAWH+KL2j8tb7Zta/93/hO8GxU8HBWsi72+FQaj2i51iDKv7x
	mXaKMocvcFN7nE2l/7uKL/RnoSahH4pnQGie3TwnvyVBOl/mvNgS/ezG087Xr3qzCgAqnqvx+zQ
	lR50qphCh6qgaQQ3Y9jmDOO/0XGUdz0fQqQ1zaLNzxuMOat8cGKPeg==
X-Google-Smtp-Source: AGHT+IEKCoDJGY1lmlxzGAZbmqw2zwD51cxjE08/BzvCDXeJUL1uvgupw74+KSMNg7LFxI/1rdLUpQ==
X-Received: by 2002:a5d:64e2:0:b0:38f:21eb:5d02 with SMTP id ffacd0b85a97d-38f21eb5f2dmr1041208f8f.22.1739368761091;
        Wed, 12 Feb 2025 05:59:21 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a058930sm20853795e9.17.2025.02.12.05.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:59:20 -0800 (PST)
Date: Wed, 12 Feb 2025 13:59:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Ian Rogers" <irogers@google.com>, "Arnaldo Carvalho de Melo"
 <acme@kernel.org>, "Howard Chu" <howardchu95@gmail.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Namhyung Kim"
 <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Adrian Hunter" <adrian.hunter@intel.com>, "Kan Liang"
 <kan.liang@linux.intel.com>, "John Garry" <john.g.garry@oracle.com>, "Will
 Deacon" <will@kernel.org>, "James Clark" <james.clark@linaro.org>, "Mike
 Leach" <mike.leach@linaro.org>, "Leo Yan" <leo.yan@linux.dev>, guoren
 <guoren@kernel.org>, "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Charlie Jenkins" <charlie@rivosinc.com>, "Bibo Mao" <maobibo@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "linux-csky@vger.kernel.org"
 <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 5/7] perf trace beauty: Add syscalltbl.sh generating
 all system call tables
Message-ID: <20250212135919.4e7a26fd@pumpkin>
In-Reply-To: <0195f9a0-5198-4ee0-b4ff-ea7126dc8299@app.fastmail.com>
References: <20250210165108.95894-1-irogers@google.com>
	<20250210165108.95894-6-irogers@google.com>
	<d47c35dd-9c52-48e7-a00d-135572f11fbb@app.fastmail.com>
	<CAP-5=fUi4RYebxCGYZVHVEt0BpWVmUA6+-vDQfbai25_KJRs7A@mail.gmail.com>
	<0195f9a0-5198-4ee0-b4ff-ea7126dc8299@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 18:53:14 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

...
> I think the way it actually works on mips is that all syscalls are
> allowed in any task and the actual number identifies both the
> ABI and the syscall. In some variant, the same is true on arm
> (oabi/eabi) and x86-64 (64/x32), but oabi and x32 are both too
> obsolete to put much work into them.

IIRC x86-64 processes can also just make i386 system calls.
Even switching to/from 64bit mode isn't privileged.

	David

 
