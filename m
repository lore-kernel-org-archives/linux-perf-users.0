Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7883F58E1
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508291; cv=pass; b=rMDLSI5mnXHBOI9IHmIKrZgmSoVf5KR2j/HgPsnDXBt/u7lyUwbMjb7vt0OD6cRaYGo67NfdlZ5n35SW/z/cXOz7oJMGfdW1LMAcItuNJNnQ/qv1NEUom8qmiKePVL7DCZksQ/Guj96wOYmyh8poFllZsUU6y9L5WedIXS/QqM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508291; c=relaxed/simple;
	bh=tf5+kz+Lwb+AcipCZSgN40n6BQ/fgFd7+xB1pxv4OC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3IqE8R02wKRXIYeC70G1TJrviuVE1Fux39eQvHentdcxqH58ksKnD82gWkXPxqnKXDivZgY00Xx1QNWPF3u3gMEprJREbTdNNjX67j6DnXHBGw9GK/yR+CdNZZVWCzfDZtLeeQ+yPOBT42RHKy/mZNpgVhLTdqtu71a9XSvXDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwkfbaz5; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwkfbaz5"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so35741cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 14:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789508288; cv=none;
        d=google.com; s=arc-20260327;
        b=LA4aVxyb5Syub6nRbtU8gejKFQas8HdqlEe+9irmAAnbLK3buDpJxPLcwGD20VxeAT
         y+jMNU5O+saU96CtbXgMIG9VWRhE58KuVi3AUwMoyoR7Qo8vz82f6W2vZZHXrlrKOU2c
         wASJxIY36KFEczak1OvngV+SEe/IZCAn9zjIACpO41CBkN3MrCSNbyQDeStix3Y9O0TX
         Sfd7sfDNRKtUt+ANdv794gMiNIiaMjXx+dI3AACDh6MC8YzLbYdxrvx/Wdbq53gOVLSm
         Npy9eQxvc0QGQcUd3IdMUywNlcmUiKpr0ylIgNYie2tMK0D3xxcxTIz4pu3uOCESDVcd
         Nswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uj/SZ3uO4mBIi6FG9GIM3H53q5vTFxwH5yPRdSUlx/0=;
        fh=SHq4SHpiEKc/uVxFixyd7hHub++CCnvNaumMNgrgmnk=;
        b=cc6Zfti+gBLLBm7tDBBggbQzbWJL//Czrry/jroDp01meMY6Pkd19Yy+i+4J2ubkiK
         ozuOWCOq1YocTKW86e/9aY0DkFePK2yF6rptZFGh+FEyx94xi0yo2GaVEv6mc860NFPi
         keVT/3AyUM7MyGqXK7Pel0muLM9kNHYOI9oOYvZ0hMBN8um7TUMPF+NOxnzjFKwHbOw/
         7cUY7o0Y/7IH0UHXwS7bKLo4qP4/pRM6wsqYH3ii4a0jagVEjj82HiCA+ztctH4W3foB
         fhev9Kimn3cRH2bwq8/oLVlZt8cRrUqBwU7/HvRNnELOxjV7CfaN13y0kEuKOB3Ef4M/
         pGrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789508288; x=1790113088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uj/SZ3uO4mBIi6FG9GIM3H53q5vTFxwH5yPRdSUlx/0=;
        b=cwkfbaz5a4m+Nb7KZjvCBA58pWgvnKJT+UdeI/8hhp0EulrdCcgahF+VfSg0Ig+eEu
         YXwuLIZt10n5osIwawZrVkAetKqXTWms2a6GNVd/5Isnq3S3qbCl+CvFAesmVPXWCX2U
         98NKf277/oc/5pzTJgzP/CW8afz2mx4SsxH82CMTl7GqOewDr2UrOjZ/3xPXL3W+I2un
         G4N6Ari7plSsIydxP9nizJP0iVuTvdI//ceK1eUriwrkh37Dsl5XYU2uUixtApoabput
         TQYs0pJpP2ehBsrH/tAG5V8ENLqD2lAIeLKBddFMGqZ/a97tczAzqgUe62dnCZQAvVaL
         i7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508288; x=1790113088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uj/SZ3uO4mBIi6FG9GIM3H53q5vTFxwH5yPRdSUlx/0=;
        b=ooRU403XD+PG1hQcmocpjZtzVbNJK9XFHNS1n5TGs/Rv94oycgIKodjTDXKsUM/7dC
         0QbZeeE+b84S8e1w2hZ9BXVdjModFIkDLdS63eLFoUboyblORk0qWIels/pw6ui+L4M+
         p3ZJmJzbj/ZGecrJ/u4yTeQRlZyNggFCYmUW/AcCGWuAWyKuQAkKk3nbdzmS1dksaqAl
         taF/qO8oiFfj0FPdLRKd7HybH+zgr0nviaZHTaS+zFIvj9GAMN3PERN2bjLijDV2v2vT
         9HpIYdpwwtJL9XHvofwqzPimYJLhb2jfr3F1Iz8BBHfAUWDQaXCPGeGhiAmhQbMEjrKv
         0DyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiLW1xx8WhE4ZyrGPxZdYVVDlq4C5g914sWXOW99uDwHNO/A2OVrAuI31UA50288/cDrFcxIkbQT4MEV3CU0YM@vger.kernel.org
