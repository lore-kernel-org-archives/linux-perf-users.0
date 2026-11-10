Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279143;
	b=kqOzqeobk8CwsGqpuM2Rs3ZJzmET5q7vs3QMwf/MekY0grD00H0yg8sALayzw5BbGizx
	 xYl7qrHhkk67Z/QS2Bg7O3EaYHuA5jj/Xt9RJKkqiNAH93LaDnvI5PRXTBWujT7n3EDOv
	 bL+V02FDYxXMiTKC9TaEl2D+SRkIvzgRxJFZaRhEvlr+QWPPv1moP/ZKbi9TNpYScA/DR
	 MKAujShT3vHlK3v+SGp6TCTNWLyPkHCLBHkt22p+oNIEGLbKbQl9zk9vUbfu3erRVwaJx
	 F8ajHRrj0LR2mEfMaOgcLsjTpTx/h+RXQNTSFiBOkqYRW0qISfuzfoCZpStNR5674tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279143;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=/BigNl2VaL7rLRFpYi5hoO1tJBWhV6OR4KSa4Cct7es=;
	b=u31se/+TlveuNU01hLAB2mPva0xCoehtpulC1qmZvTNdHcEPDuUNkYxq8bf/Y6owON3t
	 4wMC+EtLjUjHlIdDI8MTYEoFUVKpcjLpWdZWRugH3xplAl1ITEuczTuEG5dRE4j1k06qh
	 +qhIjbJU+YYuOCPzBHXNHirLqsBXuHVI3uuRu9xIGInQWRGRZqpVq7Q3AQt6eBkjioTeb
	 648avc/Ju7SCgwosxSl1/+dTS+WIHUq7+lwAlH+LNwTg8+Xn6LUxPEgpAF2Xo+0EE12gA
	 whGA/maab8mcvrS5eJ4CcDmOq1QtrRGDCulPXkF3ZjEP/fY3jGJo0nJnt9GBTGoAtuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJpLugyq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1B606A335;
	Tue, 10 Nov 2026 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJpLugyq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAF21F008A5;
	Tue, 10 Nov 2026 02:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279142;
	bh=/BigNl2VaL7rLRFpYi5hoO1tJBWhV6OR4KSa4Cct7es=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TJpLugyqYyxeMgKLUGB+H96hePV0GSh/2Rbr1BFcoWE5f3cWlnQ6LSUxvXsVQg8Qr
	 8ZResATyzXsxTssItZD/nyaJcSp8lWwF1xjaFsEDZOwPwa2yRSp7E7txAa6RRJT7kW
	 Pnl0oFCiMy083W2Byvp/CZbjAkcLnwvPuZCHwOKWiu9rVKS/7Tj3DulPWMH7e09tKa
	 hAh5A6dkJO4t0wDM+6Jq5v6SM4UikmO8blGVDozrImcts3gPQQItExgtuWNhRe3GuE
	 MV0bEXYQLx44Eld4mqeFa6s6SCeW0pA4GjT0HdhWg8GtUMS+adutZWq0bfDq+ADlnf
	 zaf8GIrM0Ae/g==
From: Namhyung Kim <namhyung@kernel.org>
To: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, "GUO Ren (XuanTie)" <guoren@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
 Chen Pei <cp0613@linux.alibaba.com>
In-Reply-To: <20261105-csky_c930_pmu-v3-1-3f33e6b3d259@kernel.org>
References: <20261105-csky_c930_pmu-v3-1-3f33e6b3d259@kernel.org>
Subject: Re: [PATCH v3] perf vendor events riscv: Add C-SKY C930 JSON file
Message-Id: <179427914192.13444.10026998542210349507.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 18:52:21 -0800
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
X-Mailer: b4 0.14.3

On Thu, 05 Nov 2026 06:31:20 +0000, GUO Ren (XuanTie) wrote:

> Add PMU event descriptions for the C-SKY C930 core so perf can list and
> select its hardware events by name instead of requiring raw event codes.
> The events cover core counters, branch prediction, instruction fetch,
> integer execution, load/store operations, vector and floating-point
> execution, caches and TLBs.
> 
> Add a mapfile.csv entry matching mvendorid 0x5b7 and marchid
> 0x8000000009201600, allowing any mimpid, to select the C930 event table.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

