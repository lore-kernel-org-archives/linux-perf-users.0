Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634027;
	b=f/5lZGGXRHViIOzul+kqtmcTHMQo3KBlbUiQGbAHR8JTFFebnMJbN0iTj5tBJaTPQl4d
	 yL3ul9DUUJyVrGQ2HvSvsZN2qxIOoIIHQZhAe97Etvy+hk4zSArXDdGJsGg+JpTuByQqV
	 fh0X/GhGqL4vMLltygrUM0hBWaO7EHgNiXnfDzmryO2pjG/OX/ErDt5IveCf5ZOHjwufG
	 6x+sRem0fuL8rCeYYILPRGhI89HAJllTblC7pS34tYcz8RnIbTX26ZSuSlrVGVCMoUbhx
	 UX2aFJqTv/nGlRU+NNOhCpCxiylvA8GLolqnqA5fKerwdT2IPDyFVywD7tArkt578tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634027;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=9y7J0GXoes6mYu/j6zHXkIzT4LF7gscuZuncmAInTEo=;
	b=4FNVCQ6wcsythiPGRu7jqf4BMCzZw/yzt0BTkGNeNxJL+y4MJ1Cv6CLOr9foiIlbmigr
	 2MpSegkE369Xl3e5F9vs5wRplZHfXHI172sGCBD8AwQzQlzevBtb9XSrTi3h/X10coSBK
	 nrhs5O+BqKkCabMujiBVyTfwN/nM++ZcjQIgcY1nnRzN40f3Trbo+MFsRtQqP06rlWoGR
	 vGIAoCgMPhTcP2OsEWCsxim+EbbvNR5FucPBoJyqpozUvwYT77ZO5x17L5zwIdnVN9amy
	 lACABXi1t5qEimDaKk9CPjf8QvUUN8L5ka72nuJe9pPw2yELsJzd6dGGr1V2TJo5i4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEgmTGCu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B31606A321;
	Wed, 25 Nov 2026 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEgmTGCu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B771F000C0;
	Wed, 25 Nov 2026 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634026;
	bh=9y7J0GXoes6mYu/j6zHXkIzT4LF7gscuZuncmAInTEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bEgmTGCutSym0c283ZkjbL34zLnCnwiA36H0APWQFSyonMlFh97W8aQc1o9l7BLpP
	 NGap7deGnvttXkLKe2hMpJUBOp3dFmGctc82cPxndpD8tpnD9LHs9G2d5lhPeygWd7
	 QB6v5Gws7bRjaBaOZwWx5QLQxpQGfXvXlim+ur8ehGoWP3rHD51Rjh/Pc/oEbwnHSQ
	 ABCjnEyUIcc+/weoyXYPys43r09BJXUhvCCB5Dlq+FeOtCZkRFCKNF0yy0UozmDupr
	 Yy+h7V5JzBhPV/9TfOOqOSY7re7TGraXlXsSaDIY1feHRFhMMAef/KVb9Edm6aOy5l
	 q7vOZXAL+orDg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Alireza Haghdoost <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
References: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
Subject: Re: [PATCH v9 0/7] perf script: Lazy symbol loading
Message-Id: <179563402516.1738553.8146705241035632403.b4-ty@b4>
Date: Wed, 25 Nov 2026 11:13:45 -0800
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

On Tue, 24 Nov 2026 11:28:23 -0800, Alireza Haghdoost wrote:
> perf script loads the entire ELF symbol table of every DSO that appears
> in a sample, and keeps each symbol, with its demangled name, until
> process exit. Most of those symbols are never sampled. On a large
> profile this turns symbol loading into the main memory cost of perf
> script, and in a memory-constrained cgroup into an OOM kill.
> 
> With this series, perf script, perf report and perf top
> --lazy-load-symbols read a symbol name only when a sample needs it. On a
> perf script run over a 45,073-sample callchain profile of a large C++
> service (about 1M symbols), the output is identical in all three cases
> (medians of eleven runs):
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


