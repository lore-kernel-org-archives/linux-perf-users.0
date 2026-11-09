Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224110;
	b=hLcpM5IIMeTeb3pp4Y25y3043o9ANw3AH72lkJWoUnZuhwKjn241k6B0c/r7ahbg8s1S
	 vkftr2uCr1g8h2dMc04RDYNlqtuciCMdzsLVT+fSP7BSp3xdwNkSgZIjujm3Vq6Bu43QJ
	 GPExQGcfZsZDSKXaXjwbdFyJZOHCs0RQkM50+6O+YNkK5RNFDY3iLvhDNFpK6vqd4ADBQ
	 3cTuwy0yaKU8upB/3TOi1WD0yDVxZLKzrSVyKYBmKVM+LzjMl+CfO6oStG6YAczJdGmEC
	 b+2ZG6qRfF+a494zyDp/dJlUuA4+j2J7DnCtWxThzDLv+papLcWfY8E2/TiLG493vXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224110;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ANHxOzhJPGflBT0G8nSgwaWuU/QO9+lNdn8zzE2S848=;
	b=LsJ4PWZrpUVApGkF0Lpg4q1h5n+vNkfkpIXwfzv44tM1tHrd7IVip2QCfH/bxaqOJKVu
	 Moaah1MKTxPKrPl0USjw9e0+3mTvoshLsi24Bk85aH7iOiUKMvSyR9uyrCw8teeAkKID2
	 jaUWOgCO0b+qJaSmOU8t+e050TWGYvCVEyBn9IPwRAiAC/gLnUIk05CbGVrz2EhcmEln7
	 W8uehjoGTJOPykCwowBhpVBHwjKxvXNOYUTzgaaYTU/Mns0yoTKKXCVNMM37wdApbJOrW
	 V6O1OGx5tQC/Hst1Jmtl+BE9T7d/plf3MhBckrMqbK0YwlVHLv3jbXIqq1qzaoRJp9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d83g7iTg;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E642606A323
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 11:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E642606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d83g7iTg
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3454A1516;
	Mon,  9 Nov 2026 03:35:05 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5B713F85F;
	Mon,  9 Nov 2026 03:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794224108; bh=MWU/VLGz5DxyOuJy58S1eckeT6uY/JsD7BNyDuhq+Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d83g7iTgYNtX5lXxQjHSwS66TyqloN7ycPmfcOHIt4ekbKSA8MX0PwokioeF94bT7
	 3BegtQPy2JRO30kU/g8O6J7q4oKtgKHg/WKNOmL8nsNzWfXncMysNkfdtOHQHbkrE1
	 k/TDDsa3BOxgRZ8XUcs7/FkJBYt633pMyeyDb4Hg=
Date: Mon, 9 Nov 2026 11:35:05 +0000
From: Leo Yan <leo.yan@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/aux: Avoid reclaim for optional higher-order
 allocations
Message-ID: <20261109113505.GX9176@e132581.arm.com>
References: <20261109-perf_aux_alloc_optimize_psi-v1-1-d56ac4bf3ef5@arm.com>
 <sashiko-outbox-204821@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-204821@kernel.org>

On Mon, Nov 09, 2026 at 10:31:42AM +0000, sashiko-bot@kernel.org wrote:

[...]

> [Severity: Medium]
> This problem wasn't introduced by this patch, but can rb_alloc_aux() leak
> rb->aux_pages [1] when the first rb_alloc_aux_page() call fails?  At
> that point rb->aux_nr_pages is still zero, and __rb_free_aux() only calls
> kfree(rb->aux_pages) when rb->aux_nr_pages is non-zero.
> 
> [1] https://sashiko.dev/#/bug/linux-c1a2bb3b-5d2a-4fca-a697-ce07992a5cc1

See the patch that fixes this memory leak:
https://lore.kernel.org/lkml/20261109-perf_fix_aux_page_memleak-v1-1-aae781d6749c@arm.com/T/#u
