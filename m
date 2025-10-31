Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2999285419
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932994; cv=none; b=vFbHIIjQFa5LxU+ZwHuesw3vD/XHipbXoz4hIA5uDkGz7UJj0P3dNYnq4VpitX5umXe+gQumZMEbqlUZMQh2DA3ZTRBU7hVCQp2qBEWc9fMYkKDpCyyqhCN06rMAzazKMFIjoHyj3LdtRR7ausIzs3QNKVzwDXr83gf+BWyNwvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932994; c=relaxed/simple;
	bh=Jpv2bdZFG2SIkjFxNiLMurxDn/3qIdoC2XeK2N01s3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FusnI1VjG5W+SaG7LTpHgFN600hO9q1uUt998u3mINe+/ppNgy16H+MydL+gnQ9LwGPiz6vj3TfEK5jGaWSQTp8Z63b/Co3rc6vREp8BVINtBinCFpsK6KPza+KGy/7QldK8GLb+VM7c5TMq8IDf1knxI0Y5hAz9HPs7kQdz2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CgDONmcK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgDONmcK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27eeafd4882so18825ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761932992; x=1762537792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2kWXN97vOOBfSdz0VZs3a35PXRDdLyrI3dIgLt3Zf8=;
        b=CgDONmcKileVq5Qf0b2qwx+l2iGjEgjy/GXT4Sf3Q35QkZ9gNymURRALoU8DTuJ7fu
         LkZBYai2bmsOoAyasqqJiCyyLBiWuRGP+0qpgjTgSiftwC5p+CwU2VXZsUnzahnJFnvd
         JlVQN6LyZBGhFMwfMs0rSC69fuG7VpCYs/290p4OqHbTe2aDE7VhNLLNofmdLnPaaNIe
         lOHLmQ25FPpXw/3qRkxNMSE+33McyW/CVM/GA2OQ+cgo+MThpgB2ZFB/CV6Q0/d8QxhU
         RFHKACRVnOXvxP7A9I40Cxth1OdkcHyD2AL9uamHzklSgyYvYR2mvmUbpQ/KK6mgkO5M
         eW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932992; x=1762537792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2kWXN97vOOBfSdz0VZs3a35PXRDdLyrI3dIgLt3Zf8=;
        b=hyDgkVWIVM4d9fk7OZQ59wcmO63IOx6qMiaApYy3UxCBJJwYe52StC5vLNf3t7StP2
         X/ZGdyR+NPPWHHG3AgR/hrd4IWd39OfcAJm/yz+TAF9BynZJhR18OBuodV1zHJDgI/kJ
         Mw7V9YEctfTjPXod1LzsUyn+esPEB/xpxa/Gtrrr9geRLeQBIe0O00GeddzAxEcJ8JX+
         r5CRBmjgYz+FONTdo92LFZXIFgr7WuC/iTpjWOlam/eeiOPRE1O+QZAj0DkRpuGm0FjD
         8eegQgMR4yBApZil14zl0x4zE9yForgp0h/k+C9ZKBJ/yKIf7RhmhgtuzIUmTDPc5TF1
         dsRw==
X-Gm-Message-State: AOJu0YwXUxw2KAsuGjl8mwVuVgsKwy401PPUXFNdMH5aa1PAIi/Q1LqH
	renPrkvIhVz+mSmwNXgnp5ranRf1oCyIqB54LEbhiSJYdORga4qu16MZe+aCFAVOdBRrmlm2/l4
	H7+HLlJAr67TVST5Yuwx/APzjYuKfDhJ0n35RQ047TFU5ouojy7ANjxYhDko=
X-Gm-Gg: ASbGncvXstLi70bvbNvGpzQxWSoY/uWRq/9BCv/F4uPKAP+d6yXsvsAbjyKOK5dnXMz
	ISiZeaZwEpMJNnZbDt9uCKxGSlUO6HfiWtKAw6kZ/F+rQaYF/qwMSWUo2Nw49NxxX/NZaAp+mAR
	DtG4mBHiU8tocaEHH8072xVP03pB3eaKFX/C4D6Xefyva/Dk2+AKRvxTmWQqD6FySzWwGb2DGLe
	Jj76R2EpKDyVXTDj2+orcarq7F+U4LTqy00l3rptzrtCx9qDuh50txdm+nb3uuuNB7rybSHprzG
	oElqhfzzyA0k2mEpnXc2n46KDQ==
X-Google-Smtp-Source: AGHT+IEGyVoSqLgSdcNny5ZYs6eVBKjfg+XjUWlli4DQ+8Pj2I+fw2p6eqNYvtrG9zf2HqaO2gbndugifjJBc01Ja/A=
X-Received: by 2002:a17:903:1a67:b0:295:28a4:f0f5 with SMTP id
 d9443c01a7336-29554c8ddedmr194495ad.5.1761932991797; Fri, 31 Oct 2025
 10:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPkivW2WoySU1Zkc@suse.de> <CAP-5=fU4y2y+pOT590GZG-A+zO5YdAAzUyPgUX5RTji0nh6Z+g@mail.gmail.com>
 <aQTrZ54mkx14r_cQ@suse.de>
In-Reply-To: <aQTrZ54mkx14r_cQ@suse.de>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Oct 2025 10:49:40 -0700
X-Gm-Features: AWmQ_bm7oI1SSElNjUxrEvZKPGDFHrCWjVGbJmBENc3Hm3MYbbt1J-tVds4EVfA
Message-ID: <CAP-5=fWvzo8nH3ibeVx3UHvAcnJAcQ+JjukWP=bLmY70vTT9zg@mail.gmail.com>
Subject: Re: addr2line performance
To: Tony Jones <tonyj@suse.de>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 10:01=E2=80=AFAM Tony Jones <tonyj@suse.de> wrote:
>
> On Wed, Oct 29, 2025 at 08:51:12AM -0700, Ian Rogers wrote:
> >
> > I'm not sure there is an explicit discussion rather than discussion on
> > individual patch sets.
>
> Thanks for the reply.  I thought the original comment in that BZ
> was talking about plans to remove the current forking of an "addr2line"
> process and communicating via pipe with some library implementation.
> Of course what that library would be if not BFD/LLVM was my question.
> Clearly this was a misread on my part.
>
> I'd seen the patches related to dlopen'ing llvm, backporting this is
> a possibility since we don't want a rpm required.

That's great to know and motivates the dlopen work! I can resend a
rebase of that series, would it be okay to add an Acked-by tag[1] to
the series saying it'd be useful for SuSE ?

Thanks,
Ian

[1] https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

> Cheers!
>
> Tony
>
> --
> Tony Jones
> SUSE Kernel Performance Team
