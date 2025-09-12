Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC35338F54;
	Fri, 12 Sep 2025 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702344; cv=none; b=sDr3u1qembndOpEUzFljj0sPul/22UtpFYILIIBaxOrt3DBkywUACp9aIJ3Mjd4o5NtxO74zYbXBp6DIC7SLcjPnlEUtv+zt79e44J8ufoOYYe2BNXhVc7NbbOfEdScPayT6Of0Lki0SdO7pma/HM2DVPoCwpfD7vscickiMSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702344; c=relaxed/simple;
	bh=YEEaCZO5aN1y/1zb1AbHYkqAatzlAvFXSfhR1nYo2v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRbhbNtw9uQSP8eo/R3Urq/YbDZwVIwZvqH7lu2+U6g20fkDsxdnwl9qvOzICRkE2LTLWuIL1ZMMt8MzqCJWUrZNC2100cyxC8ABn4VoY2Y9pI5mZpNHPqTnGul6RYTBGjKKofTWg5ro6rHAyEp1iJYWDhApGBzHXI+syGvG7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBh+Slp0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBh+Slp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D7AC4CEF1;
	Fri, 12 Sep 2025 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757702343;
	bh=YEEaCZO5aN1y/1zb1AbHYkqAatzlAvFXSfhR1nYo2v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBh+Slp03NFbbnGWPogR3V+Y6ccKy1YKEh+TT890SB1Mi6o6VrykNOSey1A0LF35R
	 35uabzq+f2zPB7r8tnlKVkaE6LiimTlE9u0To0ck5X/ji5r7mEhsPmsovQUctfyI52
	 IeEjoSxvHPAfY8wDD/vmWIr87II2awQiwlYVjbvhIYjVbeJ3VGDbyhxcndAgVOZ9xz
	 npEX0gRRaGFOlWCN9JEPASOm3jrclSOe4XF38YKFku5XNh8BvpXbgfDUCxIfg8AT4b
	 7iLLlKi4JZJY2RwgPzQjbw6LL2ksJSwBfSuLNW4Sm0sUq3s9HCviazZ8AaKZ8y12+I
	 tmT+ot12r7N5w==
Date: Fri, 12 Sep 2025 15:39:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Yunseong Kim <ysk@kzalloc.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: arm64: Sync ESR_ELx_EC_* macros in
 arm64_exception_types.h with esr.h
Message-ID: <aMRoxL9Zok_pGZ8u@x1>
References: <20250822145855.53071-2-ysk@kzalloc.com>
 <20250829132434.GI745921@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829132434.GI745921@e132581.arm.com>

On Fri, Aug 29, 2025 at 02:24:34PM +0100, Leo Yan wrote:
> On Fri, Aug 22, 2025 at 11:58:56PM +0900, Yunseong Kim wrote:
> > Update perf util arm64_exception_types.h to match the exception class
> > macros defined in tools/arch/arm64/include/asm/esr.h. This ensures
> > consistency between perf tooling and the kernel header definitions for
> > ESR_ELx_EC_* values.
> > 
> > In v2, ESR_ELx_EC_OTHER and ESR_ELx_EC_GCS, which were missing in v1, were
> > included.
> > 
> > Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks, applied to perf-tools-next,

- Arnaldo
