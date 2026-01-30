Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1730E84B
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 23:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769815856; cv=pass; b=CBwO1xEnwawnN3ntPVjq4Bk1dfyz6hdcj5bKLQqFYxbCzT5Axu3yMNmU95fvUEUpgeQthqMdGBv7USnFBSA6lgKRdNa14j+/bRML6Y8aLXjwYc1SgMjZxqqutKZkuWKWbvfjPIySF4yhUfXgjEdPWfpU1gZdvX32wEkTYZINxKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769815856; c=relaxed/simple;
	bh=uP3AnfWxksp7Fq17hXZgZwEtBM8hOyGlJYnoXXxtPoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDhiXTJm6zfzszdjxQJ0OCO4S0btRZHO3hCmBUI3eNEVkkI1AXqcM+jJa0dQe07yAwnmLOvguEkvmt4dueSbdB9EPx9Ci6oewIULtwJGUtwnYH9yoiYQNdGrUrnyhBBVUXJGZryCALVF5IaJVhr2kS24Qko50nzInXlB4dD4eUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LGUoB9dD; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGUoB9dD"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6581551aa88so1818a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 15:30:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769815853; cv=none;
        d=google.com; s=arc-20240605;
        b=SvMZTxUKX77sJFdownSTRaPvCqy6iP+qFecAI0ObhP+CYscGfck0H+JkJbsltsOUjw
         PeM3ukaElIXwbzRHfnO6NDNypQb3AKczzbkUCCqA6cjfitL3itrtDZIABSWElWFQCR2j
         nmm9QnE7nsWbGDe11JUKTegGkiIgLppPgdNrUCBI9YxFECd8UYzan+j2jwYg+GdwZ+VD
         JfYGcwS6wuGvHktWeub4R/zROFTSogEDBzGaneyr29hWiW74KDkc1mmYeGazhhfor6ce
         EEa4om3br1chfdJtvolR/IW05hfYUPzGf/t6fCb6GAgpGaFxHDpPGpoE4GBDdrNtzxqF
         rhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OWGbD3Q1oYxtbYVSNos0BG2kmeyuKAEZoyrEWcfmjO8=;
        fh=IjoePzS4nEnpC+8jC5ji0cuoMJBRF7jCMIkndP5KxYI=;
        b=iNADHqbgL5YVkwNM7JHWskaR1/v/iOB+XQy6MPQhHd94HjigKpLRNrBXTJkMtZDRbq
         /GGy0D1N+xpvICHYAx6o08TRBXncpy8AuoKUSKfjTNKVG61joHeSfnYsphRDPXQdKfud
         eaqBTvwCmatdJLYplIpZySezNJsgBhhu9gJgC3QLm1JZbYXrLWbeQhUK5dZrHT0mTOiV
         di7RXyw22gpXjZCqzxExsdCWXqK0rGgIqC/aDh9ZR9fW3WtGIPbyC+Bmd4QKwm5cmzT9
         XUcS9VPl7N8ZFl14Fwq8R4+58I/0BnwTSNN/T8ZRoW9SINazaqBv/wxrCgWljKo+vY96
         /8qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769815853; x=1770420653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWGbD3Q1oYxtbYVSNos0BG2kmeyuKAEZoyrEWcfmjO8=;
        b=LGUoB9dD9y23kkeGF6qyeo0n3Ir84ufMDaVQNwJAQRRYgFfC5UGI3UZI7zQ4yY2++u
         /LZSVMRsJkE3rdNvN50O3eWJArx05s+8Nufw/8pRtuMraTyLHfilPVIILi0JRk5jkqyh
         zYI88PnJiIrzEwW0Ljw5JyCLyDs9M6iPW5LYbQkUZunQLbAY7jrdxFRGXD6iunRKK6Cp
         m9JgnbAm009iodgRdrONT3RfwhnocFL8tDucmoN6WoUUVwAaTebxcIq3GdSG49aUXFGg
         RQRhTTO+6ybI3jMnmEGT3F5q5EA/kCm6IEOIIdpkXSrWMdxLO9ZcLyCsJnkRCXR7S+Aa
         Vbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769815853; x=1770420653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OWGbD3Q1oYxtbYVSNos0BG2kmeyuKAEZoyrEWcfmjO8=;
        b=wUDKJJJh3xt9cs9izq8z2gQFxeNC568gQBV/8stcm8jkd8f7BeznSI1TuPk10vzy6/
         sIkH8D+McLs0vGIT2Im5cZNfcOd3P/xg9aM4+WqF+N++0/InhuHjPH9cIIIhHgoppSgG
         jMDTAxzG3HMztbqlV/ABHccyyJB0GdjuIUkyz3u9PNh7aTB1GSnE9jOaPonsNfPwtNJD
         6UVFu+GD2Chdxleev259kFJ8buY2BW7w3CCIkmNHoRHNyP5U1WtFGIXIWAagduIqrEF4
         OIlRM9DGpbEOl35w7e3Xnrkqk3g7KctnD47Ex1gLGl24a2Jf+0w7BK43OzV5IP9jJ55B
         d5yg==
