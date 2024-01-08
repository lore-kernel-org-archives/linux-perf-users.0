Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F52904
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jan 2024 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qGUWWLGU"
Date: Mon, 8 Jan 2024 22:36:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704753384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9CzJI4v7ZZIn8Z4MqI2ccI8fM0TNWv+50JvAqWUZoE=;
	b=qGUWWLGUoavcMpaCn7yRI80g1nGqtIsd8AMaacC5IwTLMi8q+T4SWvT0rO6tsNvTkSd+SL
	R2It5GObhtJO0HXMQice2vfYMEk5k0jRDnhEq3yIVtZNsnbxkvw2g1kcWhNzQ+DrQZVCcX
	MuAet7nRQXXrGiOGrx7lCUvMo74X62A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: v6.7: Regressions trying to install perf tool
Message-ID: <ZZx45Q_QLVT8dHVs@linux.dev>
References: <489365ba-20ce-230a-05e6-939637e3896c@secunet.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489365ba-20ce-230a-05e6-939637e3896c@secunet.com>
X-Migadu-Flow: FLOW_OUT

Hi Torsten,

On Mon, Jan 08, 2024 at 11:57:14AM +0100, Torsten Hilbrich wrote:
> Hello,
> 
> I'm currently trying to update to kernel v6.7 and the installation of the perf tool fails. It seems that the output directory is somehow set to
> tools/perf/perf which is the name of the perf binary.

Thanks for the bug report. I'll look at what it'd take to get the
sysreg-defs Makefile happy with perf, though I must admit I'm tempted to
just rip it out and have the dependents (KVM selftests, perf) invoke the
underlying script directly rather than try to straddle the two different
environments.

-- 
Thanks,
Oliver
