Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB5743CED3
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501450; cv=pass; b=SrgN3T3spZOHaaKVdYv4LLmKuEhtbtC5sF9CF3TuO5zLYA7aZXVx5i8Hi+/P247zMEX3XZew9AFYJ2/uyFQPMMTpC4EhQgxUmWTjEQp8e3daCQenxKqp2Vw/8HElGXdwSV6hrzxKoPh7gaPIt65dGR2TDdiCeHN2SCFYMufsN50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501450; c=relaxed/simple;
	bh=v3cZtuli/IkFLtuAwsS4sr/0dZpRBwB0bHBS46rntHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPZS7HInxHWqT2C70JQFGpJufnQLB+MC6LK5vaSPN1yZdHeoIriRKabaNQ+2PqM1cbAnegx0wsMEcsEr26jZRiXoC6MvHHfccY4M15HjbipjUlBsrzyuOQ1n7QhH6g8XB38NUL0thrfK4FxbgNMc4WjGOJfwrHph4JyDYoyV1B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDua7GV0; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDua7GV0"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c8d0945b3so5096c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 15:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777501445; cv=none;
        d=google.com; s=arc-20240605;
        b=KIwuaUJr6q9UvEU+0Ylf+OOTHkWHZ8WHtQ206iUAlLUzeh1ISMg6kHR2/tReuEj4G8
         UJZXZSgH/Klf+JaQQ32NCsDlr23PCTEfsJJPib44HS+PIjjKk/RSmiIFk5SWnVUhvNF5
         /tVfJERNNc+ODDtbLMDrTI3+bFTK7Dxae/YCZdJhQBybGW+Rr0/wYbTgOrBeKD0ONyOM
         4+YX3ZpWg3yLK2KtDuhRBRST0We0hP+xZyj6arlgXlN6rKS7h5ehJaxekDran36EIj+v
         20ojv0bXSiGROLORvTUY1joBTCdfo07ZPOrTLfvxAx86R4NeX7cmJ2OzdzLKPs1l2Teq
         nCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1AO15Q+woWKMT6khRU7blgcDAFE7/nQooeNgGMR7yxQ=;
        fh=MjabDo9EnC0l/9ESpPcDAQLtR4wmfMBTUtgJD0VcaGc=;
        b=Alh9Py2Lh6jkSUHJRObXJEi2FJ+JK8MzGGupOujxoFuIxi48uu7XcJxu9u3xm5mAOv
         CKirpcDcGxyVbMJlWNux2/stQJXBqLg/qHv3VVhbp2g/MJ7jUP12BypXIS5NsdQ1TIj7
         Dc7a2Bc/cJbnRq4QSBKvAlKluT+p2nBcxYXfwBgMMmfeREsiOyJheQC6fRlkTU0ndK/K
         iLL2QySrQb5F4wh99Thjc6tIjRgINWwUIlxELlsFDeualiFxnSm/pqrh1veNRcQBxqq5
         tuYyF012Ur1RFOCMuptKkA9Yb1pjH9/s2FSuYY0QWsCxAZRFR24YEYU72JbWzSnQeFIF
         37hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777501445; x=1778106245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AO15Q+woWKMT6khRU7blgcDAFE7/nQooeNgGMR7yxQ=;
        b=NDua7GV0lUgSjOJZeq9QBY8zE/BXpb6yCwIy791zPTb/5pkbEDmFrkh0MSynRtb318
         1bV2qjfZ2+O/EHXQGQxHEoPVVCKrL0Is3s/YnP8A8yvZZ8zpAWXFGB7noo4CTSBHKAjQ
         /3RvmyTK1oTdv3z9/ffkqrazGqQbGrlYHCDeXi1hYl0XADkxNDkH2HwO1RiIwSortNpi
         9Afy9TrCuYRB8rqYYbATlDsdwrNcPGnu9kkd31TjwRjtl8gDDFpWzL+9exvI/mj3+an1
         KGeEIN8qRReUUrTyYjoSA1uetCUJmJtLuR2cAL6LwQ6rIfDR+fbFdLRpyU+NTOzPz8fH
         HtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777501445; x=1778106245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1AO15Q+woWKMT6khRU7blgcDAFE7/nQooeNgGMR7yxQ=;
        b=mOblrbCwZib32aCi0o7ItwRtqjDINabLc8ZBaOcADiWYWMLiEBCHZTxEovNK+N/vlt
         nMLZUdJ6I9vTVQmtyv9zUfALdrOhnSuhoQT67qcGSZSD3kfarkJyibSMFvSAckPrqYc+
         34n7wPQPBEYU5lJgaUdTR1+0SRXdZQtpRR/x8ECan7y8arm6oP99cAD0lDA6UimsIGZf
         DPX/yaJQ/lmOw1ovk6R2ATPUEUVHFxnVJnEtQ8XV4bkkrRBs5woPSB/dJbw5X0mA203G
         blZiOXVbjpGa7NeNP8c+Jlg3AZhJsdv9LrBGDrIKsOneAWlsS7BJDQcaSntJ274/1MJf
         IHFA==
