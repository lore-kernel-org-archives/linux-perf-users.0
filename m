Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9102BE7AB
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765301898; cv=none; b=Pg/FvBgADoMXR5mSwpPPgGs9uHtqbjLiysp++4sgNMYNH97ZkxaUjUZytA34679U8oYPAWUAv6su+EDUtjuB2QyuX+2zFHo+vkPIdjbspa5ssVHKCHIu/R+qPhUWJOXx/9iqIEo0ott4J8KuFDdrkm1zFy6iac/Drg4geXSSrmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765301898; c=relaxed/simple;
	bh=U7mqj2rxbhaXfjOPkMTRwiDgJAAVD62YE7V2tMt8HMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzQGdV2xsI9Lh4FUfq6pnd1sohJERiszveEJvmEsmr0Mz2GF4dxaxaasTX37XpmCZROyEL5u4aBemWrAqkdY22RaHRrqnjlhs6MwTiwYyk3HJlMaE+gCdUPdwBfbpM9cjowyravlmSlQ/3DQw/Oa+MMJjFbvMCK+d9RoDEe6DvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tl5gZG4T; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tl5gZG4T"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2980343d9d1so195285ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765301896; x=1765906696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DWVfPOFkRuLPHprVzGlvTN5sOBT+uaKw5aDuA531DE=;
        b=tl5gZG4TTFInDYgcksEWIa2VrYBVM4C8MWm1dVd+I7QLXwjxrfKG/V8ZC9lPjN9EdE
         t3eEoaKd8O/iDid3RBgBJUQ/R1OfF6Ffd7yDJk9Zp3jiabMPwj5Bvsi0kX2BscQ+atWa
         ZhE30coYm25EQAsh8Ca1yMj1owfJbD3grXuGDjf7vukGQfLLwTqYyPytoqgGB5YwrZd/
         rSxgws1cq5Jrt3Qn28S9Lhht62vV63djnFEvVHWPw/hl3+ZQon14XzhbuqanUkOX5tFX
         07KcfXMgfb0M3myiLusCpw9Jzfy1DaMmuIUxOtvvLi0LUIN8g3T3Hv8kBTpii4uKfJEn
         bb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765301896; x=1765906696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DWVfPOFkRuLPHprVzGlvTN5sOBT+uaKw5aDuA531DE=;
        b=WIYfIzRx0l5FhItHAOBtU6s7MXCsxfU0MQseg8dPAFXTDOQKgQcbuC9e5RPsEpPCbx
         bGlOHCYY/z+PJLvUwC5OPX3kaK+dSDEk0EfuP8tOzSzc6tXdjwa12yuB0O1uvzVUUTZG
         7QxX4Cf9Vp7y3MA5RkJ7y8S/E0tOmXPrSD4XienFvAQxvxInv4I3Ut/hV4umZBNP7RKy
         goO/Apm4oVk9VNdy9IOn/5KmiD09C1GdQmY62Wa1++32zkfDSJLEIC400iX4put/d4ou
         fDJmI8zABFLdSVpPf3fH7C3PSsjZYE0Z+XsQlEuaSj05FfE1TqWI3cYj5HF57GFcOH8d
         pmcg==
X-Forwarded-Encrypted: i=1; AJvYcCUBxLvJlULNmRruBajUAaSRJyg98xEQzfSAvEZ0vjPyiiiTX97SebSGRhAIWLSBW4N9ONgrJdadfZcvF4+IbRmv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kcbG0q3Hnq9mKx0O0AReyIKmw6duhFE2uXaUnzdgcGt9bxQy
	25I5ORBR0PMzAi4izm5gfEq3gvglRkNpSWti5u25KMA3VLQm9a5kPYaJ4JcT7BZ2d+y22MWLUTX
	J1LTkdcjRwQ3PPO9ly/+H+UR2nhAuLRH85EC0Rm2K
X-Gm-Gg: AY/fxX6r7JsaoxaPn7FxbUe6g6V19IpEmwerrvAnJhcy7yWTEdWbrG7l/D+Km9QWxLd
	gm55ZvGJEpOd/3+QoxKbBd/jmqOeqcQXLMBtkKD+9sTpzv7V8xl2rP34yhtOQRoWoEJMVkBH/ns
	4UkfwpTM2TVESUcgHwTCSloXqIQlAZyyfe1cN+FIiNX5MFxoYHHcV6TEUTq5x4bdz1/3GYv6fZB
	DCBAdVr4nU8ZCJIFclkiCeFdC4ddllnddMXlBOUfqZwadL62sr2mtm3jiCx6mDz/SylMjrUyeJg
	ZVcftngFxH6aKpG+FqSc006E
X-Google-Smtp-Source: AGHT+IE6P1CtO19tut3+obUKS9170evJjmV7qNs8FE6t/pnyZ11kR2c+QYF7xNgW7wVp5EGs90dXZ3lHItiMw+vdivs=
X-Received: by 2002:a17:902:d4c1:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-29e94197dc1mr1236665ad.4.1765301895625; Tue, 09 Dec 2025
 09:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203214706.112174-1-irogers@google.com> <aTP4zSy87wEZlbsO@gmail.com>
 <aTQRgAOpKyI53TEq@gmail.com> <CAP-5=fURCzNLC8izLAbu50AV7nhLmCDwaDpfiWkQp3ihgHMNxg@mail.gmail.com>
 <aTfhfVywjweJyCHw@gmail.com>
