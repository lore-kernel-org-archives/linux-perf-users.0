Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B194DEC1A
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014360; cv=pass; b=bWgvbtaTnQhJd/SwZcqVCPXNrCV3FLokuLD0QLwbd+vUErmBLRptTmCjhrOT2F3XrbeUmOFH5vQ750d9oyRoFa5HV6bV65IDp4boddq4eln+G67EkXZdIGnLGd3Q3HvJmBVgH6OmdrWH9vgalDqz9kwrDIF64BXS/HXROtDGupU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014360; c=relaxed/simple;
	bh=pxCditSPn667R8GM21+T7lWhaHVejNe/8zp9gD2W2Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrTvWzKUrP84RVPW35sNtWegiTSERM/tUIsK/qsMeMIKxMOInyrnpTDNESvY8b3cYowOwkfm2VYV4BPlBoIhQPREfNqDK7A+GBXaThsSokaZSeNbtqoYDUPKYC7mMMFITpsYT6qBYOZ+SlA4PRPxiIC1z/6XgQ7ImxDxzb3RZDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQjsiIcQ; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQjsiIcQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d3b445a84fso19975ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790014358; cv=none;
        d=google.com; s=arc-20260327;
        b=hMju//xYPuUtp8jBRtRZH7zU7HDG+bfnsnT+xwUupl5EB/p6wMTsnOczzg4apOe6vs
         0Pgq46TcGJ9i83GCVKY9ZRMFAFHbU6WNfj3nvT5PjJtW1LGHKxoFZSNCGL0Mj2J/1XEj
         TKv4N/uj7BUmMu3GWk1BoIDIQJM3wfVL8f/n3HLB//C3dbbhHwpkqSUA0MOU+xuRnco2
         Wel9/6Jb8d0aH2AR6P+2KBdBUaWP37QXNUk2Z7FKH226csbJcI5NbTGKdRZOTAUKw3Qc
         76FWhf8YW/Gz1Qwi9ZXTJdvAEpZuXvMNzGDsFEL1QLQHGBsB6dqFXMbd9ySNJlZtYurx
         LnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QHAP+ThF7TxWgEqj8k74itg4E2H+sNPwvnziw5xjhM4=;
        fh=g8YDxQwYTYAfiJG2IptUQfeN1ox7i2Ws92eJGxIDHYQ=;
        b=OJYsrZvL17U6+6mPoW/5nsFhE9xyMn3VmE/UE64hT1ObiZzAFqIsIzgyLxoxY33yMj
         O1t6Fd2awkwzFuZ1SpNxEvzSl8Ft5kSzDYdQsMD3LOldWql6auIvkc1UvHJ9CaOFiBL4
         N1wprTu8H7mPaUtimMfactI1zjcBmAn0nYQ06uz61+/BSLJYjwBYKCdXfy5CQcowVZ6C
         Z5BPLpeswamUEp3r47udwg8ec946USNJFrOLaYOTsN3+0ecQk3MzGlyDiEfvr20eJ1GK
         dpmpn71cpyZ6bs8X0o0UmLQuA8ZcOqBLjK0mlrL5/0IB6R6kOQGC5XrFT2Z7UeMhczpc
         z2FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790014358; x=1790619158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QHAP+ThF7TxWgEqj8k74itg4E2H+sNPwvnziw5xjhM4=;
        b=CQjsiIcQqKorgn4BH/vP6SXfG5ScUCq9iNmLYYoPhL8z0vWYArmIbJ96opXVlSbKeW
         aZl6k/GsQp8jcZ+zkfPQyc6U2bRgvUQqNHYFLy51V6DdypkXgKja6abZdOJTY2J8NYAv
         hhFXOgFa81VdgE8oYQRSraXmYKOkwizoQQvfSbQGREkPLVOlqziLI0Ni5EjD066kWKZ1
         adDh4DwhP1Np/WCIp1lI5AlOrj/FlIouB6vnbmaGc3ntgzm6oBcGfjfNEN2yPgjfzfjl
         sFqIni+8TYecqTyT5eq8sX8Mc7MxkCefYKZBH6xCichpYb+ZXb0SCkKjmztDzcvP8CZW
         VYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014358; x=1790619158;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHAP+ThF7TxWgEqj8k74itg4E2H+sNPwvnziw5xjhM4=;
        b=eahTufr86xX8RAZB0bqR3/IqHkjRmGVDHZn88QC9bm7TDQkuRA9PlGGuKuaxHxV+wW
         mJjuyi3NgoC7CqRJQb10HFg8bwkcfE8X9dn2QLo5Tww4kwbJ/puE5eE9Hx9Rsp1BO4tf
         pM0AJ57kQ2HLRzj+ZRpJm5wZwP6Jk7U/LlHyuXzvlsQl8nLiw+ccZodrrHubeEweOoj6
         nXzI2Gl9yfSmBfTw7wz40vctvmss+1LV4/1qVjUAPV0z9FVyNcjvWOCSwfQs1TTq6Slg
         aVOBMPeMMmTLknZwULzk2DtY+xAuDOr8jgnxwnodTCQrGhz4pDofqutvqMbBGYTS1J7T
         gp5w==
