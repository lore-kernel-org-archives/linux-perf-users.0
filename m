Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5B23E227
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997260; cv=none; b=VHjntI4L5XDFZ6f5xQOjPO4u0pmnVeO0KVKfa5zJZP6Yi8lnz7NeZ8eEdhzVFLibDfDMj3QaymR2d/WJjNnqUlQvhrl2NQxMJbhVgeXS6C++QUIw0olk9pmJSGrXEhxWsDr4b3yGY6RYaxXph0UmIbG0LHQKqng2XunYTIpK+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997260; c=relaxed/simple;
	bh=57jMVEEvVXQKFpQpyfNV3Tw9sLf262OVK5FW1kgNx9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBBffIrfU8mWdyZyehYuGOaiOwG0OYfH7iY/bxEK6yTBBHPc+rXdXuZP2N2U3d6fKBDf54VBZ3rk02xm35jiedHl+REIbsLU2WOM0Fpa+4LIbPbI/NMdPMWdbEywdPxzDWmt16/3zNUa/BbKfSBnZPdt+a9rxDtYpDtV23leqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL3E878C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL3E878C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D63C4CEE0;
	Wed, 19 Feb 2025 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739997258;
	bh=57jMVEEvVXQKFpQpyfNV3Tw9sLf262OVK5FW1kgNx9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uL3E878CaeZRO/z2D3sD4R+QemE0fxlrpTOTv2LpWFQTrpJ4/A+gPWduZlCWUyR6f
	 wgiVDe0qGg/Oy4FcDXDt2jmPh/sCA3sWhvqKQ2Dt7RKlwEj53pm0xvYJth8L8q6EgQ
	 Qs20CUaD7J0/DyLs6vvfig6Vt79FFdW1+wmrzPbnLY7u0z8bYCz+zr9NkdB38Ludl+
	 x0ZYoR+hlF3bcIrpGB48+LGw9hnz0THz8ZYtVBuD8cSizipwCToF9x8wTvCuPdBvOa
	 05k4OULVYyzk/qCluFrIK2yQrMlXRAmSSTUtfTJ+oKoLQrdix6lDof/V0kTbHs72Nn
	 U2RDJTJBT+Ylg==
Date: Wed, 19 Feb 2025 12:34:16 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
	ashelat@redhat.com, Michael Petlan <mpetlan@redhat.com>
Subject: Re: perf script: perf script hangs forever in linux-next
Message-ID: <Z7ZASBD7hpuGZZgw@google.com>
References: <c41e4b04-e1fd-45ab-80b0-ec2ac6e94310@linux.ibm.com>
 <Z66mwEOy06-6hvO_@google.com>
 <b8b12ca5-28bd-4e17-923a-f4f5853b999a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8b12ca5-28bd-4e17-923a-f4f5853b999a@linux.ibm.com>

On Fri, Feb 14, 2025 at 11:21:56AM +0100, Thomas Richter wrote:
> On 2/14/25 03:13, Namhyung Kim wrote:
> > perf script flamegraph -a -F 99 sleep 1
> 
> Thanks Namhyung,
> 
> i have tested your patch and both invocations of the perf script command
> work again as can be seen here:
> 
> # perf script flamegraph -a -- sleep 1
> dumping data to flamegraph.html
> #  perf record -- dd if=/dev/zero of=/dev/null bs=1M count=10K > /dev/null
> 10240+0 records in
> 10240+0 records out
> 10737418240 bytes (11 GB, 10 GiB) copied, 0.294051 s, 36.5 GB/s
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.060 MB perf.data (1177 samples) ]
> #  perf script report flamegraph
> dumping data to flamegraph.html
> # 
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Applied to perf-tools-next, thanks!

Best Regards,
Namhyung

