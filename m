Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794553690;
	b=kBmRLJbww4I88eQ5rtco2ab9/NjWyhZNM98CyWCkHCw+wWl/YKAOVoV3lqS0rcE15BhQ
	 AfCjYC+JKldstejAzUuWcTNZLjhRvnYx0Ng1uwfBq6uIAC5w+SMRo0CcOh5zIbV8zbLTs
	 3E5E/vGup0hlz7oOuhhj01PQOvX86Sun8M8EQpyiEX5ro/WzT8bB0PmiMPTkZWfn62Kar
	 nLSHd3YvaUff5TLXtVJD+c8zFt/5wXjCDV5ZSMsYlYY1t+gFWl+wV1y967GBtCIqRcsSZ
	 2ev/IygFkwud5mkCnCPhNM9yyun0b6RB5N9HhsgIEgeixFBbCHtk4yGMqAiCVnCUWmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Bbe99r7ldGy+3LHPoWZzc4j81Y95tpvjwCTeCgDNgYE=;
	b=p5P+Y+NryJ1GtODskkOh+puIE5NA2LOWP8/THeGNc2eRVlrE9R1oONRbKJv9Ty6SV43s
	 gRE6fHZcVcWdru+FWk/cFsoXpxnS54AtDbZGsMILjkx7kxoLK/xh/F7Ha+ie/jdwPQe12
	 wDSI1NQWndxjM1q/1FdIoXGEb2tD92SywA0KOFYYv/x+mbqFqEkR2wy5LLwmBM2NqKxyz
	 G/idChfN6wTbqqtdkSKjSC820ZGochjJOJk5oaof9v6Do+yPajkRZYUHxL9y3MRn+cbjQ
	 IMAJ8K0H0Jn/o4p45PE9VgMsngC71QlmcERqkx9NSjBpx4ayffj/1R2rG/tM97NRiXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Nc98C0yt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53756606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 07:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53756606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Nc98C0yt
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5383c97c8cfso186601cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 23:08:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794553689; cv=none;
        d=google.com; s=arc-20260327;
        b=q6jzq6bfW6lPrkg9mkUEQlL2JbaZcD0SxDvGbnT1bFXANhNzp2VCiRlP8iG234Og0x
         0nBL8CrpWMHNqMSz+tsEJVsUN12kRwG4ImqWB68R3LbfkKmhATSsPymWkFPlaEMPkCqD
         x9+DmcDUj66cL+b9KspovmXz6iaVoknEhEVWYF9TNX5aSBwIezVNtblje47bIspmoYbD
         VnRgHs2MOXP//WSEAUEm/UAi+fQkgEis2Mvvc40Ck707YDyNYRQjjN9A7U0jqSWHL+Vt
         XF7up5y/0N7VN0DR5jQiDL4pKjs0twospdbW9na4VFOVANMgw6lHvzGnd9+dg+8caEvn
         PP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bbe99r7ldGy+3LHPoWZzc4j81Y95tpvjwCTeCgDNgYE=;
        fh=SKKyBLgPrznhdmpPXXkIlqo/i2ty+GuND/AtKj+8y0Q=;
        b=R1jDw416mKArH5SBdjK/FP+x2rQmRAqhuYTbKrGRxt0PVr+Vx5oifvIYPpi1UDWCyP
         4Db3ijmibmeZEC9l4Y+7gNoNVLvIpYosh8zTbzXvRlFGW8jeuSwB5DcG7gscub8Zu77G
         2ecE+F0brWJQYEL3hYfhOcVq9jMS5vyhmJG9ENKj67p03NMzGf5IantTXDi6qgETMK0a
         kgHnahUrVFIjco6X4NScnqVsQA5x3Li9NPNs9zLQxH4Qns1MH1OI6/svIsOKr+7Xf/iC
         3ukRtZHdIOjVGu+80yI0uF/4NHVk2busGNpiFdK6R6N7hTpjkIItStV+SIJgO01qfInT
         LWMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794553689; x=1795158489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bbe99r7ldGy+3LHPoWZzc4j81Y95tpvjwCTeCgDNgYE=;
        b=Nc98C0yt1c3xZnUxV7h7Hq1d4SbW54n59ZRoTP430cbddJ3lXRgqlTqqB3gDZGz4LK
         CuiJCa9V9vpXHMOUrHXi7FpFdBhNEwOFDLsst+WjK/xsVBpjOAjlY7kxoqRyn3gYD7Hd
         s3G3mMg1axV5z+TumR1N1eAmG7uRjH+ipM2YDIuEltNnb+ktQi8hHR8jaDPJwbYfajlM
         jyz7o4ZRCabVTbtROiGuyzSWD7rBgeCYLqwfjMqr+3vPabDJjz804/p74hJnmMlqFjYq
         q+yiufNQ3cWKWue+fhduVAUTtc5+kEbg+t/Vf0MU1gO/B9ZVIG2DD/vz3OxUa85ygtx8
         VREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794553689; x=1795158489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bbe99r7ldGy+3LHPoWZzc4j81Y95tpvjwCTeCgDNgYE=;
        b=kRKhZdQoEM/pfmcvVFb1VOsKculpcEfg0BgvjiQaVjGIs9Bt1SBpBZ/cECGuPL5P2V
         Ft+AQJVVLwVwRHLToShyumFKTHYujJ7KHDYqnO9jygqpA8nqh5FEZHLZxWHevHfr3mTN
         TKXHEmg4H1uhkcUxcmUKcmFytBWDFRO7M8Rj7oliEW+K/Jqj7BnpjO0wdYmEuXwln9z3
         hMCVgK1ve+z+XeDTtgYCVRtVzwvgzbCKOhHUgAlxgukGODxjW6v0ig/uwh1iEBPhlKlM
         K3E83QOkIc7vYjahRBPcTnyXPJttfP1wlJlusXOhZnIOQ1Vu1edJARzrR1n6upjN2hm2
         7wjg==
