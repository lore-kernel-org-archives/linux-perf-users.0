Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEBA3D3307
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066598; cv=none; b=iv9b2lwKpp9o0uIKpAWMz4Nwcsg94dGUkVwff9Rbsuq0KROzCAkO8n8QpglTauuboTxslvYXd4PbePtKfpqhK/nymZuUV4d70SSgpv8GQbaF+O3eVhoDSZf4MYrJJqqGszhlVUsPpICbDkX9CKmbhc2M34a0R+6K6sER4HDvZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066598; c=relaxed/simple;
	bh=qGkfUw0cAuRi50whdAw9tYXjFfsurpxdwyuHiMRzvHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnZeIH5jInyMWqoyZGhlhc2qOWTQPnBSgkYhaBp4RqOqhvKR2e5F9y/5YjJ+2DPbSfFHwD5Ppk/Tw9urUtyL1cDJ0rssDmUVnfmf+EJ1dj6eQSz2VOYs5rAUhIF95ORTbi6amHxMZSEgKCiBOV6ilZgS6EnxTxmYcmEK/paa01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ihyQWMnv; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ihyQWMnv"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd759f502dso233247285a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773066596; x=1773671396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bCgFz4UpYVbBeKSYmRS1UHS00xtZH8a/t+DzU0dS+U=;
        b=ihyQWMnvVuXvR909Z1cWQbCW/x6Uje2bNeYH28gk0StuBuzAOqigvjL7w1dE9RCBvz
         ZoZwM7cx4GGinybPk7GhMgYWs8ydFH/+Jkrso2JRthaffI2Zbp5XMm+3eSXkDs8OrWPp
         1PdirPb87UjX0oH7606aIZq+oaAGP7vKybDN2bYMkprfF7k83xhQjnzcnPUik0YOPAdr
         2/KizCv3zVMKKDWmAMInYE8tZ68AN+LVOAzGdtD0I5zgKs6YmQZljOhOH1YH4QRwNHq0
         ro70VHn1/JFY0xIEfw2/X2a1ANbJoQ6e9TuLfleRF6ybM460qzLn7jf0fGZVrlG5Po2P
         lTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066596; x=1773671396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bCgFz4UpYVbBeKSYmRS1UHS00xtZH8a/t+DzU0dS+U=;
        b=QU5HdJJewbOiIEEM6abbIumrMzbrI3FV6JmqzjcBVMzsr1uQM5tCNDcAGo0lAD3Akw
         svBT3Pxo7mMNSe+8y7THoi8+68qvRL58D35dXi749aVLaR6543ksIndXsHTbw9vbyPTq
         F14tpKFjE775xBwWVZR40MHY37jMvIIkVlgvsKKukTtWe2l2WHkWmRW6AecLnJ+j0Czc
         lPgA8G4NisMPxd7f2GOmZjf85RmX49PU/HO9c4adNT5Q7/ELgUlDfDSLpNxweIPci0hc
         UYPSctLIOKDkZqbXtoITYQR/zi4FHTljtMO5WOEE0iQKVOVVNiPsh0aWt+KAQgkcfTqq
         Silw==
X-Forwarded-Encrypted: i=1; AJvYcCUgGGTIti6EOXwIcLqei2WcaYB4OYpy0Act6kdVcm4k4HQifaAt6wqVPQhxxCxS5kh1LV/aeu0hlKePpcUwpYb4@vger.kernel.org
X-Gm-Message-State: AOJu0YxifWn5JF1lCBZ4OeLkHYewXKc0eRvSIGbBM0N3PwtUWTbn3NCk
	20PzWOR+D5ot69uRIL14NiLEQMyAibpIpVJpUl9Jamar/Slsx6N5PvmEn7D+fmJSf08=
X-Gm-Gg: ATEYQzzR4hm3rOfkukCu4LvFkPg7S4oEC1aSgqqpz9sr1mB3kxFantU0dMBYDg5Vmsm
	5e5NQyM0ZdAfonE2fB1ZsCYJ6px9lBn6ypOdNrInZ43COP29dR+iljWFZBASGS7W+MblWAn1Hzn
	PLWKG/HpN9Jfx2UiSCrCMwT7c2YGeIjRmd7kHUdiakIK/E/9IplDFSCCOAXq0CsLHeaFukoRmOy
	izOvkgIG6jDXHbj8bvz+EDXutPvJsZwkLiHdiK/T4Y8qvvwouG67UhszrJiX3c8YecC7zzgH/GD
	yCb7Ar7FDJ0Cd3kbEpnXO+y4IXS5EWPjcg6rBSB2c6euggnyq1tlMHgFtxAG0Wl7pHxium9EbEJ
	9lxdAoqPR75OzuOg2cKPnSqese2tmmZXEpVild056FUBMwSBPrVjnoKZRMf/rB2Who4kRtHfApI
	wVH21Z9EbceI1hqErOll5WhGIaFTNxHD1YXAL2SrtCPOvtBA+0RftaUitJT7XA4Hdzbq3ft01UZ
	sFM9+xq
X-Received: by 2002:a05:620a:4809:b0:8ca:305b:749b with SMTP id af79cd13be357-8cd6d4d5456mr1426307785a.60.1773066595964;
        Mon, 09 Mar 2026 07:29:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8d4cad48sm148711185a.33.2026.03.09.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:29:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzbcI-0000000GTxY-2R0b;
	Mon, 09 Mar 2026 11:29:54 -0300
Date: Mon, 9 Mar 2026 11:29:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"linux-mm @ kvack . org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Leon Romanovsky <leon@kernel.org>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v1 16/16] mm/memory: support VM_MIXEDMAP in
 zap_special_vma_range()
Message-ID: <20260309142954.GM1687929@ziepe.ca>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-17-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-17-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:47PM +0100, David Hildenbrand (Arm) wrote:
> There is demand for also zapping page table entries by drivers in
> VM_MIXEDMAP VMAs[1].
> 
> Nothing really speaks against supporting VM_MIXEDMAP for driver use. We
> just don't want arbitrary drivers to zap in ordinary (non-special) VMAs.
> 
> [1] https://lore.kernel.org/r/aYSKyr7StGpGKNqW@google.com

Are we sure about this?

This whole function seems like a hack to support drivers that are not
using an address_space.

I say that as one of the five driver authors who have made this
mistake.

The locking to safely use this function is really hard to do properly,
IDK if binder can shift to use address_space ??

Jason
