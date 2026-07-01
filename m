Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6937A4BC
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927885; cv=pass; b=sbVBda4m7IA+FICsnPNfIAwcqhCUEYqhWNTrwGY1CW9xwPssYvqg1Mfm0F6GYrufz1waxzbAM6fzImnL3VWiP2a57W9UvCk7qaSv4u/SNnCkwU7uzdYSs8T2jysM9DGf3a8DzJXrYJFQgw4fwxdLOo1mbyAJmkirvRk7B1du4vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927885; c=relaxed/simple;
	bh=yoHUY1HPmlvk2DoI2QSvN4UxeuihQOz/3mG/g9FTO7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKKEbKIMtgWLW7fJjSzR7pUpLYiO2CkS49+cmpMqMBxhNJV9fki4RgtYsr+i7TMY+3yUIoNL8u5unoshA+s6+l9EGDuWwgHF2S7gwTfTMiBV0pJZkGyoMd2e1GlzN+0B9DjEcYuU0PbEgaP6vDGcyklrvsB+9npX165cmSvTqJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXIeQpx6; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXIeQpx6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c81db32393so88805ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jul 2026 10:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782927882; cv=none;
        d=google.com; s=arc-20260327;
        b=lJK/+gaiJrPs/KnZNsj2Ob/RRXupgISrExAH6VWSlO03m404VfgTngDCIAyNfN15CP
         b1ikOTA/rkfxsw4KUVQ9Mtru2r5/CYRjyAf5BBvL7gbUDYnr3PjLgpjdbBqrP6u2TF8W
         njpyUg0woqYhj3pfbZhiJKeagLx+SiZ1V85x4n12pqr6BJ3N+TqBUjtIbXk7Porn59b9
         GgtBn1liN2cTMLHgglJX+DhBE5VT8B5jRACtTen5h6UprnMHUsSzPm69AQZh4zSvjsC3
         Z5itGSXaGGrpG7aP4dgI3XvkrzDY5eFva6QclCl+X8ZnDRvvYy3IUfOsUJS9QhAEURns
         tdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3KB3W8igbPhJZR6fsRkWP2Fgao3oonwJVqpaQObUCc=;
        fh=IYcfgqVMkkkTgJNze4PaSeQDcSt6YzwpVQgvHG7AeUo=;
        b=GIJ33PCpb7fKR3TJrwws0GE8ZcT25OXNhvSgf0LD+SafBhiI87DC/QRiqchfgvkZ21
         X75w1oz5SWBZdRom9XFygyapQesdWhQqK2b3n264+Q8Z6pz9RpL3ScK/uj6bFPlb1ZQN
         UN4tXIGeKDKv1eom25bh3XPnZWiBEMn6wzKLZ+zK4OSO0/PFrWElJtlLbbhLkrC54bV8
         iRmxnbuSLswIDkXo5oh+nQytT9MAhcWLuoZo7952waSBxyxx16C9FxG14kCU4oAMznHV
         cRuyeFYIQLuwIBfHd00Q09+9byH8auOfytmLs1xO/PxaYU2oSQHLnb+CbbZFtmhTcmC4
         nUFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782927882; x=1783532682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3KB3W8igbPhJZR6fsRkWP2Fgao3oonwJVqpaQObUCc=;
        b=aXIeQpx6AI6RnYotHUoqUVB1Xnctiu7un2FeCrJlyqQociDQ7xgiGuDjJ4yVfjPQbq
         9M3CemF/8AuDZ1zvsU9mEjVVB8iMaRyy1171HvRVUbUq3VdpuA7T5q0pqZzv7iniZKtk
         +UDWkIMZnSFZZJKZU0ufyYPDn4mjHW6QT/ifRGDEUIvqImEOkHzt//WOwV+Y2OeVt5GV
         rgXdSWYchGfe3zfNYSpC3KI8p+rErYXIfiFxdxDquC3ex3g7ANkVdmSZA0L4g5iBpsms
         yW4FuwOhPqVpX848SeXBNkBqQq+CMSdd4gJn/PcD6NNtLPI//qOBpms9qgrzUkfvoLRC
         daxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782927882; x=1783532682;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3KB3W8igbPhJZR6fsRkWP2Fgao3oonwJVqpaQObUCc=;
        b=MJa1ULuQZzM28rvQ+gs3o0kX6SZNB54BYGaLHYNA3xszRx9TaHnA4SL+nYLm1flKea
         f6Wiq3gTNxZ9TLmBBD2bfRrjx4Mci0G2o/EM4hopLau6VcRzFNjAkaPktFxnGWurmbgR
         d3d+X2tbll93ZdY3tA1jYQOagiC0icwYDTtB8ovGNHgLoYQZI1pXGKv61D961LROkz5x
         chNMcZHR67RjTN23kYBT51O53lNL1aYvm+BIlobTX/OUT1GtO4x1x8HC/nz5X6FdtPa/
         aJ6xGcknkQ1fzLPW8B3tIaNY1H4IA8faOx6wknZSGw20FmwjflReSMbV6tZyvrJTousR
         xJJw==
