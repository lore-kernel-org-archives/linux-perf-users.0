Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA204508F2
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626372; cv=pass; b=eyv86hwLoN4/Iu1dyU6TAptr3sgfaP9gJ/EOL9gOQWZEwxRWvDC7dw/sSfCxUz7l2yzdPeUwWzpXlVfST7lCdkE0+VcRtdwzI/E1+RGnUvlZ3FNtLijIIpX/hcjWGXWxx8PbKsWjhrmIdaIFa/aFHzmMbAP3FM74N3TWyg9dWsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626372; c=relaxed/simple;
	bh=8uDoBxR5qf+5tNtsgyPNdMc2uf8NWiIUFAqpGNdUaNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEsuak02AxDpX+ZGljznlpGDz443pLWxpD291873enHdFSAi3S0uU/2/Th3Oq7/6GOUCQHmYQyjlCHMpEbXOKxEYKT8mS5HGJvHgfthUZrBxMMb+L1TTKqvUsbfIB/nMl5bvwKNRIiOFer73ODuVcQIs8nt4Xf8jzm2jDhrbJpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcJZ+WN5; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcJZ+WN5"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bebac79fff8so593593466b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781626370; cv=none;
        d=google.com; s=arc-20240605;
        b=W3GYXiG6fQyrs5p/xFUwfKn3Qb00jCNTzvHxW87BnIpQX/lfW3gupNfiEkY5DyXnWl
         fJ5kzmjJjTo+cgNId0Bok+JVYpfbF0TyQgfs8mPXRIARRzTAk9HMgwUzM0rGQyqlYF+C
         qRzrQmLcTDt4BTyIKbvcPtmhWnlO8+F+nT3t/NZj5hWNv8R5uQL1nDQGyJMCi4NQBWb7
         TKRA3N1PSEVww9rm30BHIdLZARtbtJvde+TFZqLue28nuZ4Gt6vFYo0eUadqj/kl7nck
         PS9nqPQiXU+qtKawxRL3EUqykVBMNm6p8yRAOrfyr9pVwhZ2WOBd7UUlA5S5n5qzfGGJ
         lv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GKs2jxsRv9+LlDfAIsR7Q+9I5QhaQR7XKzFdmi7DHcA=;
        fh=LQLdSW01h2ROUwNK2N5+UwHQ+4lE93qNu55uGrsD190=;
        b=b/7QbznZ1X4l40vqHtFVaICFSh+OfImDWfsxNwl9I4a4SV8rK2nTG3jy6t5OmjuwEh
         YJNL6URqMVuxabkwew/SDDptDcL5Q1+G363hk6bquUI416jUU78LUBKiQpBmoXwU66W8
         3zf9ubQ1GXypd4zGHsD01RhHMuCAC2TqqZ2mUuckqdmBt4REU/JuB1vVifw42D0zYszn
         VNzaBA/iqjj7JV/eJ64O+q+IuaQiDcTxUTJFlPA6l179PhNKt+1yFAZrG7dgvO/ZmeCy
         BxBgsHsNdb2P2vPd5z367behvqEq95hkhYDVydyvQvGAKcyaCXEBmlrIKW++N6rBp5XD
         W31A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781626370; x=1782231170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKs2jxsRv9+LlDfAIsR7Q+9I5QhaQR7XKzFdmi7DHcA=;
        b=VcJZ+WN5/EAbPMQnY85H/d0pP4arZTs4ZCmMshSs8GV58FIupzAfINsnkQoF/Qiabk
         k3yEjbbIj3ur0vjtnXe1GH2vgdjv+Utp2sGEOL+cXagYvXTNXUcfP+WF7CkrOROek4yD
         bdq3KHG5fuQllLaa4qgF1arxDJdzvsSaQOBEctSulROyuFEQEnm2P/em3c7O+DK0tg8j
         TpJrVHoiUaw85TmIf31os53tkSbt+8fZi/hJIDrOBluscEhfSBbYM7LpXK0Mqoowz8yW
         Zj3ijT5BFP1WwBgWXM3Y5lyw6AUIh0GDoGjeU+6MeAI8gI1Kmv6KfYensHMrP3LNbgfe
         K2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626370; x=1782231170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKs2jxsRv9+LlDfAIsR7Q+9I5QhaQR7XKzFdmi7DHcA=;
        b=JXJgU6DvAHrJ27RrOqyanCNFTeXgTrolMkVWMKIc6vvUFEzkqfsbSxskt2cXPE7b+2
         IAaeI3Y+fOAyeWBsfxU3aNWtFbg72DnB8XBP2ejgyzKN5/4O2RAjK+5TJeE7YeGP1FJN
         mb/OeZ9C278vWg7yn4MVWkAaDGfWcm3I5bRZYy5xPrrqSp/HyxfbvOy69vtpukKpATcN
         P49SzBgT7o9zCe/EzSFp3xUuZOJY3MhOOKEPkbNYPhiZ6gpg1NMqBQuWJbAy5adXwdmX
         Sebs5U3h3cqtKWRL6qStW5AxCB7ni67VKCRHTBI0UHsl9Th4vWPYyITuke+z5fYj00E5
         DcaA==
X-Gm-Message-State: AOJu0Yx5I1+PmdhGcqF95aR30HGFouclcv3YG58y8PQM1vsQx3KyCvA+
	02p0Rd1gFutb1z5ytq7Wag/qRFeQ5owi0t8qjMX/6oELGYoeX3Q4NtlfT2z1LaADkD4qhyZMoAJ
	+pqdBsi7bvLqO0Zs8moJtkh3KsfUPBCfDDhdT
