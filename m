Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984B2E888C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763337; cv=pass; b=SxnjV21ygJ5JbU7ppszqXFbUZiIygpfO9DM2EINNoMG0vqM5oiizE9TV9pItDLjTg0zlku9d4o0HMzY97A2mnxS2PHQEpCTw/wKbhECds9uMd1TvxPFb+hut2XxoFBR4zfOdoobWiafsYHVwkToMWab0ULy4LTUy3xDNHmA+8to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763337; c=relaxed/simple;
	bh=CqqW22RO3ZRqLUDSRy8f7yh1EqvrK6CgpS2J8cVHpqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYWU9otrakgvcGwTKIuUjIayeozp5doB2ndiLf6FbsziJKZ7wjm2t8kUOK6ihG4RpJuvRA5Dta3jQ2MPfwJ13sL+85u0+r31pyaWjVlsDUpe8aEwuFDUbItb3LgXRazOdqJRzl5tVwhutI2dH0TCnk5Dk3VKf8xraHBVcC+yCOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsnKQETc; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsnKQETc"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so13116a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 09:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773763335; cv=none;
        d=google.com; s=arc-20240605;
        b=bWJ/u9dWU3OSI3Cs3Ay64wP6YrMfjWGwE4A5yUXroNUZk9oJkl0ZWRBxyKXbV+f/Py
         awclJkjNdogsTDVE5IIQ2cCluXypjl1aHNmoVk8Lvkhpeb6K1j7FqNkbNL8UTr7xH0O4
         ZmY+Jx5J3ObRWrNmQX9AN0rW3XMS5RAWb5dERdM8TRB4xfoLI9q7zxBbM6S9e3N0wg6R
         dH1CiJXQYgpQ/I8F8L3GxWc5M8bcNVM2qwB8ahezAgKVFfS0ykmB4vOJJsZF4Zty6Ufa
         sz6xhBXo5iOdueRBY1p31M0uPI0FoheLnM7rKbZdeZHceGpC9tIkIACIcxc6MAvNeMOk
         dp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SY4/5vAWWcaV9x0jV4cO7baDxpJaaDgGr6iFNkqEvuQ=;
        fh=+YXLT1JC9Nj6GspRhUgjWEBk/AL//mUcfQSxaZqSbKw=;
        b=WgbA92NFluBtELxegg7U2OoYUdkiQrpZyc74uDxGAFVHAV4zWMD5bM3HOQS6LtMk/O
         Crh6G+Q0VJxnE5iEOOSRRVAp6a3Spm/SBSl+MQokYqkLBGcz9qWdcXRh3bHwTYXuT5P/
         kpTXNZZyon2k2YnZJaJiTmG4gbdoaFFXqnOZBqsuojWC4waFj9L3KNh9a0KnFBzNRxWu
         K8iyD+tkWu4t6OE0S5xmIAJOOwC0C45QsguQikvXH0aKOeIbHdP/acUmZAYIoDUr/IhT
         lufG78U8s0nu/u+UNNH4az6zahq2eI4caHrwOc+lrAMGAWrC2qfQpGB81NMo9jsfOAY1
         B+2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773763335; x=1774368135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY4/5vAWWcaV9x0jV4cO7baDxpJaaDgGr6iFNkqEvuQ=;
        b=MsnKQETcw3qKro5hwCDhoywmoAkFKeqa6Ir0NxILtQoh3sEe6M1IDctTtxvrzn9RbA
         VnIBeNtfj7rMVSafhLU60CmGjcMJrp0bSpMoo6JDDtZMnd6i86Gj5cKU7eeuJ6hwNGLV
         6CiI442hnbmbJVYt0g3KzJY37QenvPYGUcv87moJTBZx+mA8WENJTmQcSq34Ze9xoUIR
         PwbKR3l1umlCmsU6B5n16/2n0l0GGEAxH4/Cvb5P8tPuq9lzp3z/Z1JoPWWTraAfiZ78
         819B9K3dxiHh7ce6yKbcxo7sp26n6xAU9Wt2fSTaK2JEjRXr54Zp+HEUa7M+TcmQis5+
         k1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763335; x=1774368135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SY4/5vAWWcaV9x0jV4cO7baDxpJaaDgGr6iFNkqEvuQ=;
        b=ABJR2KTHwZuPBB0qhTvMs1+zqcse5HCiWH1zzMdRmT93KduPBA6PzbJZpMBeaTlo14
         BU1K+MG1T+e9ofTxJOT/x69jxcTXMNZvpESd9f1Q0nJHCXA62UPNuFcSQwh3RONCKXfV
         f7WnJjHlDTDzwp8X1gNVJvhBgaOgvMRp3Qh4aipBAB1UZMXPmwmGVZZd6dpbdUx+SD6p
         r7wUvy6r8/mkaeS+8wpnTJm3HQvyi2PsZ2AZ3oYQOFestNJDO4FJiNpaSoFvlMWXh631
         AntJBNRn1d4ZXQZNgV6PJ8K6aO8wuK9AtL5xI1dUV3j/37GSVa3MfkBnKbaKL3OxHbIu
         Xz6A==
