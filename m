Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0311E260C
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043853; cv=pass; b=QiEDzlFq7aZW8idKwJ1M65Rw9OwREucRIn13wAJR0u7/7NgNnlxUChgR2H/GGiiPK4X0h32mmOWg+ikhhDsIdSGEXvhfIhjW9cY8vaNzg/ozvQ37SxLlBFNNKQwcib3Fv70MuioPEnLmfvW2kH3ghUXLWVY4WH0xbP9lXz+oC7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043853; c=relaxed/simple;
	bh=xrganjra/8ku0pc8jF62krN68Zb8FDdPJzIOMu1tWb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trVdDXPCvilT+Pz+ZfL2D9UAC1jpqjBo7Ggfj4s9FZfjedmLsovKFe8MPKgavBqzE/M2uqiAxoB+/aGChV7IPdHu45zQhua2xH4kAvxXj7a06nFnsgO9DAVDm+/DWpmERZpsEZUhG51WQThVpO5l9dcDz9wgyn1V8oUgazZvb/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eb61jZZs; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eb61jZZs"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b462bd12afso8475ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776043852; cv=none;
        d=google.com; s=arc-20240605;
        b=kvYqWUPW1s0WhjJP+L328OX7U4M91jFjGyD5u57JS+G4XXOMU3t3FhBTfdleg6gXDC
         uZKS/o/42gobqSb+tEvUacLlDacSHwzF9vdy89XAgFFioZSmM6q4h5fOJIBPvzK2SAr0
         sGwG7kk8ucIsnn0kYPZbGHU7WOGeiKzaZ5BLIJMoi5xj5Hicdpo4yvHVXOFYZk1xiHtx
         LbEWnA2ajJwEflQEsMW7Ycbbqbv+GZAeMIB37p9xKzFwEJ2PbEDSqAlYedfUc9EkrH+v
         nQaILT0knBYISwYw8PgvZyXd5huggimggzi8640ODMW0KO9is31A4HywHLNcIe2ndS06
         MXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=674FhuOvc4SjamR07S0QD2U2Ypzb7L8rK+c/yvYwuuY=;
        fh=g0/vvtZ8dJratUq2DmpBrdPMbrsdWnL4KQ3klQfoByk=;
        b=BHdomFiym3y6ZB9gS56Qy3V9jixI1fpNvkJqP62nLTSmSrK3doN1alhu4rpInVJIYI
         Wja8QaOLzNz8a9a6UAKqvi/b4RihLla4oBmA3AQknHPIofoTKGj3B/sfCv8JesGsVbSJ
         9cgs6U44e/bzrlS328f8xSlJMtzVGoNgEMDXe1pT4DtBv/KCvp1U6D3/0q4gZjw9Oboe
         bJ/R4sdmY2gtCbvNb1Rfid4+sXr5H9+Xto9z5UbFj1wwgTY6DhFLeYnK9JX4ouNpZF+e
         31b3/WYJetTSGuRSHR4h0hjcxHzfzube116PlYjeFYwEIt7ySltUUROYU0FSNFuorUfv
         donA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043852; x=1776648652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=674FhuOvc4SjamR07S0QD2U2Ypzb7L8rK+c/yvYwuuY=;
        b=Eb61jZZsU5XjiroALwdmfFEPMUZv51WHvLuEhxYKy7+ygOhpnzuvEgrPscfKMNGdXr
         okSNhpB1kjIBPiaaTjnQIQo0uZ7QkzWsueqx72+2ojmAEFNgQvatJNzFqBkt4e9IYAzO
         Qo1yOFLOQzMdBBqcX1ktQWsgckQmGJB+QumTkwqNVqoMZ1PD5q/C0AxTXMiWJZOS22sr
         60sxPcaIY4Ara5faTcL3aJ/FQn0fAl4lqjT0jZJfHpDXRW/bnAS3hM0qe5jdniV1R9jd
         veCdYzrNS2Lqewg/MulI+HOPY8ptvc3GysLmoGKvwTup7TW7cSmcb+x+vSQMzS4qFV5w
         hP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043852; x=1776648652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=674FhuOvc4SjamR07S0QD2U2Ypzb7L8rK+c/yvYwuuY=;
        b=nw0qLaSYMLhrP+5sPOPdQ2KyJVduLCEjap+867fgikrIDdOAqY0KNsWMnMzwHsBdGs
         a3W0cGgn9hN23qCwnqp4GU5aLE5FO7Vic/Aei4Lt16A7rf0c/A3eQtjblqvG3HLWhdac
         gw8Fx+snngBQhEQF+9bCvrjEYNB/5sgDdRx1UMibz8LF0FSJFAYvbq1c6RJJwU2jBA+R
         wCXmDzX3NNqdugCh+Yxir/LovAjfkgne+zfF5BdNhpliVtZ3NaSlg4H2BByDdNVzajcJ
         dKTC5YpB5QzA89FXV3Vaq4cIZ/Kd8Lz0WKdfShwG0b3S81cu6TMxMnjLQlhRoGeBhV9C
         4+qg==