X-Forwarded-Encrypted: i=1; AJvYcCX1lCEtAyDSZMmp7zvib75DSQOar2qwHQ1fkXegxUazLTfA4njjXiY3Qvb1O4QisTM8NHD8z9wTxoBWgQ+WyUnp@vger.kernel.org
X-Gm-Message-State: AOJu0YycUEj1jKWKlitn5QHsk0LDvApJg+7HI0kBQajqR3Dr1XY2nK3p
	XZtXxZ2qM14uUW6pfD5OTBY6IbZGiiock8n5wZtoL2fU3wXhW8lK0oppE21NOrk8W/NBCYu3Zzj
	/QpRP+WQgx3swHi2IC0Krtbyr/FfZ4Pva9WuQDyWB
X-Gm-Gg: AZuq6aIEcg1PnjxSFbl/S9LisX6aLblYCoQQc0vxh+vqq2FJhr6wNqHl4Cddb85SH8V
	nBquP8hEbeVz1sqSXLIIlUY0Aw0GDv43UbS1AYr5FjZVD6GjziQZg4qbwQHyL1qjYvq8lG3rs4n
	kCNMUJ7x7/wqZ3/4fIx9IoWytk8JX1Yv6GW+CnZX6onch33t5r5ZvjHUpGr1RjMug3XOe7JPBGc
	nyUZkrBYKMd5asR0B+BPp3K3hRqziO1dp4zJGWXcNW/WEl/pvqOU2zNB1CGZC/uLdDlyB0=
X-Received: by 2002:aa7:ccc6:0:b0:658:a54c:d6f3 with SMTP id
 4fb4d7f45d1cf-658f6c75eaemr14062a12.6.1769815852677; Fri, 30 Jan 2026
 15:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129232835.3710773-1-jmattson@google.com> <20260129232835.3710773-4-jmattson@google.com>
 <zzgnirkreq5r57favstiuxuc66ep3npassqgcymntrttgttt3c@g4pi4l2bvi6q>
In-Reply-To: <zzgnirkreq5r57favstiuxuc66ep3npassqgcymntrttgttt3c@g4pi4l2bvi6q>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 30 Jan 2026 15:30:40 -0800
X-Gm-Features: AZwV_QjGWdMQTuDf_firyiB8uJrobAc3g0L2GOgNb852oEYE3viONZnLUBrlkRc
Message-ID: <CALMp9eS7Za_vFdh8YBzycV2g87gZ9uj_S1MOYrgJ1+ShwVVWZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] KVM: x86/pmu: Refresh Host-Only/Guest-Only
 eventsel at nested transitions
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mizhang@google.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 7:26=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Thu, Jan 29, 2026 at 03:28:08PM -0800, Jim Mattson wrote:
> > Add amd_pmu_refresh_host_guest_eventsel_hw() to recalculate eventsel_hw=
 for
> > all PMCs based on the current vCPU state. This is needed because Host-O=
nly
> > and Guest-Only counters must be enabled/disabled at:
> >
> >   - SVME changes: When EFER.SVME is modified, counters with Guest-Only =
bits
> >     need their hardware enable state updated.
> >
> >   - Nested transitions: When entering or leaving guest mode, Host-Only
> >     counters should be disabled/enabled and Guest-Only counters should =
be
> >     enabled/disabled accordingly.
> >
> > Introduce svm_enter_guest_mode() and svm_leave_guest_mode() wrappers th=
at
> > call enter_guest_mode()/leave_guest_mode() followed by the PMU refresh,
> > ensuring the PMU state stays synchronized with guest mode transitions.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/kvm/svm/nested.c |  6 +++---
> >  arch/x86/kvm/svm/pmu.c    | 12 ++++++++++++
> >  arch/x86/kvm/svm/svm.c    |  2 ++
> >  arch/x86/kvm/svm/svm.h    | 17 +++++++++++++++++
> >  4 files changed, 34 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index de90b104a0dd..a7d1901f256b 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -757,7 +757,7 @@ static void nested_vmcb02_prepare_control(struct vc=
pu_svm *svm,
> >       nested_svm_transition_tlb_flush(vcpu);
> >
> >       /* Enter Guest-Mode */
> > -     enter_guest_mode(vcpu);
> > +     svm_enter_guest_mode(vcpu);
>
> FWIW, I think this name is a bit confusing because we also have
> enter_svm_guest_mode(). So we end up with:
>
> enter_svm_guest_mode() -> nested_vmcb02_prepare_control() ->
> svm_enter_guest_mode() -> enter_guest_mode()
>
> I actually have another proposed change [1] that moves
> enter_guest_mode() directly into enter_svm_guest_mode(), so the sequence
> would end up being:
>
> enter_svm_guest_mode() -> svm_enter_guest_mode() -> enter_guest_mode()

Yes, that is confusing. What if I renamed the existing function to
something like svm_nested_switch_to_vmcb02()?

Alternatively, I could go back to introducing a new PMU_OP, call it
from {enter,leave}_guest_mode(), and drop the wrappers.

> [1] https://lore.kernel.org/kvm/20260115011312.3675857-9-yosry.ahmed@linu=
x.dev/
