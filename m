Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344EC30E0DC
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370376; cv=none; b=EGAmu8hdQgtfzxw8W5cW7CFOY3QdVB+tVj5DLLdi55646VzvCH4ftKdPmZnFDpJo29dqNZ+nBYupx1FWlCYslWGU3rj/PQHi/4cDe8he8cVxTXLbJkF+hSFO2FIzmKD0+PoZ7EDXiRh1VCqQfNbjuUhYnnpppukGVcSLAKf1jXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370376; c=relaxed/simple;
	bh=Gh0xkG+HEMAZ8iif2uzqr6cU9prk01bUy/kDmxuuS/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/hpvClIj27ArnhEv422Ds7v3HasvXzXe9zZWyr1mycep8ZN2wBxE1Q6y8giMazQ8xU9MgT2mxkNtQ9CBB32RIXwfGoqyHNu8wdVTEWW4POePrRlVbVaw7hZK8d/ZRymORDP5ZQ7CEh0L9cCPPOK4sJZASFmjwF+CED1kGu2/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbZQn7QQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbZQn7QQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eeafd4882so467805ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760370374; x=1760975174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gh0xkG+HEMAZ8iif2uzqr6cU9prk01bUy/kDmxuuS/U=;
        b=DbZQn7QQbkVwvsxfGu/hYMBmKynFftcCyOlq/COHZFBSI9BSDQP/hENqqZ23ARVy4e
         5fP5H70U8y2B/W+9JDXDq/hne8iG4+El6tNlHR3G9riowKdjVvIQ95MSuLN6vuaqybZD
         HhzfkRRQms509DdMecs7MnSwBrDpvEiq1MgmikBOaYS6hMYk/re8Zt4mH9GIr+QVceuX
         vXU9TumgIpBFInDzA7WoIEofZoL9q/5so9zlswLKx4mSiWtPt2L0ZO6TPEx4jwRGEJ9b
         W6TM8v3KRoU8Atzllx/GF9Ev3PCxJeCADmnmBaSWL4W5ppXA+Jy5q5/1Ccrn3i8/d3W0
         Udqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370374; x=1760975174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gh0xkG+HEMAZ8iif2uzqr6cU9prk01bUy/kDmxuuS/U=;
        b=VXdGu9aklPnM1GVlRCe6om6pzRRFIu5klpHlGVdo/sTtJMrErEZj16Kd6dogLTn+wd
         Wn6i+1Aj6oFwazMt69TmIyJhkRqFAC3aE/3vTgMo6nOL+dFgi3hRNICMkWDqYmS+vdtx
         FYerqR9xbTzpqOBZBoQ1sMpBy1rV7N3SzgibLS59Wf32hBs7FG7qYcIR2p0UTQRBBUuf
         6RwwkoeFehMsj9KbIrwbG63l2yXfL+OAXd79wq8WgsbM2esCIcWld7JHrEVZFDu2enfU
         MXhnOic5pZePSvwCAd44NQ0zEfeHE71HCSnAEnI+vGc3e6IxVWBdwdS1oewvvULzdEOL
         to1w==
X-Forwarded-Encrypted: i=1; AJvYcCVeC4eZrHDwqSKuWtSdgm2x35FqR5Qjpuj+Qzy/BP/YR7zTwBFbhvyzhsrBTeOOwQG/Sg60S55/xseKR/StzInN@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJtjSc1RpNbPoX+Lp4bGzYEF4RG8QBB9f9QhAPuyywmoq/kmP
	YWO1Ybhf4Qop75W6TrzkSAFauza7qfL7twOAdWQr5E1mVhFYO5wP9fSJTIxC2M35uj5hJ/guUHg
	IDo1Yo3XFZ8k0MLq/BE+tBmIDwL80qKr2T4OIKgYJ
X-Gm-Gg: ASbGncvdeWKHKnF+L7GGHXnH3YNjd65K58mhqmJFv+PZMbTvmFQQUmkgDoMna/NHu9q
	9iqHEx5mseBRYOpQ1+GaE+hSjhdyj2+nB3w3OCwo7BgFWbFEKuNEM+JQEs0xCk997Nt8zLNxYju
	K9q7OFsY0hXB/0CngKWdo9fRXrGvAheChcTyfgPP6/Lt4xCZ+vwa7W3scR8+jGqYWKRtnfvJ1De
	cmMF4gZf2SGHpe46SvzwO191y9AYE4FLO/NtCwFfeGEfyuXCn339KjRJ+4O2pUpxeMro6Ed1Q==
X-Google-Smtp-Source: AGHT+IFpkUdbriJp23+2Jb8eOJGaVHdsjhGARS/bTOlZqK6t4o+Ul77JlTrOQ+g9Lp/XnQzRqj62GmvLzwrp3fj478M=
X-Received: by 2002:a17:903:1b66:b0:26a:f9c7:f335 with SMTP id
 d9443c01a7336-29027699597mr25468055ad.9.1760370374228; Mon, 13 Oct 2025
 08:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
In-Reply-To: <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Oct 2025 08:46:01 -0700
X-Gm-Features: AS18NWCYdUVbOnDz-j3sbDrxzDX70h3ig4G8MD5wGb1R-4xJxXjeiEmchhKFwHI
Message-ID: <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: hupu <hupu.gm@gmail.com>, Leo Yan <leo.yan@arm.com>
Cc: namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:08=E2=80=AFAM hupu <hupu.gm@gmail.com> wrote:
>
> Hi Maintainer,
>
> I encountered some issues while cross-compiling perf (ARCH=3Darm64),
> particularly when enabling the BPF option. During the build, Clang
> fails to compile BPF programs due to missing header files. The
> relevant error messages are as follows:

Thanks for reporting this issue! There has been some recent work in
this area by Leo:
https://lore.kernel.org/lkml/20251006-perf_build_android_ndk-v3-0-430559079=
5b2@arm.com/
The patches are in Linux v6.18-rc1. Perhaps you could try repeating
your build with this tree and reporting issues?

Thanks,
Ian