X-Forwarded-Encrypted: i=1; AFNElJ+cTPfQ8FxkNOhilEoq17pWnuXEr//cUFqsRMqLBQ2xC4ETZMdj8ZBAwHaKXRy5DLG24NwnVhCmg7EI5SwnH+3S@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsFMJnPjpFIX5w4dEhbMbCXagUaHaXxdhDONcB47n2ecagT5S
	boXPW+4OIhzgXia8sQKL+QWUzOiwB4t7qc7CJLmmK2rYu7d1ZLnG8A0VK4tjqPH/onmgTxrA/f0
	ts0tEXznM1oo0jGznMt0Da1hPWXYogqNtx15cR05k
X-Gm-Gg: AeBDiesFvy1GObEuiGSwmei2Nk5bVNqetGy6SxY1JEjTYD2Myb+K5ZDixzb+LmtLLpy
	dEVcbabTdRmH9iitZJz9sstKrXz/QxPr5KVOCqm6PGikE5ByksAMFLQvO/TP3gYvwyYD3NI2EqT
	iuG4YMn3Qlj9IUzJ51gXK8Opa72AzYCu8TUDMw6z7wgEuUkJUS5eGD70kijaSCySFsz7KoImYjv
	He6XFx4+vIEp/SsP8w3zGm+GFHO8Lb+YRIIRz+xGH6kIp+iPskrN9rd6HOP+9xum0KBcNFSpEnH
	+MyBfpt+T4+t5DjYFqAt/U4Gk0VQOFf2DqumdRYORZu4OtsAJkvY4jrMLDoGUF0sjIj3HA==
X-Received: by 2002:a05:7022:6290:b0:12c:4673:7faa with SMTP id
 a92af1059eb24-12de9e34e10mr102894c88.6.1777501444779; Wed, 29 Apr 2026
 15:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
 <adv8Ka16pvgVkm8R@google.com> <CAP-5=fVc-Ac09cnXYPUVcNwzHOqFod0v=-YjjDf_oVHvM7cHDw@mail.gmail.com>
 <ad0cfz-gUKea5bI8@google.com> <CAP-5=fVs9vhofGdgE6MjAY6QND=VvfEmj1j8jz5ytC5ehAwYog@mail.gmail.com>
 <ad1P8ebyCyfKwXH6@google.com> <CAP-5=fWC7JT4mn-JwBpZ6YvUm4qBFp=wOb+bOj8AM79gxHK0_w@mail.gmail.com>
 <ad3VxtQSL8ClGiEQ@google.com>
In-Reply-To: <ad3VxtQSL8ClGiEQ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Apr 2026 15:23:52 -0700
X-Gm-Features: AVHnY4JqNNUCdmwnnfoRsBKc4JxUfT3hiquCVcZSiQzP68caCpYoAyzUf_FwsyY
Message-ID: <CAP-5=fXgkKwAOChOY026AEcmqr3Pdk1hhAgR6UoBLZN8mkXV7g@mail.gmail.com>
Subject: Re: [PATCH v10 00/29] perf tool: Add evsel to perf_sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 10:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Apr 13, 2026 at 01:55:39PM -0700, Ian Rogers wrote:
> > On Mon, Apr 13, 2026 at 1:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Mon, Apr 13, 2026 at 09:57:02AM -0700, Ian Rogers wrote:
> > > > On Mon, Apr 13, 2026 at 9:40=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > On Sun, Apr 12, 2026 at 05:52:57PM -0700, Ian Rogers wrote:
> > > > > > On Sun, Apr 12, 2026 at 1:10=E2=80=AFPM Namhyung Kim <namhyung@=
kernel.org> wrote:
> > > [SNIP]
> > > > > > > I've picked the first 23 patches to tmp.perf-tools-next as th=
e rest
> > > > > > > still has some issues.  Also I've touched some commits to eit=
her remove
> > > > > > > some parts or split them into separate commits.
> > > > > > >
> > > > > > > Please take a look.
> > > > > >
> > > > > > Hi Namhyung,
> > > > > >
> > > > > > thanks for doing this but I've done a similar clean up. To tota=
lly
> > > > > > separate the evsel refactoring from the rest of the changes, to=
 fix
> > > > > > the address sanitizer issues with kwork, etc. I'll incorporate =
your
> > > > > > changes and then resend the series.
> > > > >
> > > > > Thanks, I'd like to merge what's in the tmp.perf-tools-next unles=
s
> > > > > there's a serious mistake.  You can rebase the rest changes on to=
p.
> > > >
> > > > I'd drop what's in tmp.perf-tools-next. Otherwise we're putting fix=
es
> > > > on top of fixes. Looking at v12 the sashiko issues are all minor an=
d
> > > > the progression of the patches is more granular and natural.
> > >
> > > The goal is to reduce the amount of work (including review) during th=
e
> > > merge window.  Also I don't think there are many fixes in the tmp
> > > branch (have you looked at it?).  I think it's ok to add fixes on top
> > > in this case but I can drop non-conversion patches if you want.
> >
> > While I'm glad the patches are landing, since the changes depending on
> > the refactor haven't been posted and won't make the 7.1 merge window,
> > I don't think there's a huge rush to land this series. That said, I
> > think v12 is in a good place regarding both the shape of the patches
> > and Sashiko happiness.
>
> Ok, then I'll drop the whole patches in the tmp.perf-tools-next except
> for the first one for a typo fix.  The v12 will aim to the 7.2 cycle.

Should I repost this series for perf-tools-next targeting 7.2? A merge
conflict will occur with the Python and perf script changes that are
out for review, the conflict is limited only to the Python API.

Thanks,
Ian

> Thanks,
> Namhyung
>
