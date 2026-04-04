Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38D1DFD96
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261702; cv=none; b=OQISml4OcocM9Q+B6DDfG8i9uAytNMFMV3X7H/fwgjeBPkNE8CnyvR5GpTBqhKB91+aPCpGGQGwdgkCFGcE+dxO9Nayt4uef7uUhW0LvX6/x8q4XGCm8QIjSNdZQbOMLygPrAZ3RqVqzfkYz0k5oBIe7YTccO4zWgvTGLLq+QYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261702; c=relaxed/simple;
	bh=W2pW0QrsxXm4iSgx2dx0lJpJRttWNhdvHB5F275Fp5c=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FfXpZ5FOzoXKz98r4TYlu0wU6Dvh+I9WgLKzTlWf9GP3CWpT/8iT53KP6GSfpOo80MpSEMBsiiBzd0XNTz6mLdMqRrg55l8PfHLqPA+gEZdlsHq88eHuS85VYCuPvQaFzefDOHcXrrE7+h4ibWftUc4MO5UGC+wb+x8eOV+oq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSvr3D8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSvr3D8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D310BC2BCB2;
	Sat,  4 Apr 2026 00:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261702;
	bh=W2pW0QrsxXm4iSgx2dx0lJpJRttWNhdvHB5F275Fp5c=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=uSvr3D8XQ8yB/auVBa+sj4YFHp3h4BMA5NallQWsdYPy8P6toTTk49rlUJIBexwCQ
	 WJKpSKJULei0uhzA9ESk8yC6ggc49Xj0boAhGmYeeBQAVgtmwG5gWuAuHIADkW9i8I
	 iMM0LKkASXcug5nqgPl3i6ciZvW7/jzoPZNZhQNdOtlLYU5PT8AmFrQZK95gMO8/Bg
	 hpMjwLrnNxMikUr3nH2GgB2EAOHhuaFjTV9kIGp6sZoK3y7H+tEXXzIC2wji4Pvf4O
	 6iu4ImWLPFnCkvN1/0sJby4zopjPkc8q3zSjr68UdxyH0vyW8CggQMWqwREOoTxKpJ
	 mRwMqUxpyj1yw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, irogers@google.com, acme@redhat.com, 
 Michael Petlan <mpetlan@redhat.com>
In-Reply-To: <20260402145118.1379546-1-mpetlan@redhat.com>
References: <20260331101020.1270363-1-mpetlan@redhat.com>
 <20260402145118.1379546-1-mpetlan@redhat.com>
Subject: Re: [PATCH v2] perf trace: Fix potential u64 underflow in duration
 calculation
Message-Id: <177526170182.2123878.7712855657688931086.b4-ty@kernel.org>
Date: Fri, 03 Apr 2026 17:15:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 02 Apr 2026 16:51:18 +0200, Michael Petlan wrote:
> Although it happens very rarely, in case of out-of-order events (i.e.
> due to CPU migration when a syscall is executed), the calculation of
> event duration might underflow and thus a bogus value is printed:
> 
>     2.804 ( 0.001 ms): :49553/49553 rt_sigaction(sig: QUIT, act: 0x7fff403ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) = 0
>     2.807 ( 0.001 ms): :49553/49553 rt_sigaction(sig: CHLD, act: 0x7fff403ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) = 0
>     2.815 (18446744073709.438 ms): :49553/49553 execve(filename: 0xbb173a30, argv: 0x55aabb171930, envp: 0x55aabb171120) = 0
>     2.815 ( 0.534 ms): pwd/49553  ... [continued]: execve())                                           = 0
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


