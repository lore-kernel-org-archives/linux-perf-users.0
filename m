Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20044224B05
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787263225; cv=pass; b=DtDdKPtaIaPrqLM951CrcLfEfKlGUV6j/ZQRDOTBGWQ7xlK3u2FM4rdXQOaaywLFX/0Nrx1npuchEM/Fc5vfDRrNaf4+TCvSqC8ZySePMTlTZ8YA+ACMqFYvZjVngc9zyMohECEzWFIGdW7EpuQQ3qScpzuWtAL+SAPQy/ggxQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787263225; c=relaxed/simple;
	bh=klW63XEhKMQocJ0DzTQsXSHDJbLwJ9WMXcAIyoleFD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOEG4MYASegiir6p/cnDWpebNFpmYUZlJvywuaNEPKZ+9xBqBcd/XPo49MSKIPktZ6iKMs6y2ms4ZuioSyk8q0Jw+sIppgyFZKdlXtNmnn8U97EiKyz9Ok0K7Ugojtaauom2uOP7s2BvFBu7xAUaq7ZmkkLMMT+AgJRiAbO5NNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hk9/R7iQ; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hk9/R7iQ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c10ed63c0so17561cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 15:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787263223; cv=none;
        d=google.com; s=arc-20260327;
        b=Q5aBWZHdkuluXWADJdEeoHGKnJjhUikAdCqPDyMeRqyMltZGkRV/9sEtyU7aZEFzY8
         o09MRqEEX5hdQq6DGxNKHDivKmTvRa9GYZy3cdnasTovBqQl9JLmlkYgdOWs+VxGLABm
         JZVP0+SBZJCwdzjCFvx21jIKir7IUWrad4vCbWKbntn3BXDdZ9KxMYxCoNN4gxURx4sE
         jE1FUNLcf2QPECE9su0aT4XNVEXUj1wiBZ0LZqQItzRSgJhIklX61ZGQ4Cck0teCCMpC
         w9fRc/sMJQnjqWi6gTr+v13y8eyFJLUaGQlKuVG+VzZmn+R8S0392t5SzReSNpfSqD2i
         e9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=klW63XEhKMQocJ0DzTQsXSHDJbLwJ9WMXcAIyoleFD0=;
        fh=MAzeeLADGi5XGTGrx8vtVQKHp8OUkTz21r9UpZR/45E=;
        b=oi12cBt4cNSAeLXyE4NPgy38/z72CoFHKz3eq4A+ICEI20ACO1yBLT4QK/C77cd+kO
         i/0u1aUaGTq4shYCrIIO3qn0GuEsYdXcJ9LY8BtGiSf8O1EbOYZYcAPL6nQ2TQl6g4fi
         jAT175DzC0C4Au8618sy4XckOH9B9wMyPK2CI/x/AbWgJxnFqueiblKe9fbulKOgmX88
         emkxQHrX9r2VD3mZwZYpjAyvFZW50aASOI2tuXh/aIifCrU4rsM3U60rptx8QH1kcavU
         wLKGpYjDyVttXcPQ+O/Cr0fN4ESSkqNnJ/9UyCRL1MdlE1niEdC9WD2G/UvLznRwCu8T
         84Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787263223; x=1787868023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=klW63XEhKMQocJ0DzTQsXSHDJbLwJ9WMXcAIyoleFD0=;
        b=hk9/R7iQ3OF/Yj+LP55y7dU5/GY8lqqCEO/KHohb3RFWK24XZcOuZuIjyNQEn4Y4VF
         +oFjzXgSwSt0EMmAhTofRYrbB7SgpZ2iivK08dmDtw4bqswVJKbEMYRiTb0340j/GFYg
         sJPWJ9SfYNw4LVCuPr+JHckpK6sRyd07KjrAN+z1pmGesf8Ku2OVXTUNc2bAOdnCf328
         rp9YE5r7toXc7e/fBFNXr5/oqXFY99+kmghRaeUb0o2AmyEzpbu6CdBwxyiwGpFyacwV
         ahFkbT0I/xHWO7XbJZvoM4NRnIHb7YrZ5TJxFtbgnbUusY2xVE/MIBnxH8WRpTe0mcBd
         5iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787263223; x=1787868023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=klW63XEhKMQocJ0DzTQsXSHDJbLwJ9WMXcAIyoleFD0=;
        b=Jpi2kWV3u2grAyHDmdTz74y/eMYgjh0l7NpjhogzZpzwbRp7WRG7mw1sMDDUhSS0Sm
         IWSA+6LOT0fPTy4NsXb2Zdogw14+hzeS253XnxvM7AiUzokUdgsMIjSWI7rUYZDUA0N7
         uPKtLXFtT6v6pQy/giiT50LTFIrc6XQ2ZpHNy4opVQpF5SSZ0dwapMQG9SLTeeCz4w7h
         E8qzIDWqKWb7Kkfx/Zpsh9aYHv5vkvThf7DtpesoKH9vQwqOLLXY6Cyxn1v2pdMwCpZx
         wlLfeg7AGn5AZW6jBTc5wU24brJh+oWMLDtWvzWvHcxTm5k25QKMEWb3Y06qrj4o75U2
         fJ4g==
