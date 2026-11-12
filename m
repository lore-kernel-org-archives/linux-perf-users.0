Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510996;
	b=GTI9Ns7lvesBgj+lamavBFcxpADLNAFfIdOrflLTyDV3Cw5YxtNpb1I7Q2duPhh6B3TS
	 fOrWc+eb+tEL5tUml9whkfkSu5fEJC32pHzFBy8BCL/p7YQQGNHmFPfoSl8FCqWW3b6PR
	 5szliVWn/o0hKHpQVXLplU+MPP6C0mJdJFzGGmjyXXT3gWgDoXxBtpy6jj4kBw4hBnV20
	 BGxkwqX+x5iMMe1N9jKTywYyiIAC35ENn/2e8iP59Cw752g7SzIV5T3p/3/3nT9dlZlkX
	 J1eQztQV4v6tajcQL4ylF1I/6/+oAVKCszEhpWDgEm2eTrhhEZSxcsxx2YJRXi5tQxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510996;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=IIEUMbtDnFy3px0dufXVKAi/aJFPBCXhybdjUkL0fWw=;
	b=djXuaMRPkLP0vOR19IXgMqkMuGHDEnA7vk8YbwyDzmqopVBn/+syTHMuQqMK1SyPKqX6
	 vwqZvt5B5JWWWWI2JAwEeKtFQ+uvvxj7UGW97nBD97WMk6BWzm85tB5Xr87wJalBxmzp9
	 w0xTKn2YqfNJ2qq2WcpQjBLaqE3a9m+vDoQwGkUQxdpqbQRf198ekPrxyCU1OSU0tvhAk
	 dN6QriCKxIp5CppnyM9K+3Aay5xix5TVJ3rjdy31MWIXUWFb0cKaBHhj0p2EuOcz4nyQU
	 gKOhF1j8a3PdP9/wUdxZ9aoORTUWYqnKgYEZG3NsBNhRpJLmgcTqNS54o/RLRMTJ4EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnG46Tel;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1614606A321;
	Thu, 12 Nov 2026 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnG46Tel
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F44A1F000C5;
	Thu, 12 Nov 2026 19:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510995;
	bh=IIEUMbtDnFy3px0dufXVKAi/aJFPBCXhybdjUkL0fWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GnG46Tel/T/LVnBuKGuLylVa1Rni1Q0Xnsw23CxQYFnQPp4gx7PMBqXxPYmNaXzsN
	 h1xDUQP0djocODLayjeU1gkHCVKp9jMu3K8hN0Ufbv459ZewrRHFVFP9K9Zd0LB5Z+
	 8uJFYkb1WOhFv3rqCodurY6el9ZJN5MUL5z8wv/gw3A/8PVsTdxxsMXp+/DgxQ+Cf/
	 lRj5cMZGHhChuC2ia7kjRvgyh03oq2RZbWBpDzMj4PBrD6XNhnSET1bNQjIBpB8Xbt
	 bbjg+j/TcuAfyhzOFWWotKXXHBkeHDIgXOQYz/2+uGlvCYyfkP3E0JSmiTM2l0gTcB
	 Fu8qnFupwlHhA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
In-Reply-To: <20261022222245.2064964-1-irogers@google.com>
References: <20261022222245.2064964-1-irogers@google.com>
Subject: Re: [PATCH v6 0/3] perf test: Per-test timeouts and JUnit XML
 schema compliance
Message-Id: <179451099413.165449.9244116407892454819.b4-ty@b4>
Date: Thu, 12 Nov 2026 11:16:34 -0800
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

On Thu, 22 Oct 2026 15:22:42 -0700, Ian Rogers wrote:
> This series adds per-test timeout support to 'perf test', improves JUnit
> XML output to validate against strict JUnit schemas, and ensures time
> spent waiting for the shared mlock budget does not count towards a
> test's timeout or reported duration:
> 
> 1. Add a per-test timeout (default 120s, configurable via '-t'/'--timeout',
>    0 to disable, disabled with '-F'/'--dont-fork'). Forked tests run in
>    their own process groups and the existing polling loops in
>    finish_test() and finish_tests_parallel() check elapsed runtimes,
>    sending SIGTERM on timeout and escalating to SIGKILL after 1 second.
>    Timed out tests are reported as 'TIMEOUT!', listed in the summary,
>    and recorded as '<error message="TIMEOUT" type="timeout">' in JUnit
>    XML output.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


