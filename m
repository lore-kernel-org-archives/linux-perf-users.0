Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725660;
	b=CzI0AMWjlFO386ueaxwbWJN1VuGegqITDwNPgfFD8j3AT4BOiuqDOGbMUr0DZF9gGait
	 jnmBobNHP2DMAUfkBRSc+0EHYLe78djl+ZusNjJB4SlbdQe1FAZ2ujAiPBxfD4AcLFdxX
	 zsuoBV1jmUDvdg9l+5ZUi19nWc8rV6wn4jQDR+Z7m9zMl7r0uTz+LnoHNNPaGvPEEVmsL
	 GeAVmx39wYd3DctXUoEb8gntpEIKa6h6jVwrE1nxMdNiB/r4Ji3T2uRKheM3knIz+qg9D
	 lOZhhJjfR+AV6t+7tWkuZHtuuDlxrVkltOCPxvpVQTplAz41OAKC8tAsrh2QvaOkasg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725660;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZInQYbUxcW7DtenoLG5Di5mlTcEFYHlYTealy8i6jec=;
	b=GrEgt/8j/lJazopgONV1k3pzLCuce+pBTSFLb8D9+R1Lzm4otkst39fbfqq/RnpB0GVs
	 FeDkwlHvmsn0PcmeKFiWGIN2mpDZF+buldxkqNmR/yPl9w8aJUXtbBZajid4GjZs8zu8q
	 ABLmRqUp2jREj0KPDYZlflHiJ1iXDtg33/JJKYfwML9z6Q9uNir6vq5wO7oiZjbqJG4KC
	 SqjIqIdg/1Wt1jB/WDWC1FSAjD2NZUP9h/JHEh6w415bC8+O/3z6Qpqjm1mHzHg4Iy+K2
	 SRYuLtQlMzUH1go4eH3r4vIYIQu25+AtrSrcnUVNM1+vOcFN7woDW/hPOrVonDaTKUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CRYm/p6I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46619606A330;
	Tue,  3 Nov 2026 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRYm/p6I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED901F000C1;
	Tue,  3 Nov 2026 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725659;
	bh=ZInQYbUxcW7DtenoLG5Di5mlTcEFYHlYTealy8i6jec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CRYm/p6ICZSxky9n/VQiT9ftqP0Xz98pTyJeInVCT1/uq8LOHegw/996L7obhOZCZ
	 KYah+S3oETUHs0AXYH3sdrtxI7OjqMW511MPhJB/1OkMOutdbAGJ/Dx5lIM7ljqA9d
	 tspmkeuvKOZeyN2SFMJDUxRcw141O60DY/zM84f7ttM1OiYxpiqU3XZO4jYZU1xXjM
	 gv6IGs07YCcPEgcxv9Z3AVEwatTD2iWNAqdrxTlKdcMRDd7MQlAb+/KFH9NXccX7E/
	 tc1oj8QhxIZv9DgZDNshINWa9fNHRZ/x3ouufFbPljjSd8u71ANmnztteHSHWWxeX9
	 o/Usjq3CtbrgA==
Date: Tue, 3 Nov 2026 09:07:37 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: John Garry <john.garry@linux.dev>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf cs-etm: Fix spelling mistake "should't" ->
 "shouldn't"
Message-ID: <auoU2bRDQkQkXJNF@z2>
References: <20261028183137.537812-1-colin.i.king@gmail.com>
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
In-Reply-To: <20261028183137.537812-1-colin.i.king@gmail.com>

On Wed, Oct 28, 2026 at 06:31:37PM +0000, Colin Ian King wrote:
> There is a spelling mistake in a pr_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to perf-tools-next, thanks!

Best regards
Namhyung

> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index bdcf94813129..65bce2450549 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -434,7 +434,7 @@ static int cs_etm__map_unformatted_trace_ids(struct cs_etm_auxtrace *etm)
>  			continue;
>  
>  		if (!intlist__empty(etmq->traceid_list)) {
> -			pr_err("CS_ETM: Unformatted queue should't have trace ID\n");
> +			pr_err("CS_ETM: Unformatted queue shouldn't have trace ID\n");
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.55.0
> 
