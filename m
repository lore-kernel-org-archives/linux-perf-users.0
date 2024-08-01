Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4751A99C4
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525999; cv=none; b=eDWsWJ+/SVBvXe5q4CCloZ8IdyJWUUwmM4ITg16bq8g8LhSquX424KKnrtunaUDt88HTmz10Y3InmAhSsjdBHY89ZOxc9RBEDNqWK/yGrvt7tZ44SAD+3eLVdbDuiyMPDyWIqemeppkHOH2I3FjOJpLKNBDDuh8Ve6eg7KlgSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525999; c=relaxed/simple;
	bh=/Jl6PB4Wp3ANrgC68CItsuYKxii3v6mf1G+8fRnnZTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iiam2zFneI69zolg2fLTmhndzatsasB8o+vLUaNhGNf9VmOozxvExwXfhREWytZLm2LuO0DkME2ve7abKfhKg8aHcXoZjraxZ3nXtvJTUHgRyCDEodoTyE7zIyEzct8aKoHKi9H5QTqsAztvgjOhotfIGByVj4+F+V4WU7yKqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlNKZDGy; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlNKZDGy"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fee2bfd28so777691cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Aug 2024 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722525996; x=1723130796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJsisVlXsYheO37snVaNoupjzpA6f699hMvkHk44PW0=;
        b=HlNKZDGy2NMA6cFCJQIHJln4JOUhRG7G1krUj5XRXiGYi/tLztPlhD+Y0upMSmtr2D
         G2pGSx3F4y4s4eemlhBjSA0HRzK7uw0a70ih1z1Ll0pplUnTOsqdfeh7FrAPj64tYxfN
         Cc4TPvGhcxuLVOTja6hxbAavfvmB5cTUu7Zp+grkbT0BaPzJzwpIWSvBUDk2uAwFK6+2
         zRqhjzg/HCZWLrT5aDQ+nO+/Aq4TTJhpKoGEDy+koOT6uAPtxRfwJXYjaJVxYdg4FHmZ
         35GB5JrAPiDXWh4K8c2vTwOy913g5Ad1jG57r1cKZYPHYrDHfjqZDLfVWpPbPzb9z6N8
         Hz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525996; x=1723130796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJsisVlXsYheO37snVaNoupjzpA6f699hMvkHk44PW0=;
        b=BxSQZ3aonmofsuImIq8k72Sn8MSdtC1otGiwAx58pp2hDpwc1HD8cvDQ9bsr8K+UCa
         aO0emv68/tjJXrhx6lWV0mwZhu8EymbXuuDSC8neFtg/U5YddGP7a89jPbXoRI8LjVm/
         5bPkaI5EOtkfmcHNBqOnwoaq+u5xfZx83X2rWVE3yIXjz7XlWkXrE1zpwAg2dzOlVZM3
         fKsHzkATYz4A9ZlxGyqsLN5Xkl8g3ItDck0xsI76GzKvI4C/qjsjKDp6VIHYDgntGsFF
         jNic9v5l0htMras+yfbTTqj1AYOVaX/jjLP88jKLrc7e03Yk1HK5R/u4N0V+PFxE2ukj
         pV/g==
X-Forwarded-Encrypted: i=1; AJvYcCXwS1Hne0JnKkdDU8V2+WulyR5nO1sBOTFb+QiDfdMzDfJ7q2qFD/LH0RwtgDhC2c8Hy7+fkL3Y97X7YoJso1AYDqc70BiQS/D8FlZ7LsJwjg==
X-Gm-Message-State: AOJu0Ywv7r1vBu4tCPDuY7ZzVEwHcMJ8oBjrfBn0pvAkYXJ/KIscTi4Z
	IQUpxpj4ApuU3IdvbS8F6cmEG1/Dx7V5I53eoANslNj1LUm3HX07xDW3tspOTVm3sJkWleQIglO
	BbtJY+DbYLxbwZLcAZ5UqMrER6p/GtCcc8NzZ
