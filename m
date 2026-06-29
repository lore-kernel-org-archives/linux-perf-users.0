Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685223E6DE8
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747080; cv=none; b=gkUpCEVdTHOOOyPnbyp/IsqPt1UdDukuD7Mi8VEVQ1b9tB3yXzUGCxp9BceX0c+BaNs5dR58SLIoDhAVxnGPsjhJITFVLtmiit3e2LhyNcKCcHvdAVIPrrrBA5Fm48rgb7p98BNwRac0ahTXPjQbOfhO37PiJ848OD5qK8Qkslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747080; c=relaxed/simple;
	bh=eSLebA2K6K0JqwA20gSpIaLBxceDZU1DyvE+HEyhHoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmSr0KxdSJiC4qLf8uFC4EAf3vEa+eD+iDa4oxCkILUrXKvRWLCGnaTDzhcQqzN8IlVXtpg0WLFnl7vj1YiImUvm0xWBpf+FDWoLHNZ6WJWXqDCw4C8L+nKm7mVEAO8Vwnq7Q3BR9foPfSSw2oVyF7PTdPxfiTZg0eC0bqsA/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WCLcnhWp; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WCLcnhWp"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6a145935764so1133593eaf.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782747077; x=1783351877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtnRVAeDbe2jCD/DHkmGFKsvQqrt7nLFRBhYCay7qN4=;
        b=WCLcnhWpf7I8vxLvaDK13rqwV768hOMWQx3Cs32tapStGxKFc5PSkHyyxm/qd0f6um
         hu9z6uLVCdwWPfSVWBd2TJUc6UfaxIlfe8FZ9RXCykQLTO2692OQNDVBnsKuM4B1JJQE
         6W/lhFZSfUONNP1pQhwFgEsnZv/pL5LkqssPv9R8nifaUbtdHTpvu6P81zd5uRAqhz+c
         6B6CjwGuwLBmIMMYDBuGLnuU8LUKUrHil+Rlw1R8kg9Z35oW+08106oj/zjCblQvsZI1
         dvZcq8/m69vYHm+wc665i4ljxxQU5aew6njTJlPlnMt56WjzD8bl0Lc2nGD3S5+wFILM
         8IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747077; x=1783351877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtnRVAeDbe2jCD/DHkmGFKsvQqrt7nLFRBhYCay7qN4=;
        b=qzVsW49sfupoGgNnG3lVGuBGD0rCifNnOxFpJ/ZpQvrC7rOkA5YwRIYc8ZPHaYRV4v
         FjSxNWWVxqtvu8gkIALK/TN6yFW4hPlQZY2LhurepEhTeu79jKuZGBJ9p4aSrSTHxnNt
         UcqWymMWh2G2f9mCKX+043AId5peWT+ua2/ZkEhT8BygouKean8fh3aBQOXF6AgJi0Vu
         2rj7HlEcaxZrnhpCWlOAt41S1NoDhRHWnRJKIHqksr8zP6BhsPKitxCfnWqJqLglJokJ
         kVrQvzRnee6i8aK+KI6/F59M5Al9m+fow07T4+xa3NMaqgT4qwA2DgVLy8fF47yGpKgo
         87zw==
X-Forwarded-Encrypted: i=1; AFNElJ9Y9efZbBS9k0MtEcZaEJrdsULHsrhqsKr+sPTTV93XaLgDp6ykz367wOJ5o8B+uwZOjcJJU9BFYRZXXadb+74i@vger.kernel.org
X-Gm-Message-State: AOJu0YxZAnpaaQJwAfWy7EnPtRGEtF29LvIr/RZe+vUlAxEP63rtm25E
	uXRnBzv81eoBCzhfWvpCg6y4idTB3lYC4g0Lf0xRu08gzp0WSei/RnOwA4lt+cJCNlU=
X-Gm-Gg: AfdE7clDnI5g5HUQkz8jnBAjkcmPU2UxT/Gg20ePy2XkKQK5pPfDs2BghfOdRfMUfbA
	t/8+aP+W+O3rbWjiuSqZA7q5QqtB1mNAEfHcPD2PjhoJbGRQ9YvFG6QFHlKdSnUY0LTAbwbpZAf
	ZyDZrgjKXEhT4bpZIVTkoVwEQpjEK0BkEn1WUSuFd+p8n5tWYUx+94Y6FJpoF8GCi0vevFj5hL8
	qHMZiJWXTyEAB2wdFJsTTSrhUcrWU3Z0BbXcfdn/naAC3El6B5ar5eCGqnyLzhDRVpGL7pdAqRS
	EZgh22NRIi1E/fiwxTCzvhY9M5C8CFvm4hhsfx95cGVCfXTWmqhqEp1CfOFzRkC7NgGMqmcyPo8
	DoC9h7R5tjulcRzPcdlmx7RRE3tr2xutZSIWw3qgjb6iwvSB+aZVvBl50tchTVEyTkMkHvRr6Y3
	lqM4rqanp6vebO2/aN6Q3OfpCTZHBPVn4Lv7nc/I5+dlvgmLg4jDnKFhpKiPI1G+PmQxC8TKGNp
	wELRx0=
X-Received: by 2002:a4a:e914:0:b0:6a1:524b:1f5 with SMTP id 006d021491bc7-6a1891b6f09mr98038eaf.42.1782747077395;
        Mon, 29 Jun 2026 08:31:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6213b95esm9184285a.5.2026.06.29.08.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:31:16 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:31:11 -0400
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
Subject: Re: [PATCH 02/30] mm: add kdoc comments for vma_start/last_pgoff()
Message-ID: <akKPvwYs-4TwYwKO@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <8c618dfd7de419e3b797b8bd1cd921d4c5b8878b.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c618dfd7de419e3b797b8bd1cd921d4c5b8878b.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:13PM +0100, Lorenzo Stoakes wrote:
> Describe what vma_start_pgoff() and vma_last_pgoff() actually provide in
> detail.
> 
> This is in order that we can differentiate this between functions that will
> be added in a subsequent patch which provide a different page offset.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

