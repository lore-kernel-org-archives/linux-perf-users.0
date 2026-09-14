Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B137B023;
	Mon, 14 Sep 2026 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429255; cv=none; b=T2RNk3NSSCCJbF4aunoKJDhp72fOITwO8IKmY67ovrhFDyE0YNgFbJtH47z3RHs6qlCBMZh/uNA4hzf/U7psB+YK44px+OqZxMQKybwjMsnWtjMxkaFD9bDbeoNX6SQFBmt1jn5svCToEGyyiyDhYVZaGSOBCqTdPTtL5mvAK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429255; c=relaxed/simple;
	bh=7Mzqi6Dmzx/3/4S+rwfwIrCui/T9Q8lNTXPNMtNBjTg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kJ0LGRwRKFQrklR50Mj/Qek2fzB3kBucSBXQw87hRl5gA6Bu1ZDkCW8jhIeT4iRLijc1niAQJgmEBNHfSBUrhCQvQIxCrcQHy9VQ5RXSDUDm23kc9uRcqW/cZ6mkjWeMonkwPGRvyhh1JLg1rwb9Ot1r/yn1ll7IQUyKm4Fwr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXlFhEPS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXlFhEPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6A11F000FF;
	Mon, 14 Sep 2026 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429254;
	bh=aw46U3wJ2ufDjF1KO179Fs2BK2L18v6SBaLKoViV+pg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LXlFhEPSSbm/FPsh6NAj8AqboK1ucsn4kKerDxHCXgh+oJ1yEDJ3aVqZxig80aTli
	 V05P/QsM3HiO/B0WndwXx1jDZ06VhUVqiCTLPGNVvfwluu1CddDNBDRGdQQx9Tuzk5
	 5zk63uzA57s4x0oeo+wDuHMmlF1v5BVglEmh6AzVqsk3W8E+xYeIv09nUzzbzs6XeE
	 RLDAroX9JrRxRRHiRjHUu4N6vLse4x89sq7Fy7W2PqJOzdAWBKTgOARkfnlU3qYhfN
	 HQOmZ9bxVCX+OzGVxeutcngOISlHStaZ479IuUwWtXkgqKExsMESN8dRm1kb20k5sk
	 nMpCFGEhxwPTQ==
Date: Tue, 15 Sep 2026 08:40:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Zecheng
 Li <zli94@ncsu.edu>, Yanbo Zhao <yzhao62@ncsu.edu>, Tengda Wu
 <wutengda@huaweicloud.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Masami
 Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 2/4] perf dwarf-aux: Add die_has_flex_array() helper
Message-Id: <20260915084048.5779ad90647c116806822df5@kernel.org>
In-Reply-To: <20260914064535.1671939-3-namhyung@kernel.org>
References: <20260914064535.1671939-1-namhyung@kernel.org>
	<20260914064535.1671939-3-namhyung@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 23:45:33 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> The die_has_flex_array() returns true when the given type is a compound
> type and contains an array at the end.  To prevent an infinite recursion
> add a depth field to the internal function.

Hi, thanks for this nice extension!
BTW, I have a comment on this implementation.

> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 77 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/dwarf-aux.h |  3 ++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index d7160f87ac7d7ab3..465824e6513eb0ac 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -2180,3 +2180,80 @@ Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
>  
>  	return die_get_member_type(&type_die, offset, die_mem);
>  }
> +
> +static bool is_flex_array_member(Dwarf_Die *mb_die)
> +{
> +	Dwarf_Die type_die;
> +	Dwarf_Word size;
> +
> +	/* get the type of the member */
> +	if (die_get_real_type(mb_die, &type_die) == NULL)
> +		return false;
> +
> +	if (dwarf_tag(&type_die) != DW_TAG_array_type)
> +		return false;
> +
> +	return dwarf_aggregate_size(&type_die, &size) < 0 || size == 0;
> +}
> +
> +#define MAX_FLEX_ARRAY_RECURSION  256  /* arbitrary */
> +
> +static bool die_has_flex_array_recurse(Dwarf_Die *parent_die, int depth)
> +{
> +	Dwarf_Die die_mem, last_mb;
> +	int tag = dwarf_tag(parent_die);
> +
> +	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type)
> +		return false;

What happen if the parent_die is "typedef struct {..." ?
I think you need to use die_get_real_type() here. ;)

> +
> +	/* prevent infinite recursion */
> +	if (depth > MAX_FLEX_ARRAY_RECURSION)
> +		return false;
> +
> +	if (dwarf_child(parent_die, &die_mem))
> +		return false;
> +
> +	do {
> +		if (dwarf_tag(&die_mem) != DW_TAG_member)
> +			continue;

If the member is a "const" member, you may have to use
die_get_real_type() to get the actual type.
(in this case, you need a cursor DIE for dwarf_siblingof()) 

> +
> +		if (tag == DW_TAG_union_type) {
> +			if (is_flex_array_member(&die_mem))
> +				return true;
> +
> +			if (die_get_real_type(&die_mem, &last_mb) &&
> +			    die_has_flex_array_recurse(&last_mb, depth + 1))
> +				return true;
> +		}
> +
> +		if (tag == DW_TAG_structure_type)
> +			memcpy(&last_mb, &die_mem, sizeof(last_mb));

To find the last member, I think you'd better check the
DW_AT_data_member_location and DW_AT_decl_line to ensure the
DIE is the last member.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
