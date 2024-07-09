Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821440861;
	Tue,  9 Jul 2024 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500246; cv=none; b=hpZdAPutvnZTJhheSK8LSKYb5ZGLGpGeHBXPAkFp5ZJvXwGvuA5s7vyRKvCkXcTR4VEktTFYZetJ6tiwxM/5Z1ouA3ZnUVfJ54trSWwWF7aG6gTAFYC8s4vJQq9LIMiC5FiMKGg5pdi8iL7niEwx/W7s7cM4jt79KV5cO2YIx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500246; c=relaxed/simple;
	bh=uVd3/+hZmwtOcRjfTLqueuyazv4xkNu8knI1pzVhYcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQNmNC7UH4XKHVUl9rMuFTwDUKHBL4WMTr4ebgbm8b64yY3wdHN22zNhxOx58N4yn5C2TOzEaFqDpVILY3wV0irnP1Z1lszs8zUP/xBMMrxZg7RCKG7+N++yHezVCsfacYXWCu0UDlEZEfPShAW0P4AVOv231BV4XO1BQpGSisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c9785517c0so2771866a91.0;
        Mon, 08 Jul 2024 21:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720500244; x=1721105044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqMMZdHbLQLK0gY06sGdThaDPsXAGjfdIECfbylM8Ps=;
        b=F6UWs+Rzen1w7Yg3BgWnbctq+S8ZyHHAHzL4ACzTS4RFYmV33imKxtlgAKi4Xk5j+I
         8ZcokNQ42+O4UZ1eHhujY4c0ENtBldSOq6/AfHCND58PU31pv+tTM2oolU4UrSjCIFZx
         fQiKwjsi5N3reiDEvetetoZnvsuiV4KNlMv7pjfHbeB/8ZKtqiQdMdWJiMxKkDdW8gRk
         FeGRnEm/Eoh2lD0nzqIbtmwDL9XLMaOPatsfs1uETn/Fs/uyKKmIAOx2YY/JXI9G/JLh
         Xm80nvgxaiA5p3rfI7xt3ra4hhZA1Bk216jRS20sP71bUfnIonNEjMjxhDLgIMcEykRX
         GMqA==
X-Forwarded-Encrypted: i=1; AJvYcCUA6yA1mtjrzJaPiu7/Gc0wA/P8DsuQx7Z8Iqn3SkqAlOUEw4S+9qWuv+xtn3siZuJB8Rx3CC/BZ3Sf0PQYeb2CKg+6uZx78qZuYf3fkg7dtpRghrRWouFSHOLpTFXPs0KuNPZPNYlCRZbGBrIikQ==
X-Gm-Message-State: AOJu0YzHVsw8arekRTb4CvuwN54duPogRgbRuEZuDPo6L/EY+6GumrOh
	wX0C6kAgAgJrdApgHaQYQJ/IU9ZBa0xHLk5tjqZ/c29KUqKtNjs2O02CnUhEqM2bp7thFiAnjUE
	mYIeGsDhUQwLnmJqYreyGcF2emAk=
X-Google-Smtp-Source: AGHT+IGkL1XkIndrUWgyyGsQnjdjaDCeqa9y6dsZQ+3CLzvnvKQ8G1exyOPYGl2py2WNElzth1WR5C+EP+v1VZ3SmI8=
X-Received: by 2002:a17:90b:1c0e:b0:2c9:57a4:a8c4 with SMTP id
 98e67ed59e1d1-2ca35d5c8dcmr1275315a91.42.1720500243934; Mon, 08 Jul 2024
 21:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706232956.304944-1-weilin.wang@intel.com> <20240706232956.304944-9-weilin.wang@intel.com>
In-Reply-To: <20240706232956.304944-9-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 8 Jul 2024 21:43:52 -0700
Message-ID: <CAM9d7chhVAG9wpWdQM4DRriM_kp9vjFj=_ak1+0qyO-sRdXs4w@mail.gmail.com>
Subject: Re: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS counting mode
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

Hello Weilin,

On Sat, Jul 6, 2024 at 4:30=E2=80=AFPM <weilin.wang@intel.com> wrote:
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
>  .../perf/tests/shell/test_stat_intel_tpebs.sh  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
>
> diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf=
/tests/shell/test_stat_intel_tpebs.sh
> new file mode 100755
> index 000000000000..fea8cb1b8367
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> @@ -0,0 +1,18 @@
> +#!/bin/bash
> +# test Intel TPEBS counting mode
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +# Use this event for testing because it should exist in all platforms
> +event=3Dcache-misses:R
> +
> +# Without this cmd option, default value or zero is returned
> +echo "Testing without --record-tpebs"
> +result=3D$(perf stat -e "$event" true 2>&1)
> +[[ "$result" =3D~ $event ]] || exit 1
> +
> +# In platforms that do not support TPEBS, it should execute without erro=
r.
> +echo "Testing with --record-tpebs"
> +result=3D$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)

It never finishes on my AMD machine.

Thanks,
Namhyung


> +[[ "$result" =3D~ "perf record" && "$result" =3D~ $event ]] || exit 1
> --
> 2.43.0
>
