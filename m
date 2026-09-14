Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05A3F327D
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417835; cv=pass; b=rLZkHPwQt5EL3kIsOloZVwBitvagiJWLVUX47ESgJkSI9B2UEwowekTaji4A8C4hzEcFXZwbFwfbwatg9uCoWTes4H4v+QNoI68s/KAy+Pp2Gn3wIEmYyKD0RRsI+p8ZGun8z7eVtVABeyTudnLGCQqeW2OD8eqYz+i9JyehHw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417835; c=relaxed/simple;
	bh=opZ5FQNxeM2C8NmiRIe2HmlN0KB1ZB6y8OkMspxXydo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlZhzyiq7jIfDTaG+KeFLneAndOPZPU6JIY+RXuBA2EHrNWFktdvLGl7MnnGQbSvRStxER7lajxm6fVCMcKJOeQxQ8Z3jN32NvKTS6OWOr6/Vneu8H/JHeAVCDG/UxBjiI7kkwzQA8a69MhmgJHnxC369cIHZ9PWfrGuW9wH6n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lnU0fZb0; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnU0fZb0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so3645373a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 13:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789417834; cv=none;
        d=google.com; s=arc-20260327;
        b=Er6JQuf9q4tpzT5fvPNTjtGrzwp/V/CKNDXeGlCez7v8v+00GusIG1Gsyz9EW/FY15
         pMHBBpbLft/oE4cTECuXv/NlwVj477yZWcHKu+bCFDZIgushiYmB6YF6gP+Oos6eLujd
         6iuSUi+iXdPUxQSUDY//v7f/+3E3y/VIv+B0jhPadvjJcZ1/ANEb6pd/XxsjDfQFFfmo
         mU1BTtxzg+a5Yn1LFNZfoKIiJhrZQd8+nvEd/HDXTanTZp4sDoQ4ou3WKOZFd0wtQHtL
         VJw5mWvduTU2vKZjy0Guitus1OgYV17zFIIBHutCL6VCC5LKa5Xs+jkwNLnuh0IEFnib
         vwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=prIEjBDLAs06F0EneFKWDajp1ELDGRyxy8dsJdsmLTY=;
        fh=XPPxviagqSwuHbIREIlyJ6ObBvHh7Yr0mYAD4lkQBhM=;
        b=Z9ckzrFKxmnsYChaQ4hi0f/C8bMZ7IsvXi9r4WQaDmRHRFvC0x8TWtBKHhAMt1foAT
         wIo6wVuuIC44u5ipVNXoDbvPKGwXQz5jzmYQrU9GzdxKqgm/GzZhdaSP34feVWcGI5gX
         PJJ1+0qwfudlelEq7Hr1Cq0W6+RfqW9ChmVhX0Br9AAoYcUmUpka6kOu96nsdv5dTHm/
         JysexxNNnyQTBYm8BkD97KCjyDAjXLOY2zFCEgjky33N0Sk6Fgp+LTh/xIWp5jbm0z0h
         ad1kYXrHFLdUPBtgfW7oIoG9tPQaCPJXzn6ZluCgPGghclUjnvCzdEB4pLRUq9y5iGIu
         UNuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789417834; x=1790022634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prIEjBDLAs06F0EneFKWDajp1ELDGRyxy8dsJdsmLTY=;
        b=lnU0fZb03TA6lOvWAMEUT30N3E5JP0hPtmkdMA8k4Rew9HcuxA5FYABySAenCmR2zV
         HmHIiDM3cp42o6KdiMrRXx7msyVwte5eMZiwJCgkPb8WP8pOMpPvjAOAaGfSuMLER8vQ
         YNw98K5LGh+OWA8T2SuD2J1ZmDR/g78NgesFmthhGmE5O61Yx6PIQd8fbPh9qJMdOnnH
         9E9vMmW7Rtac96Ob2ttGEqYaSvTrjGyole0+Q8FCuuKZe+EISvRlDCSZReC4zClMUnfk
         fCYIGUEUwrFQymIhzEvj8T9Vi9f9Xo6Y1r62xM7vTOzLaQIVY7ZrhHFrmruGHjLkMDmE
         0uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789417834; x=1790022634;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prIEjBDLAs06F0EneFKWDajp1ELDGRyxy8dsJdsmLTY=;
        b=Wd4bnTv33uVe3DOucFbnz9x7Z8mZR/KVxR+Cq7VSjrm8Bo/oYzbTBDjY9Hm6MU/Mbl
         wRTyFsrGpj03DMKyuHHrvUT4EQSPQ42hDbJAkrUqTgqKeAl0EnZKCw7oLgLoFOSyk7mM
         7viegFmxpbyFX/gfCQjCfj/ueQ/TxXnNlKld11rkauh56pSviDoAdoqDe84qnJgRmUrm
         dKCEK5Qvr5Nx7oMYH3vFl6mQnwmNItgE2lZBdcgcWhQk5SOb5xdIbfRyEZS5XuGnuggA
         3ZdTRpbo0PJ+OsHacN22kT56WEl/f8VtTkSBY5koPumFq/SDwi90Dwtgwn4N1XRj6vwX
         KpJA==
