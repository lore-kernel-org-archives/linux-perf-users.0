Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B6A927;
	Thu, 17 Apr 2025 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744857932; cv=none; b=nEb287QnJBlJ9+NzBUURamtEy20qgwz/LdfBNH6Kc2MqXdHv4qxHzfw/j9qJGR11fPSvRxArtaJFHyqcYs3WTrUmiV2CI7NEVr7Q9UATi2X/Xdbjm+6GZ7oyIF/jksfTjxIk+WbQOCDtUi0m7rUnwRNm0A5sHc3GXTp1EMzoqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744857932; c=relaxed/simple;
	bh=LO1sxmeX8+aRntyiPEodIDK3ro74wS/bcDYyEkeA/HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCLaVVsHmo9PZ/7BpHhOu7efpuDocWWvZHjbpMp003SpbzXhKV8k9gvN0Sd8tFkLYP7pUuT68qo+t75hAn8ru9T20D4X4I7spA2qXCUA+AJOgrQfzNL5fFAdQKIIjwwcI8WxTNj1rXFlx7meOejo57ksWzCrb40mF4zWbQw/wXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNw4K9qu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNw4K9qu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD735C4CEE2;
	Thu, 17 Apr 2025 02:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744857932;
	bh=LO1sxmeX8+aRntyiPEodIDK3ro74wS/bcDYyEkeA/HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNw4K9qu7feF3DKI7InZwYS6glPX4TM+DeLFUseC2+KeA24xbxVj1BzBFKizm9EhY
	 ZaJt9VOUBbdhQzS+wK79/o3FskE3PaOSqTch+qGYNtoH89iqBW7OYt/er4p2ohendm
	 09CUzLYB/FXyHL1h5ITTI/2+mcQOQctXwrCieoZuSXRBit/PZxA5CKM7Pe0CmLUs5t
	 S21FsU23OdP7Vv57j/KefoiGKcfnSlfcI+oxo/GcnKkBxtlJT6AEwontq37TNmSNEE
	 rveAc92/FDDnfKB/dEreV+J2iAe20X6vpmnAbCRbg9WScFVIr7PIp1MlIPlx5KrjyE
	 TScN5KS8ETWBg==
Date: Wed, 16 Apr 2025 23:45:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: jiang.peng9@zte.com.cn
Cc: venkat88@linux.ibm.com, atrajeev@linux.ibm.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	shao.mingyin@zte.com.cn, tglx@linutronix.de
Subject: Re: [mainline]tools/perf build warnings
Message-ID: <aABrSclgXsyzGo_g@x1>
References: <40981d32-72f4-4935-a62c-444ad78ce336@linux.ibm.com>
 <20250417100118733FrbRcKrZFI5AZsN2G6nyr@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417100118733FrbRcKrZFI5AZsN2G6nyr@zte.com.cn>

On Thu, Apr 17, 2025 at 10:01:18AM +0800, jiang.peng9@zte.com.cn wrote:
> > I verified with perf-tools-next repo on both branches namely
> > tmp.perf-tools-next and perf-tools-next, and I think this warning got
> > recently introduced.

> > Git Bisect is pointing to acea9943271b62905033f2f8ca571cdd52d6ea7b as
> > first bad commit.
 
> Hi everyone,
 
> I apologize for the oversight. My commit
> (acea9943271b62905033f2f8ca571cdd52d6ea7b) updated
> include/vdso/unaligned.h but I forgot to sync it with
> tools/include/vdso/unaligned.h. I'll be more careful in the future to
> avoid such mistakes.

Hey, please take a look at:

tools/include/uapi/README

More importantly this paragraph:

"So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers."

Cheers,

- Arnaldo
