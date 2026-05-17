Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B63BB661
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038638; cv=pass; b=erQfAgvmpwoMZj7KkiDzqKswK6dBHMnkd6Fu3suG5l9zKk6GPAshcSTeZ6e3p3NxfDcc0j+5v1Fr6P01WJZh0MMkg+kz6lTbKmchuBKMO5UbMg+5lHe+FYPeHDOph35w1kIBpjO0xpy9knLXdr7WJeOA+S+kc5vOgOB4GS5tCV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038638; c=relaxed/simple;
	bh=4vPtRAi89OujlgDRmzZBBXuTp5YAF2vkzF23ocYWyKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrOGOcsXAToGkULYBddtFnFC3wlqsNWsv0pCEcg+e5TjQitv8Nngc3MRIaQnQvOt6IPW/6bLhpfLiJUNPMLNcJ7VfOHgyluIopZwkLlcL/ef7JZ/cj5qAGyL8+cx54IoDWKhwTvmymPWr20tmcwURoWqUGWwklYF+qoT2lnOCuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJsh90IP; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJsh90IP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so775ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 10:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779038637; cv=none;
        d=google.com; s=arc-20240605;
        b=O9QV3rDVc305iEwbvT9XO4tF6m/onID1nM7DANuPI3Igs109YlOfRBdk6Hib5l+WJR
         OMGrqobBFhw0EZNcjuvetHAhVpjnqoVoHFno7AtIWjRX8gWRFflqApzGNfVTYOsAOJHy
         EcMl5zO7hvYSyVulq+N04wnG2bF7wxmiFq+jWPrqFKrRXG7ZFAd/BgeOgQp9ZMnHcx36
         gDzoSbjkqta7K3qI9oTQdGSlyYSwLQjy59zEpYSJdq+ut7OmrWo0TobSns8mYc+sw5bx
         O0ePqkyy4mk+5AZ3ZWeThKxEkoR7tMYbcaVNC5QhsUt8fLamXez6B1bw1Vlec0xTUx1w
         Xdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SGJG9ixedY3dsifAWRpwM476JJR6wZkEpduvZ4yEvkg=;
        fh=RWqnzi62WiGe4gysa+cVpajx2eOOaY8tHcuxtlxXC8g=;
        b=Qg5BiyYAGxY1ptW6zsnwJgNY9Z5CWqKdL9CSYFL3IvgO8gC5yNGRf0o4a4G92DMOcz
         AcxzLKLoc7VPADrryasNfUwlYx3S9YZ8rEKu/imW6DZk9AxIPzO94njr5cYpdKzv8LVi
         9Cm+h53hgSAfEl3G0rIaCqUYiqxjU0wfA0rmfJi3c+0x4sXkWoi7X80DQxBcygFcUW9P
         FXGiWtRmtFcfPo3Fssn7qtZHNnMf0E8tx7mijY/KZtWh+05PAMi2I7IkwGxjARuWo1Of
         YubjatRrABUd26FigUtr2CzfsrOZEyLIv9M9phKoSd6RvV4S0tVJj/v/uOFF3R4oriRM
         qO0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779038637; x=1779643437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGJG9ixedY3dsifAWRpwM476JJR6wZkEpduvZ4yEvkg=;
        b=OJsh90IPYTqvCcH88kkl1Z/lEB6U6p92zj6x5xbJh1Ac9L5Bud1TMIl+uDn4PU7mb8
         cbVTvnVfWC6DQHCeFrqPnCwbw+R3ADlwQe+3O1pvKXo6JpOsuiW6hhKR2UY3HGdF8Q9g
         PZAp68H3XXHTEWWj8oY3kzFUvI/Mlboxr4MC9shCveVTIKvSmT1qqsdbK9VY6Om4T698
         8nYbtCEQnUVMhMAXmsFfJvdJRxNlfhl37+RxIr8JdxVDpKuxlc/zL1+tbFQapLjRNe/I
         d4YFNBwhgcdmfblK4ebnX/VIPKyucYp7Sh39v556ffUaq848XMVCQnz/DAA40sURmEkr
         Zebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779038637; x=1779643437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SGJG9ixedY3dsifAWRpwM476JJR6wZkEpduvZ4yEvkg=;
        b=CFVRmLfIYsygx8WQ2DrOGgG+vxD/aDKddMcINjlgXOCC1oy9qff1Trf4+CXQaL+Zae
         aZ+W0a2OpUkgDB1rQEn5qGZobP1j2I7wt/2HiwY8uoCrAb/orL6b9Qx418SPwuzetUSS
         HU3M7rOtokmOYScgW/r76Wn2VzRfLLu/mjO6ReHjmpSuUkrIZKTuivYwoxz1LU9T5BGN
         5N3YTo3crKZG48ffGhA+0m4pMG8wPb2NTIYoJwjROGnWWepruB6QjQf9uCsbWgPXm1fZ
         zP5goJjH/19THjhaRtpTcfZX2U+cbShrF+8IYhPcl9UtVB0HDYtsv4vrQgl7nvTO4G9v
         TCDw==
