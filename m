Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEAB31D730
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813964; cv=none; b=VSxUi+8gQgF5cHffnaRD9MtznXeA6CD3wGs4/OyHtKmL1saXBNKtSTIGw4XWavOgQwU9RNd3jd4/aElE+ukgDGYbB3e0OHSRYn7VHOJmTaiCfCJsX78VVo/jKjqH9cUrOZ0NWJvEi6f/nB4BWcfHM6429/Ek57J70HRb89gGUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813964; c=relaxed/simple;
	bh=8muSqko//3OVtfdLNuksgmorMVqiZ3PVqVWHx37Bpjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t11QYqgWBRG1EjmufpLYzV7uEQs1Bd5r05Z+XlvzNAWUKkWHo5DjA4rQcQKkfrSByrl7e+ZcNpgqQt2LoyvrwoviSMoETXMFkHKF3CqVCYgqRCd1HTtJzIvXHUjbbbpu7469/jHQZ0N3lsWCbYZLjSb611QV4Ah7k7S4eiUQa4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ht5G6c8r; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ht5G6c8r"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso1932302b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Aug 2026 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787813962; x=1788418762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5mb0Gi5n7+TH6iAOQaM9yonjDSHlXqjUCGPV+z43Vvo=;
        b=Ht5G6c8rIezz3bUm58T6kxjt7N480v7/Ww0Uv0jQI62ZVZdp5QPpUPEEfJ1Juvr0hD
         Iadwev+/rgRHarqg6H21aYzuVjUGBBBpIbeu6kBWuavT4AHUvdUQlG90UdyBerckbk9N
         04Fm/OybfWHDiVTyrqcQj17WSGBa7x6vR6Ywg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787813962; x=1788418762;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mb0Gi5n7+TH6iAOQaM9yonjDSHlXqjUCGPV+z43Vvo=;
        b=JjqG2Wfxgl+lDL1Ty11FYtC5V+ER3bl8hLRLoBnDPQs5HB1qR4DMToTQnYBSoihurU
         EsdtXIBVfw4CaIx78Daur4x4ckcKlQ9Xhzwg8t2kpAWWiN4roSC4MoxBPUk1GniiDhbI
         Amd6H62C6AZXi38PicfcJBwpPCe5mYhbH+ZfERP07vNsxOxR3h2AaKcATZ5PJFk7DiSu
         pxaZehnQYAfGz1Hq/vYcVaa+QnACMWqYCeDcHWX0SnTSzbxR4GJcbgUjxPADfovzocv8
         lImK2t8ht8Sn+jbAPR7ZjnwwK5WpG8Zt9hOwmisnrbTCyhap6EgVMAhae3BH3B0YF4xe
         YZzg==
X-Forwarded-Encrypted: i=1; AHgh+RqO/rc0jC7unBUtPNE2XSbClQ8Z33Rzl6UithoxLPppPhWa+2l4TEHWXco7qiCjwoEtt1JxCvfrBJKL8Xxy6RjF@vger.kernel.org
X-Gm-Message-State: AFuF++kWRR/zyXuvYAqtT1173Yb/NIYI/34/W6Lq0ef5KDEjbBuehxmR
	vV72YDwXnsB9RfLLw1M49u6VVsKzd0TcxrFOuE/t8/VqtkeB8C2wnmmwYWWDuFvbDw==
X-Gm-Gg: AR+sD115xWo//YNXBPjqMSIjjgPKNGfInuRQ31fqChA/R8Y/Q7m9f23S9olyBQ2emlt
	2khtmEA5JM6rogzsDGyP0VLruQwsvsK1BUHkHV4vYwyMFr7mwyCfvV7E7gFdLAQVKptsukgiUQl
	/Y/WkSbcyWhy+fcYwXDgGV5VZwv8W/ao5jly9fzubWVo6ETz8n8d6hi76J0OoIEtwLF169F5aMZ
	AUBW92F5ooQg4Nq1wPQ3u53eQyXVAZa0u+zvetAv22mWmBbFmoclnP1hbI9QAum2L2Z9Hl8mrBo
	DkTrwKQ8+MWlk1AHJX7yQ0hzaQCF8pO5NEvVg08bDgyXISaeNOJ4buqo9d0eL0uCpe4byKc+Yto
	a7oCRoiiNuLp8thb039DGeCAK2BBOs8X0kGM2GrjcOJOFV4dZq8/o9ayBsloLVfmqOqvkuda3uh
	9fKYAbP/EXqLK6LBJP8vZEu1qOTWg0yFSj3UFDpnZk5eaRHKsT+WvLET8V4zLr+ltIL5HzlL2r6
	Aa2wpoBvQdUDMKdty0o0MqJI2Q=
X-Received: by 2002:a05:6a00:4ac6:b0:845:e9e8:645c with SMTP id d2e1a72fcca58-85372ba1874mr25814215b3a.6.1787813962222;
        Wed, 26 Aug 2026 23:59:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:ff0:ad84:24b0:9e52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cd86fe3sm1657226b3a.39.2026.08.26.23.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 23:59:21 -0700 (PDT)
Date: Thu, 27 Aug 2026 15:59:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf/x86/intel: downgrade alloc_bts_buffer() WARN()
 to pr_err()
Message-ID: <ao_gFsBR99s0sUBT@google.com>
References: <20260827065529.3835720-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827065529.3835720-1-senozhatsky@chromium.org>

On (26/08/27 15:55), Sergey Senozhatsky wrote:
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 8940f0292229..29c24b2925a7 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -918,7 +918,7 @@ static int alloc_bts_buffer(int cpu)
>  
>  	buffer = dsalloc_pages(BTS_BUFFER_SIZE, GFP_KERNEL | __GFP_NOWARN, cpu);
>  	if (unlikely(!buffer)) {
> -		WARN_ONCE(1, "%s: BTS buffer allocation failure\n", __func__);
> +		pr_err_once(1, "%s: BTS buffer allocation failure\n", __func__);

                           ^^^  compile-testing patches?  Haven't heard of that...