X-Forwarded-Encrypted: i=1; AHgh+RqYT85aQhd8chytzbEpGEjETYZulKj/mnJMG69k5IBfyUdsNXafd4v10UKpoUjkQvsx6dKBgroJMoKkqxZKZzZQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6CKsr3amAxgDpDnmqsvBXlWcdRTj1LgW+jwSBN74AFKKjBNSM
	BwvCl5ZKE5sQyYz6z9iMG8r84jnlz1Ruu6GxPNBL/yhLqkH/612byIlyu2eLFhyf2IOLXwMU1OJ
	ohy287DijAy/dSifbfAjL0rwg3yzAp3H75x0w2cnO
X-Gm-Gg: AfdE7cnaLIM5eVz2S0QC46PTZN3bq6wPdKMeYVEU6K8oHvHaruDd9bSb+kmhKwrIIkW
	6f9bAtRnm/hG9dPYARi5ppu6JwitVTvCQwFeOqLCVQ4AYDUD3UtNF2PgOf5ekrPiAiIAy93VolK
	B+GMkb87vy0oIjFRa88ytXBWkOZuFcx+0gaiW7Xe40gycVkwkLomP4MHXbTVDLjJPAkpIenQcze
	ngVuy2wGBQJWhHcbWp5nbCAfSVoV8saLJbwqapcd/1GjB+u2BvdDJtKUic7IPpvMa20GhPCg9eg
	7blpKhh8
X-Received: by 2002:a17:903:1c7:b0:2b7:b03d:9dce with SMTP id
 d9443c01a7336-2ca7092e3abmr2685955ad.18.1782927881605; Wed, 01 Jul 2026
 10:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-19-7909f863a645@meta.com>
In-Reply-To: <20260701-counter_delegation-v8-19-7909f863a645@meta.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Jul 2026 10:44:29 -0700
X-Gm-Features: AVVi8CfVI0-HeGb5BzxacOi52xTnZf0837ZLQ1Li6xufzgI5Rfn0UuYpoo0nJUs
Message-ID: <CAP-5=fX1wR0tKyTiLjpK5JKWUP8j=E4meaPG1eyzTwj1XuKmFw@mail.gmail.com>
Subject: Re: [PATCH v8 19/22] tools/perf: Support event code for arch standard events
To: Atish Patra <atish.patra@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 1:48=E2=80=AFAM Atish Patra <atish.patra@linux.dev> =
wrote:
>
> From: Atish Patra <atishp@rivosinc.com>
>
> RISC-V relies on the event encoding from the json file. That includes
> arch standard events. If event code is present, event is already updated
> with correct encoding. No need to update it again which results in losing
> the event encoding.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/riscv/arch-standard.json | 10 ++++++++++
>  tools/perf/pmu-events/jevents.py                    |  9 ++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/riscv/arch-standard.json b/tools/=
perf/pmu-events/arch/riscv/arch-standard.json
> new file mode 100644
> index 000000000000..96e21f088558
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/arch-standard.json
> @@ -0,0 +1,10 @@
> +[
> +  {
> +    "EventName": "cycles",
> +    "BriefDescription": "cycle executed"
> +  },
> +  {
> +    "EventName": "instructions",
> +    "BriefDescription": "instruction retired"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 3a1bcdcdc685..0cf9d26315b3 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -413,7 +413,14 @@ class JsonEvent:
>          self.long_desc =3D None
>      if arch_std:
>        if arch_std.lower() in _arch_std_events:
> -        event =3D _arch_std_events[arch_std.lower()].event
> +        # Inherit the arch-standard encoding only if this event defines =
no
> +        # explicit encoding of its own. Events with explicit EventCode,
> +        # ConfigCode, etc. may carry alternate encodings and appended mo=
difiers
> +        # that must survive.
> +        if ('EventCode' not in jd and 'ExtSel' not in jd and
> +            configcode is None and eventidcode is None and
> +            legacy_hw_config is None and legacy_cache_config is None):
> +          event =3D _arch_std_events[arch_std.lower()].event
>          # Copy from the architecture standard event to self for undefine=
d fields.
>          for attr, value in _arch_std_events[arch_std.lower()].__dict__.i=
tems():
>            if hasattr(self, attr) and not getattr(self, attr):
>
> --
> 2.53.0-Meta
>
