Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB22166F0C;
	Wed, 13 Aug 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094826; cv=none; b=XDPpNoBtWwrWEf6yb0mRvK4Dh3i+XmNMUmkJI0//Q6g3UaS42rzbmAlpGZe/JUQ4YaMPnNcu63H23MoGzD2RexDjz+4C0Mt8EKkSMyEU3sZoLfL+rIibg1GqrKqGSVBKfFeHiiPjN3UXxPUunL4zqh0ln6sfBDUpc7AqJ/p7oD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094826; c=relaxed/simple;
	bh=1eySh4amzb877mIfH53pBOKu+cOMratB5ve04n0tQ5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph+e5e5zyklIINZYOpx76ng+np4f1Qdr2G36nGwUAD1CDYhTpgv54hauKMh8ye0aH7PMIr2CJ2ndrp2DPG156IFgKYQTtKFAx/yjCtY+Egz97Yfv0m56Fyn5U7qAOL/ecOvC5e75+fYePINWTPfBUi69bq0Q1eGOI5ip6Wf62WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72F5E12FC;
	Wed, 13 Aug 2025 07:20:15 -0700 (PDT)
Received: from [10.163.64.253] (unknown [10.163.64.253])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 772853F5A1;
	Wed, 13 Aug 2025 07:20:19 -0700 (PDT)
Message-ID: <c485ed00-e799-490d-ad72-aa8409db02ff@arm.com>
Date: Wed, 13 Aug 2025 19:50:16 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf branch: Fix heap out-of-bounds write in
 branch_type_count()
To: Yujun Dong <yujundong@pascal-lab.net>, linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20250809093812.308027-1-yujundong@pascal-lab.net>
 <17bdc644-329a-42fb-aba2-d7f80f2a1037@arm.com>
 <1f73657c-74b3-44a7-bee4-b7cda1a75a02@pascal-lab.net>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <1f73657c-74b3-44a7-bee4-b7cda1a75a02@pascal-lab.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/08/25 1:01 PM, Yujun Dong wrote:
> On 2025/8/11 15:03, Anshuman Khandual wrote:
>> On 09/08/25 3:08 PM, Yujun Dong wrote:
>> > The branch_type_count() function writes to st->new_counts[flags->new_type]
>> > when flags->type is PERF_BR_EXTEND_ABI. However, while the array
>> > st->new_counts is sized for PERF_BR_NEW_MAX (8) entries, the field
>> > flags->new_type is a 4-bit unsigned value and may hold values up to 15.
>> >
>> > This mismatch allows crafted perf data to trigger a heap out-of-bounds
>> > write when flags->new_type >= 8, leading to memory corruption.
>>
>> Crafted ? How could flags->new_type >= 8 when PERF_BR_NEW_MAX is capped at 8.
>> Is this a real scenario that happened on a system ?
>>
> 
> Thanks for your review and for raising that question. The new_type field
> in struct branch_flags is declared as a 4-bit bitfield (u64 new_type:4),
> meaning it can hold values from 0 to 15, even though PERF_BR_NEW_MAX is
> defined as 8. So, it's entirely possible for flags->new_type to be >= 8.

Sure it is possible but not probable I guess as new_type itself would be
first guarded by PERF_BR_NEW_MAX.

> 
> In fact, I've observed such cases when running real-world perf record/top,
> where perf.data produced contains invalid new_type values, likely due to
> other bugs or unexpected data corruption. Additionally, a maliciously
> crafted perf.data file can also force this out-of-bounds write.

Agreed. 

> 
>> >
>> > Add a bounds check to ensure flags->new_type is less than
>> > PERF_BR_NEW_MAX before accessing the new_counts array.
>>
>> But it might make sense to add this check just to be on the safer side.
>>
> 
> Notably, new_type is only used in two places:
> 1. In branch_new_type_name(), where the bounds are already validated.
> 2. In branch_type_count(), where the current patch now adds the
> necessary check.

Agreed - this change will ensure consistency across both the functions.

> 
> Admittedly, the mismatch between the bit-field width (0-15) and
> PERF_BR_NEW_MAX (8) is the root cause. While adjusting the bit-field
> to match PERF_BR_NEW_MAX would also resolve the mismatch, that risks
> breaking existing compatibility. Therefore, adding a bounds check at
> the use site is the least disruptive correction.

Right, increasing PERF_BR_NEW_MAX to 15 will not be desirable.

> 
>> >
>> > Fixes: 0ddea8e2a0c2 ("perf branch: Extend branch type classification")
>> > Signed-off-by: Yujun Dong <yujundong@pascal-lab.net>
>> > ---
>> >  tools/perf/util/branch.c | 8 +++++---
>> >  1 file changed, 5 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
>> > index 3712be067464..8ea6628c7735 100644
>> > --- a/tools/perf/util/branch.c
>> > +++ b/tools/perf/util/branch.c
>> > @@ -21,10 +21,12 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
>> >      if (flags->type == PERF_BR_UNKNOWN || from == 0)
>> >          return;
>> >
>> > -    if (flags->type == PERF_BR_EXTEND_ABI)
>> > -        st->new_counts[flags->new_type]++;
>> > -    else
>> > +    if (flags->type == PERF_BR_EXTEND_ABI) {
>> > +        if (flags->new_type < PERF_BR_NEW_MAX)
>> > +            st->new_counts[flags->new_type]++;
>> > +    } else {
>> >          st->counts[flags->type]++;
>> > +    }
>> >
>> >      if (flags->type == PERF_BR_COND) {
>> >          if (to > from)
>> >Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
