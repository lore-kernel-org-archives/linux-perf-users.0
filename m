Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1B19644B;
	Tue, 13 Jan 2026 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338202; cv=none; b=kisvxsNwLNL+/MoXugaNwU6dPWf/Hq6Iogp4xMh0PFtVFjmIVHz9XEWP8Hf9rvdNHWIpx+vro+e/u/WlYj2kDxt2rfnuzax9NITcB8P7S/fabYaiq9bg87D/m4p45uPe4w9lnZLysQK0q/LOOxSxpdejcKEi8Y1ldvF0NO+NSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338202; c=relaxed/simple;
	bh=pbDGQIg6rpwBBzRRBDZ0VgDogl1oWvUPmiXHe/3qEcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYhf+xdlAs09ZQSFBX6x+HTozNMFLDENSwk1neiYtAsEDqHZu4djDijHrEgHCYbbKmirQccOWNkAqQLZu2aDCafsi9PAKk6vw0UCMAo60QGrnTuODXu8CpXKbcybPchyYCj+XKnddiU8Aa+sjz+C9GFiAg2jpf0c+dc8Z2JtIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyMillHb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyMillHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB84C116C6;
	Tue, 13 Jan 2026 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768338202;
	bh=pbDGQIg6rpwBBzRRBDZ0VgDogl1oWvUPmiXHe/3qEcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyMillHbY1IYuIG/Kn7Jfp9wETAoxJvPEznXZVLSnGCtreBpYMsiQ6l02+Fvl34mS
	 gPerOwa/tIoaFW/aL5jU4JxoX2DwFoENwUKPBECqFJhkZV6Ifd6aTj+2w6o056ou4n
	 gCsGPd6zua09Z9sr+8JXc3yOUBg/RB3moAyGH4m1xrIDlvkdjRMQ3LSHgyKk3RH685
	 q7uHlb+Z5oKSuh2SH2DuLYaiRnXIcLE/suJVRCJr+QgVGQlkwu+0QJtnOF6MqdOmvl
	 E5C11hnz1PKMMBiJAGgehUfLxKIlUCWARYgESUrUJJY84wFX/PnAKM6+42HM0M9JN2
	 kLZxiUAhF9uGA==
Date: Tue, 13 Jan 2026 18:03:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v4 00/14] perf cs-etm/arm-spe: Remove hard coded config
 fields
Message-ID: <aWazFmD6QUV2OP0W@x1>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
 <CAP-5=fXbz-jgh6=WXn3V3UoM827t4UBPe9oK_mRh8K7Q6RRC3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXbz-jgh6=WXn3V3UoM827t4UBPe9oK_mRh8K7Q6RRC3w@mail.gmail.com>

On Tue, Jan 13, 2026 at 12:58:16PM -0800, Ian Rogers wrote:
> >       perf arm-spe: Don't hard code config attribute
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Most patches already have my tag, sending this for the remainder.

Thanks, will add to the ones missing it.

- Arnaldo
