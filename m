Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF33BB13F
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862624; cv=pass; b=AZbOzC0VaAEJcfc4YZ4JqmULZawdmGIcTb5XHzyfv5qV3/PnKp+DAXHHZ/M7Gse2hr+lmr4mvGalwkFQF6sA64g1t3Pwl4L788Fx62ts1KRt6lNaD1q2tx3b/6mdnFYtf+aeK/S3kFWtPqoq1Fap1EAlkYrWDJY+kqrVgmMPDDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862624; c=relaxed/simple;
	bh=CKmQZ7zzvw0j+f9uGPLbubfh2+YgIIFeP2hBvKRiGDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l21t7sNpJmTuaOsQ5hz9B4SJ++VZjxmGqHdoEdW85/kwcPUB1Ngqf5TMi7XDoF9cTGYt78d/LNydOIctMan8CIG+eiGTnBXn93j9cHtXXA1STIj9fmMxZoG2fiu4pAd97ntvrk98mC7yfRCMXPBrj05JbOQ2o3SGQ0bgJjDTCY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZtxcTHer; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtxcTHer"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1805ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 09:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778862622; cv=none;
        d=google.com; s=arc-20240605;
        b=frlH6k2PeqSXnRWSkZ2JdWnckKQnYoZzyKNnF2q71EMjbmF9uotfwbnra4Vphc7Sb2
         oclA/nk+rLIjtZp6DBkbu8+VGJkFwHdFByXDjD8DXfibgLBH5FBkdSn7CZzBpuo6EEcN
         Pr77+1/0iyxazj8T1ELuZFcQ69EHq3eajjMEll5RX7rNZzP2T8FbVZZds16kI3GmoAyz
         EMjjjRi85n+jp1DZTNWECmfuYjbmgZDRAaAkdmbfgm6/CZt0sqjPcpaiSyuUwI5h9kTa
         4enpiV5Nbxc4lIlfIq/GssZJjicDORS2va1zQawtc2OliFuChlN+OuwzfkmB07pMFv1p
         iBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8X36HUs6rqQl1PIy+2NqoP5v4KEcuNa4UBTx84v5R0=;
        fh=P6ScSdMWFvqFWwAfpkRB2a7A9wN91idnEh0n+HFr+8E=;
        b=MmvklvfHqDR1o1lif274ZC04chNc5s+YHiSdL3OYfuNLOqaC/cOQrWpixQy7WEuSPs
         yBUhTKwwPap6LZaOssUNRA1HbhLaassiuu3z6WFX8DzKeAq75FsMdW+Pdt6iF7ygY0RA
         fq/xZIhueG0I+NPjIGtJafbT13ugdoQOv+0J0qCNIVQOW1ZKnHMmpY883svxqRoxV5cC
         /dOg0TYLfUriTtyrWDoe11ZXwOzxDnizrgwEXSSU/3DrE8EWml/joaRikjK2TrUJYRk7
         6x3SgVVEisrx5DrZJijZkBp5tQ+9xGTutMuMwYiW4WslIX8VKXxKNruVkJGTL9crlUxU
         IUPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778862622; x=1779467422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8X36HUs6rqQl1PIy+2NqoP5v4KEcuNa4UBTx84v5R0=;
        b=ZtxcTHer4grj9h6+AxkBIA2jW9kXsWc0nxVe4/oyJvX+Nx3E34gfxtWxtoWcNerwlr
         dGwPUy4Nld4h5oXm6YWDRDOS+ti5hOPvahSPffYmFcCTtQvt4MEMP3WOcY3BDFMfF6tQ
         o6LTNZWhExtc4BRNm2kuQBX9pOen/s3f4UX8lxvwWL/fOiUR8EoIX99kSvjEpjZvtNSc
         kratxeTKusSF0F7xszx/+aE2Vjq+lyOEm3oXN9/fylXNGF7C6F++9m000r2HkaSBfgOS
         uRGY/+PEKUUqhdt6Ktq/qym5WdgwRfIts7FSq9w9nfNJey82Wsiuw+tNnUUBMmS5eGwc
         lP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862622; x=1779467422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8X36HUs6rqQl1PIy+2NqoP5v4KEcuNa4UBTx84v5R0=;
        b=LWWzh1QViQEc1QWNI5Gr89mpSIAcB8cvUasMYpXDG7q9d/4MrGMSmCFj03T8y9/Oev
         gHuTqgkptzg95NylrtnI2cL3k9033/FZRxzdSCc2106jnXgjjKburg5pM96L990kmRf3
         jiWGjawc2OX5L5enDtjw+1R7ExDXt83rdU3I9Jk9x6220vpnTtxcJQKehNo9wg8Yn79h
         kcKqXvcasAZgiEN4Jm5KFy7D4ps7SvFmlghvPmIe9uu5zMc2dJySX8n35TSGYUES2SHj
         Vm6FcYAH+YmvixXVxULETeVhq0w39A2MZfq602biPmkIOp2y9l8VDTXDVUVXbiJtzCki
         dyUg==
