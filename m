Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601E35581F
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119081; cv=pass; b=hBsODLnOzp8pXoohrW+0iiCkdcbQlyPRxbVdPqmuPZHtkBOLt3jnicAskSUX4iLJ9QLBxkzVQYJcUKG7AoWNiCl6/K/0JgP3v8i9tiMISPpRgZIw2Ou7SyiVPfjTqnjGx6txuLGWsV7PrIlfa/o6Qr1OyNQLfq0NkOGh/paZdj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119081; c=relaxed/simple;
	bh=Jfl4dZTufIKAHIVFT8NRO4fD8XoSRUWOc0fet6SBpt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIAUd4b+RdWdGPqI9Y/Fl4cKNNcV2D3Fo8yRKHQSAuWTjNeZ4DRwRLNs/XHYPNmfu6h6yTtvZ6Tlh48xqbtD/HtpGu6vh5SC8anB2B9uSrMiNvxSPM6RMpZoH3vYJlQb5lzokZcdL/BrPDWgKg9NLRflWgFx6UR5qA9yRpoDQg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=39uLLe/+; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="39uLLe/+"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-652fe3bf65aso1678a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 13:57:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769119073; cv=none;
        d=google.com; s=arc-20240605;
        b=AC2n2UjU8S24D+a1LDexZZ9uRZUomHm4C1IUsYCZ8K+0BvV1ynFRogR/RtReoNijD5
         CfD/6qKun+il5IJbqQOdAdcfi6YWIwcKhpuR83wwCV9DwAKoJ54C8kNnwEaC9knXpvdL
         VOUnMkcvKPZCXKJxU6tow53lagfRpQ3tGOS5qv5KkdCnJ0B6VD+mjINFkQ9xDUlaP+iQ
         qnO9st8VQZt7tFbkmcFQ0t+NGdBhWQAjKVVX67NfqD9wosAKVxsX9fw949r5QBR6rM+l
         jvHgBA4d3C8+H5OFKmt0NpU7CAmkzrh0P2iWdZ/Ru8ezX1Xj3uK/9QTydaidNCVIuG0B
         GSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uGwfZfWxv4dR3vjl/Vm+r9X4BJKxCk7dJgsJmeqfMnQ=;
        fh=IQu86N4QYNLdBQV2t6ALGtII75F1hwk8cgDUVTXh4/0=;
        b=aPwJAwI1C+9VjUE1QJ7oeuvCNErq13h2CmtYdcS9Vrzov5guM3jyJvxZGXyki/zvVT
         L2efLoTVaYc363SkXS68hBAnNd5Kj2ntusUvuNrIAQ3frcJ28ofm+KyPawy5xzUsdvkA
         Y701MNu3Rk2/DLtg9a12IB2kW+UbN8NYzIGyPZyBP3ZKOyrLkEUECJfDV3yPLTuOcIs9
         jTYjOC0VEEO/iZ1fvR99WmXoyKOy5FZSPGk+xX/JqIB4WcqnNcJjdcdVTGg5ZfKKJ/nR
         rpzA0mmvge/d1UgTULdZ31QfvYvPt5iyKASCgVrrgmANiYVxFkkqqH+7H0cbsZvjIpdQ
         RaCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769119073; x=1769723873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGwfZfWxv4dR3vjl/Vm+r9X4BJKxCk7dJgsJmeqfMnQ=;
        b=39uLLe/+p2pOzi73YG645N+IWdxlxqq16hn7teaCcByjiyapwG5CLMk86v9UOsG37w
         tQJ7CR/icVELRs3rrW3eMLbsjKeL5uR0F681oe2+YaX7foHkmmwCOCZ+AUt6tKPYmw+x
         8fjsmlhcBOBI5XtN5RlBP0xCtGiZs8dvuuZhkoKn8X0Jjdm0yi1sC/1we9S5X8stEq+l
         xglNJVygfboE2zIoF3NeQhg9oQANS6+7r1TMpWapzhjduTElU8RAzNNW3GPS/v9Hv3sB
         LGUGgFkyd925k7csU0t2FlC/DC9S2LW5fAk2TPYS39fprHQ1Fn8uh2msMtXgVmSV9nK1
         Uogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769119073; x=1769723873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGwfZfWxv4dR3vjl/Vm+r9X4BJKxCk7dJgsJmeqfMnQ=;
        b=rJU44MCqMIs872gHAlXVQoIPjjo2U0QFANIEweQS+gMqZnoYHJZBf7xIJ1G0hajduZ
         qpN09RyomQa98AnsZcL1i1y7EzRpMBR3tBIGudhrjDUFijJyIoLr+ANdwWkxnYJqJK/0
         LaypIk/IyPibXPhWS3cUCgxDWjGSaJd/s7m6bP2VbHg+7x9HQpyW0mITK7O3hLJaACbw
         c8PUssV4K/nk1IwMtO1FZ41n1h6JRw/UuFymbPFVvG6fqafcLDMnsYXJWHo5TY2KEFeD
         1wAp9U8/gJ/AXbl++Mh8CqA8fZIhcSsTyAladBmCuAnK7Hq8ReL4zQVdiiey/k6IFSGw
         NlZg==
