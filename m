Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF9392C27;
	Thu,  2 Apr 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122368; cv=none; b=KnPvKQMMvvZGvCBbc+Q/rG/rOjKBOZkx8UF+2N6YI2dezTXhS6sRjqvvwoTT1xYvPyDOcXKO6WuuQGAcCMuRdZ+hDuipAHIz+YOxXDzN7nThNCD36QJBP0QEA4f/r3qZCjYq7WbIE1apISnCQ5+K31Nu3LgPDksCDnHfEmfALkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122368; c=relaxed/simple;
	bh=sbzbA6SNescnwNKRvB8i7ZMu72AEh9iVWS/mHuNQ10U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/m9w/fVzf6GMLdU/FbQXpdKHRREe/Ha6AUW+EcrPL262jDPd2nHND7zxn0htF8Htjj3hRY97oDORSbTChtwWDyfK5RloNH2Log7dJs0L7fhCgZ59PrV8Ejp39ldlPvUO1nhiYnP4xsbj3KA5LAIYLorSGlQkoLSuaFH+t0KAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NoLkWdrF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NoLkWdrF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9165C2C43;
	Thu,  2 Apr 2026 02:32:31 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4AB83F641;
	Thu,  2 Apr 2026 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775122357; bh=sbzbA6SNescnwNKRvB8i7ZMu72AEh9iVWS/mHuNQ10U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoLkWdrF8PEjH8QdzJjqekgGTj2EhdNn1NkXKhD10AkGai/IDiWG1k1dpZp65URyi
	 u4xWsf0gTCOgdHV11Q3CQQRvCdxvUh47CTVMZd66fGa2u7gLns/ofQ59ZM9xwRJzGt
	 CyDCi87DM8SrfGjdaGgAIyTaHlQI8Zvu4McEYLr0=
Date: Thu, 2 Apr 2026 10:32:34 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf arm_spe: Decode Arm N1 IMPDEF events
Message-ID: <20260402093234.GG356832@e132581.arm.com>
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
 <20260401-james-spe-impdef-decode-v1-3-ad0d372c220c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-james-spe-impdef-decode-v1-3-ad0d372c220c@linaro.org>

On Wed, Apr 01, 2026 at 03:25:51PM +0100, James Clark wrote:

[...]

>  static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
> -				  char *buf, size_t buf_len)
> +				  char *buf, size_t buf_len, u64 midr)

Just wandering if we can add a "midr" field into struct arm_spe_pkt ?
Then we don't need to change many functions for populating midr.

The rest is good for me.

Thanks,
Leo
