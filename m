Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26DE2F7AAB
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160007; cv=pass; b=g5hqgF0R6Dw7tQKh4G26bmw+bJhw8wxIwFB/YflnC0WDR4XtREB8WP1csz/R30fIFxfBPA5PseWDNCOnhiLEAw8H6wUQW1jz1ToGMtA/QruPRebmPGOazSk5wuffhhTWSYrLCu22DBAtCS7hDzROinhARojJU8trnLRqU8ioN2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160007; c=relaxed/simple;
	bh=93ytCWhm+7HfW6uqJrrD6twD+UxPO31wPTRFzIBkefE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bshl9wtp2PS6kMxqVR4lvA+pqChX0Gc048E6c4V/F53MKujVI2VuqJH1BKSSV/nyxp9pvj7qP3zih67uZaIMfIPQ1GES4bC0yQofFscnjMYDxuY1XjoRW1KRFSuZYgyelE0lpEASdEfgbPoqUDChAnH1nObAjNMFkpqfyHaOG8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KheWY9Nv; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KheWY9Nv"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a885af8ee7so11735ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 15:06:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770160005; cv=none;
        d=google.com; s=arc-20240605;
        b=kgvVLt0FTWEuvdddK+YqUHaF4WBFlW8s/txZB9AIc3xpRcUWiS2oosEQsp8mQ21CZ5
         VNd378P0PDXmLdG4/Zkpu3bLnxzii0gpSWBQYCHblTcKD/vFXdC6mCpRA0FVrEXeeOOw
         cbgox63s1L+whejAmPq268VWYFy9elhumst56wGQ7WbNvgIZaJXnyS504IZ3QltvQjEn
         OQcon27VEjyhZJybS8tArMLeNZCBFyA5HgYCN6jj/tSYNWnf3i6CJPvmjRvAeza4NYgf
         DQOLRpkOwX9koczGuMMRlFgYBo/6xLQFVGxc00LbhJnVw2QwW+YQmYebjfaPMCPcLd5r
         wctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WhW0Z5/bDcVlEnz8k3eYAJjeqv5PflWO94icC/kx//A=;
        fh=ekJLtXBN+gHQoP70/4fmdhWO9QbRLIcoQt86ih3q4aM=;
        b=j2ZFG04DddfiKm5VzA3c6y0HYAWAut3E9aT1V9Mybi9i1zc64wfiA4dKZJzS83jRJe
         wX5XdfqtRa5IlLT/IjraM070xJ2JitWQDH+L8VCB8+7a1EDCDbhAY2K6BW4Ik85CNCn0
         Z+yznDmkWWNXT+upRzAKYjsmgURJD6BvPJy89+eCi6dKJ9m7Es0VCnjGZPsXXDMnoHaN
         dVRtMNVH//Ve9O4zvxno1vO11QgLP3Z9Pg7sgJn4OYC9tybkGqmBsZ9gdwz6Gwm7LrpI
         BE+EB3OxClVXo2LMjBIgsGkQ480HOK/EqygO8OasCDlbwe10pT/SpBFhIJwn/IN2E1sW
         6Ngw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770160005; x=1770764805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhW0Z5/bDcVlEnz8k3eYAJjeqv5PflWO94icC/kx//A=;
        b=KheWY9Nv6hyOKrwUdJyXvPPlmnnPoFMV9MSo43gAd/JCQHRGhdqNb8AhuCubK3PawX
         dkmbCEMgl7EMno2eiBfuQV3rXRIhjGbaYi4+dTMPPKazY0YA8h6owylAJt122sU3GueY
         kbbUptKh5lLhPREUzp8LaSaJQkzBACZQ54uMmqshqgRhdqRrxVYw3DYh99eMHjgf4Kjc
         oXxmfkZ0cEBMIg5F/TU5cbORPkzu9asdy0V2dCWuK68bDxPVan2GJFZTtOLgCkamA8dZ
         y6ljD+9PFVAy6xJEf6LxTmtgwMHZxjJAuyzp9UYB/SWSLd5NaPlV9dLMudc/xsRphf0Z
         99Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160005; x=1770764805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhW0Z5/bDcVlEnz8k3eYAJjeqv5PflWO94icC/kx//A=;
        b=EMJBAG/OWDqCUkxzVsEACQUD7mC7IjPaz2pNTq6MFXF7HK9JfODiMIggIuU8k03Yh+
         E2zAIDrLA18rqs5hzjJh54GRvQdn79buMNqaOVQGaDP1KhWpel3jbv8pL5DXf5OR2IRq
         fwWj6sZguKf24bdx0DH3nUxPMYIuTPfwEAVVSO5lYVVa5d/MXF9Ubi1C3ldriPqJONYb
         rt4S+L6vD4eUhmy7Kk7zduu8GrQM5ttJnKZrlcbRORCeY0R1obj5Pyo1m1trIRRRTVTy
         2xVuaa/25wn3gqxJSy93ZoOloQJeiH00UnFjI79wAnatX9F/WZZmFvsC1gMFqSQd2QWE
         clXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAnWGlR+YuBwlmJwMCR9lPi6RCVA2MgnZGMbasf513S0QoGFB9NeuPaFD8SOEwf3d72cByMjX+MaPKLAB/2L0b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0QSu3TIBIwMz3scemqiAvS0WkOtMIe1Yoh0JeFNtFdP505lh
	ZoVxV+oJkkZdKreT1CgE8fjmCGZp0NSxohumUOgWnIE+GhSupwVazeeVmr+BIGTYxpS3KsPBx3U
	1Pw+nD1XXFa7ZMBnx6Wq5rPeOnmVFvbHyUdvyXI+f
