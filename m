Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEF52E046
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929473; cv=pass; b=I2+1+GpR+SWH/TSmBZwwNH5YxYtrG5ND20J8LSmpINss7n4TDc9rH2kVpzc8JeARRqIUE5oUCKzyNG0L7txleYWPMynDxBkKIZpqxYRHlTpjjllushBC0Oy7vZJ/YoIN46JROY5Irm0id9qprrFZiKgkLvITxKhhNbZf+0IDvAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929473; c=relaxed/simple;
	bh=FYTV9FNBFSb9ojtmdwQPjMX2y3qFMZRTL6lxs4fSGMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+FHDSrtWUaN2n0Jr7AFR+KoHioqfjPAYgnInWapcpqq/J55LgJcKnJcZGv/YJuniEKJoWNOS/3BCXdStUsGF+jmuIsBj6S6cbZUyK6hkSxY0Fr8Z/MO8unLeN8VBhdcehQD6fm6nmULY551StfOILJ76kG1pB04cfc5QqfBa18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mr6PaSgn; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mr6PaSgn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8623790f8so180865ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 15:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791929472; cv=none;
        d=google.com; s=arc-20260327;
        b=TTM28u72SkhlbAdllSCSkObi/eu3DmS955p6tjTk7hraziJq/JfNzhD++2ccc9CfaW
         WfaZae7wEShegR7CKOS8dI9R7p+6xINsqMWBRwyiPe7LnP5YgEjG16XcYpB9C90vxxqJ
         4BURF9Jj34QjDI+N4GJ0LTMmwHM6a2SZW6lJpDc9TbZoRggmnAqJpN/Fb8LBiku/iKmF
         3XnPwA08iNnm80BCAozyE93hjaBhkNpWQn9HwmlyAUr8IJMng1mCSFq0VEk9rwzKlu6H
         rQWfsm3CLq2+LhmHz4dUz+fhLLGNoLswAE3c7JkCM8DPzXk72RuKbbRTdUKixlf8ORkX
         6PBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I/HmaWIj5cIrehfzfKKvA+54cdWoeGQYgmlrlmSSeWo=;
        fh=hZhQ/68KfdFdZTQ9mfoADI/4f8Qa3aEx2XRviSu+/bw=;
        b=jCG0gl36nv+9snNy6RK/7Hux+3mJRB8JfLC2LxoU/JzHBojO+W4ESWOP4UZfbFQGLB
         AW3eEgH1mUxuQ9qgqB5xmk3ZZDnGyZB040zdKnyE6WdDYHiuB8jm52YeTBjy+e0QmjPC
         ivdZdC5J1it2IzihVxXB/C8SwRke2NgefFf6r71kEYDWIMLGTLsfhYOFP72LwMyinyUk
         1PtivmUjCo5+nctfGAY+6axEmr/fK0rrX2emviC2TgIM/r/Eb0cyh9Xci0Q7k3WWsRqi
         b6qP4TDkJOVaTyhc6NVUYxmO/Pxy/xxFYBDK1XV6k4F9s5ASOCwE/kIRDtwMVmY8slw+
         j+iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791929472; x=1792534272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I/HmaWIj5cIrehfzfKKvA+54cdWoeGQYgmlrlmSSeWo=;
        b=Mr6PaSgn62Uz2fYQ3vRqWrnK8ggrLb9QlTS2HRhzhJlh/5cwuNHowT5rmnFVaYSqtM
         /1T464omC4gElp93jq+FlW3XgoR6lrAyT9UqypPJXnmfgNAPQqhMnYb/AuxgZlRslBBb
         eSH+DlCsHAwnSUY9aNyEKj4dOtjVVEMPXCf6SnZHHh7W1As1DMvGVkm2/1H3Bm9Ll4zY
         Ay5pEhKx8FCcmvtXBqPc1lCB2yRiaoLAUH1jevRpYbk9wLUpsuUmmJL/lXJ8HtigO5mz
         eW5Mqo30ccwEKI9Q9C2xMg5J20dPloYSzUD4dSGg/M/JBKfAC+bj8h6RI1V5UT1aspIc
         0m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791929472; x=1792534272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I/HmaWIj5cIrehfzfKKvA+54cdWoeGQYgmlrlmSSeWo=;
        b=oc7OkwYu6ZUQ2VXVjCxxYl2MInMnmCeqRL97oOQEg6Xc4qQ7g+DQoLcDMQz16EBR84
         C1CcfTibWA/yePggXG3Z0kH6dZVvyC0wOwr3mv22OQ05iinVqA/C3jHd+ldubakQlyVp
         YO1jVuzxb9aSu2CBZd1Z17fVXYTJdwIa3ZjjZA8WM3EPZL+L30Jb9mKO0hyjovxbwxX6
         EMo9OMjtBPOMLW4e65gA8NAy67TcEBsTdZ6o3XpU++4vR3TMPoV5Te8M17mpXEccPs8E
         VNPidvlKCZH5ySJKuu6YBDKMlhD0grVhXrgSb8ynEn+z0EyktsopNvBL8QM+A/CAhiCC
         E4JA==
