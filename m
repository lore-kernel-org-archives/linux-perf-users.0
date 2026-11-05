Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855271;
	b=ZA7gTluHTdFpEpbZbAPlTReR7j2gKDmQE1NC4XiycuhSaBmgLmjSb9z+DNtwid3D2j5V
	 N2O/D1pJHhMOfcombBGwos8ccSJw3xjDKqAq1sq4BvXoVLUWSJUO2b1jL3sfcrPXzDcOy
	 G/sqUcgMHc3SrVkYr8L1TbcThgpD47MuBK+NrUwBhjNQI9mK5Ylsb1yf2I5mdGXtc8n1k
	 5e8i5odothaF+Mu6zwIqbT79nim1A+/C1Wi9zWMgRPxU2ZlPPJuD+uU79dVD92nP/ByaG
	 8U2Tt0Dw6g7ZelXHU8gV2KXCRFrSn4BLQlILzWeC4fE3plPsAe2iKpYxt3Xfg1p7LSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855271;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Yi6Q0LLSA53/Cz2aURPcplC/4LZHDSvLW4Z3o4uHodg=;
	b=svs5E2EKuxA0uXHr8Mi14N7HcqMxCjCCjE+5uySazvSD0vE33m4K7j9Jy3mcCnPCV+5G
	 +ExalP3u/5QvleffpBfir+xIz8KHmZ8hBeBZaMRHFCCskE4osuLlTP14498USh1qfXLDv
	 pJ6RDcvgDDeqF5ZjjxBFzTUrbzqsXkf0V+mzkHWHNiq3I602MuiFgnHvco4MpoUNmyw6z
	 l7O7lx09xyAsngRUICqJv65K7gthUAeuJdKCureqBXChfTijZLNAyGDpH8ZPrElLHvcnE
	 ahbs5WhmZFpyK24aAa89cvrhAMJJm5pxtPnqAmgf2m8FkLfHkt9gdyHWR9Kd5qmtHvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESEPfJCH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D3606A31B;
	Thu,  5 Nov 2026 05:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESEPfJCH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3BB1F000C1;
	Thu,  5 Nov 2026 05:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793855271;
	bh=Yi6Q0LLSA53/Cz2aURPcplC/4LZHDSvLW4Z3o4uHodg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ESEPfJCH3dzeJR1ZFCDzOt72+66AITx08TSsYm7Fw/45gx1dQkzKRSruSUUjKUheU
	 krTPHnTTh8fvkgg4Ehshjjr1z4FDPRdOytJbzRVgOWJyZTM+G1LSyEdtygXbr4t4CJ
	 FUA0BdGQZ99yv2AhAG/IQnqW1Mx7oJyFhuGTVjJ1J/GgLZhNVBV7xm+4gBKWk64Erx
	 E9QDkGsuNyM/e8I9ceGSb1Bs9yCDeOmKxm0E4ZgEENj9Qt7hP7/gtqFAgltczuhWnN
	 s/HKttV1pVWCNFALPhdE9ycSY8AWQnfk5GOiwfbBasen4BcwBpzE0dgMlkIxd1n5cr
	 07EyjS3Zyc3SQ==
Date: Wed, 4 Nov 2026 21:07:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, james.clark@linaro.org,
	xueshuai@linux.alibaba.com, Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev, Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] perf annotate-data: Show event name in the data-type
 title
Message-ID: <auwPJIaRjtfQJdta@z2>
References: <20261029071510.460873-1-wutengda@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029071510.460873-1-wutengda@huaweicloud.com>

On Thu, Oct 29, 2026 at 07:15:10AM +0000, Tengda Wu wrote:
> The same data type can be annotated for multiple sampling events, in
> which case the data-type header is printed once per event.  But the
> header only shows the type name and the sample count, so several
> identical-looking headers are emitted and the user cannot tell which
> event each of them corresponds to. E.g.
> 
>   $ perf annotate --data-type=page --stdio --itrace=f
>   Annotate type: 'struct page' in [kernel.kallsyms] (59208 samples):
>   ============================================================================
>    Percent     offset       size  field
>     100.00          0       0x40  struct page      {
>       9.95          0        0x8      long unsigned int   flags;
> 
>   Annotate type: 'struct page' in [kernel.kallsyms] (59480 samples):
>   ============================================================================
>    Percent     offset       size  field
>     100.00          0       0x40  struct page      {
>      10.15          0        0x8      long unsigned int   flags;
> 
> Add the event name to the data-type title in both the TUI browser and
> the stdio output, so each header can be attributed to its event.  For
> group events, use evsel__group_desc() to print the group description
> instead of the leader's name, so the whole group is identified.
> 
> While at it, size the underline in the stdio output dynamically based
> on the length of the header line instead of using a fixed-width string,
> so it keeps matching the header as the text grows.
> 
> Result:
> 
>   $ perf annotate --data-type=page --stdio --itrace=f
>   Annotate type: 'struct page' in [kernel.kallsyms] for l1d-miss (59208 samples):
>   ===============================================================================
>    Percent     offset       size  field
>     100.00          0       0x40  struct page      {
>       9.95          0        0x8      long unsigned int   flags;
> 
>   Annotate type: 'struct page' in [kernel.kallsyms] for l1d-access (59480 samples):
>   =================================================================================
>    Percent     offset       size  field
>     100.00          0       0x40  struct page      {
>      10.15          0        0x8      long unsigned int   flags;
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Applied to perf-tools-next, thanks!

Best regards
Namhyung