X-Forwarded-Encrypted: i=1; AL+hErG4F1fhyfpEdcXfi3X6Q22zh1/I2GLwnLyiGzZMh9EbS60uk9MxfohZfaevNNLIN1iKDoNALlUdaNnn4J2ovqa8@vger.kernel.org
X-Gm-Message-State: APuU4Z95sesqISXhr6fGA6Qe6JIrAFwBtwxrSjaBREKQUcdHoCKoYoGn
	68w3umpxzJy+Nv2VAFWZZHH0JZC2/KG2Yj+aKsnt5zzOAGbSFRwBFY5wpTyRXNg6Jad//EKRXeR
	gVtI372AMFELeF2ds4S1Uv+I6U90WWk2yi8XpcnA8
X-Gm-Gg: AYBFou36A6EnetcCALyHh2JNOtY+f4/guzOqQZwCJpgdTasjfgUYgPIA6O3KKheo7jA
	Hlg08haja1oLwYCjXmBSYW7hePCgTouNbmOailpEXBjm5qZ+4+slBaRiBPyiNLc0CQszSrwf4Wd
	5X8uG0+vlQx7sokKD69aXhrXe9Eyia6i/Yl4r5zw55Zz2qaQdplo9vxPERGHfeBvhtNF1ye6HsY
	dN4COZqX7Ho2ywTr13PFXY9hMdfmiI7/E4TMZxyq29EtCMvIPxUR/GwEMYKjmaFn2ro7O9jLYJw
	7uBiobc8i71FnmkaO/d+s1jqfmYdcMTeQcvUZuoMgCazwzWxwR54JrFJel8pOXmS6QqXdoYLoz+
	wX19rmpFcJVr1U8d4oHfgBTvQ5OAt0nEIbP3+
X-Received: by 2002:a05:622a:408d:b0:530:e335:4ef with SMTP id
 d75a77b69052e-55ad7e74d7dmr6692551cf.2.1794553688471; Thu, 12 Nov 2026
 23:08:08 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com> <20261030-perf_cs_etm_fix_non_taken-v3-10-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-10-7629b52ab047@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Nov 2026 23:07:55 -0800
