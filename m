Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3C8632B;
	Mon,  8 Sep 2025 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309014; cv=none; b=CpuffQP5sybq3HpamYSISwKRkxa262eG4eta4YCryYYB3lrI93WbWnMnZt5+4esmWorQcZ8mktaz+f5Fvu15sRMZ0F/EfLDA9fTBrfAiSFyt90YMwsgbJgR3pxj9ONwd+vTUXohDu7REXE1vvZIHnjAdHw/Jw1v3ZI1IEHJkmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309014; c=relaxed/simple;
	bh=qoMSDWzFRZW5H8NdH0c03/p7PhGqw8e2L/3XWt0Pek4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyYe89UNV2XDiqck7Ugv74WnYVUzuNK1NwWnQAYntir72HXkUaURIsOUUU6XgK8WIAPXqqEwUhUbk/hqe0shph+ZID4tf6sfwnLPtWk7XSxOE3ZXZV9OoGfaEEBzBIrvm+8kysop5b3dBAze+lXY/ya1nT3qpneCREPMTfhRnjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbV2Y6Lx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbV2Y6Lx"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7742adc1f25so1260749b3a.2;
        Sun, 07 Sep 2025 22:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309012; x=1757913812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWu2XYOMOTFu9B0WNwW06nL3LV01SW2Lw7noABGOmtw=;
        b=HbV2Y6LxVxRTm8J/E94ifoXBzTM4RV368SEbvbixlvjEqzvOn8n6Z7BqxPDFx3r8UK
         CNq0v/dhYthSD+HDjcPommpqFnlVM+IKD2ry5S7MQrGu2zutUEMBOqty9psqV8cmzniC
         64mHybiklaXf67UTHBRUue45QMUsYII8B4MPpzAOeRWS4AFE6FIfgm14wlZ/cnFJGIJ5
         eiRpxQQajA2OMa8Rn3cot2Ltp0EmDObSExEMtGkKojbsF3ZevWnJAN3tUBPSPqeqSc0t
         m/YkDBPyRqRABPZFUuObn6qoO4E84xXeU9Rn2nuxBj1+wcAGuh3ApGWOQBYsgHHGfyMb
         GpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309012; x=1757913812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWu2XYOMOTFu9B0WNwW06nL3LV01SW2Lw7noABGOmtw=;
        b=bUpKnUYyBcjgGeeGA8MLD8PuiFXmUXZYNdY+wyy+nQ5OHQpebqhJUTZPU65CxZjstT
         ohq63lERhGQVWW8vYSIKQTxv5Y/P5JoBmenSE2+Pgqybk2jzIUVk5LRHIycYFrSJtM/W
         PUzdmF/HIwOylGiXwK6Y3ZpHzQLe1C99RK2G/GPi0nBEjNceQeZAhYOKAwv2Y4Nyfg3n
         Ye9CVmByQMH4Wm+6D3SkjMP+rFWFhf39IeR4TCtxjQbzLw+qwaXlxI5mmofo81yK1hOV
         xqGrRPo4qtmnZZl9oOPOgugXVUX8ohrvKgjiKIxZryPnh5CzOcIDZtL0xn6RybtHornc
         tcrA==
X-Forwarded-Encrypted: i=1; AJvYcCUSy8nmAjnwC9rgbhNCDSB9T341Ss64QO2L6eTQSdiZNnE6HshJ7q5Bkl/UlyC3puCydP+AeE/OHV3uG9fvYeO53hdF@vger.kernel.org, AJvYcCW2BClmbzyG/NvolmQ8Fxul36VxeJyCkbBJs1zP+BWW7Y0DqDRwSgwA+SulCWRuasiJfM7v05YWjZffqcw=@vger.kernel.org, AJvYcCX0+RYGFpjUsvgSl/jbjpOHCprAG7g9kvhH00wmH8NB2GJwbr85qeN8dQUe88MpUo+HSRdIvVp0yNrbREqOU0dTfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/whU7uYrB+9x50EVJ+7wju9pruRN0jh+1jwNFgaJkRv4dVOV
	XgcHMeC3tupmaXkD/AQA9q5/ekPis39b7rlMUXqJaOGQzVEkiQFHa6B/
