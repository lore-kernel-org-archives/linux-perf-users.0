Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510996;
	b=av5WXM53GLYhnx5KFTrKHCaV97zinYtlqPRxXhuWORXBipV/5Ojxjqt6DXpmGfC8TySF
	 EmHZ4UOT66aamUh876zFjjaC8Lfp0BEaV9hu6inpOcV/4yoAEe689x+IdciAUsolL5i+p
	 sBf7ktb9YqXyjKFcZtXd4V1GEDubKuKdLCZjkNiNeUU2raq4f4XEPFtyXJn0sdMGti7xl
	 SqwMxO2zQYqTopRetuxwGLVkuchEavrd1aLDWrnCbJmFCZxr/KFgfaiFVA0hG0Hcmh0Yc
	 dJTOeeF4+P63V6IJI4MAw24ewEccg8LfWfnQDKXLNKKIlZBSzVtuCN0x4DxF724WVQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510996;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=TTpgPS27g9tvWKMg7nS+1O971VeCao8nId0PVN09cmM=;
	b=3FwVPu5FkLAXA3p0x/Zztpxg3ijMKueXvXEMU1VudBZ+2vvscq2mmefaCpn0XRzBR+C8
	 Ew8tAlRDKHT7bmvHtjjn3n7aXi3SW64HWZHC0VQefYJc7kU36JGNC0copIYsmCSgemS4H
	 DdC9D4IwYpmeGLqa4FiuyLf8LVc/vX9LoR/k34uNNG1Zdm56PR+slVV1tEL54qvTU6sFB
	 yfs6nP3nNv3mXeatKFKxl6KXqfvIEvwLbq15AAIbv51XknkG2Tm78WfuHpNvKWUD4lpcL
	 smxWW8ajFMyCaNRnHWpEcnIHnHeusqATEB7A4qiZFP9I6SVw2LL4146iNjBipM3CRQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajApgNCo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AF606A32D;
	Thu, 12 Nov 2026 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajApgNCo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51FC1F000C6;
	Thu, 12 Nov 2026 19:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510996;
	bh=TTpgPS27g9tvWKMg7nS+1O971VeCao8nId0PVN09cmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ajApgNCoD34Zjz5EYgerjdNOee/AmhIzIfaRwHUT3dGv5RFwY0UFg6LkcVLB+IYT+
	 348NWsLgGaYmd9r3nRG7883c7iCo+0bueqRhqmy1vN2ASaW/9jdlXsNo5JBTxaq88A
	 DZw4qzSSVfDXA4VgyyNxyiAn69ROZ+d4KKNYmR8s9e7wKfaP0oLUqKyaWywb7qyj0u
	 QBoZ6jjTxNt7sPsrS48+t5bS0UPbFJAYVbgfywFeHkf9/FrqOJIW1k4B+P8Cgk7A0R
	 4fAcqjevE8qhNKd+nqJ3aFgboxbQ0B4xHa1EVVAhCWg+AENk1eQtS5Zg3/6JqadpwJ
	 OuK9fZBeKfhCw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20261111192328.3917311-1-namhyung@kernel.org>
References: <20261111192328.3917311-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf record: Do not fail with an exiting thread
Message-Id: <179451099476.165449.2568504015872173129.b4-ty@b4>
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

On Wed, 11 Nov 2026 11:23:28 -0800, Namhyung Kim wrote:
> When a thread in the target process exits during the synthesize, it
> can fail due to the missing /proc entry.  So __perf_event__synthesize_
> thread() ignores the return value of __event__synthesize_thread().
> 
> Do the same in the perf_event__synthesize_thread_map() too.
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


