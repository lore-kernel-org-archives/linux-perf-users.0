Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FADD36A37C
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610577; cv=none; b=gt3OZ3iNpRUeWUfU7EPLh961x9pAC4+c72kqwAYfHRXVQbg3LCwIJ2/AZ1EZycGfn5RHfxa5M7dPI/t5YUxQB9dPm2UAAguhnn92Kb2GhiBp/hu0PSm8lX0588bjmJg+u51H6PfMhfr4FBiwJiAqJ5Lkj5dj9zercFuFKgdbRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610577; c=relaxed/simple;
	bh=WZm0pCIlMCZnYkWqHCv0Ceyplb5Du4QgkvAdE7k9ZdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnBAlqI1vShhb10f4sYkBqxNDGujMTWcFKVtL6twgCy/JAKoJgnn3vTIuFtEtu41qqTu9ojMggksCh7+vSPWcj7ndTnAKrKRMspFT2Hdpmz3YYSM4c3o+WWICxthsj26QIyVY8QTz+EIru3V/rP0CNzCYDljk600afSV41ude+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=at0Go6QV; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="at0Go6QV"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8f18d92172aso201726d6.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783610574; x=1784215374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8MCYdDNt+ln4FYDiI3hqZQpolLcmikZ66uE9gEYE70E=;
        b=at0Go6QVpsvcs347YVm8e6Uaja9G1IeXCuro3d3GOlXJqHWVvE6PiN0K2GrLyghLIW
         z3oj6epX/hjLL27IHOykQiyUe/iNRNY1KDATD9vh76zvXQHF5HBTyw9/Aq8HDW7V933u
         wN+nxswsqSfWTjCdK/+Kl3FBNM0eBchEq7T9PdmZKnesdFjarUfsPj3XxCRJXXvUxwOm
         p+XWOy5Qk3UREk2XLNSf41ntnAdyKhre7b8Pe4ZuqkS5bQYq1kz/PxDwBk5xWSo96gGz
         jTdJjrtzSEH51GHs+sq7xrsvUHCZr/q3OKaXfAojoNZfUxOOj9jGmFUbIMVbGezn4Afh
         G0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610574; x=1784215374;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MCYdDNt+ln4FYDiI3hqZQpolLcmikZ66uE9gEYE70E=;
        b=Hx504wL7BBx5lqLSsj/kltXG00mtoicxYYmHklykV5feMIp3Qp0d6//Br+LXjN55bT
         kZFl46uton8XDa+AxgMc/kU+E9iRzehQRlG1gTGsz079A5HpGQ9i0lYFwD7qcipBW8O4
         zHmATrBVgUAvmVxSivY1INgNMgF7ELgg7lKcPSUrypfga7Z2fRl3jhO2ovpx+l80dhY3
         HMYymtFuJ6l084a7XeFESI3g7c4wv/OPNl70xhQt19QAD4Twua/ZoiFx8Ue879B38Bte
         oByWlQLKFo4gnjxKnn0yE4sPE9BAuEu4raKfxsmQhl8prpmNfb0VzmldwtufEqVpdo1/
         Bb7A==
X-Forwarded-Encrypted: i=1; AHgh+RpyobQUjG3lkl04rnqcYvDCtbDuMcjl0MtkEnnHAlOfUVRkGauDWzNjcqUwhtNNGmD9608cHK6l7VhL9dQKqw9n@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5girwaXBrexuP9Qa7koKW0gUdZk/z47RGAtiuX24NgtmeubDM
	I8PbVgJVu576inRrxTe0+Nen1edpqpNROayEFK0jKLSqCBT3+gX4klHgShxi72NPRKA=
X-Gm-Gg: AfdE7cm4cpAmHfwFpG1gWhQaYB2AFTv5keIJHL092nckm+gEG/bGCt2AawLXpshD2sW
	FhVvodcmOaGpTSt+Xh5Zk4BgKel4oQE8JBm2816ixHQnsvdc2QAX7p8y8kFupcZAi1RbKoMQR1b
	3Jb5rSz88Ma5ucs2Be7VJmZIVCu7kUYSPLZaE50qCXL6YPV+85MABB0JZn+/hCeCzaSCpP4983l
	bfyxblVdAAJOnJZfFJkGaMmjD6KM0RSYxBnXz63+5wv/emQyaRoiDFpg9iGAfNBXaC/0IQDIIYu
	3KwCc4tG41YxwmT/v7T7WxDij1BF1blMv6ezVMrtYcjPJW1B62wS9Fgn1fH5MbLEDVU6G8hTifO
	oblsD49pT9gbX4cJ939m0MIsowQTEQ+0hGai/GcbHFG5h/JTB+ykCkLfN3xWP5WCqlDTt1oEF2s
	Ll1DPMquzGgvjDLKuBuEI7vs7YBGxdEcHBvban+2oBcwOG9wrcpxJJpKdrr2c5Qv3oIwYU
X-Received: by 2002:a05:620a:28cf:b0:92e:68be:1c5 with SMTP id af79cd13be357-92ecf6165e4mr847751685a.21.1783610574232;
        Thu, 09 Jul 2026 08:22:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b7fc3asm1638936985a.9.2026.07.09.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:22:52 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:22:47 -0400
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
Subject: Re: [PATCH 15/30] mm: introduce and use linear_page_delta()
Message-ID: <ak-8x3TWsuhGzKlJ@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:26PM +0100, Lorenzo Stoakes wrote:
> It's often useful to obtain the number of pages a given address lies at
> within a VMA.
> 
> Add linear_page_delta() to determine this and update linear_page_index() to
> make use of it.
> 
> Add comments to describe both linear_page_delta() and linear_page_index().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

