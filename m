Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C43B2D10
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717936; cv=none; b=aaV58Grl7kx8I3o0I1Rix56BQmezICRaYYot/ACGZO+g77Ez4DcEORmNk1qdgH4mLVGYdYFrBDHcYyTrJDYZyYjjCxW9lcZjrLS39FD8TaqVa8bBpL+WoGBMy7n3y1i9JnLLP5ULJch+ei2Yflyoo4zTGY4Q0I5KKREjEsc0X9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717936; c=relaxed/simple;
	bh=dQzz6EcSb1LSSq/sqBlPjvInRxBfU2sSme6h83vG2JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhmltqsPQkUbxlXno1aBDY2mVPBoT27WGuzbV28wLtWV9saPgDoRK91FxQdpvLq54vN8GKQMkN2K/adJkJJXiOP3ifIEYIkEcGQIrMhG+Ln1OJxY00M/nSSTYJX6DbyFkwZTC67pYeitdxySgml7BqQtrX3zZVmm393+yidgYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N6b3TpOC; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="N6b3TpOC"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92eafc94c9cso72490385a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783717933; x=1784322733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pf2tO4nh1364RXnPDWacirAQrZ5x9Oo1qInEIWqsetg=;
        b=N6b3TpOChbThE/0tnzlpa/NcQ77linH1Asj8qwSU78EqKBP12VBXntR0fMIMQZhHCE
         HZsGMjq2u8g+tFr+cwRu+FocceXiNd3NXVLDbCG47ArWUfK5sMgnZM3WSRtijImszrzy
         ix93JWAbrEvs3fLJMXDCQWb8tNF1ApzaiJIpTnhfn4OR1IOgw/BszN6U3xQcUymM+kjr
         t5kTbQS1KsELCKqZveY/qWqnzxkK/PZpdR4SCuYayerSDb8YhGP8QfBxiEZiiI2omI/x
         zyOQOL4QfuBf46cb4VBcagyWJxhD5mWeEB9N8gBL+pMOrdGSg5FOUePloLptjP3p+Rrh
         Zo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783717933; x=1784322733;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pf2tO4nh1364RXnPDWacirAQrZ5x9Oo1qInEIWqsetg=;
        b=QNcr2ePNf+gbrkIpyhn9n6FwQlinVHEbqSF5yj1e2KH/mCP/YA/llZii4c0Hc6e8I8
         W+h3N6qTjzjnGSYXkwt9auDNZMqf3VZ85IWl1+HHqmpRLH+e3fHSfiVFVdgngi/IdvsO
         W4ic54CJP768mMzWe6GCKFEpPfkWFsSGY0I+mWb38RYCKRMJztVsMkLPhPt93Y/blQjS
         gkN8zGRuEsC9uLzg+JgRQ5f1lSDtFopHiB/papCnuZumLdTFNUFOJSyQ0XfJ1mjMLyu9
         esIRadUP0H8B3Qrm0lnxYoo//eSxbksu9Q3QhG3OGGaVXeFInkCXUMk7CJZA27nY4kDu
         MLnA==
X-Forwarded-Encrypted: i=1; AHgh+RpRIU6TtmuBKXLZURwJsneXrbPmCad9WDLcXwccZs34Q7S1djbt0whEW5+ixYssGBDkJ6mxgm9HicsVJ1gexbrI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vIRKAhZ5nCUPLarlJADspPZjjZztYLV8wKDM7WOcBCTHk2r1
	tsTw3SMKAJueBHu+x0ZWABCAN3+ZGkubOtJhpkbw54+lkn+IpdzDU6eEvZnIVPsEfDY=
X-Gm-Gg: AfdE7ckYSH6+lUiXw1CFUFaTAXGiHHmcF0W+3SOl4F62ZqW/MYbT7WLA3czJUZgTr7W
	vzHBvMR/Ltec9smid8f6fyEXqKtIjPhJ4MDcIuaalaWa1h9HMHE0lj0sVHE8pRXfg8bpPUfxndz
	vDjFXIcMNQhXyg5LsBmV9yIZzJ/rBAnnkdBAfAMHxax4zipUW8WX2viEq3EH1G1aaAUuC3ELMDz
	lDakttYXSTOSgJTyQ+QPAg9BLx+syU81ikfeKrshT5gZNGB+MeiT604JZEtQV2O47Z5rAiz2X1x
	16iUDFlMQB3mENyYRXewNWhMRec3XZrTbw++vcywxko3o0o4Rxe5f+nmdM+uJ+UbVAROaEKu8n5
	D07a4NwZn1iG6NjDQCBWsXy/KSWPmO2rt+z+uaTYGfIYPLoyA2djVbhghT+8bzP5fKr1q6fZGfX
	X+Wnhv5v6R9q7/pWZDOhzr+PCOe3ca2A1C0ytudr3JL2zmM/dbCf402vG+nXDXK3EKLkdx
X-Received: by 2002:a05:620a:1a24:b0:92e:7c7e:9c9a with SMTP id af79cd13be357-92ef2b32433mr108915185a.31.1783717933240;
        Fri, 10 Jul 2026 14:12:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfcb0dsm290194785a.25.2026.07.10.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:12:12 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:12:07 -0400
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
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 09/33] mm/rmap: parameterise
 anon_vma_interval_tree_*() by anon_vma
Message-ID: <alFgFakGEcg6hO6E@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-9-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-9-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:16:50PM +0100, Lorenzo Stoakes wrote:
> Similar to what we did with mapping_rmap_tree*(), let's declare
> anon_vma_interval_tree*() in terms of anon_vma rather than rb_root_cached.
> 
> In each case the rb tree referenced is &anon_vma->rb_root, so just pass
> anon_vma and the functions can figure this out themselves.
> 
> Also update the VMA userland tests to reflect the change.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

