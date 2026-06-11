Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDBF4D8DBA
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204094; cv=none; b=OoTYdEun6ADNweGlncVsCtVoLGIzfMM5lqLD2t1oWMLsMmHmqblPmhM+h5J6PFcXSBkI2NcHMmiIMPmwHB0519rUG6aahWDLzorbnKTOTgFui4zPtXzZGoz/OpsUjtXtft+gWqvK/dFqYtylPCZ1nCSGyLgs0J0tIYij7FWJ2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204094; c=relaxed/simple;
	bh=6Dfy7SEBpWaNg3DQTkQKNi8rsPlexhOmoWDAiSj2NZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+5yL+Eq0ndrYsSQpHd97zlLqzLdMmEUxIx5j5lU1esubHSYNvokRxzydBuqVZIfwV+IJTPhRcoxUzWzW8Sy/3uUG0BKa4CLl8N6c9To7QeYBMrqP+2XPNGkGEhgrDe9N1btR2UVrxofuHg1phSf0R4EykiHnfetzeMXGE94eyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7UPz3Re; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7UPz3Re"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so1156795e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781204091; x=1781808891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIp60jOuw6YasJhSGuwVtQdUMJRmifSkGDIQOjmNbzM=;
        b=Q7UPz3ReGTSF2nqedydjX1BD+yJ1XfscRpl1TU1/tgRw0isWOXCR7rK2ghvlLq+xYi
         TsKAwhWrvLSnxmjsdx3m7ZaYlIagh4Mf7gADae05sBcG6VHn8Pq/DhK9RY6n0pk3xJ3Z
         al5WUzAVXcYjT7t48DlWhQ0gWs475LU4NveMZkYCZ8YKMGj7veMa1VJCWrXW8OygkNrX
         MDkiPUAJqnybnL1zmbPVRD2s6yTQdVx7Ks50sl7g33OD2kXPx/muASBoWpcV2jy6Yg0l
         pC2uQfEZYTRG15lT40eAxEPcQELxt5lL6PI9m911EfxMS2rNRYuArr1jOo3cSmD2MA8O
         dbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781204091; x=1781808891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIp60jOuw6YasJhSGuwVtQdUMJRmifSkGDIQOjmNbzM=;
        b=IR24qcu4bgCUmh5EyIwJkgFU/KzKJOOglOroz1vMSgoY8hpBVz4WWzuu9I0rJyhSpF
         nNDMpCD69W/sBpN2CzzDyH4EXX5wM3WfooaG6fmLS1xzTQjnggIF/JseUttrq3bHqlrh
         HQML6GZW3smdD5jnL4SNvUGPCqzqP4Nx9mCvRXETdCklsNb06juOsAM74CG5a9D8FugG
         UqmDeD0sdNx+6wqD75A3L9vuzFiu3K9dc8nIp0jKFQtHwQhTNT/BYlt+XC1SrrW8H5jW
         PE2mD98vACK1Y1BBWNuexkSPWGqIO1fqsez8O5xi2l9J0i+E0WLclwzj7uD0pE4pYt6h
         RnDw==
X-Forwarded-Encrypted: i=1; AFNElJ/cEbTVMHfgi4jD4QrVApEF0JV+JGKmzEL/8F3+Rb9bScjsjF3K2tQ5YBkrCMbx+iUdHBH5hyp0gdUGMVnp3sEN@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzhnTnJKc2/Gcy9mztV7z/lnm+R9ZQnbFlPXnu3i0BfitJi7z
	83ci1DmajsK8BmzlqZ5lGPirDDxvHxhR0jBUZYR2BuHpZxOr6RwxVU7s
X-Gm-Gg: Acq92OHvN3AMrYbBrQJxV9SPrQfaU/5VsceUy5ODu6x7TR/PEL0PFmu7aOfbTKUeJ3l
	u+0xOIgGuprdZP+Sp9nxpMqQiEr/ltTp3+y64K+DtfLP0o766czX24oFUgQtR8MEE3+y1qzFVi8
	Ct2wnENG3MIOHAihlgSkoAUFkmVV2dnSzWqz4OcXJpzVWkIARzRQOqLCb69UNwo5xNGhc4p+ITY
	HLiRkFymBRXpgsSNnfm6OaU2TLpFQ39H13Ks+sTL1XKpG7t8i5DdEbnvB4aoljxSXVlEgXMXx3B
	H9rv3mIa5DJxC3nvsWzfjyVMWSuXB4+tyOXSSNwoUA/CFDeK9LSLs73KZOM3uk9jrnOjfskbBlF
	ndSP9EqK1dxL4neL0br4lyqvptIwMMMJncK5ESCSK69NnkUNU01VEtX1XMYT9VNnD+DutxYkBut
	/oL/JvHJ/eZv/syQMBfJW+6qVJSrufQGgSahww52dOabyWz/4Ox0P8kFJrkEnc
X-Received: by 2002:a5d:64c9:0:b0:45e:f46d:fa95 with SMTP id ffacd0b85a97d-460673fbc3emr6880851f8f.0.1781204091090;
        Thu, 11 Jun 2026 11:54:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606c0c2442sm1048525f8f.1.2026.06.11.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:54:50 -0700 (PDT)
Date: Thu, 11 Jun 2026 19:54:49 +0100
From: David Laight <david.laight.linux@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Leo Yan
 <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Compile named_threads workload with -O0
Message-ID: <20260611195449.7230e316@pumpkin>
In-Reply-To: <20260611-james-cs-unformatted-per-thread-fix-followup-v1-1-3c855d93dba8@linaro.org>
References: <20260611-james-cs-unformatted-per-thread-fix-followup-v1-1-3c855d93dba8@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 12:13:46 +0100
James Clark <james.clark@linaro.org> wrote:

> The work loop relies on the compiler not optimizing it away, although
> named_threads_work is not static for that reason, the compiler could
> still do it.

Isn't in enough to put barrier() in the loop?

	David

> 
> Fix it by compiling without optimization. Also add -fno-inline for
> consistency and in case anyone wants to look at callstacks.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> One trailing Sashiko fix from the "perf cs-etm: Queue context packets
> for frontend" patch series that has been applied already.
> ---
>  tools/perf/tests/workloads/Build | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> index 75b377934a0e..7bb4b9829ba2 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -26,3 +26,4 @@ CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_inlineloop.o       = -g -O2
>  CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> +CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> 
> ---
> base-commit: 7336514f41e75d44782fee7e0990d4195a3d3161
> change-id: 20260611-james-cs-unformatted-per-thread-fix-followup-babf28a4e640
> 
> Best regards,

