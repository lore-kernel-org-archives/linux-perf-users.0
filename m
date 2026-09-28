Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448D4E36F2
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608327; cv=pass; b=TAdXdnKDtq/TqKuvt6yE7Vq78/uSmg+cRDLjH749ClAVZRDB8GL/r/ZHWSt47n5a27zUUm8bLy8CBAMC6UO+gNzmIOM230Uu+DoF4GSnxV2hSQhP/irxi/01i5Zo2agxX2iMPBp8C3s/MzmkbSlHKCErRverAdpa9PUnbg6WioQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608327; c=relaxed/simple;
	bh=cxpTfer2sMLmLTmjKf53yCvqaUBCk1EIHEd1pxLD0u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1lcfQLSErV7XrMrnNGDJt/HZvxWGPl7CSyg0gJAyLPCt1df4EONUTJYIsp6WLxmsLgFvPpU7zHyCHAW5m09u0BsvTFwVRmP/RsY2t2yAJAWjOkYqTUK9d+QqKnKiFbDWAc5lDhADUvnQ+ocQDKP8tkp/8XBk4pV825SGN2VQ7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbJfg3Bn; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbJfg3Bn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d8facae850so93375ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608325; cv=none;
        d=google.com; s=arc-20260327;
        b=rMYnMyfjWUI6RwJl7F0frq6q8VGeS1ggTxM0FqtrY1n6QhojhcfYoiHaIYNuyrrmTh
         NuK6OngQ5By4KbkQYo3Pp3j8Wb3OK00C78qxqfo/TgCeURQIATGSr1i6jWFpvEoWbOhd
         YMBheX+/lkSxBYdvhKUBaB6up3JyS8C2IbFhCHO4vIb/oGEkNGuCu3I385+l0ZnDwE4U
         ctyFD0yWI6NNAXeAy7jOpCmqgbh203mzrQpgF42t4YCyQOL50N5gyASTg+O1L6/mTPDe
         pM3gcl6zDMMx5xWKaolSmluZdmHCSWSRYT68F1aPaqbjlAr72NFJLQ+AJcwrdX4wAZH6
         PkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o2oSZa5m02C7TagvPW0aUMVOvbBcJY0xL3Ym+Z1In0U=;
        fh=OJOOoayaRa4p65GkWGZ3+QzhL7HlAus26KWM7kY44EE=;
        b=b8QcYZanghqzryyLNafjLwj1J99tKZvFSiURjGQKnc0axraAX6KeqqDBoshnZlZj/c
         bjDwrITs4Aj7I1DIld3iYr7R0plZ7EH81QYT/j9bNA8fCOEhkAZmZOdsZrk+PRmIW09w
         K07+jWzPtvwoQwrhHczlEGdSXbAocDy/XxoT23W+Sv5JvWLSyh/5YzoIbF5291XVpgXF
         IEgehuQrBiFVLULNcMhqvRW8h53TYExsiB8m8bQh4PkXoZOa/awB5Eo9LeGwJjEvsUb6
         tTMgv3hbIkaWEcabfUB3frgIov+EYFvJ1WJ8KdoYDwuabCF0mNeWtFEc2hgdTEFFbQD8
         hASQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790608325; x=1791213125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o2oSZa5m02C7TagvPW0aUMVOvbBcJY0xL3Ym+Z1In0U=;
        b=JbJfg3BnWID/7BAbuNO+/Qmk5hClQTbZai22t17Y8pKIbcL7mch0D1+jGrelBXAGF6
         QhcDeU/pD5ZFyN9OmiugBOLnk2Qg0hhKGfBPkZuN5cKfFhUric9EG9Y+gSxrVy9DVNgJ
         7G2GhRpoKL/fc2mU+364KH9PErHmd9JYvIai+Rijw+gVRq4xFJwxjl4UncbbfTVFk9qV
         xUqpjOyG1tGqC1o9Y0YEY4zHbPgbeTia2b0nEpJJqhdt/ojATFCBPJTLz8V02sPdlEZp
         YqJYZJ+8v9r2iK32aBgdGk+Mq60T+lpsxgKaIEx9eB+pg8y0K7OK251MCWQ5OZtmBErt
         GT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608325; x=1791213125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2oSZa5m02C7TagvPW0aUMVOvbBcJY0xL3Ym+Z1In0U=;
        b=OuMADlq3rk5axYfDGJaT/kguEy38QL1qRvlJt04JoZ6y4KcPQ7i0ONOcg+F8GHPiMv
         qz+BhYYbbJzIT8Y+b3rjMsGMY7p4jtVHTNUN4pR3zbQ225bRAcBpVR1e0d7ORRk4xQAI
         I8wrR5SWOPAiryhx2F4JjW0Uz1u4876g897FIK2qmodGtDeOhM6KSrodh+olLFC5sf10
         Yckerg2rUeuO5Zwl/xojnmL7HQNb7CPHbrPWXsK97Vc8Y9d3J7GLdjsRUWEKbqUtzcfG
         fMzeAPZZWbapI40GM5YQopE6lwD6YJA8vCebn1wWxVuLBmYYiLGiTxcCc9XQ4ZZDIP1Z
         L+aw==