X-Google-Smtp-Source: AGHT+IFMASjGXKSuF0FnLFzbAgMwMf9+e1XvKKegyCNSTZDeHUACfQPHE9S5FaA15pCyPsL9NbtKplB7rSftZhJoQzg=
X-Received: by 2002:ac8:7d8c:0:b0:447:d7ff:961d with SMTP id
 d75a77b69052e-45181e6e4f1mr2046151cf.9.1722525996159; Thu, 01 Aug 2024
 08:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719115018.27356-1-eric.lin@sifive.com> <20240729181927.1712841-1-atishp@rivosinc.com>
In-Reply-To: <20240729181927.1712841-1-atishp@rivosinc.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Aug 2024 08:26:24 -0700
Message-ID: <CAP-5=fUJh6zzpiFcYwxMjxk7O3eOZWTVvzOB_zt+twcbnZMYXA@mail.gmail.com>
Subject: Re: [v2] perf arch events: Fix duplicate RISC-V SBI firmware event name
To: Atish Patra <atishp@rivosinc.com>
Cc: eric.lin@sifive.com, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	peterlin@andestech.com, dminus@andestech.com, locus84@andestech.com, 
	jisheng.teoh@starfivetech.com, inochiama@outlook.com, n.shubin@yadro.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:19=E2=80=AFAM Atish Patra <atishp@rivosinc.com> =
wrote:
>
> > Currently, the RISC-V firmware JSON file has duplicate event name
> > "FW_SFENCE_VMA_RECEIVED". According to the RISC-V SBI PMU extension[1],
> > the event name should be "FW_SFENCE_VMA_ASID_SENT".
> >
> > Before this patch:
> > $ perf list
> >
> > firmware:
> >   fw_access_load
> >        [Load access trap event. Unit: cpu]
> >   fw_access_store
> >        [Store access trap event. Unit: cpu]
> > ....
> >  fw_set_timer
> >        [Set timer event. Unit: cpu]
> >   fw_sfence_vma_asid_received
> >        [Received SFENCE.VMA with ASID request from other HART event. Un=
it: cpu]
> >   fw_sfence_vma_received
> >        [Sent SFENCE.VMA with ASID request to other HART event. Unit: cp=
u]
> >
> > After this patch:
> > $ perf list
> >
> > firmware:
> >   fw_access_load
> >        [Load access trap event. Unit: cpu]
> >   fw_access_store
> >        [Store access trap event. Unit: cpu]
> > .....
> >   fw_set_timer
> >        [Set timer event. Unit: cpu]
> >   fw_sfence_vma_asid_received
> >        [Received SFENCE.VMA with ASID request from other HART event. Un=
it: cpu]
> >   fw_sfence_vma_asid_sent
> >        [Sent SFENCE.VMA with ASID request to other HART event. Unit: cp=
u]
> >   fw_sfence_vma_received
> >        [Received SFENCE.VMA request from other HART event. Unit: cpu]
> >
> > Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ex=
t-pmu.adoc#event-firmware-events-type-15 [1]
> > Fixes: 8f0dcb4e7364 ("perf arch events: riscv sbi firmware std event fi=
les")
> > Fixes: c4f769d4093d ("perf vendor events riscv: add Sifive U74 JSON fil=
e")
> > Fixes: acbf6de674ef ("perf vendor events riscv: Add StarFive Dubhe-80 J=
SON file")
> > Fixes: 7340c6df49df ("perf vendor events riscv: add T-HEAD C9xx JSON fi=
le")
> > Fixes: f5102e31c209 ("riscv: andes: Support specifying symbolic firmwar=
e and hardware raw event")
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > Reviewed-by: Nikita Shubin <n.shubin@yadro.com>
> > ---
> > Changes since V1:
> >  - Add "Fixes:" tag for every patch that copied firmware.json
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
