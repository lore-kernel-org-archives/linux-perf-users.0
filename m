Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372093EDE7A
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jul 2026 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089503; cv=none; b=K/Pd4T3jHiOd/2nvsSi/jVQJ+S1OAVRSzrIoNkJeX4qhG6Kpw80taCDrADUUJc7Po5dW8AnLxThekb2oek02TbwOvqQjd9QuinR9wb1Rqzp40BfgJueUrR1qWfLV/q8fziI3e/TajkBPM3r4tj3FikklIRT7nfd32tdSRd/9gl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089503; c=relaxed/simple;
	bh=6AeDRRgD3yN4DkAMI16Ol5bWSHoi/2y1rDyIZ4jO6DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwBjM/bySmrbRWowKkjVgyPZAVsieTlUxW2/oxmp9JxtcALdNP3H1G5SRCMDN83OkggFNhyeOIYc5wedozjIqxAayStbj8RnvYwzo44JZPOWYVyVbYHCwMeq9Mq6gJZcIgfbo/49l9F/zHtBulqekA9Ci3q1V0MQsvfF/BEVsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AQTwpQVf; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AQTwpQVf"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46cea75d96cso76629f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jul 2026 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783089496; x=1783694296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYcKnRNBBATcFMmYjoa8x8AgbZncnZb+6A3fuAeXiUI=;
        b=AQTwpQVfjkKo2qB/x5jup+2NrY7ocLaBf9x4L5SQhi9GBQfkXkUZhKKMdoro8pFiRZ
         oEBXPiwFlt1BTrKy9hh8pDscVq49rTfUk1anH7L58iQuyqsoJDRtlAI3uICVNigf2Ouf
         ozzfj+NEN/tklxjHHmaBR1i5sv9SrAlvOXO7iRGVlIZs/ZJNlUeuZIjJrS0NgjrvJPmh
         +Mz3XQSUT42G3G/KItk9RBrVqgMIbEgkQ59qQnR3prHBf6+s6X8UDgSqZcn8rTKDOgQ3
         u+dg60GRY05+An/aqTxDsdUzGWsKmPObP/s6B8wNGCSp4ysrLMXcKaEvNUnoWqhx9WHm
         x4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783089496; x=1783694296;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYcKnRNBBATcFMmYjoa8x8AgbZncnZb+6A3fuAeXiUI=;
        b=d4ECUdFVj5HcuJMHzRUHOTuVTRGAbHFzEJEypZYKEEzzKQyFXTAzIeoXf+/kgXrELb
         IgqXGgsUhJ2FysGK5DV7Ndyd9AMTmVEpX0ytwkyLD16er+bwVe3szq4rPyjZQXLsJlkm
         H+VH/tor/lRpstwU7SLaIxsiy332vZfjGGcL0HRhHYcuxMeLvVQFSSm2tgaqr/x8NQ7/
         fQnRAW1XDF5n1VKtrMe7IQrIZOaEe17R+GkMiFgQT7TyOud1mht4AdYkd3ZcfDbuvDcR
         eHIqErvm3cV4zd3YWQ+Zh9tN913TlJ9FUZ8Xd5ofN4NnLNB6oMFDzEHdSNY4GiAE2yZ1
         HTiA==
X-Forwarded-Encrypted: i=1; AHgh+RpKkf5v9G01IDBGKDP4+Yr1liark5zeobxrL4gDAJQrM7oaDg8oUXUvC0tqh8el+sWjEdXBCW8exMWvtHDgCdda@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07ykVb05pIyHtvgsXYjaz73P5IOgYvT0oX+B4WjpfRYi+7FZo
	U03OYgYdeMRO+EDMa5y04tPlmhQA79VhYje+vN/km3yqi8GNs7PdC28LuCcBf/qSFTI=
X-Gm-Gg: AfdE7ckrevrfX2I8P3YrWDbjlYNnwbpTggtGsFRhbYPPfpF08OrYrwDbGSEwaJ5YuMo
	1hqf1rSNt9pBIcaztwGLBSX6XvD+COBrMReTF82AYZn5eCaiBp8DygV8xAoean5FfWVK6idDeVp
	Uu181ZRd5KE65pfDjFjkyB7x1W1nusUTUmq0C9mLbnClfrsxvJWdohHoGqF+YXbmNZjgnKfrT09
	K3yUoJfF2IzmOjO/lKI/Q+JSvK6QXFABdi695IOdY428g+GG5Iug1sX6QlCM4xoadbcAsGsP5dk
	aPsL0LGouvmgWV8cDIFZbPmtog7SQrUem2M17slPFyv1kKpVzAxPGxF68tiB4NJ/Pwfea740u2T
	AIaHHza0K/JvhgIChriK8HgWaaxMEMmE8dr27RmyTx4enytkGSVCSuAEXVCxRJO9e8UsB4BZ/AB
	fXyVBCSfs=
X-Received: by 2002:a05:6000:310a:b0:474:2b24:8dcd with SMTP id ffacd0b85a97d-477554e264amr8372343f8f.0.1783089495690;
        Fri, 03 Jul 2026 07:38:15 -0700 (PDT)
Received: from ?IPV6:2001:1a48:8:903::e14? ([2001:1a48:8:903::e14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3db964sm17544462f8f.8.2026.07.03.07.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 07:38:15 -0700 (PDT)
Message-ID: <86a2b2ae-5c5a-418f-a944-4c8d179aede8@suse.com>
Date: Fri, 3 Jul 2026 16:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/30] mm: introduce and use vma_end_pgoff()
Content-Language: en-US
To: Lorenzo Stoakes <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, "Liam R . Howlett" <liam@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
 Kees Cook <kees@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-mm@kvack.org, iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>
References: <cover.1782735110.git.ljs@kernel.org>
 <e379a1cb6a897126ad96e3a263fdb91d6c11f6cb.1782735110.git.ljs@kernel.org>
From: Vlastimil Babka <vbabka@suse.com>
Autocrypt: addr=vbabka@suse.com; keydata=
 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
 pYekxJujNeEDkUlky0Y=
In-Reply-To: <e379a1cb6a897126ad96e3a263fdb91d6c11f6cb.1782735110.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 14:23, Lorenzo Stoakes wrote:
> We already have vma_last_pgoff() which retrieves the last page offset
> within a VMA.
> 
> However, code often wishes to span a page offset range, which requires the
> exclusive end of this range.
> 
> So provide this in vma_end_pgoff() and update vma_last_pgoff() to use this
> function.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

