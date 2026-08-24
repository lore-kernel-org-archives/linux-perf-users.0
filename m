Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9813932D0;
	Mon, 24 Aug 2026 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608127; cv=none; b=nHLD1tbMYCernTPtboJEJN9gLsWWJkqrwRkHo/3H3F05OIX8E5axFgB1omwXXH5HygitGld8Kz/fJjW44ft4cJxCTCmu9hqbu7n8VFPtqdWapzvN707yBAQypB0G4ZI484E3o8g/wjsboXhMnFgXlwWgSg/KWDVX9bnPahc8JZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608127; c=relaxed/simple;
	bh=6/pekqSCPc9aBqiZFJGkzLnWvMZpkA9dp/ziWygfQjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSqgxtLMLDiRG8o/IKWiiM0d7aNRmti9QaOzdyc8qAP8seHJUDpV2J5RODYcDyIUVsWBKdaJN9RdRnkFhi9yRHagveIfOz5Y8uDXZY82yrfr7OtUE1jW0aQYV/BtaPU+EPorKtQgHr0zdEGtA78UhS55HpbJJ3AIzbeGqOV3k54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQBarLQs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQBarLQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51CC1F000E9;
	Mon, 24 Aug 2026 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608125;
	bh=uRawa5RLwJRROp0EcURzr1QD6Ax7kIajePCnoCiQjZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NQBarLQsOT09yMjr2BuQTqnoJNQKEfLmz6k7IWgLMM/AxixqgP5Ud4EaWjrfdLSo5
	 V3UeRENfw0tKoGdx7mj9Ky4vqMNP+NX6pY+JBnGwfRhrcGYGe6a5RaxEE/Prxsyp6t
	 hkNOYSUix56Cu7OGhZSkOuZsM5aqyyzYe3iB3Tkdak/hX0Xh9x/IwGU0M46IU9NUtW
	 mXAu1jSRGj5Lx85PGnVuB9mtF3EZIQwuCIBMj1wBFKhbVu+WIGIGKakzl1W6zJu5Sq
	 xPJXpEK9n7JwB3wAot9dt1d+ltvkCRsnSVa0UsNguss8Bjxm/x/j89iyKm/cD/iSVA
	 LxHTYZc9KkiWw==
Date: Mon, 24 Aug 2026 14:48:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, james.clark@linaro.org,
	Li Huafei <lihuafei1@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 16/23] perf annotate-data: Expand type_state_reg
 imm_value to u64
Message-ID: <aoy8OwogQGsGR0_j@google.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-17-wutengda@huaweicloud.com>
 <861296f2-a17e-483a-8b46-74ba777958d5@linux.alibaba.com>
 <793c2b7c-dac8-4565-9d4a-5be7e9ebea3c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <793c2b7c-dac8-4565-9d4a-5be7e9ebea3c@huaweicloud.com>

On Fri, Aug 14, 2026 at 03:58:12PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/8/11 16:10, Shuai Xue wrote:
> > 
> > 
> > On 8/8/26 8:23 PM, Tengda Wu wrote:
> >> The imm_value in struct type_state_reg is defined as u32, which limits
> >> the size of values it can pass.
> >>
> >> Promote imm_value from u32 to u64 and adjust the print format specifier
> >> in pr_debug_dtp() accordingly.
> >>
> >> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >> ---
> >>   tools/perf/util/annotate-arch/annotate-x86.c | 2 +-
> >>   tools/perf/util/annotate-data.h              | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
> >> index ee4e3e7f3209..eec3d8ce00b8 100644
> >> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> >> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> >> @@ -540,7 +540,7 @@ static void update_insn_state_x86(struct type_state *state,
> >>               tsr->offset = 0;
> >>               tsr->ok = true;
> >>   -            pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
> >> +            pr_debug_dtp("mov [%x] imm=%#"PRIx64" -> reg%d\n",
> >>                        insn_offset, tsr->imm_value, dst->reg1);
> >>               return;
> >>           }
> >> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> >> index 453e13bbe3e2..91b83e94c51b 100644
> >> --- a/tools/perf/util/annotate-data.h
> >> +++ b/tools/perf/util/annotate-data.h
> >> @@ -173,7 +173,7 @@ extern struct annotated_data_stat ann_data_stat;
> >>    */
> >>   struct type_state_reg {
> >>       Dwarf_Die type;
> >> -    u32 imm_value;
> >> +    u64 imm_value;
> >>       /*
> > One subtlety this introduces: annotated_op_loc.offset is an int, and
> > immediates are parsed into it via strtol(), so assignments like
> > tsr->imm_value = src->offset now sign-extend instead of preserving
> > the 32-bit bit pattern. mov $0xdeadbeef used to track 0xdeadbeef,
> > now it tracks 0xffffffffdeadbeef, while the register actually holds
> > the zero-extended value. (Canonical kernel addresses happen to
> > sign-extend back to the right value, which masks this in the common
> > case.)
> > 
> 
> It appears that assignments from offset to imm_value occur in only a few places:
> 
> add/sub: (already existing)
>   u64 imm_value = -1ULL;
>   imm_value = src->offset;  // int to u64
> 
> mov immediate: (newly introduced)
>   tsr->imm_value = src->offset;  // int to u64
> 
> 
> > Relatedly, this widening doesn't actually help 64-bit immediates on
> > the strtol() path - movabs is still truncated to int at parse time.
> 
> Indeed, for movabs instructions, the immediate value is truncated due to
> the width of offset and strtol() as well.
> 
> > The real consumers that need u64 are the arm64 adrp and stack paths,
> > which feed imm_value from ops.source.addr / stack state directly, so
> > the change is justified. But maybe worth spelling that out, and
> > considering a follow-up that parses immediates with strtoull() into a
> > dedicated u64 field instead of overloading the signed offset field.
> > 
> > Thanks,
> 
> To summarize, there are three issues:
> 
> 1. Sign-extension issue in add/sub (pre-existing)
> 2. Sign-extension issue in mov immediate (newly introduced)
> 3. Truncation issue in movabs (pre-existing)
> 
> In this patch, I'd like to fix issue #2 first by adding a type cast to
> avoid the sign-extension problem:
> 
>   tsr->imm_value = (s64)src->offset;
> 
> As for issues #1 and #3, which are pre-existing, a possible solution would
> be to promote offset to 64-bit as well. I'm thinking of addressing those in
> a separate patch series, since it involves multiple architectures and would
> need careful review.

Sounds good.

Thanks,
Namhyung

