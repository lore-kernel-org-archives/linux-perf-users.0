Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D335A388
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968057; cv=pass; b=X+YaMEOkKWK6nvMcYmtyqwbUnpMRHDZiQgECAzcd6WhDOgUF76MXlwUMO+bFpsZwzQVQf+8vJdzECQAGg5uB4iS5jlPRoRAm1WsEQNMaA4wd6Bh8JsTCUDkgrvoSeP2tMd04z48+tLzTFwZmmxv3dbA7KBDBUppfN4SIhUu2/FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968057; c=relaxed/simple;
	bh=3X0XEQ7mUewMdktVqynHYf8leq1tI6zJiV17AX+r9CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNM5K4PtjtuU1gHihqqowtLy8/JVFhSBMi18OwvIREoPHChM5gPzeYZNeelIZN73YkHmVKgyYKNg8kGLQ5HjZZXopr7HZtfrA9fK0G43A+r0XSeAX7ZuQiGv98Ky6N8/I7N93BZo9cdCA4EYmxYLHTAWIRmJJhpFS2nSZbEVQHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbuBaOLu; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbuBaOLu"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso56921a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 11:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776968054; cv=none;
        d=google.com; s=arc-20240605;
        b=BgrzKOf+DXC0QYpHbx4OAAQI3+kH9e5ts6IX0FGiN5+Fs1IcIOkhADBISz3VZAqu3a
         cSz9cDj0U4s1nTy+v+7TbSyU7nlPvjz/mxhIgPMWLIqVYKXrmNSZ0b62DfJZORdDOHVh
         KLPggEElZqGWwjFhqh6cTw1nv3m5lC4lopLP0iMy4JMCEeVuOM4nEgjq0FPysgYhPfpp
         qz3ymtPDZYktRqNg9pCDkWb3AV2tRV4V5sB4r3xp73F3B74pWBH7L0/KRZbsl3SrjIVR
         XESJchLT01RcBKbZzr35+hreEZre+rXcO4YxpTm8j3jVekHXM7rg8N8Wg6zFD/qj1TTT
         iNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K4QPY9s3GqKXMk5HSC8jCFB/X41J7ptf4y91qIA/h/U=;
        fh=945D+AG1jnfo4JPRckJ7CHfOn54l0KVTTSTf7RqhUII=;
        b=bTwpgiuWoo4xxJUWftaEUTQ2BGJbP0ik0BDl+2rgFuqlMTUUSl1qeRoOm29mSAAubD
         2b7ZXBJuSDyrqgY1Q50ZJjzWjQDGVXP7kzWwH7wEZ3jXkTX9xGOLQN/PQ3+JOOV5bXLr
         O4hb1vemdHldLFuF/lXOx/GaocZGm6Jyly4Z/YAcJ6r12Vavn3GSU1T8N0sMmVqmE0wq
         gYVk8dPN151j3odNScMMPcO3WXCFW9uItO7E2ftyiuHaIJNXbYIFeaidnHJAmTH4cyUZ
         7TKFDj3paGvYG/AF4BXWFF6Hg4viBsvsakAEFJxZAjPW3dWybi1et8qIzVvHR+ESFhds
         tqdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776968054; x=1777572854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4QPY9s3GqKXMk5HSC8jCFB/X41J7ptf4y91qIA/h/U=;
        b=jbuBaOLuRFbY4hV2GM54HNoLpwfm1m4mjMMwrJRig/CoyXFg6IEayF+LDESMNawKpW
         E3JdIWpxkoCkLc8DyOiHr+fjHbghzpY1xWbp5OK5IEKri4krZQTxlp18C1GykIqPxzV5
         nEFfYeJK5bvZBXF+Bi2V7uyO4dyXIPn80W0KOMxhMB2xMnRgdfBnJf5hRZmwt1sztolC
         5bfMdqJ3tWp9VDW4RJFUOguZchn0dLlOVoAvxhduV1k3EVZ8t23as0tEOalXardC+nG2
         iCAktBVftDLpcuOx44WuRh1vjzLpROXZ/FO/YxFG6SxXLkyQuGT4hlE5VK9nAXqHEqwg
         Yz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776968054; x=1777572854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4QPY9s3GqKXMk5HSC8jCFB/X41J7ptf4y91qIA/h/U=;
        b=TpJuf9zTCGQAueA2IrMNGXLWLVn+S23IOW2w1lL8BBo0mHJaY1ElW/2bEArq8zamRG
         qTvsYXt3b6td+reBFcTZeao0atRveI9G0y0M0MBSof6+QWvCbphD5+9tk3p88YTsnl+f
         uj3w2qajaELuTpmWk7rfUnhqyxOHnvc3yep0douj1E2NrlASAaXY/CbFCTkH/HkS+Nmd
         O291QFQKWsKxp8uO/GMcHoM12V1n9eWiJDn3gkhIiOi7SqHmGThY26JsXFZ/HvqOywim
         3JHbJeAeLDKJJwEaFKuM4m37hC9u7Pui7LHS2ylJpFw3PGHGGlFDQFRiGXQkZQWtGZPA
         MsPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Q9ISfkBDW49m0SJsRZ1u0vpgPAnuDNAK6z8JVxG92ijZk2mSgVORAu6edhXRlIoBlfbaJQ1rKm6dw4RewrnLS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VPlbLgcVcOZUV7n+l7xQFHFKU4WZ89+CceTjSfraC33pn/MF
	EbItx/eddXWou5BbjP6HYd9xMaI1EWekU8/80wW/AX6BZK7/lgqfkC3tTR+znMjdg8vOLFVgqkn
	TorxgwkXhQ8CTQd0zMqgHi+YnT9BH+hkNHIIvjnq/
