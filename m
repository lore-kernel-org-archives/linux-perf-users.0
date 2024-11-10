Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191C55C29;
	Sun, 10 Nov 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254901; cv=none; b=FKdmMKc2qTbXIONZ2miGUEqtqjpgi2t9OyHthMIjajRjXOaDkdnWZDPUi+MlbPO2bNromNws1rv36Bg57uGjEBq+N1efofrK1ZplKH9f2fEpT/l5jXpyOEDgtRTY2QHZrFtBN5/ygZdLDQOfyv9ERQmQUQRizlsVIJlG2WNiXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254901; c=relaxed/simple;
	bh=JBXIFanmQXeLs3qZ6yNho/Yd2mSxSWulQTXSJ8lku+M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=obNcouRRRGhp2RrGhbXia3N05f2rNwcZam0SahDTzwUEuBYeTf/MU1qFp8kemAlxWCrRz1/3WHwSo/tPTX/eWcooGalGFv2tqKtwHknu/qXL7cl1XMwJsc4QARcovhKfkc/754GfPnY2OWg8QyB9vXYeFLZd3GfMNFRhStGypCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYgrwdei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYgrwdei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538ADC4CECD;
	Sun, 10 Nov 2024 16:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731254900;
	bh=JBXIFanmQXeLs3qZ6yNho/Yd2mSxSWulQTXSJ8lku+M=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OYgrwdeiIbXgYq4lpWU8ck843JRk9VLM45YTC7B+syAZuDHLWzeSXy8jy54D0SXY1
	 2aoJMvK+L+f5iVh4sLEOi/bRCiVORQoDSM6NNekqjJBEvfHI1of6mQNEn3EgNn8L85
	 AfRb3ISkyebM37b/j7yo8ZRhkfbedxURnqeUrBKP6D/Vup9fGQ+A8jHwvx44NRBxtS
	 S0n0DuUj8R9FDw3hURr7PPOKFctKxhTFKHPToz8KuH2tQmek/1WYWFl60NFULDOV3h
	 o59uDdwi/v47HNFGKV2O7MpNY07k/w7XupIoS1OJrg3QHE94bd7+10rD4Iy1j5egAh
	 4sV5WlXAgbO2A==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Nick Terrell <terrelln@fb.com>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
 Changbin Du <changbin.du@huawei.com>, Guilherme Amadio <amadio@gentoo.org>, 
 Yang Jihong <yangjihong@bytedance.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
 Atish Patra <atishp@rivosinc.com>, 
 Shenlin Liang <liangshenlin@eswincomputing.com>, 
 Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
 "Steinar H. Gunderson" <sesse@google.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
References: <20241108234606.429459-1-irogers@google.com>
Subject: Re: [PATCH v4 00/20] Remove PERF_HAVE_DWARF_REGS
Message-Id: <173125489927.241089.8450722244768775739.b4-ty@kernel.org>
Date: Sun, 10 Nov 2024 08:08:19 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 08 Nov 2024 15:45:45 -0800, Ian Rogers wrote:

> These changes were originally on top of:
> https://lore.kernel.org/lkml/20241017001354.56973-1-irogers@google.com/
> 
> Prior to these patches PERF_HAVE_DWARF_REGS indicated the presence of
> dwarf-regs.c in the arch directory. dwarf-regs.c provided upto 4
> functions:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

