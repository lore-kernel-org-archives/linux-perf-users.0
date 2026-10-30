Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793332771;
	b=RpLke3BMVpBo8Yt7M/DuPubIE6pQsxVOMHu4A7Y4LafeMIncUD8np1OVc4ggl5kE5avA
	 JALNRmYXqYNj+CetH3+xhDqV2Wp5XqgdzbB2hU0WsBVpcFaXobWWr2VIR28pePMHUtRGR
	 dFm+j8KTlo8OG2Nh6GhkdnLq6/0gWYkBEoq1C79ggxvmxQFi7r97JIUz3u1x7YJphZxFY
	 QdMlxm6qlJ4fxnXfsgpIeSN2e20+N8BmkQ2LQLuTqiHjMdgZ6CKdGp1CcwFexSEwOlOVQ
	 Pg2fvUVsPfjbyA9vYA1XyqD3PQEjhhvvhkPEZ2a5mYTmpybiiJZsSW7u7zMcDRb52Aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793332771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FOT2v3eFb29HN7FW8NdCrAqVBUnxkiOGyHwF4K+pcrc=;
	b=bzZXuD2hyIq3GY3Mo7pooUM1ISybel3RY2CIm7l/7AswlUwPoeYBxIBeM0yImPux58tY
	 A9dFVnXdPgL1FMejHFBLwAx3j+jqj31C62fNVf8yY+ajizW+0OVg9CB0pwKJ0nY0gykAy
	 UkLHEtwmsyOVugf/ym6ZDjNc2k1N29awb7ibMSAoKdPgfZay3EIXt1f20R2xnp/tSFtCF
	 KfHv5wA4WBvjiSqpA1i4AuE2D3ZNjRo+8kgbEGHEG/MuZGVkOhwr+qZczYhX2TtNYUbKr
	 lqrytGWKrC5DBjHUCurs0BkDLMM+wMcm2zQYV1XnBXDAMewBm5LHUr3vV5SO3ISsUHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E31A606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 03:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E31A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ab53a99771so2866581fa.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 20:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793332764; cv=none;
        d=google.com; s=arc-20260327;
        b=TsJOicMs5wVAmbjei/px8DYHE86F7rfLdRrikD+hUeIzL/LTFKTrj0XD1eMxrnQBt/
         ttfAAQDg7rOiRONEYb+utsjNgf6HUK53lj8ug3WCsgwXTAdvCC33LauvkfgRJUt81507
         W/xeOaIls0JFzh1nL9Da5uCvLfY3SXJDDbLJWArcPrm03DCCrIIEP0N7AW7LSLHwJ1cS
         /AI15hwF/XZndduQYKdPQTkuB+8irgH7kNEBcHwtAPfQx+pORWJemozz72dj51A/w14v
         Oj9GxDelmnInbRT2apPfdKPEEEyK+tInQkBEF1ohAYxbqEa+I2Lk6rdvd5/q983QA+Pl
         3zoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FOT2v3eFb29HN7FW8NdCrAqVBUnxkiOGyHwF4K+pcrc=;
        fh=68h/G+anO2MIeCWSLfcfh0rk2x4+Boga08whTzExWZ8=;
        b=GcFZVWnwmlReGXncev9XKXYCPpDdjwUjDV9SIr7Jxfs2RSxJV9+94eibYFg+WFkTRs
         sRqh9JJlJR1DBBJaNbiufXlIvKM8H998UB+iFD0J7wqqYHgJutlwjjxBD69dxPZ1C7ZN
         stLia1ldwYxDCcYEsCPZY3OpLI+Lvc2BVTmBcU/V9ClGFhtVdZtv4zcY7GRcqQPJ82aC
         ObCPJC5Vxl4hRekEfUn/Uy4cm6jlDNGMMy7IutrNMM4WfIe98/GCwwaFtn0OWbJP+nEz
         TGJYc7UlxVJIRzofwEoD5CkFkJoZBha2t3X8zLIs/pTNA/Lxoh3LQXK19szb6WFUMuiW
         APAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793332764; x=1793937564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FOT2v3eFb29HN7FW8NdCrAqVBUnxkiOGyHwF4K+pcrc=;
        b=kOm4/A9uYwuoxIElIPkqOL6pDbf17izln7xJORCwomxPzYzFRAjWGx6dz/pFDFMKvs
         XvgdHHpsG0mYL7sSAfudM1W+DTArUE1vd9/NVrpfOrDCIcKqecx8mAsX3+6ZUbD5DD54
         rOFOTaCkgCxwj2UgQQUjJNrqYho2ZY+KF0u/coLUSvBD/UAcsoceiJWqJWzf2sFL/lm2
         ZpBCebJYk9z+LhJbF+A8uOr5ltcjX3SFjAZI3vBDkHeOzbRWYIHO+5WH3EMyWHfa1lDL
         stl+QLqZGL8MlL6UPoQoMq/ZiuTkHu3dkvq+RLU3vckc+l35nZZ9dWOJsZfQAv2+Mw6v
         Q0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793332764; x=1793937564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOT2v3eFb29HN7FW8NdCrAqVBUnxkiOGyHwF4K+pcrc=;
        b=ESoluLgAt2WI7Fciva003BhHLALb/O0C3VPdNjwk96tLjLix1v+brwi7MGGfKfyrzm
         iADqr4Xsn2MIluK9DeHvJe3Akin3ymodTN9ni2UaG7P4Z36d5xi8qIT9kgzT1WH1NxHx
         ktjaxXo/en0VykKdFmrdV18H2tG8quD4JpL6CcP0jwRJSVX4Ei0ae6j0TQyon04GX6cE
         bu7/nrNO8b/nWM8yC4PV4jH813dbbp5YV+DSum0EI6Vgqx4sCOiWIt52r5vFVCDqFCww
         M7fSv+dqRJ1fBB1RYiq6QCHIqOgbiAL6Hz1iHsjNbjoEgA1mXCkOLs3q3bFfSRGiJNCA
         8hEg==
