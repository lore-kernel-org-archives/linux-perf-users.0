Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB91AC8BE;
	Fri, 16 Aug 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830689; cv=none; b=s4SqDLcY8g7GZv2huM40m3Q/sVkFYCri3w14aBByp4OIdu2t47Benz+IZhSrnNmNRftl6fJityR+BNqmspo46KQ61GAGnmb4QVmfOOly2zt2dOeDZ1wP2dViewNYwP61bD+WwNEtD5hPALMwQkxZzabmF4RbUAm7cuyNq972Zro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830689; c=relaxed/simple;
	bh=P03NoRPWOew/zEckFq6H56iG7PE+QKUMOpQAR0woiL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOqg/BP1u9o9fjWKN8IG+/giZZdlIehPsXq06wVMNhvupX2GhjWIk7wTjORoaSSFpW+3//JpgoErAQkMxosqN+Kf9o97bcJxvCxzT0AKY7EdL+TjfLa+tslQVjLxH+ZZgk+80CebTG6SAg8a8OpQHoNZJHdnA9lVpKSdMs4FenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EBiccx3l; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EBiccx3l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IOOLI9WKFRs4gfl6He/jq3lJinZdUeEYeTDVswuAvyo=; b=EBiccx3lTHuQMq/USiLorIxKXp
	8r340NPpPWyctZD636zkEfIxlBVjjQ217KtE5bAhDsn8TOkGl6hdKtxzP5hQSFWmC5tgbtIMhJEmC
	ZJud3UHOTuAdA30oTpS8GqNwjw+GZqVV9joZ00mg77PlxhZamSdhF8T/U7BCwmMjPLsrZmZUZ7goh
	BJmwUY3XeAcw90DUXSRJb05wkwoEElSRS24eXjpM+mu8Yz2cX0t6GhTZgZUiaQpz2VLyQ9hJk9Y64
	jhJnmOZAQPcT2dYFVtUP7LNQVvF9pV1Cc1MnuRqkgUwDyGwXAb/rYxulil4NqjxRzG+Meh1Eozmr8
	NllZyL8A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sf16h-00000003uWG-2dmY;
	Fri, 16 Aug 2024 17:51:23 +0000
Date: Fri, 16 Aug 2024 18:51:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: Remove setting of page->index and ->mapping
Message-ID: <Zr-Rm14B5AHZ4_UB@casper.infradead.org>
References: <20240809201038.2648058-1-willy@infradead.org>
 <202408161305.a3a5158a-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408161305.a3a5158a-oliver.sang@intel.com>

On Fri, Aug 16, 2024 at 02:35:39PM +0800, kernel test robot wrote:
> from commit message, it seems just some useless setting have been removed.
> but quite some performance regression bisect by our bot finally point to this
> change (already removed some not so significant changes to avoid this report
> mail is too long).
> 
> we don't have enough knowledge to explain these, so just report FYI.
> if you have any suggestion for our tests or need us run more tests, please
> just let us know. thanks a lot!

Can you try this replacement patch?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c973e3c11e03..bc12f4fb7fa9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6221,10 +6221,9 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
 		goto unlock;
 
 	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index   = vmf->pgoff;
+	lock_page(vmf->page);
 
-	ret = 0;
+	ret = VM_FAULT_LOCKED;
 unlock:
 	rcu_read_unlock();
 