In-Reply-To: <aTfhfVywjweJyCHw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Dec 2025 09:38:02 -0800
X-Gm-Features: AQt7F2rcBLqolDDYdqcj18ETybtxJ-9gWC9C7laNc-nemzcqYxa31OlwcjJuDwI
Message-ID: <CAP-5=fWD_3nuvJUUn0162OkCYE4Ex+ETLJ=6+s6Z0enc4iSk4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Perf stat --null/offline CPU segv related fixes/tests
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 12:44=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Ian Rogers <irogers@google.com> wrote:
>
> > > There's one more perf stat QoL bug I'd like to report - I frequently
> > > do repeated runs of perf stat --repeat and grep the output, to get
> > > a feel for the run-to-run stability of a particular benchmark:
> > >
> > >   starship:~/tip> while :; do perf stat --null --repeat 3 sleep 0.1 2=
>&1 | grep elapsed; done
> > >          0.1017997 +- 0.0000771 seconds time elapsed  ( +-  0.08% )
> > >          0.1017627 +- 0.0000795 seconds time elapsed  ( +-  0.08% )
> > >          0.1018106 +- 0.0000650 seconds time elapsed  ( +-  0.06% )
> > >          0.1017844 +- 0.0000601 seconds time elapsed  ( +-  0.06% )
> > >           0.101883 +- 0.000169 seconds time elapsed  ( +-  0.17% ) <=
=3D=3D=3D=3D
> > >          0.1017757 +- 0.0000532 seconds time elapsed  ( +-  0.05% )
> > >          0.1017991 +- 0.0000720 seconds time elapsed  ( +-  0.07% )
> > >          0.1018024 +- 0.0000704 seconds time elapsed  ( +-  0.07% )
> > >          0.1018074 +- 0.0000946 seconds time elapsed  ( +-  0.09% )
> > >          0.1019797 +- 0.0000524 seconds time elapsed  ( +-  0.05% )
> > >          0.1018407 +- 0.0000658 seconds time elapsed  ( +-  0.06% )
> > >          0.1017907 +- 0.0000605 seconds time elapsed  ( +-  0.06% )
> > >          0.1018328 +- 0.0000868 seconds time elapsed  ( +-  0.09% )
> > >          0.1017469 +- 0.0000285 seconds time elapsed  ( +-  0.03% )
> > >          0.1019589 +- 0.0000549 seconds time elapsed  ( +-  0.05% )
> > >          0.1018465 +- 0.0000891 seconds time elapsed  ( +-  0.09% )
> > >           0.101868 +- 0.000117 seconds time elapsed  ( +-  0.12% ) <=
=3D=3D=3D=3D
> > >          0.1017705 +- 0.0000590 seconds time elapsed  ( +-  0.06% )
> > >          0.1017728 +- 0.0000718 seconds time elapsed  ( +-  0.07% )
> > >          0.1017821 +- 0.0000419 seconds time elapsed  ( +-  0.04% )
> > >          0.1018328 +- 0.0000581 seconds time elapsed  ( +-  0.06% )
> > >          0.1017836 +- 0.0000853 seconds time elapsed  ( +-  0.08% )
> > >          0.1018124 +- 0.0000765 seconds time elapsed  ( +-  0.08% )
> > >          0.1018706 +- 0.0000639 seconds time elapsed  ( +-  0.06% )
> > >
> > > Note the two outliers, which happen due to some misguided
> > > output optimization feature in perf shortening zero-ended
> > > numbers unnecessarily, and adding noise to the grepped
> > > output's vertical alignment.
> > >
> > > Those two lines should be:
> > >
> > >          0.1017844 +- 0.0000601 seconds time elapsed  ( +-  0.06% )
> > >          0.1018830 +- 0.0001690 seconds time elapsed  ( +-  0.17% ) <=
=3D=3D=3D=3D
> > >          0.1017757 +- 0.0000532 seconds time elapsed  ( +-  0.05% )
> > >
> > >          0.1018465 +- 0.0000891 seconds time elapsed  ( +-  0.09% )
> > >          0.1018680 +- 0.0001170 seconds time elapsed  ( +-  0.12% ) <=
=3D=3D=3D=3D
> > >          0.1017705 +- 0.0000590 seconds time elapsed  ( +-  0.06% )
> > >
> > > (The zeroes are printed fully, to full precision.)
> > >
> > > Basically random chance causing an apparent lack of significant
> > > numbers doesn't mean the tool should strip them from the output.
> >
> > Ugh. I'm not sure why the output is like that.
>
> Yeah, I'm sure some dim-witted kernel developer requested it,
> without thinking through all the consequences.
>
> > [...] Searching back through history it seems you are to blame :-)
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/commit/tools/perf/builtin-stat.c?h=3Dperf-tools-next&id=3Dbc22de9bcdb=
2249150fb5b3c48fdc4f6bedd3ad7
>
> Uhm, never mind, what a brilliant feature! ;-)
>
> > Perhaps we can drop the precision printf flag and just make the flags
> > fixed. I think this output is obscure enough that nobody cares about
> > minor changes.
>
> Yeah, sounds good.

Cool. I sent:
https://lore.kernel.org/lkml/20251209173610.2033973-1-irogers@google.com/

Thanks,
Ian

> Thanks,
>
>         Ingo
>
