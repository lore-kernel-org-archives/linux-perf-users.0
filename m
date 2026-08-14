Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8A30D40D;
	Fri, 14 Aug 2026 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786688143; cv=none; b=lBpieysPNBIs4Ycgn8zez7VGAcV0auhQaZjc7Nafg84ZyVXtizxkCurZ8OJoZ83AjJS3B6i28EJjHA+OVW3YFBAjK9Is8BnyPLwI1b9IUXjHHzsYXxyxnC42BaenSvQidMrmbRCMQs6Xaj+18y+k9SC6s3nSpJmGRIYZVEEvT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786688143; c=relaxed/simple;
	bh=NET8+GcD+ix8xYuauM6huY3QwaNswuAdMl96kZOFfeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CP/x8Pm31mEP4v/sBAj3cWqk3dNs14kBCxa9bR9P9zzG/QGvgtTvEnTdBPYsDMJGBHDylowSwoHaIBcCp2WLYFSElrDU//qPoX0/2H8xR3YGUatE3rft7MXrnfAf0axwR64i/5Mn+PyA996nY7krU8w3kM19ZKcH2a21P+OvywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5KVN3n+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5KVN3n+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ECE1F000E9;
	Fri, 14 Aug 2026 06:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786688142;
	bh=8ujbR8nfCaBIZLUlofmUmp3ccj2HHRqzUvdZpXAWPB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X5KVN3n+DutPTTTwYrJHBEZWeOVQrVXY/yRS4KkQEt3yopWn6lwEZDzGLDSlPBoGK
	 6P0R7J+UCvq+Cez+mCN7EW0qaLCcvkZM0AbhqEJH2bisDQYLlUmiRXAZwc84taQUM3
	 lqb06Jmj6B7iYYcv0xZ/pPG0XbYMYwKOK8NrX0bHk0txrLG9vg/co8lS87xFwZmHmZ
	 qzFCXbW+3l1YPYLaobkEPgp9+pATpGVwd8oANeKKcY16Avt5jl5pxr+EF4Tr5/4UgF
	 dcReljcLtmEctSW9mqDfzd8Lqe6r34KOcxAgUTnfYWQDgJwekF6rJiMJo32nymYh+o
	 IdVmo94DzjCBw==
Date: Fri, 14 Aug 2026 15:15:38 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/9] perf c2c: add function view hierarchy entry
 creation
Message-ID: <an6yiqhtAyy8v8oZ@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com>
 <20260810052647.588867-7-jiebin.sun@intel.com>
 <anxvDnc2Kx-OSQEj@google.com>
 <20260814032306.2055624-3-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814032306.2055624-3-jiebin.sun@intel.com>

On Fri, Aug 14, 2026 at 11:23:06AM +0800, Jiebin Sun wrote:
> Hi Namhyung,
> 
> > What if both DSOs are NULL?
> 
> If both are NULL, the outer condition is true, but
> left_dso != right_dso is false. The function therefore skips the DSO name
> comparison and reaches the final _sort__sym_cmp() call, using the symbols
> to distinguish the entries instead.

Ah, ok.  I misread the code that it may return undefined result or crash.

Thanks,
Namhyung

