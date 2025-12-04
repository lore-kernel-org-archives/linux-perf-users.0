Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BFD22D9ED
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855961; cv=none; b=T7NyzvweOGMQVJphjJVZ72cJfC/pTi+J7NeIZCahZwPcGcfykRmawcF2I43XTdtiDlsZWi3c+z2uuV0X/WoIqRFks6XS51QYlOn/2Gb68z0Qnc6AFJ2CWQ+H5+j1WXoPgda7SH2Jo8NY58x7kxNKnUK8vJcQt1H5mUQZFzB8inA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855961; c=relaxed/simple;
	bh=Huo8GPzw1pi18AFv5FmiIW1yPfcWgWChMNbzSgtTxNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3gvudbWTiRWgAqBOB1X5HqT5nOc/rLbCKrb2pNdgJqZwAWfPc07QBwb9DOfwKSzCcB1kyu1LBRrT6rYt8mt0eCV16I9KKyjKkAUOeCGoYKSk40VqqebRM2gP9Aea2lpfqlKw67maCp/BQnLt7fZEa1SU9+gRBGH/af+hTYCLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ok+mxDX7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ok+mxDX7"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2ec756de0so80881085a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 05:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764855958; x=1765460758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BiNjOZmAVdmFCT/h0Fx8xqDnfwmtfIhKs7a0qrI0Rs=;
        b=Ok+mxDX7yySm1K7MAqT5RXdjD2IDb+6v/7yponfG+8agb/ohQ2Z32dhbovukQRDQmn
         nirGM0Tq32qVuXHGfkjYedUhPjLw1OeSS8N59F2joDZJwVbrMgKm6MRp0VO59t9m4QSi
         ghum16rzv2pFgYWlHXL2ejzR9IrBzlQNNxuabSyVHNed724OjermIboUgve49mcgzEtU
         uIjMPCCxr9h/lLcZGMhjYAVNFT7Zx9wEJnrw4rPyPltWoUtc7ROD/GhY9c9+5Hl5v70B
         Gy/iNV2XhqWB9m3K4satKDkOI8ziVG7U4NhqaRwnjqB97Y/oBIoAIexuKDhc/xP1HRdr
         6egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764855958; x=1765460758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BiNjOZmAVdmFCT/h0Fx8xqDnfwmtfIhKs7a0qrI0Rs=;
        b=HdXC4pinJTTTw5LAbKTion32R9J21YFbUY8Tbs0SJRPsjrg4hMcm9iFROsiIOgJghl
         C+HVYfHQ/xShhH0mVPKnyK0gt2jrZPyxvxBpdocekRmgmgbdyvehg5hGz5McWOhtWzue
         OUo2wsj3ErRijpE85gDTEmmZm9KILQg/UySSqxZwUUJsHEPN4xf9RW0DIL1uATPU9bJf
         jsxnREJEwwI4hwq3aC6HTzsCA7KAmkkn1zsIW91R6V3z/X0j9JKqErfQDT4ikJ2tSpxs
         sHqR+0Q09yPgH/2YhO6UMHVCNzpjtPC/qyafI8CBSYNkz8KWEPLXWmYvmbBVZhX7RLU5
         bFqA==
X-Forwarded-Encrypted: i=1; AJvYcCWFMM1zfGcatSWy4/c2a69J3KVccelwkC34dYn/DM5EvmQpE0CDDPzatJL4pW0+RfDsmHXLYDGWgCGhuccRMk4G@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKhP8EXqzLGuKGj6lU7S660+2za9vKkFZHbSDcoeNs4uIMxjI
	6TF/WbL+K9okFv80cRyvrPdYXC4gLEHFiD17zR/Ky1G3kT0F5qZKg9x73rhGzKeRtjfF16g9k6q
	cqn+NzQbfRevdHkpla4IIPJhdN6XW+PFAutYe3zpYDg==
X-Gm-Gg: ASbGnctgJDRBupQ5wYTaDV1vb1PWddAkFkgBUlv8AlGwN4H2sK1+YF1KHEQ17rmnYl2
	IBYqt9KU7bxLAvl3vgJ5c4NcvQrAYMHblN+bctkoQvhwaDSRaOVUtPSMAmgjb5oEWDCOl4OwQWP
	NYYxXvNmkiwVXowsdzyMazaLuT/3oTGIptP3UyU/YKj7JkCLVpSMmy2rHxAqIUMrwORY4RKTidQ
	FSediGg0EKNQoQsyjiSyoPJaM5Rizz4zD6fEmdo1O9YVVuSXISw/U1RxE3Jz450QcOy3wZi0EoJ
	6JRIHigPMLX2umsjtC67+2kG2rd5
