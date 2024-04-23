Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4613D53A
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891086; cv=none; b=Csi759mlqxWlyKBKJjBVuHHsHqii+4/BDJ6ohcZJu0rowbDydUrWQY2Ahf3uQbrygRbl3gmU5vUmCezz7tu42Ot9WkFoUGYybaDd09kUz2MzEhkygcc1MmjycXenQ6Y6nyBMJqItjU1RX2yU7GwUSrSD6a55gx6cmLadvL22IOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891086; c=relaxed/simple;
	bh=2l+5UdzN7ZbavXU6zUsRnpsRb/FYFC3ss2jaeR0uYUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah68MZduEdqMEsgM2LraT1r97wwqxDvi1gAfqmpATK48GCi+oWdW3sf7o8qI18nr84Vt1LIjZOGCl9XhL3xxbaOEYVwWxZ4XQnWA/oY1lSivdmwcpLzQttTpy/2QKM2AY6sNJqXnVZOEYmg6sS11Y3bGjMLSshA7cXkrDFjIQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRHr9XCg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRHr9XCg"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a557044f2ddso656242266b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713891084; x=1714495884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2l+5UdzN7ZbavXU6zUsRnpsRb/FYFC3ss2jaeR0uYUU=;
        b=LRHr9XCgR/FtF3nn5eyf4zb2nh2aAatbTtVsn4VcOsRGvtlmRVUClFElmyHGsmIG55
         XfTDKx4o3QV3DqTenAWvlYV/bHRTENmgvme7O1gdyNeZHBOEs6+U11QSQWUmyxaEQPJN
         ja0BwmlNaM2taRB0lZGVLfDyJOqE5gxUli6lxvA4Bt0nWsE/VnL+ZXtzXHj+ZVeQt+x7
         hUByO5nqRZD3pjVz4gOD2tG8PGXRiBze5hlw2qwzmMUJQBM1ttyRP5jBU6U8aLiwyWha
         U7fKHCauKjKKyDPIAgVhVZDhTgxYZ0iyVzShks4xCAWvcTjd0syLZJmUo/wH57NsQAc1
         AJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891084; x=1714495884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2l+5UdzN7ZbavXU6zUsRnpsRb/FYFC3ss2jaeR0uYUU=;
        b=UVf6j4GzXFeqjaVZVcWCyeDLfxRYJR+6I95KleegIPlTU4Rq+r4CbowsdgadK5LlPP
         MJuxApD5AIi46rQAFVafdMHeMQHKboq29jqMEwnQVDLxcdhBhyo0ym8UyTR4EiGrICt4
         KmZzWEoOhinA8Y9MFUxHL6eDTLq+GiPZo8AG+ByhhtTznKBT0uLRAZmPRXN8Gt1XdcDd
         vrEJiifEIGGrlIYHTyIeXnFtBnY3AxE/eWMEhlKIUVtxjPrXe0Qv7uLbK0URawJvX1IX
         RRz51kMK8+sOQffKkyM0P9JOlDzccWv8EC/pJ5h/D3B+LQtEAaRE6Ha6ggdr4rx1guFZ
         Mdgw==
X-Forwarded-Encrypted: i=1; AJvYcCWwDo4MBc2UA/Zj00L8Orn2s/yOkngs/HZRNPYT5cLfApfTy9ubhtjtulendNhL2I//wCE+Iu2RcANLLwiXDiIYpE/tLcdRa94h+4v8gzldmQ==
X-Gm-Message-State: AOJu0Yzu5a+TeD7c/JhsifkvqKAF+tXQYJETyVvOatHoNGZ6yb7kwpZr
	bCILoQKSx2194086z6G3Q2jmunhj9PdYpVX+mxtnDMexHVw3Rj80xdYyIxGZ4Z6+ez3EUr2DOBl
	lGGysWRGHz1PuX87sOQzaqS3PN09zifTimCuZ
X-Google-Smtp-Source: AGHT+IEUYXbroPWIegwIe9uOSMKwRDxhQ+zZsIaEyJugWTF5WG0C5K8peKi60BHk1tv+7Q4IawZ95Nmnfs8+lJ+y+Pc=
X-Received: by 2002:a17:906:615:b0:a52:3623:f498 with SMTP id
 s21-20020a170906061500b00a523623f498mr10162882ejb.31.1713891083421; Tue, 23
 Apr 2024 09:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18b19dd4-6d76-4ed8-b784-32436ab93d06@linux.intel.com>
 <CAL715WJXWQgfzgh8KqL+pAzeqL+dkF6imfRM37nQ6PkZd09mhQ@mail.gmail.com>
 <737f0c66-2237-4ed3-8999-19fe9cca9ecc@linux.intel.com> <CAL715W+RKCLsByfM3-0uKBWdbYgyk_hou9oC+mC9H61yR_9tyw@mail.gmail.com>
 <Zh1mKoHJcj22rKy8@google.com> <CAL715WJf6RdM3DQt995y4skw8LzTMk36Q2hDE34n3tVkkdtMMw@mail.gmail.com>
 <Zh2uFkfH8BA23lm0@google.com> <4d60384a-11e0-2f2b-a568-517b40c91b25@loongson.cn>
 <ZiaX3H3YfrVh50cs@google.com> <d8f3497b-9f63-e30e-0c63-253908d40ac2@loongson.cn>
 <d980dd10-e4c4-4774-b107-77b320cec9f9@linux.intel.com> <b5e97aa1-7683-4eff-e1e3-58ac98a8d719@loongson.cn>
 <1ec7a21c-71d0-4f3e-9fa3-3de8ca0f7315@linux.intel.com> <5279eabc-ca46-ee1b-b80d-9a511ba90a36@loongson.cn>
 <CAL715WJK893gQd1m9CCAjz5OkxsRc5C4ZR7yJWJXbaGvCeZxQA@mail.gmail.com>
 <86d1f6d1-197a-ecd9-3349-a64da9ea9789@loongson.cn> <729c4b30-163c-4115-a380-14ece533a8b9@linux.intel.com>
 <CAL715W+BpyX3EeKr=3ipMH8W30wmhMkxg2Fx2OET9cvQ480cgg@mail.gmail.com> <46a889c4-b104-487e-be3e-7f4b57c0b339@linux.intel.com>
In-Reply-To: <46a889c4-b104-487e-be3e-7f4b57c0b339@linux.intel.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Tue, 23 Apr 2024 09:50:47 -0700
Message-ID: <CAL715WK60PeB5kmStfKq9pFb4CMf6DL5hjM5kMXEe+5yE_e_gw@mail.gmail.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: maobibo <maobibo@loongson.cn>, Sean Christopherson <seanjc@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, peterz@infradead.org, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, jmattson@google.com, 
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"

> > Is there any event in the host still having PERF_EVENT_STATE_ACTIVE?
> > If so, hmm, it will reach perf_pmu_disable(event->pmu), which will
> > access the global ctrl MSR.
>
> I don't think there is any event with PERF_EVENT_STATE_ACTIVE state on
> host when guest owns the PMU HW resource.
>
> In current solution, VM would fail to create if there is any system-wide
> event without exclude_guest attribute. If VM is created successfully and
> when vm-entry happens, the helper perf_guest_enter() would put all host
> events with exclude_guest attribute into PERF_EVENT_STATE_INACTIVE state
> and block host to create system-wide events without exclude_guest attribute.
>

Yeah, that's perfect.

Thanks.
-Mingwei
