Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85642D9ECD
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562578; cv=pass; b=e4ihqsROskTNLw3NC/tQDSE8VSrCKBnzhQSBbq9XLYap/3WYSlZVdyGUX+ZiA8h2J8hla4da4cM+4y3ri/es4iNmZEKIOuC5mns4BqaWaWMqhKPxieimdF/bWNj8pNZ3IYnifk0weIF6HAZ8TRmA8i/QAIVwnqOejPVnjVE/PR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562578; c=relaxed/simple;
	bh=VttgwoB85cht3PKYb8QZ8qtGm3rDTnCCBtygb68d2o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3LtNDPigsdTeDtskEf1iunH97BFiXcGsVRccdR7GXXMweSor/m1Eolu35cl0OgonIgrggd2kKEVjTDTa8DjCuQdHzws7iPTAmfUAqSCYztk6pwPTxqtT9MI661GJuJYA99ntY3puPAdY28px1dqHJ61D700K4i9BgoLuQ66D2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmXKmukP; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmXKmukP"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso10525a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 08:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777562575; cv=none;
        d=google.com; s=arc-20240605;
        b=HS6q3v5AmhtICsUbA28mSk7+Z2VvcWXyLM22ZEmPZnWpkJxLPX8sE+6SP3Qa54jigA
         SPyLpOHH0FskVHefj6m2mvSG624r9Jh/40ko6lL/6GV3tbo8ixJDTn9iFtS6rkXp5ND6
         QQ8LBq72cp5JhTUcJouM1Gygp7MF4WMyAWt3irH9+B3ieFXf0+SJK3HFdbh5q4IeQmix
         19tQtaZAOJe3dAKuktyqVuz+KjPPYvTZwrR13NVNYJXhRaB6Xd47csHAq4zWp9tqyuco
         P4Gk6diFnKozDiFgR6rLOt/lT4YJv9h6BdqR4DY7MaeKHZPgbycVfxv4OO8uOD1Jcx8B
         BLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4f2t9Iavwrso0cx79h2X7BZfZ6KB6P9YOcCIqQQB2DA=;
        fh=+hxdVEQACzvKWZuPM2Z2uqDSUm8KCZuWKNPCykB0DH8=;
        b=gkaskv4k4UDKvreFJ5idv4kjSvlXz4Q2mZsvCcJzLFM0s5Gq7pvQcM9BIRTnL+dr+4
         pvQtownwxoSgZnoVaQfRawkvuXSeqgf4slcHhQddBPWLTlu9UcvB27JPRxHTdHwQYi0I
         DYsyQ3yr2m5OF3NUzcDRSxzTAN5ypg1jnCDzB+2Jbot3VbzRV1GOs6HPB/PkbEX+tnah
         ZJU6/sPxrEMcpDjJgXN0gM9YmYgaDk78rb4K+1C/8R2GY2Ki0TGHG8Crxa2soPbKuq7S
         Nsakr0Z/1ciRM+XJr7OfjcWJhG1e+0tXUju1yhB0rGxec03sEbkpZNjBay0IXUdcopvU
         N11g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777562575; x=1778167375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f2t9Iavwrso0cx79h2X7BZfZ6KB6P9YOcCIqQQB2DA=;
        b=cmXKmukPDZsqP4ixXpetZ4lqign+9o9o0cdBRlAmOQWZZlx3bhzMzI+APPksDnmMEw
         /+HcmsTiUEUFLkYhuHNIHDs4ZfJUmbxvtWyUaYdW5PCLppfLVO+HFOVPs6ACDYeLgOl7
         DxW9UsRXfw4+GzALguJa55pQdLaEwR1rN75/hvyQzHfv/3Q/eQUtGcdB7oOEwKCR6hjX
         PoOzjfN5sbkBlJ4342XtIyPcun2G3OaV877bWPsqwkWQRN5nsNGy60NG+0Cy4c4w6aeu
         QrkUk3myPpWfOS4NOeu2ZbzlEpHRQBrRO4q0gUZNCAdWhRr15CbZ2nr550EX/6FQNFuW
         4iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562575; x=1778167375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4f2t9Iavwrso0cx79h2X7BZfZ6KB6P9YOcCIqQQB2DA=;
        b=LsCSmKW8TFADJuvxZ87a+4za5BJSbwMV3/Gs0ctFGyTxubXRbmqWAdqnPN2pADDwnm
         EYATbztBaDnob18CdM07RR4QbyL5yIIyS0cJE3AsXusfsQr5SwcG2snxoNw8f+FR6PMe
         I04kyDco1vVdHqIHdypIjVfSNDPprWBbDmKZsGsY7em2rPwhxS+oLZrxOhQvNs3XunZq
         cyBKzcfH8PQyyl5lBGvB26nR2g+JxCEVbn+Od0W/Lh+N8ydfG8fO/8aMXi48hl6YUweO
         LhdtTwlJrhG0PpkzqxBYE90sbzJNxpstePT11QSBmIvA2Qario1Hp71zq7HD3hNDaE1D
         QRbg==
