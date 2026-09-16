Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CCF4F55C5;
	Wed, 16 Sep 2026 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566986; cv=none; b=OMNkSRaR7qhn2aS46+gbiiULAnDwjiy/2TfM6GvoYAb+TIK5v74aVk8GMPMAQIGg4MBh24+ybol3xVwpkN/9JNbFA7mBZKZkr+O0hDHMm0HzTPKg7S1i0L/3ff/je4F8RtgFXXut/9eO3XydtAnbURdtcBMosuVZjVMt8L4T2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566986; c=relaxed/simple;
	bh=3QubtO6CSUa8SO9CyTAzsKkl1hptedq9FZW9RTKlVGY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=meWhu7lI9tBrMhnfMHenxXDUQm+N5kRfdNSWYa0Yn6mYfC4VBOod2pAJKwEJ3KJito2EjnRRFWudMg+ZjNnHWMKZaj/N1nUFShsr89ry4NsWjbi/hPuMKK755O+sugK/oOWgZIA5GU39nMlgng2N5GbLW1Bm8YojeFsIE6P8WeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrKwrOTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrKwrOTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30161F000FF;
	Wed, 16 Sep 2026 13:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566978;
	bh=uGEbqpe/3+fV/WQLOw7mKLByOr4dCUPRxLVznKQgTIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MrKwrOTjrp37s7IvIX+uYruIafB+syY1oDfxb6L58NuX912bqAjIZamAxzHktfZHb
	 gsZo0DCiSGJCs3KJ5rTS4Fybh9/6lx9XqsapY15p7pEIExrr8HAIjWT3J0WMiRHwYB
	 YKVTiHKnbc/4BEWi5UVwMdIEua6NEwufAGGgFo6r/1LJhXCv8yI6A4A1gDtf/CR+5P
	 QUAYKiAeMMErSxuOe6L7/YWINaO8cyTVVqVU1COp4AWmu8BK6xj8rbruqJ8sDSXclq
	 kDY2NfoLhxpVWvlY+MdOp+sTAcLEmDGd9c+cKMvuQHm+EQoVuV+FIHNXadarS1JVvg
	 mrvQlGjEZkwdQ==
Date: Wed, 16 Sep 2026 22:56:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Zecheng
 Li <zli94@ncsu.edu>, Yanbo Zhao <yzhao62@ncsu.edu>, Tengda Wu
 <wutengda@huaweicloud.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 2/4] perf dwarf-aux: Add die_has_flex_array() helper
Message-Id: <20260916225613.f70bbbf7f627c593cb0beb2d@kernel.org>
In-Reply-To: <aqjdixZz4RYQZgCJ@google.com>
References: <20260914064535.1671939-1-namhyung@kernel.org>
	<20260914064535.1671939-3-namhyung@kernel.org>
	<20260915084048.5779ad90647c116806822df5@kernel.org>
	<aqjdixZz4RYQZgCJ@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 22:54:19 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> > > +
> > > +	do {
> > > +		if (dwarf_tag(&die_mem) != DW_TAG_member)
> > > +			continue;
> > 
> > If the member is a "const" member, you may have to use
> > die_get_real_type() to get the actual type.
> > (in this case, you need a cursor DIE for dwarf_siblingof()) 
> 
> Doesn't it belong to a type of the member?  In my simple test program,
> it shows the struct type only has children of members and their types
> including const are referenced from the member DIEs.
> 
> Also I don't think flexible arrays will be const as they cannot be
> initialized.

Ah, indeed. flex array needs to be initialized. :)

> 
> > 
> > > +
> > > +		if (tag == DW_TAG_union_type) {
> > > +			if (is_flex_array_member(&die_mem))
> > > +				return true;
> > > +
> > > +			if (die_get_real_type(&die_mem, &last_mb) &&
> > > +			    die_has_flex_array_recurse(&last_mb, depth + 1))
> > > +				return true;
> > > +		}
> > > +
> > > +		if (tag == DW_TAG_structure_type)
> > > +			memcpy(&last_mb, &die_mem, sizeof(last_mb));
> > 
> > To find the last member, I think you'd better check the
> > DW_AT_data_member_location and DW_AT_decl_line to ensure the
> > DIE is the last member.
> 
> Good point.  I can add the member location check.  I'm afraid decl line
> may be incorrect if compiler randomized the layout.
> 
> So far I haven't seen DWARF data having unsorted members (by location),
> but it'd be better to make sure it's sorted.

OK, that maybe enough.

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
