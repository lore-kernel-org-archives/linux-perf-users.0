Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340F17F385;
	Wed, 17 Jul 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245564; cv=none; b=FSRd9xgIqjPTAOOLaBYFWiToMWPFO2zzMaBD9SOULHqOnRUWOKUSfe3DsyzL4BscLgDD3oGM8Lh5g2v1cmYqI6AhZXM+QwbAdAp3ylNSucX4G/R0FhC30OOE+SFMLmI2NEoFS5joF13rvblV8LOxw6S+4r99tp0mhDpVHcBOPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245564; c=relaxed/simple;
	bh=DGnSee0F74oSXwowBRJDvg/XPZfLYyv9WTpDvPYV9gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv+hCO03p5CNNwG384rcizmnjVECVVzZ7WnTv9HvwDkw4ZIulF4RQNJIP3bBjYkmI6X/+b3ep3GUi4N8nVCBgwVnqf+cLzw2dc6BVkZQb1oGqeqjrvDZwhyGnHhVwRR35cdv3UYeOzRlOxaDFzWKcBkRGq5uxiu+w+EwtXDKzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2879C1063;
	Wed, 17 Jul 2024 12:46:26 -0700 (PDT)
Received: from [10.57.9.252] (unknown [10.57.9.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 566D13F73F;
	Wed, 17 Jul 2024 12:45:58 -0700 (PDT)
Message-ID: <0ae7232e-e75e-488e-b781-6c291aa284aa@arm.com>
Date: Wed, 17 Jul 2024 20:45:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf dso: Fix build when libunwind is enabled
To: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Leo Yan <leo.yan@linux.dev>,
 Yunseong Kim <yskelg@gmail.com>, linux-kernel@vger.kernel.org
References: <20240715094715.3914813-1-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240715094715.3914813-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/15/2024 10:47 AM, James Clark wrote:
> 
> Now that symsrc_filename is always accessed through an accessor, we also
> need a free() function for it to avoid the following compilation error:
> 
>   util/unwind-libunwind-local.c:416:12: error: lvalue required as unary
>     ‘&’ operand
>   416 |      zfree(&dso__symsrc_filename(dso));
> 
> Fixes: 1553419c3c10 ("perf dso: Fix address sanitizer build")
> Signed-off-by: James Clark <james.clark@linaro.org>

Tested-by: Leo Yan <leo.yan@arm.com>
