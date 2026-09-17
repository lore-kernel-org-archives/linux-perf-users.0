Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1C332EC8;
	Thu, 17 Sep 2026 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605056; cv=none; b=pyZdmj2AU3pXu6CUi0J3ZCqJnumOzXg7+EyvjcjD4XKJUE3ujSdK+rFJYgVAdVrdBDpDq1EkQTLnZH5rq3rlRJ6dMKG5+hUW6HNaAgERoVRbOHx9tOdrzpU+Pw26gwJc7xZoNEyN7qcQlJw6olcdxQcxu72/zTSZ5U2fO+wRTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605056; c=relaxed/simple;
	bh=IafVmLNF7t1J4v3DTjxeHpTqTP0+LOiTgjAL5PAFclw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNDQNd++DVUKJyrwQN2qh2UsiiMOfJUEiIADHjQZZChk0LuS1BXtLdsmvricKosoi6X8X3c+HVYwvzueKgt7sj4MXLDQ2iN9raGbo8LqiLal4ftJaKYy8kcOGT3UQChcQhKQWXQl5XirvMhhjMP62Q1RDbqREYrhMIi+UPEDfgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzM0AvTc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzM0AvTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AADB1F000FF;
	Thu, 17 Sep 2026 00:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605054;
	bh=8bnPSZ8iZiqlDC4OCgJs2cYT4HeyFoBMn4r97deBHYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MzM0AvTcaMERobm+4eHRZBKmlh+lOE3RszoyuqFfIZwQX0/EgfX5o7HZuWpP9H+Z9
	 hWIasZkDTDhxPFnQUgmA4q1sLU1Vax+JSw1+4Tm44ZAifwJsLQSFY+tUQJ9KF+1wTn
	 j8amFUdY2QP1QnzBliFM1HCc2b+f5Sys1mLmyuD+GHzngjxPNwMaAFsssjlft5qmN/
	 tX/JKAZcHhyJFsbgIV+0WtpYoSamijfntYWWKhGuQyF6h9PO7kmOq4m9UuEjv3qk0r
	 xYsJN82zaVuUSGV2ySrnu/nlHBn/6Ey1j68xUIQJ+02n50m94FO7ztKCKGOezcct4k
	 uFUCs8OLLBT0A==
Date: Wed, 16 Sep 2026 17:30:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf symbols: Fix broken ELF_C_READ_MMAP fallback
 guard
Message-ID: <aqs0vRg1v7fhIVLy@google.com>
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-1-1d3360e21f07@uber.com>
 <20260915185318.0573C1F00893@smtp.kernel.org>
 <CA+w=M=Rpvn9QpbvC4UWex91wNZ39BNmjt2-PaACNS1Rsai3uGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+w=M=Rpvn9QpbvC4UWex91wNZ39BNmjt2-PaACNS1Rsai3uGg@mail.gmail.com>

Hello,

On Tue, Sep 15, 2026 at 12:04:27PM -0700, Alireza Haghdoost wrote:
> > Could we restore a proper feature detection mechanism here rather than
> > relying on an unconditional definition?
> 
> Thanks, this is a valid concern. I’ll restore the compile-time
> feature-libelf-mmap probe removed by 22dd1ac91a77 and use it to select
> between ELF_C_READ_MMAP and ELF_C_READ in v2.

Please don't.

I think we already require much recent versions of elfutils like 0.157
for libdw which is released more than 10 years ago.  So I think it's ok
just to assume _MMAP is available.

Thanks,
Namhyung

