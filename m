Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A3A143738;
	Thu, 16 May 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849756; cv=none; b=GheFbpxvq/KsQHH3buA7Rvy/Ofh+IvZj8qIARHx6SWmQTFqD0gxBiu8hnFKyH5dy/Ggj1VH4u0ZE8zCAWlCbgTPz/XFwntnvSiNEOTlLpDtCC594JuHxbJpuvdKAFZlLbENlGSuU99Gke3GePQeAHY4I1gTrVkX7IzfzLgDJ2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849756; c=relaxed/simple;
	bh=yjsbqCiWki3Ghwx9X9Ee4DgPf+NUK2fSlGhg28sW7oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1eaiZ2AWt9gGCnZy+s7SqGs5oIJgVQyHFKdKws63SNdlGNY/hXVWPqYrOVavi/F1s5MuOQG/JrGEhPFy47YdJW26wMHspmZ7p6PqlZnzpGBVyodPXTAjxz3eVmCWECRCLCy0lKaKWmiVPr5eXclz4olWo8XJndh87zPUJ//xuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 961BBDA7;
	Thu, 16 May 2024 01:56:18 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8CC73F7A6;
	Thu, 16 May 2024 01:55:52 -0700 (PDT)
Message-ID: <55f6701e-9a37-4cce-b063-af6e1776245e@foss.arm.com>
Date: Thu, 16 May 2024 09:55:51 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] perf maps: Improve the kcore maps merging
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240515211045.377080-1-leo.yan@arm.com>
 <CAP-5=fVh-i5cCdW9MJ5AeN2k5Os2W6fifSCMi3gi6qMt_cdDPw@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <niayan01@foss.arm.com>
In-Reply-To: <CAP-5=fVh-i5cCdW9MJ5AeN2k5Os2W6fifSCMi3gi6qMt_cdDPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ian,

On 5/15/24 22:39, Ian Rogers wrote:

[...]

> Thanks Leo, testing this change on perf-tools-next with an x86 debian
> laptop I see:
> ```
> $ perf test 24 -v
> 24: Object code reading:
> --- start ---
> test child forked, pid 3407499
> Looking at the vmlinux_path (8 entries long)
> symsrc__init: build id mismatch for vmlinux.
> symsrc__init: cannot get elf header.
> overlapping maps in [kernel.kallsyms] (disable tui for more info)
> Using /proc/kcore for kernel data
> Using /proc/kallsyms for symbols
> Parsing event 'cycles'
> Using CPUID GenuineIntel-6-8D-1
> mmap size 528384B
> Reading object code for memory address: 0xfffffffface8d64a
> File is: /proc/kcore
> On file address is: 0xfffffffface8d64a
> dso__data_read_offset failed
> ---- end(-1) ----
> 24: Object code reading                                             : FAILED!
> ```
> The test passes without the changes. Let me know if you need me to dig deeper.

I can reproduce this test failure at my side. I will look into it.

Thanks for testing!

Leo
