Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8938156C6A
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770151577; cv=pass; b=jlZqdFkJuhT6xiE8xHl0ojbtrK0xg7u5v/hK+wohRLZ1lhiTSucnO8fG2g21N4Kc9zDK+xA0vtC6iWZxH+ZJP1FXuDMabAz8tydb3iOHUiot0vqLQhSjuVZqUzGYzy1V2nQ+WBNAWiCejBTZPib7I0O7aN5JtYvJaY3YCDMoCX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770151577; c=relaxed/simple;
	bh=Q7OwuwFj7g4WIG1A265nsQSz8PIxVCvFg2hsp1EQeuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giXwfVsnHeb0PPFENGf9unOc2atdeze5r+0L9URYKMJipYUT8E4OEEqMhreRTal3i+/hK770JS7UDd9IWJ3LVIcKFslKlv/gQyvIcT+qNg434HPdsdCu07+U8re7Y63tnly2eFqYfO+riB7KVLTwUhggv6taD+3I2wN4aVjYr7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ooyFdnY1; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ooyFdnY1"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-652fe3bf65aso53a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 12:46:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770151573; cv=none;
        d=google.com; s=arc-20240605;
        b=KLeMpp7FJhs2gK/4ovtRLLXTqKpN22pTuoaDhcEujzFwmNNlDpiD0o4rvOSbmP29PU
         Mff8WvBd8ja6NOh/hravihysyZEDvgfOJY+643MbFNkDbBAg5dIfqKCf0q4NbHFUQypP
         NhHwPLEhQtxcP0Bscj2enmi3icyOZsumr0IOKsfda6bIR6iWUf+TRpPs9nOlWQcKAe2a
         k6bjvefv/fyvIsKVU/5lGVsoqVLW3GjTAiKLHYkRBE84Dv0UojbdJYSVnLpRQkP/41Su
         tKoGqrx/f1QM8XCptC3rRRf5vx1mlPdNIHQ523bzU74tc9VpmDqeGxcjoIMX4y9jRaE8
         zHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UXUxBXB30px7Qxjr7Xjdulu2/5KTCIkLZZ0qQGNc3DI=;
        fh=d5h2JOTSpINdpOlqoJbzq1n48cQ4hMtIn31UlkDmOTU=;
        b=LPHVDovNBVikj6nU4RVk0nt/RnTtIcH/mUYHYm6r9yXP5fbg8HkOwEmGoX9ELa1NWS
         ZCZcZTqh65baiu77c+xjm0KzVD1LFDi+GCfCt7u9lXStSomiYcl9N/y8ZLSCsfKpwosC
         y7ARXa03icU3aK/i3BES6mgqWDf/TorJ0YUy7MFk/NhFXItQhLyfoLNBy/yKF/Mu5g9Z
         or/NvV0SUAuiFiZAly5nMHwOzL9m+/BZXuBmP2gSg//XKlAKqkbfoEctthH3WIg0l72M
         eQEWWnpghDwhSQ+lo/tBuiQH0aMHWFhUecW3BytYT0cSkXWwlTftfYoEZMdnp5hMoCv2
         4AbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770151573; x=1770756373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXUxBXB30px7Qxjr7Xjdulu2/5KTCIkLZZ0qQGNc3DI=;
        b=ooyFdnY1e+9GoqOpIwTgS1gcgtULscsQkBPkOcPLLpS5YifxKIlfBmWMhIGK302E+I
         LkAjzl9jkZW77eBvlQXd/vmJSj5e4YvMi39XOhmGDaoxKob9gREEpDt1y4Ia+gSHqrmi
         zaY9ehvEhlhUBcBR5+ifth58C42VEIBfwoibzKHVKSbKlROzmvIN/SiqIOPluz1NYZxn
         OSkeauiHP7dsQuMnxKG7997Ckldvg1OkmldGaY22zuYT7gKEhjFkeDneI+fAe45URp10
         dX9IQGDaaNgutQLj1ZBHaalxb4m+Iug4rPoknwa93J/LvwCCQ/sx2wYs9hHW1WBAbxnW
         iaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770151573; x=1770756373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UXUxBXB30px7Qxjr7Xjdulu2/5KTCIkLZZ0qQGNc3DI=;
        b=lLnv9/lhTr4AH7tsIqqeCunvMOpO0dLcTV14V+rSzPQoy2NbBlQKx6cJ1kgPu0F8jO
         tMTnrm7VTEuFDZuYzt7iTdmEUtg1YexcgnVJue3Kk1srqJH5VvVDsZD/ItA1skyOdjj9
         asd52VpL0jxtX+Y/rLtE2qpfD7DSiPuTS7Tb9OSpsPOL2DJx0wf6HNDsIHZPcb1V11IH
         uSc4glCqtv1Y2JPYIqSjixp3s43uDPOkQN+R1mXYvklJJTxNnmaw460KdhdN9F75w8yK
         TlCKWxeepoBemqJufFImWatQjG9UYHiwTCWSivlAjJaK0ysfF+Nmb0LrRsuA7yGUU1E0
         l39A==
