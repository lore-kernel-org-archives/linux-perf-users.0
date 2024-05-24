Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C885936;
	Fri, 24 May 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716593057; cv=none; b=chq4SgdhhnUVKlYsWZPEPCxJHgzmz9hdyKMa3xfEy3lHNrZkvx7dlx6f5ojqolR/QBAv43VHClebu3z9V8wI62hW2WEkhUOAqYiaS93lwOzBGcoN0lgBvk6ltAeKl3pSYsr0soUbxhrVON12I9HKMxQsNZZ3hrNu6Jb6h6nbmmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716593057; c=relaxed/simple;
	bh=jeGSZEblFR9O8TVzYhKnPHfChmV2IuXAfaybcxlkpZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFXa0eQ5TXiS3bmURqAi3J/uM4/oqSqx91CcsRZ96o7iWcTs7Ly+Vs//GTPH7whHoLLgM2I1uhl1VQ5yzEFrX2yFSy7lKtme6Mmze2kb6nWLXwSPW+2ImvnzsbTbbc/Id0D5inNZVs96/XIgrcTzrqwmCYgiWIBsiXl1CeNpCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-681907aebebso1038691a12.1;
        Fri, 24 May 2024 16:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716593055; x=1717197855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jo/txYd16OxYeeZkLVhwLQWYv1aQLPqjfT1NvKfIevM=;
        b=ekN3csE0xENgciMILa0X4YgEIHQ3N4LnbDlOTNddjpRh66YHV/v0Q3klVF3T3eVded
         XFoqSo+nl2FnYDMIJvcHcUIG06UBAyr19ajvPJk+qAv7ylSt7VSLnyCbcGeHUfoAB3fj
         V56zQU3+dW4CALx0GzhFgCE4A4iOVrKB9fr7NIQZb+4FDHPVPY4r0F9go3x3KDZ4zQ/s
         xy6wGsLti8zVFJ9SNRwij3UFzFP+4Vy1muiWM8qdMW3aA1ezuNQhBG6+mXv/D/nlcpkv
         rBKLFwQ8ZNRtM/WLCrdypS/jZWQph58CqwQc5MlmNd+PdeYcPFPBocrtc5kVcMm4XabI
         jX/A==
X-Forwarded-Encrypted: i=1; AJvYcCX2vTojkQB/QUiMhdVQ/0lHd5lhFYWWYNbUTPTP7MrYIPiIwPcTekAITs32IxQe+F4Nz4orUi/V34XU4YeB3Z7oc5JiSjCNnEm1zchsAseaFyNk1bo4ff/Gtb3RGUc3vioXFauplMCe7sdszNzg/Q==
X-Gm-Message-State: AOJu0YzF1QaNGo/bEe4VcwlRWLhQobm7jE/RUuRDSUKKGGV9JBBPbzRm
	Zoyao1HQTpjUiK8pUr5NT78ZQq2CoBpHaZ3KpT16b5SQK/+R0080gsLwVmVvw43dCqCgAGs4zGZ
	xc2bkCthwQSrSyCfby+RBBi1vqW0=
X-Google-Smtp-Source: AGHT+IGXua6kfTNtBBYyloM+krOmAkK6BdjlZv8CxAm3MIEa+JH5Q3Zi2AfslEz3dq5APKwiu0hiZlbQqnR2vvUhkUk=
X-Received: by 2002:a17:90b:1bc4:b0:2b3:5d8a:a13f with SMTP id
 98e67ed59e1d1-2bf5f7547a7mr3282122a91.47.1716593055660; Fri, 24 May 2024
 16:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521173952.3397644-1-weilin.wang@intel.com> <20240521173952.3397644-8-weilin.wang@intel.com>
In-Reply-To: <20240521173952.3397644-8-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 24 May 2024 16:24:04 -0700
Message-ID: <CAM9d7chURO---Gw1M+T9AafgAJHsN=sOqQzqx5M31RR57m_i2A@mail.gmail.com>
Subject: Re: [RFC PATCH v9 7/7] perf test: Add test for Intel TPEBS counting mode
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:40=E2=80=AFAM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Intel TPEBS sampling mode is supported through perf record. The counting =
mode
> code uses perf record to capture retire_latency value and use it in metri=
c
> calculation. This test checks the counting mode code.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  .../perf/tests/shell/test_stat_intel_tpebs.sh | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
>
> diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf=
/tests/shell/test_stat_intel_tpebs.sh
> new file mode 100755
> index 000000000000..4cb749d84367
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +# test Intel TPEBS counting mode
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set e
> +err=3D0
> +
> +# Use this event for testing because it should exist in all platforms
> +e=3Dcache-misses:R
> +
> +# Without this cmd option, default value or zero is returned
> +echo "Testing without --enable-tpebs-recording"
> +result=3D$(perf stat -e "$e" true 2>&1)
> +[[ "$result" =3D~ "$e" ]] && err=3D0 || err=3D1
> +
> +if [[ "$err" =3D=3D 1 ]]
> +then
> +       exit "$err"
> +fi

Probably you can just do

[[ "$result" =3D~ "$e" ]] || exit 1


> +
> +# In platforms that do not support TPEBS, it should execute without erro=
r.
> +echo "Testing with --enable-tpebs-recording"
> +result=3D$(perf stat -e "$e" --enable-tpebs-recording -a sleep 0.01 2>&1=
)
> +[[ "$result" =3D~ "perf record" && "$result" =3D~ "$e" ]] && err=3D0 || =
err=3D1

Ditto.

Thanks,
Namhyung


> +
> +
> +exit "$err"
> --
> 2.43.0
>
