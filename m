Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9D3932CA
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573960; cv=pass; b=EFA+l4pV1NO8TPJpJ6zmm7azEtIaNTSHgEJlSgNEw6DXWhjtPsfm3Sqb0KolRkHW5gI/r2Q9fNU0KumP95tIWYuhNBvQyOTFZ8ijuxAcjjFtmtFmUHIZaYKxSUgLS7ORFsK3pcNrvq28gxlSdzhM2aVVxCZIbC7YZ3E80aTiM8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573960; c=relaxed/simple;
	bh=fFAElkF7CUR60GDJaFO5zfK9HienfC7eKeiuvWcR+Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwSqXh49Z7P2Wwz2XnEE0fN0X2zD6kJKPTkdsmq8b4P+pK3ZRntMKLOXjnDdYs5i4lAcYIHHnGC5MDovnXqwFrQR/V0Iz1MmlIlJAvp+XwNXDcmmbTepByEbdUyv6jdeOn7tcgP2WbVQLpgGuDU7tvKMlPwcJBopHra+1wWPR3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urrYZLlS; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urrYZLlS"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5069a785ed2so702611cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 13:39:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772573958; cv=none;
        d=google.com; s=arc-20240605;
        b=k1sSG4dj9JgzPmin6jk9e7mXB0L+Kibmh40kVwwwhb90DS07NgQO/aMLEfGyMJpu79
         eAkCCf7WJTrFtuKAiZOOc9IEf5oHfU7eNIaBpxzf+KdUjO8bEXX8C6FJXnAc9hTL5W9A
         6BPiF3npc8uQSmeo4ysLDXTTszFuUuPXvgaYEvvxk0CI7IPeCUgyPQIs0diqiCEPQQ3o
         Udie/lHn7EEglA5T+4H4QkZSz9PFW65GQnBCTgSyjDv9NEhaWFAhMyHKDa/CG4pqBxbj
         vatLt3sldeRnL25NjTzgE71jmdNhWkSgDm/vdFHLqFqaPy3jf9i4KB/0wvPZ9LpFrL89
         YWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bcnZYXl2BjJMuM0/iADjl1cewrDesHr5oW+IPkJ8qks=;
        fh=A61BwR4E/VJrZzBvYTNY/mljH5CQxZADW+uKZfhNdC4=;
        b=gN1fbXQqQXeDycn7ugGTtNme01blSIr0t0Mf9PYm3N+aJLAMz0TjjYog62X32pZzCh
         b3tlvA+snq5xO7iPw4guA2ywhN1THO3Ap1F94UlaOSlFktvuZPhDlRTZaIsOaNllOy9L
         KFMmkoa7Pvm+1qwegUmlD7lrEtq5DQOznMZvMg9cb3pOOMggAsbelgrmxdJSOwetkSv1
         cS7oKWkslRQToE9v+gX0yAQNJdGhJDQbJWMGrpawMidaM/fklpBWH1313kMU5PJIwuT7
         nLpm5L2zL05scsClHLJEwgK1dfxQiaS0M9UPTAxVgq6WfIn2SbWmOg5WX4HnbCQ32DSD
         dwOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772573958; x=1773178758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcnZYXl2BjJMuM0/iADjl1cewrDesHr5oW+IPkJ8qks=;
        b=urrYZLlSRrKI5XMoirf+oqqipuJjfyedHLrjVILHepEH+u3/VD1hN/pcBfB7oVB+N5
         TqF5GESRKSqtHHcEAIBTXV5+PB9wtZ0XCfSgpbQygJtAuh/uMY0yOFZ0BAiKes1CAIn2
         1Z+TepzcISZDNJD9MkZmJTeQrjIEd7SybnHZPOMrz+2mgwqlFcutm9FxK/C9E/ZYi69o
         SMG/79bHPRP505syYLqe+uAy7gTdngVnEjXkiQsLEUWHXrmcoGPucANRUew+53hi+Mj6
         Efp91BO394jvkSvIpEzmsnLt+4dPxkWlKAypkJcl4Y+F3WQ6pYkU1Tr3FLKaAYKnUAX5
         2gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772573958; x=1773178758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bcnZYXl2BjJMuM0/iADjl1cewrDesHr5oW+IPkJ8qks=;
        b=bEmIJuCKqVPOb1S8y4d0nlOoYJQvlfTpaLw1dsUss40LXZSVQitHd4D8mGxuTpgEF5
         +y40nSETlmcYMXIoG0Fy0KJRhP4BUyKRnK8XIYHGTbym5rvNh9MVMIGkmivPo0LCr2B4
         mWFSuTWIAqAfOXavOu5/0Kuq+k2KJTqm7wVBouVFeGx2Lu3wGkVXEoTZ/ZYplw4naDRB
         cWQVHdFj0pLiITkPnczHGcdRiTrE5IH61Ufd9gTOJyvuvfAenXbwI4cdOEhihbyqwEZq
         Stp66/fw5W1/AerhUjRYFm0XzoYaJvmrLYr462+/vMWRCxMvqts67Ou2eKaXT2OWDhyX
         gEfA==
