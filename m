Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3637382F07
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710126; cv=none; b=I/KMJr2NE34BpiZyfiLygnJzdRRdjRgxkDHExUN3qC/zJVwIbe9BtV3EtAmcMbFPvDUGgbcweZHUiu/+cNSflMmyQL/ARTCh0/+VrN6E5g7mRhwkCOez3zsNkZFbTw1be2gD+Hn5G/v/UMidZXzEBRjxwcXhb8C9rVG0iUA9Ltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710126; c=relaxed/simple;
	bh=47yOZh0uL9PiUmgaP7WAHRIYSRvyXRhMxAEwOuVsgWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEz0i/sOtyyr3+khdj+CibkIagJ6aYraiZOhTwvUof7AjXx0gOofwiClH1WZNbqeqFvVLEe0w9vAK25aygdT4rZJo/C50yncbfUphKATDbsmGK+KZXihPMU90b0OPZLsnUW4VEqSUfRqe8RxhqyLvNZD56CDBP4bpC/JviUrghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JiOh2sCr; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JiOh2sCr"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-73770fd1b65so401058137.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783710124; x=1784314924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pC/3U7Ftz6dY/QSNTLtw6DNyhuKVUlnEMcNANT8zsUU=;
        b=JiOh2sCrZy8hTvJGHpUZUYAJ4psVFYbcPAYl+AWP7yfeFrFHE/mE+TKI281V0mo0L0
         82BI/RnywUNPlOB6W8b0OYPiCFZ8aTKBQUgJb6f9piNaoYMPvGGWoqdgGHHA2pAhM3C8
         M4TvenvDa7W+6t+UDjETvSw9dUpeFvOpQVBvYy5yHzDtHTrkis0371ckkNgzql+fQe6a
         0OiloUdGqXIlKE2stYLKCiqq/tFERqweZz859LVJ7kT139s793OhzbdyK1jvtlCujSVq
         jQLxlJ9WQYuBejQPJ0W3iaB8TUKtDDpXbMo5d6FRAqAq88FPCUqMoUfgeL1ySdnM4irI
         a3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710124; x=1784314924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pC/3U7Ftz6dY/QSNTLtw6DNyhuKVUlnEMcNANT8zsUU=;
        b=EFaICbZ1MIwG1sifJEKnboH3qON0cJBidJoam1ZFlDfv+Qhnv7LZa+hERlIuqLzI6H
         +dDZb+N49Qnyfo9//J3Dy/Su9/x+KZyRD/Rl2ZigDwgNgg9f6ReQUOITTrwhSYKg/lp1
         c5ibUm6dtFQrxfHI3VE5rdMAudtLRkrCIdm1mPAjuiOeiQlTcnRsliAWL1tJzXoDjD48
         ArUUEqJwPdycXYmLtYkJ4a9xIPVP19shlAgoZXeaDRN2RE2veHPTrN/ww3B86H+aEwBr
         yE0FVOOYVElvkozoLb00PXujkX5iIGb9fyEerZhl+pmVaBiv/5parZrkbRpNw4IBOx7e
         6dQg==
X-Forwarded-Encrypted: i=1; AHgh+RrhRT8OXXy4Jha6J1Fn6yuHSVvbUyckra4ryFYx3NagFeV2dPHHn68HIyQSrd5ymgqvdcZdKe5v/cHOtVVOF4fZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQrgJPd0O4iEa7aNl/w/4zr/Lj42RoqGSNnb7VaJtF16Iy2nJ
	qdIsIFsq0aDPQk7p6CDtoyP2+g5OaCrvZtikzPEI4dZVHPReBliNfMh95Oy1bxoaVu8=
X-Gm-Gg: AfdE7ck/b7IhJeYHLQVc5et+Rq3Mbv3B1pzSnfnoc+3tRv67xWnLFQu4DEeJkUz/Y3Z
	ebdoN2RplbBw9tlz1I15JKi9nbAoDY+y+9anr4DZOM2gOmS1tigBoQ2mXW71ckh/2oKzbIXV9qZ
	fxCixEBs83mNKRuwBsETyutmfGaElj87DVyfpmVlwP8inbU44IDjyfPp1/pUOOHFvx/Vsa8ettm
	wWu3RuXk5HijVFfL8JS7IbMmTEoRkB6aKMC4AP3aUHkxej2nCca+KNB2tADxum7HYLgb0QXBIxr
	gis5UiVCR/2fiI6mShB3ioGx1zAK2MyHHqmpsOBxQC8tKcnSSwHF0fwHoxvI8UGx5mygu70GXLK
	MWrNwMAoNOqIvudWot7Wh66bZEceqTB7LM21a6koKEyjO692J38Tfab8MkpwVrIJn+CEY/v+ha/
	t0xeEeQnykbcxRN32CoyQQ4dGCLaRnDafgsTDXsuYq4qsM6GuFJEYXZ7fizsI1wM29OsRL
X-Received: by 2002:a05:6102:689c:b0:739:5f55:3c3c with SMTP id ada2fe7eead31-74533d66217mr325833137.13.1783710114831;
        Fri, 10 Jul 2026 12:01:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b91sm48074036d6.19.2026.07.10.12.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:01:54 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:01:49 -0400
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
Subject: Re: [PATCH 21/30] mm/vma: add and use vma_[add/sub]_pgoff()
Message-ID: <alFBnZ8RcRN1hlk5@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <794044881e454fd8ac13e59d5ff5fc86fca08b03.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794044881e454fd8ac13e59d5ff5fc86fca08b03.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:32PM +0100, Lorenzo Stoakes wrote:
> Add helpers for adding or subtracting to a VMA's page offset, exposed
> internally for VMA users within mm in mm/vma.h.
> 
> This is to lay the foundations for tracking anonymous page offset for
> MAP_PRIVATE file-backed mappings, where adding and subtracting from this
> value must be reflected in both the file and anonymous offsets.
> 
> These are used on VMA split and downward stack expansion.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

