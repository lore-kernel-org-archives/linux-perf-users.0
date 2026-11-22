Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795388283;
	b=MKtmG6+7xjdNfI5LJp4ueniWC9V7CsyPgbCAELAg0pAlyYL8ybPwJVQt1bZbXV6qG5Bu
	 BudIIqPvZE5YaSGQgUaAUz/pjzHRD4uQQmpLtRMQZTI7UOns5xhHmH71iC186ah//69K+
	 HCQ23YuczEE/2Jfy4AGj6Rz1e9ys/qGUvyBsflH8X3nARtl/fM6fcoUb4WIklFbcyIivI
	 JuqscZXKB9lqO76zmnkNhCuuYtDOCRQBvqkmeD8+FXew+SKI7etQi9b7cjFe4HPfWoHRj
	 t4P6P13eo+XFLbTmqCCBQ22P3474Pr832m57k89UD3HqUsATLqFvNk8gl0W4hA2U/aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795388283;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=lposm0Vw+zeu8H+uijuR6PyW060ISkjLm9T0I+VfGj0=;
	b=jLeups3bbNOW5qTs4lJ77H7eQlWFPWMqpMKULi6I9fXQPibOYxE3F+1Itsz7Q9OvvmUw
	 5HtkjbWcyNGK4jI4YM90wAilRqauGimZ3hI7laUoKRbTYWLwDy555FnMAZhPycp1Pe+71
	 JdFxQpUwMbfAlRJfHJ7WCxJRyAqRf8mdmj6r5XZxaX4PcGxmgUfzAgDl51H3UP70Mz3/d
	 yhA3D3T2Pdk5mWqvnhP5Heb7b+/l9UeqDDtepAReN/bJ/XCDjTdpyvLadwCN1Bk455p5u
	 S1g7C6BZDZ8y0xAzfhrNguGMIutqPzHtPheNIqdhJWDyiDco5IBdGlrD/mTx8wL8LKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJD2zOz9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B78606A31A;
	Sun, 22 Nov 2026 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJD2zOz9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B17D1F000C4;
	Sun, 22 Nov 2026 22:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795388282;
	bh=lposm0Vw+zeu8H+uijuR6PyW060ISkjLm9T0I+VfGj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FJD2zOz9LkjKdyZZMtpWyGUgDo33x6kMZtcfOKWEUpiN2J1tHQsS5rCMnlgVajlVS
	 fkLrFXfUXEk0EVv0dIV5D9S6ghlY95yB0IhawJKVgGqx8slIsCLc8BuZBM1+hUT6GE
	 63HfcTDJIzjlYUeUf59jTIDCOnFmz3QC7Gz1VltzOt6Wh0bIGcduCgATF8SM1rfzgR
	 Pv041BDuShGSVXPmWlCeS3f0H60k9PqExfH34K3B/yBzMxKZ5B/J7Jb4RNNtoh4IU9
	 HNBDGwIoaoMO3Ceyd+2lQrJrOzqtCFWbah/BPdilUqiudVXxoYMl64LAMlWmV7pdcj
	 XTNXAuRWib6sg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Marco Elver <elver@google.com>, 
 Ian Rogers <irogers@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
References: <20261121065813.4143649-1-irogers@google.com>
Subject: Re: [PATCH v15 00/23] tools/perf: Adopt kernel
 compiler-context-analysis.h annotations
Message-Id: <179538828133.1041165.5939897182403929791.b4-ty@b4>
Date: Sun, 22 Nov 2026 14:58:01 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 20 Nov 2026 22:57:49 -0800, Ian Rogers wrote:
> The perf tool previously added Clang thread-safety annotations in
> tools/perf/util/mutex.h (GUARDED_BY, LOCKABLE, EXCLUSIVE_LOCK_FUNCTION,
> UNLOCK_FUNCTION, etc.). Since then, the Linux kernel has adopted a
> unified set of static context analysis macros and attributes in
> include/linux/compiler-context-analysis.h (context_lock_struct,
> __guarded_by, __acquires, __releases, __must_hold, etc.).
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


