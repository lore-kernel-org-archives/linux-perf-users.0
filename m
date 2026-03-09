Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FE53D4115
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071874; cv=pass; b=g3H1WjottUx8u67AQZsH3MWuAr3IT27pXhvBt2NiUUK4TpEBFAxxFTd0qrAZRchrIVmUp2SMC1FlaMe8+k5f1vjU/cClyHnMewTo7jK0P/oUcbw6OWPjvJ/9+ITZQIjZyheidDryxOOwqB+ryRYnFauFe6bpoaq2xOV6b+vTOzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071874; c=relaxed/simple;
	bh=RBtiBdsy3qpAJmgsvRfdfrPnsbf55v0o0OUVno+ugLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArjarCURza2F3GVtH55LKmajwhcOuqWAhNz1yJgOxlQ5pp3ihc8BjEBRWo7KvDHZfPiptLwILFxCNa/Vu95mDJ1j0O6ZqU0wV7cchAO5F2y2YkCdiz+0qZZicuoMBKYcg9RfXPCSUksClJlvUvpw6pYBVJsYbCha0ybwo2JNYdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q8b+W+Ui; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8b+W+Ui"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae3f822163so153795ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 08:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773071872; cv=none;
        d=google.com; s=arc-20240605;
        b=ftVNArTOlkx8ZaKnSVvFWiGsDZ55kS/hYsy0QaNuAZr3TY4AgxnHsz9r2q0UkmYeEt
         kJwC5K+lmqkCC+wVsoLPtyJWSuK7gvy1h3nHcU5FtoLMWTDgEcFsm/PcFe6vzGHIL0E7
         5nwtmSGUxreg+jiogycc87A/D5QES21nZvFs2gwQHv9dabeIQhuVv/RpwnwMrbBb0UV+
         MdOrhqTCTT1BAwFaltq4wyRIZ9ToMJTLzr5I33KwtFnUUHBlvCfjYeIg0eDY5tiIz3qd
         lJDm+0ZFFZFPZlJ4pCs4hQKdM9YX93g1kV9jIkmvHIQ+zEak13V7XoKS96PhHEEgnSqq
         i1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ry897ZhJp2yTG1lXS+4plTo5xRSiPLEguQxlHrl4M40=;
        fh=I6SZulyRnYO8zgnM5kYNNAdGNDdlv//He7kg+24BmmY=;
        b=C4ggFNcE8EUvgywKcxgdMoDIhFtKBPquDTdb8CfPjeDidE+Rqko5VtLZiAAPIGK9nu
         ypme73nm0lU48TmICUs/Mr6SMQLdwRVusyEaCnNZPYi/bNYRSyHd8NFc2FJ8dLNvS1rA
         +cG4nZ/hbZ/d1Suwfu1Or0thp88/CJZQl1SwGS4hsREYdM98k/0vPgwIChBsMHS0AD3u
         LZuGn1FhyR4WYFIE7po+K4XqNj1nGRWXsJjPcvK27IxGnDlDFURD6p6cD86MJLWmZm6z
         u/iELDGq9UKRXovxF8m6XO3A8TTJdJEQtFICLjXCJ02r2iT4aRoOjGK8MUb9r2DS2DoE
         Ahdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773071872; x=1773676672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ry897ZhJp2yTG1lXS+4plTo5xRSiPLEguQxlHrl4M40=;
        b=Q8b+W+UiVaQtSD37viCHRVgFkzkSJ04hrOj0c3UCRjMLVNXvkiddHf7KHG/MnbJ6AH
         Ao20MOQEsYul9jB/vSi3w6bCYvFrTofbHtKyYIFYXzCCvRcZIr5MVSyDyplSvMTKe8bY
         ctYgTsRvd7tt6MghmczlfL6ygtklTe3cZRUGYo3Qbf/gRhduiT8wEVa5pTI30DNWSHWD
         JiT7VuSjKYDq3j32PYBruCppjSnn/LeGFSv/3mG3iWuoWnro0GEaeNiqVKYu5b9WYaZA
         QbwsoNSL16CDKHPTfYeHqT2fGhPCBIHeCafTAm5am4o/UJ39U/4nc/eMQU/V3yXp5JR9
         Qirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773071872; x=1773676672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ry897ZhJp2yTG1lXS+4plTo5xRSiPLEguQxlHrl4M40=;
        b=PhooKsKfF8gAMzQzYF1RqLC1GjVHtG+VHx08wJ9uNKE3ZHUY4mgGYCC7VOx6PAhHBV
         xlq3safZUfQ4oySpDRaMIb+IIPrRcF25hrkULr9/utKjH4yZHXrJStK159dHYCATDz4C
         td06v0trqwvb/pffLbFyPjayGKacHLBeIYi7sxWGvfagUWLDYy2wzIgkPp8t97dV8MQJ
         CffQ6GkRksE3RIO7vqWI4dVn53LBcKcmeap5Rn8Dsta4p0WyTMqC7qXtezhDk6u7zWmW
         og52JsHDCmb7g8Yz9qE3URISE8HK5lKT4fLcJ6n+bpvT2gbG3H0CcYMWhGX+YPovG8px
         Y6ow==
