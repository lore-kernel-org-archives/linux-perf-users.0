Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83833932F1
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077382; cv=pass; b=MTXaiCh51oGx15Vc0jwDE9CJEgv75LKAWO7se7FuTmP0tVANbHJg/y0tzOY3ye0X4Srf5kqdHFjpk/I9a5fUaMkw+g+2FIFPml1OnOttliAK0ef3CYIOxk9+23G2tpe5GECm2D/5cfIlZZVwnkSzwqiijCZ7P10LfNh/CE5a+9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077382; c=relaxed/simple;
	bh=PVzvdWJL1bYwcpYPNT4jshqZIOaIpMANfjHIQtPOE1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEr7DkldqlOIMTdOaEF+UHx3sRsprwQTbW07qMxounN0iJET7GZknbegciEWHi1jwwk99u+xgoDRsomqALAgsW+tAvGqLx1PLF2B+Ctzw514gp6T23b1HhJCLO/TPWnqrocvFSs5L5Zfy1cCgIs6Mlwf9QqbnERbavcy3prn5Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZEuDqqe; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZEuDqqe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf22c18ad3so975ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 10:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780077379; cv=none;
        d=google.com; s=arc-20240605;
        b=doknXg8Rbi26VITeAU9J496/yd4CJZo9BoJBiyKybgh0P44YvWOtVICc9r3HLqubt+
         NtdfXDotFwgjBhYKKUzG6gLnx+krHyC2ZiBG/BqT7B8ieUkmrlN5EO3TlH4NPlKK7nJ1
         zRtlGVDHDb+F6u0D5RaPOAmUwUJ9jTj4B1uy1h6emIgixUkzgG9HurTVqMP3VTwqy8CD
         +4SQ5iOq2In+vEbvH4aS3tfMkQPAUQeoI8YlN+KlaI8lJI6U2aEIRKNRmp3Al7ts8Fh6
         Lol48krmXcCfp7ZDYT4dGnvWzdOe5TgsMz/Ysjw/BbpkB3oYp9q+Cznm3VogsS4TSbtb
         qAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eBhLxKNmxd00CX8Y6dfV8nH/3tSl6zm4Ve5kF/xOr/k=;
        fh=LtZqbd010LKemY4yAvFWIG27X237bjlPERHw1tU2/UE=;
        b=ZKer/0tbkCvcpQU2EJecPiun9xHCUyB64qgbOXJuiFRKMF3m9d27hqk7Bab3OArbwX
         1bG8eoy0BlTiQkdpprK8NhRo7bEKXdiot0xkVz7yp2yAtK+a9yWOL3ej2Xqkiqe9Y6jB
         adBKYlMVxHEgF66D9w8j6cC06nobHpwrDohV3ba2OkOS0ZU2ZjP+aEsn/fJ9Fo4AwLcN
         if25URMHzYcCMTHJ/mZJ/GWY99BhHFgPg+t+vrrMNPlh+9p/lGUBX8/zq7iXKW6q9fzU
         VEJhiIZfb0A0ZBqxip5NSN0FOm5hRkDpUl9C2Xt2Pjx0iubK4gMqnFTB/Ii6wddwsJLB
         ZJSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780077379; x=1780682179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBhLxKNmxd00CX8Y6dfV8nH/3tSl6zm4Ve5kF/xOr/k=;
        b=HZEuDqqeitASJAwTDDFaI16iVAWGd+ny6bJE1X3IQaKCsuuWgN+lx88md38ltO/oM4
         hVUslYqnepMfYuoDgRjjNUoXNTAC48ZJXgqawnx8JBqlB8yJ5LaHZvhvIw1T36NKW2U6
         3CUf5eKDF6KMIGHIoXcscRbd02Y6NNX1G0Oia4A/jOyAdjGGP3+SFNEcrCQBr/Pz1yVk
         EGutMsJrNjo0N0ZM7SA8HBl1EV0+D1VrBkuCId4puuhcj2v6S3y5NOWobMLCTFvD0ovw
         k7aXfaOKYzUys9XPWbnZH7YA/U2qpxfphse8gqc/oLNFlLX6UKqJNcjTHkWi1T/sB/DO
         H2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780077379; x=1780682179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eBhLxKNmxd00CX8Y6dfV8nH/3tSl6zm4Ve5kF/xOr/k=;
        b=rSxVn6FmoGuMZgBu9l7ubxGxSZ0Hs2lNNrvh7YhG/s+OxDM8c/uFRrrojsGbfUpNDs
         H+Y9rq5l+UKtI1Q38sVHqj4m8+gs1Qr+LVmpu8heqRsEDTCntYsYQ2kmk519bvw1k+vC
         47U1H5ZUfroAkTSE7zX6RKuWfB0KorTUBf/8g8BsRJYtyMHId+bltfVsZF1Ex0DEIuxc
         oMEDvMx/F3YqYItjKQj/GPmdycCiOtGMRjO0UxiLHsp5b5nZ3wVpG1/ip5Ml8e3CQ38c
         sotJzlzitTzMETgqFcWKtMwvnInIGv7Mc/cmQqKomujd4tIA0o6P0NRe2XWR6IB4NRzV
         HiFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QUYnRw8llssNEaiCw0OUx/xq3F5RvYq5F+LSWequzVKF/QMRPm6BezPmL/gI+nuEVe5NVTUiS5ET4vuAZj12B@vger.kernel.org
