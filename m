Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793288099;
	b=JNuwgmgc4ZZSypXZchkI5WDygia36oDnjJj5dxmewKF93zsKd+W2WpTCcXE2JQJKnfoy
	 mdi+Y5ntCMBZfjYYcowU2dZmgWD4GA9330p6jhA/MQYw0M9tdp+knd8ZSMurICIY4LTvp
	 7ljnla2Uv5JMxZ3F+RVvd7rDXMGYkbojrmghyqvQnyoqrs0sAfFBVPYwV5DZEAXdF8/iR
	 Lia4cmpsDHfFWksrkoYotKESOIf25kI6wPbPn4jb2jT/BNLJmvxLXtfYuF+ZHKa3hHk+h
	 tO2YGR6I1yEaZVtX2p0kBtYQEKHmNbuM/xjXLdDL9tOeB4x+Bm8HqXegcIc1YnVL5dQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K5Rm/IwaNhYgMhwcnqL255xWGYwp8sgs8BcKPKPbzD8=;
	b=Rr0l9YaZ4/ZkNKHTSy1BYWd+ds0pMaOspBntKPeHBjPW9KExi6t1q3b+UVaKENpKik/g
	 rZd+IDY8e2b8dOThuH7cGXCdTPU+1D+LJiB/hwnKkMJuuJPgRd+ziN+aLyqon5ibZjdRM
	 KhJ7nbAqvxu/l68VVRNeqcZ1wShjoxJzdPO3RaTuKHBUDw/qr2cL6NOPh5PtLVLKZj+/H
	 PU5w3c7E1SpB9s0RJBjiENJeeNrjcPCObq5OOjZQFSChq8cDyfe7MgvpszrdyQR8UbbvD
	 T8YgjVCZNW8B4mLZJarA5mnROIrF5H1kDEqqUYoJHvJHZGtAFc0+jeG4gN0ZgpoO0KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JU48K3St;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83915606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 15:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83915606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JU48K3St
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a98fc80925so26933191fa.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 08:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793288098; cv=none;
        d=google.com; s=arc-20260327;
        b=OoYC+doXZvLoT7yG54/J0CgHrJ5obP59E+04eVeIVmFZdApbRvpjIEXDXb2RiLxpnc
         37sOa54teHYLY5U3wEDOyb77DPBknjCtRjLA0v8kO3cXuNN4KVMrI+gJ489pwCz1R/cI
         TuobuwGQ7SMXK6xhUw8Wwi+Cfv/C2vMfZPKICqdGkn9J9uNwfM0al3BIx7S4wHvXQ+L6
         eCoWjHjBnyj62OMa5QRE4Au5i7svInwbpfWuexQqrMCJK+bnw9DvKKohWsiEbFu+Q/Vt
         ve1gnKJprfu/j1DO7v0r96TL7EVq1T8avmR3kaQ1mEo4RqTU9RXxtDoxvUMN+u8IIDMz
         pXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5Rm/IwaNhYgMhwcnqL255xWGYwp8sgs8BcKPKPbzD8=;
        fh=5T9gz7PRxOhgVWQr6vhPAFBtLzaNASuMb/ceR4qu7ag=;
        b=kLAfKCuYDfSbluGMmJGyK0V2z8ImRgbwDismI1GWjYSadoBB53CQQmzp1WpORF1xov
         hGLQUcqwB+EbqNf7ymMmKXFJOSPXiL3069vhOdDh1qebXo+hmYH4ED0nxadPIROTi/3P
         SnHfi28T4V9K1EDFGBMEuGPTCrByReus30S/y+VrjWEIcQKXLR5YOa44XZkUGf6oEnz1
         +SntWEcfiwQGotq1mclaroBWmFkLlNY98TJCNhU0oHzVzbJneWtqImRYEJoAGlTP2maL
         aWEkPLNo+I/yh948t/ipZUq5baGMVv6ZqWd36FmJF92a+Q1jpieUuO+9z/e8K63pkn0s
         cSpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793288098; x=1793892898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K5Rm/IwaNhYgMhwcnqL255xWGYwp8sgs8BcKPKPbzD8=;
        b=JU48K3StrPmJy+BWBXIimZZVccOgFf+hwfyzZld26az5XfF9tBNddSRRA6EbTNH/iI
         1gbEcjpkkMPDfjRZj02sayE/rDgogPl0HqX5RxpF3COYCVPkhy43++ax7kr9CZHbByT3
         /dG90Httmlbxd4g/b2oVe3D6+xBGiwLMUqyhyuPWpEoQ5MWrA2UcABudFCclnuawEyZk
         dhu2cpbb9eWELAn7JEH4LlscXqJmgRxhSQVK2TuZhaGHbfJ5Nk9UuZ75GB/iVe7JDuZW
         iHoDmjlZjcOt1gUo+onBNqR9c6cLGbeiJGrW6NvFYLzqSHKn5MvAW4M3q02ZPy6GtHkO
         6z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288098; x=1793892898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5Rm/IwaNhYgMhwcnqL255xWGYwp8sgs8BcKPKPbzD8=;
        b=U01sl9zzLB8rPSr75s4Zb+ni2cE5EzxMGSAAVHN44vtksFF+QDMuqUKfm0OF8baKej
         6LV5KUYUwqsQI44IsS16Ikssg9Ol97T/Wf/KsoJdluY1slRwPC1t8L+DOg+vNun2IKkP
         NVw6uyx2vKkb3xagTEOtCvlX2DNl9C4aBNTlq3+xs+ALFaELEDxoEj2pYpsBWYOkV9Qr
         DHiNqG0yK9KZLWAqbDoOdW8h9iHMN7GDl8A4KjgOZhhixElsIahHTnJOy0lRS6Y2o7Ux
         P2Gyi9Xnhc73qh2mZnPRULr0/TjWkHos7N9xNvrea8D7tzD073H3uxS4jHQk+YWy24EP
         0UrQ==
