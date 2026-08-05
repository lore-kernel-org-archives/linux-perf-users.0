Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F2363C77
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957041; cv=pass; b=UdvWjx38sypfbxWP9AkzabMwOpaGQBgzVT2DW85qXeVx4UM1AIdWT41zyK3UDFQ3sEy0ACRu1t0CjpoHok11harDz8QTNTi0BWDKsPCmmE+rf7l8xNpXY/550uumVaZfdynSv3gjVyED+slfF6o25E1yfscxN0jrhYN7vxFMJRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957041; c=relaxed/simple;
	bh=EbWYE2gXutj+Weja9HZVCAAzFDg8djuK6qxRmRZNqrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6V1MopIBPoduywyS1NYu1hP9B16AFReU87jST+befS7DeQWm+2/YN5HtzRbUW0EoPymayikjTRimXQfy9dT+yiGdmT9CYyTvQ/Kt5hSsYIC4o19Y1cx4NvzD5eq9bXIftDG10NyzDVERcmmN8dsDHHY/gQvmS3BavGKLjYGvnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8ELIOQT; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8ELIOQT"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10e86e52so45261cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 12:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785957039; cv=none;
        d=google.com; s=arc-20260327;
        b=kKA2w6f0CDWL3xOhBNkBv3WzTNOay4wZkyHH6eutjpMks7ce7nxU4fnBO0k8MXWmaS
         NAa5UK+3ldPgWWs7jHnbfjt+HxbVlVZMtuzjxtnKtE0zktryCY65/kagqWrpCwvZIHbd
         niNTvGAUvOSdL3CEIQlfiVeqQYbi/TfVWtc4zpN8CV9fgTQVcsdz9UlaXwylyF+zp4lt
         6fL1x63EvCdyrz1o5QokIJbGRUiSsBtEi00Fskvuy5U8kCEnBvJM4CvRwnyCPnfekLIn
         MjfNeAeJCo7YXkjSvZGsGniMKiKcyl7gUOc3G5VaLeOpBWHLMheGowKT8NEwY/L5oYJ1
         lOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uhk17DX3Fi9iicA4/AIWVQXIP0oYpm7VcptV2uFqGGA=;
        fh=QJ4WnR+VUE+uP11x8jyuTTWQN+Vser1fMfziIE2hgug=;
        b=VdyTdEzX4U11dSVI8uG5Q0zFq2aTi8QOQ5QHtRZstqTD9bQtwDRkBFq6NFARvx4Py2
         yy2WhR1+B+nMVqExjvJpTS4m52fbpXIKNZWh40xgCGhm1nEmYcM5TLcwGJrCIjT7OSVi
         eDk/ZHv+34ToOtADuZuZ1bKCpTEI7YJo+pS88GqhL8LnCM31FUlbsTWa9DMSJ5lH19KS
         AKt6ZFCy5jdgAhfIYmrzUqNxAfLae2PVDeBz6VnAkMO969drLTSWWr+1kohu1iC62k1G
         nFK6CobmAOOAuu8EAQrq/BG3QHPN441tVxOTAvSI/6PHLk+JwfpFyC7aEIpJXGotqEPV
         6shA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785957039; x=1786561839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uhk17DX3Fi9iicA4/AIWVQXIP0oYpm7VcptV2uFqGGA=;
        b=s8ELIOQTM2wjW3p3nbGg+yGVjh8WLNBZ00SVfaUa2YsYI5vVfG/s8U3bXPY0LpvUUW
         ep5RK5wyMX+I5Jqsmee/9xJDR0oYeizmujVwk5N214tvDPrJ0oA5Nz5XZaQolS/IZBsA
         yDhN7O19Ns70WMjgPhFjXOVmRJQwNcZqWWOYL8qZeoxj9kcc/xGIrAa5zqxk9jq97kvN
         MCn5R3HFSd2MJQt5Q3hT13L5eYhHcxfczT4uvdXidW2etAYb+C4HFdq28FaAMpItkLQK
         nka9ihrP1iC6extG0u4cUv4tnxszr//Xos4WzU/0IxTFDdDdiSxiWZfDJWN4euxZwLNv
         8kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957039; x=1786561839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uhk17DX3Fi9iicA4/AIWVQXIP0oYpm7VcptV2uFqGGA=;
        b=hkKqJEOAx0LjbnNvW3xBPn8dQuLCi4sTp4ysvMeyKkuU5bVDlVt0CQ1vbpvhgVACmc
         pPa46RVqrtd5og/7rK1H0andlXMrdpsZyked+PsiPs2qmn3bq1dq07qyDrKmgH9hH7Us
         xAMlQZcg4JeyuZOuEiNF6/ViLnHnMHZGnkxAn4FQK1zcXsNXOMU3yWjDy+lDUkStJGey
         6dAN78rJuu3ep1CM7a6kpXW8e2/DDO7wNxkJazBpPxMq72VwbPS4m9Tcs5pLLKGDi8kg
         w8zTU6s7yKWEtnr7t+BlGRhtECXfk00PsYPcxj9UwAFsJSroN+u7pwdVgFzjEjA413zR
         0dLg==