X-Forwarded-Encrypted: i=1; AJvYcCVS4T19LBUEx6c02TQ+C0hawXSFeEG2MXBsiab4kkhep/pxemsC2mr2AeM0q0soEi4lWRU3Yv9UfROu4rrpBSyN@vger.kernel.org
X-Gm-Message-State: AOJu0YzkP+E14eLdQx7EB4fY72WtCW9Cs+VtDTog4TAYzZJ7z/22yG6b
	M0R554M03MRf+jgq9aIt9NS2TPd7ZW9eAEuRJF9mcBLwXVQaIj9JaWLEYHa5jF5gFnjh2q7Tgnd
	ihPXCRV+DFMFMPIPQlis+ZrVnINMY0LizuYcmtdZe
X-Gm-Gg: AZuq6aIwW1syuBn1cyZQEZfgKXPBdaE0sBUZi59Hmh92C3ZE2uT2A5MuO1eiFj6MtPW
	WRlYypMfbLjhXomFSCtV3/t4z2iCZMds+6wtYGYyvU9mKBxXrXxzqIDBLSRBPH5Ob71YwovdLV2
	Zql+0iFFXZ8rRSNyOonOqHBGUIecOkTCFCWVt2O93TEFudOiVgC1tL5xhJ6+KnC+jaBwh9E2zhh
	O/XFDPzAEZ6uYzbkkIPgaYmGeNdz/VBfMduKFmZ/q07NvcuYUQapCJpHqrubA71e0ut+5x4Ir7h
	sWHPpYTC6hjbOGVANNdf5n4pXFHA1PJxgA==
X-Received: by 2002:a05:6402:5144:b0:649:8aa1:e524 with SMTP id
 4fb4d7f45d1cf-6584eabef16mr2044a12.11.1769119072536; Thu, 22 Jan 2026
 13:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com> <20260121225438.3908422-2-jmattson@google.com>
 <aXJKdlJI3fg42gim@google.com>
In-Reply-To: <aXJKdlJI3fg42gim@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 22 Jan 2026 13:57:40 -0800
X-Gm-Features: AZwV_QgJymUgNy_50vQyL9SN8_pY8sRH-FZ0KRcWUNAUxqWJsSqINclPGSmR8dM
Message-ID: <CALMp9eSNqqgLN9dMzer9Cj3hQ64fB2T==hB_yjvNBK4W8Pn66A@mail.gmail.com>
Subject: Re: [PATCH 1/6] KVM: x86/pmu: Introduce amd_pmu_set_eventsel_hw()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 8:04=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Jan 21, 2026, Jim Mattson wrote:
> > Extract the computation of eventsel_hw from amd_pmu_set_msr() into a
> > separate helper function, amd_pmu_set_eventsel_hw().
> >
> > No functional change intended.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/kvm/svm/pmu.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> > index 7aa298eeb072..33c139b23a9e 100644
> > --- a/arch/x86/kvm/svm/pmu.c
> > +++ b/arch/x86/kvm/svm/pmu.c
> > @@ -147,6 +147,12 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
> >       return 1;
> >  }
> >
> > +static void amd_pmu_set_eventsel_hw(struct kvm_pmc *pmc)
> > +{
> > +     pmc->eventsel_hw =3D (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
> > +             AMD64_EVENTSEL_GUESTONLY;
>
> Align indentation.

Sure.

After wondering about how to configure emacs to do this for many
years, you have spurred me to action. In case anyone is wondering:

(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-offset 'statement-cont 'c-lineup-assignments)))

At least, this seems to work so far.
