Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxJyf+2S"
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAF2B2
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 13:21:47 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bf09be81bso95e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 13:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701724906; x=1702329706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFgXuHjDc3D5newp7eIztZW8LVxzGsmFQc2MUunS/xE=;
        b=LxJyf+2SvJuXxnx9AYQMYRhpQsOzAjao35CofXsDIpfFXTwD2LY/WlNkZaUFYtEo+p
         r2MyHnbWbSgtt74x8A5WeGlBn79Zy6Y7M0FauTS2YVnCVYvdlpmm37YiNeL2CqfdCVB3
         yefxCW5/2WtY3Aw/hG0mqe/2h98Q/DOKb169nbFoXzTzaYYi2kzmnM0RC6zRLGtLP99B
         zUEajcyQGaGa8O5vd0Agu7wIdMABiyGkm5eUCqcFkXkMrTyMl9mZSHDAn0n/ZmCqhEtR
         6mrvPBuzVeOB7Etp3rL28ipw3O9B7RH7HtSyLTKprPKd2WABtc0UHRh/Mr8Cx6VNc88F
         yycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701724906; x=1702329706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFgXuHjDc3D5newp7eIztZW8LVxzGsmFQc2MUunS/xE=;
        b=Azvwf+oCoudaEnIOHqPdnu9plct3wReyKrHc5teWjWfYFvtKCXiUDOrLLvVeTxPJRS
         iTpKj6bqY2597LiIXPOC9ImdvOo6N/oLc6JKKZa5rW0m38bqFnuMkCKFgV9UE+licVRo
         gbidzqVaIdj7nrd7DP5O29ys4IA4TSrm5gZhH2nyS1AYH//a6dfxuWgTAMORelkBVkq5
         /gIFJnWBHwA2ynKfjVqP39e8xbrVDx9ffZl46yOsRTwowD6UNEfi/tMQ/jAYNAXBN2Qs
         rO/bOwzzRKrFCwzUsA+wASVCZEIyTEd2rFMOY3BI2Ck+WpR2b9+N3itSb+R/dTysFb4B
         ch5w==
X-Gm-Message-State: AOJu0YwDvnTqmZ/d4YG96FYmqnstnPhmPc0A7+kZYpNgNmKwPFLGD9ab
	3w03G3qIUak6o8KQ25dIUkKQebG1H3x8HKxnJA8a5w==
X-Google-Smtp-Source: AGHT+IE/O/ZsBoR4FVdm50oimb3IctySD4pL3CK5Zb6bplneGlVeSn6JqmSdQE2L2qXXFPyQkm+jAg8R75bOhPqcutA=
X-Received: by 2002:a05:6512:401f:b0:50a:519d:5a8a with SMTP id
 br31-20020a056512401f00b0050a519d5a8amr307755lfb.5.1701724905861; Mon, 04 Dec
 2023 13:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADWks+Z=kLTohq_3pk_PdXs54B6tLn25u6avn_Q1FyXN2-sVDQ@mail.gmail.com>
 <87fs0iujaj.fsf@meer.lwn.net>
In-Reply-To: <87fs0iujaj.fsf@meer.lwn.net>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Dec 2023 13:21:34 -0800
Message-ID: <CAP-5=fXER_5EMRLmc56UEeRfmHL8nMjoF10CwGkmeADazUO3FQ@mail.gmail.com>
Subject: Re: Converting manpages from asciidoc to rst2man ?
To: Jonathan Corbet <corbet@lwn.net>
Cc: Dimitri John Ledkov <dimitri.ledkov@canonical.com>, linux-doc@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 6:36=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wro=
te:
>
> Dimitri John Ledkov <dimitri.ledkov@canonical.com> writes:
>
> > Hi all,
> >
> > I was going through build-depends on linux kernel in Ubuntu and I
> > noticed that whilst most documentation and man-pages are written in
> > Rst format, there are a few that require asciidoc.
> >
> > $ git grep -l asciidoc -- '*Makefile*'
> > tools/kvm/kvm_stat/Makefile
> > tools/lib/perf/Documentation/Makefile
> > tools/perf/Documentation/Makefile
> > tools/perf/Makefile.perf

Fwiw, I'd be in favor of perf not using asciidoc and would be happy to
review patches making the change to rst. Ultimately merging wouldn't
be my decision though :-)

Thanks,
Ian


> Interesting...I was unaware of those...
>
> > Are both Rst and asciidoc preferred in the kernel Documentation? Or
> > should we upgrade kvm_stat & perf manpages from asciidoc to rst2man?
>
> In general we don't have a lot of man pages in the kernel, so it's not
> something we've put a lot of thought into.  Ideally, I suppose, it would
> be nice to get all of those man pages integrated into the RST docs
> build, but it's not something that is likely to inspire any great sense
> of urgency.
>
> Thanks,
>
> jon
>