X-Forwarded-Encrypted: i=1; AHgh+RppD4XhFSFdTixNgAL5lvd2GvkGbCEqRbQ/hNWaQrIV4Zhjbnyf32QQ2XBSPJBJ3g8u5QFkmcX1frJzq4vYnGei@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUywkdWfmf+4JE3TP86XWiAjCBs1egJzQl4zce3N3gx9hfeHH
	vbMQF6eryzim83HzpqLdIml0QVR2xbgogZDfAWAA7yDLVojG4veReEo+E/9rnlfiHa5Yfchoabm
	uAXW6ysuMS0Y5BPAGJBdHrmpjREYorKuH5BSB+hrh
X-Gm-Gg: AR+sD11Buc+VWl3l0c0eceRGIhiCua5WnM+M0V05XpWsry7SUUXGgydHsQ9iP7DKv7r
	mUyElyh2+5rxAmFnwmyYOhPc+TPhd5cSCflkHe7/EqgQRppLLj8OVlb0dpBeih8sClSt6KK/OpT
	D5qFFAU9arRBMTeUdqLp/uRDJDD+gy0m9abMZ95hpAoe7c0N3Etvaur+YfqlDpTZ8tSC1hdC17c
	/d4KQCpzBFGuAirLww89rtgqJLI8hkxG1AirKEYIDWUVv/RQrwe//wv18c9/YUEY7cMj7bheYjL
	zsdOMKWAFjcbGPZcxj88WmmOItm/J448OSAFRsSTL5YYlQ==
X-Received: by 2002:a05:622a:314:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52cfc06c2e2mr3163721cf.1.1785957038518; Wed, 05 Aug 2026
 12:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-9-acme@kernel.org>
In-Reply-To: <20260805133013.235016-9-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 12:10:26 -0700
X-Gm-Features: AUfX_mzPgSB8HZQXesWjmgnpODi4peZ53_yvmixAN5_YOoIyaeOewXLwI4m0AzI
Message-ID: <CAP-5=fXhi5+5H-wL9VAMU_Wzk4pFLkfhm1=Pjt9cxkdd99BkDQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] perf jitdump: Fix debug_data and unwinding_data leaks
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> jit_repipe_debug_info() overwrites jd->debug_data without freeing the
> previous allocation.  If two consecutive JIT_CODE_DEBUG_INFO records
> appear without an intervening LOAD record consuming the data, the first
> allocation leaks.
>
> The sibling jit_repipe_unwinding_info() already frees the old
> jd->unwinding_data before reassignment =E2=80=94 add the same pattern to
> jit_repipe_debug_info() using zfree().
>
> Also add cleanup of both buffers in jit_close() so they are freed when
> the jitdump session ends, even if no LOAD record consumed them.
>
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/jitdump.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 4f52b143cd0da296..3085091b95a517ae 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -118,6 +118,8 @@ jit_close(struct jit_buf_desc *jd)
>         funlockfile(jd->in);
>         fclose(jd->in);
>         jd->in =3D NULL;
> +       zfree(&jd->debug_data);
> +       zfree(&jd->unwinding_data);
>  }
>
>  static int
> @@ -706,6 +708,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc =
*jd, union jr_entry *jr)
>
>         memcpy(data, &jr->info.entries, sz);
>
> +       zfree(&jd->debug_data);
>         jd->debug_data       =3D data;
>
>         /*
> --
> 2.55.0
>
