Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40203876C1
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 05:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789708379; cv=pass; b=sNtRhdx70FZuNM4p997dXG5Bhfq5zA0gkVRIxxIIbI3WQ142cPycyiWIKdzNunzuZlz4gx+e3WasvAMV2X+qXIDbSri3Dj74nZhD/ZsR5lMW3vh4J8CtekgKUJioYypAbOn5lbDzxubgtvIE7TvLsgCMJS3RT3VhHZVvFNJb/j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789708379; c=relaxed/simple;
	bh=BFYS6IY8vd1U1P0niw3TW44Ap+VLSQTNuvDTg/GQXzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhoEw1kZFuOf+SpkFcgQ2P+4S85kPkLkvhlN9E5REHBIds65O70ISC3+q/Go2Is4CqO1geXUi82hZzC+GSyE740hq4aw0B+Qk5AEUdLGfaicbAQhK3FSl7XLbXmfCrr2D1o+UiHGS9Mj63Pvd9WRkdo0kpr23YdolnkVDbFc7eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MLNab+eR; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLNab+eR"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-530f6bcc301so103171cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 22:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789708377; cv=none;
        d=google.com; s=arc-20260327;
        b=a9p0ff+z6122IYZb8Yw4vGAPNLFuR2jGV2ruVbgmNbzmargMHkpkGh9dWe3QJFaAK5
         Vidzv2/ZXmvWhCbUMFNepFYTzOmt6a4N9a3SRwx8ZGgLGyiqpT4ckQsIF+ej78t85sKI
         /LbxUjQYCsAHNmFm0km0FbQf5rX4vpMAcCZ3HQXkk2FmefILPBzw02DWyYfqiMPbLmTL
         l+zuRI+x3Zwdw7CQ/oU+ZVx2LXw5x76uTFVVdSVC4fCkmpW/qIr414nAIt3uPholZTtj
         /VZu19u8BRExUO4063cQcns5CQVodY1ZSFAoA9XLPm9870XJruv626UrNq02u9YdgfvW
         Eurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jI/idnWWaftbUL+K1vee70bRRLkx813ZrtDJy0dunn0=;
        fh=DU+60YOkgFk7sUfGJsA/SIT7a+OtJH/2Jl5KGORlsLg=;
        b=ELwg6SR7C6Afjgdu1llGvOekHKyA3iFSWJ1SaTsXfktXjk+Jzc7JI2PbI1eWh2A+5q
         A37vzxh6q5SBMIf97s2DGGgUvwN1dnIESmhryWCiqUOpdAlWx3FptTruKCnUEpGMAKL7
         2lu3MT6zAO6qwfkLf9jHr4hZZJQee5BX7d2FDTJh9Wp0q6PlOESK99vHQyy0ns9HBM7z
         ysWbZI4MOjSOqmbKilOvLbO1bcMR5y8lPufcJVyc3KvDfAljjzXoD90C32dlYOm+GuFe
         fas1CyEuKbsASM2yjV8Bj8lkO4nlGM9z4aesVa/Sz4+pwAWjHjy/xmSANPQUDOjoUTiz
         2vjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789708377; x=1790313177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jI/idnWWaftbUL+K1vee70bRRLkx813ZrtDJy0dunn0=;
        b=MLNab+eRIJBHMSo7yPN/fSRY7t0j2tAO3e9IovSN5jvtlOCt0H0DlWvKGxGoYGk8iH
         apwlwizDTWkuBHYf1tVAazQHIxxzNI8ZCtXnlkrTTJTUfa5CAhgsGT3zQ8z2s64jI/Ok
         5/2mh6Ko71SfnJ3D0VAk+Ki6cbyDNb7f/2LkPqQIZQxjK2n52ZpfxUil2fChMs/wMIEc
         tS0ohcH1I8/dRetj3tBeSmCOOEX51CDUWM4QZXSPo3qDG7kbi1snCNT4Tm+wR8BEr1wI
         WyZYrTOhVmUo5rMevzWaxYb6WqeKb1iSgjTMdlxuYK/3iUgCk6exRqnOcrGaJu86hQrs
         VxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789708377; x=1790313177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jI/idnWWaftbUL+K1vee70bRRLkx813ZrtDJy0dunn0=;
        b=gI2/ask9V2mwtPPrnsmND8zzgekmtSXHgvHA+qw0wJN/84u064ZRb8/UAgfSdKVlnS
         ko2LtRc5jBFiWZeAFAT7I3IAyFRTXbFP5V0T+6LY9GkV+VZ/ukLClb8Rkd3ZpBv4MicM
         VGSX4AB5e1ELUlmmqZbCI9L8kghcb+QWUOXorBYPTMDAhnyI8ywZ/MN+rMzKncuxMsw4
         uZUS56N0Lzt31VPLz8i9LCtZKPJ/eBm8FgIbadDddxnzvJkJuF4P2JBuvPWseXSrAoIF
         wPdX8f53E6dLS/BnyI6dXpcqAaAHkE4ajoWocBRuFWSjC6cGrhylPHiYSX3DHhoxhOvf
         P40A==
