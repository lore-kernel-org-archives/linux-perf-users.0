Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BE45C71D
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267895; cv=none; b=ut0abc5eXFKqLm5bB32FnlZ6BSBXnATdCWK8EOsk6h3qMLJhARMBUe5QjQA1iLEELTpvOsFYnjlUaDOzLoOqw8YOcfafbEMIgRkRjCaqJlQJRn/TuMQDbavDHODQEXMqhz+EHYEcC8ygM2uwh+fHmRyPeSt053Jl6WNvP6kqe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267895; c=relaxed/simple;
	bh=Y6dfgoDu9ENyHz35342iESy0PYqePxl/sIn9jSurkUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG6ZzNHm5zW1jgrquJE3ip6+u6Fl87Pcms7URa7RnRqDmby87opdW+fnXW5hzmzT3DUQO+XeEdRGFmB5CID5EZFk4OQfqlpqVw7Fn3nvNnWLJyhOhsgp/0cKWdWxNRPdpBqOL40gQ+JB9SQ42+vuu6x7+tgw5rg3onkwSPczeys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DELaQ6H+; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DELaQ6H+"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76543e1so245131cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790267891; x=1790872691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=DELaQ6H+GoqYKhSPbbw83I2UghjOPLUKt/HJzwYXOl5vd4By1b/ewKsZIbd9ahXhZb
         TJDLBT2drAnq8j1D4gtZjKdZE54vfhHIW07z7SMjyhNrpJZ88lIXL27llafwJKgt7Hvw
         zeqWn52o1fsiwmzoo4rrDQZv3h3IiFJnFO2iuBnkUsGA3ktjvtFHA3Jr6K2ZEcGMg8M1
         1di2ZTIAJ2yTB2V6zmlctv6zG6tcG5IvMF9RkWmI06r7tX+skZxDuVThBB0MSr3NZe3S
         B2+XxiOTA95Xk/3/+mlBZ2rpvQSIcAx9lD43yFxhcrOBvTesr5mE416XkZK5Fw1vsdLx
         5Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267891; x=1790872691;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=NS3IQ2M8fIHUrrR5u77G5BhwhmpWPRGQtTEk66ix55KQ8EyMbjQYctvVTV7UelrtlW
         r86AV0lez3d7++La+VZWva/SGVkZ8YWc2b3rq6VHWFfXeVBdy1LjZmz937/FH2d7+m93
         5WfEFw/XdIdr9B91X9YKUDQXeb1MCfcrhfPOvI/DYGTkhkB9RnF0XOQDXkWf4pGH182U
         c9uKvftiNJ5gaN4ASiA6w3vQszHaXrZSQsvDp5tl/TLdeeCeBfEP3fhbOc7QLYzfbXNF
         tkEW46GsZMtlM93ky/gDNHwK/lj9yPxz1HRj4NMIUDmQYZiPef5fWGY6/0BI2U5x1HD2
         sYYg==
X-Forwarded-Encrypted: i=1; AKwUvBxIF+pusJQArp/9boJ2yTyB0GtLAj3Z3W5mrXxWCc1Xvz8Z+sFPbY8gju6nXpdGcEYY+xCrzbiG98pj6NvVjXJ6@vger.kernel.org
X-Gm-Message-State: AFuF++mebkFPRc9n3kB/3KjA7RTPNCaojajFsQ+cHJQKOR6KHVgHMxMz
	Tf90UUgYhI1yoiFoQLXq2Lu8q3I19qCza2D/1S3eEfCvGPLZwMZraP4KY2rNSLGjkCouarCOcjd
	SbEVz7YY=
X-Gm-Gg: AYBFou35DwGpa+z6ktb6vWB6S5xBG/QwVms9KoAG3//aOu7oiQsECKiIlcXWmlpa5fZ
	UrnhPkwMoUvWr8/90mw4j57i80UAszJubSI0wBQukMstO8N6gRNz007xfAMHHaKNbEHus/zxMuf
	/eKPCD87vdRNzCdRGS4VXa1X32yjg0CxJtiVnazn5am26bZrLh0FxHIkIBjFUdg8FdOflIha0+8
	TrZqRm+yT9Pe28/FvTXLRBChUxhXvK5ENG5XQevA5o2phniggoxqPnoMdSliLkMnANHLOiTVdgM
	k9eAT1yLNxeTCuDFd9pJ2qkHL9SO6YS32imcW7Ty0DyUMvfRSViAOgU0a0Eh4nrM1ZXVqrP0dLR
	iTtRPXiGTaP3EmXwvdap4JD3LY3etDJKH1XAsmvGj81FgXy7Ifl0s47Jng5L3ZFBOnAln+wh7Qb
	QD4367sAjHQFSQf/I2GdxNazUVEq0KavdYPO3GkmLOOxCZABnJLVx+VqNVvVm2HHSoKMKI28wPt
	FvO2Tlk9w/vmSXUDSnG9tVP7Ee//vjolkTWvEzIzZU+I/7HxOlFuPA=
X-Received: by 2002:ac8:5743:0:b0:530:d860:ffba with SMTP id d75a77b69052e-532fe9f05bamr29797891cf.6.1790267890993;
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb32f6aasm45064551cf.16.2026.09.24.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:38:08 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use
 vma_[flags_]can_merge()
Message-ID: <arVRqJZkql6sGunt@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:12PM +0100, Lorenzo Stoakes (ARM) wrote:
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic with
> two new functions vma_flags_can_merge() and vma_can_merge() and update the
> merge logic to use the former.
> 
> This abstracts the check and expresses it in terms of the desired behaviour
> rather than an arbitrary and confusing VMA flag.
> 
> This also lays the groundwork for making further improvements in VMA flag
> usage.
> 
> Also update the userland VMA tests to reflect the change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

