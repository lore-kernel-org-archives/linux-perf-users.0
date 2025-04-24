Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64527B4EA
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500392; cv=none; b=spneBEu0WB4ifi6LRqVSmptVkTV0mmvoU2X+Hkv54GIbaypPNSlFJNLFM/ipmdvdeVFc3rsmr/qBQlyo2dB2RQVOb5be98UJM21xr47qPNLOLDpMoutkTL+QOZdHNxQTvok0nVfl/eHdzFY0Z+Y4qCqHWLgybhB4KUHpgMwuSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500392; c=relaxed/simple;
	bh=JnqcVv5ipWAX32SbJHm/iasJRV01iMKRVyjmRylLsww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LHv/giXtOu7qmQILYnvRDqj38LWcmkYz9RGIPQTl1aItxnqEOIGPbTzkwy8D5zvtSP7Sma7S+3054ls38xBHwv6Ya8e43+ytkwv1aukGZexP8dqJYhydWVzq4NfyvpFNbkjodjCUqlWEDqIJdCm0vTqerxsRdlN23HKSfrSaiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=33RTNsBk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="33RTNsBk"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22406ee0243so7415455ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745500390; x=1746105190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0c86aSm9mbGutEGyAxJG/oYRe+s25bJjg1mlIbxso8=;
        b=33RTNsBkRgxXlD/yBT8yr0JGtYSz0vqe7wCD0qlbaKLAVw7ymKX+DVCrlqZnzBvMIs
         +ztybuVF4dflmWapNahute69VHDtmaf9Kqpcdifz97BnSNx7X6K4ct+yVqHhJkhOe1QN
         cm/tW0m3HuRiI2lAQN8ThIM7RE1K1E5GjCd+TrXMjhwuTLCMosyj6tdZleA3sSZ3s/Fg
         TtqVVH+Y4td67V17JTFez6EvDmZKA0dW5bj2vMFDiu5PSbXC6YCAPIo/YhTUv5T1ECH1
         ghGMYNKtjC05lOTH7wsLT1U8WujFwXsUuJYopY9Nz/gxx6cwRWtDdNwtOXIiKrPrgCUr
         VGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745500390; x=1746105190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0c86aSm9mbGutEGyAxJG/oYRe+s25bJjg1mlIbxso8=;
        b=HS6m/gvX4l8ZasnvbOXuuvRloIAK39gQ5nBsKfHksToj94NK0Ma4NyEGbbe/kZnxaE
         yk+VLhyzPz9jLxm+RjOQ/HHACj6WlHGy1vuPxU2yxtflczNUMJLRluOgvWzZ6UZp3NNe
         vv/nrI2BhsNSooQdUxFFw775wrMZNIr+Sv+Db5xop97Z7qqWkVnCwCFbfh6RkjJcYrWG
         QLB5BdNJ9Tp7VZ5KTeXOMlgdXSrtIbCzQ6auTncHH9n8/kMvDAsDSza4VA9zTqX6jKV3
         Jgc76sSI5jLcoY8j//4aH4TC0MtdnZfk+iK4ojYDdlAhQhauOqkBx8/6hVeOr5XBMIIp
         TBvg==
X-Forwarded-Encrypted: i=1; AJvYcCVhBUsF/CyqEMII+ekRAueujgMkqxwPPXH0STJ0RXkM/ADhxfiwZiUr2/7traFIPacroT1w5u9U27IymNqZmW3V@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkKJ14qLEkAK3lj34LmwNjZKTr+1DwvetfeNoUs7GRV00iOhl
	vFjMnw+rFWL48iftH1zMgn+Ot8ipXiqBsmk+3zNBolXZmpsyv45wH2HQfUbcuu5kO4H0mX91wYl
	oaA==
X-Google-Smtp-Source: AGHT+IEduhjZpso9oQb6/mx71OdtoyDLBu1Elijpug3RYWmeptfZdsfoKGSddxcFcrKlVeJDGITkLofUEhA=
X-Received: from pgar18.prod.google.com ([2002:a05:6a02:2e92:b0:af9:775:2e8b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a0e:b0:21f:68ae:56e3
 with SMTP id d9443c01a7336-22db3d77dfbmr39969695ad.39.1745500390413; Thu, 24
 Apr 2025 06:13:10 -0700 (PDT)
Date: Thu, 24 Apr 2025 06:13:07 -0700
In-Reply-To: <27175b8e-144d-42cb-b149-04031e9aa698@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z_VUswFkWiTYI0eD@do-x1carbon> <27175b8e-144d-42cb-b149-04031e9aa698@linux.intel.com>
Message-ID: <aAo445Nzi5DuAQAR@google.com>
Subject: Re: kvm guests crash when running "perf kvm top"
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Seth Forshee <sforshee@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 24, 2025, Dapeng Mi wrote:
> Is the command "perf kvm top" executed in host or guest when you see guest
> crash? Is it easy to be reproduced? Could you please provide the detailed
> steps to reproduce the issue with 6.15-rc1 kernel?

Host.  I already have a fix, I'll get it posted today.

https://lore.kernel.org/all/Z_aovIbwdKIIBMuq@google.com
