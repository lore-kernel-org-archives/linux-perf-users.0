Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D245535B62A
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063325; cv=none; b=I3ejEi10QEWFuK4dDzBcDqD1wp2rAD8DAZDtOJxL7YMhHJ/MbV/uQ7ck0Pgw6Lxx8g7WABFQ8NLbLULTZtDrMVdqMs8xv5pbNgCV7uDE9Ze67TwnhM/isalXKUtZRvj092U+Pl88FdsSJF7UrXBzQtj9dP+orU5dKWn88gmCKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063325; c=relaxed/simple;
	bh=X9nVPqu6ICn/GIyufxEXK5wFTDE/TwlyQH0t0LVCqeY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmcIaNxRbKtY6JQcmq5yGJYYENAOFEoLE9zFEF+opJ42k4G0m4PFeAp4VxRT9jlKN0Xi/wMRbdbdzjep6lz4bwWLKaWssVx3zoXc1EntOMCVXsnS7+7d/AdVbFNZn7+9uzhnsgbYQ9jRX6KquhNx0ja6p3bv4711NoF+DX8Nf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fvJ7Z0GPGz1YQpmD;
	Mon, 13 Apr 2026 14:55:06 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fvJ7Y6Qz4z1YQpmD;
	Mon, 13 Apr 2026 14:55:05 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id CB25530004D3;
	Mon, 13 Apr 2026 14:53:11 +0800 (CST)
Received: from SH-HV00110.Hygon.cn (172.19.26.208) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 13 Apr
 2026 14:55:05 +0800
Date: Mon, 13 Apr 2026 14:55:03 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <sashiko@lists.linux.dev>
CC: <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm: use get_i_mmap_root to access the file's i_mmap
Message-ID: <adyTR7vqbBuQTddE@SH-HV00110.Hygon.cn>
References: <20260413062042.804-3-huangsj@hygon.cn>
 <20260413064431.12603C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260413064431.12603C116C6@smtp.kernel.org>
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

On Mon, Apr 13, 2026 at 06:44:30AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Low] Compilation error in mm/nommu.c due to incorrect struct inode member access.
> --
> 
> commit e38eaf1de7eaee855cd4763bac9c006d3d26fa76
> Author: Huang Shijie <huangsj@hygon.cn>
> 
> mm: use get_i_mmap_root to access the file's i_mmap
> 
> This commit introduces get_i_mmap_root() to access the i_mmap interval tree 
> in struct address_space and refactors multiple architectures and subsystems 
> to use this new helper.
> 
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index ed3934bc2de48..418c8c91689df 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> 
> [ ... ]
> 
> > @@ -1804,6 +1804,7 @@ EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> >  int nommu_shrink_inode_mappings(struct inode *inode, size_t size,
> >  				size_t newsize)
> >  {
> > +	struct rb_root_cached *root = get_i_mmap_root(&inode->mapping);
> 
> Does this cause a compilation error for nommu configurations? It looks like
> struct inode uses the member name i_mapping, rather than mapping.
> 
> Also, since i_mapping is a pointer to an address_space, taking its address
> with the & operator passes a pointer-to-pointer, whereas get_i_mmap_root()
> expects a struct address_space *. Could this be updated to use
> get_i_mmap_root(inode->i_mapping) instead?
Yes. thanks for pointing this.

Thanks
Huang Shijie

