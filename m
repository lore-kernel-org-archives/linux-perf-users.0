Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3939901A
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714807; cv=none; b=ry55sEtuBu+Zz2NwmNgsTqSrGqoL6vnZSnrlvfilkOcdmbSNcLgLmMgC0dBuzE30LfU0hCXulT7pgC6cMF0OsqM3O4w+AIiyzzAFIbY4VNN8wAbkwwNRUEuIJIO8py3uBZWhP1FRzdOeznosOH/3ypWSMyAAZEpqdrkg7i8inHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714807; c=relaxed/simple;
	bh=hY0ihDWAncS8x5azfJXUc95BFne8Ovg7UFiz7I6gZN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPeEbTlCkBNvaymGVvKrNja44hG5cshG6pUtW6fo6zfNMxf36EYile2+xUj2s2KMcxnU+3QjHppHrud9zlvkRj7SmxgOf2PzwI9m9G0SQo0djgEmHIOlfwgrMHooZPIyoL5vDI93pt9JlWmapn73I2mOAnD+oQYog2tzsBTn8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=X3mYeLKC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="X3mYeLKC"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2149571dso11631211cf.3
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783714804; x=1784319604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Atx/vDG1sDwzZEMAHR3NGh72ccSeLTTbFrhohwZH8Yk=;
        b=X3mYeLKCTjrKKg7CrKhhtCpJiHPHVx9i7wyXOXHXJaNZNTkaIVryh75DoorULOx84m
         TM+OwWO82Wa5PBzq/bp3fBMco7tSum+uO7dHKjgCrcAOtrj2ZcQoqjcMRdW+2pjSQB+w
         tlu3tni9BW495YqGesm+7e+WSEHEYWpHM5hPATAn+CpKpWPA/cUG+5VCwhc5PCHe0PUS
         MFkXf6cktWK5db+chO1jL7u4Y/QBBpOwl8MiEg45GxqUmoLXqyMpkCjPR69yebLQ4Enu
         QCcQoXAuwRIe5dPzaJOvDluq2JLNeIY5o4vGwaqPBzmc1kC+TmHXnJkELSBsdLoTg8vE
         umKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783714804; x=1784319604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Atx/vDG1sDwzZEMAHR3NGh72ccSeLTTbFrhohwZH8Yk=;
        b=KhuftijCuDI6CbAEyjtBPqXeXW18mYMR2t1+ncG7BLQqJ2IPEELLi6HQYogWRlpKDt
         FHZBm/w6BbJDLpb1RLy6fZx/9DI1KkA/bJ0sdqF/IzaJjDUpYcEydOuM6VbhaNZyh2Rw
         Od7xr5wgbZgLd+VkD5lqxskSDph6Im+2OZbTXQ3sQifw+Mw5UABnH3v+rh5VKFiqIyhL
         Qn/1fbMIg1cj/i695LfOodrD+9QyI8Rw4gfVSq+EXLS4lDldRmk5lDECz54PEJMH/JYs
         Q6yA+bMXYN8p3zWLEFIvprwIgC4ROzP6IL0zF8ynayiQhvtC53dYM7QiYEWhj8WbCS4H
         9Nzg==
X-Forwarded-Encrypted: i=1; AHgh+RpwEhE93oMmCB0TmegqDuyGpewHEruw1Go/dA6Dup95uZzH10nrvjVVWhPnAlb23ImJmOdgSRrL2qC7reUOla63@vger.kernel.org
X-Gm-Message-State: AOJu0YzV1efsCNo2Ks5CMbFGQ469tUwomA0+uRN7wznakouRl7BPjJnB
	fdBtQ4HZbgyTL6ti8Qm1buMsMICwoXIKVTHPh71MgsAsk/sfmphFNrBoO9+LLS5VLek=
X-Gm-Gg: AfdE7ck1AUDWWukCEvDQ7hZlxDa2yxPHk+LTCzYtkww1/wRfE9ZIZ/8+iWOWMD7unyK
	FcH5LtL7FgWUcANuwjUn03IBu4fdSzf9agbV0nyb0ywQYa1vqB05amU/oeD+cQlAfjlfBz0O2z5
	9jgI2KSpdt4vNIPjNngkvRG7J3pTF38mi1tX46lxRir0QaGai8/W6Vvj40l3gI2OCzjUMcqexiV
	k5tP+KB02N9PBjjJM3TeTWs/e7yKPQQNTnIMBJAPkrNxIbGlMHy/ow/khB4xkjHPqdUicRB+DrF
	9uC2b6d+2M0zdUKyeGLq2VkZ//bWkP0piOStzuzQtFcAU/zWgR7UnfQi4d5FYFb8EOPK6ukE4XA
	yw3la47pFQKxKnGB4huiheehCXUKDYCtLjVCkjDJauiafycqblUkLUC+kK8LMO/DyFOSRDUaoNo
	dOIg6AGzEIQjPT3HzWE1Twpe6p6errzmj+/sFsaqEwhLWR4FNSWohHFBOjx/no9wvm8wlO
X-Received: by 2002:ac8:7c56:0:b0:51c:1291:911c with SMTP id d75a77b69052e-51cbf0e0649mr5096251cf.14.1783714804352;
        Fri, 10 Jul 2026 13:20:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e10f4sm49427896d6.1.2026.07.10.13.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:20:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:19:58 -0400
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
Subject: Re: [PATCH 29/30] tools/testing/vma: default VMA flag bits to 64-bit
Message-ID: <alFT7lx8F04rN01D@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <27cd07f6dd862d92410cf9db03f7c11e5f66854d.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27cd07f6dd862d92410cf9db03f7c11e5f66854d.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:40PM +0100, Lorenzo Stoakes wrote:
> With all of the sanitisers turned on, setting the VMA flag bits depth to
> 128 by default results in overly long build times.
> 
> Reduce this to 64 - we can always manipulate these later for testing of
> larger bitmaps as needed.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Seems like this causes instrumented inlining to go crazy.

static inline void bitmap_or(...) {
	if (small_const_nbits(nbits))
		*dst = *src1 | *src2;
	else
		__bitmap_or(dst, src1, src2, nbits);
	        ^^^^ this branch is being hit ^^^^
}

tl;dr: __bitmap_or() gets emitted and then the sanitizers have to
instrument a ton of inlined functions instead of the compiler simply
injecting a couple 'or' instructions.

if you wanted to keep the coverage you could do something like

# These can be varied to test different sizes.
NUM_VMA_FLAG_BITS ?= 64
NUM_MM_FLAG_BITS  ?= 64
CFLAGS += -DNUM_VMA_FLAG_BITS=$(NUM_VMA_FLAG_BITS) -DNUM_MM_FLAG_BITS=$(NUM_MM_FLAG_BITS)

w/ 

make NUM_VMA_FLAG_BITS=128

would let you still test the branch but not by default.

anyway:

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
