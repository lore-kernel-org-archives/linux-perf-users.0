Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2B2153D8
	for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747264880; cv=none; b=KVjPFvgUTtrC3bPfTQ7Kx4RMQcGYo3M2g5/Sj5xCxml2DvHKUTPZDDIvbz7GCCYUwroeEeaSJLm2OaCLL5e3WqCGgD1QCQliCHjo8Cdh3QZV/amAclbCnoyyzWLypuDXJfT5wNDK95pCz7rj03U+PCUg513Ep4CyL8zvsoklnGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747264880; c=relaxed/simple;
	bh=YEKXLYRf3Z91CVsnsWfdQ9wfCYW5gqK6f8e442q5Hiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dzJO3RWK9NUbQE6e3icys8cxAYeOvs6qfbKrx4so3sJ+B1w9Q8YWf0uqvim2q0csndRYDdC1o1UuaAV8V5QmHxoJhSovIdHlTyn/VIX3pgAeNSH0T5Rxd42XHnk4nOkpoCquWjAXexJrwfonjF5TjUEMQCI21NtPDd0UTqDXzq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xd7F1Oye; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xd7F1Oye"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26cdc70befso159095a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747264878; x=1747869678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0W5oRAU5Tx1bBNWhYqi9a+fsUdga8B/qghEhaqvlHzU=;
        b=xd7F1OyehJBJvB2ccUvc1pKbtQVY5d09+V8IxScIfm8ZLwDX9UjVOD56BcsIxCzNzn
         rOyIJsHArhieQweztEahZnvtMw/USUgm+zMrAaFzNUbNARnmgoiSfn0FNt3M7WU8WyUj
         m2itZn6ay/9gZwfo5OTyWFLWgI1rGPzRndG2NK8orSxQCGnavft5U0RgLQTOMRn64+8e
         LYmDrkJNfgyeIi42TES2rhHKsPnDzsVosuz/GhQ7KPWfa0UcSz/cXSB2LlL+z6Ua4/EZ
         KxiBo+q+aCJKIBGZkpU8dtKGBEl0Eetv3/wIEvqA85lixJW4B3dD6oNqCCNm7iVoupP8
         O+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747264878; x=1747869678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W5oRAU5Tx1bBNWhYqi9a+fsUdga8B/qghEhaqvlHzU=;
        b=gDJ8stb1PRfxKBMF7H/Gt8jNbPeFnzXakXeqzmenIWiAB2T7F7A87pszARSTMu7dDT
         bzMZGxRkVhM/0NxACwBc4Yd/R1dgl4ipb1FeNM5Bkd8P+SuctwUBWYp2cl18rFCkFC5a
         f/z/TgiBq5ggf58obWj/BRwj8tntvqnmfHHSWSNDFEq8EUDrey73d1GvJX8phaDUY2fA
         eoXPF5jEPBxGvApZoWucSxdXjjzHa9S5firzDqGKG8QW6A5qLgz5B6/9I0nnsxV7aDsl
         DUfwIInrkMEe11Yd9iTo4VHf5bJR98EtqP4JwyFVyOTA6drGNrobFJYTKaCugaqALC/U
         BecA==
X-Forwarded-Encrypted: i=1; AJvYcCXyZeykASu7kcKGYdEQhFISWhkXlbs/gArgwTZs5RWtbM4kjzUN6wiV9+4s+Oo1Ac+4YGP2hV9facgLIjy+NJZX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj3HWjYtWm3TSWF7fhcRrjSuLfMTC7hLAXAGDV/dytwjvr5Fi8
	q9ymlnHvo5AjF00dAXfLScwNpV/JE1PzXlZi1C1Qvjyupv+Pv3z6SNDQAHEm2QRHJOWaIdLUqQr
	daw==
X-Google-Smtp-Source: AGHT+IGTO73AIKyjnTSCUICJ5vVeiHlgCc/yVjvzHrQyDqfhwzwnQP3wljVXsvhihVqXHqt1ySm+522Vois=
X-Received: from pjuj4.prod.google.com ([2002:a17:90a:d004:b0:2ff:852c:ceb8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:564d:b0:2ef:31a9:95c6
 with SMTP id 98e67ed59e1d1-30e2e5c3177mr9009619a91.14.1747264878446; Wed, 14
 May 2025 16:21:18 -0700 (PDT)
Date: Wed, 14 May 2025 16:21:16 -0700
In-Reply-To: <20250324173121.1275209-7-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-7-mizhang@google.com>
Message-ID: <aCUlbDNoxQ-65mc0@google.com>
Subject: Re: [PATCH v4 06/38] x86/irq: Factor out common code for installing
 kvm irq handler
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 385e3a5fc304..18cd418fe106 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -312,16 +312,22 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_x86_platform_ipi)
>  static void dummy_handler(void) {}
>  static void (*kvm_posted_intr_wakeup_handler)(void) = dummy_handler;
>  
> -void kvm_set_posted_intr_wakeup_handler(void (*handler)(void))
> +void x86_set_kvm_irq_handler(u8 vector, void (*handler)(void))
>  {
> -	if (handler)
> +	if (!handler)
> +		handler = dummy_handler;
> +
> +	if (vector == POSTED_INTR_WAKEUP_VECTOR &&
> +	    (handler == dummy_handler ||
> +	     kvm_posted_intr_wakeup_handler == dummy_handler))
>  		kvm_posted_intr_wakeup_handler = handler;
> -	else {
> -		kvm_posted_intr_wakeup_handler = dummy_handler;
> +	else
> +		WARN_ON_ONCE(1);
> +
> +	if (handler == dummy_handler)

Eww.  Aside from the fact that the dummy_handler implementation is pointless
overhead, I don't think KVM should own the IRQ vector.  Given that perf owns the
LVTPC, i.e. responsible for switching between NMI and the medited PMI IRQ, I
think perf should also own the vector.  KVM can then use the existing perf guest
callbacks to wire up its PMI handler.

And with that, this patch can be dropped.
