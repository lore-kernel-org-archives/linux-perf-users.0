Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634030;
	b=qQz28ZHmGwuUl9mruut+f4x1zm2nVREh61yRbydmoRcLPNWOhqwVFnyoTo6jmxuqqHqU
	 Xgp1mcJZEYIUeuj7qKsfOcH0uU7tzDiJAnIRHSSrU7cqQuXvpUPAGtOvnlLD7WbYtQPdL
	 ddskoTGcTVGF6/+r1Wsyj2bICnjp3yBjpBtUXL4tksRhHh2CxPjSEK8mfukHOLMF3Uhha
	 V7VY+fZUlbrmrLAfCAOkmhJaxce47R2PyEKWx6dSIiRf0TtgU9HSNw7Y4iD11SNB3+6FT
	 uryTjQszD51TABm+xx2UI3g1GpbQT2SCNjn4+e1rfiXBSGIAG+e/igeJYMmsVl4xvJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634030;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=JzqkgI4XKn+2Xg9CKdw/pLeS+R2Pa6tQ/U34hWLaem0=;
	b=S3hEeDT4atNyVbbneKL37WWQ56L8TWu2vR7Us1a9sapRL32M59pJVpEtcw+6DTglu8PV
	 hqkO6L1rWY15gNaJM6NO/CMA9qppQLvADIyS5QVl/zLnq/RHWVKI8ExUUjypjmOK8gOYh
	 b87A2Y6QtI9kRiY2LFNCwvGhJVBvbbvVjriZbg2eomNVsWS5qldTv/dEA5860gZUdRPz/
	 nf0QSon85K49/Ll7aYDImxoZbseRSVlO7JOVVqS23RjGTcuirUKJR6hxHoGhreKJ9wK1p
	 EL1kQZMzZs3H5huNTOAyYYhIDlzYOjBOuP5sgqdNPVYFEL9e82bZZ12VfO9R3fbbwpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TvH/VhjH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820C606A330;
	Wed, 25 Nov 2026 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvH/VhjH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57BC1F000D1;
	Wed, 25 Nov 2026 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634030;
	bh=JzqkgI4XKn+2Xg9CKdw/pLeS+R2Pa6tQ/U34hWLaem0=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=TvH/VhjH69e9gw1c+LupLN+HPd967kQUHhrw1v0Zc9vLptLFZtyy+4/lgQP6VOdcp
	 PCfMBIb1f/59Z3pNuhLw4xzbuA7HPJJcI1B65RWurLsAS1Ku4CUTHkgVreoxt3L8GD
	 prVbGZdiA87FLx4qxmReydkILok12JQ2bjYtskB/VThxbzrB2AhRetUWSpCog1Z6M5
	 aVxJqCZaSxyVZ6RO6Has5H4aL366bI2Nt2Wtenm4gNV1iqdJvD3CdxwID32mQbajW7
	 SUJU6zt/ivfaa9twCHdZf0FQL7wV9AynS1z/EBrYkfQJ4AV5LeOFyH05ih5xgvIdK4
	 xTpVa3t25YmmQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atishp@rivosinc.com>, 
 Anup Patel <anup@brainfault.org>, 
 Shenlin Liang <liangshenlin@eswincomputing.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, lirongqing <lirongqing@baidu.com>
In-Reply-To: <20261102091809.2215-1-lirongqing@baidu.com>
References: <20261102091809.2215-1-lirongqing@baidu.com>
Subject: Re: [PATCH] perf kvm: Fix RISC-V VM-exit duration accounting
Message-Id: <179563402794.1738553.15078250246991180255.b4-ty@b4>
Date: Wed, 25 Nov 2026 11:13:47 -0800
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

On Mon, 02 Nov 2026 17:18:09 +0800, lirongqing wrote:
> Use kvm_exit as the start event and the following kvm_entry as the
> end event for RISC-V VM-exit statistics. Keep decoding scause from
> the exit sample.
> 
> Before this change, RISC-V measured guest runtime as VM-exit time.
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


