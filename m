Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44521DA5F;
	Wed,  9 Oct 2024 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455576; cv=none; b=dGvXOGGd8bFB4EeFAftaeUnmeQ/yan5N0oRGbJ+lEXItwMMGkTeJTD5sjqN5V2f4dfOEe3sjxo1A0s7yovM56gbz843CiugG6P08ImkV4Zu7LdsWwXyFmsmO9tYER79uWvtTv1PxxPpdPIH0evxFxkD695H8WYUcRrFbDAXFalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455576; c=relaxed/simple;
	bh=3H8ZczT380X5D8WBXp8+X1jRDpHkELl9AAoxz6UiKME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbdNTjeiiLNkoocgssU7tH7GiYb8YqYAKMNtEipYtAnGxgUbdY34S3fYn7EOXxy/kgjHELnPjO3sPhk4koziu2d8d/2OdIhzE0GeBaHs+BF8ryfqPfxbAvmwWYqDhZxau0/VuWPTzO6qlRhaaWRijQMmGdxrf0015St5fdnib8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzS2XoXl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzS2XoXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F76C4CEC5;
	Wed,  9 Oct 2024 06:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728455576;
	bh=3H8ZczT380X5D8WBXp8+X1jRDpHkELl9AAoxz6UiKME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzS2XoXlovTXp0rn2BL3yfPyDc65rOJsQi7drahURgSsyQ7VPkp2hszUyFncIHCOG
	 sgDySa6f2gvZPwsA0QTVreCO2ErTuksd/oJ4tqUlHPc3rjCd5c/wnU14GWI5oW9NFR
	 NWY3YTPkrTAMS2Krrvgn72SlktdZ3wk+AlDU/7djKq5yiSuFJiJasozvgdqJIpaFZq
	 ckHUJBH6XzpJbNNDQBO9x4OnpU+vBMx+Ffnf85vkSs5ej8DpeXOxKZjF6hMx3MTgPZ
	 3HRyb5mGL56XFEYxXTlidudcQQ16kePTUl/PbwztxzmV55hzrvE3OEayUOtDONPxqI
	 svLFIZ64ng2vw==
Date: Tue, 8 Oct 2024 23:32:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH 6/8] perf/amd/ibs: Add pmu specific minimum period
Message-ID: <ZwYjlm-lzDd4XG3U@google.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
 <20241007034810.754-7-ravi.bangoria@amd.com>
 <ZwQ2yzLm2yyaYOcJ@google.com>
 <8a105c37-d403-4967-8862-6e097328c836@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a105c37-d403-4967-8862-6e097328c836@amd.com>

On Tue, Oct 08, 2024 at 11:16:43AM +0530, Ravi Bangoria wrote:
> >> @@ -295,10 +296,14 @@ static int perf_ibs_init(struct perf_event *event)
> >>  			/* raw max_cnt may not be set */
> >>  			return -EINVAL;
> >>  
> >> -		/* Silently mask off lower nibble. IBS hw mandates it. */
> >> -		hwc->sample_period &= ~0x0FULL;
> >> -		if (!hwc->sample_period)
> >> -			hwc->sample_period = 0x10;
> >> +		if (event->attr.freq) {
> >> +			hwc->sample_period = perf_ibs->min_period;
> >> +		} else {
> >> +			/* Silently mask off lower nibble. IBS hw mandates it. */
> >> +			hwc->sample_period &= ~0x0FULL;
> >> +			if (hwc->sample_period < perf_ibs->min_period)
> >> +				return -EINVAL;
> > 
> > Maybe it needs to check perf_ibs->max_period as well.
> 
> We do allow event with sample_period > pmu->max_period and handle it with
> "period_left" logic.

Oh, ok then.

Thanks,
Namhyung