X-Gm-Message-State: AOJu0YzjtH4SiD0qX3d0zuCv1fcrnFsgaAKgp+NXZ+3ALw9rkjFc+fEI
	rrf6o8/wPURsXuPWWrVGLMm1ty6UNQFf8p01fS7r0rQFfSUHI1bfWSKR9Dp5atfz2MQnEW0fNDj
	idHTtLFLUlo7YtgyT7VkV5LUw4ayxXL9bJyYLqgmt
X-Gm-Gg: Acq92OHN4jWnkQRCK6rum8abkM8gERR8xV0aT/Qhst316e5zr7WUZ4N0Xkv5SXLCrn3
	dp7WEHdHhzKk3AfcETHyGYGt8Mfc+gVczcpdSC6nj60Z6dmn86+zhFOTi33REsprEF4xzUFbQiH
	uw984eybSqZertvhPQqHjFcUt/AsMFaxHO4oBHMxN4xvQBkNCHd6bO+xP35qPvDtZd1erlllKIu
	057SeOAOVC2XqGpHi+8dO2QAqJFiUVdKwYTvHXGpW+evAaIceiUTNsFxkrCB+SAosV5PD4+qhEG
	XKpW5X19pVJLArCDHvM6tBwNsJxqveGWgCG9kLv4BGPyJUJls871fS1u80w=
X-Received: by 2002:a17:903:1d2:b0:2bc:dc0b:ab29 with SMTP id
 d9443c01a7336-2bf7b5eaa7bmr272955ad.0.1780077378248; Fri, 29 May 2026
 10:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529082451.591783-1-dapeng1.mi@linux.intel.com> <20260529082451.591783-6-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529082451.591783-6-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 29 May 2026 10:56:06 -0700
