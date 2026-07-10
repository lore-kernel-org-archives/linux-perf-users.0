Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69738F233
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717451; cv=none; b=XDoIFM1DFXqicssmEbSQZL6zO0GD5gab49b2ixpvXewn+1uTvYJ/XbtBQ3yHGsEqPIHN7ozH39AOnOdt0/5KSTdui83eJVztxuOAUiMi1sH1dmpb56NvDCEkisiK4/VLVdtXTlFnk7sId8nPOkq7LKzNGlk0IpAkicsiVGH34vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717451; c=relaxed/simple;
	bh=2Gu7794NM37tAeRC1T+cOMES75vIKzE7urqHPy3L3qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfZXvrfhnTcecaev6hSqvrixCgaDJbmoy1xoDD5NUkdNQabuEdI9kNqmFb2Ol0JH57mD9eZInJn2Vtw3SWADFRd1OsGQsKpHlruaLRm3ZysvPwExATIEBM5sEMFXwwE8fvmrrqkOEpvHXjP9QQiBTw6UTToiqkTNB1SyV34Q1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lBvWm80Z; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lBvWm80Z"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efb708b1a0so12023966d6.3
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783717449; x=1784322249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OhI7UcJVN9EaMSo9cM31eWAmb7Tf3pcvHFHtAkV4RLE=;
        b=lBvWm80ZKrpTlXiNp4GEU8sSXeFn0kDDZQsu2kQPU4ELlyE7sUch+ixBiculQRIBz6
         98fjNmbZfXcFA9lqohtHnytU20+56W0Y0pRnyFEi5duqJC2z7q4V64zBnN+QHrVrCGL/
         ukYi7TBLxnTlEDT2OjhVX9PuNocoIcSUqS3milrwenYSGffD1w1JWzaJOIzclL8U6Xaf
         42xPz1rCkL0UCS0CG+J6mpHa/XN0ghBpRKTvxK4C2AczrPrbcJx1ST9zzif5afW2RjUF
         iKfd7HbuvG4A9s2E0lFjqnktiJ0+YfW3NIMgX+1saKzKJNEB6B6PDL2MDYZYfMHG/d8G
         o6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783717449; x=1784322249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhI7UcJVN9EaMSo9cM31eWAmb7Tf3pcvHFHtAkV4RLE=;
        b=JdjwTg9W4+8XHcIWKCnfoc65rVL1SmX1CQiGB+3hkFFdunM+Mxmm/3JYFKYE3OKWAD
         lEpxKdxWsHAsotOZvywpSevAMhxLSaEeYPQ0ppdybN36wBKSZnnmiuAtNO04e6NFys4Y
         hXkuZvaDnowZX6e1LfCQQFx8exLnIlfdh2aGF6JJ9/1GbAXIkq/kXDbbRAieUSk/1Q2p
         vwovNuOU/1JFf6qkg9+bosiOJroEPYtFzYdoHCNeMdYkiGKBZSd3Y/Bw4aohM5By/0os
         CR/1eFxyMrb3z/8kOqjFs6wv9aVuNcJzMnFAbhh3cVzlr2VEoY7KIrbCbuccsYNshc9w
         GMZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0WRBj+DtTJ5tZpJYcliVdPbrum1ZApKq8iCSnVZhfvnLQsePklFK+6jum0y6vj7RUN9MClpkeRFuuhgoB2C6j@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhdew0SQevUnAl5tCqwB8B8CFWRHcgI+p/izKiv5UWxOxpdty
	rrpxp24iBkDBXXw9AenowsS6gRtB404iojpilTQi20V+oLhzy3xLROgrKZ/hPMi4V+I=
X-Gm-Gg: AfdE7cnSMiuMleTixSJPL+a5hwjL45BbAaZdbd38h9sdibGBwv0Fj3kBveAgqgNxXyW
	4b+14N/yj1y14EQL21T6eRsXn4BVWBxMjRv8zTtUA6CKjuMgCagNtkCu61kxBXq1LahUfFmgYbV
	bacu8NsfTG0BYfL8D8gut0JDvvkKL375fXwlo9bju2KKs9Rx+MvNTveW2qJzW9vVG2/cK0WKVJs
	g5mlzTE9ETUL5hY8WNTDsxKpn+cCM62SljfiJ85+9oR/2iOmM9sedbVaKgDUabaOVNuNZKdaFPg
	PDzcxHs3p5EVmKcOy9AkGNIaafltFMpjLBwm+8+ZCWShktKeFUWLgp6DOqMbUnDoVxxuWju1Fny
	6MH8bUpjLvsjNU75F1jjTIzYaObR0x1Sadn7sZ6chyDCLaJQ9t+CKPIGtGygyXloR7+232vBVut
	BE0U3Z53v6eL04ylaPA+AIAnLR1e3f7+qJccU5Ud7z6ogvRN8KOuwahwAXtRkTPT7ouj9+
X-Received: by 2002:a05:6214:3bc7:b0:8ea:10f8:ae87 with SMTP id 6a1803df08f44-903fe450f77mr10485176d6.11.1783717444207;
        Fri, 10 Jul 2026 14:04:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50df5e2sm50655596d6.4.2026.07.10.14.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:04:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:03:58 -0400
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
Message-ID: <alFePgFUR52GgBS7@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>
 <alFHR3fg8K1-SITK@gourry-fedora-PF4VCD3F>
 <alFJUfaGHVnKd-Nb@lucifer>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alFJUfaGHVnKd-Nb@lucifer>

On Fri, Jul 10, 2026 at 08:35:43PM +0100, Lorenzo Stoakes wrote:
> >
> > Do you actually need 3 copies of this comment or just one copy in
> > vma_internal.h?
> 
> I'd rather have it at a glance, it's a bit silly but C headers are silly :P
> 
> BTW you're kinda racing against time here as I'm on the verge of sending v2
> :P

:[ i don't refresh my inbox when i get hyperfocused and now i am sad
