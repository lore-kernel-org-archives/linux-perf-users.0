Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC301D90DF
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768629039; cv=pass; b=PXLuKOkR6XgJTGYnqQoQQzIn/8Od6hVmaAFVgNpvglcOEXYR4Iu61/JRfVHl7oAxTY+X5mlzLWgxeNCUyTu0kHJb+gBIu7fCHpyKoJ904PwaDgRDO411ZPe6dUMREJPD5pcandR3SKZUHVmlrnCSFJFtkZTZA/ASELJgNgHtfBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768629039; c=relaxed/simple;
	bh=aIz0L588XEsreUX86QuV9ZIyfcQwbm/vU+KYClBpZxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqRNHe97QqoG2h9QzuLiAvW9oSEYCAL//+gqIZ/DlUBv4qIWd7uXRkaVsu6BA/kEWTs6zshWE3CiB5mYfed95AJaSCTfKAjdvcyd/plEZF7CgF5CD8WyYRBr8fL7tLYrEBIRok+ZO3E+LaF/tHTq0jdXRJFtxbcip8JqCIP+wkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOdr/Mne; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOdr/Mne"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-121adc0f1e5so4393c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768629037; cv=none;
        d=google.com; s=arc-20240605;
        b=do2nkiXu6IEgisO2obx2+jXm5ZvCUnmYSj7QOlvb179QV0O4uUReSzwagn5lmw6v3n
         64b2rcqDRrePhEha6C/LttEKUU6oS8Ntj4GCAbQZUxHV4xjuvHCwCsSyJ1RyQ93jWU9L
         HTZRw9dkvh0RCxa4dQ3BbY1g6/6stRtJ50K0wXeyfqFfoiPjT/L6ANLQInuHg/qjDmwm
         U+TmP6jt3b++ufZMiHMznzEyY5b2VBBBlSvnTDqbMHMMv6c1/7O9du90FA2VYaicnZvi
         kG9Auc99n1dSn31N/yDAtIN0eJXfmSZASU8mSFENRd/h19XbaMmBCyXdfZQF7I2mrkYK
         Gj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aIz0L588XEsreUX86QuV9ZIyfcQwbm/vU+KYClBpZxQ=;
        fh=gjEThcTnOzv5ADGzqtoQOGoShqQo15ThPwhYv3OJwnw=;
        b=Mtx+XskZ1HvHUIP8yNyAQph56oG8xdxHFatanh85DMXpvizXVhKAuJ9Zop2F1ZqV+I
         CpkU9y2MaJc39ncHzCCKTeqHOWHE9rHKe8e2LotFHAcqL9JIrFqpiZzvx0xMoNL2uBcs
         L0YebNUZA6ZEqmbTJ5PXZTpW5BdtSWkYnEYlpCHbkIQhUmjC+p6c0HsRVnijrFQElYTM
         IMdTCHeolBnRcHOwbVi8jg9pSuv+ywzVeS/6Qr0Q5RYpMrFyUhjNYn6FW/2w8O9HwNSu
         qP/+h4YWUbrr78q0b+3tzAnrA+kiIhdD6xua3NwJxsvK/ptstZOkVGMcM4r0pYrlENQB
         +oDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768629037; x=1769233837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIz0L588XEsreUX86QuV9ZIyfcQwbm/vU+KYClBpZxQ=;
        b=cOdr/MnejPRM4B4ue+gP5CNjnVmheAEBFOVRQF1r8TpDKWYhtpa5ZF2/zu5IA5002m
         VfpV9WANuXjnKChdhFIgKY/qxbsFYTeRzwpdVrkX2G51mrnN+mlI9itJ+7volUoKV73T
         sQWsP8Piz3DKkoicXzSBV0bxBzQsPFeurokGGkIyQXwDZtUkZJxtKvBy1rVPn2Z8XHhB
         PZyvUHoNF3RgPaFCNa6gK2cihWYEBcSBqGlXcc7G//GMlm5Ni18W1ZrFpephsPlOCeDi
         XOKndB6XB7UeLnL1xzOB9zhIww5XaizqX8iNWkfL0lFT+60TRH5OUW1wF71BW6CB8oi+
         etww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768629037; x=1769233837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIz0L588XEsreUX86QuV9ZIyfcQwbm/vU+KYClBpZxQ=;
        b=sWPRxirTsz/0LJDdiAvGO/TMpp/ZUCSKpY/FO20D1MnLgpVEmSVI9jigtChFOG1iGC
         SXSs1V1AK9yaxZwtyFAy4+6FpJHiNpkjnvdNM4G1TizFJc9OjMCckyEk+tZntgXusDFs
         nELMJiRyeiVauGZ2cmnGOdCXngZsm8dO+1nqjVzn4UOCU05SyZ3bkWsSpiCTzCCFM6GI
         Zx4PB0KigmawVkX79PazyoGNu2YaogkTOmqLf84u2SwgastiiAgY53o75XjJUl8m7wvI
         ZwOIaxoGen6/w8wt6Gd/sFydmkGtCQPCvaW9MJkBva5Lf6J0ox3fDrYoeMNeTkDUciQV
         BxkA==