X-Forwarded-Encrypted: i=1; AKwUvByDhv2SlgZCqHPFD6JgkKJH+Sqy/bq76b7NOatde9gPcv0NPS9/XNKQqIgHjH9mwRXjSNuTUGDKKMne+M+wQACW@vger.kernel.org
X-Gm-Message-State: AFq9FYI0fTdyCIlDdLHuQEzM91xrJTe+NjLOY7QR7+2EaMqoPgzgA2FD
	mldUbP/a8RshWcj8vu8UBjL2su67fb0Xad4m9gX6rQXolQMdehkN0fEy+k3+vG9aq7CIpT3uNvE
	nzXF+PEcw2AnBUxUPO3OMq7KFdBIGMW9waltIbQ89
X-Gm-Gg: AYBFou2QjU6Gqfl3rlz9R3EDf1YbppFyy30vOKum9PuYOS21x5IoYu1hzbib2TejGUd
	AecHrG6bF8DMtq+wQR/7rFBM2FDSQCBntqLIwXEY4PYf1tlSo+WJVJ6exLxO5y9B0CzGLWozRab
	8+0v8qB+NGtq4x9dTiDL33mieg1dcV5VxQPBBnp87GGWxqG2LXhlTXYDV1Yf3nsNMfHvyZbUMUx
	xJrFrJPmRr6bQF6HsaiXP7rXO2PvyL/X5pYrrBdv+HvICPwjzjmTRuJ1y34gceTCZ4x5Mr0Lit0
	TF1+Ps5WZ6YAftqt72czsJNOPw4dHMJXptru4E9xRnFP+OBqS1cqanoKU7jgu+t38jC+A/zkqGy
	h4TSFJWMO
X-Received: by 2002:a17:903:1b4d:b0:2df:96ca:d7c7 with SMTP id
 d9443c01a7336-2dfa622759cmr7214885ad.10.1790608324149; Mon, 28 Sep 2026
 08:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-james-perf-mypy-cs-disasm-v1-1-1bda909475ce@linaro.org>
 <20260928134642.GE14479@e132581.arm.com> <79e7cb39-b4af-4ac9-b72b-b01872603cff@linaro.org>
In-Reply-To: <79e7cb39-b4af-4ac9-b72b-b01872603cff@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 08:11:50 -0700
X-Gm-Features: AclHuK9VzJqnLWWLa_yJchAEgAsHiJ9270-56uCWBGNQX48AES5uJ19677-R9tQ
Message-ID: <CAP-5=fXeSXGmC=E+Wznn2L9yReMCx=6Gwe=v-6hHbu=q4ZAyDg@mail.gmail.com>
Subject: Re: [PATCH] perf python: Fix arm-cs-trace-disasm type error
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:52=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 28/09/2026 14:46, Leo Yan wrote:
> > On Mon, Sep 28, 2026 at 01:58:09PM +0100, James Clark wrote:
> >> The perf sample dso_bid getter returns a string or None, matching its
> >> Optional[str] annotation. Attempting to decode it as bytes causes mypy
> >> to report union-attr errors, even though this was behind a conditional
> >> that checked for bytes type.
> >>
> >> Use the string directly, retaining the fallback for an unknown build I=
D.
> >>
> >> This fixes the following build error:
> >>
> >>    python/arm-cs-trace-disasm.py:266: error: Item "None" of "str | Non=
e" has no attribute "decode"  [union-attr]
> >>
> >> Fixes: 279b402e5143 ("perf python: Port arm-cs-trace-disasm to perf mo=
dule")
> >> Assisted-by: Codex:GPT-6-Astra
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >
> > Thanks for the fix:
> >
> > Reviewed-by: Leo Yan <leo.yan@arm.com>
> >
> > Just curious, have you run this script and compare the result with old
> > one? Seems to me, the build pass is insufficient, we should run a small
> > test to ensure the result to keep same.
> >
> > Thanks,
> > Leo
>
> Yep the test still passes. I assume the "if isinstance(sample.dso_bid,
> bytes)" part was just dead code.

Sorry for the breakage!

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
