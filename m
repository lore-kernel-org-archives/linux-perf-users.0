Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56E3E2AB6
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718829; cv=none; b=J1uoTI8ssGLHrIi0TzPJXtDv4oaldRzgI6I80c5S5ZcHUVR4RiLCHhDsq4sGTTG2p+keVaEsGTKv10YMlQeHJWcsCu8qKEDAsPlD0cb9uj/PKNQ3EhBQjpnzcnL/iLwv8j2/SpqQgpxhBe5ToRgS3dl8NX1i1YhL3XgiJGX5OQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718829; c=relaxed/simple;
	bh=WA59mEPQS2KZpz5hwZRIhAuqwWCApokXv9AsxSKOvQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVDhtWstUGe8ZWSvdGDyrqlznz/GbkkfWfnCFQPKwKSCMs9jpOMMqPzHRu5OVf8YGIIh3YKWvJa72cvSsWbPB2hmdx1UFWrCxXn2PHacGPzY6AvT7B11+FZz9D1mdtyeWdcGpgOARh+bpMbSWpS1cfrl76aw/NxGiUkWoYgcXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nhYo0OJh; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nhYo0OJh"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e65e18969so106586985a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 14:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718826; x=1784323626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oXHpiDgBaIEeQKnuJdWSZ8rFz2G2XIdWbRFpuwAJIiw=;
        b=nhYo0OJhcjieVg+GLl0VaGACf2wtApb6p5NFoPYfJ3MFB81Uk0jAT93VGbHD/HYzFx
         x0iIlnHKm+fPHeNvTkVRG+kydtCkqPqdRQjIzjZK4+F6R7+zS4vdg5Eiq37/IA0jTvim
         MWPOtrLGN6TsW5SBj2HQjmjOht63fZLw/WSbMPV+QOplWYLd/Fg26t1gz4Lw6jXPqkEZ
         6jJwsPu8eyupguGAmDz/agVlqsi3IeXJw1+TLWsvJjCKG8m06B26W6DrWPV5AjCUSLRD
         mTxzsXm6lp6swrGkIhY4q6XvE3FhBpZmFy6EutES3L0lQJrwD8S0oXfy7XwNV5XXViRT
         klXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718826; x=1784323626;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXHpiDgBaIEeQKnuJdWSZ8rFz2G2XIdWbRFpuwAJIiw=;
        b=XxxhwE5oToRjl86mD54+bY1Lvf2RFDlfoXGoIR7sFZVSSFuCkb1kLC/g44VFgka53C
         Q6YL8Gjwpg7NvW4abPPoPaRtKO0Sbq3I3mBuCbV0J42fyI+RYLwvt9qJo4Ns64I/S7Nz
         lmZeoh+AYKPv2ObarkIzNzTLOuWZ8dOqUWxu8t0t+x7OW/VzyT0UTW021OO6RjkUYLVm
         OZbrE54CaStfJS0vuWa/C5TD2LBdMPPMZwE2i/99tmI2P/v2yG6ooXwBXCnBQzBVv1ZO
         w6hJhiWoGZcb97GJQXLYlDUeRuY8zvy8RBgq6i8YM7HVYK8f73DA9E4avYxE4cfyaLNo
         ju8A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7dSuoPbj0qFWgS9Dme93rVqIghcCiefJ+hL/GK0M9/xjmvgm0vfnfaY65F68743Sm/fPidS5TU7WzFtpCCwUB@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWCLVQ6h2VPSiph+84OnUuhOLoqrbJeLxZxff6Zq8LnlLxq5O
	1XZNZfiN+VIwQvkF0ZK7MFsLC7FLXoZblcIEtleV+sz6/KWhH4c4/myfi9W6n0pCnVM=
X-Gm-Gg: AfdE7ckPCLvRKzOCLvJxzqS2PcT6suH2xxP36M0aoxrxaXV7ctp1KsVA8F8bxxxxeXr
	rwPECjONsNlNnb6aQM64p0xrQ5VcAvwS+yen1lqfBp9hfm6ncRgliu1KG1+whWIJaiBoxqW4B12
	nnPCGUQ87c90Rba1nwfWWYuu+J5fNHojnCv4eNS8qXFdDurc5of4g726+eg48XFn/L1M6+Ys47c
	M42om/VWScpPzC36C7AugsnOXEBxFKMId5omqy+8MNeCpQD5TP+ntDtg85GyAF/MeazuGwQSH9d
	9GYvtr9BCjHU4C800VAtsoCFuXQPMVPLi1wNGqyMfljd/hkwQu6FSHaog1jYNY1bFUfkOOHAQQU
	ujyNR6QtsenRbB48xULJqev8n3W9FgHZzY7BiRPkddbz5f5OT8ODAcKwCkwrZu4HmHCWEAKfzXf
	flThN9D/Wv1yUn97XSCVZL4KLIyNHOomH0/JU4UKsfJOI28m3ihy5tineicDMziYmQbix0
X-Received: by 2002:a05:620a:4008:b0:92b:856f:3c14 with SMTP id af79cd13be357-92ef3d1792cmr55468485a.11.1783718825767;
        Fri, 10 Jul 2026 14:27:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d2d68bsm289148485a.33.2026.07.10.14.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:27:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:26:59 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
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
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 29/33] mm/vma: introduce and use vma_set_pgoff()
Message-ID: <alFjoytGnkjJs7zR@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-29-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-29-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:10PM +0100, Lorenzo Stoakes wrote:
> In order to lay the foundation for work that permits us to track the
> virtual page offset of MAP_PRIVATE file-backed mappings, we abstract the
> assignment of vma->vm_pgoff to vma_set_pgoff().
> 
> We additionally add a lock check here using the newly introduced
> vma_assert_can_modify(). This asserts the VMA write lock if the VMA is
> attached.
> 
> We also assert that, if this is an anonymous VMA and unfaulted, that its
> (virtual) page offset is equal to the page offset of the VMA's address.
> 
> We must be careful about MAP_PRIVATE-/dev/zero which violates fundamental
> assumptions about anonymous memory, so we check for !vma->vm_file after
> using vma_is_anonymous() which these mappings satisfy.
> 
> Additionally, we only perform the assert if CONFIG_MMU is defined, as nommu
> does not set vma->vm_pgoff = addr >> PAGE_SHIFT. This isn't really relevant
> to rmap as it has no anon rmap (nor needs it), but we must avoid it
> asserting falsely.
> 
> All of this logic is kept in assert_sane_pgoff() to keep things clear.
> 
> In order to maintain correctness given this assert, we also update
> __install_special_mapping() to invoke vma_set_range() after it's set
> vma->vm_ops (which determine whether the VMA is anonymous or not).
> 
> We do not use vma_set_pgoff() in vm_area_init_from(), as at the point of
> forking, we don't necessarily have correct locking state.
> 
> Updating vma_set_range() covers most cases, but in addition to this we also
> update insert_vm_struct(), compat_set_vma_from_desc() and nommu callers.
> 
> We also update vma_add_pgoff() and vma_sub_pgoff() to use vma_set_pgoff().
> 
> While we're here, we drop a BUG_ON() and update insert_vm_struct()'s
> comment to reflect the fact anonymous mappings can be added here.
> 
> Finally, we update the CONFIG_MMU, CONFIG_PER_VMA_LOCK defines in the VMA
> userland tests so IS_ENABLED() will work correctly with them.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

carry-over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>
