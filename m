Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42882424D70
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826025; cv=none; b=F5xR9W1cw3OT/mnv19Q1fqBcXMIC3mM5SLoeUdy6bn0hWgP7LnIFSZ3YSdHFW29d4QtC4I+ky2eNpSjgDSjw0J9WlVBfAKCt/nvr+ut3Z1S4nXfb5ADQann7iz73GUrLUBmxmsuuD0Tias5u3aa6x8Iesh47fRqh2eAPdouT6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826025; c=relaxed/simple;
	bh=uyj41NdzjqFdtF1mTXfNgjv5XKkpGGT0Dwj633J6MNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICBFr12Rz+D7O8QJjAqYkTGV9rISOc/AThtFcP1vuK9UYgoBKZzCSo15+Oos508ypLWNiX4pye47wvTAhgVrGUGB+dtu2BYUX6s7brgr4jXM6a8wFmnP2IeTzbJchqoKBkkJhylwiNCyHT/QEMgKM8vM0im0VU8PclCteVjemSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Anu4Cx1G; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Anu4Cx1G"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so1132328a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787826017; x=1788430817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RHN2hwBNs5IN9u9eTuIPZ9+qk+rdBpKl5uG/PvdzHEc=;
        b=Anu4Cx1GFWAkzLncVqwej/h0Y9runcde1Lce6ERC/v5hvQkR9j6I1rNyMnSPt3XcFq
         wHGH+JRW39UlbcyLm9OrfgFWWiexeWzMC271v78SZd+8ErSnwtJ9IqhyPttkhJ58kD+J
         lv6KypesyOlnmln3lvAl1fDqx80QLwTGXKOOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787826017; x=1788430817;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHN2hwBNs5IN9u9eTuIPZ9+qk+rdBpKl5uG/PvdzHEc=;
        b=hpMDJdC8TS/CVUv0L6Xe80e/OoDkuxZQEmP7B5RUXEwqMOpBwkTWDv9j3ysrfUKLF6
         7Ntdu7VZJubWSI0juQZNdZDT75F94zk+77p3jlXMCGG7XuEN2p2fDcqT6DbNVmu0ctdQ
         qFMIs6/VOIJnn4feBnTy845N6BWQL54SwvsUNr5yciDXLbwN0TR+pntfKiNOK+1qod0B
         +PCK973tKt10A20ULAWBq4ZUMR2EWMrx4apza0JHh/OZ+hqg6unOezOtdzmHoYkybPdI
         8pXMPCa4AV/vf1UAAgcm8SMcSsklzpFOjBDsPv2jHrMbxlbFd92xZQ274n6nUFPh7U7R
         VF4w==
X-Forwarded-Encrypted: i=1; AHgh+RrcLs0DZaSaEDvizbxEscUBEIDJbQKMZoK6Z0Wvr0CHmxDZsmvwtw+K/X+fea3EjCK7A35hkVn6PeFrtbMGqHXo@vger.kernel.org
X-Gm-Message-State: AFuF++l2f4j+23+GzSXKzW7JBDJ+XseE8nuDJBVhQlD+DflR+iVC3szs
	s689+if9cgb0jeUKPU4+gKumzhKimsZeq+GOMW7bCFpYLeiqtmVU4Nf3z8LJFW190g==
X-Gm-Gg: AR+sD13mLYpGvL0cZkHPW2hQVfcqjb7RoczbC5eSx/Q8zUkB1MyaAubhrvSeVb854Iw
	0PH6v7zRlum9gJjiJq/xGWoYAeD9jc+gACV+ebcDP/Gh6sxLNa5esEDpg13GI4HhBjgcGqwAsVY
	Uvr96qYO+zHw6jvikmm4yg1pPDCIrRIGNFKi4JMDltNG6hiK/9GXJoeyeingKFqk58msarBNfS9
	jerxM29Hw3vlu4gDP6S1HpwS024M8d9jZvy2LHFhROk5nlr0NAdqn9Mi9Vc0a93YbtdyRnq2gOQ
	Ay9tCOyLoojJCbkejg+Nvodoz2z+8e8vIOfrXhDrMx+Bz9gH07ygK7gY1vjIU/dbQkjkVdJkrZq
	uJNrs9Hp8d/Iyd7NkQl/Hjqidh11dWLYjDuFA1aUwptqgizm78i1FuW9QULMRjCpNSmbe+VlkrA
	/rNLwRye08/Hjpr4xRlu8R2svg0wIME0emnYceAvMw/0daxh0Y5gkZWUK+T/KpEX9hWDzDM+/+q
	qgUCBBHkPCi0kK/WzdV8rIIcQU=
X-Received: by 2002:a17:902:ebc7:b0:2d7:3c80:aa02 with SMTP id d9443c01a7336-2d73c80ac0fmr57449955ad.10.1787826017452;
        Thu, 27 Aug 2026 03:20:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:ff0:ad84:24b0:9e52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70493f729sm15576855ad.2.2026.08.27.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:20:16 -0700 (PDT)
Date: Thu, 27 Aug 2026 19:20:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf/x86/intel: downgrade alloc_bts_buffer() WARN()
 to pr_err()
Message-ID: <apAPNE709y7724hb@google.com>
References: <20260827065529.3835720-1-senozhatsky@chromium.org>
 <ao_gFsBR99s0sUBT@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao_gFsBR99s0sUBT@google.com>

On (26/08/27 15:59), Sergey Senozhatsky wrote:
> On (26/08/27 15:55), Sergey Senozhatsky wrote:
> > diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> > index 8940f0292229..29c24b2925a7 100644
> > --- a/arch/x86/events/intel/ds.c
> > +++ b/arch/x86/events/intel/ds.c
> > @@ -918,7 +918,7 @@ static int alloc_bts_buffer(int cpu)
> >  
> >  	buffer = dsalloc_pages(BTS_BUFFER_SIZE, GFP_KERNEL | __GFP_NOWARN, cpu);
> >  	if (unlikely(!buffer)) {
> > -		WARN_ONCE(1, "%s: BTS buffer allocation failure\n", __func__);
> > +		pr_err_once(1, "%s: BTS buffer allocation failure\n", __func__);

I guess also can just remove it altogether.