X-Forwarded-Encrypted: i=1; AJvYcCWf1SkMjMbZQMQ8QvKeFYyYemK1jvA5+ITNktO9Lq48Hjr3AkcjV/orD5yexJCclDC8kXIMYmlXJFQw0hxJys16@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCLKPqz63bcmIHEsIIll3+jBds4g1UwdGzNJSTZotEWpITHIT
	AoLKBeBhgDrEgb5AJzjQiBj2E58DkFxV3RKCY+c2QuElLnZxhnmzJwNbZijKYf8dJhcIwfWJ6xD
	NCR7ourXqc73UcIwbzu7Y3tQwkLiXTMLCe1fb1ID2
X-Gm-Gg: ATEYQzxdatQBlGgV/PPaHNm6oms+FZbL5agZNxzIqzt8F7L3TeVbht2L3LtG47/uV1H
	tWoOEKlOOS6cC4KM+4b14nkmFhJOpkvWo7jX/w38sqkH1O8uaylqpa8BQHufoUnwgrH1V6eCb/J
	66PWI8a5K0RJ70p9vDU4S4NO2VaLsC1HMN+yTC4rRz3lJNRbShTVCnrzH1euLUaPWzVoImE44om
	zld2QZkEqjno+zf3xOkqxd7k9KOkhMBuEyQc8RcG0do2CUuiB4fp7WC00lIRz82HXmqUDrx1bC7
	8nXpCv33zWC3xg8o9A==
X-Received: by 2002:aa7:d691:0:b0:660:b029:3d4c with SMTP id
 4fb4d7f45d1cf-66713bea8f6mr51265a12.2.1773763334159; Tue, 17 Mar 2026
 09:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_VUswFkWiTYI0eD@do-x1carbon> <Z_aovIbwdKIIBMuq@google.com>
In-Reply-To: <Z_aovIbwdKIIBMuq@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 17 Mar 2026 09:02:02 -0700
X-Gm-Features: AaiRm52Qe_TIMFzvhlPR8tJPzof84bHGndhqcQdcQocpyA2EGQ2Rrcs0dQ9C98I
Message-ID: <CALMp9eRvB5Jqbs6aKMsPzKDJE7Pb0iUTsO9Ot1CB698px1GHcA@mail.gmail.com>
Subject: Re: kvm guests crash when running "perf kvm top"
To: Sean Christopherson <seanjc@google.com>
Cc: Seth Forshee <sforshee@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 10:05=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:

> Long story short, masking PEBS_ENABLE with the guest's value (in addition=
 to
> what perf allows) fixes the issue on my end.  Assuming testing goes well,=
 I'll
> post this as a proper patch.
>
> --
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index cdb19e3ba3aa..1d01fb43a337 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4336,7 +4336,7 @@ static struct perf_guest_switch_msr *intel_guest_ge=
t_msrs(int *nr, void *data)
>         arr[pebs_enable] =3D (struct perf_guest_switch_msr){
>                 .msr =3D MSR_IA32_PEBS_ENABLE,
>                 .host =3D cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_ma=
sk,
> -               .guest =3D pebs_mask & ~cpuc->intel_ctrl_host_mask,
> +               .guest =3D pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_=
pmu->pebs_enable,
>         };
>
>         if (arr[pebs_enable].host) {

Because kvm_pmu->pebs_enable is optimistic, I think we also need to
swap these two modifications to guest PGC in the code below:

arr[global_ctrl].guest &=3D ~kvm_pmu->host_cross_mapped_mask;
/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
arr[global_ctrl].guest |=3D arr[pebs_enable].guest;


By the way, IA32_PEBS_ENABLE can be modified in NMI context by
handle_pmi_common(), so the host value returned from this function may
already be stale. We have seen cases where handle_pmi_common() clears
a bit in IA32_PEBS_ENABLE between here and the next VM-entry. VM-exit
restores the stale value with the bit set, and that bit persists
indefinitely. If the next perf event assigned to that PMC is not a
PEBS event, it magically becomes one. When an NMI arrives for PEBS
buffer overflow, perf refuses to claim it, because it doesn't think
any PEBS events are active. So, we get an "Uhhuh. NMI received for
unknown reason" message on the console. A flood of these is enough to
trigger the NMI watchdog and cause a panic.

I think we need a fixup after VM-exit to clear any IA32_PEBS_ENABLE
bits that were cleared by handle_pmi_common() between
intel_guest_get_msrs() and VM-entry, but I'm not sure what the best
API might be. Calling intel_guest_get_msrs() again seems too
heavyweight. Maybe KVM could ask perf nicely to just rewrite the MSR
with cpuc->pebs_enabled? Note that any erroneous IA32_PEBS_ENABLE bits
are dormant post VM-exit, since any PMCs throttled by
handle_pmi_common() will have their enable bits cleared in the
corresponding event selector.