X-Forwarded-Encrypted: i=1; AKwUvBz0t5Offt0qkYN7o0XPvtbZI/KdyLuoYWJVL5FIfsQCRBuUPUf5ieX0c8rVXdKW1m+GMfX85zheWjXnCN8qtJOB@vger.kernel.org
X-Gm-Message-State: AFq9FYIK76seuTrn00OM1SrLSZ8QsbFIRIGVRfeLWm1PItMBBGRnvkcl
	G4KqwSH/9ZJ9VMh47m4GtvnZQ0FYlub3Asd/7ybXVrJZ06soX5N94hAQTdXc3Su2huOO/uUrC+c
	J3LFo4sKkpJDRT+9v66T/tgxGADHfxZ9x8du8eZDv
X-Gm-Gg: AYBFou3Hr30DHsH3M78DAhsOCsJ0eQ/koA12IuriygbREHb1igb6AyBCRrfAc6I0LKK
	RtFGOQyaMPw7dFVbo0fLbzSJDrJtEO7wprIAaZAL71DarfmfdyktbDvvF3e7jpuFzq00bcxB/tV
	sejExjr/TAtEXYaegiW1aZlBLrnSVpWertFCaSUrZxAdfiQUQJp0uJ/EbT8IVMYdaOnjc4YlkdQ
	4AFke5Jl9IIr1QmIlEt8QJ3cu2G+wwFcQTkGwOJyy3SbrAARVQBZUSG/2UP73mNBrt+U/abPTQ6
	5Ek4e+h/A/YgNP3igMRaEtZc1WhHhwr/Zob/f2OhQrv76MgdwXM4kHLJFNo1pWv0MNOg3u6+Yzo
	egqn0p90h
X-Received: by 2002:a17:903:2b07:b0:2df:96ca:d7c7 with SMTP id
 d9443c01a7336-2e939abd25bmr287505ad.10.1791929471359; Tue, 13 Oct 2026
 15:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com> <20261013182458.1234616-2-irogers@google.com>
 <871bf440-5b43-4d63-83f8-15ba96719fa6@acm.org>
In-Reply-To: <871bf440-5b43-4d63-83f8-15ba96719fa6@acm.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Oct 2026 15:10:58 -0700
X-Gm-Features: AclHuK9zqPxbei3yiEwT_Je-bqqvc_vKWZJxCFnB8AYrF-IAVVVXSXOd4HXS8b0
Message-ID: <CAP-5=fX1XZu=3scB1-hA2ppcM0+sR7t_3=C7fFx=kGikm=dLqA@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:44=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 10/13/26 11:24 AM, Ian Rogers wrote:
> > _context_unsafe_alias() does not use its parameter 'p', which triggers
> > -Wunused-parameter when building code that enables -Wextra (such as
> > tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> > Explicitly cast 'p' to void to silence the warning, matching
> > __assume_ctx_lock() and __assume_shared_ctx_lock().
> >
> > Assisted-by: Antigravity:gemini-3.1-pro
>
> I think this should be changed into Gemini 3.1 Pro. I don't think that
> the "Antigravity" part should occur in the Assisted-by tag.
>
> > diff --git a/include/linux/compiler-context-analysis.h b/include/linux/=
compiler-context-analysis.h
> > index 8302ebc2ea8c..024e303188ad 100644
> > --- a/include/linux/compiler-context-analysis.h
> > +++ b/include/linux/compiler-context-analysis.h
> > @@ -243,7 +243,7 @@
> >    * alias as a function argument).
> >    */
> >   #define context_unsafe_alias(p) _context_unsafe_alias((void **)&(p))
> > -static inline void _context_unsafe_alias(void **p) { }
> > +static inline void _context_unsafe_alias(void **p) { (void)p; }
>
> Why a void cast instead of __attribute__((unused))?

I agree; unfortunately, the macro isn't declared before this header
change needs it and I wanted to minimize the change.

Thanks,
Ian

> Bart.
