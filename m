Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130394;
	b=VQxQVQhJWPvmWFugMUgmg0Efywf54oOs3N4eRSy8FKB5Eg9fGGQoKRj2cNSzb59KM9GJ
	 t+JwXtJrfK/PhyIpFD/Z5fwVFIWJpElD1cKQcMxszDe86Pnlr1085hHkAbntFz6XipLMk
	 Es0I92dDdPLPq/DwXK5F7DxgDaLvVHlS7Hxrfa3ulxxVAkICZZdj5SrnanOLFSX/3l9+f
	 kxjz44NaiiL69j3k+5HJVAEqZYyNxcwI1MJGkYPq8Cp5EacYuPKbQu/M8LSNnbZ2Z/Y8j
	 ptQLYNPh+U1U7fL2JY2VLowUx8EbchHRpQyY5AaakP+E7YrNWkOjz1J6cj/RAcr792g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130394;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=JOTkIEV2oM01tUCfRWSA4k6sR5uZdilc8YIF5pCfTSk=;
	b=kUMqjYZBgnsCpIhwIdp4t/L8MKihs8AkAldSwY17BkdD9AZWU+qz8ztuqQgWkP3nABpD
	 4RXi2O1Ewh+o+nKG7vnviVuNGG/jaWMfXIi8v7D5Eo/+mlB0bkCUh9fYWWJbNcBOll+Cf
	 isBIGx54c68b9RXcVfkdOTvuDuNEEL3vdGcmZuSSoa7Z2cDeuWNX0MKisayi/a2P/eXAC
	 7CXsb9yEsyPG93rJG9hTGg9pAPN8ttalP81ehom/f1bax0wPFb0dLMIDTMqAFK+9+KDbn
	 pSoMxByJL+0sc2xpuUF4flqO+jVR8vZt2hCB4usUU+KBimdJod5hWq146j3dfns/G8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYUXjX3M;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="DcFnS/K8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA5606A31D
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 19:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7AA5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYUXjX3M;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DcFnS/K8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793130392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOTkIEV2oM01tUCfRWSA4k6sR5uZdilc8YIF5pCfTSk=;
	b=DYUXjX3Mmve/cvYugwfjsI2W76X/c0DFKvXV3+4dDArFnL496Nu6hf9F8qLPUrEdanPNHZ
	xCrVxCwYA7twVHVoOsugbB7darw0KUJHREP+ZRUg58qWDU6ti/ony8QHmf2hRbL/Y3NfZL
	fhZTarA4lASW7c5mV7PqzIMb7XJmRr0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-qt2UJSBmPP2nOcDaoNmhLA-1; Tue, 27 Oct 2026 15:46:31 -0400
