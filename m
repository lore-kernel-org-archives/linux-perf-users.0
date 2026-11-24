Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553983;
	b=z6bgRYZbGrKDkpKfwFXlV0Q4CfUSZcoJz7UrDruiE9OuEc+ZwqiqMzPakx//19jQkVIi
	 Wk2LTGkgESXMS4BI7jRvs3U96CmomqrbGFBr+5PwLsbPeXcDsA4jwgm0E2z1UlJBZ3oYP
	 kWLv+ifzd7luBBKYekeo/cgr6DAfMA6D9qylnZK0zWUqCuWJG5596uVu1rW1u0ogtn3CJ
	 nvQHGFzw6GynLaaofCYW4GEottPF1DZzpmqMYkHLevjaoZURW3ZmnqOmaCH/2FYusCmSj
	 p05mc+4vcrhyBSu9ttO4qC+4dY6mlqiVPZ1msYmRPE60B3nKR/7LZXLkWKZ5ABbWwsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553983;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=BJEqOvG82zIOAOWDYZgYE+qdtWC5v670ijVSd2L32yc=;
	b=EsDu42Tj4HrnLXE9GG0BZoIf9q/k+v757gUzfXnmQTxN81YODlQKeOAEIjg2LYTx4Wur
	 Efi4NktWK30XlVDgPxfxu7xdPogRKvpT3eH0jWP6rx8VbsDOvQAZzt9RW1nZ67uhtTtMF
	 ji3OkMOHPoraUPLbYTXfnLjoWx8WjmHqJRajbxvMh5SaAQDwYvDFsSNY+mjYZUFsi8kLc
	 vya7aHIIT7KJNzbSRYPSaehn4MQxlm7Oz2HdVWaMTBn1U+dwM1LHWv0gjhFKAoWJv0iqP
	 YiJxvaaeaTPeWzK5reDg//fTVJWPQFcZgF4uNPHzjsDRU6rMMDm/TTjsiqtqPXdaliw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IF0RnWq8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519A606A697;
	Tue, 24 Nov 2026 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IF0RnWq8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C761F000C6;
	Tue, 24 Nov 2026 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795553983;
	bh=BJEqOvG82zIOAOWDYZgYE+qdtWC5v670ijVSd2L32yc=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=IF0RnWq8BBLQ9et1rN8mENnvCd163YM0m60w6kMbOjPhE3sCR06Z6M7WtpEHU4nTw
	 xDha1YkKL2mhZ0plNlWZB502jtXx6wRBDoOA3KwbtFrdSP7xUlA2ap5HNs5gJVZ4q7
	 IbjT2PF3GWKuJnmbN27mEiE6wn/K1lw4YnScKISGxKf77iyJtriXTShBucWLHJTyqX
	 JMt6aBF1c4SUwQB6DtVZOL95/JbYVnfcdm//8duQCau9Q2xwPbvYwQ1uu+nhu0BFXB
	 wx8WXiLXsFBO/kA70ZZ6MwH4Jang/XgmL7pty5Dle0V4ptNXIow1jJg9XmZAqeyuz0
	 PiQHtTRbMpXKw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20261118200057.2134362-1-irogers@google.com>
References: <20261118200057.2134362-1-irogers@google.com>
Subject: Re: [PATCH v1] libperf mmap: Arm64: fix transposed reads of
 counters 12 and 13
Message-Id: <179555398238.1562760.9579469813393708281.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:59:42 -0800
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

On Wed, 18 Nov 2026 12:00:57 -0800, Ian Rogers wrote:
> Reported in Sashiko bug linux-3291a858-209c-483a-b4dc-eeb57abdaee6,
> the 2 counter read functions for counters 12 and 13 are transposed.

Applied to perf-tools-next, thanks!

Best regards
Namhyung


