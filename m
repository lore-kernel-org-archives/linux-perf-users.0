Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586E19C55E;
	Wed,  5 Mar 2025 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203065; cv=none; b=h3VAnjr8iyiLB4vmAtz399fJuCfmX90I9/erZ63qmWGLeeWZYFjuz6EqpRBO5Rkg6S8wELQI11rLLgAH5U5r6LcdoRtZ+11lEvjuyuVdnvloCfhN09Lz9BYK1v4ENBCSEhUJP51xgW7vxbgGNmhSJywcOBpK0nr7wSsiO0dYLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203065; c=relaxed/simple;
	bh=t4sPVOxzDJAYKnhpd18C9Vkop8eqR4sQJbzHM9Uvhws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glKh/SYaI97QWONFFLSvbS2roS6RgzSG2HQZQbCdK2DR3g6hGioYoMduXMg0hLzmP69POuMDnR/em6jeq0NKIUMTSyWC8Gd2XxfDl1CeS7GNH9AFHq4j4lvSSZgwezIRHlmtLBR+l0lc65jb+2oOeRq+EtaqP/PIPM5vLnt418Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MiHR/u0l; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MiHR/u0l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=17Q1ePKPZtBEcl+vkrap0wJMpbpHnmXjVqjNWIZ6vhg=; b=MiHR/u0l5WWzte3RVYSWhrNqLK
	dETVteqyqPEHquevzsPbV3NjjXC5nAHASQz6P29yuenxd7ElZ+nx9y2PnLkdeAMjFGmJceiioJC+3
	c3eB6ndsGoSV4lSfAhfsofngXQepmkT4ediyjgHz3wraqJP+ATjAs5MdePDRk9doca9d9m8vwwOM/
	x0UoZ59vYD49pxTySy0SVGlIG/4F1vZIK/qVQzE+Bg7SdcuJDxU8wEhpPMFbvSv08mXDAR4LRksFj
	oHhrFbuyNkRHYEtPloIpnwDNdTxAP6cwO9rJMPYzoPQBGWs2rfh7jQpjJ/ETV4WLqlV0ay89kHQVo
	QK7Dai/g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpuSH-0000000661R-1wXY;
	Wed, 05 Mar 2025 19:30:57 +0000
Date: Wed, 5 Mar 2025 19:30:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH -next v1 3/3] kernel/events/uprobes:
 uprobe_write_opcode() rewrite
Message-ID: <Z8imcXuuW6EK1aLY@casper.infradead.org>
References: <20250304154846.1937958-1-david@redhat.com>
 <20250304154846.1937958-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304154846.1937958-4-david@redhat.com>

On Tue, Mar 04, 2025 at 04:48:46PM +0100, David Hildenbrand wrote:
> +static bool orig_page_is_identical(struct vm_area_struct *vma,
> +		unsigned long vaddr, struct page *page, bool *pmd_mappable)
> +{
> +	const pgoff_t index = vaddr_to_offset(vma, vaddr) >> PAGE_SHIFT;
> +	struct page *orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
> +					       index);
> +	struct folio *orig_folio;
> +	bool identical;
> +
> +	if (!orig_page)
> +		return false;
> +	orig_folio = page_folio(orig_page);

I'd rather write this as:

	struct folio *orig_folio = filemap_get_folio(vma->vm_file->f_mapping,
			index);
	struct page *orig_page;

	if (IS_ERR(orig_folio))
		return false;
	orig_page = folio_file_page(folio, index);

