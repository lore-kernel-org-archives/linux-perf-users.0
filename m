Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CBF3D0930
	for <linux-perf-users@vger.kernel.org>; Tue,  5 May 2026 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013780; cv=pass; b=pUJWqvC42TkiVjZ0ZmVsEuXFqDi6AMOzt/H4eJFZdClT8eJ7V3gEqXnA6gpRZ/m/WaTPm8pfSQKfDRdxvvfYIQo9BS/qOfqLVnoJMWHbVA7rfseuCr2Q23Qe7D+hSSno4LkcPEWKA3G6TNSObDhtVK26LLjW5Rlr3eR8SmpKx90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013780; c=relaxed/simple;
	bh=5rb4MbkbYDYdF/uqyZmAKMRxIMfGMsAq8HZiVeErGm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvTsJG/135UiFyVBhS1ZXZjIt3ITq90PTVHe04xU2sy/eW/g6XIRh+XbVypoty8cIpMQBIDJpMPrixdjyfwGlABa2FZRa1/uVIzpFhxnygWT+6rr0IvSg5kCp473Ys4AiHvC0F22+InbNa9MmzR3Z6zy/sSRrvFZPKXkAXCNcns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGcQpWvo; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGcQpWvo"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1270f10a774so1207c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 13:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778013779; cv=none;
        d=google.com; s=arc-20240605;
        b=PAm9I6icNNnihh08X5klUO7CK0GYLKt4AaYIY6atkHffJsUBtZLBpvshaJSWw/Ed9/
         PGnD53mXOcQP50mZyoqNuqJHCDbCCLiBW16AIjgM1Yt2IrTKFBk8EmM+iW2wdqcWS7Vi
         RcrNYfy3+hwBK1PqNkvG7llwAAxbhnbM34tPJhMhc4rdpIaCSIPJ/Su7L6BtUoOlUvJT
         Y9uesZzs4xxnEddifx0tOtyE4kU7Igxz71zGZos4SjWbANJo/qjN8L4oKtymuVxN/Mit
         58Yd3EmiPVhT4vS5yNHcZaFLVTMWwUx5tDxRkwCGOAcyChV+Nth5B6CFzV81+el5Wsh9
         47kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aWEGxma8SuORLQaPs+73ZSwOWcKgsiDRBuZcLtSIbsA=;
        fh=r+ESyidb1gfhdZPPm1uIs8K2zSxvGjwiUR0Gjw/8z7E=;
        b=Ubw3fwi51V4SaZLgxwLX5W7HdCGUgdv0UmjJHR5QYRpYtkBbNtSzzI0F50VKpYiy0U
         7tAyaJhZaw0lhss3iGmoSFc4wtD6CzbCODkxZgbZ2ZhRPo0ghErOGy+Fuj8xXGGiMH+a
         7/R3fONI/WCT5iPQZqTpiUINPVpy48kLgq1tbGlDHUhbMPa65hGshUUoUe2/wflW1uTM
         eWw+nskSji1Wvja4d656HEbqmS2k8gzOGaP5/ah+5lYdxXQmSSCA8iZh3T1hLau/dn8D
         lS/SdzZkPrtDDpcBvjXE+F1ExG4nFNLOTkhNsfTELKAMcWX0H6vCO2FPDzntc0SwBfDg
         6vDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778013779; x=1778618579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWEGxma8SuORLQaPs+73ZSwOWcKgsiDRBuZcLtSIbsA=;
        b=QGcQpWvo2FySvQGxXSFvbeztvaI8ZRi1r+u3mhHHyBElq2X2v/Zt+S2VSuG9mO3CBv
         hLT2v5AUI1lXRYAGLBM3PwCCq6Az+QW99bVxH+KbOuAE+NVZkNiMgH57MbodAMTMM5Fi
         KbzxQH54iw5GzD2gLR9Kf3I9ZlNMJpWKwaW9/jnvBTfz6h5O9q8PorNc/lBrPnmBLD0y
         wO54DOO09oac0uEKy0ZxDXjBmXL8XxQvu1xgYGJpLvQc1P/yEnCLud0Z4E7CxCnyHW3G
         u3Vd0M965O3eByRwgbP348h/ROFlwVuhw1ubzno8rjhT5T/O+rNIUvd1y77MQpfHQQVW
         lbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778013779; x=1778618579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWEGxma8SuORLQaPs+73ZSwOWcKgsiDRBuZcLtSIbsA=;
        b=jonNc/fwQsHIGwAmC5p+h9OFFD6Amcp5Hbg+4183a3eysSoNA8I7I+PAtWlxx+8sDs
         ZJpN6IM+DzfaVWO1GsqZrR1cOSD9eBlhjNE1kBtJy9RKWvE+6ZMlk+CTiKBOkmuU11au
         ay/pqFivdgGJ0Q4+mkaWlDlDxhgHXIt2jRDFwXdePSP7Av3v7O8A8uYIWagsime0p6QQ
         qW43muZrSictL6LFW4iMCr0o7dMIJzmIHIUd/wzEkxXk0x0BJ0gOZyKg+cZqP/QH/9cv
         M+nUVe0O4ftdI1syyjo8ndoebJQQFwWnttwJjVw7vcIs0VcYnSR5me25wCC0C8G+mHVg
         PR9g==
