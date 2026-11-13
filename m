Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583234;
	b=yZNltHz+HtKe+Yaw6d3XbIe5YXV6yZGEGXMOY3EootkhaDqzO0jbz/D5ZWrKaOr41LCv
	 WTyS3/e7Jw2WnQj6fh//muK4x6ulD605xFqUvWCmmj8PW068ys/wekoPFLoGZwWQuIFi9
	 kbtJGaAWBdSsRWPfFuh7W4uGz8Zad27Ilr36JYoreL0e+11Vug8MI6I3iPaHF8RXaVoMj
	 oKkfbsfVSddC33DnnPFk1Mw9B0EKBm8Qie1p6S/BF0mTI5fQawzPatlvG86dmgV6fVayH
	 dVUX1H7izKzqkOkBJsOOzsRtDhQyGEdkwYc35i79UBPrPXNK+cUrZT6RN62NUhdpVdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583234;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=S1pLWYbamOi5rXtFLm0Gwq6ZibslKhk1ncxUfDLldzs=;
	b=rzElB9iQcl04VAXXVzd4gFiR/pvJGx6lpkXvz5YGYxfSz90R7hwOolGCt4w24pNnDb7H
	 3qQUUxoowK9s76KSmkRaqSS5R6x6LFGhE62DBmkR8CojePFFPhpq2tiv7WcmL9BqygIRQ
	 ohwsETL5Cp1SdAOyl0lStIHE7tlmFSBIxm0Cvb1iL0KO7XN+ehlZEeMMwh11qA/Pk9aHB
	 S+09FjOEJOGfSAhmVu109RodXQ3rh7CGU1vF3Tto8LNTrRc+KPj5S/lrPnSdFoU716F6s
	 95uFBYdwE1wlV9hj9AXxXveX5C5cgnM1bORlDBs8j+0XGpZzQwM+mX+Lt2ZS6BfYgpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCBUVnEh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623F606A33B;
	Fri, 13 Nov 2026 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCBUVnEh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B129E1F000C4;
	Fri, 13 Nov 2026 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583234;
	bh=S1pLWYbamOi5rXtFLm0Gwq6ZibslKhk1ncxUfDLldzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DCBUVnEhluFN2HEDgsBMW1F2A4ZRslNIsw4PxHM20KWA7pF4wrjZTq6/lk+gnp52P
	 HZVM3+UOtffwp/3M2GVGCDEcwncEZiLTpvuhaqVKLrcNanY6S6AZMv6yRt3rCIgwv3
	 zMZzW2++Wqsa+492i/zlv2/E9JQPc61d2SKBUf+HUOSY2WKpD5xfco8cVZmgnwChr9
	 idrCMM2Y2Oe1aCHu9DRUmWnbtooL3ULIvh/Pt11xb3KFaokbo02XDbF+c2M229JNrt
	 6eTSo1KnEOlev7K91W2zAWj7Mbs8X5H+syMKZQotm/ISNNEPVVGy9Yid6yzDpJT54V
	 ayB6PxHII7QhA==
Date: Fri, 13 Nov 2026 12:20:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Mike Leach <mike.leach@arm.com>,
	Robert Walker <robert.walker@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 09/12] perf cs-etm: Fall back to the recorded
 instruction size on a failed read
Message-ID: <avcqv_oU4CkAZyDq@phoenix2>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-10-acme@kernel.org>
 <20261113151549.GR9176@e132581.arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113151549.GR9176@e132581.arm.com>

On Fri, Nov 13, 2026 at 03:15:49PM +0000, Leo Yan wrote:
> Hi Arnaldo,
> 
> On Fri, Nov 13, 2026 at 12:05:50PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > cs_etm__t32_instr_size() reads the instruction bytes from the traced
> > program's memory to tell a 16-bit from a 32-bit T32 instruction, but it
> > ignores cs_etm__frontend_mem_access() failing, which happens when the
> > DSO or its debug data is missing, and then reads the uninitialized
> > buffer.  GCC 16 warns about it and build-test fails with -Werror.
> > 
> > Use the instruction size recorded by the decoder, as the A32/A64 path
> > already does, when the read doesn't return the full two bytes.
> 
> This patch is duplicate with:
> 
> https://lore.kernel.org/linux-perf-users/20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com/T/#m5f610e381705bc587a9ce3d31be4e1e0ed595506
> 
> I prefer that one, it handle cs_etm__frontend_mem_access() failure
> throughly.

Ok, I'll replace it with yours,

- Arnaldo