X-Forwarded-Encrypted: i=1; AFNElJ8gJ9xBLR8qNPvmOOgnPLeUv1iktOVLdgUeJQCLl+1C/8CwKnyNt7uLkAyocwSs9EuauEuuXh1IpZgum4TC6wKF@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+D/N4Vw2ub1Mk2RZwBB3FnsKS9cYr6Wlsh0xkCRNT+ha/FPk
	fCOYW+T6lVzEdXAGSjh53Bebh5j6x3mxSnmJTe2MhC56SSsW+udlM2jjDBN/l/8giAQAdRfsl2H
	8t+ms4MCxfTDNNuW71llkbVMbFem40wUo1+eXEOeHAQgQA/hTB5eEyGr7
X-Gm-Gg: AeBDietgGdej2pYn3EOFlTXYP5TnQ9Y2t6TS3jJerzblqNUiOGIxliYJfXc7QKMbCjv
	1XPQnuZb9ZvpkAz20TlLxvN+xjFNyBSGTUlc4+ioQjm0529P3nbQA4aDbIF94DhdppxS13tNIT6
	SihP6GVyjzJo8aW4qVxFj3In+nFQ7iXvaE0PYxY7z+03we5g2sB9t9khht/LKrTr5x4GOgztlN8
	BcpTPrkM6a05bKB9M8A3KltckLdtU92ueHkK3LAPC++MewlrtarBhgZgkWhXdb5g/z6WzqEAxkB
	Ls8IzBsPSIcOAdAglLKSFWPWB+AVGw==
X-Received: by 2002:a17:902:da92:b0:2b4:6130:f63d with SMTP id
 d9443c01a7336-2b46131077cmr282135ad.0.1776043850785; Sun, 12 Apr 2026
 18:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413010920.546501-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260413010920.546501-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 12 Apr 2026 18:30:38 -0700
X-Gm-Features: AQROBzDI0sLq5tFf3_WQcx03poG5tnNBt2lAZ92BLlZI7xPm0sAlC8HdPp9Jiu4
Message-ID: <CAP-5=fW0Z0zXDjqR_tpJbT-0nbyXQO-Zcc+4Fpk=XejYX8uF4g@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Add auto counter reload (ACR) sampling test
To: Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 6:14=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Add auto counter reload sampling test to verify that the intended event
> records can be captured and the self-reloaded events won't generate any
> records.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/tests/shell/record.sh | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 7cb81cf3444a..1068843282f5 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -402,6 +402,47 @@ test_callgraph() {
>    echo "Callgraph test [Success]"
>  }
>
> +test_acr_sampling() {
> +  events=3D"{instructions/period=3D20000,acr_mask=3D0x2/u,cycles/period=
=3D40000,acr_mask=3D0x3/u}"
> +  pebs_events=3D"{instructions/period=3D20000,acr_mask=3D0x2/pu,cycles/p=
eriod=3D40000,acr_mask=3D0x3/u}"
> +  echo "Auto counter reload sampling test"
> +  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/n=
ull
> +  then
> +    echo "Auto counter reload sampling [Skipped not supported]"
> +    return
> +  fi
> +  if ! perf script -i "${perfdata}" | grep -q "period=3D20000,acr_mask=
=3D0x2"
> +  then
> +    echo "Auto counter reload sampling [Failed missing instructions even=
t]"
> +    err=3D1
> +    return
> +  fi
> +  if perf script -i "${perfdata}" | grep -q "period=3D40000,acr_mask=3D0=
x3"
> +  then
> +    echo "Auto counter reload sampling [Failed cycles event shouldn't be=
 sampled]"
> +    err=3D1
> +    return
> +  fi
> +  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2> /=
dev/null
> +  then
> +    echo "Auto counter reload PEBS sampling [Skipped not supported]"
> +    return
> +  fi
> +  if ! perf script -i "${perfdata}" | grep -q "period=3D20000,acr_mask=
=3D0x2"
> +  then
> +    echo "Auto counter reload PEBS sampling [Failed missing instructions=
 event]"
> +    err=3D1
> +    return
> +  fi
> +  if perf script -i "${perfdata}" | grep -q "period=3D40000,acr_mask=3D0=
x3"
> +  then
> +    echo "Auto counter reload PEBS sampling [Failed cycles event shouldn=
't be sampled]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Auto counter reload sampling [Success]"

Thanks Dapeng! Could we also test ratio-to-prev as well as just the
plain acr_mask?

Thanks,
Ian

> +}
> +
>  test_ratio_to_prev() {
>    echo "ratio-to-prev test"
>    if ! perf record -o /dev/null -e "{instructions, cycles/period=3D10000=
0,ratio-to-prev=3D0.5/}" \
> @@ -457,6 +498,7 @@ test_leader_sampling
>  test_topdown_leader_sampling
>  test_precise_max
>  test_callgraph
> +test_acr_sampling
>  test_ratio_to_prev
>
>  # restore the default value
>
> base-commit: 4e03d6494f9504f8af46ba68a2a8b6877c196789
> --
> 2.34.1
>
