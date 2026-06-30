Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD394657CC
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834415; cv=none; b=h8kjkhG7FVZQ3TUCabrsk9JhGGECBOrIOkN11D3Tvfy5BUiR2ncQvA+b1G0ifIQwFuDnUtAGpjFj5JSSM1CY1ipgORJUi4HVjma4/b2Ug92mMQrYWcV2fBTzoGRLtd+OjcC+zjQXgDWnuPWRpBDkJI0C76IP+wBCADKu/c65OfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834415; c=relaxed/simple;
	bh=dDmXL5XwXaYV+8+puY+mAXsJDpis0aF3tebQ04m+2HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/Q9iOzO8tccuHYYy+KSPPXRRYoyHFDMwFjOXVAXe1Ujxo6Q31/m9Phyzp8U37lcsbbTGDrvjj1FrHor9JmKpcJTtxZrZC7kCcBqt6MHo2YQtpa0ikJJnSQROzl0moB8jckHDcXpe/BubBaMRNzcPqQHPtg7gAmFmTaM8N0WU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=vDUgBP8D; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="vDUgBP8D"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e65e18969so87969985a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782834412; x=1783439212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3V1BQpPjw58FUuLj010lwChkcBGTpKii5KT4CVPULY=;
        b=vDUgBP8DSx3vav8BjJqPGsXsvPB3didQ/5jzaChUmCxi3DxsAfKWPAk5Pj4i9ciiZK
         gnS6f1JSsry5+xa1W76dJ0jOwDjXQBqpJ9D2KltXzw0CVFROF6zoZkpLu2y8xe8eZWJz
         lF9FPyA9sA7EDl7L39UlzMn24nQCENSz5s3ctgtoSQICOcj6zdJWPMfzL75AaBLoH28y
         6xm4rwSp3HbvuQu/pMTID5HZWQsaMBx93pxeF2wECsXSF61m5NEgiqCjZ58g9XZlcEm/
         kQE8xXs1T5IOepP6GiwqZaBEXHdL2pxmwPzwFOAlbbQrLipTQZU50SDPh8Fk2Qku94VZ
         8rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834412; x=1783439212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3V1BQpPjw58FUuLj010lwChkcBGTpKii5KT4CVPULY=;
        b=b7LxxnxPBkseh2axBm0RE/jMCfymtC71KFMlrlls1kmXSPdeXs+Jj69glAePP/qjA0
         VWiPV0NAlR67EH38jap37Z4Knlad4ofEnzWRwsKRLskEeQ+uV3R4QjDf7Z8zLF6HxK30
         q1aexLTE0YpCxgWDczU2MYFTIuykWYvh5U7te0K2RtRcM6Z4qLjo7yxQke8Fm4mzRtGu
         CjWXOV9GxSZ+igUwCdHgwIG+a78lfO/3/YeXnJ1Q21+pxrplmm25j+65dbmep1XF84Za
         0Qs2z+67dyirvZVyOg5tfN0+N1QmjvtM7ALlv4lgecR0hzelBu8eWFH13q/lYp7eSysv
         jjeg==
X-Forwarded-Encrypted: i=1; AFNElJ8N+DGtD4T1GaKUtzTObKcau4dO+UlqtIdajUoSz3aoKYmFU62jxtLV3hbiCZd2nEahjed4eUxjHrxxkQzAuFTa@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrMeWT079uZk/rq/QKI7QEBPDckJnqMwkbqw1ZZrnB6RfbsnR
	savVQNwJW3wOzVLn57tSygoT1dnelhP3V3ZuRnDi/u5FULxtGvbLytoL2Mbnf1Tj9I0=
X-Gm-Gg: AfdE7ckSbT92+eYEV94NLa6MZeR8q4Qm3bjkmm/VK4haJC67v0psCWL29XzRYXzJ1VF
	D9Ci1M1paDzf2P0vwmb/co+rW8/NojTY+70r03/6g2u7weY+AxUR3IsMYnTBHFJAn0FygOH/ZU5
	JdIw+vbufG8/aSKsvpdf/fVnBFCeTNUlw+WM36bBiwqqUD5l66IWcUXD7+MJiATdoNfxWTOQaqU
	62mHOzysndJEUhjY/bjbyEyeO1GgiotrOCyWJBSzU4Wxw9UYbGEe7wTVmD9eBLFOesHO3Y8JJhr
	U1SKi2QRWdrxGXwrDXGV6+E2edCX1wuNgX4fbwp5U9l543zPJtpHAzo+bvZkZKBcGxxQOp9H7wl
	2pB+iQFEaseCIXcCwExMogGejThOE5GoEFN+Z3PBzeUe2nIk2RFmd+Zc2VTPvn9DsbrKiEgLR0U
	N4w8qCCfbyD17X8l4hXtvcbwxvCkWcqtrbZa/QMtdyk7YV4cnsdbKdoWMwvVNQahfKNOO0
X-Received: by 2002:a05:620a:2913:b0:915:a47c:f721 with SMTP id af79cd13be357-92e6974d636mr316697685a.21.1782834412151;
        Tue, 30 Jun 2026 08:46:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6233a5acsm267797785a.35.2026.06.30.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:46:51 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:46:46 -0400
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
Subject: Re: [PATCH 09/30] mm/rmap: parameterise anon_vma_interval_tree_*()
 by anon_vma
Message-ID: <akPk5o_gHD1SxX_0@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <1c1df7b905ef340cbf2effef769a4e770a8e0eb1.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1df7b905ef340cbf2effef769a4e770a8e0eb1.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:20PM +0100, Lorenzo Stoakes wrote:
> Similar to what we did with mapping_interval_tree*(), let's declare
> anon_vma_interval_tree*() in terms of anon_vma rather than rb_root_cached.
> 
> In each case the rb tree referenced is &anon_vma->rb_root, so just pass
> anon_vma and the functions can figure this out themselves.
> 
> Additionally, rename 'node' to 'avc', 'index' to 'pgoff_start', and 'last'
> to 'pgoff_last' to make clear what is being passed.
>

would it be possible to split the pure rename changes out from the
changed function declarations?  It's hard to pick out this as something
that needs to be looked at as more than just a %s/x/y/

> +void anon_vma_interval_tree_insert(struct anon_vma_chain *avc,
> +				   struct anon_vma *anon_vma)
...
> -	__anon_vma_interval_tree_insert(node, root);
> +	__anon_vma_interval_tree_insert(avc, &anon_vma->rb_root);

an annoying request, sorry

~Gregory