X-Gm-Gg: ASbGnct1xEVN+MnFVWofJUim6PG9XKKzuPuARtX632AC/hXz6TS4lvVi4S2C+zxr40k
	gKBpIBqXZEIZBLJ6p1+m0EffcFNSBSIOhlZNkhdHGxedZpyQ97ctcgI9Oj9CbiDnoHba4AlQTDR
	FsHtxgU++ynfxATHLg0vHWeAHzPKPtdUW5QhWN4MDWjQjeu97m7npzZXpG4a1Y0taGmiHnCqiyE
	jSVCsUtLSHFLqWaZnrOG0flKYBEKJQGJOBqYHkHgyYh3QG+38nbMGcxsz/vgg1r0oM5PC3xIjuu
	oB3b86vN710mOFb0Dt4wzb39xlajWFchhtff4ISk6AspgbFbUNr8eRhvJXa+QRfuN+DLGWdo/OM
	t/T3T5mAoYmVeDNH7fKjjyG8LiXOhFRLv04kUoWbcEZAC5iwK
X-Google-Smtp-Source: AGHT+IHhHv4Iu58ATI59YbrWBaYVLbKFXM/ClLr8aEJoJiAWuzKMQN7cVpbbtrr/dTshWaOeTRjAbw==
X-Received: by 2002:a05:6a20:7344:b0:24b:3b75:b059 with SMTP id adf61e73a8af0-25344130942mr10522566637.55.1757309011718;
        Sun, 07 Sep 2025 22:23:31 -0700 (PDT)
Received: from localhost ([103.121.208.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f992d3de9sm14051191a12.14.2025.09.07.22.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:23:31 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:23:28 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/18] mm/ksw: add atomic watch on/off operations
Message-ID: <aL5oUJEWSuRpH5S-@mdev>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-8-wangjinchao600@gmail.com>
 <20250904064659.GV4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904064659.GV4067720@noisy.programming.kicks-ass.net>

On Thu, Sep 04, 2025 at 08:46:59AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 04, 2025 at 08:21:04AM +0800, Jinchao Wang wrote:
> 
> > +static DEFINE_PER_CPU(call_single_data_t,
> > +		      watch_csd) = CSD_INIT(ksw_watch_on_local_cpu,
> > +					    &watch_info);
> > +
> 
> > +int ksw_watch_on(u64 watch_addr, u64 watch_len)
> > +{
> > +	unsigned long flags;
> > +	int cpu;
> > +
> > +	if (!watch_addr) {
> > +		pr_err("KSW: watch with invalid address\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	spin_lock_irqsave(&watch_lock, flags);
> > +
> > +	/*
> > +	 * check if already watched
> > +	 */
> > +	if (watch_info.addr != 0 && // not uninit
> > +	    watch_info.addr != (unsigned long)&watch_holder && // installed
> > +	    watch_addr != (unsigned long)&watch_holder) { //not restore
> > +		spin_unlock_irqrestore(&watch_lock, flags);
> > +		return -EBUSY;
> > +	}
> > +
> > +	watch_info.addr = watch_addr;
> > +	watch_info.len = watch_len;
> > +
> > +	spin_unlock_irqrestore(&watch_lock, flags);
> > +
> > +	if (watch_addr == (unsigned long)&watch_holder)
> > +		pr_debug("KSW: watch off starting\n");
> > +	else
> > +		pr_debug("KSW: watch on starting\n");
> > +
> > +	for_each_online_cpu(cpu) {
> > +		if (cpu == raw_smp_processor_id()) {
> > +			ksw_watch_on_local_cpu(&watch_info);
> > +		} else {
> > +			call_single_data_t *csd = &per_cpu(watch_csd, cpu);
> > +
> > +			smp_call_function_single_async(cpu, csd);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> What do you think happens when two ksw_watch_on() instances run
> concurrently?
> 
> What happens if a CPU comes online/offline concurrently with
> ksw_watch_on()?
Thanks for pointing that out. I did not think much about it.
I will think more and address it in the next series.
