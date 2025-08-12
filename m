Received: from out28-83.mail.aliyun.com (out28-83.mail.aliyun.com [115.124.28.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E181A9F99;
	Tue, 12 Aug 2025 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983930; cv=none; b=KYOB9rGqbM8kJUliGsmmXeRfgEab5Sb8CRt49U2HJzQa74qHlB5lY4M8XBHjpP9yQ7HNmIG0y/UNpXUheQgh6vrgFVY1keQP98FfyveTiPNT28BtVEHWyo/Gvov+/I3juh8zTtT/OXVKo+QNfNzrvwPFn3hAxnTGJGYQXBzWa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983930; c=relaxed/simple;
	bh=CCa9Ci3J5QHDFddhdCFeCywPPj7C95oJwqOE6D7d/3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmwKwV3ss5yI6zSZloEUyT4l/eUz6etXRGKMBXnccAHEI2WvEVDww+e3X+SZ9vCBhSnSkkaniy8Gt4jB8eDyyffQCU9XTB2Kn4M86hcjVMkKEoQQ2bunW7XELSZHIBjgvxk21Itwzp2Pk0l7bUFxsJhI3gS7tSaSs3CvlGd5OoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pascal-lab.net; spf=pass smtp.mailfrom=pascal-lab.net; dkim=pass (1024-bit key) header.d=pascal-lab.net header.i=@pascal-lab.net header.b=VQPG+mGb; arc=none smtp.client-ip=115.124.28.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pascal-lab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pascal-lab.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pascal-lab.net header.i=@pascal-lab.net header.b="VQPG+mGb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=pascal-lab.net; s=default;
	t=1754983916; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=j3T37CffnhSQE5FtkbQoa66mwv8d5798OrQGY72RZOw=;
	b=VQPG+mGbqnhsxNzwTXCEbSLMO8Y6Eh6SF7FNWqHaWXV/FR9nlT76lG/WYzIcEMxobJzFmtBaQLTbCUXVUTRiH6J8NR6m5DjyRC2X8JAW/Lqk9ipSFKa2WLwqzmrpZO7CEdKzv3Ihg11hAK7ms08BdBkZ0M4YCljt5rAOMijbb8A=
Received: from 192.168.0.105(mailfrom:yujundong@pascal-lab.net fp:SMTPD_---.eDV-wna_1754983914 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 12 Aug 2025 15:31:55 +0800
Message-ID: <1f73657c-74b3-44a7-bee4-b7cda1a75a02@pascal-lab.net>
Date: Tue, 12 Aug 2025 15:31:54 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf branch: Fix heap out-of-bounds write in
 branch_type_count()
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20250809093812.308027-1-yujundong@pascal-lab.net>
 <17bdc644-329a-42fb-aba2-d7f80f2a1037@arm.com>
Content-Language: en-US
From: Yujun Dong <yujundong@pascal-lab.net>
In-Reply-To: <17bdc644-329a-42fb-aba2-d7f80f2a1037@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/8/11 15:03, Anshuman Khandual wrote:
 > On 09/08/25 3:08 PM, Yujun Dong wrote:
 > > The branch_type_count() function writes to 
st->new_counts[flags->new_type]
 > > when flags->type is PERF_BR_EXTEND_ABI. However, while the array
 > > st->new_counts is sized for PERF_BR_NEW_MAX (8) entries, the field
 > > flags->new_type is a 4-bit unsigned value and may hold values up to 15.
 > >
 > > This mismatch allows crafted perf data to trigger a heap out-of-bounds
 > > write when flags->new_type >= 8, leading to memory corruption.
 >
 > Crafted ? How could flags->new_type >= 8 when PERF_BR_NEW_MAX is 
capped at 8.
 > Is this a real scenario that happened on a system ?
 >

Thanks for your review and for raising that question. The new_type field
in struct branch_flags is declared as a 4-bit bitfield (u64 new_type:4),
meaning it can hold values from 0 to 15, even though PERF_BR_NEW_MAX is
defined as 8. So, it's entirely possible for flags->new_type to be >= 8.

In fact, I've observed such cases when running real-world perf record/top,
where perf.data produced contains invalid new_type values, likely due to
other bugs or unexpected data corruption. Additionally, a maliciously
crafted perf.data file can also force this out-of-bounds write.

 > >
 > > Add a bounds check to ensure flags->new_type is less than
 > > PERF_BR_NEW_MAX before accessing the new_counts array.
 >
 > But it might make sense to add this check just to be on the safer side.
 >

Notably, new_type is only used in two places:
1. In branch_new_type_name(), where the bounds are already validated.
2. In branch_type_count(), where the current patch now adds the
necessary check.

Admittedly, the mismatch between the bit-field width (0-15) and
PERF_BR_NEW_MAX (8) is the root cause. While adjusting the bit-field
to match PERF_BR_NEW_MAX would also resolve the mismatch, that risks
breaking existing compatibility. Therefore, adding a bounds check at
the use site is the least disruptive correction.

 > >
 > > Fixes: 0ddea8e2a0c2 ("perf branch: Extend branch type classification")
 > > Signed-off-by: Yujun Dong <yujundong@pascal-lab.net>
 > > ---
 > >  tools/perf/util/branch.c | 8 +++++---
 > >  1 file changed, 5 insertions(+), 3 deletions(-)
 > >
 > > diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
 > > index 3712be067464..8ea6628c7735 100644
 > > --- a/tools/perf/util/branch.c
 > > +++ b/tools/perf/util/branch.c
 > > @@ -21,10 +21,12 @@ void branch_type_count(struct branch_type_stat 
*st, struct branch_flags *flags,
 > >      if (flags->type == PERF_BR_UNKNOWN || from == 0)
 > >          return;
 > >
 > > -    if (flags->type == PERF_BR_EXTEND_ABI)
 > > -        st->new_counts[flags->new_type]++;
 > > -    else
 > > +    if (flags->type == PERF_BR_EXTEND_ABI) {
 > > +        if (flags->new_type < PERF_BR_NEW_MAX)
 > > +            st->new_counts[flags->new_type]++;
 > > +    } else {
 > >          st->counts[flags->type]++;
 > > +    }
 > >
 > >      if (flags->type == PERF_BR_COND) {
 > >          if (to > from)
 >
