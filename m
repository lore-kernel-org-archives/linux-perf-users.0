Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569264C84;
	Thu, 25 Jul 2024 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890409; cv=none; b=kgel9a8Rpnls7frvB0STI71h3766UhWVh7c5F/tbFIIEr6cSlOhn2SmJ2wfJKQ2g3KDUZHLQ0ffakckMC+gr7AcWFwntAsTG/P2MxyOSKKXFZBNpOrXaLoMfoDTZ3YNDaFS+FEPNnNRS2MukOce1DkMzi0KChbanF3eTpptRw4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890409; c=relaxed/simple;
	bh=Lj4tggI/fJ/+sEj6cckWS7AfLrD0rYXwnbdkO/iILD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Snw9WhKMfgyBmLlqi8uoYCcr/szHZe1Wo0uHvfClQ3epCjQIu4TpjXO7KOTAOSzLz8U7riLAaD+fC2J43gC7ioTBMWHxg4ybRDKW7KndoGFyROtHF1JPi4rIqBLZKRfViKEyFjGVMP8gele7jeC0FVae147dVM4dyRBf+NDXURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21AB01007;
	Wed, 24 Jul 2024 23:53:52 -0700 (PDT)
Received: from [10.1.33.12] (PF4Q20KV.arm.com [10.1.33.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF16C3F5A1;
	Wed, 24 Jul 2024 23:53:24 -0700 (PDT)
Message-ID: <77dd91c9-e545-4a6e-bf94-045418606f75@arm.com>
Date: Thu, 25 Jul 2024 07:53:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] perf: build: Fix cross compilation
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, James Clark
 <james.clark@linaro.org>, amadio@gentoo.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240717082211.524826-1-leo.yan@arm.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240717082211.524826-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Arnaldo, Namhyung,

On 7/17/2024 9:22 AM, Leo Yan wrote:
> This patch series fixes cross compilation issues.

If this series is fine for you, would you mind to pick up this series?

Thanks!

Leo
