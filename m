Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F14156246
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081566; cv=none; b=JzSHyUGQ7bnavVF3W7fCzu0dMRD/Bc/wUAJoEMSJJQCFWlrD4rQ6iRunwKulym6UPfgms37VVmdENIMk1KhJDgvnUURuo1/m89CNileHTgGEo1oS4pq5D5K9TWQFG5d07sP+jYTrjA4/aIly4x/27o+BH7N8rb4Piu/xkJqPYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081566; c=relaxed/simple;
	bh=ddLKxs1S7s/ADJE035dpDCdlheH8Ec/EUB9hgxSWCqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ClGWuoP0eCoTYWg5+IY90tkHAZKUCjja2AaXFUpId704kPjiSHHwENQ8wfYDrD6vIKr6iUYMDxOuSz9lSDbkKIXkygYWJa+/tptzs1naPNkh7ZgAMAESY/dos0a6UvcL68jRB7MwQ4xjCjvekUm00mkTNzWl0Does/bRnPsy44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kSkLWvbg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSkLWvbg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5d8dd488e09so1688327a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714081564; x=1714686364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9g005zQ0uoPXb33P7XvBANrUcDvwGxhLLo5EvZW0qw=;
        b=kSkLWvbg9oxhLeu4v+HlAcmDuMvp/TTyiIxrPO+Km5RX/EntkNjXgZDBRuDfgwewoT
         ddYYDw0g/r1E0G1QsMEMXC7bkcQ2JNGli1QfsoCaghQhA+ZEh4YdQXiesFhgp0Fd5gGZ
         f7IopQ4+W8w0TB4+vzeoNVwMeRUmp1YQfvTcHOLogHR3kp5exTbIwZvjwPFRY/ZgMPe6
         mEU2au01Tjk2oSiqO4CHiWWQgmuSFZ3ThrhcMZBSTfjlrFVZV/Wksjb0NbkUBuYFAIUu
         HRvmQ1XECZBXWxtxxfX4usJjxSNUSmsXjoHGtnCfBtQP9xljJY21sEgKGZm8ALbWJf9e
         D3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714081564; x=1714686364;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s9g005zQ0uoPXb33P7XvBANrUcDvwGxhLLo5EvZW0qw=;
        b=ilhv0xSlbbQtKLS8PtBLEA9cs0RKV8IQtRAUw+IXndAEpkJo8fdph/1u6lK0sUNblX
         vDEtHeT0Ab8A2Jc58yPtJACkvTivJ1Pzz/wpLgrKPNO7CA+kyyWX+/tM6HTz31h3+Chf
         FwTlVvyf0gS+ytzk4zO7vVRAykQUe5r0UnhxYIT0BtiQwJNuGfj3rVVkphXqhNOxnvyW
         CVNaGN+F5Wef7Rk2be8Ecd1C7IaZXJ2uWRQp4RmRmNls6LgyqVNcnKT1NunPa6PhD/cx
         qdhc3g7bme4V3+52B7Zv8r3AiDz3vXnlBOY95VlbIOACWCDv7mRg+pd2UpKqeFB/V6cf
         El6A==
X-Forwarded-Encrypted: i=1; AJvYcCWtMwJrJrqTHkxXrAjeWt/4ct5KQTzGMV7fQmKvMn2R8bEAlSV658wpPdsRLV1Rx6YABrIu8X6eGd8nQ3Zp/rWAsFiaC/wTb98aLjDzAcSuHA==
X-Gm-Message-State: AOJu0YzkfMdWm60tKlu/q1CsKjR2p0PpIbDJmnlbi0Id5qgH6pjs4/Q2
	JoH9z6S0s0raq0dUiVqFAH4HcvMtXHupkPOy6xUqf3znhmCEe6rk68JVAQfIL+t9XAHv1S7gTsB
	NKA==
X-Google-Smtp-Source: AGHT+IF/LRU+EJ/onrc6UqwR3rdQDKd/KzJxGXef0/+6lFJNaOGOLGDyuSBxzSg57E/OPctPDy+9bf178I4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:2005:0:b0:5f7:fca4:6d2f with SMTP id
 g5-20020a632005000000b005f7fca46d2fmr25355pgg.7.1714081564026; Thu, 25 Apr
 2024 14:46:04 -0700 (PDT)
Date: Thu, 25 Apr 2024 14:46:02 -0700
In-Reply-To: <42acf1fc-1603-4ac5-8a09-edae2d85963d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAL715WJK893gQd1m9CCAjz5OkxsRc5C4ZR7yJWJXbaGvCeZxQA@mail.gmail.com>
 <b3868bf5-4e16-3435-c807-f484821fccc6@loongson.cn> <CAL715W++maAt2Ujfvmu1pZKS4R5EmAPebTU_h9AB8aFbdLFrTQ@mail.gmail.com>
 <f843298c-db08-4fde-9887-13de18d960ac@linux.intel.com> <Zikeh2eGjwzDbytu@google.com>
 <7834a811-4764-42aa-8198-55c4556d947b@linux.intel.com> <CAL715WKh8VBJ-O50oqSnCqKPQo4Bor_aMnRZeS_TzJP3ja8-YQ@mail.gmail.com>
 <6af2da05-cb47-46f7-b129-08463bc9469b@linux.intel.com> <CAL715W+zeqKenPLP2Fm9u_BkGRKAk-mncsOxrg=EKs74qK5f1Q@mail.gmail.com>
 <42acf1fc-1603-4ac5-8a09-edae2d85963d@linux.intel.com>
Message-ID: <ZirPGnSDUzD-iWwc@google.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
From: Sean Christopherson <seanjc@google.com>
To: Kan Liang <kan.liang@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	maobibo <maobibo@loongson.cn>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, kan.liang@intel.com, zhenyuw@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024, Kan Liang wrote:
> On 2024-04-25 4:16 p.m., Mingwei Zhang wrote:
> > On Thu, Apr 25, 2024 at 9:13=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >> It should not happen. For the current implementation, perf rejects all
> >> the !exclude_guest system-wide event creation if a guest with the vPMU
> >> is running.
> >> However, it's possible to create an exclude_guest system-wide event at
> >> any time. KVM cannot use the information from the VM-entry to decide i=
f
> >> there will be active perf events in the VM-exit.
> >=20
> > Hmm, why not? If there is any exclude_guest system-wide event,
> > perf_guest_enter() can return something to tell KVM "hey, some active
> > host events are swapped out. they are originally in counter #2 and
> > #3". If so, at the time when perf_guest_enter() returns, KVM will ack
> > that and keep it in its pmu data structure.
>=20
> I think it's possible that someone creates !exclude_guest event after

I assume you mean an exclude_guest=3D1 event?  Because perf should be in a =
state
where it rejects exclude_guest=3D0 events.

> the perf_guest_enter(). The stale information is saved in the KVM. Perf
> will schedule the event in the next perf_guest_exit(). KVM will not know =
it.

Ya, the creation of an event on a CPU that currently has guest PMU state lo=
aded
is what I had in mind when I suggested a callback in my sketch:

 :  D. Add a perf callback that is invoked from IRQ context when perf wants=
 to
 :     configure a new PMU-based events, *before* actually programming the =
MSRs,
 :     and have KVM's callback put the guest PMU state

It's a similar idea to TIF_NEED_FPU_LOAD, just that instead of a common chu=
nk of
kernel code swapping out the guest state (kernel_fpu_begin()), it's a callb=
ack
into KVM.