X-Forwarded-Encrypted: i=1; AFNElJ90ZxSFIJtD/oXMJLKtFtSxTFW9kEH46GT3GJy+8hgD47kuo1X74eG+A77hxQTUZS7/kzvk3PyoEqhEFOIT5+70@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Jkb1n9Cy7hlH81MgfbXaNVv17/wY8rxJBn4Sa9wG1L/C/G3p
	IEBOuwyvyKPb0CZ+lFH4oV/fzqHCbrRj8xS7CScPnclZOUKk8mX+hUAIBSvwxAiEjD1N0Mrf5z8
	IHifAEQ9M8HdmK/wIKmdCLVVpJ4T1/BJXhA/LJKAj
X-Gm-Gg: Acq92OFb43i2+YN8afyfNUu01sXjbWuqEjJ/bmsovK5JPR2Ni3pnz48j8L+rPSbYxAS
	mU5woCCNcndXTTwSRt5+P4dNsUzXLxlqIC5RqCsCrXVoRlQHBSCDODKLwRbjNw8rb5T+y1i5l7i
	L5uNOdJUb3OJYUrUJlGwZmgE/LLiwYY4J8H2vnBNODCI9iycxT37HKysSEUZXylbUQv2dYjeLfV
	LtVhFBvIgTca6G1xUTxiQryumv+c9a6PvyKxHcHlkA4Fa8KamtbCn04R71v4GbeVmdJsbIaDLi/
	Hyu04ZwGiOstWg27zeQ=
X-Received: by 2002:a17:903:3203:b0:2bd:907:2ce5 with SMTP id
 d9443c01a7336-2bd855b3f82mr2291875ad.7.1778862621458; Fri, 15 May 2026
 09:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413024805.1316480-1-irogers@google.com> <20260513233151.572332-1-irogers@google.com>
 <20260513233151.572332-2-irogers@google.com> <agZk-CCrLUMTyWE4@x1> <agcDOac0qbP1KZ4Y@x1>
In-Reply-To: <agcDOac0qbP1KZ4Y@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 09:30:08 -0700
X-Gm-Features: AVHnY4Jj3RombHh7dzSY677EqlEwmw-S-zqP0uGxlB6k_ARgnj2jPXbNAf5RD5M
Message-ID: <CAP-5=fUO67hKRV0C48uT5zF4uj6ptT+ApYE1jOitnJ=Af700=Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] perf unwind: Refactor get_entries to allow dynamic
 libdw/libunwind selection
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

On Fri, May 15, 2026 at 4:27=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, May 14, 2026 at 09:12:40PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, May 13, 2026 at 04:31:45PM -0700, Ian Rogers wrote:
>
> <SNIP>
>
> > > +++ b/tools/perf/util/unwind.h
>
> <SNIP>
>
> > > +static inline int libdw__get_entries(unwind_entry_cb_t cb __maybe_un=
used, void *arg __maybe_unused,
> > > +                                struct thread *thread __maybe_unused=
,
> > > +                                struct perf_sample *data __maybe_unu=
sed,
> > > +                                int max_stack __maybe_unused,
> > > +                                bool best_effort __maybe_unused)
> > > +{
> > > +   pr_err("Error: libdw dwarf unwinding not built into perf\n");
> > > +   return 0;
> > > +}
> > > +#endif
>
> I also addressed this local sashiko review comment:
>
> -------------------------------------------------------------------------
> Since unwinding is performed per-sample in the hot path, will using pr_er=
r()
> here cause console flooding if the user explicitly configures an unsuppor=
ted
> unwind style?
> Should this use pr_warning_once() instead, similar to the UNWIND_STYLE_UN=
KNOWN
> fallback behavior in unwind.c?
> -------------------------------------------------------------------------
>
> And in one other place, please ack,

Acked-by: Ian Rogers <irogers@google.com>

I think Sashiko is heavily biased toward warning about too much
printing due to how the kernel handles printk, log spam, etc. For perf
we have a problem that there's lots of verbose logging and logging
something just once may lose the warning. This is somewhat the
opposite problem to the kernel's. Do I care about the change that
much? Not really. If someone is having a bad time, perhaps it makes it
a little harder for them to know why but the priority is to not make
people have a bad time.

Thanks,
Ian

> - Arnaldo
>
> diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
> index 28db3e3b9b513401..69ba08afda792d17 100644
> --- a/tools/perf/util/unwind.h
> +++ b/tools/perf/util/unwind.h
> @@ -53,7 +53,7 @@ static inline int libdw__get_entries(unwind_entry_cb_t =
cb __maybe_unused, void *
>                                      int max_stack __maybe_unused,
>                                      bool best_effort __maybe_unused)
>  {
> -       pr_err("Error: libdw dwarf unwinding not built into perf\n");
> +       pr_warning_once("Error: libdw dwarf unwinding not built into perf=
\n");
>         return 0;
>  }
>  #endif
> @@ -81,7 +81,7 @@ static inline int libunwind__get_entries(unwind_entry_c=
b_t cb __maybe_unused,
>                                          int max_stack __maybe_unused,
>                                          bool best_effort __maybe_unused)
>  {
> -       pr_err("Error: libunwind dwarf unwinding not built into perf\n");
> +       pr_warning_once("Error: libunwind dwarf unwinding not built into =
perf\n");
>         return 0;
>  }
>