X-Gm-Features: AVHnY4IoYXfv9ZkqRSzaMyuUdYo8s8LjUhy_34iIpwVo1W_a9041ujP039Hy-kk
Message-ID: <CAP-5=fUkAa9kE-xGRBH80ikqyV7L=x-06UaeDd=TSExy-jsjjA@mail.gmail.com>
Subject: Re: [Patch v8 5/5] perf dwarf-regs: Add SIMD/eGPRs support for x86
 DWARF registers
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 1:30=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Enhance the x86-specific DWARF register handling by adding support for
> SIMD and eGPRs registers.
>
> This update is based on the "DWARF Register Number Mapping" table from
> the "System V Application Binary Interface AMD64 Architecture Processor
> Supplement" (version 1.0).
>
> Modifications include:
> - Updating the x86_64_regidx_table[] array to incorporate SIMD and eGPRs
>   registers.
> - Enhancing the __get_dwarf_regnum_for_perf_regnum_x86_64() function to
>   retrieve the DWARF register index for eGPRs.
> - Enlarge the x86_64 supported register number to 146 to cover eGPRs and
>   SIMD registers (get_libdw_frame_nregs()).
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  .../util/dwarf-regs-arch/dwarf-regs-x86.c     | 138 +++++++++++++++---
>  tools/perf/util/dwarf-regs.c                  |   7 +-
>  tools/perf/util/include/dwarf-regs.h          |   7 +-
>  tools/perf/util/unwind-libdw.c                |   6 +-
>  4 files changed, 129 insertions(+), 29 deletions(-)
>
> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c b/tools/per=
f/util/dwarf-regs-arch/dwarf-regs-x86.c
> index cadef120aeb4..b014a36d21b5 100644
> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
> @@ -90,22 +90,22 @@ static const struct dwarf_regs_idx x86_64_regidx_tabl=
e[] =3D {
>         { "r14", 14 }, { "r14d", 14 }, { "r14w", 14 }, { "r14b", 14 },
>         { "r15", 15 }, { "r15d", 15 }, { "r15w", 15 }, { "r15b", 15 },
>         // 16 - Return Address RA
> -       { "xmm0", 17},
> -       { "xmm1", 18},
> -       { "xmm2", 19},
> -       { "xmm3", 20},
> -       { "xmm4", 21},
> -       { "xmm5", 22},
> -       { "xmm6", 23},
> -       { "xmm7", 24},
> -       { "xmm8", 25},
> -       { "xmm9", 26},
> -       { "xmm10", 27},
> -       { "xmm11", 28},
> -       { "xmm12", 29},
> -       { "xmm13", 30},
> -       { "xmm14", 31},
> -       { "xmm15", 32},
> +       { "zmm0", 17 }, { "ymm0", 17 }, { "xmm0", 17 },
> +       { "zmm1", 18 }, { "ymm1", 18 }, { "xmm1", 18 },
> +       { "zmm2", 19 }, { "ymm2", 19 }, { "xmm2", 19 },
> +       { "zmm3", 20 }, { "ymm3", 20 }, { "xmm3", 20 },
> +       { "zmm4", 21 }, { "ymm4", 21 }, { "xmm4", 21 },
> +       { "zmm5", 22 }, { "ymm5", 22 }, { "xmm5", 22 },
> +       { "zmm6", 23 }, { "ymm6", 23 }, { "xmm6", 23 },
> +       { "zmm7", 24 }, { "ymm7", 24 }, { "xmm7", 24 },
> +       { "zmm8", 25 }, { "ymm8", 25 }, { "xmm8", 25 },
> +       { "zmm9", 26 }, { "ymm9", 26 }, { "xmm9", 26 },
> +       { "zmm10", 27 }, { "ymm10", 27 }, { "xmm10", 27 },
> +       { "zmm11", 28 }, { "ymm11", 28 }, { "xmm11", 28 },
> +       { "zmm12", 29 }, { "ymm12", 29 }, { "xmm12", 29 },
> +       { "zmm13", 30 }, { "ymm13", 30 }, { "xmm13", 30 },
> +       { "zmm14", 31 }, { "ymm14", 31 }, { "xmm14", 31 },
> +       { "zmm15", 32 }, { "ymm15", 32 }, { "xmm15", 32 },
>         { "st0", 33},
>         { "st1", 34},
>         { "st2", 35},
> @@ -129,7 +129,7 @@ static const struct dwarf_regs_idx x86_64_regidx_tabl=
e[] =3D {
>         { "ds", 53},
>         { "fs", 54},
>         { "gs", 55},
> -       // 56-47 - reserved
> +       // 56-57 - reserved
>         { "fs.base", 58},
>         { "gs.base", 59},
>         // 60-61 - reserved
> @@ -138,6 +138,49 @@ static const struct dwarf_regs_idx x86_64_regidx_tab=
le[] =3D {
>         { "mxcsr", 64}, // 128-bit Media Control and Status
>         { "fcw", 65}, // x87 Control Word
>         { "fsw", 66}, // x87 Status Word
> +       // 67-82 - Upper Vector Registers 16=E2=80=9331
> +       { "zmm16", 67 }, { "ymm16", 67 }, { "xmm16", 67 },
> +       { "zmm17", 68 }, { "ymm17", 68 }, { "xmm17", 68 },
> +       { "zmm18", 69 }, { "ymm18", 69 }, { "xmm18", 69 },
> +       { "zmm19", 70 }, { "ymm19", 70 }, { "xmm19", 70 },
> +       { "zmm20", 71 }, { "ymm20", 71 }, { "xmm20", 71 },
> +       { "zmm21", 72 }, { "ymm21", 72 }, { "xmm21", 72 },
> +       { "zmm22", 73 }, { "ymm22", 73 }, { "xmm22", 73 },
> +       { "zmm23", 74 }, { "ymm23", 74 }, { "xmm23", 74 },
> +       { "zmm24", 75 }, { "ymm24", 75 }, { "xmm24", 75 },
> +       { "zmm25", 76 }, { "ymm25", 76 }, { "xmm25", 76 },
> +       { "zmm26", 77 }, { "ymm26", 77 }, { "xmm26", 77 },
> +       { "zmm27", 78 }, { "ymm27", 78 }, { "xmm27", 78 },
> +       { "zmm28", 79 }, { "ymm28", 79 }, { "xmm28", 79 },
> +       { "zmm29", 80 }, { "ymm29", 80 }, { "xmm29", 80 },
> +       { "zmm30", 81 }, { "ymm30", 81 }, { "xmm30", 81 },
> +       { "zmm31", 82 }, { "ymm31", 82 }, { "xmm31", 82 },
> +       // 118-125 - Vector Mask Registers 0=E2=80=937
> +       { "k0", 118 },
> +       { "k1", 119 },
> +       { "k2", 120 },
> +       { "k3", 121 },
> +       { "k4", 122 },
> +       { "k5", 123 },
> +       { "k6", 124 },
> +       { "k7", 125 },
> +       // 130-145 - APX Integer Registers 16-31
> +       { "r16", 130 }, { "r16d", 130 }, { "r16w", 130 }, { "r16b", 130 }=
,
> +       { "r17", 131 }, { "r17d", 131 }, { "r17w", 131 }, { "r17b", 131 }=
,
> +       { "r18", 132 }, { "r18d", 132 }, { "r18w", 132 }, { "r18b", 132 }=
,
> +       { "r19", 133 }, { "r19d", 133 }, { "r19w", 133 }, { "r19b", 133 }=
,
> +       { "r20", 134 }, { "r20d", 134 }, { "r20w", 134 }, { "r20b", 134 }=
,
> +       { "r21", 135 }, { "r21d", 135 }, { "r21w", 135 }, { "r21b", 135 }=
,
> +       { "r22", 136 }, { "r22d", 136 }, { "r22w", 136 }, { "r22b", 136 }=
,
> +       { "r23", 137 }, { "r23d", 137 }, { "r23w", 137 }, { "r23b", 137 }=
,
> +       { "r24", 138 }, { "r24d", 138 }, { "r24w", 138 }, { "r24b", 138 }=
,
> +       { "r25", 139 }, { "r25d", 139 }, { "r25w", 139 }, { "r25b", 139 }=
,
> +       { "r26", 140 }, { "r26d", 140 }, { "r26w", 140 }, { "r26b", 140 }=
,
> +       { "r27", 141 }, { "r27d", 141 }, { "r27w", 141 }, { "r27b", 141 }=
,
> +       { "r28", 142 }, { "r28d", 142 }, { "r28w", 142 }, { "r28b", 142 }=
,
> +       { "r29", 143 }, { "r29d", 143 }, { "r29w", 143 }, { "r29b", 143 }=
,
> +       { "r30", 144 }, { "r30d", 144 }, { "r30w", 144 }, { "r30b", 144 }=
,
> +       { "r31", 145 }, { "r31d", 145 }, { "r31w", 145 }, { "r31b", 145 }=
,
>         // End of regular dwarf registers.
>         { "rip", DWARF_REG_PC }, { "eip", DWARF_REG_PC }, { "ip", DWARF_R=
EG_PC },
>  };
> @@ -204,7 +247,7 @@ int __get_dwarf_regnum_for_perf_regnum_i386(int perf_=
regnum)
>         return dwarf_i386_regnums[perf_regnum];
>  }
>
> -int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum)
> +int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum, int abi)
>  {
>         static const int dwarf_x86_64_regnums[] =3D {
>                 [PERF_REG_X86_AX] =3D 0,
> @@ -248,13 +291,66 @@ int __get_dwarf_regnum_for_perf_regnum_x86_64(int p=
erf_regnum)
>                 [PERF_REG_X86_XMM14] =3D 31,
>                 [PERF_REG_X86_XMM15] =3D 32,
>         };
> +       static const int dwarf_x86_64_regnums_apx[] =3D {
> +               [PERF_REG_X86_AX] =3D 0,
> +               [PERF_REG_X86_BX] =3D 3,
> +               [PERF_REG_X86_CX] =3D 2,
> +               [PERF_REG_X86_DX] =3D 1,
> +               [PERF_REG_X86_SI] =3D 4,
> +               [PERF_REG_X86_DI] =3D 5,
> +               [PERF_REG_X86_BP] =3D 6,
> +               [PERF_REG_X86_SP] =3D 7,
> +               [PERF_REG_X86_IP] =3D 16,
> +               [PERF_REG_X86_FLAGS] =3D 49,
> +               [PERF_REG_X86_CS] =3D 51,
> +               [PERF_REG_X86_SS] =3D 52,
> +               [PERF_REG_X86_DS] =3D 53,
> +               [PERF_REG_X86_ES] =3D 50,
> +               [PERF_REG_X86_FS] =3D 54,
> +               [PERF_REG_X86_GS] =3D 55,
> +               [PERF_REG_X86_R8] =3D 8,
> +               [PERF_REG_X86_R9] =3D 9,
> +               [PERF_REG_X86_R10] =3D 10,
> +               [PERF_REG_X86_R11] =3D 11,
> +               [PERF_REG_X86_R12] =3D 12,
> +               [PERF_REG_X86_R13] =3D 13,
> +               [PERF_REG_X86_R14] =3D 14,
> +               [PERF_REG_X86_R15] =3D 15,
> +               [PERF_REG_X86_R16] =3D 130,
> +               [PERF_REG_X86_R17] =3D 131,
> +               [PERF_REG_X86_R18] =3D 132,
> +               [PERF_REG_X86_R19] =3D 133,
> +               [PERF_REG_X86_R20] =3D 134,
> +               [PERF_REG_X86_R21] =3D 135,
> +               [PERF_REG_X86_R22] =3D 136,
> +               [PERF_REG_X86_R23] =3D 137,
> +               [PERF_REG_X86_R24] =3D 138,
> +               [PERF_REG_X86_R25] =3D 139,
> +               [PERF_REG_X86_R26] =3D 140,
> +               [PERF_REG_X86_R27] =3D 141,
> +               [PERF_REG_X86_R28] =3D 142,
> +               [PERF_REG_X86_R29] =3D 143,
> +               [PERF_REG_X86_R30] =3D 144,
> +               [PERF_REG_X86_R31] =3D 145,
> +       };
>
>         if (perf_regnum =3D=3D 0)
>                 return 0;
>
> -       if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_x86_6=
4_regnums) ||
> -           dwarf_x86_64_regnums[perf_regnum] =3D=3D 0)
> +       if (perf_regnum < 0)
> +               return -ENOENT;
> +
> +       if (!(abi & PERF_SAMPLE_REGS_ABI_SIMD) &&
> +           (perf_regnum >=3D (int)ARRAY_SIZE(dwarf_x86_64_regnums) ||
> +            dwarf_x86_64_regnums[perf_regnum] =3D=3D 0))
> +               return -ENOENT;
> +
> +       if ((abi & PERF_SAMPLE_REGS_ABI_SIMD) &&
> +           (perf_regnum >=3D (int)ARRAY_SIZE(dwarf_x86_64_regnums_apx) |=
|
> +            dwarf_x86_64_regnums_apx[perf_regnum] =3D=3D 0))
>                 return -ENOENT;
>
> -       return dwarf_x86_64_regnums[perf_regnum];
> +       return abi & PERF_SAMPLE_REGS_ABI_SIMD ?
> +                       dwarf_x86_64_regnums_apx[perf_regnum] :
> +                       dwarf_x86_64_regnums[perf_regnum];
>  }
> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> index 797f455eba0d..9e2a0c93ecc9 100644
> --- a/tools/perf/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs.c
> @@ -158,7 +158,7 @@ static int get_libdw_frame_nregs(unsigned int machine=
, unsigned int flags __mayb
>  {
>         switch (machine) {
>         case EM_X86_64:
> -               return 17;
> +               return 146;     /* Support APX eGPRs. */

So the 17 comes from libdw as I believe there are places in the libdw
stack walking code where additional registers cause libdw to fail. The
key is `libdw_set_initial_registers`, which passes the flag
`/*only_libdw_supported=3D*/true`. This is where capping the registers
at 17 will have an effect. Presumably increasing this value requires
some degree of libdw support? We could add a feature test for this,
but it may be safer to leave it as 17 as it is unlikely we're using
vector registers when walking the stack. A comment capturing this
would be good, as clearly the intent in the code hadn't been clear
enough.

Thanks,
Ian

>         case EM_386:
>                 return 9;
>         case EM_ARM:
> @@ -187,13 +187,14 @@ static int get_libdw_frame_nregs(unsigned int machi=
ne, unsigned int flags __mayb
>  }
>
>  int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machi=
ne,
> -                                    unsigned int flags, bool only_libdw_=
supported)
> +                                    unsigned int flags,
> +                                    bool only_libdw_supported, int abi)
>  {
>         int reg;
>
>         switch (machine) {
>         case EM_X86_64:
> -               reg =3D __get_dwarf_regnum_for_perf_regnum_x86_64(perf_re=
gnum);
> +               reg =3D __get_dwarf_regnum_for_perf_regnum_x86_64(perf_re=
gnum, abi);
>                 break;
>         case EM_386:
>                 reg =3D __get_dwarf_regnum_for_perf_regnum_i386(perf_regn=
um);
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/inclu=
de/dwarf-regs.h
> index 46a764cf322f..92cf0af93e9e 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -103,7 +103,7 @@ int __get_csky_regnum(const char *name, unsigned int =
flags);
>  int __get_dwarf_regnum_i386(const char *name);
>  int __get_dwarf_regnum_x86_64(const char *name);
>  int __get_dwarf_regnum_for_perf_regnum_i386(int perf_regnum);
> -int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum);
> +int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum, int abi);
>
>  int __get_dwarf_regnum_for_perf_regnum_arm(int perf_regnum);
>  int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum);
> @@ -125,8 +125,9 @@ int get_dwarf_regnum(const char *name, unsigned int m=
achine, unsigned int flags)
>  /*
>   * get_dwarf_regnum - Returns DWARF regnum from perf register number.
>   */
> -int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machi=
ne, unsigned int flags,
> -                                    bool only_libdw_supported);
> +int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machi=
ne,
> +                                    unsigned int flags,
> +                                    bool only_libdw_supported, int abi);
>
>  void get_powerpc_regs(u32 raw_insn, int is_source, struct annotated_op_l=
oc *op_loc);
>
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 05e8e68bd49c..678db5a65ada 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -273,7 +273,8 @@ static bool libdw_set_initial_registers(Dwfl_Thread *=
thread, void *arg)
>                         int dwarf_reg =3D
>                                 get_dwarf_regnum_for_perf_regnum(perf_reg=
, e_machine,
>                                                                  e_flags,
> -                                                                /*only_l=
ibdw_supported=3D*/true);
> +                                                                /*only_l=
ibdw_supported=3D*/true,
> +                                                                user_reg=
s->abi);
>                         if (dwarf_reg > max_dwarf_reg)
>                                 max_dwarf_reg =3D dwarf_reg;
>                 }
> @@ -288,7 +289,8 @@ static bool libdw_set_initial_registers(Dwfl_Thread *=
thread, void *arg)
>                         int dwarf_reg =3D
>                                 get_dwarf_regnum_for_perf_regnum(perf_reg=
, e_machine,
>                                                                  e_flags,
> -                                                                /*only_l=
ibdw_supported=3D*/true);
> +                                                                /*only_l=
ibdw_supported=3D*/true,
> +                                                                user_reg=
s->abi);
>                         if (dwarf_reg >=3D 0) {
>                                 val =3D 0;
>                                 if (perf_reg_value(&val, user_regs, perf_=
reg) =3D=3D 0)
> --
> 2.34.1
>