X-Forwarded-Encrypted: i=1; AFNElJ+oF7YBO01w2ttsKmbXE22WhzzQg+h4BFYfDtB8pu5j5goNj3Clh/vT7r9BeC4ZlAjDHxu0xxsEziujUIquv7zh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38ylsM68xDzZtGXYvz+wMOHZeKofYkN0r8nJmDFDT/A63Dexy
	vamIevG7I6WpTL8a0XwiysSJWx/MbwBhLOeeVPdzVqYjUsXsdyWh4jzvS8/cp+en5DbT4LfexPl
	Zw2gksq6YoTqPBzIKZ+HUTgcUYkzQQGD9U9/MV1bX
X-Gm-Gg: AeBDiesSTIV8UglmAemqt1HhZ+9/i9t620J5FcvdVNCkyW/WLnFrBT3Tc9Bka4WK+qL
	bqMxIrpzBQBb+fzmqBlNqKtj3tTeGap8zioIXG9G6MmWX+s0Od0/5Z2cY5jbT59fXGYCLT7uQgW
	+/nK7C0dAF4BEbyK7ke7blBnmlUwBQsa4dLubW+2eCrNynlbobirHjuk+BDt9Q2+Wi4LIKcs+5B
	s4A9t4tUgalHl74r0yG5g1b+ng5LQ0X2qRNLCuGlve/dcaxGfwr1GGi53XSd22DASqT/V4NgjBQ
	qdZHeb8Eg2KOfKmTEaQUDt8t3QLOMg==
X-Received: by 2002:a05:7022:6183:b0:11a:2c18:9e70 with SMTP id
 a92af1059eb24-13203eb0c48mr13410c88.11.1778013777871; Tue, 05 May 2026
 13:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413024805.1316480-2-irogers@google.com> <177751952104.2274119.14762312333480941665.git-patchwork-notify@kernel.org>
 <CAP-5=fVLcfx6_T-o7mJ650K3SX+N+T3YYOY+ibZKJGT8V56NVg@mail.gmail.com>
In-Reply-To: <CAP-5=fVLcfx6_T-o7mJ650K3SX+N+T3YYOY+ibZKJGT8V56NVg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 May 2026 13:42:45 -0700
X-Gm-Features: AVHnY4LZYgRX5tX2o2GOGvjJhkF8Llo6dB7Z-hyRMxpBodU2GezE0_CMCc4wYpU
Message-ID: <CAP-5=fUuxMUeZTNShmrzi064LjNgkLbJiGtEPS6mWqZ9ijaVJw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] perf unwind: Refactor get_entries to allow dynamic
 libdw/libunwind selection
To: namhyung@kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: linux-riscv@lists.infradead.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 6:40=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Apr 29, 2026 at 8:26=E2=80=AFPM <patchwork-bot+linux-riscv@kernel=
.org> wrote:
> >
> > Hello:
> >
> > This series was applied to riscv/linux.git (fixes)
> > by Namhyung Kim <namhyung@kernel.org>:
>
> Hi,
>
> Will these patches merge into the v7.1-rc series and then back into
> perf-tools-next? I don't see them in perf-tools-next:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/libunwind?h=3Dperf-tools-next
>
> Normally changes like this go from perf-tools-next to perf-tools and
> then into Linus' tree.

So I don't see these changes in the RISC-V fixes tree:
https://web.git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/tree/to=
ols/perf/util?h=3Dfixes

Are we still working to bring them into perf-tools-next?

Thanks,
Ian


> Thanks,
> Ian
>
>
> > On Sun, 12 Apr 2026 19:47:58 -0700 you wrote:
> > > Currently, both libdw and libunwind define 'unwind__get_entries'. Thi=
s
> > > causes a duplicate symbol build failure when both are compiled into
> > > perf.
> > >
> > > This commit refactors the DWARF unwind post-processing to be
> > > configurable at runtime via the .perfconfig file option
> > > 'unwind.style', or using the argument '--unwind-style' in the command=
s
> > > 'perf report', 'perf script' and 'perf inject', in a similar manner t=
o
> > > the addr2line or the disassembler style.
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [v4,1/8] perf unwind: Refactor get_entries to allow dynamic libdw/l=
ibunwind selection
> >     (no matching commit)
> >   - [v4,2/8] perf build loongarch: Remove reference to missing file
> >     https://git.kernel.org/riscv/c/841dbf4871c5
> >   - [v4,3/8] tools build: Deduplicate test-libunwind for different arch=
itectures
> >     (no matching commit)
> >   - [v4,4/8] perf build: Be more programmatic when setting up libunwind=
 variables
> >     (no matching commit)
> >   - [v4,5/8] perf unwind-libunwind: Make libunwind register reading cro=
ss platform
> >     (no matching commit)
> >   - [v4,6/8] perf unwind-libunwind: Move flush/finish access out of loc=
al
> >     (no matching commit)
> >   - [v4,7/8] perf unwind-libunwind: Remove libunwind-local
> >     (no matching commit)
> >   - [v4,8/8] perf unwind-libunwind: Add RISC-V libunwind support
> >     (no matching commit)
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >
