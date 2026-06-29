Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD012CDBE
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747622; cv=none; b=Hwl0nuHlxxBrhcNRmzP9oTIXjMwm6AXqzLbR8strBboVT47Y5J6BFCZtqYS98Vmorykmvkwt2PisMTxQu+o6hl/iAlQx3p+7kqFDiHH+5wGr1blZjRcFvtxbMUkxPc/1cQPpXqWtWsaVHPZncidxZHK95ItnopBAkxhA8nPveHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747622; c=relaxed/simple;
	bh=wTZ867cLvl3NEk7csUy7NtkIFljCREofjieQ4f4eY6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzVs6Th0WRQ296ciSwFOevfolpxPOKpfYTSzdfr/f6wkAxg+l9JnkX45Kh0g2p5x0lSpqXQd2NNO7NvlvbxHheyXsux61TOPOgOqBJbbOKyD7eJ9V917VhLNrzbnYNZr26BHwQiNC8uQRWBNzf+QNtZcZtJW8U39IoFRi2St5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rlI/CDK2; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rlI/CDK2"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51a8f5ef23bso23156161cf.2
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782747619; x=1783352419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwgemlAWVZOfyfvrJ+7cyHmQGRLai3JgFnH6EFj5//k=;
        b=rlI/CDK2Me2Etlx0NUkaHtRU+6rVLYVzfsgo3i4Dopx/2QYpJJyxXzwr3cnt/dsnQi
         c7ypbUJWyZrOclOTOo6xuS2x8j6h+YbrMDDzO04dRP/9MZI9xlFOaRleW2eF4FKXc2oP
         1nhfYC3dofYj3kga3Ya0HWk6wBZo++TjajS3+6vEuC8oT/rb69G26r4OCj5ta+x+crBT
         WNhEhQy+v48nJMdFyK8CO3cb5bpxZ08fg57jYe7qPCx9Xcs3739pKT89IDi+3yaD2yCN
         aM+IejLgEjH9gnlRl0fCieJR2PcnGG96QNC64qauIdZ9x6GaO094v5hpKdyg7+5e84iQ
         C+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747619; x=1783352419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwgemlAWVZOfyfvrJ+7cyHmQGRLai3JgFnH6EFj5//k=;
        b=nK13ly837tv+SAvgoXucVDzgPEKREi4m8Kp9os+TBTBn1p9UnVywnLawupr5avbQ1O
         rrzzZ8sD8uvw2IXtcAnc4faba1s3txPtf0hZpMsZzV9v1bo+0IvHgRL6+EBYYCdJiyRV
         e+U66Mg9dQGeiXEJmFZZ4TsmZjYRVqTNG9yxt36OPO0g2EhlnCK1LKElG6rYLtebYR9u
         9hzlhqpQmwLBLyFtIc8RfIbdfpq+5rL4pYZyeWtTkhU/ztk4Mo/w9E86kzPowBDF5uY5
         w6isWuiOqRFA7BuArYnYNHdjv7LWZ78oZZ4mondLOX5/B1A9WgSxejLToF430KvTL7pA
         WhtA==
X-Forwarded-Encrypted: i=1; AFNElJ8oibBh5uWpNEDpTpbm4mH5dbyv101WB7pnQN+mDEZVWy3e2B4TCMk9VCwX4EyU7wj/RYqBHIXdTkX4bfKRNRYY@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJvBW/J068cLtXWq7mEtaaTCL8G6YpnA+PSaPAVm/n/eR4h26
	ouquY9mrnBC+yh4d4wt2RN7gnGTKVWb2ahDrIenLlckyE2R4UUVmaQgPX5hp5t0Yvgg=
X-Gm-Gg: AfdE7cllFnP4FqzUI1l8jGit+LRnqMWtnyMr5yKa1LiCGLEnDHpBTY3bjBop/eZENi+
	pFZ1252mVXHTcNuYDI9A1B3LtA6jgtzfmDYITa/SNp4W1yRJjIicnhpiHEdpSQHLrchDsAU5Viy
	CB+UNdi8SCIJHvp41bHEpoAWCa+Omwea45zHpxvhFxzeuRzi/ELITIBdMSDxY/vqa2/gXfRUXy0
	r6+OjxuMuFarXi/5A7HdA4jQi5zqRaGAXoRACNCYJeHK+6fVbj29VZgwYPwspAyIG/Uf6T40GHd
	rcVlC3gcMXPBtxT28Txl3PIegaR9bplV7gfuePCJ++RXjDR/kgB2KB2AP3/dlieKEXkXpq9rrP7
	3zIGH2Z2lsQCIafhEDj6Kp7nz2mS+Sh43mjXWLBViOfbGIwo6wsPB3fTN3T1QOjbv5lC5fRQzD8
	5la+mVoGpumMPLIN9Ih6jReXqZkoYBPkomcNsg7TmoidKRR8ZtvQ7Dt2upDdeQ3UJkE5Wn
X-Received: by 2002:a05:622a:5987:b0:51b:f635:9aa1 with SMTP id d75a77b69052e-51bf6359eadmr68650541cf.48.1782747619393;
        Mon, 29 Jun 2026 08:40:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a876c888bsm78114501cf.9.2026.06.29.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:40:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:40:13 -0400
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
Subject: Re: [PATCH 03/30] tools/testing/vma: use vma_start_pgoff() in merge
 tests
Message-ID: <akKR3bFV7393yOUs@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b501eca378b9d9734e83838102aadc9276590fba.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b501eca378b9d9734e83838102aadc9276590fba.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:14PM +0100, Lorenzo Stoakes wrote:
> Now we have the vma_start_pgoff() helper, update the merge tests to make
> use of it for consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Question: Should we have primitive tests for vma_*_pgoff() since
the behavior changes depending on file/anon?

Nice to have the cleanup and clarity. Maybe worth asserting no
one ever breaks this.

for this patch though

Reviewed-by: Gregory Price <gourry@gourry.net>
