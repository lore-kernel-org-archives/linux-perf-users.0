Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C838422B;
	Wed,  4 Mar 2026 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662001; cv=none; b=ixgQ3OrA6y9EGGG1uC/lLsbWry+PxWj2fIYUHdJCP0DQAPDU6EEsAL4vGwKJhjUiIECfyII7VAfsuhZgL8E//zPxWTIpDPcKTTbNiqMrBMv0UYb1Z7q6fQBiZSioIWm92TE9N+tcU8VtqcAQwPIJ1NUzHtTNiSNzVZ65zcQBhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662001; c=relaxed/simple;
	bh=b7YC2waEdkFOMwrrUYbBe74dKFGeax1fi6WrLnaLX1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD8LgdkqsgeLtrYAF7BHd3sRPZjW8GLImAfukfiLJUrOgcr/md8LphBLwWPVZgY3tXUGWOYFMIxnjGeT3G2WgYoIRTBfayNJ2DAJysWqP2XwDTeP8w4ZtUNq9PzIhEWa09DxFmeWiAEn2c5fTEExHdpE6OUPAPVe7HMXQgIANPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo5cSw30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo5cSw30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD1CC4CEF7;
	Wed,  4 Mar 2026 22:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772662000;
	bh=b7YC2waEdkFOMwrrUYbBe74dKFGeax1fi6WrLnaLX1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qo5cSw30CVDFFUEfYUKmJdsb2uwKWUK8/rC6WPCWd99VXaRdQOmfla4+LXWmUHPfS
	 qMv/LsemgLxSP1vSNgW2AgGZYR2rk+Iv+++uRSJrjK7PV6wlBR4vAnt16cucWjDX+f
	 y5tX0tyEaevICoDqdZkBIbScoEs4Y8njt0VfBjIl3Ag9Zd2QvEjBVuGMq9eHGSCoH/
	 Kzo2b37NcKtWymoDta4jYrF8aIZ5/34K6CXaBS4yTG4zhIDdU24LUL4DNI7TpB08e3
	 +TOJcO2ORk7DNzxWjGwABkifDj3LOqoIBVnz6sW4mE5NctkVsod9+uO2zV/dkSFJkL
	 lxdTFdQv56MsA==
Date: Wed, 4 Mar 2026 19:06:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Collingbourne <pcc@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] perf llvm: Specify features="+all" for aarch64
Message-ID: <aais7jiFlUy1tHWu@x1>
References: <20260303230056.2074898-1-pcc@google.com>
 <CAP-5=fVUv7bJTfyJYheKqXcJFzz3f0-auXYFmOGYfjtCCQSA9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVUv7bJTfyJYheKqXcJFzz3f0-auXYFmOGYfjtCCQSA9A@mail.gmail.com>

On Tue, Mar 03, 2026 at 03:31:42PM -0800, Ian Rogers wrote:
> On Tue, Mar 3, 2026 at 3:01 PM Peter Collingbourne <pcc@google.com> wrote:
> >
> > This is consistent with what llvm-objdump does (see [1]) and allows
> > the LLVM disassembler to disassemble instructions not in the base
> > instruction set.
> >
> > [1] https://reviews.llvm.org/D127741
> >
> > Link: https://linux-review.googlesource.com/id/I52e4fef18d2e12b45f875231fa9d3efff2538fd4
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Namhyung, this should go to 7.1 (perf-tools-next),

Regards,

- Arnaldo
