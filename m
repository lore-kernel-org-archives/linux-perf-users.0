Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C72BE03B
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711569; cv=none; b=jMeW3ukexIrDadwk00yrepwXemPJZR9+mfAfSERjE6uQ6GwM/E7CWwC9OC7m3qJcro9NTDOpdW8A0YhyOom560yKT4nWQc+aTtZZovqEQOL9tG0678OlWQ69W3SguadOTLLBCxleant/LqKMIGehfrjQWw1RWwiA+USs5gHKDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711569; c=relaxed/simple;
	bh=QOojT1E2vhWM7tSRUHih+fCOI5zTfyzCTjJ63JRhM4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUZDFSz0hkwEN4FKT5v7e7hX2W0rSpWMzJgvUVRNYukF09E0qi68UK2GxrHws596gqOtlTJ4z3wxDcHaeRR6kfzlFEKupkeKglHhhgrcFtCJZashUrX4t3Z4Rd9YXzMC7oMExDZ8sai7TQ5SK8ElVbAmB3hK0GWOHLj9/u6z0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dbm+yKTe; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dbm+yKTe"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e51d3d83cso67182585a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783711565; x=1784316365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHwFumUUjp1dZn3azv3jRxV2z4/4b2Y11BxxEMyANyA=;
        b=dbm+yKTeJMcBsc/CYkcTAQ4TIaGcuSrF3MF8158c1/hSDk31EH/NClDCmOcYl88b3+
         hXK2sJzbsspq3YRmQe/WvOsgPfE3Qzw5eyC/EKH6hSvkj/mG9cOY7C4On4sX5yfxN23N
         IIZT62bWwMkkXTTwstqxKOhh8SSCO4kYe+3dI0dJ/f0zNPLVc0f/SCNfGd7jQQdwLW8y
         BbAHzwTvJM0kOtacFFyDuHKqRY4VG9oFO8eAMNtw/Gb2mSJuYiE890oQvrnVkH2rMIL/
         9/oLWYzMWVDHe+7TRYQoM0jPmN3lg+xFcC9eeEkkAzAAR19IeCxBEu5izY1fuWnQK5w2
         rTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711565; x=1784316365;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHwFumUUjp1dZn3azv3jRxV2z4/4b2Y11BxxEMyANyA=;
        b=PZOnvHovuGCMwO4chVOikHhQ/FWpsvmx/h0/0SMJfzgmdDg4wqa0g7jRdgV3cjxQuY
         yyMHzwyp4630y33FeSoDEbZwCH+S50c+LvgrU9GAeWQpJMFL7yAokiYYwP6VHhU0xu3h
         xkGyNtvtGwdKAGk1sgVC7zqaLTo2GYnda9IiFTi9NUxs1VsfQlBvhfdV1bcHuSKcs2tz
         30Al3WitLyMUd/1RU8iRQ5dKbZZ8NRd5UStayMs2Q+/r/w/zA2FNAvoCBsw/lCmi3aoo
         rRdZkmoP3ENR5TX7sy0U4LACEurnY1VCu0Oj+wbwk7/AHu5LsaGjj52lzMMOI8y2YKwL
         RhLg==
X-Forwarded-Encrypted: i=1; AHgh+RrQuJpgVX7FCQZT2Ln9hy+JAboHn9SiH5RV7M5aqUmc6xl5DSVuzFE+jEt/biD0/W/Y/DAE7+kNnwMLovwS+Pfs@vger.kernel.org
X-Gm-Message-State: AOJu0YwR78tMiyljofrdYuPE3l9ZKVWJMjgx2RTwYzihJRg3y7xGHVQZ
	E2DK+Ox3a2Y1sQyAO2qlFeu0+P8Q4RW9Hl/8j6vI3+brmXWSaBWY2JdDgkb814KZXDU=
X-Gm-Gg: AfdE7clZJTREdgn3ZJFBGiY1ZgaIyUddmhVo4lansob0Gb8ixcdp+sxSxhEzql/relC
	rk9vTzuqqg/KBq7FFq6Twg0ZIWL+5C1WcPAR0MzupunMDzrKRnLWswS53PzcXG/HAFlqgV9+uYl
	i2mwh80kbR1JfxAC3UMANNJ0b24qxc6AMQW1N/BAGIqfLc44hYUjbxC7dpMvE4boV5v+U10tSW3
	qhPpKHDkILg/AZdKjI8/9DHMry1hh5+QawGbTaWg2PD5STbG+NlDaSUI0YPMqSrJjgEncMz6ZHr
	Rcp4Tb/Jh2fw7nE2DzY2VLfqsO5TzwAY+rlDBbEF4cdOqVUivVVPRagqFNWcO+rkSBkm18VxCsv
	uIA59gpk2NmvECI2tqasX7JJ5O4a3xPum67hhwVnK/OMTInbX3WTw/M8RIwAzvvO4aqNG58VUlS
	v2M/zYcsiG0nguRbGsVAeTvnRlaigEbxwOLD7jWQgUrko2P/v8/naT7MtrFHWrNMVBaWRoKKAdW
	/tOEEk=
X-Received: by 2002:a05:620a:2993:b0:915:8502:f7f6 with SMTP id af79cd13be357-92ef2b575e8mr66564685a.35.1783711565033;
        Fri, 10 Jul 2026 12:26:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm265182485a.38.2026.07.10.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:26:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:25:59 -0400
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
Subject: Re: [PATCH 27/30] mm/vma: correct incorrect vma.h inclusion
Message-ID: <alFHR3fg8K1-SITK@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:38PM +0100, Lorenzo Stoakes wrote:
> The only files which should be including vma.h are the implementation files
> for the core VMA logic - vma.c, vma_init.c, and vma_exec.c.
> 
> This is in order to allow for userland testing of core VMA logic. In this
> cases, vma_internal.h and vma.h are included, providing both the
> dependencies upon which the core VMA logic requires and its declarations.
> 
> Userland testable VMA logic is achieved by having separate vma_internal.h
> implementations for userland and kernel.
> 
> Callers other than the core VMA implementation should include internal.h
> instead. This header does not need to include vma_internal.h as it only
> contains the vma.h declarations, for which the includes already present
> suffice.
> 
> Update code to reflect this, update comments to reflect the fact there are
> 3 VMA implementation files and document things more clearly.
> 
> While we're here, slightly improve the language of the comment describing
> vma_exec.c.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */
...
> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */
...
> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */

Do you actually need 3 copies of this comment or just one copy in
vma_internal.h?
