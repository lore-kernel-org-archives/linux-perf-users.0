Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0B55E73;
	Thu, 12 Sep 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152662; cv=none; b=EyWnvf6mK72bAxxxdl9CTvSQYsstD3kWe+sEAwLPS07o4bz9uCSrJj5iYDeVXXMjRolDXYp8ZmxPUWgXpkkcCmmpJyD+rTMTb/FXjKNToJ0bPmt3eMx43NqQMAxILC8Q4/zRowp9s0eeQtLH5/7X/Kq6FdyZ342VPhAO2zcIVq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152662; c=relaxed/simple;
	bh=iM/LHvZ8HGzzoIyfcdqHCo4ta2hwmbON4/bbrrU+2Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCvQo6+2hR7eiRfLXM+uMXb2FOikkhgE8P1ZubU6vG6UVIJm1sGr7YGd6LOd9v7kd7JjDQFPqyNZXzAaozpgjIa+6YlAb6TJ0RYr4QeVteG7dF6bpuq3SAtMHY7I/Wgcc1GjfAXMu6me5Yvc2Go6dgmVLVa2AKIs3W4x6HnZLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEWGUAxh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEWGUAxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944B9C4CEC3;
	Thu, 12 Sep 2024 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726152661;
	bh=iM/LHvZ8HGzzoIyfcdqHCo4ta2hwmbON4/bbrrU+2Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEWGUAxhY5mW19Bm5CmA7oX6dZRTJcxxFFO8SQSkWCZQRYRQIG8m6rv7BqvX33H1f
	 FVbiJmJt2kfdbNvX7FXlhZWX+Mu10MrG/Kj0FczfogvKa+LZdwm5NlkwaSPJUmTYhG
	 sC34v0Fw88siFbP52/4ziq6mfACUputPSXucQuQBMvTJWJlXkh67oBuWtoJ4VoqkIR
	 4VgWchoeqsSb3Ik0MqwbqNV0Fk7EV0pT0EckuWVqAcYOLB6WApQBJnFEKXHD8rUsSD
	 SQFV2t+dDSArpPCybLC8iC9OlVz1gkdtRa39NBcC3Z09OdqM7b0tLA9IBwsPPdGm+D
	 +AMp5QO7IK1yg==
Date: Thu, 12 Sep 2024 11:50:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
Message-ID: <ZuL_0V5jgaaEUOY_@x1>
References: <ZuGL9ROeTV2uXoSp@x1>
 <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org>

On Thu, Sep 12, 2024 at 03:40:32PM +0100, James Clark wrote:
> On 11/09/2024 13:24, Arnaldo Carvalho de Melo wrote:
> > Howard reported problems using perf features that use BPF:

> >    perf $ clang -v
> >    Debian clang version 15.0.6
> >    Target: x86_64-pc-linux-gnu
> >    Thread model: posix
> >    InstalledDir: /bin
> >    Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
> >    Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
> >    Candidate multilib: .;@m64
> >    Selected multilib: .;@m64
> >    perf $ ./perf trace -e write --max-events=1
> >    libbpf: prog 'sys_enter_rename': BPF program load failed: Permission denied
> >    libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
> >    0: R1=ctx() R10=fp0
> > 
> > But it works with:
> > 
> >    perf $ clang -v
> >    Debian clang version 16.0.6 (15~deb12u1)
> >    Target: x86_64-pc-linux-gnu
> >    Thread model: posix
> >    InstalledDir: /bin
> >    Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
> >    Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
> >    Candidate multilib: .;@m64
> >    Selected multilib: .;@m64
> >    perf $ ./perf trace -e write --max-events=1
> >         0.000 ( 0.009 ms): gmain/1448 write(fd: 4, buf: \1\0\0\0\0\0\0\0, count: 8)                         = 8 (kworker/0:0-eve)
> >    perf $
> > 
> > So lets make that the required version, if you happen to have a slightly
> > older version where this work, please report so that we can adjust the
> > minimum required version.
 
> I wasn't able to reproduce the issue with either of these versions. But I
> suppose it could be an issue with only 15.0.6.

Interesting, that complicates things, probably the best way then is to
try to build it, if it fails, mention that 15.0.6 is known to be
problematic and suggest working versions?

- Arnaldo
 
> $ clang -v
> Ubuntu clang version 15.0.7
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/11
> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
> Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
> Candidate multilib: .;@m64
> Selected multilib: .;@m64
> 
> 
> Ubuntu clang version 14.0.0-1ubuntu1.1
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/11
> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
> Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/12
> Candidate multilib: .;@m64
> Selected multilib: .;@m64
