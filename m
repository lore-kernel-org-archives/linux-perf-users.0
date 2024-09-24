Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510541760;
	Tue, 24 Sep 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207083; cv=none; b=Bfg+2p/8kFYGUV/gVexSi8qgdIO+jVf5VgnmpPqOKB6H9Pj77RrYHntIXVqO1kkGqrgHMygqx3sztiXX4SBqpcqdiyCWcFo67oebWiCm3YkjaU9NHlz7xKtT2Q2t0pUDl6BMDjkjy2Et6AHpjBIVC05AsOrr1eBsNi97kW8gCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207083; c=relaxed/simple;
	bh=80mpvVAA1XXCS6hk3NsNyxC4dU7NPoblV8wgQtE5jOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZbX65FbzgpmrrLvYO1qBgMfvEd4g9MnlkbiVg5aLZwJlRVp7z/ZTgRP7enp2TPkVCVP0hqCO6k+NygXqxKt7X+4kk/Q/TXKWpzBuG2JJHZ4XRZSxf7mSUpjRD+q1Gw5eEEheVTZvUYWM3RDJwo9w474daLDCGt4OBQ1SwDtMqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 500DBDA7;
	Tue, 24 Sep 2024 12:45:09 -0700 (PDT)
Received: from [10.57.22.151] (unknown [10.57.22.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA9E3F528;
	Tue, 24 Sep 2024 12:44:33 -0700 (PDT)
Message-ID: <522387f1-3fd3-4ff6-9bb7-eaa746be81af@arm.com>
Date: Tue, 24 Sep 2024 20:44:15 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] Libdw/dwarf build clean up
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Nick Terrell <terrelln@fb.com>, Guilherme Amadio <amadio@gentoo.org>,
 Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson"
 <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>,
 Anup Patel <anup@brainfault.org>,
 Shenlin Liang <liangshenlin@eswincomputing.com>,
 Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>,
 Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Yang Jihong <yangjihong@bytedance.com>
References: <20240924160418.1391100-1-irogers@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2024 5:04 PM, Ian Rogers wrote:

> The patches remove the conditional compilation assuming the
> features are in libdw where the feature test is expanded to check
> there pressence.
> 
> In the Makefile code dwarf tends to mean unwind or libdw support for
> dwarf things. To make it clearer when dwarf really just means libdw
> numerous build variables and defines are renamed.
> 
> There is some tech debt in the changes as perf check still reports the
> values using the old name and for features that are no longer tested.

I built for Arm64 target with static and dynamic linkage, both can build
successfully in Ubuntu 24.04 and Debian bookworm. FWIW:

Tested-by: Leo Yan <leo.yan@arm.com>