X-Forwarded-Encrypted: i=1; AKwUvBwMhTvUUDIhVKjmHYSThgaJJs2SIIMOMfd4PYyE353KHdZwIamS5YnuHaXuSTq+7zuJ+5v1Pyl0tYbfVRVXueYg@vger.kernel.org
X-Gm-Message-State: AFuF++kNgTa1MxRjEI2jCK6QW3woncXXEJNFOlKpo1SUac8ZAiK7Gx80
	JflGH9NeeUurLwzZ0PFvvATxGPVV/MJk05FPIzCK31jhJrcMezoTZEkCGe9ghMDS/NKnLiphaRF
	tV0YKjO0ADdpHjEkkFVoMip3eu+71uI/1psjRYqgV
X-Gm-Gg: AYBFou2ifXS3mXzUlEBzNdkFG16mPUQKm1cyq/yEGEBGnYO9m/8pRxBXXQurdj2M53+
	AlDnysmYfNcp3Ns+thgn65s3wslAOupYPUuzDRllFf2eXgAbXmOnkpt2tEeiZspAXUjkg8VvUk5
	j8uNIVrLTOwk9FI1c6em7QE/Qh98LuoZa944fX/pzdVCyqHiL5rhucE14P5MhsiBWIcITalmMoY
	vlJO4q7P4MzqwoCBGxHrvHkw3cnS+Vhw616wR/keROh5en1KdRDmLVjW1eq+ljpJRCeQLd4eIqw
	f6l3srYtYXxgAGK6zKTLRCCzSjrOLB84x4FxFw6HVY89W5wqkgCdik8oXBwc8CNKnA==
X-Received: by 2002:a05:622a:53cb:b0:532:8a04:af52 with SMTP id
 d75a77b69052e-5329f23efa4mr8184991cf.9.1789708376260; Thu, 17 Sep 2026
 22:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918032356.466938-1-enelsonmoore@gmail.com>
In-Reply-To: <20260918032356.466938-1-enelsonmoore@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Sep 2026 22:12:44 -0700
X-Gm-Features: AcwNN1W3VyMrVrWO3rsSvZ-m8J7of_e35S6VhvP1K0L7i96UVXJSjS29TXJJ17c
Message-ID: <CAP-5=fWS6TOnfq2WmJ_HOhkySF8XRQf92Zo2XhZSFJVv8XFSWw@mail.gmail.com>
Subject: Re: [PATCH] perf: remove unused empty help-unknown-cmd.h header
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 8:24=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
>
> tools/perf/util/help-unknown-cmd.h has been empty and unused ever since
> it was added to the kernel in commit 5feaac248a46 ("perf tools: Move
> help_unknown_cmd() to its own file"). Remove it.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

This seems like an accident, the declaration has been in
tools/perf/builtin.h ever since the commit above. Perhaps the header
file is a more natural location, but an empty header file is clearly
useless.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/help-unknown-cmd.h | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 tools/perf/util/help-unknown-cmd.h
>
> diff --git a/tools/perf/util/help-unknown-cmd.h b/tools/perf/util/help-un=
known-cmd.h
> deleted file mode 100644
> index e69de29bb2d1..000000000000
> --
> 2.43.0
>