X-Gm-Message-State: AOJu0YzbVOyjOhfDJjvMov+mZHqYYIxMPFRE8PMkffQ83pr3P9y69nNa
	0ALRHC6CYQUOzqklToGC4Rsoc7ZHZhTKk02NOGUvOvnS+Kgng5SMyrGi0vRHQ1Sp9QD/X6padNK
	VhKFmGkZGwbMFHW7Eb4A0L+E1v+OGs5SAX1oPJZ7S9rjlggE0p/bOiJR/
X-Gm-Gg: AR+sD11RzRREFnK6nxEUvU1BKYoZBCycAMDw0b5TXlheVCgZVcPGqDPogh1h87q7ms/
	aPDf3oojxknctncp4kK29cUXC2ajKCHZ8fPG0wfNK54OiOYXnVrpjyAIHUVywIpDUj5RBaz7y5c
	aZ4RSs1H9QLEs6ShEb4gTXpidNYFbo/v4lqnkC4OKwWoDZpC03ysnu8gtbwubA+UUpDj4fYCAON
	a0jTv8JSke0ekehXucZXwJTQj+BoRrECTrGdQna0e+xKFFNw6Aze4Eqn1RKCs6Il3fjCC51xlZM
	hY+P+4+6SBbSPMojkB/iNVVc6KANg3ny2IdbJXxfhCETQO3HWHtCz0Mp/bQmboZGKq/5+z85J/o
	=
X-Received: by 2002:a05:622a:5149:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52df88afd04mr2504521cf.3.1787263222021; Thu, 20 Aug 2026
 15:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820200214.2865570-1-irogers@google.com> <20260820213757.2970316-1-irogers@google.com>
 <20260820214746.98B771F000E9@smtp.kernel.org>
In-Reply-To: <20260820214746.98B771F000E9@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 20 Aug 2026 15:00:09 -0700
X-Gm-Features: AcwNN1Xa00RO2YL4RNduT3DuqpeMZyvCVDSXWwTpOp_CQqUAcPvThzOhh-X5BpQ
Message-ID: <CAP-5=fWRhOdjT+9wUqOy59Hz4fSZQgibanisytCy_3TNTN1ecg@mail.gmail.com>
Subject: Re: [PATCH v8] perf record: Fix unhandled POLLHUP on non_perf_event descriptors
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 2:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> > When processing POLLHUP on a non_perf_event control descriptor,
> > evlist__finalize_ctlfd() is invoked to finalize the setup, correctly
> > setting the core evlist's poll array file descriptor to -1. However,
> > this finalized teardown state is never propagated back to the
> > individual thread's local replica of the pollfd array.
> >
> > Consequently, on the next iteration of the main recording loop,
> > record__update_evlist_pollfd_from_thread() performs a strict
> > equivalence check between the core evlist's array and the thread's
> > localized poll array, detecting that the fd values no longer match.
> > This causes an immediate -EINVAL abort and a premature teardown.
> >
> > Fix the underlying logic within
> > record__update_evlist_pollfd_from_thread() to sustainably propagate
> > the finalized teardown statuses (-1) originating from the core evlist
> > back to the thread's localized poll structure. This correctly
> > maintains synchronization and entirely prevents the unhandled
> > index mismatch crashes.
> >
> > Additionally, add a unit test that explicitly validates that
> > fdarray__filter() preserves its invariants regarding
> > fdarray_flag__nonfilterable items to guard against regressions.
> >
> > Fixes: fb4751e79c45 ("perf record: Fix teardown hang on system-wide mul=
ti-threaded sessions")
> > Assisted-by: Gemini:gemini-3.1-pro
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Sashiko has reviewed this patch and found no issues. It looks great!

Random unnecessary comment: v6, v7 and v8 only differ by comments. The
comments were added to avoid hallucinations in the issues Sashiko was
seeing; I wasn't seeing the issue internally. This is the first time
I've encountered this problem.

Thanks,
Ian

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820213757.29=
70316-1-irogers@google.com?part=3D1
>
