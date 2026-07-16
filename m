Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ADF443E34;
	Thu, 16 Jul 2026 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226123; cv=none; b=IJW2TC2oBkbRNHX6oOc246aVMbmMq2OW5mGSTwOm9agtJ32mXGRSoKsloxA5WhpRL11FVNetHBXvY3/3OIL+KDkovYc+nHGJI0H4kPXJHoanrdCWJTlvt+d2aYz/ph/zUlYIuS8UGjyd4UMAf409FmhgzoyZtsOuXXqiD9VO89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226123; c=relaxed/simple;
	bh=hCNQdizOHMZ0gY+NZHED7mm5uYFnwtZlYw1FzsU5oTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isWjH5VhdnQzTU23T9OdCiW+7NCyT37CkrsWsvOem/jMNuWJPcURNbtUB6qElpCwPCDREfJ5rlogh/EASbl+9c9Eulfli+V2i7IsU21w+GJ0iQYBGa+ny9jZTMEZF/Zc+9NxoLVNCGp32llmONRSCCDK/Zr5Po1r19ISfKVSZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQrNIeZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQrNIeZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3909C1F000E9;
	Thu, 16 Jul 2026 18:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226115;
	bh=diIwfxvG0SM7BSyVjn/P5vTsFYU3RHwtYfHdjtNXFnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BQrNIeZdJo4VjQOOr9kB+djEHCuY6HBYvds8ANMRtO7ABOuMLd8AI58S4DnzFA1GB
	 iKsC/PaKSFVNrJoVDa8aa4ZxsVybc9UiqQ1YB1SxA1IYznKSSe44vjzPbqahFYnVhW
	 p5qiOA3l5ihWzrVgjFUEy8+IBG0qnbaNcb6HwZurYdPT/BcabXNZDar6P5fpeNqcCu
	 al3lZtu8pUe5b5QXi7R7EcVSWLE1BGbhkVY5Qpw6GZcX+tXSfthGbw8VSW4lEPCn88
	 EB9b9mRSe4o35Q0jsDLaqavmnCuG9jzlO8550TEcgw+yXQb4+0mmj2SVcl4xgWP6eZ
	 fYY/h1xmwU7sA==
Date: Thu, 16 Jul 2026 11:21:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [tip:perf/core] [perf/core] 166f10836a:
 perf-sanity-tests.Object_code_reading.fail
Message-ID: <alkhQXgadepTWbk9@google.com>
References: <202607091054.7c96d6c6-lkp@intel.com>
 <56069e78-7006-4569-add0-6ccdf88c746b@linux.intel.com>
 <alCwJew7UgGb+EQV@xsang-OptiPlex-9020>
 <803bfea9-b16c-44d5-8004-096a92e90017@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <803bfea9-b16c-44d5-8004-096a92e90017@linux.intel.com>

Hello,

Thanks for taking a look.

On Thu, Jul 16, 2026 at 02:29:49PM +0800, Mi, Dapeng wrote:
> 
> On 7/10/2026 4:41 PM, Oliver Sang wrote:
> > hi, Dapeng,
> >
> > On Thu, Jul 09, 2026 at 05:04:11PM +0800, Mi, Dapeng wrote:
> >> Hi Oliver,
> >>
> >> It looks the direct reason causing the test case failure is the "0" sampled
> >> IP. This is expected. The commit 166f10836a653dfa280d4335603b52f685b8b1ef
> >> ("perf/core: Fix kernel register info leak via hardware skid") mitigates a
> >> security hole and may lead to the sampled IP could be 0. 
> >>
> >> What user right is used to run this command, root or normal user? If it's a
> > root user. as 'sudo' in attached:
> >
> > "2026-07-10 15:38:50 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf test 23 -vvv"
> >
> >> root user, suppose it should not generate such kind of error. Could you
> >> please add "-vvv" option and rerun this test? The "-vvv" option would print
> >> more  verbose log.
> > as attached, thanks
> 
> "
> 
>   disabled                         1
>   inherit                          1
>   *exclude_kernel                   1*
>   exclude_hv                       1
>   mmap                             1
> 
> "
> 
> The event "exclude_kernel" attribute is set in the test case,  so it's
> possible that perf overwrites the kernel IP to 0 to prevent kernel IP
> leakage if PMI hits into kernel space. 

I expect PMU doesn't hit samples in the kernel when exclude_kernel is
set.  But maybe there are some corner cases.

> 
> In general, the "exclude_kernel" attribute should not be set for root user,
> I have no idea why "exclude_kernel" is set in this case.

The test explicitly runs with it both for hardware and software events.
I think it wants to check the privilege filter as well.

> 
> Anyway, we could have to improve this test case and skip these "0" sample IPs.

Yep, probably that's the simplest fix.

Thanks,
Namhyung