X-Forwarded-Encrypted: i=1; AJvYcCUDow1+rLQhCxD6cnlxeicyyZ+02jIRunsppJy3KN2x99wQcLYdF/caN23fU8X87NxR3lWrZS9U+azLGHXOb37L@vger.kernel.org
X-Gm-Message-State: AOJu0YzgbQkc5XQk3jqwq7dJwonyGqo7OENkSkuGXf2yc86aIod6GG0J
	WnXGl17x7DL13HIaihfRFy5LQfH4GaBQ+z/fszfmCNXtMU83cWRGbZE9hPgHHaOcbM+bFy/ycQ9
	agNdiCQ8RFG1IYClbGYlbKbQL8Un71iwU+8QjtThW
X-Gm-Gg: AY/fxX4SkErum67hBxAUeVGjG6JXrbXga9UKj0VBCK+aVZBkfwMTJMVqLhCoboXw/xP
	UOKX0WUIAoGdvO9NutH1ud5owvIrRqEopA2NwHLQgbdtaMgpZm7389QITkwl+vksNw/j90G2+h+
	+0IOnI+hYaOesJ8oFmYN2bi25HjOmnQSHaRL+3TYmCCqcWISe8gOAwIA4NW4iWMbv/b/SPlewJI
	prhc6UuPjdqpmf0ET1Do2j4J1VoyGk3WHzexM4SXKrqelvNwwC1Lx91dj2cCznNcpAXgxhG
X-Received: by 2002:a05:7022:4392:b0:120:5719:624d with SMTP id
 a92af1059eb24-12453d722e0mr72492c88.20.1768629036416; Fri, 16 Jan 2026
 21:50:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-19-dapeng1.mi@linux.intel.com> <CAP-5=fVk7+iGn+jhfE3a9iY_G1Gdph9Sh0RNco+745XQMfubLg@mail.gmail.com>
 <9d97e2f4-3971-4486-8689-ab50b06c3810@linux.intel.com> <CAP-5=fU+JeBqCNfKVR9O2cd0zzPO1bsYORtEBzeTeTpMLg4m5Q@mail.gmail.com>
 <0a99aaac-d51c-4c65-addd-5e366408a3f0@linux.intel.com> <CAP-5=fV_dbFzQ8_xHsduFytEq+6H0M0iPof0Krb0dBB+Bsd42g@mail.gmail.com>
 <3d95b037-e1c1-40db-b357-889c62c70221@linux.intel.com> <CAP-5=fW5g-_Owf2wWtXZwpbtTy9uns_pqr=BFumohHxWGU+i0Q@mail.gmail.com>
 <47014c3e-0fca-4248-9f23-09007f9ee95f@linux.intel.com> <CAP-5=fVbWp5bdnxrcA4XQPvFa2iYB3583C4DzOP7wA=oPqvcKQ@mail.gmail.com>
 <8b932ae4-5f65-454e-ae9e-0d9377a92254@linux.intel.com> <54c173b0-55f1-42d2-a43d-d6389d3fbfe3@linux.intel.com>
In-Reply-To: <54c173b0-55f1-42d2-a43d-d6389d3fbfe3@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 16 Jan 2026 21:50:24 -0800
X-Gm-Features: AZwV_QiZfw0VrjdUk1NsqVdrT6Y5DmX9u3nKb8XN4j58CTHB1qvuZ-OnaGA0TEE
Message-ID: <CAP-5=fV0iPapwbKX-rjbF86_WcZPji8opKNgO=r_kDSJB7T8XA@mail.gmail.com>
Subject: Re: [Patch v5 18/19] perf parse-regs: Support new SIMD sampling format
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 11:27=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
> Ian,
>
> I looked at these perf regs __weak helpers again, like
> arch__intr_reg_mask()/arch__user_reg_mask(). It could be really hard to
> eliminate these __weak helpers and convert them into a generic function
> like perf_reg_name(). All these __weak helpers are arch-dependent and
> usually need to call perf_event_open sysctrl to get the required register=
s
> mask. So even we convert them into a generic function, we still have no w=
ay
> to get the registers mask of a different arch, like get x86 registers mas=
k
> on arm machine. Another reason is that these __weak helpers may contain
> some arch-specific instructions. If we want to convert them into a genera=
l
> perf function like perf_reg_name(). It may cause building error since the=
se
> arch-specific instructions may not exist on the building machine.

Hi Dapeng,

There was already a patch to better support cross architecture
libdw-unwind-ing and I've just sent out a series to clean this up so
that this is achieved by having mapping functions between perf and
dwarf register names. The functions use the e_machine of the binary to
determine how to map, etc. The series is here:
https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.com/
and I think it can be the foundation for avoiding the weak functions.

I also noticed that I think we're sampling the XMM registers for dwarf
unwinding, but it seems unlikely the XMM registers will hold stack
frame information - so this is probably an x86 inefficiency.

Thanks,
Ian
