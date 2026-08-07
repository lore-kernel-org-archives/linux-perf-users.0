Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DA35B64C;
	Fri,  7 Aug 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120762; cv=none; b=KTUNJdzA79oEYlZ0C738PAE9He+0njQDfveJRLqondc+wBtJDS2zf/3opIrSBH5VlIxKW+sMnDjL8Eqpcl/LQijCe8kB1EM9cCecdLHHBAOSSe0bmJcIGCd1VXoeVyDs6zsJmT3XZPjHmc3qfssMB3FWcd2s6i7byiI3Z0Z02b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120762; c=relaxed/simple;
	bh=ZsVy2Bldc4Iy1xfqK36SYjDdw0ZqYj0Z2l6LTWQYrlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6xiLlh7H2RFkfD4wuBtKeNkbI0FZxjcOkVgesD6kcPxQLIOQgNlZPZ/mtGCV2djXjruHC48yp0ULosA0wB6NStuCbdZluxzf/sczlZ74YDl7U5cKTbvFA4pUODvYllq27zHZoC/qPdn2G37h23ZNrR8aBuh/SrwSdlq9vZSwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6tFLJEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6tFLJEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142FE1F000E9;
	Fri,  7 Aug 2026 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786120760;
	bh=/um5uPcjx7OWZ1jsOcB5wCREV96cnZsw1LH9dLXHlLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z6tFLJEbn/PJFoazverXDdBWXnRb2cvwBkhknO+C4wYMKDSgSz9zQm9hOu1uAD5PF
	 b3iGwAjmXLo2XQeVbAzxOc9h/bLoK0MQTN2h0bYrGjMsB4MS44GsFhdeyEffTtrzHe
	 2DxiQ85xbCeFdOIZfkHFwX0kPgWjLU9tnUrnTLtTs/CN/SzQ7ykVzzMRLovnnuxwLs
	 pk1iEsCj/+l0L+XXklVEiav9+JGGHAMZjNc+HbFv4IuzfM+JAZOVuskVqnkPG4X4nz
	 iNiLXP1Tj+SUwPCY+6Iq0tehO0lATO5UihZzEIZH9nnZZ/MbKLkpd1DwlyB1U4RP94
	 JD/9rG4gadmTQ==
Date: Fri, 7 Aug 2026 09:39:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Tanushree Shah <tshah@linux.ibm.com>
Subject: Re: Fixes tags need work in the perf tree
Message-ID: <anYKNuAVxu6TyJ4w@google.com>
References: <anXtnqxN5PN4ULmF@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anXtnqxN5PN4ULmF@sirena.org.uk>

Hello,

On Fri, Aug 07, 2026 at 03:37:18PM +0100, Mark Brown wrote:
> In commit
> 
>   8782a10c74e85 ("perf trace-event: Fix integer truncation in do_read() and skip()")
> 
> Fixes tag
> 
>   Fixes: 454c407ec17a ("perf tools: Get rid of read_or_die() in trace-event-read.c")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'

Sorry about this, I should have checked it more carefully.
I'll fix the tag and force push the branch soon.

Thanks,
Namhyung