X-Forwarded-Encrypted: i=1; AKwUvBxs0sSRa7t8l5wgadBlEf2fW3GMMLLlG4VmdM4sTOlZROd0AHHP247AGBjXpFAYKv76ogLik1NOdLj7KMlf4rH+@vger.kernel.org
X-Gm-Message-State: AFq9FYIq5vQVhApFdwwAOytjsGIYwdoWJV4XVkZ1x/+mzN1mk0X5OfPp
	H15UuJucX1+Xfc88sLAu05GP8kENoAQ3IFTxvC9vy823SUNlJDb8KyRVV9umQkpEV31vb1TMoRR
	+HcX+DhQhYPTUbzZmMe8LQJWgU8mDUKUmzijfRxjEDw==
X-Gm-Gg: AYBFou1iT/HA0qmL7oKSacf7HwoQOPA92MDKVSZXPau3YjTKdg/OrizW+dYc7XiAe0p
	q6mGK43dQq9/yHiM44aHfRf+gbu06a73JYfat3Sb7lnN2PaVy+poxlDzaF0U9Sz3UQ0Ch0+iD68
	CG7yS0esakxMezoPdyiBHmsswsOtLo5FqYf3LjAXASl0QM4SADNVofzo7K7LiefbR1U5s+pVqSG
	53pyyRxNcJP3X+ckR8U4QXYt4KWPibokqMYKEHbZpTEgXa8qzqt3nnmLPseWaMTaqqXAm5bIJiw
	7h/3JXc9KJt7OBNW/xrzFuC//+1vy/yDSklLDbFgo3HoALhgUfmsLX76r7/1m/KaZNVuL/Nt4ut
	dmlSW1HgXxTCEqYwOluoRplwLPbW15emE9QeiXjIGK68wwE+G9Z845MOEs5VIXzv8WztkXHX3jo
	OE6DZkViccPCxSSLsucSKagjSx8D29wNWzMSTEp+UfiDZ3vi+sK5Zi
X-Received: by 2002:a05:651c:1508:b0:3ac:416c:721b with SMTP id
 38308e7fff4ca-3acb7a98329mr1607061fa.10.1793332763639; Thu, 29 Oct 2026
 20:59:23 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>
 <20261028-alpha-profileme-v1-3-d44b52bf2500@gmail.com> <CA+=Fv5QZhtB646nAvoMzbc5O+EdFOnZhXyRrv_1Q-LGWKfbrEQ@mail.gmail.com>
In-Reply-To: <CA+=Fv5QZhtB646nAvoMzbc5O+EdFOnZhXyRrv_1Q-LGWKfbrEQ@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 29 Oct 2026 23:59:11 -0400
X-Gm-Features: AclHuK90bCzCpBH3kCewscdgnWin1k9-jXiMf8ZZ82e4TOlEtXb6Mcvjq0xGsE0
Message-ID: <CAEdQ38H0sdgPHOi=iDrHWjzsF4GNJgVUt4GxbZ3O5YwpPc3zJw@mail.gmail.com>
Subject: Re: [PATCH 3/5] alpha/perf: implement ProfileMe sampling
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:18=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com=
> wrote:
> > +       pm_regs =3D *regs;
>
> On Alpha, perf_reg_value(SP) derives kernel SP from regs + 1.
> I think passing this copy therefore reports an address past the local cop=
y,
> rather than past the original interrupt frame.

[...]

> If PMPC is in userspace but the interrupt arrived in kernel mode,
> this also makes perf_sample_regs_user() select the copied kernel
> registers as user registers, bypassing perf_get_regs_user().

[...]

> Could we preserve the original frame for register/stack capture
> and supply the profiled IP and mode separately?

Right on both counts. sashiko caught the same thing, and v2 drops the
copy. perf core takes the sample IP and mode from regs
(perf_instruction_pointer() and perf_misc_flags()), so there is no way
to pass them separately. Instead v2 sets the PC and mode bit in a real
frame for the overflow call and restores them afterwards:

- interrupt taken in the instruction's mode: regs
- user instruction, interrupt taken in the kernel: task_pt_regs(current)
- kernel instruction, interrupt taken after the return to user mode: a
  per-CPU pt_regs holding only the PC, since the kernel state is gone.
  It is not on the stack, so perf_reg_value() reports no SP for it, and
  the user frame is left alone for perf_get_regs_user().

So SP comes from the right frame, and a user sample gets the real user
frame.