X-Forwarded-Encrypted: i=1; AJvYcCV7BzPKhv6U4sY2Ewiva2q9L6K69hwmyX8CF3IksyzPW/5lQWruQEnKzCSXaC28leMs6QT5i59K+G/tSQaglZMK@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxPq6BZDRiK/ZWZWZyjrrkWvXcMl9ZxSFQuwd1jjaJtBEbXfk
	wIAV7aNAAl5Dauth4Rv/qFiTO8xaCLmaow0watmqd/FJzqrh5Bfb80mbl9XeaGbtiy0VGD02HSg
	SFlzDfBLAFPam+SOutAA60SlGy9oltjxLUIBgodPq
X-Gm-Gg: ATEYQzx5IhHbaWT238sx6bVg5DZ6dogMF34ocGmT8tQObPAqFuE57MsLiHwiBlr6nkg
	4hrXAspJlSQsLMbM7Af5wHj3+rWvWARtC9wJCjFECosVmvaZeY8W2lpxifewnRNL2EuLJWnqzCX
	iNttV+OLg72d2D7NNlgxNck1lbxQR7ZM2LNGgCUumiAxnRi4YHPH6oA2tSATq2JUjzjA3BRIG1E
	5ArDAsU5xW0EFB77/VBFtxhVdztN3KxTG9MM4wTKu25cFoQk3UVw3880rB9UP4/sMGwrwdVCrYg
	1GDHJMW7TBQxsV7ZR1rgpsGaEk45KPp0HhSo3l+z
X-Received: by 2002:ac8:5dd1:0:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-5075fe651d3mr42016611cf.8.1772573957041; Tue, 03 Mar 2026
 13:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com>
In-Reply-To: <20260214012702.2368778-1-seanjc@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 3 Mar 2026 15:39:06 -0600
X-Gm-Features: AaiRm52vA8aXyZ84QO0eVPVcndLPd2lZR9vVhS9_WQuv-P7okwod2ZXFImZ6Qdk
Message-ID: <CAAhR5DF5BAcFO2tj0H63ZoRCcdpDS4Jw9XzqC=L2xWMW0M=0QQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] KVM: x86/tdx: Have TDX handle VMXON during bringup
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 7:27=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Assuming I didn't break anything between v2 and v3, I think this is ready=
 to
> rip.  Given the scope of the KVM changes, and that they extend outside of=
 x86,
> my preference is to take this through the KVM tree.  But a stable topic b=
ranch
> in tip would work too, though I think we'd want it sooner than later so t=
hat
> it can be used as a base.
>
> Chao, I deliberately omitted your Tested-by, as I shuffled things around =
enough
> while splitting up the main patch that I'm not 100% positive I didn't reg=
ress
> anything relative to v2.

Tested running TDs and TDX module update using "Runtime TDX Module
update support" patches [1]
Tested-by: Sagi Shahar <sagishah@gmail.com>

[1] https://lore.kernel.org/lkml/20260123145645.90444-1-chao.gao@intel.com/