X-Forwarded-Encrypted: i=1; AJvYcCUpRINdZ6WZTBlboJVY2jxy68EZtsm20RAc7b78ZBg6C9JVRUkXmhFiRQmhH6Cg6OwpMGWn0alReL8hTwGJ3PVj@vger.kernel.org
X-Gm-Message-State: AOJu0YwmZfk/ZBfaikK+UozeNa0ZHGM+8QBco3vLZCWKBEtDuS5hKePr
	1z+iDjfBe0SNkbKHOI/6i7C0kTjMNFbmHEi+a8jb4ZPq5k/aQx3W455UueE9bAYrGoNYh3b8plA
	yun9vAEB8pYZ3LtYXN03rwYW1/L9W2/zNrfZB+zyl
X-Gm-Gg: AZuq6aL8wYpcEFR9psHlyztCrONmYXhGgYGV4+NDEw9+yIk7vle4BgYZ8TeHlCt0epd
	HQn4qGHAh/i88ftz+wfxrGdYAnL94RLWvHx0NX3DKr/PhmdIC0LtiHrR4de4WcYJ5hS6xAeXqec
	d/StPLFT/5W+razn1Gee1VSPxZdAFhz1wLRNCSIHfe8H67dP1e3rPBMW9gyACi/PfKkp1TTxtbw
	FNt7liKDkj7bnhwf7ObhIkXbWz8iQw45+VpUW1StyCKukERFCQaBIOIpY99pHkzoYAyxo4=
X-Received: by 2002:aa7:c508:0:b0:64b:2faa:d4e8 with SMTP id
 4fb4d7f45d1cf-6594cc84926mr251a12.1.1770151573037; Tue, 03 Feb 2026 12:46:13
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129232835.3710773-1-jmattson@google.com> <20260129232835.3710773-4-jmattson@google.com>
 <zzgnirkreq5r57favstiuxuc66ep3npassqgcymntrttgttt3c@g4pi4l2bvi6q>
 <CALMp9eS7Za_vFdh8YBzycV2g87gZ9uj_S1MOYrgJ1+ShwVVWZw@mail.gmail.com> <626dbe6541266f61e8b505202cf49c94c4fee12e@linux.dev>
In-Reply-To: <626dbe6541266f61e8b505202cf49c94c4fee12e@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 3 Feb 2026 12:46:00 -0800
X-Gm-Features: AZwV_QhrunzURc9V5Pq5tiKjnsYeNR99YAZkjlUEbz7G1F7PnzNGzpkU8X6_T6E
Message-ID: <CALMp9eSZX9UQhu6iv24Jj9zUK+NVuiHAeHxsMDSgjP2skA=QMA@mail.gmail.com>
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

