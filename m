Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4536A360
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716547; cv=none; b=ZAAQ6ZkK1lPLxUW1ExRh2P1qUjg5ibrMx2ZxJTsUG4FhEPmyiKwjFUFKUNN78Tk9HEFVeYyZl0l57LRfb7hk84gg7bZSlcC7kQxGSbaa94KffbfNDVmGRJpptORoq0NfbcpVAV1u/a9tsbFNJeR1h0UQouyZ53gvmQjrR1ZUQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716547; c=relaxed/simple;
	bh=gC5eUqeAebp3PWfUT6EP2kjPnQImFCyW8H71EpslMQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN2nunwZglLRmeww0QKaNdYNWaSAQDxCLLRmU5bmf5u8ZvG1wYtCDte6YACpMncfPDdwCA95/N/b3jqKPXJ/9gazeoz+n998X04Fd4/i/l068mIbNcFiNfT54SPOYkPikmP4qbBLf8UBUCpsV+HZXAGzMquLGSv6LzR//kATMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fonv6uPz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fonv6uPz"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-517dc520840so9180831cf.3
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783716545; x=1784321345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fM3Bw1AZy4lAkPPHaL59OrI7vB0RIP/keCGdI0vS7tk=;
        b=fonv6uPzbSKpXVdHanWV5yL2JqDJx0BGpTTlatVYw7KbdZpIPvlukInSDvuGJzFPvj
         9Rb6nF6N1V592BAcnYZj+KuIQ6SUkNVw5BFkU33l8++hsxVZYpm6N2yINGX4SeQYz5Pm
         0uC+wmjY2g/BzoUPQOVBvgQPzF+896+ru9GQ2Bke9PjtSUaYf3ji+w173v1VHl2JDf2D
         cuZ4xUZCBkOxjsAwjzBGUe8aor3Jv10fASVIo+klHJhyWjemtNaXu9/XAhOtcs6ap+8P
         tLKZ/vRdwaA27+Rqe3dkWQovqS2cERzk2/CXU2jrO9ebCfwVgJ2tr/qigd8Ad8xNjTbV
         N9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716545; x=1784321345;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fM3Bw1AZy4lAkPPHaL59OrI7vB0RIP/keCGdI0vS7tk=;
        b=RS2+QrL4VRaXksSqFPN0LJ7ezTrJIK/Bmc0RM92EZskyz/auIEWNeYMYs1L/zr4X8h
         6m6a+FJvvkOS83rCouLp+3oBnXe8oB4W2AnmeW/0PezKpTfsqf+If92nAPotgcECD70r
         FbkJDnFE1IYTqLAcRPLFzGxUE5RQF8Mj+TXn/b1sez3fy1tuASE1mUWLBZhf5yO4h0M6
         6Aw1gG1w46T9g/ffiJj4hzvrzyTA3aKbdkV3u+5GVHFz8KLP7eoY7Jan4MoXtLJ9IJ3S
         xVEfQSxWvAXazFCGkTL5g8B0tcV7LkxiflUaXRKFa9metvL31KwY6kVdpJQ560pH4RjT
         wWig==
X-Forwarded-Encrypted: i=1; AHgh+Rr41+DvaokLqcCLXQOCGwVFj/xDKRz+p7VzSZAdVub9i63Y+Li8Y16ud0DWULIZ/oB3bDt4T/J6tKmGBdC1lzkM@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVOmf+bZQqhEpfEZ9YfHwgMYuMyeWKL+XosxWy5GxKCkl6vUu
	SuQjUQFeYPWiq/aoqx4P+cCExtQFZtgfK5eGJcA5iciyVDf8esTEvVPbHhpEYJOGsAk=