X-Gm-Features: AclHuK-AnxLYHKF4-9qpseOsqe_AfHtt2i5OGLHh-0sk5gi77CYMBej7Kg_rG1c
Message-ID: <CAP-5=fUMwOb6Gj+5DOu9-yNmthDz5ghAqrzmZ4ACX0g+9WB59w@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] perf cs-etm: Synthesize exception entries
 separately from branches
To: Leo Yan <leo.yan@arm.com>, James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Mike Leach <mike.leach@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 8:13=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Exception entry is currently represented by replacing the preceding
> range's flags and forcing its last_instr_taken_branch bit. This gives
> an interrupt the source address of the last executed instruction. When
> that instruction is a taken branch, its edge and original flags are lost.
>
> For example, consider an untaken B.LS followed by an IRQ:
>
>   4000f4: eb02003f  cmp  x1, x2
>   4000f8: 54000109  b.ls 400118
>   4000fc: d282f2c2  mov  x2, #0x1796
>
> If B.LS completes untaken and the IRQ is taken before MOV completes, the
> preferred exception return address is 4000fc. With kernel tracing disable=
d,
> perf script previously attributed the IRQ to the preceding range:
>
>   tr end  hw int  4000f8 =3D> 0       b.ls #0x400118
>   tr strt jmp          0 =3D> 4000fc
>
> When an IRQ element provides that return address, use it as the source of
> the synthesized exception sample:
>
>   tr end  hw int  4000fc =3D> 0       movz x2, #0x1796
>   tr strt jmp          0 =3D> 4000fc
>
> The source now identifies the architectural resume PC, rather than the
> last completed instruction. The IRQ signal could have arrived while B.LS
> was executing. The traced preferred exception return address of 4000fc
> confirms that B.LS had retired architecturally before the IRQ was taken.
>
> OpenCSD provides an exception's preferred return address in en_addr when
> excep_ret_addr is set. It does not define or initialize st_addr for an
> exception element. Derive A32 and A64 exception source PCs from the
> preferred return address. Exception calls (SVC/SMC/HVC) use the preceding
> four-byte instruction; interrupts, faults and traps use the return
> address with last_instr_size set to zero.
>
> Use pref_ret_addr when deriving exception source PCs in the decoder and
> cs_etm__last_executed_instr(), and when setting sample.ret_addr.
>
> Keep T32 exception samples on the existing fallback path because
> determining the call size requires an instruction read. Retain
> pref_ret_addr for the frontend's SVC check. RESET and missing return
> addresses also use the fallback because their source PC is unknown.
>
> Resolve the preceding branch with its original flags without adding
> instructions. Then retain the exception in prev_packet until the next
> range, exception or discontinuity resolves its destination. This preserve=
s
> both edges when an exception follows a taken branch and also handles
> consecutive exceptions.
>
> Supply the preferred return address in sample.ret_addr so later instructi=
on
> fetching cannot change the return PC used by call/return export. Generate
> final instruction samples only from nonempty instruction ranges.
>
> CS_ETM_EXCEPTION_RET needs no further handling in the packet processing
> loop because ERET is already part of the preceding instruction range.
> cs_etm__set_sample_flags() now sets both that range's return flags and
> last_instr_taken_branch.
>
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Hi Leo,

