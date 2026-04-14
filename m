Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809E389460
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205784; cv=pass; b=hlMgIv8AUoSMkb2Yto50/Fsqkveuh6UCUX1/AURMg/jStlXdSxaoqL5zblD3fs3JD1+Ivs3J42i3G9vpo3OkZ0NlImIcwRpiy3/mpiPfISy4GMVixwkQIcmgIwSzYKN5Jvo+V9E8+MnsMwKvsRI66+saJOGn0pjc/6+WA7lFKic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205784; c=relaxed/simple;
	bh=fBbjf16osq2lmBsm3qe27/2B7qTE2ZnTyCx45QXf1GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWK1d5kulm2gO2EPh7pbfwMx1QtiZ3ryaIK85qTj2ktCveLlkjhgAj5aRtAfeTbapkwpgvrWPnxWU6RZ66AJjOGyXRfLXJO6bnqM4OU6QO2tsTrsdAn6ng+YuzcLy6cSsnSEZnsUeUuCQ5FRVWDnhc4TvLQZbbnmUFr7fPxkb5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqgvuZjB; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqgvuZjB"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso28941a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 15:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776205782; cv=none;
        d=google.com; s=arc-20240605;
        b=ixVj9mVFs9iRsRZbQR+xz3PSLT8dQQlTrv40rUU6f7xz5F3eicI9LefbWMLMsttXpW
         aYLUhFUGVR6wnDKb+cgXpjCToSwro7uYAfSQnYh82jtHQMalmL2JEK7jYA9eABTwX9B6
         2RSJKDYS7WIln7PrtJcv6U5SA6l4g63i9WWkLr6/0Xyi6dMUIxbJ7/I16pBhOtwGS47L
         L7TzyyXzjetGMbF7k3a8UO9uDYZT+SivyvlSujq1DG2T6S05XiwMGn7fJ3X06pzlsvhZ
         xogOudakU5r0GaMk8lFxxg1GQygSjiGlVXYPjqwEtqHGWpUb4EPcyMn9+K4Zugk+2DsP
         fJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1stwh6IzFVN5ADaOr/0ZpBdvHW9a8MLzS14mBjhnkQw=;
        fh=WvOCRV8cwJR9j9vfChY8fCIMCH+72aOGEDyv/bVABuQ=;
        b=SOQl7G2wZGxRa1/6WkIJUb7wyFOrQLaU7vLLsvplIDmXjuT5jvwT002fkONTvCiZCF
         8mS6jzMlQgV4dYnD1uZxjp3QTi0UCTcnDKacK93qqG61Pw4cw47Cg30a6Xaq1vA1GUts
         FNU1oCoIswlPV9wrOB51suDzSVWsfK1klvwHuv9dTsDi1YVEMGaNRHUYQcH0T/weHrdK
         Y9LXO3KWUT26hDPcW9TDhAMsAcSGng5p8bVI9gW5Sul7RLaX+HWFErQgTKD8Boyas00r
         OpLM1/PKQ666+ZKLKNcdR85JK3D7rPFHir8S3fzJJPNzEg9k8dIiyCtjCxFtYHTf7PbW
         Gl6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776205782; x=1776810582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1stwh6IzFVN5ADaOr/0ZpBdvHW9a8MLzS14mBjhnkQw=;
        b=YqgvuZjB/qVnsTU9DkIQHn6ZV2NlU+KNKbxGmJqPgQj80bj4ypVt2eJnrKhNHc8ecE
         YafRVzfJKWPkXztsKZQDIHh6I8LaLqijjJZbU+fzODuAdMhEeeVDiuuRjzbuoBhJXucZ
         k0zX/vHC9p65fZIWsJufdZKE9qR17gA61pTNoQlydOR56UYogERy6cP0MibGbUvuYqeG
         mZdJWvxB5Wnf7NZ+TbonGf5j9fFGK0Bhf2jDZlVRaiaxvCj1c08Zpo/B+D7QiaHS4X0a
         JpF7rDthUOu+/LmLDblznc5pyP6uyRR9FBHE0HoH2NOAiUdWwSfpCV8jyrVmKCyMLAPx
         +EPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776205782; x=1776810582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1stwh6IzFVN5ADaOr/0ZpBdvHW9a8MLzS14mBjhnkQw=;
        b=nd+jg9r+qW8g346P3IJ9nvuvrNYxWn7tFwkFgWWSKyISqQyVKaTFrIeAfRo7YsFUhC
         UWD55tukBXAGtlYxT6i24hIi3QzhbEvM3c5l+WIMkfR8oCALn2t2P4uwwpp9xKKPFOQP
         KmqrVIy+4wenZFNl/cEnlc9H1Ife7n3DjFnrBXWebQcR5Prcqd31akRbkZr5TszuPYAz
         tiUcomhqxpD4GS7MZL61SVrer0WXPFt0maFYXX34qsI7wNdaH1n+vWMwCey6mLSqJIbi
         e1k29WoOG4WdOhur/PCrMqeylZtmvcUxRS4/rmsFwsHOgRUVCnXnciSubigWsekcWN3c
         0/Rw==