X-Gm-Gg: AfdE7cmGHWEjaN+qSmbpeJNoiE9EcPmZkizy7NAzAdqrsvO2KzqHlMNjaRhM9XquDNP
	QySy1RlYpy0cqIwZL4mvr1Whe+uaq9+T/uKn2AXZEf5fuanKeip0EY1RcZ55JeoS/jGibZsvJlM
	TittA5uoUUA4GWf3PPh4vloaqWfh+c/lvxMtWWbPSEvzdXz4tUCh5Me2YeyInjnqZmF7Fo9HLVu
	dyZIZwaLfqtkuw5AwZH33kYlBUGBUL5lwDza6Uxezs/TX8VK3UFa1Vk2tgzMzDWcMq308iL+8rc
	CKb2vG+SQvyXAT43cRrnMxahA4lVMc625kis7EBNWAM4M9SMUG7uBZMm+xovDcfJZ6dQ0TAnn6N
	0Qq0Zyo7Q7b6h2N3ofaktT8+WBBSvNbzBWCbtCIhPOhbscF88pOE1JqLdnH+76hL8AYOTU4x8oo
	QiPbe3AAdYGmuuceavZTT79mocQZH0XK0ghVOLIRcz5VV1AZzFKgb3rRLprLcUjfUTR3hK
X-Received: by 2002:a05:622a:15c4:b0:51c:7b11:41a3 with SMTP id d75a77b69052e-51cbf361a3bmr5658901cf.80.1783716544856;
        Fri, 10 Jul 2026 13:49:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf5f61csm24147321cf.22.2026.07.10.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:49:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:48:58 -0400
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
Subject: Re: [PATCH 30/30] tools/testing/vma: output compared expression on
 ASSERT_[EQ, NE]()
Message-ID: <alFausURKttxHUAI@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <432444fa4c12ae1c4047550e2b205d3e9bab458f.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432444fa4c12ae1c4047550e2b205d3e9bab458f.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:41PM +0100, Lorenzo Stoakes wrote:
> -#define ASSERT_TRUE(_expr)						\
> -	do {								\
> -		if (!(_expr)) {						\
> -			fprintf(stderr,					\
> -				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
> -				__FILE__, __LINE__, __FUNCTION__, #_expr); \
> -			return false;					\
> -		}							\
> +#define __ASSERT_TRUE(_expr, _fmt, ...)					   \
> +	do {								   \
> +		if (!(_expr)) {						   \
> +			fprintf(stderr,					   \
> +				"Assert FAILED at %s:%d:%s(): %s is FALSE" \
> +				_fmt ".\n",				   \
> +				__FILE__, __LINE__, __FUNCTION__, #_expr   \
> +				__VA_OPT__(,) __VA_ARGS__);		   \
> +			return false;					   \
> +		}							   \
>  	} while (0)
> 
> +#define __TO_SCALAR(x)	((unsigned long long)(uintptr_t)(x))
> +
> +#define ASSERT_TRUE(_expr) __ASSERT_TRUE(_expr, "")

Mmmmm... macro madness.... I don't think this is what you want.

I think you end up double-running the expression in the failure branch.

  ASSERT_EQ(cleanup_mm(&mm, &vmi), 2)

run through the preprocessor expands to:

  do {
      if (!( (cleanup_mm(&mm, &vmi)) == (2) )) {
              **** first run ****

          fprintf(stderr,
              "Assert FAILED at %s:%d:%s(): %s is FALSE" " (0x%llx != 0x%llx)" ".\n",
              "merge.c", 645, __FUNCTION__,
              "(cleanup_mm(&mm, &vmi)) == (2)",
              ((unsigned long long)(uintptr_t)(cleanup_mm(&mm, &vmi))),
                                               **** second run ****

              ((unsigned long long)(uintptr_t)(2)));
          return false;
      }
  } while (0);


A bunch of existing ASSERT callers mutate state, so there's no guarantee
the printed value matches teh actual test value.

I think you want something like:

#define ASSERT_EQ(_val1, _val2) do {	\
	__auto_type _v1 = (_val1);	\
	__auto_type _v2 = (_val2);	\
	__ASSERT_TRUE(_v1 == _v2, " (0x%llx != 0x%llx)",	\
		__TO_SCALAR(_v1), __TO_SCALAR(_v2));	\
} while (0)

which expands to:

  do {
      __auto_type _v1 = (cleanup_mm(&mm, &vmi));
      __auto_type _v2 = (2);
      do {
          if (!(_v1 == _v2)) {
              fprintf(stderr, "...FALSE (0x%llx != 0x%llx).\n",
                      "merge.c", 645, __FUNCTION__, "_v1 == _v2",
                      ((unsigned long long)(uintptr_t)(_v1)),
                      ((unsigned long long)(uintptr_t)(_v2)));
              return false;
          }
      } while (0);
  } while (0);

~Gregory
