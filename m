Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA09477E27
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708915; cv=none; b=nlCfUpncrJ/SVeoXkB4sew43++D6CbYugtevxj//IeNgkZb1NnGzOlwF5N42uZaWqmh3Di2z0GuQG05lBqGkBAWPEzY79jh/YRO6TpLugmYqzg986tBXix9v7nPsPv2fk2fafrLqmjyPlJJNu+r5PK+4Z0LNRHquuGtBRrJp2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708915; c=relaxed/simple;
	bh=dn8rVySMl5MW0er6iW4qyJ7r/M1hv8iOh+kv6XTqsmU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpCgZiB6JIUQWzwrVMfHQV9OkUOkxt5ExKO1f/7BYyJOgrhqQ4a52iKzzQnYUa4aJiid+2zs6aZ5XW/DDbbvA/ZuTORn+ZdoYUDxJ85cxcxsqmtn0ILseqUWmY2XGD/rlvPOb1a6F2LAK8R9LUUjRUFQzxfJo0Je3Ex0VLbGv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i8u3J2So; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i8u3J2So"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940982D91;
	Wed, 17 Jun 2026 08:08:26 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2D0D3F915;
	Wed, 17 Jun 2026 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781708911; bh=dn8rVySMl5MW0er6iW4qyJ7r/M1hv8iOh+kv6XTqsmU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=i8u3J2So2vHEgBZlM0Fh7RJphmc4hwc2GkvJ64vcDSZZaSq1pTWigp2bJEe1KfADf
	 n5o38uvZwbS2AaSgfzzZ87r1azmrenbDMGChAY/7i4JkMERUxPV7in0caviw7l4FES
	 PAg4dUihLTf7Cby53Zcjhz0RupmHhyxG+geHkzFI=
Date: Wed, 17 Jun 2026 16:08:28 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>
Subject: Re: [PATCH v9 9/9] perf test: Add Arm CoreSight callchain test
Message-ID: <20260617150828.GE31870@e132581.arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
 <20260616-b4-arm_cs_callchain_support_v1-v9-9-f8fad931c413@arm.com>
 <6855d77f-d2f4-4dab-8481-a8c586e4872b@linaro.org>
 <20260617123322.GD31870@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617123322.GD31870@e132581.arm.com>

On Wed, Jun 17, 2026 at 01:33:22PM +0100, Coresight ML wrote:
> On Wed, Jun 17, 2026 at 11:03:07AM +0100, James Clark wrote:
> 
> [...]
> 
> > > +	# It is safe to use 'i3i' with a three-instruction interval, since the
> > > +	# workload is compiled with -O0.
> > > +	perf script --itrace=g16i3il64 -i "$data" > "$script"
> > 
> > Is there a reason we don't generate callstacks on branch samples and use
> > --itrace=g16bl64? That removes the magic number 3 and reduces the output
> > file size and test runtime a bit.
> 
> I checked Intel-PT which does not generate callchain and branch stack for
> branch samples. I just keep cs-etm aligned.
> 
> I can add callstack / branch stack for branch samples.

Tried a bit for this.

The branch stack is skipped due the check:

  if (is_bts_event(attr)) {
          perf_sample__fprintf_bts(sample, evsel, thread, al, addr_al, machine, fp);
          return;
  }

For the callstack attached to branch samples, the output seems not
directive:

  callchain_test    4372 [003] 75596.459422:          1 branches:
            aaaaabdb0794 print+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
            aaaaabdb0798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
            aaaaabdb07b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
            aaaaabdb07c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
            ffff9a10225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
            ffff9a10233c call_init+0x9c (inlined)
            ffff9a10233c __libc_start_main_impl+0x9c (inlined)
            aaaaabdb0670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)
            ffff9a2206a0 __libc_early_init+0x100 (/usr/lib/aarch64-linux-gnu/libc.so.6)
 =>     aaaaabdb0768 do_svc+0x0 (/home/kernel/leoy/test_cs_callchain/callchain_test)

It is hard to digest the log as it separates branch from address
(aaaaabdb0794 print+0x8) and to address (aaaaabdb0768 do_svc+0x0),
and put the callchain in the middle of from and to ranges.

Given this is not enabled by other hardware trace (e.g., Intel-PT),
and we need to change the common code to make it better, I'd first
enable callchain/branch stack for instruction samples. Let's see if
further requirement after get this done.

Thanks,
Leo