X-Forwarded-Encrypted: i=1; AFNElJ+rdWT6Oo4m3tsKTe7hg60Ci1b0DfDz2sh9l4t+NNRJwo8tGc4DbDTPrlrTyHzdIFQvSlg7WYKckVIMcPPYp8tj@vger.kernel.org
X-Gm-Message-State: AOJu0YwengglITHyUlDcO7yqSwKm8amuAgDuj+ETKO17vdgMU4RGPdFk
	v1sbBn8nU+AI27q0chLLpeYAhrQkwdc4IJeJDf7i7RSWAtSCwIMYJwloF50WdhpZMTLEzaIgjO+
	8Kr0u8qLz+P9vV4kX1lAbVQYr2xWzssthxyFbhnHC
X-Gm-Gg: AeBDieuw5pFI1Yj82bijH+oAEeY+FzAhngra+WIikXhZ9fYejf+TZGZ96ss+zzP9jxi
	D7jiqIZonbK/I8emwW5xLv6Lo2f9G3cvGXQEQZRA5bY1ksfhDCnpRncrFUT6PnlX8SHnmMDufqb
	lqFsMaEulBzsgcM6sNAaT/4FHoa6JqkWbLk2Yn1+dMXmYoksJT0+pMX8/ib6S6TGEt+FY90sWOj
	YeA+2CefbVxjLXoNU2M7PBfnv4VF+CaSMKWMz82Bhk8UGPP70JeCobXJKJ5/R12OouZ+8SFLIbF
	GkcHLoTiDsC3AZOCXL6KsgMQVvAJ
X-Received: by 2002:a50:fa90:0:b0:670:3723:70ad with SMTP id
 4fb4d7f45d1cf-672315817b3mr5119a12.3.1776205781431; Tue, 14 Apr 2026 15:29:41
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com> <20260414191425.2697918-4-seanjc@google.com>
In-Reply-To: <20260414191425.2697918-4-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 14 Apr 2026 15:29:29 -0700
X-Gm-Features: AQROBzDk78p-yC_-TyPp-cyL-cS1J8qrJKkTJuwtTmxDA43bY6KLY86NJfmlLZI
Message-ID: <CALMp9eTFi+9HrxfjiqLGw5BbdJiZsO4DxzhxN5-tCSbZAPY5aw@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()
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

On Tue, Apr 14, 2026 at 12:14=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Drop "support" for passing a NULL @data/@kvm_pmu param when getting guest
> MSRs.  KVM, the only in-tree user, unconditionally passes a non-NULL
> pointer, and carrying code that suggests @data may be NULL is confusing,
> e.g. incorrectly implies that there are scenarios where KVM doesn't pass
> a PMU context.
>
> Fixes: 8183a538cd95 ("KVM: x86/pmu: Add IA32_DS_AREA MSR emulation to sup=
port guest DS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Jim Mattson <jmattson@google.com>
