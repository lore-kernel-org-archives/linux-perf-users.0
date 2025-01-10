Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766E2066E0;
	Fri, 10 Jan 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532791; cv=none; b=d1WtxtnySRfUihOPzSWgI0vsEAbBzctiFFK2uL3NjxLSrdrZ31YT0NN4EkbAiwezDZLcIPkdGYRO8VIC0ZfpFAWTHdMNE2/8bbbsxmBvSET9EfEhaU7PS1OKdqcqkcYHNgpuPdLsLIuaeEovAnMp/J/0cBQsVgaNXkNqKWsp+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532791; c=relaxed/simple;
	bh=ShK00Ofv38WK6WN84JkRnU0D2y5QC3C8qfWO4KPdaxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3nNnTaxAHlzay7hzd9JguZUFLuTFM5zOmjmMcubUqukh1e9RAPXrs9MgDq6rLJqFc4gKqMOnexu5/ps18a+CavwH52i9xR4hFj6Aannqv7MdIY7Tnv0mqRqSp5s7HZl1//yOj0j9etPIk/3mnpa8K3t90HgDzFMG7fbVj2Ll2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMS9n7XH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMS9n7XH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72A8C4CEE0;
	Fri, 10 Jan 2025 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736532790;
	bh=ShK00Ofv38WK6WN84JkRnU0D2y5QC3C8qfWO4KPdaxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMS9n7XH4yLYmIiVbO4iL0Fx1SHo6XACDUkJjq4Fz3osKWK33gxCR9TWilXI2yRqv
	 cbfwwfwLCvmdwuFZjqCPsZXJXX9Sfr5hPr+lVnEJbGba206f1XiWKeIgIKBmyCkRj9
	 F+ytvFAsEePwIEfZhDJHTyULmwXCjVKJnU7g/+2lf+Fcda7iAbiHsX904HDedcJzRH
	 UQ4gkQwiHVrZpmOtUV61ZknK/hcjlsmt1LvHpnKtFpzhVRWk5ilE9wOTj1uM+qMTw+
	 8WInSQvAxo6R0kY7Efig4XD6koEUY9k/ZUu6VrERQ+DI94IQz+h8mvmuMrwu0F1W0x
	 FKe3TZWEU1Tlg==
Date: Fri, 10 Jan 2025 15:13:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf ftrace: Check min/max latency only with bucket
 range
Message-ID: <Z4FjMwlU6F2RSO4c@x1>
References: <20250108210015.1188531-1-namhyung@kernel.org>
 <a016ab208eb3ee3821ab59a2520a2bf56645917e.camel@redhat.com>
 <Z4Bt8aIkX5uErX8a@google.com>
 <0ef32d5e-594a-43a4-ae5c-e8ad05a2d320@redhat.com>
 <Z4EonTmShlWn3n0X@x1>
 <2ce46fa93b5c33491797e97c6995759b4ed31da4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ce46fa93b5c33491797e97c6995759b4ed31da4.camel@redhat.com>

On Fri, Jan 10, 2025 at 04:11:05PM +0100, Gabriele Monaco wrote:
> 
> On Fri, 2025-01-10 at 11:03 -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jan 10, 2025 at 10:09:14AM +0000, Gabriele Monaco wrote:
> > > 2025-01-10T00:46:49Z Namhyung Kim <namhyung@kernel.org>:
> > > 
> > > > On Thu, Jan 09, 2025 at 08:53:02AM +0100, Gabriele Monaco wrote:
> > > > > On Wed, 2025-01-08 at 13:00 -0800, Namhyung Kim wrote:
> > > > > > It's an optional feature and remains 0 when bucket range is
> > > > > > not
> > > > > > given.
> > > > > > And it makes the histogram goes to the last entry always
> > > > > > because any
> > > > > > latency (num) is greater than or equal to 0.
> > > > > 
> > > > > Thanks Namhyung for fixing this, something definitely slipped
> > > > > while
> > > > > testing..
> > > > > 
> > > > > I confirm your patches work well also when the bucket range is
> > > > > provided but the
> > > > > min latency isn't.
> > > > > 
> > > > > I'm wondering if it would be cleaner to propagate your changes
> > > > > (using
> > > > > min/max latency only if bucket_range is provided) also to
> > > > > make_histogram. That function currently works since we assume
> > > > > min_latency to be always 0, which is the case but probably not
> > > > > considering it altogether would look a bit better and prevent
> > > > > some
> > > > > headache in the future.
> > > > 
> > > > It looks good.  One thing I concern is 'num += min_latency'
> > > > before
> > > > do_inc.  I put it there to make it symmetric to 'num -=
> > > > min_latency'
> > > > so it should go to inside the block too.
> > > > 
> > > > Or you could factor it out as a function like 'i =
> > > > get_bucket_index(num)'
> > > > so that it can keep the original num for the stats.
> > > > 
> > > 
> > > Good point, I can have a deeper look at that. But I'd say it can
> > > come as a cleanup patch later.
> > > I have a couple more changes in mind and this would be no longer
> > > related to your changes.
> > 
> > I'm tentatively taking this as an:
> > 
> > Acked-by: Gabriele Monaco <gmonaco@redhat.com>
> > 
> > But it would be great to have it as a Reviewed-by and perhaps a
> > Tested-by, provided explicitely in response to this thread, ok?
> > 
> > Thanks,
> > 
> > - Arnaldo
> > 
> 
> I did test after applying both patches, went through the code and
> confirm my test worked as expected, and I confirm the issue is there
> before patching. I tested also in between, so feel free to add to both
> patches:
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Tested-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks, added.
 
> (I'm assuming you are referring to 1/2 and 2/2 and not the little patch

Yeah, Namhyung's 1/2 and 2/2 patches, these:

https://lore.kernel.org/r/20250108210015.1188531-1-namhyung@kernel.org
https://lore.kernel.org/r/20250108210015.1188531-2-namhyung@kernel.org

- Arnaldo

> I sent in the first answer)
> 
> Thanks,
> Gabriele