After commit 9648f9fc3525 ("perf cs-etm: Synthesize exception entries
separately from branches") in perf-tools-next, perf's build-test
(`make -C tools/perf O=3D/tmp/build CORESIGHT=3D1`, i.e. `make_with_coresig=
ht_O`)
with GCC 15.2.0 (`gcc (Debian 15.2.0-14) 15.2.0`, `-O3`) fails with:

  In function =E2=80=98cs_etm__t32_instr_size=E2=80=99,
      inlined from =E2=80=98cs_etm__instr_size=E2=80=99 at util/cs-etm.c:13=
90:10,
      inlined from =E2=80=98cs_etm__copy_insn=E2=80=99 at util/cs-etm.c:157=
2:21:
  util/cs-etm.c:1381:28: error: =E2=80=98instrBytes=E2=80=99 may be used un=
initialized
 [-Werror=3Dmaybe-uninitialized]
   1381 |         return ((instrBytes[1] & 0xF8) >=3D 0xE8) ? 4 : 2;
            |                  ~~~~~~~~~~^~~
  util/cs-etm.c: In function =E2=80=98cs_etm__copy_insn=E2=80=99:
  util/cs-etm.c:1372:12: note: =E2=80=98instrBytes=E2=80=99 declared here
   1372 |         u8 instrBytes[2];
            |            ^~~~~~~~~~

The uninitialized `instrBytes` in cs_etm__t32_instr_size() is actually
pre-existing from commit a7ee4d625ede ("perf cs-etm: Support for ARM
A32/T32 instruction sets in CoreSight trace"): cs_etm__frontend_mem_access(=
)
(via __cs_etm__mem_access()) can return 0 without writing to instrBytes
when thread__find_map(), map__dso(), or dso__data_read_offset() fails.
The changes around cs_etm__copy_insn() in this patch just shifted GCC's
-O3 inlining enough for it to inline __cs_etm__mem_access() and spot the
uninitialized read of instrBytes[1].

Zero-initializing `u8 instrBytes[2] =3D {};` (similar to instr16/instr32 in
cs_etm__is_svc_instr()) or checking that cs_etm__frontend_mem_access() read
ARRAY_SIZE(instrBytes) bytes before inspecting instrBytes[1] should fix it.

Thanks,
Ian

> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  31 ++++++-
>  tools/perf/util/cs-etm.c                        | 106 +++++++++++++++---=
------
>  tools/perf/util/cs-etm.h                        |   1 +
>  3 files changed, 95 insertions(+), 43 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf=
/util/cs-etm-decoder/cs-etm-decoder.c
> index ccae10e6cdad55607e092b90a1a940103fa050d7..b9397151748b222ae4542394c=
7b974b0fdb69bba 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -514,6 +514,7 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue =
*etmq,
>  {
>         int ret =3D 0;
>         struct cs_etm_packet *packet;
> +       u8 last_instr_size =3D 0;
>
>         ret =3D cs_etm_decoder__buffer_packet(etmq, queue, elem, trace_ch=
an_id,
>                                             CS_ETM_EXCEPTION);
> @@ -524,8 +525,34 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue=
 *etmq,
>         packet->exception_number =3D elem->exception_number;
>         if (elem->context.el_valid)
>                 packet->el =3D elem->context.exception_level;
> -       if (elem->excep_ret_addr)
> -               packet->pref_ret_addr =3D elem->en_addr;
> +
> +       /* RESET has no defined preferred return address. */
> +       if (!elem->excep_ret_addr ||
> +           packet->exception_number =3D=3D CS_ETMV4_EXC_RESET)
> +               return ret;
> +
> +       packet->pref_ret_addr =3D elem->en_addr;
> +
> +       /*
> +        * T32 calls can be two or four bytes, requiring an instruction r=
ead
> +        * before pref_ret_addr to determine their size. Keep it for the
> +        * frontend's SVC check and leave start_addr unknown for its fall=
back.
> +        */
> +       if (packet->isa !=3D CS_ETM_ISA_A32 && packet->isa !=3D CS_ETM_IS=
A_A64)
> +               return ret;
> +
> +       /*
> +        * For A32 and A64, exception calls execute a four-byte SVC, HVC =
or
> +        * SMC and save the following PC. Other exceptions use the interr=
upted
> +        * or faulting PC, including traps on those instructions.
> +        *
> +        * With a shared branch target, no instruction has completed
> +        * at the target, so last_instr_size remains zero.
> +        */
> +       if (elem->exception_number =3D=3D CS_ETMV4_EXC_CALL)
> +               last_instr_size =3D 4;
> +       packet->start_addr =3D packet->pref_ret_addr - last_instr_size;
> +       packet->last_instr_size =3D last_instr_size;
>
>         return ret;
>  }
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 14a6466255017386addaee539141bf89b6dcf76f..c8a6a6e4c7d3b4c9d58f3a5b4=
6587ee53c864b2e 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -101,10 +101,8 @@ struct cs_etm_traceid_queue {
>         ocsd_ex_level decode_el;
>
>         /*
> -        * The frontend accesses the EL from '[prev_]packet' because it n=
eeds
> -        * previous EL for branch and current EL for instruction samples.=
 It's
> -        * not possible to change thread in a single branch sample so no =
need to
> -        * store or access the thread through the packet.
> +        * Samples use the EL saved in their source packet. A branch samp=
le
> +        * cannot change thread, so the thread is kept in the frontend co=
ntext.
>          */
>         struct thread *frontend_thread;
>  };
> @@ -1397,11 +1395,10 @@ static inline int cs_etm__instr_size(struct cs_et=
m_queue *etmq,
>  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *pac=
ket)
>  {
>         /*
> -        * Return 0 for packets that have no addresses so that CS_ETM_INV=
AL_ADDR doesn't
> -        * appear in samples.
> +        * Return 0 for discontinuities so that CS_ETM_INVAL_ADDR doesn't=
 appear
> +        * in samples.
>          */
> -       if (packet->sample_type =3D=3D CS_ETM_DISCONTINUITY ||
> -           packet->sample_type =3D=3D CS_ETM_EXCEPTION)
> +       if (packet->sample_type =3D=3D CS_ETM_DISCONTINUITY)
>                 return 0;
>
>         return packet->start_addr;
> @@ -1414,6 +1411,9 @@ u64 cs_etm__last_executed_instr(const struct cs_etm=
_packet *packet)
>         if (packet->sample_type =3D=3D CS_ETM_DISCONTINUITY)
>                 return 0;
>
> +       if (packet->sample_type =3D=3D CS_ETM_EXCEPTION)
> +               return packet->pref_ret_addr - packet->last_instr_size;
> +
>         return packet->end_addr - packet->last_instr_size;
>  }
>
> @@ -1580,6 +1580,9 @@ static void cs_etm__copy_insn(struct cs_etm_queue *=
etmq,
>                 return;
>         }
>
> +       if (packet->sample_type =3D=3D CS_ETM_EXCEPTION && !sample->insn_=
len)
> +               return;
> +
>         cs_etm__frontend_mem_access(etmq, tidq, packet, sample->ip,
>                                     sample->insn_len, (void *)sample->ins=
n);
>  }
> @@ -1606,8 +1609,11 @@ static inline u64 cs_etm__resolve_sample_time(stru=
ct cs_etm_queue *etmq,
>                 return etm->latest_kernel_timestamp;
>  }
>
> -static bool cs_etm__packet_has_taken_branch(struct cs_etm_packet *packet=
)
> +static bool cs_etm__packet_has_branch(struct cs_etm_packet *packet)
>  {
> +       if (packet->sample_type =3D=3D CS_ETM_EXCEPTION)
> +               return true;
> +
>         if (packet->sample_type =3D=3D CS_ETM_RANGE &&
>             packet->last_instr_taken_branch)
>                 return true;
> @@ -1625,7 +1631,7 @@ static void cs_etm__add_stack_event(struct cs_etm_q=
ueue *etmq,
>         if (!etm->synth_opts.branches && !etm->synth_opts.instructions)
>                 return;
>
> -       if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
> +       if (!cs_etm__packet_has_branch(tidq->prev_packet))
>                 return;
>
>         if (etmq->etm->use_thread_stack) {
> @@ -1737,7 +1743,8 @@ static int cs_etm__synth_last_instruction_sample(st=
ruct cs_etm_queue *etmq,
>             !etmq->etm->synth_opts.instructions)
>                 return 0;
>
> -       if (packet->sample_type !=3D CS_ETM_RANGE)
> +       /* Only nonempty ranges provide a final instruction to sample. */
> +       if (packet->sample_type !=3D CS_ETM_RANGE || !packet->instr_count=
)
>                 return 0;
>
>         ret =3D cs_etm__synth_instruction_sample(etmq, tidq, packet,
> @@ -1771,7 +1778,7 @@ static int cs_etm__synth_branch_sample(struct cs_et=
m_queue *etmq,
>         if (!etm->synth_opts.branches)
>                 return 0;
>
> -       if (!cs_etm__packet_has_taken_branch(tidq->prev_packet) &&
> +       if (!cs_etm__packet_has_branch(tidq->prev_packet) &&
>             !(tidq->prev_packet->flags & (PERF_IP_FLAG_TRACE_BEGIN |
>                                           PERF_IP_FLAG_TRACE_END)))
>                 return 0;
> @@ -1802,6 +1809,9 @@ static int cs_etm__synth_branch_sample(struct cs_et=
m_queue *etmq,
>         sample.flags =3D tidq->prev_packet->flags;
>         sample.cpumode =3D event->sample.header.misc;
>
> +       if (tidq->prev_packet->sample_type =3D=3D CS_ETM_EXCEPTION)
> +               sample.ret_addr =3D tidq->prev_packet->pref_ret_addr;
> +
>         cs_etm__copy_insn(etmq, tidq, tidq->prev_packet, &sample);
>
>         /*
> @@ -2052,21 +2062,23 @@ static int cs_etm__context(struct cs_etm_queue *e=
tmq,
>         return ret;
>  }
>
> -static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
> +static int cs_etm__exception(struct cs_etm_queue *etmq,
> +                            struct cs_etm_traceid_queue *tidq)
>  {
> +       struct cs_etm_packet *packet =3D tidq->packet;
> +
>         /*
> -        * When the exception packet is inserted, whether the last instru=
ction
> -        * in previous range packet is taken branch or not, we need to fo=
rce
> -        * to set 'prev_packet->last_instr_taken_branch' to true.  This e=
nsures
> -        * to generate branch sample for the instruction range before the
> -        * exception is trapped to kernel or before the exception returni=
ng.
> -        *
> -        * The exception packet does not describe an instruction range, s=
o don't
> -        * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be us=
eful
> -        * for generating instruction and branch samples.
> +        * Resolve the preceding branch without adding instructions, then=
 keep
> +        * this exception as prev_packet until its destination is known.
>          */
> -       if (tidq->prev_packet->sample_type =3D=3D CS_ETM_RANGE)
> +       if (packet->start_addr !=3D CS_ETM_INVAL_ADDR)
> +               return cs_etm__sample(etmq, tidq);
> +
> +       /* Fall back to attributing the exception to the preceding range.=
 */
> +       if (tidq->prev_packet->sample_type =3D=3D CS_ETM_RANGE) {
> +               tidq->prev_packet->flags =3D packet->flags;
>                 tidq->prev_packet->last_instr_taken_branch =3D true;
> +       }
>
>         return 0;
>  }
> @@ -2463,7 +2475,8 @@ static int cs_etm__set_sample_flags(struct cs_etm_q=
ueue *etmq,
>                  * instruction packet, set flag PERF_IP_FLAG_TRACE_END
>                  * for previous packet.
>                  */
> -               if (prev_packet->sample_type =3D=3D CS_ETM_RANGE)
> +               if (prev_packet->sample_type =3D=3D CS_ETM_RANGE ||
> +                   prev_packet->sample_type =3D=3D CS_ETM_EXCEPTION)
>                         prev_packet->flags |=3D PERF_IP_FLAG_BRANCH |
>                                               PERF_IP_FLAG_TRACE_END;
>                 break;
> @@ -2495,15 +2508,23 @@ static int cs_etm__set_sample_flags(struct cs_etm=
_queue *etmq,
>                                         PERF_IP_FLAG_CALL |
>                                         PERF_IP_FLAG_INTERRUPT;
>
> -               /*
> -                * When the exception packet is inserted, since exception
> -                * packet is not used standalone for generating samples
> -                * and it's affiliation to the previous instruction range
> -                * packet; so set previous range packet flags to tell per=
f
> -                * it is an exception taken branch.
> -                */
> -               if (prev_packet->sample_type =3D=3D CS_ETM_RANGE)
> -                       prev_packet->flags =3D packet->flags;
> +               if (packet->start_addr =3D=3D CS_ETM_INVAL_ADDR)
> +                       break;
> +
> +               /* Resolve the preceding trace start or exception return.=
 */
> +               if (prev_packet->sample_type =3D=3D CS_ETM_DISCONTINUITY)
> +                       prev_packet->flags |=3D PERF_IP_FLAG_BRANCH |
> +                                             PERF_IP_FLAG_TRACE_BEGIN;
> +
> +               if (prev_packet->flags =3D=3D (PERF_IP_FLAG_BRANCH |
> +                                          PERF_IP_FLAG_RETURN |
> +                                          PERF_IP_FLAG_INTERRUPT) &&
> +                   cs_etm__is_svc_instr(etmq, tidq, packet,
> +                                        packet->start_addr)) {
> +                       prev_packet->flags =3D PERF_IP_FLAG_BRANCH |
> +                                            PERF_IP_FLAG_RETURN |
> +                                            PERF_IP_FLAG_SYSCALLRET;
> +               }
>                 break;
>         case CS_ETM_EXCEPTION_RET:
>                 /*
> @@ -2531,10 +2552,12 @@ static int cs_etm__set_sample_flags(struct cs_etm=
_queue *etmq,
>                  * system call instruction and then calibrate the sample =
flag
>                  * as needed.
>                  */
> -               if (prev_packet->sample_type =3D=3D CS_ETM_RANGE)
> +               if (prev_packet->sample_type =3D=3D CS_ETM_RANGE) {
>                         prev_packet->flags =3D PERF_IP_FLAG_BRANCH |
>                                              PERF_IP_FLAG_RETURN |
>                                              PERF_IP_FLAG_INTERRUPT;
> +                       prev_packet->last_instr_taken_branch =3D true;
> +               }
>                 break;
>         case CS_ETM_CONTEXT:
>         case CS_ETM_EMPTY:
> @@ -2610,7 +2633,9 @@ static int cs_etm__process_traceid_queue(struct cs_=
etm_queue *etmq,
>                          * range, generate instruction sequence
>                          * events.
>                          */
> -                       cs_etm__sample(etmq, tidq);
> +                       ret =3D cs_etm__sample(etmq, tidq);
> +                       if (ret)
> +                               goto out;
>                         break;
>                 case CS_ETM_CONTEXT:
>                         /*
> @@ -2624,13 +2649,12 @@ static int cs_etm__process_traceid_queue(struct c=
s_etm_queue *etmq,
>                                 goto out;
>                         break;
>                 case CS_ETM_EXCEPTION:
> +                       ret =3D cs_etm__exception(etmq, tidq);
> +                       if (ret)
> +                               goto out;
> +                       break;
>                 case CS_ETM_EXCEPTION_RET:
> -                       /*
> -                        * If the exception packet is coming,
> -                        * make sure the previous instruction
> -                        * range packet to be handled properly.
> -                        */
> -                       cs_etm__exception(tidq);
> +                       /* The return annotates the preceding instruction=
 range. */
>                         break;
>                 case CS_ETM_DISCONTINUITY:
>                         /*
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index e40b9b7d0a9bd90f089c2f20527332264ead4249..bf0e0f5a9711f8d450ea8a0f9=
d67aa5e8d7204ab 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -173,6 +173,7 @@ struct cs_etm_queue;
>  struct cs_etm_packet {
>         enum cs_etm_sample_type sample_type;
>         enum cs_etm_isa isa;
> +       /* For exceptions: source PC, or CS_ETM_INVAL_ADDR. */
>         u64 start_addr;
>         union {
>                 u64 end_addr;           /* Range packets */
>
> --
> 2.34.1
>
