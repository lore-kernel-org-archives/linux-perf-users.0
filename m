Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547010;
	b=2SU5bc1yRiYQ9ImTlAEvA/J7fAn+h0+KmR6UpLnU0U3CSXcyQdlQdiG6z2cBepncoKdE
	 a1Ido43LoRKYQRSOjX4A/TdhyEnXh2uSrR5hYqirS89EWH3TL26ptb6BbtfT4KDlJiQnV
	 fK8befp1B34liH+ZUgzUrCkYgH/TzP4AyFCSvEooNws0QDreaZtJYq8bpKyBd6j8U13k8
	 T1dpSpoPLQZZ6wFMMrp9TdlAzXeskZuz+DB5v3Dlr3mvRGxEGO6mLLGmtdXFDaNHOdETK
	 qfzIyNuy+tYXAw+PFIB3eXm5/S7fr3rH+dr6NjTGm3C390mr44Awdew4D3bCBOB+MUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DEZLHLMFaIZZh6sop25oiq6fyvwG5qZr2DfGtG3xDWI=;
	b=mkZOWA3aIbsa6npBOh7dubc82vsuQObpXnrbZAfvb2kej4fb1EHv21y8F2fFiuC0uxW2
	 BGPtPS7Jx2hRS1bFSHK/LnWL7GxHuuk9Pud2emexEZhY2up7BkK9CVkTzv8S4gls30V4D
	 hIPt7W+XSSBygCx8FOpfH/QsOOj76TzQOfjbL7Q8Z6PLG6+qnExM4qkAPaAWZ86gnD4VW
	 t6qiQbjNLgM46hXeJlhtrF6UTSGzPLF5U3/KwhYUyMABtxsS7XUvVYN8O2+LIdjAiqYAW
	 uu2tCD9kRHHy4777SHGqFdPIoNNQhhfik/tHXN6eqDCFntzcZo6PoaUt242nxLJfA8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYHxQFVr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C1606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYHxQFVr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566341F000D2;
	Tue, 24 Nov 2026 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795547010;
	bh=DEZLHLMFaIZZh6sop25oiq6fyvwG5qZr2DfGtG3xDWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fYHxQFVrZgXz934zvBwD7ffnqrgHSVoKgYWdSxJ5Jd8r9wDABRU32ehhATRYEUaS0
	 eDmbwVntXMs01sCECV8pIT8PyYa/cdV1uHBNhE4cHhULirb4Ni7fsLDYUYrc+Dvvpy
	 1ahfD7WiJn3rf8TMp1RjZe6jZCX4gs4rYGudR71kHXcf5yvIjFP1O03veBXGEilRC0
	 LfYvhbTqs4e04yh32+2QvB907x5WyONxAt4oZoNftX6MYvl8SE+b6omu8P6hq7uJJ4
	 XPeSFED+XUFhu9pfkJRnpwq0EGPFK0gf0j7zKwr/sj0iT64yRk0O4isHgRlI2A4Udw
	 Wmn95jXrzMvOw==
Message-ID: <sashiko-outbox-231876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 00/17] perf tests: Add coverage for the untested perf
 subcommands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-1-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:03:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 17-patch series:

- Patches 3, 4, 8, 9, 12, and 15: no issues found.
- Patch 1 ("perf tests top: Pin the ring buffer size"): 2 potential
  issues (2 Medium)
- Patch 2 ("perf tests sched: Exercise the sched views and options"): 2
  potential issues (2 Medium)
- Patch 5 ("perf tests script: Exercise the list, fields and dum..."): 1
  potential issue (1 Medium)
- Patch 6 ("perf tests sort: Exercise the report and diff sort keys"): 1
  potential issue (1 Medium)
- Patch 7 ("perf tests diff: Exercise the output options"): 3 potential
  issues (1 Medium, 2 Low)
- Patch 10 ("perf tests record: Exercise more record options"): 4
  potential issues (4 Medium)
- Patch 11 ("perf tests trace: Exercise the tracing options"): 2
  potential issues (1 Medium, 1 Low)
- Patch 13 ("perf tests kmem: Add a basic perf kmem test"): 1 potential
  issue (1 Low)
- Patch 14 ("perf tests bench: Add smoke tests for perf bench"): 4
  potential issues (2 Medium, 2 Low)
- Patch 16 ("perf tests probe: Exercise the variable and line lis..."):
  1 potential issue (1 Low)
- Patch 17 ("perf tests report: Exercise the TUI browsers"): 2 potential
  issues (2 Medium)

Detailed reviews have been sent as separate replies to patches 1, 2,
5-7, 10, 11, 13, 14, 16, and 17.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org
