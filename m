Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD9330B15;
	Fri, 17 Jul 2026 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311869; cv=none; b=YNkwtDye8lolujF0jsZQylfLRv6P3SeiwGiIuTPQNla2ZpXPqlsSMmyCzItbEgeq6ZEPrIHa5dWGsCohtEZVHLvYGqeWQwabphxWfwW7K+yyfeIB5zVK7Rz9jmeUx/+peRaEbNVBKoTdwyq21tWj264tV5RkM2qDbmFt+DLR5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311869; c=relaxed/simple;
	bh=UC9qmsDtmii2DsHOAv1oqYnGcnNidJDZ2oeL6cbUyOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTU7Z/KWpmA/6CoBeAYHNhENLwsCtupKa4BMwZHFHEatJoylkLDTR+Jbi48F/8TsbGJPPSnaUNnfCSfr8Wqw4uR88hfQcSevv2+L0PSAGMOzkeee/QjMx5ARk7J1nBfSaxbPZgAjc3MOCNv4/XrcEwu8msqo0HpwEealN+n8dAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IqJrUL7c; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IqJrUL7c"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5AA9440E019E;
	Fri, 17 Jul 2026 18:11:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u8fFbPN4AXBQ; Fri, 17 Jul 2026 18:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784311852; bh=bPmbqf9uyCcKnQQHBZ8qJ6WEarZSzlfc3+zUiESAp+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqJrUL7cP7mIgpNONmTCu4WcE4TxmRVaFAl4dPpyzG+oV0TNzjMUDTrgieox7AbQ0
	 BERvJrvSZK0HWtYOEbcvaH96YVV6j2mVMSozgcdwxNMWH1a39vphGkb98//AXYO3+y
	 zu4Vc1XbDz2CiMLluP0tFABdFhidZpw99WP95WYs67lGgY8Xya+spL7kw4h8KNIDQ7
	 Z8iGse3DNUXlVOj4b61XN+YhlR+gs5Qw1G2f9cSgHRnAou0MJoCEI6C2AoJtBzmaKw
	 nkH+4fv8UqOInOt9toWCHKhYSLC0+58MScyBC3ITb42SMkHykE8oDYd/34I5e0wJbd
	 ZUetXFu9XjWMYtpojw3F1B5xEjX4Rb+asflz6f+Jvizt2fRNotw3Dt8CYOc7TT/kxu
	 uHQCnKviymZrUS+U/L478dk9CKDXl2jzEKgszWaY9y4TF79jDoFt+P1dovW3C1ZEWm
	 i8X6BfckPOqBmKWq4o+B8Ihv6fsAfGhsFqwGAQ4U0Hlg53LJDFoDfGOvjMvIlikhoG
	 mxdbxTqK8+IoL9FbzcA+p8KLtVvMX1LYhF9HgSD/u5t2bIZVEmjzDB0qUzJCXs0kCY
	 qoEpjNMo7X3+jlCLAnsJKndoPJXOHKA3fSgpSgF+DdRZ0nIaTUI7M6ItOwneKTfCDP
	 /3zT5ryLd6YHw269x00DqZc0=
Received: from stx.tnic (unknown [165.204.77.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8ABD040E02B0;
	Fri, 17 Jul 2026 18:10:23 +0000 (UTC)
Date: Fri, 17 Jul 2026 11:10:04 -0700
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/13] mm/kwatch: dynamic hardware watchpoints for
 hunting memory corruption
Message-ID: <20260717181004.GBalpv_MOaAflgFxgh@fat_crate.local>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <91f3486b-3b85-4b43-b099-0a5325643352@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91f3486b-3b85-4b43-b099-0a5325643352@intel.com>

On Fri, Jul 17, 2026 at 06:41:49AM -0700, Dave Hansen wrote:
> On 7/17/26 05:50, Jinchao Wang wrote:
> >  24 files changed, 2115 insertions(+), 63 deletions(-)
> Reading this, I wonder how many kernel debugging features we need. I
> don't even think we have a centralized list of them. They all just live
> in their own silos.
> 
> This one really seems like a super specialized tool. It has to be
> enabled at compile time and specifically aimed at a specific function.
> 
> Maybe this should live off on the side for a while. If folks end up
> actually needing it, they can point their friendly LLM over to its tree.

Right, and in my mbox right under this mail thread there's a

https://lore.kernel.org/all/178429796992.157981.3393977217853767915.stgit@devnote2/

which Masami has been blasting almost every day this week which contains two
of the patches from this set here...

Looks to me like folks need to sit down and agree on strategy first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
