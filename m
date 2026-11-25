Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634028;
	b=NdctZt9QaCXjB9VHktHo5BKWd7ezFLLht1c4IhEWS66bps+tyNXeEFvDkttCH+MdQ+GG
	 b2gztxtD/Z3kukCuttfU5I06mbcZ3bliWMQtc8rMdbgg2Xne7qpgxqY1lyRMbuySmEVbn
	 I1loqGV/InAtEpR2v3ASOoheRoHrH5FTknQJ/UhE9ppNaa7O2j19JlM2HBkcM7OC4rF3J
	 t6gxXmo+1As/EY1HFkupHpZcHWvAHZQ0ZRIR/1NuLWxKoqqv7O+WiEnIgfy8oBW9Ktnnw
	 RROHd6G3Ta8rQ9o/oCihumAY4FPJXbV4Y/eFG1ZW3idwhvh8mKeZJtEbw5DzqQqkrYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634028;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=LtZw8LUX6DlKIAEgi1CuUF78MqKI72D67ymURbi420A=;
	b=Go+43extanu8p73/zuz+/OCuB5DLRc/Ii0u2L2l5OH3XA3y826jehBHcr7NRhloczwnX
	 RvU20N1Ys3mHZs3ap25b/zGApJ7oXBW6oNBdy4Tc3kfy/nK7sz/9O7T4PfZC0evzCR1xn
	 HVQ2JRNc8v2fsZvjNnkxaEKayUFOaZdjmTkn7U0vYcJ7hk1LfDQkvgoE7ZJC7nd9m/VxM
	 2vktgPABGTNA5OspiocXzG8Zrfn2K8I4M6jq9eUZcaIc5bNP3mwJC7v8h6V512cjSQ020
	 OiFJeVtnum1MJttAs0D4hpVQW71Rgg2UFpioadZifzmXLVsBsuidfppYQt6D82DUeIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQmKaBof;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7DD606A32A;
	Wed, 25 Nov 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQmKaBof
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761101F000C4;
	Wed, 25 Nov 2026 19:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634028;
	bh=LtZw8LUX6DlKIAEgi1CuUF78MqKI72D67ymURbi420A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eQmKaBoforePHATfQczzjIFhmDl5Pks6+LDySsqMFvvLlxlB86lvG67yI1ThBhHGG
	 iRDpG7fpyQENHfOzdVcMv5urlLb7Je5pKVSOrbn7mvwBwliF9gsVP4+ddvxRGvAdI+
	 yBKWKbawnpLT6p4ZcnqXRhtb4DQvBMHVoEPN9QNx3SUI6oMKF0XydcyTJlRlqTru7R
	 FpSOjnNmTm9daK2diY9V4GJbRWxlIaZvfgM7NkdmuduaK04P9KAVuTYfQQpPayLbGG
	 ZIw9SbeVckteG0M/mqBfQ0TasTlk1VX8jgkXaQNefkTnCOOvGm2Y3NFG/GXGrIpay1
	 5FtO3gFiG+Cyg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261124-james-perf-late-parse-attr-v3-1-f9e906dd9da5@linaro.org>
References: <20261124-james-perf-late-parse-attr-v3-1-f9e906dd9da5@linaro.org>
Subject: Re: [PATCH v3] perf build: Stub out __guarded_by() on older Clang
 versions
Message-Id: <179563402661.1738553.10663002855082686569.b4-ty@b4>
Date: Wed, 25 Nov 2026 11:13:46 -0800
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

On Tue, 24 Nov 2026 11:33:33 +0000, James Clark wrote:
> __guarded_by() annotations that reference struct members require Clang
> 19 or later [1], otherwise the build fails on older versions, e.g. Clang
> 18:
> 
>   util/env.h:142:39: error: use of undeclared identifier 'lock'
>     142 |    struct rb_root          infos __guarded_by(&lock);
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


