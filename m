Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D982EBBAF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696153; cv=none; b=A+WSj88cf0RdZrw3d5jE0yXmFtC19YkaSEVTxzzyiV1bcxBnR23eberhNO/l8rN+msiXQBWz4GMbRkIX5x0DnOQ+QlJVRQAa6qhFHlW85NBSwvl7c14IsoR61mM5xZPoh9WG+h0ZxSL7l8M23PNuK3kNwEGbYxmLHE9b31eZSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696153; c=relaxed/simple;
	bh=EYnEp1we9gIclXQGcrALFhmvzaRn2auF8TgNETsfUuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7CsV2DfF24ELCvK6JwGwwotN2M15y13lwlNQ5gPQVSCtO8rmVlYXuBcECFpWSisiBHcy3gtv9Hc0tW/a6ZL3/uPOPre+MQDE9dntT2MZGhXDzP8dOXg66kyq7A04dynyL9fx81dcFERPlVbjtw6i3zk9DScv5vdoqm3qV1W6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=epDIsSux; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="epDIsSux"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e54f8c051so49299585a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783696148; x=1784300948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kfeOD7p/qxHHEIV6dN3ojdA17bZ6I64Gd2Z+QpoWxkg=;
        b=epDIsSux+DHr+R7+57IO63qplyq/xvKvyvsaSnGocrnSVyB35pBz9FidDdZuFiqUU2
         DEI7utoVBOJd+hL2ZkNUbyTbx0Y08lPoRNUQRQXYseSYf0HdXLcShSbznwu1JXATey+M
         Bfk6ZHvdiTBAFpvVxcbsiTVK8ykyQWYr0zJzGUXLadwAyHssLBd8x6Jgo4u8W9tN5Z29
         wZIU9h14ifKZhs1PuK4WQDrSK0h/xCBwcAKQTquQdjn/ua+BQ95nOwYBKbmQUv4a91i5
         CGGuHWdgt++oNXzXs7BjBuahelgwoIdMTKYwabA9Lt3yQQk3+oU99uqBMe2SlqdHUwLf
         9Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696148; x=1784300948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfeOD7p/qxHHEIV6dN3ojdA17bZ6I64Gd2Z+QpoWxkg=;
        b=dhLNafGSY2SHAO31ra2Y87bHBPQjQStpe80vOxv5Hnk4NKH24NBrA/f6g5d/Ljz5+q
         LPj/oUSAd1n7AvXX3WIda7uSvu0wiyF9Pt7VmK89ShiIsuUDTEph34fMym/bsxI+SDL4
         4/kB9N/0ESZ95xdUe7rIrA/f3853qCSRhxstz/Im+m5n6vOQZ4wHrbZLV6MAB3gDSxqX
         HnCKB+tD5TPC+gYZ/C+rjM6y7ZWq0AuO/wY78bkgR5sMIrMEMaWrtGG3QfgEyTzrAOeO
         +oNoc8xEo1tdi7YpHUqJQuLUt1rnKCnb5QxDWW/HRDJ8T2GMPWWR1yHAeyw+ncl9IQBl
         S56A==
X-Forwarded-Encrypted: i=1; AHgh+Rpl7tF6v0Lxa3DxoXMALNRfhGBiRfWERDI6T+2RNMRX35jxwzol0XVofIhJG6pNvPidQh8a1rU4TYGCkfxpmw5P@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7uodSBBFrSv/1YLIsFfH5H+I/IWh/6PSpj2AG4Ea1zkkPkZp
	Kgtfevw5QLqech2E66+IUf/CQOEtNI07XMCtoiDASEwl6f5wCirZqMz4eGQ8704teC0=
X-Gm-Gg: AfdE7ckJp3Uo8aYqhR2WBLthcgFt6gecPYeerNL1uQ/I7BWx4eM5k+L2SotZcWBTfhO
	PFCD1w0+itdq+0V/KfRfpuxjqLJzYHg2hvCV24d+Oiiz5zkWXp+1Oz6a9pPdd3SXMAc0sekVMQW
	wwcIH2D31C8uoiQuphJ6jOafLz5FlMTlNfmMrU9x4k7Vy/m2ESrcYi/jZpSYrkG83R5n4WCu+oj
	vWJCA1YvBM/O8JXYFqKlhJcZD9fm02pKKXu9c1Ry52yZKXdAs1ufFbGW6OhZ4tmNj7BIi5Xsfht
	iWgZ7L8ueq3e4rgGkYq8ZCmyxJI9pVSd5e19ZrqBAv/BB/yB3sa5M4+CL3i/opfH+iRokHm2/kC
	+OghxBQQfEuedW6TVNA2SlxlD9OdtZY5fupQok3FvGC2zSNSpmsl+HCrjLKh135Z6jCm5OR6/5K
	Erz01xTWFxhFtslKPI9PlrjYuvsb2DmvQcM6EUIohbZPPNtTLq835RL+qj035X7NssGjum
X-Received: by 2002:a05:620a:4414:b0:92e:7d53:8e8d with SMTP id af79cd13be357-92ecf55964cmr1359477885a.27.1783696148308;
        Fri, 10 Jul 2026 08:09:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d34f76sm213283985a.35.2026.07.10.08.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 08:09:07 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:09:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	damon@lists.linux.dev, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 17/30] mm: prefer vma_[start,end]_pgoff() to
 vma->vm_pgoff in kernel/
Message-ID: <alELDgm258nhjk3b@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>
 <akZCg73F-oGzDp1a@pedro-suse.lan>
 <akZGqclqQ6gS12Vv@lucifer>
 <ak_C_o2ehS17Q5HV@gourry-fedora-PF4VCD3F>
 <alEHy1raICek7imv@lucifer>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alEHy1raICek7imv@lucifer>

On Fri, Jul 10, 2026 at 03:56:33PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jul 09, 2026 at 11:49:18AM -0400, Gregory Price wrote:
> >
> > Silly question:
> 
> There's no such thing :)
>

All my questions are silly.  That's my secret :]

> >
> >    What's the purpose of retaining tags in a non-address value?
> 
> Well if you want to reconstitute an address from it later then that'd be the
> intent, but I'm being hand wavey here for sure.
> 
> Main thing is to retain stuff under the page mask
> 

Right, which ... 

vvvvvv
> > That sounds like there's fragility just waiting to be broken.

If that's an actual issue, then our relationship with tags is painful :[

~Gregory
