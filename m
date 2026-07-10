Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9833B6348
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718291; cv=none; b=XIJr8aaTbUBwQf/JqrlkD5cV9amfvB16Ud/qyTN7t0YFRbsrDRBLbZGw2CZwi1ukTEL/Y9zzkCt5GhwrE6tdhVMtm4OVNdgxJPWzEGXDLsHyVGrjgiIg6heimCvEU964KdR7qLH0atUTbx+mW/Zbj/1RWfKNmEaxtnn8iwcMikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718291; c=relaxed/simple;
	bh=SIhLOUaxsH6uNqg5w5fr4DNuZv6zf1h5UML6naETP3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZNw6xyvo3hhMaKO3HJT0DiupJcCCfzUo6y8QyptaGicIrslveKF+4gKveii4esy0VVeS1bttSPS6k4lYrxC8HakgQPVdpuV2nZ5JwgVbYrfkHlKZPncTglhtK8l0HA/RILUr4WDxjAQ5x6jUVKRuC6MBxq/KcbB1sr58tQB78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cMqjH9gY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cMqjH9gY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e57a753f9so109516285a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718278; x=1784323078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ZedB0VQ1AWAm53tDDWxHLVghH418fWVIB0lX7U1LiE=;
        b=cMqjH9gYWgPuYsaSLlGZSP1pbN6HHhILt3levtSl8wDIMlf1EX03LXoTvPXxSsdBaN
         yVQTZu23kWuXIBjucH9rcSxiRe8mjQEKM+NseemVb+EJl6smuLtpRaPWShnmSkY2wEmL
         ByZb4ytK/UUzEkc8inyp9AvzdbZkU1MSfHmtSJtSCcqurHn23q1bn0AZkU8mezMriUn0
         Sx6CTIkSH3FBRTDpe3gI3MuWqaC1Ssd4k1ez5cPa93oTVV7Kpa00Fk3Xlsw3VnNkeoD9
         dajSsC9N3QEXz1+HUAIZnEJDiCsfyntk3j42LonZdGZafjTknpWeI9vZ7QlFKdtoeVct
         zGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718278; x=1784323078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ZedB0VQ1AWAm53tDDWxHLVghH418fWVIB0lX7U1LiE=;
        b=kqDI92u5ML2/GZp+jYrzZRiptUzTh0jJ4G/kdkEB31POrcRqm38rhQhFbz7YQaqmNC
         ebzjPH1ff+yrhVOjXYSEg+YdPl1iYsmXSvnkPDKmlqHiGqvRV+lByavFbEiHQ1sRAB7j
         tKoVMI53RVgELGlODa9YsDRFU8gGlRP9D4R97q4nQFz19ZPIUGT5dcIWTVbQPVBTL921
         R2HSLGATPotjy//mHRUzuHIVA6yF1hNdf97/PGNaUQIef6XlWQXQk0ZhsyjqYwdB1pb0
         LcClabL3EXoZzq4mP7d72Kftigq3uTYs3VJo2ATyvVhV1qVmb/cobkDmHD0EtfntXRUX
         Dh4g==
X-Forwarded-Encrypted: i=1; AHgh+RpYolTfacq4S0Ccxy1u3y7kvBDGCoE2urpYU3ncworddi+TFUSLXSp3l8nYrcDT1wWIu6noQb4gQbBBeeHU2uix@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz97sxQBVYTRpaG5ivBfRjTswc2f5JT9K1rVWk9INrYcc7YJLa
	IZ1ksceDrTHn30WmQMYLtSlhxbaLINArd8w3H2P9nHPFVcPXHBmGwjnfVsji41Tx2Ak=
X-Gm-Gg: AfdE7ckMSzWqb42NuaYgbw+LOdyk6n4cjc/Y6zY9N4lfLS1RoY1mPJ/YEwICI2jirCq
	FmrflMdxVPHtPQzPQeGuEZ7rptmbXM5bFtv4JlUi7nnY0vzHiFM//i1PSYykSwG4qR68dqf9UmX
	IzGXT/UeLsbKgy1SfTtFUWWijMfDSYAo0CurRQocBYnFeCvw6nqTMzgcmr+pNAZZP3wdNy0hJZI
	V4lklVTnSVLjfCv2Qy8CpnqSNQEb+1ltbHBl8/o9Uh0ZPHsLydcKoQM5kb1XY9PMR9GAZiFwWiV
	25Nqi3p9FO1FKUZbWEcq4NE3tzgRoh+IuoIrOPL78s4A2XG2khuVxPRMXQnv2pW8g5wgvJInhTC
	ie7UJfS3wArMlE0hAqcrGvELlZFs+OMBZ0W1LI2Ep4Ex6230ktSBs3iUsExYu0RP6izkv/xbyIi
	WDixoVctZI58Y/wN60YIGS9cJkVIZZPTRH3LNmsaqAPTvuro7jViB9j9NYVHirU3km8xtBf5zIF
	HOMnZ4=
X-Received: by 2002:a05:620a:40d3:b0:92e:7afc:93ed with SMTP id af79cd13be357-92ef2d03c09mr108964985a.71.1783718273295;
        Fri, 10 Jul 2026 14:17:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b1bbsm292932185a.2.2026.07.10.14.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:17:51 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:17:45 -0400
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
	Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 23/33] mm/vma: add and use vma_[add/sub]_pgoff()
Message-ID: <alFheaAGWCIAjom-@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-23-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-23-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:04PM +0100, Lorenzo Stoakes wrote:
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
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carrying over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>
