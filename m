Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25D2DE718
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931227; cv=none; b=snbnxeKs5k+fpaWIiLfPqE3wAxj25sYJLZseB58F/PmIwfOCAD4Cyw2pEG1fDtnps6a7aAc3+V7XzQUIjSgvG+U3mO8NV8RkgnlepJasmdFipRw55JYaWt9gewFKOoqVlHMhbq9zVrakuJoHCMP9rP5V/uZ9yukpogTcfLj7evk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931227; c=relaxed/simple;
	bh=K5cb2Ag3Ltt8vqf0qcYqu7qQhHK83SWemQp0eng8oe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/7dFQXt7fe+0Pk084v5/Q4nt9OCwNtKSCjW/WQfNA9FaeqG1JrAAD+N1X367LKB3E5wZC+QYpY9ndu2FPm1MrWiUe/BP0dXzNDMzm1dp6/MHfoAbms7qI+QJPYbbidnWTKQJSe0IVWBZsVONh+SBsWPO29+rnv9Pp5u0bmTnPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJppgZuh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJppgZuh"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0418f6fc27so43629266b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756931224; x=1757536024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yDlCIvq84MKyXPm8Ow1snYfB2SvaU48Tu2aP8oyfTO4=;
        b=qJppgZuhmHO1G8cGw4WAeTJWU68v0DPYAwN/suRpnPOX8FDZrSKcTQH3SYIckAV9h+
         XxMhVvSLO1RUYkJ/YUuXDdDUHtmQ6MmyDc5sNTIY0WfToXGL1yNjW2tWL98G6BR2CoI2
         Ptwh8BdikudSl1T+RBIlUln8yv/9TNIWhsfraX3Tf+xOpqq/EzcODzZ86ne/WNU3vPt1
         j8jmOmrYop7Wd9z288JU+LD+6iYhNiASIvFRIi0YfcltU/EQS+e0CIlMadKajAxoSgCG
         RKBqVPFE/6kU0RgKhtoeeGo1rfAI/ebfw7eXj5LWlbpBjkxZNfticiY3amxedA+BP1lB
         Y6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931224; x=1757536024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDlCIvq84MKyXPm8Ow1snYfB2SvaU48Tu2aP8oyfTO4=;
        b=QUne49D3+ll995teKL6TppN373r+PEc08IK2DsNPp/xh6n1Nwh0+IUYfCTSEwsSoIL
         Qp/b/S+zoqCePkOEdQJihqgDtyoXX3EGIAdXzd16NpKZlVF+k/L4pEysrDoLk6WISjMN
         Qt9Z3YlSyVbeFdMJeZ7x/Kb9KZYej/XmmJCx7vXEWPX14luIZzi0MKH4RxW41rxdb5Ij
         2q4AICgJ8TGejIyYkHXGkdrMsZmIHwOj5xiWkoM46ej5OMhH4AZ2a46z9zPk7Nr9+EUZ
         ScGH5X+vYZpFoIoWxWb67MQVS41qDCM4wPWDb+KGgnmvbvvhZtLBv7WbYMou0s7fGqaW
         pxDw==
X-Forwarded-Encrypted: i=1; AJvYcCX1j0fG11vKxUWAXYnc5GVS38jxhwcNzNt6SfxK+IugRKCIIl5G8Hj+ujvlPt7dBORL4MX1OOclzgSTqr1Ov9yS@vger.kernel.org
X-Gm-Message-State: AOJu0YzaMl5tquYwDji10hMeV92p9qDXRN+HTYFnsLkfUOwDOMdtHXrO
	fqDInrHXC8dZCKvg5MblCWYzPsa3ipsMYqZGIh984+/2vUDoh4Gjpdbv9d3LrTH3s70E7nuEvSi
	PaWzH8215w+bG5Zp6XUzlHhDjIIFlcnzOx5SfHJco
X-Gm-Gg: ASbGncv2gOuukVG+Pj/1cbL/4HQvJTNRNvB8n3gL8PXleGbCsbdi3Ve0jUhWsczI6ub
	cc466FrccHyEJTL/lbZQJ0MrykQpcxoQeCkoh1vcmRAUC0cjHkgrruwMdsi5SbsgMLVHJHLUinl
	Yz53cRBM76UC3pf+G9ITTFdLLWX5EkH8qTHGipR6gMXEkizLbB5iqPtlvtCbi2W2JI1xUWz+YdB
	yoiNPvl+7wO1CZk9tlCL6jbZGLVWt8lI7VDZhdp6/oXCMx/FwrgU4rW6fYyndJyYQ==
X-Google-Smtp-Source: AGHT+IEbHaCIIe299yWYOSoPqR47Z4thD9poSLa3/b87xSS9PPrV/EzUbSMB8e9hNc7scJxAqa4KQvg2xsR5ZR4LgL4=
X-Received: by 2002:a17:907:da9:b0:b04:7880:3e88 with SMTP id
 a640c23a62f3a-b04788056a3mr133873766b.18.1756931224249; Wed, 03 Sep 2025
 13:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195737.225824-1-zecheng@google.com> <aLKknf6qFxVgN3gJ@google.com>
In-Reply-To: <aLKknf6qFxVgN3gJ@google.com>
From: Zecheng Li <zecheng@google.com>
Date: Wed, 3 Sep 2025 16:26:50 -0400
X-Gm-Features: Ac12FXykccIYcG9bPxZD3cwKt34GI_MEBjFLOzP5gRg53pY0R13CjgOBsUMBK2c
Message-ID: <CAJUgMyKBFkF9rKFnzP6S_c9ma3P7a-NsCubV1DiTwoGUbByk+w@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] perf annotate: Track arithmetic instructions on pointers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I was thinking we can use TSR_KIND_POINTER here.  Probably we need to
> distinguish it from the existing percpu base use case. Maybe you want
> to rename it.  Then you don't need to find a pointer type in the DWARF.

Hi Namhyung, thanks for the review.

Yes. I think that's a better way to represent a pointer to a type.
With that tag we can also support registers representing addresses
(is_reg_var_addr == true). And when moving an address register to a
memory location we probably can simply add the * to denote a pointer
without finding the exact pointer type.

>
> > +                     tsr->offset = 0;
>
> I think it can refer to a member in a struct.  How about this?
>
>                         tsr->offset = state->offset - offset;

True, it may load an address of a struct member. Do you mean
stack->offset - offset?

> > @@ -388,6 +493,7 @@ static void update_insn_state_x86(struct type_state *state,
> >               tsr->type = state->regs[src->reg1].type;
> >               tsr->kind = state->regs[src->reg1].kind;
> >               tsr->imm_value = state->regs[src->reg1].imm_value;
> > +             tsr->offset = 0;
> >               tsr->ok = true;

I also find for mov register to register this should be

tsr->offset = state->regs[src->reg1].offset;

Let me update the patch.

Zecheng
