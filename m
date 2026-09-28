Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6C4E7808
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611967; cv=pass; b=QJMrGfNwt3cL8DOvRf2vLZCmHM7IKsHtYSbujZw0bPDGoTudooOWwA/tplkBzRALpuSX5ikRUfGk0f/xbJPMYaSsBsJDctkIEBsfwBU+/YlvCNdxDm4T6XR1+OVqDHuYAcabVUj1excw6nNtcaSdgTjnVOBWbcFiOCyavm3cdyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611967; c=relaxed/simple;
	bh=9/5n3y53FjTjhvHDgz6T1mo7PBjDtEFNf/o3yogF9pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLbiJbb6bO1hHxeZ1W4tl11hIwML/x8gk3/nx+cwdqcNwXJqzn7JNIF8uDxo61F8lh0d4/V4xWb9EqCC1DDAuOK6DT3YMMea0x4o/nOJFqVMSMVbAWGMcS4gWkp9/86f9sXKJBUW0TlgHZ8ySQ4rcyfVJFT4o5a31xJEjQis0Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okkzBXfy; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okkzBXfy"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5333401e359so328431cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 09:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790611965; cv=none;
        d=google.com; s=arc-20260327;
        b=KyQaaGv5mAYZsb2DHEILUIdRWVR7hWSNJ/Vi08899yK49eutJjsWo7xYRbDcgVY/Up
         cfinw6mQBp1fFXt3tYgkAzZiKGSkiap0x5SIJXYTg6myPeeN4CTEmEF6BDFtFECCq/BQ
         Fr73COJvEr1uc05jWpQigBhB2Y6HVlrMnUB7EOppnNM6bzsfEMTDkJWU2AYQFp1kXpRm
         Y7Zc2VDeckQOKcYFszW9L2W1utiQIkg0i87A/ZSKdvXow2wYfYXBTheAvFVLhMdWZqfv
         Nc4igdOSzLIe+rREAUMH1Bd5iaCYX37s3uHooPy1t41TeVgL95uGqSDdDozcROKLMyhC
         xzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jtwl90z0UN3pnLPH3ZZJ2kXHY9taouCeQz8eAktVkic=;
        fh=iBE9EmbOPjoMN7APsCDZGz44W32Y+787wJLLxdHa9q4=;
        b=H3EGPavR57AvppgPcswxFP9YB/23fHlQN5iNld8vzdykbkq508Psn5rj26wTgMlmwf
         QzpBtp9I2tTyae5hZ6OQwJO4rtHDz/Z61xltHUPwOMaA2sNsLET9PXKzkais5mwfPt2H
         I0O3xiwXocso6XbxS9qmzGHv3FKRc/rvDYHNcSpQ/GBRgQay5sS+4FjfoMbNBwDtEbN6
         h6PCL/+9p+cHqFKxW9WTXSYaSFOZ/1wwSxsVFTIkGkRGORrfO+cviGUjHAT3PmR89kQ5
         wjVXrnsI9WlfGxZxIA1HDRbk7hyzPVcfA3bGiyxa4A+9yotOkjDwAvnit/eYYw2u+Bff
         6OUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790611965; x=1791216765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jtwl90z0UN3pnLPH3ZZJ2kXHY9taouCeQz8eAktVkic=;
        b=okkzBXfyQv35uAZrtHPHqBW3PC7h0eVzWHWawTsU4QHNvped9XBMWEO3NpaxHmItcd
         IN4R1+OSKzKVbR6u4UEdNX81eQ0Hul8fFItGZzIQtl5UMgtbFLsJUXOsHvKr8Nt7voMC
         U+FRviuPLHDkRUidQ+bpFsuPdaWnl75xgAIrWzQcnfI5LcinqGNXncakofS3+3LZtNF3
         zHKExFVPPzAzDwCzs15d1mFOSKYeQUtGdejIdXNACnPLEyomtaXMKD+93lQ39KUGRnBN
         ceXb2avTlINqlPN2XlIvQFoL9tldE4CMNK23P5tws/UcLczSuw6H4pNmLnDH14CKBSx/
         KD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611965; x=1791216765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtwl90z0UN3pnLPH3ZZJ2kXHY9taouCeQz8eAktVkic=;
        b=QZQHyw/4kfBRbuc2Ou/NmgRUhrICJBZVWr3u0bvEX2KUd7Sj6hycKwvAUf2zCp17Cp
         4mdGfKSCLaYPK5O/cpBBkwAA5+D6/SbS48VJbqHHMFXMqjlvSZAPR2GaAd9zGyYySKG4
         EdIw0rjzISyuWz0/FjRIrPerjPkL9tE9vObQZRgActU2u6ShztpneuwqIfi/Q3UVlZ1e
         el+pnBE7CFrGgb3L6pPWv0mdC/GyVPqvtvPf8Y3R4YYJW5QvRirk1xT3Fg5henEXkqwd
         hmcBzD6WyS9R1ZM4aSS0oFbv+XXiyiy61JE6wF+rplrZlXqsAu3xDwSSXyymS6yPoI0x
         V9jw==
