Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000D219FD;
	Thu, 30 May 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091269; cv=none; b=rQbptnowZpZhkqHTax/aRwqUHXySaN48RaTZ+0ANFNbOuX4bb0SCFjvD3WUcSga3+vfDxEvtT7N47ytfzCwdeob9h1h2SiTi0SxCN0YRaNQcnDzDH8TDGZfnX+UMjLYVONWZk+4PDpF29RDyZC7PRycPLSLj+/6XUId3sdhUM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091269; c=relaxed/simple;
	bh=qErOKC7ofurrzhpbYIzzbA8eWtCnbIEmsnOdRx6pC9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smU+DVgqNZuLNv6JKwhTjWzmAypsoaWMIO0Y6Y1cJe/7uc7D+O3JBBahiak/aS5AnT6GQV+6uOt+A2qHT/Ui8pKM7l+/luUUasiZie6oHDKJ6ABbZns+PyiXEcguhruTy08hoCu1lh76RlibFALMaXEWZz/3CUm2VkPhemboNaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbmBwfln; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbmBwfln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717091268; x=1748627268;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qErOKC7ofurrzhpbYIzzbA8eWtCnbIEmsnOdRx6pC9g=;
  b=cbmBwflnTNKLfvCGdcMM60ZJIt54TcsdSIpCakYKlusIow6zjg/U58D1
   yqxKPcI8AFAk9bajjh0B0LIMpnGgBeyMfNH7e5P+VieQEXBRYzQBRYdSc
   Et16yXifj12Zb3dcG+gc1VRua+6V46lKVqqhqF3W6BQu7w+LDYT3AB/Ac
   nbiaMD6rnRpDEFVUMYxj+BMB+BCLQXTK70z6k7byyfGmwBAxvv+4il08M
   3uy/A0HjC/Dv+5eC5lt4wzQhXmsiwuBkvimSjhwxvBXsZcXnbflWvHJEZ
   4olqJ3HiE2k7A5HicwPf1ZTO0bNE4uQXC++7ZV/D0MGRekMkziK7uRNbR
   A==;
X-CSE-ConnectionGUID: h8CgcEu5TiKYqfimOCAh+g==
X-CSE-MsgGUID: 0XgHeQevTHuC67ZRHE9xLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13558328"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13558328"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:47:48 -0700
X-CSE-ConnectionGUID: +uczZK5oQmq5U8tU3TgYCQ==
X-CSE-MsgGUID: HdRkl5sHQWGqz3aeN078JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40954905"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:47:47 -0700
Date: Thu, 30 May 2024 10:52:44 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 4/6] x86/irq: Process nmi sources in NMI handler
Message-ID: <20240530105244.46090c04@jacob-builder>
In-Reply-To: <ae870a38-e7ee-4334-ba4d-ca3e4e17a53d@zytor.com>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
	<20240529203325.3039243-5-jacob.jun.pan@linux.intel.com>
	<ae870a38-e7ee-4334-ba4d-ca3e4e17a53d@zytor.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Peter,

On Wed, 29 May 2024 14:12:19 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:

> On 5/29/24 13:33, Jacob Pan wrote:
> > +
> > +	rcu_read_lock();
> > +	/* Bit 0 is for unknown NMI sources, skip it. */
> > +	for_each_set_bit_from(vec, &source_bitmask,
> > NR_NMI_SOURCE_VECTORS) {
> > +		a = rcu_dereference(nmiaction_src_table[vec]);
> > +		if (!a) {
> > +			pr_warn_ratelimited("NMI received %d no
> > handler", vec);
> > +			continue;
> > +		}  
> 
> In this case, you should assume some chipset hardware or VMM is giving 
> you garbage in the event bitmask, and treat it as if bit 0 were set.
> 
right, should return 0 and poll all handlers.

Thanks,

Jacob
