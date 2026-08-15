Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0C388E68;
	Sat, 15 Aug 2026 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838084; cv=none; b=Pyer2ylyb2kmawWw6c2YXJhalDjbkOghpFJw6kS415PYLAIf8fypJncjumPqV/M69eCQF/LcxGaF1dm2TGE8xK3k4eXTfuplURYxYSB7B3o6rr83dOiNClxSmGfoqzjgNdYVjvWo2oLFpXvEOtjdcrMzVA/JuCFWuEgBfS0a+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838084; c=relaxed/simple;
	bh=Vvr7n53lfGqeX1TNDO/BGs55aBx27cBL44oR88eSBvs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jEdylh/MiV9wA4un9ZaYAlUdC6ZPbiCYNXc6BGwUjbwg0OB0Kol1LhMKPjwoqOZTVGrOZpmDGHL0BYv7V2f8VobXkzsFXm8dvlgZSy3lpuctV+jjC3yqACo3c2SWVqWRj+UVxLQ05CwvAu/3g1F47CWz0vh/atDX3jPRl2pqEX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzq0WueU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzq0WueU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309B61F00ACA;
	Sat, 15 Aug 2026 23:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786838083;
	bh=vZ1sosfYWZn5XqFy0thm9ZDfZrn9PZjryymCA/128Jc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Xzq0WueUAWv4Y/D1VyG0B3yfy2uNLG8l0Wd+gQj014HLzssIn4YiynEi9uIXJJ1MA
	 DoYzHkqy8Wv+RBx/X98siMJaYnmeTngaqhOVNUIHQk77/SRLkORnHWN6DnLft03fi+
	 QIJBFoUTSrjPcueDMrgFR7384/r3wx/KP4Y7HLj1jcGQFNU6cHmkKC6lI7XdCs9Ib8
	 n67Rcj8tUR0M1sxJvoocPtFMmE+vscrMRkGHr1HGeUQhe2PK5kCOmCqgwRScIDmqNN
	 qAVeRlEPxbXJWmHovGgpoTABSl/DlyOVG328QAFuYPn1QEkBAat6Eq7YRE0qF3+uwq
	 GRIMsksS92PCQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, 
 PVS Narasimha Rao <venkatasuryapala@gmail.com>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org, 
 mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20260810061925.32498-1-venkatasuryapala@gmail.com>
References: <20260725084704.15463-1-venkatasuryapala@gmail.com>
 <20260810061925.32498-1-venkatasuryapala@gmail.com>
Subject: Re: [PATCH v2] perf test sample-parsing: Validate
 PERF_FORMAT_GROUP values without LOST
Message-Id: <178683808316.3302182.2276194460332343634.b4-ty@kernel.org>
Date: Sat, 15 Aug 2026 16:54:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 10 Aug 2026 11:49:25 +0530, PVS Narasimha Rao wrote:
> The sample parsing test only validates grouped read values when
> PERF_FORMAT_LOST is present.
> 
> For PERF_FORMAT_GROUP without PERF_FORMAT_LOST, the contents of
> read.group.values[] are not validated, allowing corruption of the parsed
> value and id fields to go undetected.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