X-Google-Smtp-Source: AGHT+IF/TeSZNNywvIRUljAsJ0vS8hh9ONjlM/mrinOWxQwCICFrieYSQl60nuXiOfIxLqeEfqqlcVfgiDzyNM1AfYM=
X-Received: by 2002:a05:620a:bc6:b0:8a9:ef98:6835 with SMTP id
 af79cd13be357-8b618158045mr347919285a.33.1764855957706; Thu, 04 Dec 2025
 05:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-4-22ecbbf8007c@linaro.org>
 <20251202114300.GV724103@e132581.arm.com> <53b24702-eb3b-4e08-bca3-70402eaf4db5@linaro.org>
 <96c54895-cebe-4247-86e6-d41b8be0dd40@linaro.org>
In-Reply-To: <96c54895-cebe-4247-86e6-d41b8be0dd40@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 4 Dec 2025 13:45:46 +0000
X-Gm-Features: AWmQ_blxXenv19pw3rr9VLrADJwMIARDaOtETNn7Wt5gmB_nqIfN80W4UUwmDoQ
Message-ID: <CAJ9a7Vgn+HBSO0d3s-x+vjqk3Zfm2shpW1di12_OEZVSN6S0yw@mail.gmail.com>
Subject: Re: [PATCH 4/7] perf cs-etm: Don't use hard coded config bits when
 setting up ETMCR
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 4 Dec 2025 at 10:55, James Clark <james.clark@linaro.org> wrote:
>
>
>
> On 02/12/2025 11:53 am, James Clark wrote:
> >
> >
> > On 02/12/2025 11:43 am, Leo Yan wrote:
> >> On Mon, Dec 01, 2025 at 04:41:07PM +0000, Coresight ML wrote:
> >>
> >> [...]
> >>
> >>> @@ -746,7 +779,7 @@ static void cs_etm_get_metadata(struct perf_cpu
> >>> cpu, u32 *offset,
> >>>       case CS_ETMV3:
> >>>           magic = __perf_cs_etmv3_magic;
> >>>           /* Get configuration register */
> >>> -        info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
> >>> +        info->priv[*offset + CS_ETM_ETMCR] = cs_etm_guess_etmcr(itr);
> >>
> >> I still think cs_etm_get_config() is better than cs_etm_guess_etmcr().
> >>
> >> For ETMv3, we directly pass CONFIG to the kernel, and after validation
> >> in the dirver, then the value will be set to ETMCR.  If we already know
> >> the config value is consistent between user space and kernel, why
>
> One other note is that since moving the timestamp field, this is no
> longer true either. The value in attr.config isn't directly put into ETMCR.
>
> >> introduce a redundant "guess" operation here?
> >>
> >> Thanks,
> >> Leo
> >
> > Because userspace doesn't always come up with the same value as the
> > driver. For example right now in ETM3, ETMCR_RETURN_STACK isn't set
> > depending on certain conditions that userspace doesn't know about.  ETM4
> > has the same for TRCCONFIGR_RS and maybe some others. In the future,
> > other versions of the driver could do different things as long as we
> > don't break decoding.
> >
> > I didn't want the function name to imply it was doing something it
> > wasn't as that confused me a little bit. It's definitely not "getting"
> > the value. Maybe "guess" isn't the best it could be, but it's not far off.
> >
>

Perhaps cs_etm_synth_etmcr()? We cannot read it directly as it has not
been set at the time of creating these headers. (unlike the sets of
static read only IDR regs that we do read).

When in perf mode the only configuration bits set in the ConfigR for
either ETM3 or 4 are those generated or implied by parameters on the
perf command line.
This info has to pass from perf to the driver somehow. Evidently many
years ago, when only ETMv3/PTM existed the easy way was perf.config ==
etm.configr, now that is no longer feasible.
As long as perf and the drivers interpret the command line attributes
in the same way - all is well.

As James says, the actual configr can differ from the synth one - the
key is the bits that control the trace format - e.g. cyclecounts,
rather than trace filtering e.g. userspace/kernel that affects the
drivers configr but not the synthesized value in perf.
Decode cares about format, not about filtering. Additionally some
things - like return-stack are implementation dependent - optional on
PTM, not at all on ETMv3. If the trace unit does not support it then
the drivers ignore this. the only effect on the trace output is less
compression if retstack cannot be used.

Generally decode needs to know about things that affect format and
function, rather than filtering.

Mike
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