X-Forwarded-Encrypted: i=1; AFNElJ9wi8Sj4IjaCtP++/s6kafoa/exX8+Tdgk85k4F4GDL9/l/hu3Z+OYvvejOZ0dJMeP+OeyBU+jWfldJuTQM/mZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YwpClhtLYoKsK0mkZLhDe1ehjnk8O38hMth2zecVRTzkGP7zUW4
	mR38sRMKC2k/AVNmgrrvWX0tBXdC6oVGRny6FWSTjVlaHMvYaq/ea4AFIlKTgpPIqy2rcN/42iL
	HSpDSRf9pQKujqxORg+1QBR5FUcIsdfkP0itclCtG
X-Gm-Gg: Acq92OGjQoOFrcFdE8WZAIbmdbTtWuF+HwUEw1TwjoQo9ChtdyVJ9DkYngSrAzgGjBx
	bw71cZiuZNa6NywTR2Wya5vQ4hlo9NW75sPkRTd7P21CsifZ/IFTm1GxLEYGu+0CzvcmfFwsM7I
	BPCv4Xk+diekcaFo/GBF94Lp5JjsTaoqqEfsY5vGpAulrBuir1esFOoqAJ8zcVIp8eT12sPruPj
	WoWNvRo7tDjQVQ1WS1w2l8adVVf/gNUxSFuQpf+vkvO/PM0eft4xTvy1AMM8G6mW3Qgtc6sI4CQ
	exnZ3HMSvFk/TP8173c=
X-Received: by 2002:a17:902:d4c4:b0:2ae:80a3:98a9 with SMTP id
 d9443c01a7336-2bdb32c2d37mr1167585ad.11.1779038636024; Sun, 17 May 2026
 10:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413024805.1316480-1-irogers@google.com> <20260513233151.572332-1-irogers@google.com>
 <20260513233151.572332-5-irogers@google.com> <agdyluuau3wPQOtX@x1>
 <CAP-5=fUeGOSH1LO1oSbWnpmXfv_RzxfFE+YCQ07PC19gLHDEsA@mail.gmail.com> <ageGsOVhDDKnvQhQ@x1>
In-Reply-To: <ageGsOVhDDKnvQhQ@x1>
From: Ian Rogers <irogers@google.com>
Date: Sun, 17 May 2026 10:23:44 -0700
X-Gm-Features: AVHnY4JUTcrJTBzz5U7-VpKwbcc8eerSQ_000WG5_wnMHmZQGZGfdOC7RDHXMOQ
Message-ID: <CAP-5=fW9aJyt7VojbZqkiHdiFgEcofKHpYrd9BHMSAOLRkfApw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] perf unwind-libunwind: Make libunwind register
 reading cross platform
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, namhyung@kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Li Guan <guanli.oerv@isrc.iscas.ac.cn>, 
	9erthalion6@gmail.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	howardchu95@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org, 
	leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 1:48=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, May 15, 2026 at 12:38:48PM -0700, Ian Rogers wrote:
> > On Fri, May 15, 2026 at 12:23=E2=80=AFPM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
>
> > > +++ b/tools/perf/util/libunwind-arch/libunwind-ppc32.c
> > > @@ -23,6 +23,8 @@ int __get_perf_regnum_for_unw_regnum_ppc32(int unw_=
regnum __maybe_unused)
> > >                 return PERF_REG_POWERPC_CTR;
> > >         case UNW_PPC32_XER:
> > >                 return PERF_REG_POWERPC_XER;
> > > +       case UNW_PPC32_NIP:
> > > +               return PERF_REG_POWERPC_NIP;
> > >         default:
> > >                 pr_err("unwind: invalid reg id %d\n", unw_regnum);
> > >                 return -EINVAL;
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> > > Ok? It was the only issue found in this patch.
>
> > Looks good, the NIP is in the original code that I copied, so I don't
> > understand how I lost this, but good catch!
>
> What I have is in tmp.perf-tools-next, doing a container build now,
> still need to look at the other findings, but they seems either trivial
> or complaints about making  the build time more inneficient by not
> caching some feature tests, so I think I'll fix the trivial like I did
> in the above case (posting diffs to the list) and leave the build time
> for later so that we make progress.
>
> Will try to do this later today so that I publish it to perf-tools-next
> for it to soak a bit in linux-next.

This is great! Thank you Arnaldo!
Ian

> - Arnaldo
