Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A9113BC2F;
	Tue, 25 Jun 2024 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339385; cv=none; b=CRFVQrEnB09jc54FWqYr/LuoJhjxwTUvNjFijypyWfiE/jzi/fOUZVm51y/WDqmHO4n/H6cQgqWqSDZgr2kJHXOJDBv/a18HyGlHSdaLaHGLQUUldzGjxUNYYR2pY6XUWWA2Ib4VAL5v8udoiRA3ZexSr+EMPODk0U7a5cp6qf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339385; c=relaxed/simple;
	bh=4dUKPV6O9+l6tOPY2DwuzbaLzm/NSLR6/1ExTYxNWck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxGSAUkiq92+X0lPiRGa2F2inK6T5dtgCsSG0jAsFViugX0NAG8ltHCpF/PuTc7aJeEjLOal6/ywqLNZg9rWUi7A+rYfMcEjtOyeBH4V8ccDXe+2n2nPMEfW7PxWlTpCcMwz26Pi9K2hRqMOd0ecyT7yiuqEY6t/fLh60yCB3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40A51339;
	Tue, 25 Jun 2024 11:16:47 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA31B3F73B;
	Tue, 25 Jun 2024 11:16:19 -0700 (PDT)
Message-ID: <763864f4-e370-4e0d-a4ee-cbff41ad5c08@arm.com>
Date: Tue, 25 Jun 2024 19:16:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] perf docs: Document cross compilation
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>,
 Changbin Du <changbin.du@huawei.com>, Fangrui Song <maskray@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Guilherme Amadio <amadio@gentoo.org>
References: <20240610095433.336295-1-leo.yan@arm.com>
 <20240610095433.336295-7-leo.yan@arm.com>
 <CAP-5=fVqJWGWbrddyqAhUp6afG3AX61ekNr3Mpe6u=wYaeeCcg@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAP-5=fVqJWGWbrddyqAhUp6afG3AX61ekNr3Mpe6u=wYaeeCcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/10/24 19:43, Ian Rogers wrote:
> 
>     Records the commands for cross compilation with two methods.
> 
>     The first method relies on Multiarch. The second approach is to
>     explicitly
>     specify the PKG_CONFIG variables, which is widely used in build system
>     (like Buildroot, Yocto, etc).
> 
> 
> There is also:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Documentation/android.txt?h=perf-tools-next
> it looks very crufty, not least as it is referring to 32-bit builds
> 
> Could this be refreshed or deleted?

Yeah, the doc is quite old.

Actually, this patch series is to support static building, I assume a 
main usage case is to use the static building binary for Android.

I will give a try for building perf with Android NDK. I will base on my 
test result to update the file android.txt or remove it.

Thanks
Leo