X-Gm-Gg: Acq92OHOijqK9EQsCPqs5fTsouoRLPDz1MtfxySttMgSeQ9Wfx6yNt61tIsIl2/WjlY
	OZsjT7eI+O/oaUnseNvqCzizpHZw9vyS5KgafiQDBLntGTixFzL3217nXRalXKoru+2qsQ2/T6r
	6Lq0HblrIrbhoA8SLJ1GItK7d40XcRMFlKwbgWpBV1ScWQYuRYhsSbFW9rwoFO+bA9au/TVL/sC
	kWstbQeCAWgwvAeoSr30GixuSIlG21edxXFWbRKjmhAyG1rJt1QmVr0kT0IRqvFA+cZgP0A5naa
	k/XUgeLN5Hu7GrXUQdn/qB4=
X-Received: by 2002:a17:907:b03:b0:bee:875d:af12 with SMTP id
 a640c23a62f3a-c05a09bc11dmr25587266b.0.1781626369768; Tue, 16 Jun 2026
 09:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-5-puranjay@kernel.org> <20260616160409.F321B1F000E9@smtp.kernel.org>
In-Reply-To: <20260616160409.F321B1F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 16 Jun 2026 17:12:35 +0100
X-Gm-Features: AVVi8CdKaboq2XwNC4hu_WdVZt4UvvXDyGLLztXHu06VCQ07VL0tsmlmXy4Rvtk
Message-ID: <CANk7y0jV89r++T_nN21FTCiuA6Twx+LB3jv+BzEN3+rzyjypJw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] selftests/bpf: Adjust wasted entries threshold for
 ARM64 BRBE
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 5:04=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] The test skip threshold for `total_entries` was not adjusted f=
or the increased ARM64 overhead, leading to guaranteed test failures on har=
dware with 16 branch entries.
> - [Medium] The ARM64 threshold for `wasted_entries` provides zero margin =
for environmental variations, making the test extremely brittle.
> --
>
> commit 08ff160f53fde2f401cb063e6cbc84b6bc9a9970
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> selftests/bpf: Adjust wasted entries threshold for ARM64 BRBE
>
> The commit adjusts the wasted entries threshold in the get_branch_snapsho=
t test
> for ARM64. It raises the threshold to accommodate the ~13 wasted entries
> generated by the ARM64 BPF trampoline compared to ~7 on x86.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot=
.c b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> > index 0394a1156d99d..8d1a3480767fe 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> > @@ -116,13 +116,18 @@ void serial_test_get_branch_snapshot(void)
> >
> >       ASSERT_GT(skel->bss->test1_hits, 6, "find_looptest_in_lbr");
>
> [Severity: Medium]
> Since this patch increases the expected wasted entries to ~13 on ARM64, d=
oes the
> skip threshold also need to be updated?
>
> Right above this line, the test skips if total_entries is too small:
>
>     if (skel->bss->total_entries < 16) {
>         /* too few entries for the hit/waste test */
>         test__skip();
>         goto cleanup;
>     }
>
> On an ARM64 system with a 16-entry BRBE buffer, the skip condition evalua=
tes
> to false, but with 13 wasted entries, only 3 remain for hits. This would =
cause
> the ASSERT_GT check to deterministically fail rather than gracefully skip=
ping.
>
> Could the threshold be adjusted to account for the additional ARM64 overh=
ead
> (e.g., needing at least 13 + 7 =3D 20 entries)?
>
> > -     /* Given we stop LBR in software, we will waste a few entries.
> > +     /* Given we stop LBR/BRBE in software, we will waste a few entrie=
s.
> >        * But we should try to waste as few as possible entries. We are =
at
> > -      * about 7 on x86_64 systems.
> > -      * Add a check for < 10 so that we get heads-up when something
> > -      * changes and wastes too many entries.
> > +      * about 7 on x86_64 and about 13 on arm64 systems (the arm64 BPF
> > +      * trampoline generates more branches than x86_64).
> > +      * Add a check so that we get heads-up when something changes and
> > +      * wastes too many entries.
> >        */
> > +#if defined(__aarch64__)
> > +     ASSERT_LT(skel->bss->wasted_entries, 14, "check_wasted_entries");
>
> [Severity: Medium]
> Does this threshold provide enough margin for variations in kernel config=
uration?
>
> The commit message notes there are about 13 wasted entries. Using < 14 me=
ans
> the test will fail if exactly 14 entries are wasted, leaving no margin fo=
r
> error.
>
> Minor variations like KASAN, PREEMPT_RCU, or different compiler code
> generation could add a single branch to __bpf_prog_enter_recur and cause =
this
> test to become flaky.
>
> For comparison, the x86 threshold is < 10 for an expected 7 entries, givi=
ng
> a 2-3 branch margin. Could the ARM64 threshold be relaxed slightly to pre=
vent
> spurious failures?
>
> > +#else
> >       ASSERT_LT(skel->bss->wasted_entries, 10, "check_wasted_entries");
> > +#endif
> >
> >  cleanup:
> >       get_branch_snapshot__destroy(skel);


This selftest is supposed to work with the standard BPF CI config and
setup which it does currently, it doesn't need to support all
different configurations and setups.
