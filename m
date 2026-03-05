Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD53537FE;
	Thu,  5 Mar 2026 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749233; cv=none; b=eudMeqOVCIhGXysGh2FjZF7AiBuVPzSKEtegFufl92YlR5K7SI8lBOTQnsy5i7GA33mSlOb5Dt/GgwC9leSeNSbIUTBAKkhyipuButltw7ekhV1elXWRyILK32z3D3IIC357/cWstyQdolNG/OrxLYtuJlEfeAZ75qbB7lUAbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749233; c=relaxed/simple;
	bh=Ye1tY1PtZJpma/4l34cTuH+sf9R/LVTHDD6k1HKo/PU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lh74mgyrtiJcuiiigozjdFbrt2U9Kl1QZqONSHKTW0COM/GUKs8Jtc/GkB3OGwYhU2MHs2+MmyGadG+urDMbH2VN2kSYxDcC1Wy/kq5vMAhjGc41iHEoSAcErG53zutC15VlHdU8meju5WFSU/ytyAU1/TzYeKY/QXf86GBlAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7EmmYPP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7EmmYPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3E5C116C6;
	Thu,  5 Mar 2026 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772749232;
	bh=Ye1tY1PtZJpma/4l34cTuH+sf9R/LVTHDD6k1HKo/PU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t7EmmYPPrq5Eq1w+EEIFtkKmxEh6Ugj0zdZQwRu0cCfkWvnOdFHKni7E8/qwp6W6+
	 sktPe6+0sJdWPl/H94nPLW+cWOaQf1V47Bk7ObbBqDZ0FwO/8u8fjzfxAzniGTLGFA
	 BKnsGMVRhYS+9YvCEYVVFu5XYKnqpVGZefsL8K+aAGLrsnt4dU/RdY+bS/5A2Jq5u1
	 4kLYqREKhjp3QeScoYrkDNdLXPKJOQwBqlYZBYgKD5X/A0IN3Yz9O2CTc2SZgaIkYV
	 M1Yk0VJqXswfyObNXn+TxVJ1xSYyCRlbStuQDnU6yquAcIqGRM3h5Yd5fiS3A7gdLn
	 8fqqmbwmIp67Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>, Peter Collingbourne <pcc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20260303230056.2074898-1-pcc@google.com>
References: <20260303230056.2074898-1-pcc@google.com>
Subject: Re: [PATCH] perf llvm: Specify features="+all" for aarch64
Message-Id: <177274923167.4113020.17078184650711628809.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 14:20:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 03 Mar 2026 15:00:54 -0800, Peter Collingbourne wrote:
> This is consistent with what llvm-objdump does (see [1]) and allows
> the LLVM disassembler to disassemble instructions not in the base
> instruction set.
> 
> [1] https://reviews.llvm.org/D127741
> 
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


