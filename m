Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FF155A59
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490290; cv=none; b=DArFj9xII7L1RJqSJt7pWAr0NG3T2SxLa6EBB1pPEYthiUD+kWGwSqJdkH4HQwsHY+Xz/CREqpUfxc/KqrO3UMOcJ5YYFbsU1TX+nGlXf69iw9tedGYikzI+vNfX4mDTeOwbkvt/rsPbxRdwFH1VkW5ZSZKY8D5iWw/dhjuIkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490290; c=relaxed/simple;
	bh=7EhG9EbVTGqEsiK8x+VNzz9p7fj5lCIpORxLSBcfrP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzoGhppa+KXor3ruzhXsorB8JNV17/HaUu8/x85aed8WNDI03iXAu6w5Q3BhANSn4B7JPZ2TpDvqghnv3dxdxYRM+5ZK7tHH9PQ9uC+gk4zj+tAhxqCXG09bf6gh+0GEa3xaIwwX1603M9coq6EOrOguwLZaPSC2YLwreTyRwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Jqmv/nfq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Jqmv/nfq"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c2561e8041so3683401a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1726490287; x=1727095087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KNBeOEHGq7Pser7VzvbTspy/A3zYw7bZRrBFbZEGNjk=;
        b=Jqmv/nfqpoO2L99oG2ltOBigQGM4qVA/mZLBR5mir4GfsVpT1NXcdXPfR517WwhlMS
         0zdoO2HUJU6MPwnk+eLaUW2YxD8PxPN8mKjEqf0DoU1mwP5wYHtGRLE67AI+FlDPuQws
         p6BuvD4CzCfG6IO/F+Ul8QdysdDIzmEBzh88JXJTsuCkZbyEfvtHYyFa9C9HZCM/TzNx
         2CfzOqsik9zVHNDVhXtie+F8RZTeAXuCgV9OzhTAiUPKOPpU/q4FMRe74FXApG8qVuvG
         9nrwhNlxU1B1VYIzD01NPjymKACYwEdEa0T45FdgCqNyRAjPUAb3vE0vuhjchAbfXiGY
         ZsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726490287; x=1727095087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNBeOEHGq7Pser7VzvbTspy/A3zYw7bZRrBFbZEGNjk=;
        b=bpZpzi0mM67klak8iQWFA47pjUg9PaGNg2lS07ErcLt9PzIhMdtadHCh/dTkMxqNZA
         yoLF1+0gkoJHEwot3hTOpgMDg1MiX7lj/k/VB7IQPYg8cg9eGNhJiOP9Fdid6+WvWjbn
         krc1aZziZYmgFcPKIl5pS8VtMYhecACHzYZS/s9arc3ng7+QGeT9xqi/T7Vs5nlKfJah
         VaZgAyKANuix6oFnufpYktbbk1OaC4859n2+CBtxB1aQR2a9E/t17lYbHydlM+X5D14O
         M8Z6pXpps4mBgoxSC6HSqdX8hqOhGLzAeWkE3Gh8EIwdqTq3aoSTPL1GKbKavplTBe+G
         NtIg==
X-Forwarded-Encrypted: i=1; AJvYcCXqcEwi5ff3HiCzIWjiLFcoAelg7GAIR8lBsUevSqBNOTz0CaHuNTN5vdRPvVKHQ77nFQSYEbOlngp5cV0tN6C6@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGA7QBQjeOMM5aM76HSC8xLuIA0JEocZLSjWCgDv37YfOhbe5
	bivpFSgGt9eXqf4QjNwidKfX3VtcEkgNrp78eYA5p+p0Db+PaAoosfNQYXPfEk8=
X-Google-Smtp-Source: AGHT+IGOZcpAXmdIVEV2vYM9IhWJaJecvzLcXzXO10w2tECmYppWvm9paxVvWFyfXx7MUbTlLrDpRQ==
X-Received: by 2002:a17:906:f5a9:b0:a8d:51a7:d5ec with SMTP id a640c23a62f3a-a9047b4af68mr1200972366b.13.1726490286251;
        Mon, 16 Sep 2024 05:38:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3a0fsm308834866b.117.2024.09.16.05.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:38:05 -0700 (PDT)
Date: Mon, 16 Sep 2024 14:38:04 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/2] riscv: perf: add guest vs host distinction
Message-ID: <20240916-6f21ff3d12224f366ccaac6e@orel>
References: <cover.1726126795.git.zhouquan@iscas.ac.cn>
 <c62057d587f075a64442df1038fe27b52b89c997.1726126795.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62057d587f075a64442df1038fe27b52b89c997.1726126795.git.zhouquan@iscas.ac.cn>

On Thu, Sep 12, 2024 at 04:00:29PM GMT, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> Introduce basic guest support in perf, enabling it to distinguish
> between PMU interrupts in the host or guest, and collect
> fundamental information.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/perf_event.h |  7 ++++++
>  arch/riscv/kernel/perf_callchain.c  | 38 +++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
