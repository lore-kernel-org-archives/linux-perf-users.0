Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B59320D4F2;
	Thu, 26 Jun 2025 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959684; cv=none; b=COHh3hXKVAcJn8McIPGH4QobCPQ3lF/jdtpSKPxzL+D00AteYfeSrCLthlfXkMp8Y5FSVYQApNNtdAK98nnAljJHUMnn0B6uF5vkLRoe/PxVoanuRTlke8m69ik8sw9MP7xflKQLA77L7AeMf6knCNfzXuEbnLx8xhRYVb+mM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959684; c=relaxed/simple;
	bh=S6yftzTqRreb6fAcsiDFpqgkyKzzCrY4x9xkT5qRdAE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WzyLOSp0lHGiSMVxWHz8aPa44Xa1CsSl4ux0ZwW82sVs1blBK92rnGpFT4RCoGq+otKwzqeCRz6x43P2hsWGrF7Zo27fvji5xm1tsCEwVZlVde4JYH8Bn0YR5/+dEamvRlqgUYZ2aomBOyMkP9A+nAynUh4bgJhmgrBqbt7epBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+wvCNnD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+wvCNnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C58C4CEEB;
	Thu, 26 Jun 2025 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750959684;
	bh=S6yftzTqRreb6fAcsiDFpqgkyKzzCrY4x9xkT5qRdAE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=f+wvCNnDxZnMfL4t5xJrhaHFIFXkT3kpv0KYndklYVer3aGfR6xE3EpRZ/w0+i/Ul
	 lA2pWMoSp5cxy3iX47Gdi71d3+QQ3eEWNTUKEpb7JKbvASIBEchLwmzW/Pe7D+WZeS
	 3fF7tn/+QugOAL25vISKeqVudoaLnNIuM72FRCluyK2VwwO6SHd6+BEieSbdrLp1w5
	 dACCXN8o6/QXJ9g/mHQUI3jTyvnOEg8MXfLBmiMnxRfk3eP1hD5hkpsxUnlIJvdgsA
	 LqyDPHxjMy/zKqIIy2LabC7sL517UbRFMNNthx9/d51zmVI5ASmKuTRNaD6E5pb0gx
	 J2HbJPKuISeIQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
 James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, 
 matthew.olson@intel.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250624231837.179536-1-irogers@google.com>
References: <20250624231837.179536-1-irogers@google.com>
Subject: Re: [PATCH v4 0/3] Add support for a DRM tool like PMU
Message-Id: <175095968371.2045399.16176878639226540053.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 10:41:23 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 24 Jun 2025 16:18:34 -0700, Ian Rogers wrote:
> DRM clients expose information through usage stats as documented in
> Documentation/gpu/drm-usage-stats.rst (available online at
> https://docs.kernel.org/gpu/drm-usage-stats.html). Add a tool like
> PMU, similar to the hwmon PMU, that exposes DRM information.
> 
> v4: Rebase over changes like the auto merge stat to first wildcard PMU
>     change and the clean up of tool PMU initialization.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