X-Gm-Gg: AeBDies23koiWViwOg7uU8wGfvmbZ5vaeCDiTe0dbBk7QoeDb5898nVTXIaf0ummZRP
	9R/q30hDzJjjc3rx3AmamwOw4pQyB7S53gtqgOFmAaU0BzR1QfFCdVX6JVQmwkwioH2qvAHb8P2
	hyuzrNABVicvPcKj0e05RSej7uYv61FZIa8vrNospUSzljNlcEHiIldL68/UA4/M2VnB+zPMDjt
	vqXaRgJk/qdSC/hcliAYMj127keVGZ/ikdyFHrhTWFP6epKuG1T8PizpN9BiRWAWLh2l6ayOkot
	BC+3dY01ljwZt0aD3lTw+q+c4JP4
X-Received: by 2002:a05:6402:951:b0:670:9e9f:1a5e with SMTP id
 4fb4d7f45d1cf-674404f0026mr269246a12.2.1776968053761; Thu, 23 Apr 2026
 11:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-5-seanjc@google.com>
In-Reply-To: <20260423150340.463896-5-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Apr 2026 11:14:01 -0700
X-Gm-Features: AQROBzA-HWufnC0-Ev6XrddaWAfr8RjJyxYq0ElI4imQXSGVPU0VALJTnOxzTWM
Message-ID: <CALMp9eTYhE7Co7LHb-251NhSHdyK4vzC4mrPu2_bRbDbrDcwew@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf/x86: KVM: Have perf define a dedicated struct
 for getting guest PEBS data
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Have perf define a struct for getting guest PEBS data from KVM instead of
> poking into the kvm_pmu structure.  Passing in an entire "struct kvm_pmu"
> _as an opaque pointer_ to get at four fields is silly, especially since
> one of the fields exists purely to convey information to perf, i.e. isn't
> used by KVM.
>
> Perf should also own its APIs, i.e. define what fields/data it needs, not
> rely on KVM to throw fields into data structures that effectively hold
> KVM-internal state.
>
> Opportunistically rephrase the comment about cross-mapped counters to
> explain *why* PEBS needs to be disabled.
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Jim Mattson <jmattson@google.com>
