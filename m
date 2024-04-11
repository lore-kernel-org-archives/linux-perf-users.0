Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269CF1862E
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712874647; cv=none; b=Q6Ow5DXgxxWNtuVPKPY0u4E+S+oWNk75XeXJa9qpBQPWrtRH9GyslFq8YPj/cXx8CSlHsiN0hH/4zT82uOjZgLXLLKWMb/4DX0Ozej/on4tcW/VAvR1y4ifaOSWVjURO8kkEi2YUGBMSubDsJfO3LXw+iakQs6tyQ48nFwtSNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712874647; c=relaxed/simple;
	bh=FPP0pGTTQJ9w/af1qSi4/wrO18+xLS21UrdlmCqaGCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1bEb/FbNAgm1DKhgSeNAuS9mUjIR1uju0pXkbaX1QXNH2j+b6KXTQBHxS+qF40Bd8I+zKeFUC7ZQBcatJhW9Nm1UhLF66ezOBxCqLXYwXQU6uGCqghF2WUcH+6AHXH/gr+DZnYRAz7P2Yz6LW1k2n+ic9pRy12o8ibJBgqcac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLg0DMph; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLg0DMph"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so2035a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 15:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712874644; x=1713479444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TC6twZx6RBXTw+ooEGShhOHtZOxQHkfNzLmy0BDBQz0=;
        b=oLg0DMph3m0qvauDhxcZIx4zSylGeblkJ5IL3Xo81f6825vW/N+BVcZz/zH+CDo8KG
         lOVdkT2e5Jz+SMjL7sDiiDZt672RM3k9jKxfGyUZAZ9dyIPB6j9/tkQd/1Zq0x1oPty9
         tEEVrFdmUzfio3g1QoAdMxHArUMOI80jKukPDw7pODSlb9/io2CiU3Qk7nDv3XX8I4jo
         NuFFZGkYTsjB/CSFuuY/JAtFqBLyDtnZ/c3+1FJoufimMoebYEVwN8Pp29L7Uzt8H8qi
         om91vGAohv4WqU0gWyET7avdjHh3YAoD0ewZVQ+axll3SY+pLSHF4yNG8gaOQR7KeIgm
         r3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712874644; x=1713479444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TC6twZx6RBXTw+ooEGShhOHtZOxQHkfNzLmy0BDBQz0=;
        b=CjJv11hjgw/VpRhIc8fOwZKlvJwjuz9euFtE2FABDezGCYqk2+JxjUmnvxl7nyEiIr
         TfG/h2G37agR8NF3rL17ZkaT5nrMNZ+DmNOAO1RJ7eyd/KchwyVoEOJ2zh2dYcuWcvjF
         2NKRqIFXv+G1ljAGr8FERq3LjSFhz6SLu4i6hGMMoLbQTqKk0Bs+RjJJrWNa1FIz1MJ0
         9uVyMz0qt/W6CAGqesYMC2c/MZVPKf/QTqIu3SyvLapQjwbk8HfkKx9wSNfQRPECSqNG
         uVusL98IeJTmHSW56nSzU1FGMOvC39ZqYJZ8NidR+fk6X47G8m25g5mKpmLvKWbBDM2I
         orvA==
X-Forwarded-Encrypted: i=1; AJvYcCUpusTCRTkxCS3AzW1DYx/rndgpB2RRJvHVp2zZF8BywkV3ySCzqdeYvYPss5OWmZS9r+aklTeKbX6M35zWU3FefDdHPNkhNLxI5fjzDj62wA==
X-Gm-Message-State: AOJu0YyxYrAgVRuxEv9WHcyG/4BgF80oL6dujSjXWgz1bLxz1pZsfeCR
	SGeDe2zAFhGyvdc/4sS73I06xplMGZrYqJ0yUlkllzU1cadRdCfwntiDv3V+fNr26dhcH2OQAXE
	HvKuHnpPMllx2eL2t2tfUP/2iTjIkpbepdGj+
X-Google-Smtp-Source: AGHT+IH0fRw88jlF/PTTGp8JUv+i2sdboTHFQlUCx9qkS0imAB+RnQjF3l7GHprGg80gvoA8gFg+M99vrf6oV9rVo0k=
X-Received: by 2002:aa7:d889:0:b0:56e:5681:ff3e with SMTP id
 u9-20020aa7d889000000b0056e5681ff3emr59016edq.2.1712874644225; Thu, 11 Apr
 2024 15:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-16-xiong.y.zhang@linux.intel.com> <ZhhUZJ7rE0SbE6Vv@google.com>
In-Reply-To: <ZhhUZJ7rE0SbE6Vv@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 11 Apr 2024 15:30:32 -0700
Message-ID: <CALMp9eQ01NJZKKYt8XhTbnu8rNpuhpk388ocvyPqWJiO+sov5g@mail.gmail.com>
Subject: Re: [RFC PATCH 15/41] KVM: x86/pmu: Manage MSR interception for IA32_PERF_GLOBAL_CTRL
To: Sean Christopherson <seanjc@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, mizhang@google.com, kan.liang@intel.com, 
	zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhiyuan.lv@intel.com, eranian@google.com, irogers@google.com, 
	samantha.alt@intel.com, like.xu.linux@gmail.com, chao.gao@intel.com, 
	Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:21=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jan 26, 2024, Xiong Zhang wrote:
> > +     if (is_passthrough_pmu_enabled(&vmx->vcpu)) {
> > +             /*
> > +              * Setup auto restore guest PERF_GLOBAL_CTRL MSR at vm en=
try.
> > +              */
> > +             if (vmentry_ctrl & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL)
> > +                     vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL, 0);
> > +             else {
> > +                     i =3D vmx_find_loadstore_msr_slot(&vmx->msr_autol=
oad.guest,
> > +                                                    MSR_CORE_PERF_GLOB=
AL_CTRL);
> > +                     if (i < 0) {
> > +                             i =3D vmx->msr_autoload.guest.nr++;
> > +                             vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT,
> > +                                          vmx->msr_autoload.guest.nr);
> > +                     }
> > +                     vmx->msr_autoload.guest.val[i].index =3D MSR_CORE=
_PERF_GLOBAL_CTRL;
> > +                     vmx->msr_autoload.guest.val[i].value =3D 0;
>
> Eww, no.   Just make cpu_has_load_perf_global_ctrl() and VM_EXIT_SAVE_IA3=
2_PERF_GLOBAL_CTRL
> hard requirements for enabling passthrough mode.  And then have clear_ato=
mic_switch_msr()
> yell if KVM tries to disable loading MSR_CORE_PERF_GLOBAL_CTRL.

Weren't you just complaining about the PMU version 4 constraint in
another patch? And here, you are saying, "Don't support anything older
than Sapphire Rapids."

Sapphire Rapids has PMU version 4, so if we require
VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL, PMU version 4 is irrelevant.
