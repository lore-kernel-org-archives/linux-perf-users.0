Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675F3130499;
	Wed, 18 Dec 2024 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492748; cv=none; b=Y1ZcaVSDC+RtJWAZvGdfxS6DUqfb9eX5UQwNQwvLM9CEXay486CH/HRgbbSOjCezbjTfihmYFWObQNM4EryXr47HdJFV5pAHFiOzr84CX+HOlNZpeVDVi11RGnGAasp1E8bLJksibmrOow30ZSOQhdqlBTD+c0G4kaYP+ZP/PyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492748; c=relaxed/simple;
	bh=uumEaZyAbr6IJbruAfxA4UfFnKV6vGc0NgYTG1KBZdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOsi4KW3UAz9TKpR1KrzWzFu4Ti9S/K6tPOGZxrJTbLQCn/re+6ovWUc8o1TLPU6vCKUMbIvIr0f+VoLWewfOcjIzfNYyXf2eZFg99t9HSxFTMwuokEzrKTatcCU3+aha/HjV+NJf/N1TZPLmTF22Rk+nRPymmTA/b5Wx34mUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB82497;
	Tue, 17 Dec 2024 19:32:52 -0800 (PST)
Received: from [10.163.50.13] (unknown [10.163.50.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 370903F7B4;
	Tue, 17 Dec 2024 19:32:18 -0800 (PST)
Message-ID: <42b0860d-c30e-493f-a8ff-a11738a6c17f@arm.com>
Date: Wed, 18 Dec 2024 09:02:16 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: test: Speed up running brstack test
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241213231312.2640687-2-robh@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241213231312.2640687-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/14/24 04:43, Rob Herring (Arm) wrote:
> From: James Clark <james.clark@arm.com>
> 
> The brstack test runs quite slowly in software models. Part of the reason
> is "xargs -n1" is quite inefficient in replacing spaces with newlines.
> While that's not noticeable on normal machines, it is on software models.
> Use "tr -s ' ' '\n'" instead which can do the same transformation, but is
> much faster. For comparison on an M1 Macbook Pro:
> 
> $ time seq -s ' ' 10000 | xargs -n1 > /dev/null
> 
> real    0m2.729s
> user    0m2.009s
> sys     0m0.914s
> $ time seq -s ' ' 10000 | tr -s ' ' '\n' | grep '.' > /dev/null
> 
> real    0m0.002s
> user    0m0.001s
> sys     0m0.001s
> 
> The "grep '.'" is also needed to remove any remaining blank lines.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> [robh: Drop changing loop iterations on arm64. Squash blank line fix and redo commit msg]
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> Originally part of this series[1], but I've dropped any Arm specifics, 
> and it stands on its own. No reason this needs to wait on Arm BRBE 
> support (which I'm working on now). I don't expect to have other changes 
> to this test related to BRBE anymore.
> 
> [1] https://lore.kernel.org/all/20240613061731.3109448-8-anshuman.khandual@arm.com/
> 
>  tools/perf/tests/shell/test_brstack.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index 5f14d0cb013f..e01df7581393 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -30,7 +30,7 @@ test_user_branches() {
>  	echo "Testing user branch stack sampling"
>  
>  	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
> +	perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' '\n' > $TMPDIR/perf.script
>  
>  	# example of branch entries:
>  	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> @@ -59,7 +59,7 @@ test_filter() {
>  	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
>  
>  	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
> +	perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' | grep '.' > $TMPDIR/perf.script
>  
>  	# fail if we find any branch type that doesn't match any of the expected ones
>  	# also consider UNKNOWN branch types (-)