X-Forwarded-Encrypted: i=1; AKwUvBzmLTfUXZJZ1qaRnWK6WuStLg0Qrel1vnYWpfwGOIJMlbUgdH8zfAKVMaOwU6tCCTTMv49t/Ql6ClHQt5X+/+Jv@vger.kernel.org
X-Gm-Message-State: AFuF++m0nObRbFRGV9oGw2P1/ePHEj6swpjJyfoJYeBcFhCmwW1QZ2+p
	wIZE5m+jUP3ibs6Y6K6RoDde+dsRLG/Vg4ipK+D4xgp3nP4ZbQ+qvfbXJpuTQD+MuuIa2wi9IlH
	H77jT+Aqi2/d8pJFEzxH7fW/9bUiyDQ+Esu2jg7m1
X-Gm-Gg: AYBFou1y7h5huW9l/01uOOHfq7MIebgocJjti1ucMAo/Lz5pvw3uQSkLHaGyhbBd6we
	U0K4nATd4iycL2agkCUJ86A4LM7W2JWTgark1rFxT8PDvJSBUYUyJDLPgh5JORlnecPHt/srOd/
	z8Ye79n9bcCfRbdbp5LAnH1LK024TgONv0hIUGfg0PGypKpOQ41zpvKshWr6mXF4pivCWEtCLc3
	3QN19woYH5vsoY0h2nIX+vjhjUW69oD31yRdccbTn7dLz2Iix89NOwmHKyKA3dX30eCcM2m2Sds
	FOlR4i2n1/2Y+6FSvq/PVu82Muv182caCGUVt2nUBWEPjDqNTNtVhQ==
X-Received: by 2002:a17:90b:4407:b0:38e:7168:281 with SMTP id
 98e67ed59e1d1-39debff3508mr7663269a91.10.1789417832827; Mon, 14 Sep 2026
 13:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602181349.3969429-1-ctshao@google.com> <20260602181349.3969429-2-ctshao@google.com>
 <CAP-5=fVwLO29i5SoLjOBhPqqUMTiy-z52Wm1mbeBF_941Jbx9Q@mail.gmail.com>
 <aihLa9ezNXXZm9mC@x1> <aqdRi7v_A03mY1tU@x2>
In-Reply-To: <aqdRi7v_A03mY1tU@x2>
From: Chun-Tse Shao <ctshao@google.com>
Date: Mon, 14 Sep 2026 13:29:56 -0700
X-Gm-Features: AcwNN1Uyj1nEMyc2YgqJq1SHKBkxWydcjwGfqjjonWswyP_b47BedhpVDIjpjbE
Message-ID: <CAJpZYjXT5rrqQuUTePV6WS5XafgtW1Z4FxMoT93uKjYdKU1VWw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] perf evsel: Find process with busy PMUs for EBUSY
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 6:44=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Jun 09, 2026 at 02:20:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Jun 09, 2026 at 08:58:03AM -0700, Ian Rogers wrote:
> > > On Tue, Jun 2, 2026 at 11:13=E2=80=AFAM Chun-Tse Shao <ctshao@google.=
com> wrote:
> > > >
> > > > It parses fdinfo with PMU type, comparing with the event which fail=
ed to
> > > > open, and report the processes causing EBUSY error.
> > > >
> > > > Testing cycles and intel_pt//
> > > >
> > > >   $ ./perf stat -e cycles &
> > > >   [1] 55569
> > > >   $ ./perf stat -e intel_pt// &
> > > >   [2] 55683
> > > >   $ ./perf stat -e intel_pt//
> > > >   Error:
> > > >   The PMU intel_pt counters are busy and in use by another process.
> > > >   Possible processes:
> > > >   55683 ./perf stat -e intel_pt//
> > > >
> > > > Only perf with intel_pt was reported.
> > > >
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > >
> > > Arnaldo, as the kernel piece of this landed (thanks Peter!) could we
> > > land the tool part too?
> >
> > Thanks for pointing this out to me, I'll do some housekeeping and
> > process this.
>
> I think this hasn't landed, I tried to find the userland part of v8 but
> didn't manage to, can you please point it to me?
>
> - Arnaldo

Hi Arnaldo,

Thanks for taking care this. The link to lkml for this userland part
is: https://lore.kernel.org/all/20260602181349.3969429-2-ctshao@google.com/

The kernel part
(https://lore.kernel.org/all/20260602181349.3969429-1-ctshao@google.com/)
was merged by Peter Zijlstra and I can see a tip-bot replied on it.

-CT