X-MC-Unique: qt2UJSBmPP2nOcDaoNmhLA-1
X-Mimecast-MFC-AGG-ID: qt2UJSBmPP2nOcDaoNmhLA_1793130390
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c415561aaso101391f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 12:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793130390; cv=none;
        d=google.com; s=arc-20260327;
        b=mreLxnEdLc5gACozRD7jxpIib1A2oTTSzE7GjD1y+IG35BM9Ja+Kfn9NziXg+eoLfo
         RSDotzgNTdO6F4+f+nx5DHZdWt+CK5MGka1LjlsCyU436o1VE2KMt7XZtJ2nldYrMSbn
         BQI58o3StuTNdHFaIyGglHWDb3N2O2JMoXp/sngB+rypykCurxE9GQo6Kwr2lBB39JFL
         C+1fIaE+v/5aDcmPMlVHO31TusgUWDGWajf0SoUg+MzLQJBppmMbhdDMh6jnIOD912ct
         /Krd7eecQKB/eCqA/OMf/npVyJ+zx+WlI7WNDVfgYqca98OGvQxvXK1A1WCxnnsAf5OA
         EeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JOTkIEV2oM01tUCfRWSA4k6sR5uZdilc8YIF5pCfTSk=;
        fh=ZPT9hsaXyZidmYWEcuRPuRgioGFFn2czElQ/Z2acfsE=;
        b=OdTbbnJLXQIRG95plZ4E/eBPLXNUR7suomx2qzkyXQBf7lnBsyUaLrej/BOM6JwlD8
         uXDvfQ5SqVbG9DnRFwCljlY+CXFpvbd/by82NNrBLWktaqY+A6IuT1p9yqqC5SjKYavB
         8cL8YTVVui4r8hpiizXZZML01apOEukxwAyG9zpw6UQPvdNJT9SeiatNLbVZyCeesNLp
         Ja7vPMLWJtRwPeB8WM99p0atBMVcFzMPaunokXcV23tX2Dapsf4+WB4RzGf6yCQ5DT/I
         p0ZzchodJearb+QJaiV83fzGpSFgwDHunSF3rSf46FEGq8uwmLRD96tLfkofEmiCvndb
         ZNNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793130390; x=1793735190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JOTkIEV2oM01tUCfRWSA4k6sR5uZdilc8YIF5pCfTSk=;
        b=DcFnS/K8dEYdmjg6ZJjKVDRati4KEQtyPwkobvaifSOUbYSlhmJOdL0zbOoWK0LIrh
         4ppZDeB2XI/bvptNP+9IBQyfFvasqR2BU+d2wOXtDtamBQ0/OosC5/VDv4ghm1KN0Hmp
         e9fDI6DzOQKpIWCw1KA5WP2ILp9c4h2L9n6a8a+4inJZISmDK5dRBqWYuTNmV6fgnTZU
         wgwgqNdS5TwwdIYayRSmvLfleSdhopfD5pYh+vJnwkv+P2LsbdEwtNUd30e+U9Q4iuHv
         kFizrcnnAiSwDDUYmC/7usVb/AYxqNh3xr4mO+ICaVyxQB1ysE+oyBmfdUA5ynopvl0I
         Q1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130390; x=1793735190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JOTkIEV2oM01tUCfRWSA4k6sR5uZdilc8YIF5pCfTSk=;
        b=LGiDzSfPWCjod82t9QaEVWEYv4wPesezuHzxhx4xCpiE4AV2AOCSLHOHSG0Kk9vpDQ
         xzpX0qWykiaYCtuel4I6sVVQ0Ymqd1/23z9Jh9GZ3rLo9q4OBT5HJojCNjF1CbQyPuK8
         eLrGZXh71TqcAjFsp7WRDIV5Kl6yssbAPDXG6VN49MfQRVQHoPVpEQ/wFb8LxZN1alPp
         b48VIa8KEpS47VZYJ35OqlHd0WBJCiLox4DxflfAOpcPyI5MN7b8GDr4cLfJpV4RPxbI
         oVyL5xaM3w9QuGYUAVNj6IfueJFXybXrZxH7F3WMd7gSbiEPKH0s5A+F5yNDWKbYcyyl
         DABA==
X-Forwarded-Encrypted: i=1; AKwUvBw1FGSQxVT6XVKHBq1iUHeZt+g+pVoaqWCW1T1YfPlFVz7CkhwSu6qJtENj9FvyfRmJ4MeaimqFe5wk6oP3W7ml@vger.kernel.org
X-Gm-Message-State: AFq9FYLeOkB1G7OO9tGhI512cYgDRj912tPPAqXwdIX7PKMBBm0S9rS6
	iOmYd3Q3wu4igdVSVgclKP8/bhfcn56SbThjOamGJEAReMdI8B4Rey95wp55+2CQwOjqG5gVpXl
	VangmNRqRaj5x62cu+9nDAloKfVJZpT3cURgAkniAYIdqnVqC+0nJePCNm3hv6CoYPAcSIxLzhz
	UYDpJM6bltIYmdYmFG45nls91EAbzm0yMaOEBRBhHiX8zmHg==
X-Gm-Gg: AYBFou1IGyYXHifGZelI9lvX/BVS1DvQvocnNs0eaMAxOfaljQYCxxdxZgE6S4QVj0h
	q6RhmDarPfbEbxH8Ml4iNrTI65qk4l5gPAwmAHp+KDdlPTd/FxO0E1ifZ5IAIFlRLHYpsouS1Ga
	awhb18hxSIb1Jipy1GxJFIFWKwr1urEhjnk+EtVwD4Blkiua9u+FApulMKgTpQOTd6vk4kEBgq4
	nxcyJjO3L9gG50JGA==
X-Received: by 2002:a5d:588c:0:b0:48e:bf0:352 with SMTP id ffacd0b85a97d-48e5d284d78mr1237766f8f.5.1793130389898;
        Tue, 27 Oct 2026 12:46:29 -0700 (PDT)
