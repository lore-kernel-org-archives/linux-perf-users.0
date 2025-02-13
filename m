Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0432036FA;
	Thu, 13 Feb 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467291; cv=none; b=c7fNXRrsH16Mk66u536fSuBnZc4MKW48yrO4XYtk0QoQ5chEKhEi5YgsrsP7/Ppne30B855P4X37EKR/WudE/o6emie2IR0hIFEM8A4s4X7AkLeM3f0D5w/jQ9BrOrczaN1swb3j6P06OEfQ7gXQBh4BSCfOFuRyBiIWV5Zan4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467291; c=relaxed/simple;
	bh=lYO6NRcKGW3pamNfzE5W8XjHsrirWmghOIIFmq2cQrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qUEF3cnCShoH8DcZ+/3/+geJnPe5fMSvQMJHLIe9mafbL6kMakhSWR+yxpb2H2tN5Rb1yTuBJbECdHCOqpIVbDv5M00hnrDYe0Dvf2Uhmx/ppOMpHlN+dEeL141f56qBlHPUVoaNETshCyh2pnRWh1EeecDX7u+qu0nKFI2Q/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar4SOuP/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar4SOuP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DA6C4CEE9;
	Thu, 13 Feb 2025 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739467291;
	bh=lYO6NRcKGW3pamNfzE5W8XjHsrirWmghOIIFmq2cQrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ar4SOuP/+ZV9P5CZ2t06lNM75c0c23a6gdDwaiiG+E8gCGS8tOASl1Wgz3mMzXUUH
	 5UUyNv2sOVstI3k2U/ZL06T9NgLp8hKzCDUCwLsWTjqfDnSDkKkEp/nQNJ1Qkv+WCP
	 fGPl+cgCeD21Y6UUzLKijYHmxqsgaFFKE4jvs0OLb2T5VQXLs2zdE8P68cE41RSj6j
	 R/ZWIIPnIsfiy4p+19hC72JLhCsHo91NiVCqvAlx9GDo9DFFLCbRfDv8BaiR5E01yM
	 mRE5q17kXSCtphU+KQLHFVE4w4C48LjjwfIvlrBMCeGe9kM2fUWmKrFoYzjZU0Lysi
	 bR91KaIu2Uz3g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Masami Hiramatsu <mhiramat@kernel.org>
In-Reply-To: <20250212221445.437481-1-namhyung@kernel.org>
References: <20250212221445.437481-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Use symfs when opening debuginfo by path
Message-Id: <173946729082.1291083.16132326522323232275.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 09:21:30 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 12 Feb 2025 14:14:45 -0800, Namhyung Kim wrote:
> I found that it failed to load a binary using --symfs option.  Say I
> have a binary in /home/user/prog/xxx and a perf data file with it.  If I
> move them to a different machine and use --symfs, it tries to find the
> binary in some locations under symfs using dso__read_binary_type_filename(),
> but not the last one.
> 
>   ${symfs}/usr/lib/debug/home/user/prog/xxx.debug
>   ${symfs}/usr/lib/debug/home/user/prog/xxx
>   ${symfs}/home/user/prog/.debug/xxx
>   /home/user/prog/xxx
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


