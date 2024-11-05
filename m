Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF5166F1A;
	Tue,  5 Nov 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824900; cv=none; b=X2MEK8qw7S7GUDf2vDjJtnO8VvonWV1KdJniLeVGeq/kFzAVwXRFOMxr89Oaw7qgiL1ks83Y7XSA4vOlQFhteuuAgh36ofvsLXrN7UgtxCfftd9iBTIcLDLMhFNfTRadWS/JZVakjkk7B0X5/uIbr+pSYrebz4xAdELuuiUpw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824900; c=relaxed/simple;
	bh=i1MV6yXqnpQf1LWUHeE9WK3SA3UiEMTLBIekvA0MA0Q=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TsOAiffRlaL0TyWytZ3cJzbttQStazgg6/ypl5FlkOX9DQ2Ec/INFQLvKRsOaUSY5uOYHfklkZLxuMQTTRsDut7qaxa9K3CP+NkmJbifnBmdDifNCXFe3VAvsDRk5clhFjSs6k0Mb8ESNOYr6P8PErjKYgOntNtzaFxOJ9yBOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC601RKq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC601RKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A39EC4CECF;
	Tue,  5 Nov 2024 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824899;
	bh=i1MV6yXqnpQf1LWUHeE9WK3SA3UiEMTLBIekvA0MA0Q=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=LC601RKqeOnG5Ok6rV1hZmsYdFGBUu41Jd2c1bZ18S9mWhzl/X+YkUWri5e4x25+n
	 LlXSiW5i+3ERFSwNE/DmtmLA0KQYSuPCBUMzMZfh4kWhpepOxPG8FdwHKIPNM+F/aM
	 bTrpC6YIgGLcC/5xNvgZOi/LJAXdPFvTAwtwNWZiFBI9cKyYfzZx3PsbjYrppwQL5l
	 ipFhiAHXDyBTsHJtH/6kJVM0BZ2JogqTclygltzCY4h+dcRgNvoc12Y0gu5h+MRpgB
	 Bby6Vya2PW9DNoMnbaHlHFzeiWw0xddEsUPkilY0HvHdbfbu2h2Dl8ehpbJ180wjqX
	 vLc4/xP8s5JTQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241028193619.247727-1-irogers@google.com>
References: <20241028193619.247727-1-irogers@google.com>
Subject: Re: [PATCH v2] perf build: Make libunwind opt-in rather than
 opt-out
Message-Id: <173082489932.149345.16688202672767622276.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 08:41:39 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 28 Oct 2024 12:36:19 -0700, Ian Rogers wrote:

> Having multiple unwinding libraries makes the perf code harder to
> understand and we have unused/untested code paths.
> 
> Perf made BPF support an opt-out rather than opt-in feature. As libbpf
> has a libelf dependency, elfutils that provides libelf will also
> provide libdw. When libdw is present perf will use libdw unwinding
> rather than libunwind unwinding even if libunwind support is compiled
> in.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

