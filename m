Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32443C140D
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719570; cv=none; b=XmTrzji4Wy1WCJgFSyYi8zIzesSQvF0t0xafkSG9Rc7P4CMP+CXYBpaU9rFnWU9yKD0/eNn7XTysEmpuJz/FAgf9FpoOH4zL6ruUn6WtMXkI+JrA2BCaXGCTTjQ/VCq3Wa7FbAQscBTzxR1vxlDNp6zZgPQVXqcW3VWTO00BeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719570; c=relaxed/simple;
	bh=8IQ5CYx7b5nVnRm8wkAHsld3shhNHab0xIV3bA9f26A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDvtBUHYH4YKpnC6NBOBk1CIFmswxawzpAYPECxbZRIWgTEfOy+e2hGB0cK7QXNllXlf3vuXB9+S09KR298ruViIUBcY39qGLWo0v8N8DD66qYQFS1rXYsQU8VbD0a97I2thd1q7IbDcmeyv4jw5A2IZYRdGM1HpGDO3WezvC9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KcM3Wylc; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KcM3Wylc"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ff20870ac7so10344306d6.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783719568; x=1784324368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wb1LcvJKID9cCXN+ue8juptbLrwaSleub1+yDxtfpnU=;
        b=KcM3WylcLQKgQyXi9yGb6DVP2xBKT/WbjS7kPU2VDU7XkEH4msaT6vN2PsX/38yBZz
         8DXrNaOJya8FB8lundHEne4O353YE2hDIALM9o/2VBTcWWbIZXjoSBld1dOop2vOMmbl
         GEaav3WGOuAd2joAlZRxieqZmCAlx13NmAF+RsQB7bqQCVVuuJoLKuPXDyfv9EbDog7+
         0APUZO2+koKajYBqWUXhYmRb8Mut7lET+V6pvLRRbwbSLd1Fx+tBt1OR8kCkbkOVm8rj
         YLaiVQtEgIVqoEXPWjQhT1+7yX1R5ZUSI9TK6UaCYaaaQmY8ZPknfw0RBIeoO11F9jrN
         GWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783719568; x=1784324368;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wb1LcvJKID9cCXN+ue8juptbLrwaSleub1+yDxtfpnU=;
        b=p3+8Sb7NztLJ/KcGw7Q1+Lq3XOj223LCaKIIiTq+BX8Mn5PjYUntheNPR6ZlPuROTV
         nzzEMvfFV+TnAQv9Q8dyjIXdBDaQ5bDiBqQrUQle53oj/SI5UY+XirDUjCVtlKwiIl6W
         FYTa1yG0Mn/H7E9FJSeM7PEKT2Awtc6YGS/rcTv3/R95RaubPrycQN1lpgSuvgHwYr7N
         WRhSXJ00oNmTAF3qZs4dEDBefO/Wrgd0XoamUwx92uNC33RkOlQM/7wE4M9C7dZpNieZ
         W/CESL1qX6Bh6PcL3PnpM6EKVG7GstbaGjXJtV3f+QtBlHJeD4t2nNX4k4uBgSFA7fVq
         eIaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqS8mbwRyZkZhRMzveuO5WMetU+CcfablHl09CuBrrlGw2AdatnAZxavp6rxTJHOzosncO11lxOojZ7LM/R4RtI@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXSBEAN2AoW8g0v5UAmBi6O95vdw0d3Apej8570VeWO31cF92
	rZLGjE5HS0/lfYNzuVdmxHL79zetAweapihcCNW+6jwytAnxeN56uwcoNzr4ubUMbxw=
X-Gm-Gg: AfdE7clFbyPyZ/yRwa/ectgP6ITcz9hOym0kUuOYVn6dSZTZ4mguncqdidUsTLttfyP
	H5UOY0e8Qukkzz9dAdQOnVYB4sGWVeN2EfGws8t9OlmSivw81Ubk2Crnrr2si2uqBTkdJYauPWB
	4UcWbeQfrOKjESh8ZCQi7Ld7Bu71CY1L2PhOmUFHZzLulgVSy5awlnkMSiZiLvCxlOf9Gt2OJi1
	uQLX/a+aAvB9gruLWHAVfxJLkoOVp6DL7iHfO4shgVDVc9QQiyOaF28Fdw76/FyHTKmxFm+5gdj
	wnhd09vW/sC1foUOW+EhRU74K02oczlFMXmkf0Lx2KMo/VUayKVQbCL378UQyV+tXZXtjxD9fsU
	NS9jV4ST29pO/e2WQv7D7NJnYurwg9SB0mwca+ODCTt4CnWaFJvsg1a/+WAuyo0sG6Jp6ZDCDSq
	jmeal/d9ZgOCQ79WxARhoV+PXfuEU//5Y6Njao2bg9jifl04HEJUCY/T3kAkdTFdDAAEuG
X-Received: by 2002:a05:6214:5904:b0:8ce:9cbd:b0ce with SMTP id 6a1803df08f44-90400c8fae9mr11445886d6.34.1783719567574;
        Fri, 10 Jul 2026 14:39:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e081dsm50984276d6.9.2026.07.10.14.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:39:25 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:39:19 -0400
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
	James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>, SJ Park <sj@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
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
	Ian Abbott <abbotti@mev.co.uk>, Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH v2 28/33] mm/vma: slightly rework the anonymous check in
 __mmap_new_vma()
Message-ID: <alFmh0sm1are2VIq@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-28-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-28-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:09PM +0100, Lorenzo Stoakes wrote:
> Determine if the VMA is anonymous early on, so we separate the logic which
> invokes callbacks from the rest of the logic.
> 
> This is in order that a subsequent commit which asserts correct virtual
> page offset for anonymous mappings correctly asserts this for new anonymous
> mappings.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