X-Gm-Message-State: AFuF++kPc3TvY5iNL/Htnj2da46J7KMoz7DWi6P43cFcaR0A0zSgRrL0
	ppnZmaKusZtCRyQlf4g1NaAZ4njC1vUqXWCQWP5otF/vGgJvC4pXQMGqg8nrc6BHRqukNZ+ZDxl
	mSKvaq0IvCs7DMF/9BIBspr1G5qvqiBxJUxdOlB2H
X-Gm-Gg: AYBFou3ZgoMgxDh82dEaiPmQeTCdmvxVC3Z8KJvubIno1R8W+bIXDv1Kz5H+jZwTrPR
	zZhxpg5/dWu9gOlglCduqwmx3Ks4Awe1b4AoX+4qmnoa+JjBPZne8tviLxNxI7mR3neC5ky3e7o
	xdldi4I7A9y9TXYeiXzkTHhkov8UHavMwydT1v68wynrYnaRSZarnPB2wy30qs12Ta0+9d+48Fp
	AC0TW+5OuIJCFZvNQfbKc5kWkIgL0BMxgp6izZuiiWPTXE9XSV41aHnLG3bs9MIymKnNX3uU4hc
	VKEs2mg3SW3xXgA8WNQ4rNk3+SY/eKavXTMwAQQQ/1ArDXgEakgjmn/FRqWLC+P7bo+yq1OkrE8
	y4pOA+GGz
X-Received: by 2002:a05:622a:514d:b0:530:e335:4ef with SMTP id
 d75a77b69052e-53320076e0bmr26013661cf.2.1790611964291; Mon, 28 Sep 2026
 09:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag8X7gcDw6jpJsLq@decadent.org.uk> <20260921175719.846883-1-irogers@google.com>
In-Reply-To: <20260921175719.846883-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 09:12:32 -0700
X-Gm-Features: AclHuK-hxjh56xDGaVF6n08-980kUi7Pvlc_u2k27mAU3zemUfhouIkaRCBRU9o
Message-ID: <CAP-5=fWEvnp1S4N37U69Shc=S_C7Xn+NnSiTS8q4YxR5_EUsXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf tools: Put Python egg info in output directory
To: benh@debian.org, acme@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	tglozar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> From: Ben Hutchings <benh@debian.org>
>
> Installing the Python extension currently creates an egg-info
> directory in the source tree, preventing a fully out-of-tree build.
>
> Add the necessary runes to the setup.py comamnd line to relocate the
> egg-info directory in an out-of-tree build.
>
> Signed-off-by: Ben Hutchings <benh@debian.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
> v2: Rebase

Ben's build clean up that I've then rebased and addressed an issue
with building in tools/perf seems like a nice to land thing. I'm not
sure what more I can do to push this forward, and I replied on the
list about the Sashiko feedback, which was a little wide of the mark.
Let me know what you think; perhaps the tags are not done properly.

Thanks,
Ian


> ---
>  tools/perf/Makefile.perf | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 2438b40eaaec..438102bcae6c 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -908,7 +908,9 @@ install-build-deps:
>         $(Q)$(SHELL) $(srctree)/tools/perf/scripts/install-build-deps.sh =
$(INSTALL_BUILD_DEPS_ARGS)
>
>  install-python_ext:
> -       $(PYTHON_WORD) util/setup.py $(python_setup_quiet) install --root=
=3D'/$(DESTDIR_SQ)'
> +       $(PYTHON_WORD) util/setup.py $(python_setup_quiet) \
> +               $(if $(OUTPUT),egg_info --egg-base $(OUTPUT)) \
> +               install --root=3D'/$(DESTDIR_SQ)'
>
>  # 'make install-doc' should call 'make -C Documentation install'
>  $(INSTALL_DOC_TARGETS):
> --
> 2.55.0.1082.g2b9226bbc0-goog
>