X-Forwarded-Encrypted: i=1; AJvYcCXdcFM6ZhMcYjDRFk+2igBU/FlH6M8W16CjvqHTTJJ3OtsadoohrJdXLPciODUuHdW1wyPU6/oBHY6iaKU08xr7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+JXNBj2PRUlLzNpZs1yJz6ZUE3eWsgGldzh/xi0thMDetux4
	Ov1eYX5tqzqQxnOnwsdJ0NFzeAeGiSyPHmCPcnIPuaJBiR9HthsBqUt75u8Ny7CCPjP3vyyeF98
	nxla3dISAVNLvYhGHOMYxeuCdDJOHO1MWTni/lnZp
X-Gm-Gg: ATEYQzweSObYdfkxjv2fqPCq2QTXRtxq2DJnuMJN7EyPoe9WCx51ogTjtSxUDbagik9
	TpuJzt3Ukoyc2bEQVAmz/Qino4D4a35em4LsVj/bJ511ON6GT/a1V60CBW8nj0yz5q0bYKP5pog
	EI7Q8TzgM3fDWF6Ulgm8XYAAEVfczMiE1KPovI6KxkucPCWDCvl0dbmjrksodWJ0wqcRXCJKMFy
	ARYJ/n886KV8U6dDNf7YSnvroaqeEE5d2l+ONzXrveUvuCerYjtkFZrGZUhQWFHkbUDxiJalB7Z
	xmx5SytdhBhEsOsE0Agj0DTcaAgkcuIpE5fgFA==
X-Received: by 2002:a17:902:d487:b0:2ae:8039:fcb0 with SMTP id
 d9443c01a7336-2ae8b99e584mr2674645ad.5.1773071871879; Mon, 09 Mar 2026
 08:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216042530.1546-1-ravi.bangoria@amd.com> <20260216042530.1546-6-ravi.bangoria@amd.com>
 <CAP-5=fV_cJskvLRZhQQXMGAcPUb_Rg_b30PDJNXzxL49JK4B5g@mail.gmail.com>
 <8b99652d-155a-444e-8395-d461714bf4b8@amd.com> <3b6ff125-4110-4fbd-9da9-c510b3d43106@amd.com>