X-Received: by 2002:a5d:588c:0:b0:48e:bf0:352 with SMTP id ffacd0b85a97d-48e5d284d78mr1237726f8f.5.1793130389407;
 Tue, 27 Oct 2026 12:46:29 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com> <20260930063919.608911-7-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260930063919.608911-7-himanshu.chauhan@oss.qualcomm.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Tue, 27 Oct 2026 15:46:18 -0400
X-Gm-Features: AclHuK-ugd-SMsap1lAbeozrFJFmptki5zc_TqPt3AXr1L797xe5xdIqlH8kHik
Message-ID: <CADRr4bcBjUR0vSm+8kDe7dsa4v0N7jpB6OCOcJ4S3aSNeFQ+yQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] riscv: Add software supported single stepping with
 mc/mc6 triggers
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	alex@ghiti.fr, aou@eecs.berkeley.edu, palmer@dabbelt.com, pjw@kernel.org, 
	qingfang.deng@linux.dev, shuah@kernel.org, thecharlesjenkins@gmail.com, 
	cp0613@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:40=E2=80=AFAM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> With mc/mc6 triggers, after handling breakpoint at current pc, there
> is no way to tell trigger to skip same breakpoint after the handler
> returns. This can cause loop of breakpoints at the same address until
> the trigger is disabled or uninstalled. Debugger may keep the breakpoints
> enabled and if kernel disables it, there is a loss of state coherency.
>
> To avoid the loop, software disables the current breakpoint, finds the
> next instruction that would be executed after pc and puts a breakpoint
> at that address. When this breakpoint hits, old breakpoint is reinstalled=
.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  arch/riscv/include/asm/hw_breakpoint.h |   9 +
>  arch/riscv/kernel/hw_breakpoint.c      | 256 +++++++++++++++++++------
>  2 files changed, 202 insertions(+), 63 deletions(-)
>
> diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/=
asm/hw_breakpoint.h
> index ca2ef93c020c..93cbf39f4b4a 100644
> --- a/arch/riscv/include/asm/hw_breakpoint.h
> +++ b/arch/riscv/include/asm/hw_breakpoint.h
> @@ -280,6 +280,10 @@ struct arch_hw_breakpoint {
>         unsigned long address;
>         unsigned long len;
>         unsigned int type;
> +
> +       /* Single-step callback info */
> +       unsigned long next_addr;
> +       bool in_callback;
>         unsigned int match;
>         unsigned int chain;
>         unsigned int select;
> @@ -289,6 +293,11 @@ struct arch_hw_breakpoint {
>         unsigned long tdata1;
>         unsigned long tdata2;
>         unsigned long tdata3;
> +
> +       /* Saved trigger config for single-step restore */
> +       unsigned long saved_tdata1;
> +       unsigned long saved_tdata2;
> +       unsigned long saved_tdata3;
>  };
>
>  struct perf_event_attr;
> diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_bre=
akpoint.c
> index dd6f63953969..9597ed362537 100644
> --- a/arch/riscv/kernel/hw_breakpoint.c
> +++ b/arch/riscv/kernel/hw_breakpoint.c
> @@ -11,9 +11,12 @@
>  #include <linux/percpu.h>
>  #include <linux/kdebug.h>
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/math.h>
>  #include <linux/cpu.h>
>  #include <linux/cpuhotplug.h>
>
> +#include <asm/insn.h>
>  #include <asm/sbi.h>
>
>  /* Registered per-cpu bp/wp */
> @@ -328,8 +331,11 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>
>         /* Breakpoint address */
>         hw->address =3D attr->bp_addr;
> +       hw->tdata1 =3D 0;
>         hw->tdata2 =3D attr->bp_addr;
>         hw->tdata3 =3D 0x0;
> +       hw->next_addr =3D 0x0;
> +       hw->in_callback =3D false;
>
>         switch (dbtr_type) {
>         case RISCV_DBTR_TRIG_MCONTROL:
> @@ -347,6 +353,93 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>         return ret;
>  }
>
> +static ulong get_step_address(struct pt_regs *regs, ulong insn)
> +{
> +       return get_next_insn_address(regs, insn, regs->epc);
> +}
> +
> +/*
> + * setup_singlestep - Set the breakpoint to next instruction after curre=
nt breakpoint.
> + */
> +static int setup_singlestep(struct perf_event *event, struct pt_regs *re=
gs)
> +{
> +       struct arch_hw_breakpoint *bp =3D counter_arch_bp(event);
> +       unsigned long insn, next_addr =3D 0;
> +       int ret;
> +       struct arch_hw_breakpoint tmp =3D {};
> +
> +       /*
> +        * Save the original trigger configuration so we can restore it
> +        * after the single-step fires.
> +        */
> +       bp->saved_tdata1 =3D bp->tdata1;
> +       bp->saved_tdata2 =3D bp->tdata2;
> +       bp->saved_tdata3 =3D bp->tdata3;
drop saved_tdata* as they are not used.
`hw_breakpoint_arch_parse(NULL, &event->attr, bp)` restores the
origonal state instead.

Thanks,
Jesse Taube


> +
> +       ret =3D get_insn_safe(regs, regs->epc, &insn);
> +       if (ret < 0)
> +               return ret;
> +
> +       next_addr =3D get_step_address(regs, insn);
> +
> +       /*
> +        * Software path: update the trigger in-place to an execute
> +        * breakpoint at next_addr.  Build the tdata directly without
> +        * calling hw_breakpoint_arch_parse() so that bp->len, bp->type
> +        * and bp->address are not overwritten and remain valid for the
> +        * handler's matching logic after restore.
> +        */
> +       tmp.tdata1 =3D 0;
> +       tmp.tdata2 =3D next_addr;
> +       tmp.tdata3 =3D 0;
> +       switch (dbtr_type) {
> +       case RISCV_DBTR_TRIG_MCONTROL6:
> +               RISCV_DBTR_SET_MC6_EXEC_BIT(tmp.tdata1);
> +               tmp.tdata1 =3D RISCV_DBTR_SET_MC6_SIZE(tmp.tdata1, 0);
> +               tmp.tdata1 =3D RISCV_DBTR_SET_MC6_TYPE(tmp.tdata1,
> +                                                    RISCV_DBTR_TRIG_MCON=
TROL6);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_DMODE_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_TIMING_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_SELECT_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_ACTION_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_CHAIN_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_MATCH_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_M_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_VS_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_VU_BIT);
> +               SET_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_S_BIT);
> +               SET_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC6_U_BIT);
> +               break;
> +       case RISCV_DBTR_TRIG_MCONTROL:
> +               RISCV_DBTR_SET_MC_EXEC_BIT(tmp.tdata1);
> +               tmp.tdata1 =3D RISCV_DBTR_SET_MC_SIZELO(tmp.tdata1, 0);
> +               tmp.tdata1 =3D RISCV_DBTR_SET_MC_SIZEHI(tmp.tdata1, 0);
> +               tmp.tdata1 =3D RISCV_DBTR_SET_MC_TYPE(tmp.tdata1,
> +                                                   RISCV_DBTR_TRIG_MCONT=
ROL);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_DMODE_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_TIMING_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_SELECT_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_ACTION_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_CHAIN_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_MATCH_BIT);
> +               CLEAR_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_M_BIT);
> +               SET_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_S_BIT);
> +               SET_DBTR_BIT(tmp.tdata1, RISCV_DBTR_MC_U_BIT);
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       bp->tdata1 =3D tmp.tdata1;
> +       bp->tdata2 =3D next_addr;
> +       bp->tdata3 =3D 0;
> +       arch_update_hw_breakpoint(event);
> +
> +       bp->in_callback =3D true;
> +       bp->next_addr =3D next_addr;
> +       return 0;
> +}
> +
>  /*
>   * Read mcontrol6's hit1:hit0 field for trigger @idx. If either bit is s=
et,
>   * clear it in hardware (the Debug spec requires the trigger user to do
> @@ -401,10 +494,10 @@ static unsigned int mc6_read_and_clear_hit(int idx)
>   */
>  static int hw_breakpoint_handler(struct die_args *args)
>  {
> -       int ret =3D NOTIFY_DONE;
> +       int i, ret =3D 0, bp_ret =3D NOTIFY_DONE;
> +       bool expecting_callback =3D false;
>         struct arch_hw_breakpoint *bp;
>         struct perf_event *event;
> -       int i;
>
>         for (i =3D 0; i < dbtr_total_num; i++) {
>                 event =3D this_cpu_read(pcpu_hw_bp_events[i]);
> @@ -412,85 +505,122 @@ static int hw_breakpoint_handler(struct die_args *=
args)
>                         continue;
>
>                 bp =3D counter_arch_bp(event);
> -               switch (bp->type) {
> -               /* Breakpoint */
> -               case HW_BREAKPOINT_X:
> -               {
> -                       bool hit =3D bp->address =3D=3D args->regs->epc;
>
> -                       if (!hit && dbtr_type =3D=3D RISCV_DBTR_TRIG_MCON=
TROL6)
> -                               hit =3D mc6_read_and_clear_hit(i) !=3D RI=
SCV_DBTR_MC6_HIT_FALSE;
> +               if (bp->in_callback) {
> +                       expecting_callback =3D true;
> +                       if (args->regs->epc !=3D bp->next_addr)
> +                               continue;
> +
> +                       arch_uninstall_hw_breakpoint(event);
>
> -                       if (hit) {
> -                               perf_bp_event(event, args->regs);
> -                               ret =3D NOTIFY_STOP;
> +                       /* Restore original breakpoint */
> +                       if (hw_breakpoint_arch_parse(NULL, &event->attr, =
bp))
> +                               goto exit;
> +
> +                       if (arch_install_hw_breakpoint(event))
> +                               goto exit;
> +
> +                       bp->in_callback =3D false;
> +                       bp_ret =3D NOTIFY_STOP;
> +                       goto exit;
> +               }
> +
> +               switch (event->attr.bp_type) {
> +               /* Breakpoint */
> +               case HW_BREAKPOINT_X:
> +                       {
> +                               bool hit =3D bp->address =3D=3D args->reg=
s->epc;
> +
> +                               if (!hit && dbtr_type =3D=3D RISCV_DBTR_T=
RIG_MCONTROL6)
> +                                       hit =3D mc6_read_and_clear_hit(i)=
 !=3D RISCV_DBTR_MC6_HIT_FALSE;
> +
> +                               if (hit) {
> +                                       perf_bp_event(event, args->regs);
> +                                       ret =3D setup_singlestep(event, a=
rgs->regs);
> +                                       if (ret < 0) {
> +                                               pr_err("Single step setup=
 failed: %d.\n", ret);
> +                                               goto exit;
> +                                       }
> +                                       bp_ret =3D NOTIFY_STOP;
> +                                       goto exit;
> +                               }
>                         }
>                         break;
> -               }
>
>                 /* Watchpoint */
>                 case HW_BREAKPOINT_W:
>                 case HW_BREAKPOINT_R:
>                 case HW_BREAKPOINT_RW:
> -               {
> -                       unsigned long stval =3D args->regs->badaddr;
> -                       unsigned long bp_start =3D bp->address;
> -                       unsigned long bp_len =3D bp->len ?: 1;
> -                       unsigned long bp_end =3D bp_start + bp_len - 1;
> -                       unsigned long stval_end =3D stval + sizeof(long) =
- 1;
> -                       bool hit =3D false;
> -
> -                       if (bp_end < bp_start)
> -                               bp_end =3D ~0UL;
> -                       if (stval_end < stval)
> -                               stval_end =3D ~0UL;
> -
> -                       /*
> -                        * Prefer tdata1.hit from SBI trigger readout whe=
never
> -                        * possible. Fall back to address-based matching =
if HIT
> -                        * isn't observed/supported.
> -                        */
> -                       if (dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONTROL) {
> -                               unsigned long tdata1;
> -                               struct sbiret sret;
> -                               union sbi_dbtr_shmem_entry *shmem;
> -
> -                               raw_spin_lock_irqsave(this_cpu_ptr(&ecall=
_lock),
> -                                                     *this_cpu_ptr(&ecal=
l_lock_flags));
> -                               shmem =3D this_cpu_ptr(sbi_dbtr_shmem);
> -                               sret =3D sbi_ecall(SBI_EXT_DBTR, SBI_EXT_=
DBTR_TRIG_READ,
> -                                                i, 1, 0, 0, 0, 0);
> -                               if (!sret.error) {
> -                                       tdata1 =3D le_to_cpu(shmem->data.=
tdata1);
> -                                       hit =3D !!(tdata1 & RISCV_DBTR_MC=
_HIT_BIT_MASK);
> +                       {
> +                               unsigned long stval =3D args->regs->badad=
dr;
> +                               unsigned long bp_start =3D bp->address;
> +                               unsigned long bp_len =3D bp->len ?: 1;
> +                               unsigned long bp_end =3D bp_start + bp_le=
n - 1;
> +                               unsigned long stval_end =3D stval + sizeo=
f(long) - 1;
> +                               bool hit =3D false;
> +
> +                               if (bp_end < bp_start)
> +                                       bp_end =3D ~0UL;
> +                               if (stval_end < stval)
> +                                       stval_end =3D ~0UL;
> +
> +                               /*
> +                                * Prefer tdata1.hit from SBI trigger rea=
dout whenever
> +                                * possible. Fall back to address-based m=
atching if HIT
> +                                * isn't observed/supported.
> +                                */
> +                               if (dbtr_type =3D=3D RISCV_DBTR_TRIG_MCON=
TROL) {
> +                                       unsigned long tdata1;
> +                                       struct sbiret sret;
> +                                       union sbi_dbtr_shmem_entry *shmem=
;
> +
> +                                       raw_spin_lock_irqsave(this_cpu_pt=
r(&ecall_lock),
> +                                                             *this_cpu_p=
tr(&ecall_lock_flags));
> +                                       shmem =3D this_cpu_ptr(sbi_dbtr_s=
hmem);
> +                                       sret =3D sbi_ecall(SBI_EXT_DBTR, =
SBI_EXT_DBTR_TRIG_READ,
> +                                                        i, 1, 0, 0, 0, 0=
);
> +                                       if (!sret.error) {
> +                                               tdata1 =3D le_to_cpu(shme=
m->data.tdata1);
> +                                               hit =3D !!(tdata1 & RISCV=
_DBTR_MC_HIT_BIT_MASK);
> +                                       }
> +                                       raw_spin_unlock_irqrestore(this_c=
pu_ptr(&ecall_lock),
> +                                                                  *this_=
cpu_ptr(&ecall_lock_flags));
> +                               } else if (dbtr_type =3D=3D RISCV_DBTR_TR=
IG_MCONTROL6) {
> +                                       hit =3D mc6_read_and_clear_hit(i)=
 !=3D RISCV_DBTR_MC6_HIT_FALSE;
>                                 }
> -                               raw_spin_unlock_irqrestore(this_cpu_ptr(&=
ecall_lock),
> -                                                          *this_cpu_ptr(=
&ecall_lock_flags));
> -                       } else if (dbtr_type =3D=3D RISCV_DBTR_TRIG_MCONT=
ROL6) {
> -                               hit =3D mc6_read_and_clear_hit(i) !=3D RI=
SCV_DBTR_MC6_HIT_FALSE;
> -                       }
>
> -                       /*
> -                        * Sdtrig may report STVAL as the lowest accessed
> -                        * address while the watchpoint can match a highe=
r byte
> -                        * in the same access.
> -                        */
> -                       if (hit ||
> -                           (stval >=3D bp_start && stval <=3D bp_end) ||
> -                           (bp_start >=3D stval && bp_start <=3D stval_e=
nd)) {
> -                               perf_bp_event(event, args->regs);
> -                               ret =3D NOTIFY_STOP;
> +                               /*
> +                                * Sdtrig may report STVAL as the lowest =
accessed
> +                                * address while the watchpoint can match=
 a higher byte
> +                                * in the same access.
> +                                */
> +                               if (hit ||
> +                                   (stval >=3D bp_start && stval <=3D bp=
_end) ||
> +                                   (bp_start >=3D stval && bp_start <=3D=
 stval_end)) {
> +                                       perf_bp_event(event, args->regs);
> +                                       ret =3D setup_singlestep(event, a=
rgs->regs);
> +                                       if (ret < 0) {
> +                                               pr_err("setup_singlestep =
failed %d.\n", ret);
> +                                               goto exit;
> +                                       }
> +                                       bp_ret =3D NOTIFY_STOP;
> +                                       goto exit;
> +                               }
>                         }
>                         break;
> -               }
>
>                 default:
> -                       pr_warn("Unknown type: %u\n", bp->type);
> -                       break;
> +                       pr_warn("Unknown type: %u\n", event->attr.bp_type=
);
> +                       goto exit;
>                 }
>         }
>
> -       return ret;
> +       if (expecting_callback) {
> +               pr_err("in_callback set but epc (%lx) not at next_addr (%=
lx).\n",
> +                      args->regs->epc, bp->next_addr);
> +       }
> +exit:
> +       return bp_ret;
>  }
>
>  int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> --
> 2.43.0
>

