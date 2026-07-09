Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2A38B12B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612639; cv=none; b=nYlBPWc/DcNJK4v57dcKlFVrKDOTRnSb5ZmwqiI0VsOvWTLzpzjA8qiv4ruwH25IgwyO6VBvrOZ2udG08yAJz52KdCbP3PKF7mCtEonkat4s6ZOlipsGoOxrxFIldTm7wFGKnqcxL/gDmx9fsj7oyiNpe7o6TgMTkU4usOlotmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612639; c=relaxed/simple;
	bh=zOqJj5IGDkUHkuE0A0VjkQNttgCPQIdWlZYAcSbicnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqywsLQGB01ctpOSHBmkg+nzvXhtp39CNwDI8g5CyOGNrayYh2i31zBuTYujdNe9AngF+FtCYuktZaV2/yX40PDCLZSuEa9rEkp9ZmfVvxaStK+bo11q46Exb7gFl1AzbS0rD+RDe/7j3MM1/SdJ4q5KYMiMzvhMtHcQJuMlKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JaiPRMxW; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JaiPRMxW"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8eff5ce3b95so365056d6.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783612635; x=1784217435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T5BtG8ZZnILhla7gs7f63UlRSUpFIkMkPS04TXxov0k=;
        b=JaiPRMxWcQcvwomxKrNgkR+V+GW/eBHpnGZNau6MH5y450xJl98VMTJJHAF9jRsuXC
         Xt7mR7KeawTZPVnKboCCSGbsxow5a2PgFeiSY8/XWddVDWFrEWmFXtO5W/Dl0nrr5olU
         FHib07hylrfhwz/tO61AsseU9KRqyHxGgKPeBcjHWB/NVjmWrN59d0H3M1NQXERgA5Mw
         SBvOCnVFfjsbezQ1DAbcIXDOTZgXYgBqCjS4/QI1RF06UoQPY6hmEkM7zoDzdAY2dn+j
         Mu9hGDFmirDa4O7n5AJQfExMa5HZRVOJt/+stBKx4vf5W+gioGtJL2bg1Fid5qnDWQi0
         ldYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612635; x=1784217435;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T5BtG8ZZnILhla7gs7f63UlRSUpFIkMkPS04TXxov0k=;
        b=l3xr+0vQr9kv9pV+9gfFnzo2lBIyp4/xvxChYmZst7s4qyIxoyYq9yLvghtMkecGJs
         c9lk7+jlfjLqDhdY2XJ9Z8bwgFZ/NjJwTA2AXjqxFtkyICpeajITHAq5vNNb2fs6iuRM
         B3CDFDGDCwZfJcMvv3J5DxADb5LVHkfkb7uqsBJ65MsRYsOUniAC9H2/BaynzYSKx/or
         +S4tWL3GPcWHAeD3Rw8A89H9SXfWWYUTXgvyKW9PBBBbMb6G0IDwgOjq41mteHBJ5rGP
         7lLVDyhjOtSHtzJUBDRhf7IJGCNWJOLPNKDgK6jxv8t+5HgURdrgb18OnToHtnz9SySZ
         jlqA==
X-Forwarded-Encrypted: i=1; AHgh+Rrxh+TIT7BxaeIoXhhiq/M2t6H6Zx3BFBbkXnjVBWwDT3rOBjpjJag+jqnVHBrwZZAdNJMbufsXNwqq/vLcnsXG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+q/BPVs24FMdbtEDtCSBbKuaWa9XNZDn32K9q3JNjJFhKrDad
	kqWDnQn+m3gPCBuJr5DIMrZXLg4cZoNgYFR5aY2n1SaR2VCeZ3dPvhAfIewZ/HGcEJI=
X-Gm-Gg: AfdE7cnXyMEWKtjcVgszn7s3uvhpsYdN9QEcWlSok5VuTdn0SHMXMbY0UXaRQRud/D6
	2aSqVHqdkNsVlQfY251x8uHfwsTIMm2ClJBF0Hp6CpRceutcoTcJr6G4vGl1cw6zuMqctvb2dM+
	tDNxoavaO4pJFSwQHjKA5hqiOxR/A/696c2BHeFwAGAGqZ5Y9ikSIkfh1oqvL1f0MgI/QlOth5L
	CI7tpXF3aOlh7XbR9nuxuDsKzpK5jUrET5oCTmw0HHSL1SZW6NnwCTzfhbykS4lPTH8jZ8EKicN
	6LVOEGqBY/fbxXOh2DtIqv4/cbcJJhx8/xJT7GuxbzXZH2UGB7siPwov0tv2dt1y76JHQ6gpGhq
	E5G+8KLPdLExwJ3V7rd4erYQTrpR3lAcEAc39GVTK63x1fsFoEGAX2mKS1Nb4bE+Cqh+7KLyOcB
	Ud6x5LxKyRj6se7OiOrREGQaKwZ+A/bHXb4bQg2Cq3D8ABxt0Oz4M0+96J2e7w9Mii6kHcLSzGV
	yaC4v0=
X-Received: by 2002:a05:6214:2aa6:b0:8f3:e0ce:6119 with SMTP id 6a1803df08f44-8fec0ead52amr91789316d6.21.1783612635560;
        Thu, 09 Jul 2026 08:57:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd86d43e2sm20317526d6.43.2026.07.09.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:57:15 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:57:09 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 19/30] mm: use linear_page_[index, delta]() consistently
Message-ID: <ak_E1Y-D2Twykusr@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
 <ak_EivwcDDdn1Xvp@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak_EivwcDDdn1Xvp@gourry-fedora-PF4VCD3F>

On Thu, Jul 09, 2026 at 11:55:54AM -0400, Gregory Price wrote:
> > @@ -2462,7 +2463,7 @@ static int comedi_vm_access(struct vm_area_struct *vma, unsigned long addr,
> >  {
> >  	struct comedi_buf_map *bm = vma->vm_private_data;
> >  	unsigned long offset =
> > -	    addr - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
> > +	    addr - vma->vm_start + (vma_start_pgoff(vma) << PAGE_SHIFT);
> >  
> 
> Obviously correct, but was this intended for a different patch?
> 
> ~Gregory

bleh already caught, sorry for the noise :]