On Fri, Jan 30, 2026 at 3:41=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> January 30, 2026 at 3:30 PM, "Jim Mattson" <jmattson@google.com> wrote:
>
>
> >
> > On Fri, Jan 30, 2026 at 7:26 AM Yosry Ahmed <yosry.ahmed@linux.dev> wro=
te:
> >
> > >
> > > On Thu, Jan 29, 2026 at 03:28:08PM -0800, Jim Mattson wrote:
> > >  Add amd_pmu_refresh_host_guest_eventsel_hw() to recalculate eventsel=
_hw for
> > >  all PMCs based on the current vCPU state. This is needed because Hos=
t-Only
> > >  and Guest-Only counters must be enabled/disabled at:
> > >
> > >  - SVME changes: When EFER.SVME is modified, counters with Guest-Only=
 bits
> > >  need their hardware enable state updated.
> > >
> > >  - Nested transitions: When entering or leaving guest mode, Host-Only
> > >  counters should be disabled/enabled and Guest-Only counters should b=
e
> > >  enabled/disabled accordingly.
> > >
> > >  Introduce svm_enter_guest_mode() and svm_leave_guest_mode() wrappers=
 that
> > >  call enter_guest_mode()/leave_guest_mode() followed by the PMU refre=
sh,
> > >  ensuring the PMU state stays synchronized with guest mode transition=
s.
> > >
> > >  Signed-off-by: Jim Mattson <jmattson@google.com>
> > >  ---
> > >  arch/x86/kvm/svm/nested.c | 6 +++---
> > >  arch/x86/kvm/svm/pmu.c | 12 ++++++++++++
> > >  arch/x86/kvm/svm/svm.c | 2 ++
> > >  arch/x86/kvm/svm/svm.h | 17 +++++++++++++++++
> > >  4 files changed, 34 insertions(+), 3 deletions(-)
> > >
> > >  diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > >  index de90b104a0dd..a7d1901f256b 100644
> > >  --- a/arch/x86/kvm/svm/nested.c
> > >  +++ b/arch/x86/kvm/svm/nested.c
> > >  @@ -757,7 +757,7 @@ static void nested_vmcb02_prepare_control(struct=
 vcpu_svm *svm,
> > >  nested_svm_transition_tlb_flush(vcpu);
> > >
> > >  /* Enter Guest-Mode */
> > >  - enter_guest_mode(vcpu);
> > >  + svm_enter_guest_mode(vcpu);
> > >
> > >  FWIW, I think this name is a bit confusing because we also have
> > >  enter_svm_guest_mode(). So we end up with:
> > >
> > >  enter_svm_guest_mode() -> nested_vmcb02_prepare_control() ->
> > >  svm_enter_guest_mode() -> enter_guest_mode()
> > >
> > >  I actually have another proposed change [1] that moves
> > >  enter_guest_mode() directly into enter_svm_guest_mode(), so the sequ=
ence
> > >  would end up being:
> > >
> > >  enter_svm_guest_mode() -> svm_enter_guest_mode() -> enter_guest_mode=
()
> > >
> > Yes, that is confusing. What if I renamed the existing function to
> > something like svm_nested_switch_to_vmcb02()?
> >
> > Alternatively, I could go back to introducing a new PMU_OP, call it
> > from {enter,leave}_guest_mode(), and drop the wrappers.
>
> We could just call amd_pmu_refresh_host_guest_eventsel_hw() every time we=
 call enter_guest_mode() and leave_guest_mode(), which is more error-prone =
but there's already other things in that category.
>
> We could also call it from svm_switch_vmcb(), which will add some calls t=
o extra places but I assume that would be fine?
>
> I personally prefer the former tbh, as it's otherwise easy to miss.

I'm not a fan of replicating code sequences. Maybe instead of a new
PMU_OP, I could introduce a new KVM_X86_OP, which would be
conceptually more general, even though the current usage would be the
same.

> >
> > >
> > > [1] https://lore.kernel.org/kvm/20260115011312.3675857-9-yosry.ahmed@=
linux.dev/
> > >
> >
