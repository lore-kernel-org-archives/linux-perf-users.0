Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140338736E;
	Mon,  5 Oct 2026 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188881; cv=none; b=ji04css0Si2kUNOu6A+71nwSNaFWzmrR8ZAV0joOuI6j3xuNvW0Pkn9BiWWKT0vAEtuQPziM3n1s3C/9SoZ2jjDd6IbSUNOG9DHFrQt7j5xE/xjQpysSC9pKCrnBqo8sze2RjyaEKRSHP6AqQlhS3sSk9Ne9Z1WOBzrTb62OC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188881; c=relaxed/simple;
	bh=hMzMKrD5GRz4RS04pSGTUAESHa2miNS4pt9QSNa+h+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmB+88uDZhDK6xLyY48JXICIQk9SDiZsfRDEVp8eB165NZplOeqREhO+MYwmaAnUgcvXSoARs1QqQggYg1DSIoZXCRNl573jQ9r/dU+SxmBfQlv6F/pPTcTaVU2Co7qXpIO6sZjZo/OFHoWgp+s8YzSQN6DXTrGfdz2xndFJx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSRZ0AiC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSRZ0AiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1021E1F00893;
	Mon,  5 Oct 2026 08:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791188876;
	bh=qo4xR1q1NsbK0Jqv7gJMpCILZ1T8CSmK9ju1GsfOPWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kSRZ0AiCazN5TjrtDop8t3K6xVt9WxYch2HGvKPMUbczSZ6D0iqg04MNztQXDyLS4
	 La4LfMLGeGVzM3PGWIpdKx6Vc5phiV20Q1fs+j7VBv+9ljPkDC70xxWvCJXqWuDKiU
	 8yAs661YvZxdnC5Tghav0ONL1fWlVL+49gB9mJsnWYGEwoT7XeZq8ZnbIet0uqCkA1
	 W+O3CREIwVOMqTBffehQDMLXX6NgMz+qILZU8rvMzwisJDYCxd3PdJakMdipfW+qbH
	 2ftDJkxNyN8gZiOEkyWCxsopzMYNaY2ecE+7q1aekSxhytDOhb8Cj764LdJ2JvNf0K
	 DVni6KUSHK9mg==
Date: Mon, 5 Oct 2026 09:27:51 +0100
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Leo Yan <leo.yan@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Al Grant <Al.Grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Factor HW discard mode out of
 arm_spe_perf_aux_output_begin()
Message-ID: <asNfh-qywjOPxajj@willie-the-truck>
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
 <20260805-james-spe-software-discard-v1-2-0ff0e44c4c92@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-james-spe-software-discard-v1-2-0ff0e44c4c92@linaro.org>

On Wed, Aug 05, 2026 at 04:01:52PM +0100, James Clark wrote:
> Discard mode doesn't call perf_aux_output_begin() or emit aux records,
> and enabling it never fails. We'll add a second discard mode in the
> next commit so it will be cleaner if there is a separate begin function
> just for discard mode.
> 
> No functional changes intended.

[...]

> +static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
> +				      struct perf_event *event)
> +{
> +	u64 limit;
> +
> +	limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
> +	limit |= PMBLIMITR_EL1_E;
> +
> +	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> +}
> +
>  static int arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>  					 struct perf_event *event)
>  {
>  	u64 base, limit;
>  	struct arm_spe_pmu_buf *buf;

Is it worth checking that we have a discard event in begin_discard() and
similarly that we don't have a discard event in output_begin()? It looks
like quite an error-prone interface for the caller, otherwise.

> @@ -775,6 +785,12 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>  		arm_spe_pmu_disable_and_drain_local();
>  		break;
>  	case SPE_PMU_BUF_FAULT_ACT_OK:
> +		if (arm_spe_discard_mode(event)) {
> +			arm_spe_pmu_begin_discard(handle, event);
> +			isb();
> +			break;
> +		}

This looks like new behaviour?

Will
