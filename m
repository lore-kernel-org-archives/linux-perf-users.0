Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A371862;
	Sat, 23 May 2026 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779494559; cv=none; b=sBjaB+S2h8brM7XYENyTsBwvuDk0TnWfOvXXFao2hgy9KLR6UNhkM5rrdh5natA+AGkanM+wcx22G7YXTWYhqK5aWzeUJ1BlKWYEkDhPtqu9U31SBVkHFxsxcdaof6m1U3lO0vA4ICle9F0N02v6AGCv7tY60t4+C+66mBBvUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779494559; c=relaxed/simple;
	bh=JxoGcNc+m+doRoo428iSMbwlhF+9G8Cr5gQdnj7QVcI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NzHGTLenSaMLkmD6PwDgGuZRhhdhFTGqYD43AGvisivt6lSwnC/SGl9K5BtqEXyvhakvXnX3sLVxHZrp7g0OWfhXxxC71efvWmjN9IcBNuJQC0Ye/FUURmdLSJkmqAMT6JruMKqRkQcXciR/GBiaWCnsv9ZIvsnSKzwZnu+Yz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9GVleRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9GVleRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E301F000E9;
	Sat, 23 May 2026 00:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779494558;
	bh=BGTkKvSPuE5al+MftdgA9e0ramgmtr0IIHqjMaXwx04=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=h9GVleRJKUXdUhTip+xz6cMjbDOYNtn3Xh1gIy0zbrlaxezb/5rJ88G3TJA1Y4YQS
	 QmA2sicC7w1LM7RMDeMLMj5fgMngt02/P+ynQ+pW0oiLv1W9if7ifzOd8ClIio+KiF
	 L93vcztxZ2W+XiRa3L8hSK+uozTi9FoF7kA9VNTZ+BjyyjD52VS4IM3F+MfpbwPvCA
	 hnBImDXhI1vruuxCvAQfbhKcpX5AxyMrRVXyx30oqgA346PjevKB7nYlv6GoKwuSw4
	 4ydgogNxbHebiuS+mR5LjO2GOdbN//L3mFcstZOJ2uJKpHsXTDuvp+LLIMXzI4NwY6
	 A2AOwAHidcUJw==
Date: Fri, 22 May 2026 18:02:36 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
cc: acme@kernel.org, alex@ghiti.fr, dapeng1.mi@linux.intel.com, 
    guoren@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
    mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
    pjw@kernel.org
Subject: Re: [PATCH v2] perf riscv: Add SDT argument parsing for RISC-V
In-Reply-To: <20260508082658.3982-1-cp0613@linux.alibaba.com>
Message-ID: <b9f0c9a6-01bb-c111-2153-60c2b3407dae@kernel.org>
References: <20260416124945.121699-1-cp0613@linux.alibaba.com> <20260508082658.3982-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Fri, 8 May 2026, Chen Pei wrote:

> Gentle ping.
> 
> Please let me know if there's anything I can do to help move this forward.

Probably the best thing that you could do is to find at least one other 
person -- ideally, more -- to review and test, and to send a Reviewed-by: 
and Tested-by: to the list.  

> Thank you very much for your time and guidance.

Thanks for sending the patch!


- Paul