X-Gm-Gg: AZuq6aKKbZpUzrry5HIxCSJyG4CIn+JbK2v5ni5lvLTrDnaqJHPyIdsXUuDWf7LdXYK
	y7yvHFxUs9mRMDZFw0CAtJL8P9MYeVNPKRN0GmKulK7kwo2OE/95xpVFIEShRTgaEqoqsWnbxdC
	SKYl+HzpKHvAxE8A8YFk45Dn2uRC2/6YE3IO/BRE8HTd9JyPqRDbPTyWEJ2xxXbuWps399qvSGQ
	Nghr6aj0icPqIq3O2X5AJkZ21ybkv5Dl22ZHgisjG3AtrsuHeCxygYPd5XdGZx9BFZS2XoxUdBZ
	hPJmKUYMji5Yi22eb9yWUy9F3A==
X-Received: by 2002:a17:902:e543:b0:2a7:7f07:340e with SMTP id
 d9443c01a7336-2a9344ae075mr1024005ad.4.1770160004714; Tue, 03 Feb 2026
 15:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203024356.444942-1-dapeng1.mi@linux.intel.com> <20260203024356.444942-2-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260203024356.444942-2-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Feb 2026 15:06:33 -0800
X-Gm-Features: AZwV_QgPh6Zuh81ytCB2QhBaLQojIu2yqs-k71pIg-mHSzTgbaREXv2IKP173Cc
Message-ID: <CAP-5=fU7V2KT6Ce+mk5YbyHggxvRfsoiSzZk4g0CYcNK4NGT2A@mail.gmail.com>
Subject: Re: [Patch v3 1/4] perf regs: Fix abort for "-I" or "--user-regs" options
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 6:47=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.co=
m> wrote:
>
> Fix an issue where the `perf` tool aborts unexpectedly when running the
> following command:
>
> ```
> perf record -e cycles -I -- true
>
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
>
>     -I, --intr-regs[=3D<any register>]
>     sample selected machine registers on interrupt, use '-I?' to list reg=
ister names
> ```
>
> The usage of the `-I` or `--user-regs` options without specifying any
> registers should default to sampling all general-purpose registers.
> However, this currently causes an abnormal termination.
>
> The issue was introduced by commit 3d06db9bad1a ("perf regs: Refactor
>  use of arch__sample_reg_masks() to perf_reg_name()"). This patch
> resolves the problem, ensuring that the `-I` or `--user-regs` options
> work as intended without causing an abort.
>
> Fixes: 3d06db9bad1a ("perf regs: Refactor use of arch__sample_reg_masks()=
 to perf_reg_name()")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/parse-regs-options.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse=
-regs-options.c
> index 8dd35f50f644..b44b47d9059f 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -66,12 +66,14 @@ __parse_regs(const struct option *opt, const char *st=
r, int unset, bool intr)
>         if (*mode)
>                 return -1;
>
> -       /* str may be NULL in case no arg is passed to -I */
> -       if (!str)
> -               return -1;
> -
>         mask =3D intr ? arch__intr_reg_mask() : arch__user_reg_mask();
>
> +       /* str may be NULL in case no arg is passed to -I */
> +       if (!str) {
> +               *mode =3D mask;
> +               return 0;
> +       }
> +
>         /* because str is read-only */
>         s =3D os =3D strdup(str);
>         if (!s)
> @@ -104,9 +106,6 @@ __parse_regs(const struct option *opt, const char *st=
r, int unset, bool intr)
>         }
>         ret =3D 0;
>
> -       /* default to all possible regs */
> -       if (*mode =3D=3D 0)
> -               *mode =3D mask;
>  error:
>         free(os);
>         return ret;
> --
> 2.34.1
>