X-Gm-Message-State: AFuF++l4ZRdfPdXhJqLn/lMiMgh+E0NP3i3nHg/X/cmUFc7Bp+cFZzIc
	iLNWQQ8snXIzVZvp4u5i/Fi3AmKvMOpyns9DfJx5vnFkMy/fxTHlcmFuSvdAE0sv7Zhg6UukxYA
	VGTs9IJbAuoqxbXh/l//V4D2jaLoFRN4hXdOSam51xLickM2dGRS/+8on
X-Gm-Gg: AYBFou3GXBuHtQoa4VT/gp/hRKTEgzO9lcUyjokuD8mgh/ENe49P2yI1Exm6V1mKvYF
	4njW3Kk3YnRIO0VfWea42RyY2vEzu6XCe5xSRFy7rBJ5ylw4eK0eK504lMrTlqSEdFjydQVqqh/
	pgOwc8Klm0MR0XFBLEW3EyfO3pwROUGVGc5NT/brU13PSMbOsL+YsxV8taT3N7rouqG701GDoB/
	68ULndt77RgucaHALwa0W/Sn5txY+0LfUDHuJhmTLg+8nkJqXfaoEVAUZw5ZnWHlv19TXjdP546
	r7LOI7IYxylErbke7l880D/0DsjP8p9k82HDL4iv+TeO6m/dRWZ2TKs5RmWWZPKTftFQVFIKry1
	F5kM6ELBl
X-Received: by 2002:a17:902:ce12:b0:2cf:4353:f117 with SMTP id
 d9443c01a7336-2df5aae1b6dmr518255ad.0.1790014357595; Mon, 21 Sep 2026
 11:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag8X7gcDw6jpJsLq@decadent.org.uk> <20260921175719.846883-1-irogers@google.com>
 <20260921175719.846883-2-irogers@google.com> <20260921180544.064DB1F00893@smtp.kernel.org>
In-Reply-To: <20260921180544.064DB1F00893@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Sep 2026 11:12:25 -0700
X-Gm-Features: AcwNN1WtQRPw4NjyM-aaF9lzmK2cNFGQrwApgnAZh98Wf0nWalcexW5EAz7_hpk
Message-ID: <CAP-5=fVQui77+75dHLMgddUM2P3GhZqV2wbdVUkcG_6jwWqECQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf tools: Put Python bytecode in output directory
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:05=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] perf: root filesystem pollution or build failure due to stray =
slash in PYTHONPYCACHEPREFIX
> --
>
> commit 3de8bc01d44a9b11e10c327ec26bbff8605926df
> Author: Ben Hutchings <benh@debian.org>
>
> perf tools: Put Python bytecode in output directory
>
> This commit sets the PYTHONPYCACHEPREFIX environment variable to relocate
> the Python bytecode cache directory to the output directory during out-of=
-tree
> builds. It also updates the python-clean rule to remove the new cache dir=
ectory
> and perf.pyi.
>
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index a0b23d20d005c..50bde95c78a54 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -397,7 +397,8 @@ PYTHON_EXTBUILD_LIB :=3D $(PYTHON_EXTBUILD)lib/
> >  PYTHON_EXTBUILD_TMP :=3D $(PYTHON_EXTBUILD)tmp/
> >  export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
> >
> > -python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUI=
LD) $(OUTPUT)python/perf*.so
> > +# Put Python bytecode in output directory
> > +export PYTHONPYCACHEPREFIX :=3D $(OUTPUT)/__pycache__
>
> [Severity: Medium]
> For in-tree builds where $(OUTPUT) is empty, does the unconditional inclu=
sion
> of the slash cause this to evaluate to the absolute path /__pycache__?
>
> When Python 3.8+ runs during the build, it appears it would attempt to wr=
ite
> bytecode files to the root of the filesystem. Could this cause a regressi=
on
> by breaking the build with permission errors for unprivileged users, or
> silently pollute the root filesystem if executed as root?

This is already the behavior. The difference now is that instead of
multiple __pycache__ directories for the directory the python script
is within, there is a single top-level __pycache__ directory that is
handled by the clean step.

> [ ... ]
>
> > @@ -919,7 +920,12 @@ $(INSTALL_DOC_TARGETS):
> >  ### Cleaning rules
> >
> >  python-clean:
> > -     $(python-clean)
> > +     $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)=
__pycache__ \
>
> [Severity: Medium]
> Since $(OUTPUT)__pycache__ would evaluate to __pycache__ in the current
> directory during in-tree builds, would this fail to clean the incorrectly
> placed bytecode directory at the root of the filesystem?

Same issue; yes, the build would fail but the build would already be
failing if this were a problem.

Thanks,
Ian

> > +             $(OUTPUT)python/perf*.so
> > +     @if [ "$(abspath python/perf.pyi)" !=3D "$(abspath $(OUTPUT)pytho=
n/perf.pyi)" ]; \
> > +     then \
> > +             $(RM) $(OUTPUT)python/perf.pyi; \
> > +     fi
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921175719.84=
6883-1-irogers@google.com?part=3D2