In-Reply-To: <3b6ff125-4110-4fbd-9da9-c510b3d43106@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 08:57:40 -0700
X-Gm-Features: AaiRm53XQYzchggjvT3MYk4V6OhXhpYx0m4L45NKMGNLx-Nzywq1rqxMWiAc-t0
Message-ID: <CAP-5=fXM6z5Rzk+JJu=vYu_nObykXjt-Fxmjj=0M0rJksriDGw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] perf/amd/ibs: Enable RIP bit63 hardware filtering
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Sadasivan Shaiju <sadasivan.shaiju2@amd.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manali Shukla <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 7:58=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> Hi Ian,
>
> >> Does the bit 63 assumption hold for guest operating systems?
> >
> > Yes, this seems to be an issue, even with current swfilt approach. Let
> > me inspect the code and get back.
>
> All mainstream 64 bit OSes use the bit-63 set for kernel addresses and ze=
ro
> for userspace addresses. This norm does not apply to 32 bit guests, but
> those are rare, and profiling them with IBS would be even rarer. So, I'll
> document this limitation in the perf-amd-ibs man page.
>
> While looking at this, I found some issues in IBS. Below patch fixes it:
>
> ---
>
> From deb6cdcbc60778b57a6eef60b2b7bd1b8e3cea74 Mon Sep 17 00:00:00 2001
> From: Ravi Bangoria <ravi.bangoria@amd.com>
> Date: Fri, 6 Mar 2026 04:52:00 +0000
> Subject: [PATCH] perf/amd/ibs: Improve guest profiling
>
> IBS captures the RIP but not its privilege level. Since the NMI is
> delivered with delay, CPL can change between the IBS tag and NMI
> delivery. Add a check to catch and discard invalid guest samples
> using CPL stored in vCPU save area. This will work when there is
> user/kernel CPL change in between IBS tag and NMI delivery within
> the guest boundary. But it won't work when there is a guest entry
> or exit in between IBS tag and NMI delivery.
>
> When profiling a guest and the IBS RIP is valid, assign the sample
> IP from the IBS-captured RIP and set PERF_SAMPLE_IP in sample_flags
> so that perf_prepare_sample() do not overwrite the RIP with
> perf_guest_get_ip() from the vCPU save area. This keeps the perf
> sample IP consistent with IBS raw data, data_src, weight, phy_addr
> etc. The privilege level in the perf "misc" field can now go out
> of sync, as it is taken from the vCPU save area.
>
> Reported-by: Ian Rogers <irogers@google.com>
> Closes: https://lore.kernel.org/r/CAP-5=3DfV_cJskvLRZhQQXMGAcPUb_Rg_b30PD=
JNXzxL49JK4B5g@mail.gmail.com
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks Ravi!
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/amd/ibs.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index eeb607b84dda..70408b0b1597 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1415,6 +1415,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *per=
f_ibs, struct pt_regs *iregs)
>         unsigned int msr;
>         u64 *buf, *config, period, new_config =3D 0;
>         int br_target_idx =3D -1;
> +       unsigned int guest_state;
>
>         if (!test_bit(IBS_STARTED, pcpu->state)) {
>  fail:
> @@ -1526,6 +1527,42 @@ static int perf_ibs_handle_irq(struct perf_ibs *pe=
rf_ibs, struct pt_regs *iregs)
>                 regs.flags |=3D PERF_EFLAGS_EXACT;
>         }
>
> +       guest_state =3D perf_guest_state();
> +       if (!event->attr.exclude_guest && guest_state & PERF_GUEST_ACTIVE=
) {
> +               /*
> +                * IBS captures the RIP but not its privilege level. Sinc=
e
> +                * NMI arrives delayed, CPL might change in between IBS t=
ag
> +                * and the NMI delivery. Below checks can identify and fi=
lter
> +                * out invalid samples when the CPL changes are within th=
e
> +                * guest boundary. However, these checks fail to handle c=
ases
> +                * where the CPU performs a guest entry or exit in betwee=
n
> +                * the IBS tag and the NMI delivery.
> +                */
> +               if (event->attr.exclude_kernel && !(guest_state & PERF_GU=
EST_USER)) {
> +                       throttle =3D perf_event_account_interrupt(event);
> +                       goto out;
> +               }
> +               if (event->attr.exclude_user && guest_state & PERF_GUEST_=
USER) {
> +                       throttle =3D perf_event_account_interrupt(event);
> +                       goto out;
> +               }
> +
> +               /*
> +                * Assign the IBS RIP value directly in the perf sample h=
ere
> +                * to prevent perf_prepare_sample() from retrieving it fr=
om
> +                * the vCPU save-area. With this, rest of the perf sample
> +                * fields (raw data, data_src, weight, phy_addr, etc.) wi=
ll
> +                * remain in sync with sample IP. However, privilege leve=
l
> +                * captured as part of perf sample "misc" field could now
> +                * go out of sync since privilege level is fetched from t=
he
> +                * vCPU save area.
> +                */
> +               if (regs.flags & PERF_EFLAGS_EXACT) {
> +                       data.ip =3D regs.ip;
> +                       data.sample_flags |=3D PERF_SAMPLE_IP;
> +               }
> +       }
> +
>         if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
>              (event->attr.config2 & IBS_SW_FILTER_MASK)) &&
>             perf_ibs_discard_sample(perf_ibs, event, &regs, &ibs_data, br=
_target_idx)) {
> --
> 2.43.0
>
>