X-Gm-Message-State: AFuF++k8TLZ5HF0NE7g1HghCaZiHfQPbRHMrxMENiFB61hL53rUgKqdu
	irNMLGUX+tQwmsPS6vYFLSp5L/zcZRfudSOhtFs0hSNpgXAEa/3LE8ntP3naze/8vP5VJ4M7n6h
	2UQqt/a9yBiwkzBwB1H8GMGzDtbESsZk8SB1hee+q
X-Gm-Gg: AYBFou2kg/SOQV0ny8wNZG1q14FrEl3k5jP1WUSxiPaegStCJpTEdaCEf8tdQzrLzqv
	SxJTmthZL57M984xTRYbwWAgucQ1t0f2n+yGC/U8sJvRFs/Hs4Vfoh2hPc2kqRIzaB/YWcMbzcb
	89EBz32L4ld6CIWr0ZGc2DhUJzC1atGTTBL2krRzl62OYxvUM9bQNybIbI2H0XuokJC65CoRUZ0
	hN1aQLRMndBsGo0E9bAwy10qnCHEVP4XTz+JgA/5/3PkpYJ4dtg90xSRNjaBbWaRPWAGsN58act
	S8SRp3Et15ftlrYYW/FsQ/e5lDVPM1X/kOnMWTf27s1n8QAzt1XejdDFrHweEZsXVi4PuVA2QJJ
	/toPoWC1iYjPT+yj/I6s3
X-Received: by 2002:ac8:7f09:0:b0:531:282:6560 with SMTP id
 d75a77b69052e-5327e6f2a86mr1402711cf.15.1789508288001; Tue, 15 Sep 2026
 14:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321105835.7389-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260321105835.7389-1-kexinsun@smail.nju.edu.cn>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 14:37:56 -0700
X-Gm-Features: AcwNN1WcDo4psBdya88EuyT7rYNEEi-tLpQ6qAXr8xzpTGZqui71u5NNPhj6wjM
Message-ID: <CAP-5=fWbKeudydV8mxErya+xfz0jJXZ9XN=R1mFmLw-nBCz5+Q@mail.gmail.com>
Subject: Re: [PATCH] perf/core: update outdated comment for refactored ctx_flexible_sched_in()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>, peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr, xutong.ma@inria.fr, 
	yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 3:58=E2=80=AFAM Kexin Sun <kexinsun@smail.nju.edu.c=
n> wrote:
>
> ctx_flexible_sched_in() was split into pmu_groups_sched_in()
> for scheduling a single PMU's event groups and ctx_groups_sched_in()
> for iterating over PMU contexts by commit f06cc667f799 ("perf:
> Optimize perf_cgroup_switch()").  ctx_groups_sched_in() was then
> folded into __pmu_ctx_sched_in() by commit 2d17cf1abcbe ("perf:
> Optimize context reschedule for single PMU cases").
>
> __pmu_ctx_sched_in() is now the function that schedules flexible
> events and may re-set rotate_necessary. Update the references to
> ctx_flexible_sched_in() accordingly.
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ac70d68217b6..463440774f26 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3556,7 +3556,7 @@ static void __pmu_ctx_sched_out(struct perf_event_p=
mu_context *pmu_ctx,
>                 /*
>                  * Since we cleared EVENT_FLEXIBLE, also clear
>                  * rotate_necessary, is will be reset by
> -                * ctx_flexible_sched_in() when needed.
> +                * __pmu_ctx_sched_in() when needed.
>                  */
>                 pmu_ctx->rotate_necessary =3D 0;
>         }
> @@ -4575,7 +4575,7 @@ ctx_event_to_rotate(struct perf_event_pmu_context *=
pmu_ctx)
>
>  out:
>         /*
> -        * Unconditionally clear rotate_necessary; if ctx_flexible_sched_=
in()
> +        * Unconditionally clear rotate_necessary; if __pmu_ctx_sched_in(=
)
>          * finds there are unschedulable events, it will set it again.
>          */
>         pmu_ctx->rotate_necessary =3D 0;
> --
> 2.25.1
>