X-Forwarded-Encrypted: i=1; AKwUvByalCLnE+zZqPNEawfC86RsCgPtpa3MUaIw07drR2n7ct5A3nK8o7Posa2to8Dp1Nux3mjBnHOnXvn+8CSPecxP@vger.kernel.org
X-Gm-Message-State: AFq9FYKj1i4ZFSDonTXSG9at/CnsX6gSbMxCGpie8WkxYNlK6tw83JXA
	ymiV8puMpSSlcegm4FafGP3V2c4O95Z/jNfr/JR0bVpcon1cp4gpul3io7aGiS9m4bA4A2ST6uA
	4Cnbe/xfeqgCOTmoQRbCDSMKMAZ5dwkM=
X-Gm-Gg: AYBFou3GIH55ugvpHlOgJZjB7JMGX4VDUOMye41jIys/leTq2INEocyAcS9SzB8uwMV
	XHCAxWLBE53mx0wvXOOYX6ZZ4U72vAiJM46xh+4Wf96gke0eOA9/OmON2OFu21btlahDMNLnU9b
	0lDqYSjaX0gQLVjaatbgUDawBV2Vu3V843VAMNVPbOLexcTs5cOeleIc3kHeWXh2pDuFTND/qhJ
	UyU42UCmQ+9koc0UvYzHibFeiJ7DjNxsvXKYZ2lHLU77m5VPQBN0UzFDzRxh9Lpx2GV68oYzN9S
	saUEkfnjKiMz+cqoo81yqQ58O550GpCSHLWHe24p1nJckO6ueFLzg72wkFNmuX7ouKY7uVkoBuX
	0C04JUwjc1IjAxM1gidBgvd9Jwy6JhINbXjxQRvuh78t2J/izKTvdgwwdrOkDur9Yt59kxi+Sbs
	OYbnvvKRAcF0pBNgPbsOuQ4qdgjz7borItyIsJEtW8926BPImyQ461
X-Received: by 2002:a2e:bc01:0:b0:3ab:4107:1bef with SMTP id
 38308e7fff4ca-3ac9ce5418bmr14386351fa.1.1793288097433; Thu, 29 Oct 2026
 08:34:57 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com> <20261029091141.GG1779021@noisy.programming.kicks-ass.net>
In-Reply-To: <20261029091141.GG1779021@noisy.programming.kicks-ass.net>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 29 Oct 2026 11:34:45 -0400
X-Gm-Features: AclHuK-YqVWgs2e1oeI2-sd1y4gbLXMqMG1B76Dt72P9DpeCFgJ2eqCh-7oWuCk
Message-ID: <CAEdQ38GiZLmnjYxzN6C92uz4-MOX7KoYvTuRrZ5Zike8ssDCqQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] alpha/perf: add ProfileMe sampling
To: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Magnus Lindholm <linmag7@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:11=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Oct 28, 2026 at 02:09:29PM -0400, Matt Turner wrote:
> > The 21264 from EV67 on, and the 21364, have a second performance counte=
r
> > mode, ProfileMe, alongside the Aggregate mode that the driver uses toda=
y.
> > An Aggregate mode sample reports the PC where the overflow interrupt wa=
s
> > taken. On an EV7 that is anywhere from 15 instructions before to 12
> > after the one that overflowed the counter, which makes perf annotate
> > output close to useless. In ProfileMe mode the CPU picks one fetched
> > instruction, follows it down the pipeline, and reports its PC along wit=
h
> > what happened to it: whether it retired, whether it trapped and why,
> > whether it was a mispredicted branch, stalled before map, or was killed
> > on a wrong path, and what PCTR1 counted while it was in flight.
>
> Isn't this the thing that ended up as AMD's IBS?

I have no idea, but it wouldn't surprise me too much :)