X-Forwarded-Encrypted: i=1; AFNElJ83e0p+XWAOTCmanvXDAPsR4R/IHW5pe48T1cxPTLRQTcdhrkTSnbYgQ0ojbRn3M2shGoM3AgvvM3gd/2O6bYIu@vger.kernel.org
X-Gm-Message-State: AOJu0Yztfxgq/xsDPgS89pggxoeTmOZvKbgVYRJEbuCliI8hwMC9nh1q
	heVe0bmBwXQCCVeew1MDtYuMS1ez9fumemiI3vZ7uCFFHiaEel/4ZsOsgnTMo1hqfM9ceeLI5wY
	3ph/wiJxFYRfsjAMZQClf3xhpcL7cf9GRy13AujMi
X-Gm-Gg: AeBDievg20D8CvIcLkxHKJt61uzjg/R4Nyu2/HAYfEY6eV9a4BIqQIbXKP6AbFKLrbA
	3Ynzzmti1WZllGxj3CZT6QSBuVMTSO2yjHgOxttgHCqE1uWPNAsPsKnd9Va/zfFaxdDmY6G4VwY
	eZZtDP9x8VjhwnK/JGQ1fAA6d/WD1ptqQ6gGauZi4S7RNYn0QOKT7LUgNYrLXkEhXY4+cpIhe5W
	/zmeC4sBQnjCOpUzj7DumdTYIPuGP0H+9ki7rgRnoGzbpioPs6jYywf+PX35hSFh0Tdp16NoSMZ
	fvkbU/jzItWRG3FK5f+aUngOdbAFelgHG1G2EEgAWE/nIJCHPfH5p8dbtg==
X-Received: by 2002:a05:6402:3241:b0:671:fff6:f82c with SMTP id
 4fb4d7f45d1cf-67b4e8ea06cmr58179a12.2.1777562574533; Thu, 30 Apr 2026
 08:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429131522.4049054-1-dtominac@cisco.com> <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
 <afIiqR5CqYRId0N0@redhat.com> <afJz3l6435DHLorn@goliath>
In-Reply-To: <afJz3l6435DHLorn@goliath>
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Apr 2026 17:22:18 +0200
X-Gm-Features: AVHnY4IXFcsVkK3lFxWPc3mkzosN0e9A_ZuO_cu-riyBEoDL1P4-BpVJGbycfsQ
Message-ID: <CAG48ez0mwkHz=4+PoLv_VmYrQiPqkSQqCSo=3R-ztrQ2zAHUwQ@mail.gmail.com>
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across MADV_DONTNEED
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Oleg Nesterov <oleg@redhat.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	"Darko Tominac -X (dtominac - GLOBALLOGIC INC at Cisco)" <dtominac@cisco.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, 
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 11:11=E2=80=AFPM Daniel Walker (danielwa)
<danielwa@cisco.com> wrote:
> On Wed, Apr 29, 2026 at 05:24:25PM +0200, Oleg Nesterov wrote:
> > On 04/29, David Hildenbrand (Arm) wrote:
> > >
> > > On 4/29/26 15:15, Darko Tominac wrote:
> > >
> > > > uprobe infrastructure does not re-instrument pages on individual pa=
ge
> > > > faults (uprobe_mmap() is only called during VMA creation, not on
> > > > page-in), the breakpoints are silently lost once the discarded page=
s are
> > > > re-read from the backing file.  The probes stop firing with no erro=
r
> > > > indication, and the only recovery is to unregister and re-register =
the
> > > > affected uprobes.
> > >
> > > Right. Don't MADV_DONTNEED uprobes, just like you are not supposed to
> > > MADV_DONTNEED debugger breakpoints/set data etc. :)
> >
> > Agreed, thanks.
>
>
> Shouldn't there be some sort of compensation or notification for this, or=
 is each person that
> hits this suppose to just scratch their head and send a patch that's reje=
cted?

I guess we could add a pr_warn_once() that warns when
madvise(MADV_DONTNEED) is called on a read+execute file mapping,
and/or (as David said) add an explicit note in the madvise() manpage
about how that can interfere with software breakpoints and uprobes?
