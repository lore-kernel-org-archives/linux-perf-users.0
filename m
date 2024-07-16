Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8321DFF0;
	Tue, 16 Jul 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148268; cv=none; b=BT9454sUdHYrrhWR+bGsIwmsQRMncbjeHNOYC/gSIjVUOB4nrDv7v5jeQhN/EnIDxAJpXjvLfKaDN65t+qH9as1Q/pt0oPht5Jr5k4DNS9OulN/kt2mcXHaEF2zzfKqYzCVeVVJsx4bC+eG7UG0DcwR7QLOjiBk1R3c8jMUQwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148268; c=relaxed/simple;
	bh=f9k0S0giKiap554iUbPwdedMhkbrcKiT5a0iH0kTZjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FFYlkbbxHZHC4TkeT6mnXDZ/e4G64TW5qqmBN3kIxz9bV+5J96rAsa6wjB9wWuRye9icBNLckwqj0ikHf5xEYh/BhR5+/kL6o02C5IJn632kv6rhgRD3efRywyqxmiHvBWPxC22dc585Lo8G6DcpQ5o1u9a4ghrD7JPtlPIfUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 932FB1063;
	Tue, 16 Jul 2024 09:44:50 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFCBE3F766;
	Tue, 16 Jul 2024 09:44:21 -0700 (PDT)
Message-ID: <13f2fd44-09bc-4aa7-a797-0b5735e76406@arm.com>
Date: Tue, 16 Jul 2024 17:44:19 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/27] perf auxtrace: Remove dummy tools
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Nick Terrell <terrelln@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240712181108.475336-1-irogers@google.com>
 <20240712181108.475336-2-irogers@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240712181108.475336-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/12/24 19:10, Ian Rogers wrote:
> Add perf_session__deliver_synth_attr_event that synthesizes a
> perf_record_header_attr event with one id. Remove use of
> perf_event__synthesize_attr that necessitates the use of the dummy
> tool in order to pass the session.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

This patch LGTM, and tested for Arm SPE:

Tested-by: Leo Yan <leo.yan@arm.com>

But the patches 04 and 15 cannot be applied on the top of
tmp.perf-tools-next branch. You might need to rebase the series.

Thanks,
Leo
