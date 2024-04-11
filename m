Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840E6FCC
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861815; cv=none; b=pLVz71M33dQPIY1OXfkgWsZPWeKrs2jK80gw0Yh0sylyaHCe7e7AMZvC0yIRS8PRSYXFcLmS8LJMuTp4/WsekDsayUM8245s+Q/nG63Zd1P7V6TTHMTjNukRco/3PPGanH+kiCMgwbzpjHqWDyzQbEkVueReTxPm/6RUNXkdQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861815; c=relaxed/simple;
	bh=BkM9vYHu+qyeMmH+VUq9zveHIqjsweQCNVJmljUh4Js=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UZECyVRfTRAUGY7kEFFEu4nFkN6WAwpMwD/91sruHMStxPHdhDdVLItv1ZUpXn3maZCCRWncngtxABTVMlDbCTB/HIdkahDzc0jJ/CL8UpX00WDcTpOBJuNy6oKTiMBI9d0ExtN+qi0QIWhZPLmP6yRsrpYxRbv3mMHsL4dHaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xVK/mCOi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xVK/mCOi"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cc8d4e1a4so1150697b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712861812; x=1713466612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGEHFGSvXh0z03nigzVMI+fVkzOE9PQp+ZJSe40gsQI=;
        b=xVK/mCOiA/Kb7nCukLZdG+tGFuLS+KvT/053/ZLmHykdecUeTkqS8Yd8aqADJHMszf
         muJHiSwPdeexhWko6Yt0f/QlM7h9FBPjfJg8RwUmDs0sj/80tKkdNEPtC/JbNvYjp5Pe
         B8wFm9WuhzeB5cUXtEl8Wpze1dxYr+iDq2J/MbF8eC1btz5UKHDU6d7KDySqXcEo04Dk
         NkO1mVQ2H/BrQSXjIR+3e9RlX1mvaFhGp2evkA9Vch1o/f5IjmmgN4YTwTWg93fAYloW
         m4kUQ/wQtABwm+R679sHYdplWvw5mMpKDhe4/bZGCG1h/7rD//gRkI+BIIICnhdl9IVa
         rX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712861812; x=1713466612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGEHFGSvXh0z03nigzVMI+fVkzOE9PQp+ZJSe40gsQI=;
        b=VgNN+nVr2DSAos6ec1XtKC/ge0hkcu98ib5d1KZcVOVZ9wWPigSue3HjaE1b4p/mYS
         Niq8S8p3vb9rTnFwwLJfuJkR+LB74A6s8f3z077SkyWorvUYBZWMFYiC4cHMRfvVSzrN
         HpmVdmNeHp91SChAecfFrzm4HCNWiVFlSInGv1efhMRtiD5TATKgLzb9NtrZrTVY9GnF
         UQICO+lhVknzEBjmWK1v3gjpY/JxEMAE9o1ThpvH/HK40KN/rN55BMZLe7tOmIeJI0lU
         6mR3z28PGxZA3XUHprEqaoYe9AS/33gsUZSs14J5BJqen/4JytS8bDe0KLVVcZ5IE0S0
         2mNg==
X-Forwarded-Encrypted: i=1; AJvYcCVRLzcnvR/78r9fYVLfLm91N5+zSFJlk0HISbnRpDHIVA0KBT3e7oCkiJb5JRGwHLOdG9/4Rrz+2QRZJ6cgQOUvDYLU4Q627QXuKQncLCZejg==
X-Gm-Message-State: AOJu0YxPDiC5cTRliOMiJPlOYn9+/LnUqlzRhJMfjAI2UWI2oMqXUVp4
	zt5xgcfUFxF8OENcHoYLh5AAGhgKzMB2k6Njs+GErzJK7TSiKrt/rLOvwNUOh4bH9UwTQJdwmwZ
	JrQ==
X-Google-Smtp-Source: AGHT+IEar8TRcdXvMuTPUVFnkSx1JlvfraxiBybj4p1JG6Jg8CcJxmn1OlXaUfN1eRDVQrA+4z/SonB6OCg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:91d4:0:b0:615:32e1:d82c with SMTP id
 i203-20020a8191d4000000b0061532e1d82cmr67605ywg.6.1712861812259; Thu, 11 Apr
 2024 11:56:52 -0700 (PDT)
Date: Thu, 11 Apr 2024 11:56:50 -0700
In-Reply-To: <20240126085444.324918-4-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-4-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhgycg0Bu0kL9D_W@google.com>
Subject: Re: [RFC PATCH 03/41] perf: Set exclude_guest onto nmi_watchdog
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Xiong Zhang <xiong.y.zhang@intel.com>
> 
> The perf event for NMI watchdog is per cpu pinned system wide event,
> if such event doesn't have exclude_guest flag, it will be put into
> error state once guest with passthrough PMU starts, this breaks
> NMI watchdog function totally.
> 
> This commit adds exclude_guest flag for this perf event, so this perf
> event is stopped during VM running, but it will continue working after
> VM exit. In this way the NMI watchdog can not detect hardlockups during
> VM running, it still breaks NMI watchdog function a bit. But host perf
> event must be stopped during VM with passthrough PMU running, current
> no other reliable method can be used to replace perf event for NMI
> watchdog.

As mentioned in the cover letter, I think this is backwards, and mediated PMU
support should be disallowed if kernel-priority things like the watchdog are in
use.

Doubly so because this patch affects _everything_, not just systems with VMs
that have a mediated PMU.

> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  kernel/watchdog_perf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
> index 8ea00c4a24b2..c8ba656ff674 100644
> --- a/kernel/watchdog_perf.c
> +++ b/kernel/watchdog_perf.c
> @@ -88,6 +88,7 @@ static struct perf_event_attr wd_hw_attr = {
>  	.size		= sizeof(struct perf_event_attr),
>  	.pinned		= 1,
>  	.disabled	= 1,
> +	.exclude_guest  = 1,
>  };
>  
>  /* Callback function for perf event subsystem */
> -- 
> 2.34.1
> 
