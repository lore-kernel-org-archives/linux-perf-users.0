Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9623B27F5
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975267; cv=none; b=A5Z2QxePuvrVRwIUf6bSiXKYvxAnSBsFs6oIhw3wv9dAI06jabUE104x4w8W2yp+8sy0gBFgvobcbdZBPJ6bpVfx7IwCurVEqHuyrByXQxxo8qsPbeFXwo621172IiiMDj2bf7qMv1Gw7RDwItFBQ7fHumE/klpHCbHWi0IFU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975267; c=relaxed/simple;
	bh=Y8GDNbPyMgdEkV4CdxAFRFdT6Y8d1kGSN9nZzLCdeRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SAbR09MUYTcVKWvhDmkyWekhoX2YN9z+8ptVhxqJhTsvDaN680NEp3j+ziHBFbQ/AcVYnng8A5rAvzibdXgNxzQJFFrbx78YKI+hRfsSK3OZjS/OXluntm0k23NqrO5/rOOth+RjvdPvQwGqeyQPmsI+fCCLruO5OlmYKzp1X1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z6+8P7TV; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6+8P7TV"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-395543dc382so297939a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975265; x=1791580065; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8PP44uGEZEb+7JewBj+EOqBPmGw0RZmzzcgLW1VRFHI=;
        b=Z6+8P7TVdEAvYVjSWO4sFBaRbLWEuvn0zh39wrjtEYAOpjgoZr/dAtA0TLUo4JgQYZ
         /26tK+xS/pd8j3gY7finwFKA3gJnT1ho0hM/qEHTh/qMamMhaWZg1Sffftu11I++4q7i
         ZVzrjk2UnBDhxzfPf35qbEQrOucqvLD4RGgOwvb92BTdLm1olZgbuF+aOvxjqperrasK
         zdO0+1jUveZwfVTlKU+K3adpk2aG3EO5ojxzR3EoWO/mIMvzYNpwXhvqRYLm9taACRa6
         aTUXMfdxAUTlGAtEmsZhjItOd7MSQX/wtLAoOHZu+WHrxYjqIMcA4As6BLl2abDDSYBs
         E85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975265; x=1791580065;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8PP44uGEZEb+7JewBj+EOqBPmGw0RZmzzcgLW1VRFHI=;
        b=hQzoFZskeyO1IUsYWhhkRdHsZf/e530Y9sT1NuBp0HRSvTNBrYk872f9g1LRmresVY
         1KUS7BhVxCKN+dLPUhjaLDeFyPHQ4HEkEqUYBhw6f4kMbKyJX+rB6APFn/8m3GsE/rKP
         k0yVNT0TDzXTAlbVVi+mUmalE4MxarL3QYVCyhKNdFZ+5HomoVSiZ0tgRXPD21hMQEz8
         cXDZckCGYntpaH9ZaUsixjTXlmV3mFcXt7cOPgD/XxkOEKgwdYP+QE3Ng7uJDcJMd0fa
         yWdwtqSEwVwjL95z5zB6WYnFK+kiINtNAGLDJppYQb0hfwEGCqwRqTGQU48yQbwevX13
         3Ucw==
X-Forwarded-Encrypted: i=1; AKwUvBwb9SNv3cYuRZWi6fCoaCEulZ6uSIhTQUGYWxNtfETQGwWwz8zf1usfWk80o3QlImAjM4fe9kn/NlMRxYMZnqze@vger.kernel.org
X-Gm-Message-State: AFuF++kT744y8+kSolDgM7doG8NDoOEMcTu99ZP5oMeD8OtNufrKJHJ1
	jeYcfAzYJBely2pW0KH2X60ovh2PF+iotJuPDI0OGvrNZhMYXJj34MRhH11C5j4CRaOtRYmjXpf
	RCBGSPA==
X-Received: from pgcv5.prod.google.com ([2002:a05:6a02:5305:b0:cc7:84e0:e066])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918f:b0:3de:7c83:26cf
 with SMTP id adf61e73a8af0-3e0bd18f3f2mr4012633637.19.1790975264546; Fri, 02
 Oct 2026 14:07:44 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:06:50 -0700
In-Reply-To: <20260920155453.10836-1-absandze@amazon.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260920155453.10836-1-absandze@amazon.de>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097502083.4081947.8136908804673682436.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: x86/pmu: Don't retry a counter whose config was rejected
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Luka Absandze <absandze@amazon.de>
Cc: sandipan.das@amd.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	dwmw2@infradead.org, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, 20 Sep 2026 15:54:53 +0000, Luka Absandze wrote:
> kvm_pmu_handle_event() re-arms the reprogram bit for every failed
> reprogram, on the assumption that the failure is transient and a later
> refresh will succeed.  That is true for contention, e.g. the -EBUSY from
> x86_reserve_hardware(), but not for a configuration the host PMU driver
> rejects outright.  A rejected config can never succeed on retry, so the
> counter is reprogrammed on every PMU refresh for as long as the guest
> leaves it enabled, and every attempt fails the same way.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86/pmu: Don't retry a counter whose config was rejected
      https://github.com/kvm-x86/linux/commit/1c24893fdb4d

--
https://github.com/kvm-x86/linux/tree/next
