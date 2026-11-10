Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794339076;
	b=AlwQg9zWeZT6lji/zQUJ6bv7ZdQoK1NACD7l37Qe2Cb0YL2N7ML+6GPU2BVOS5g7orJC
	 Lls/MaBVrWYKFRMJl9ys7N2XSluaD+ioZTfzhMy+hsCETFYiQeOdj36iN7ExYCudsu/3+
	 1xbG/1T+TS3jt+Q/qLHoeRwogj4nDR6zucqVUYbnWUL1F5aEPfBkxovZL8C1d2vmEqf+F
	 HYpMJA4Krf6STB8dMBxHeTMeWoqrX8NxVBAjxx82VaQWTyFxFD3VbTEIRjSQpFY9DEH8H
	 cT2/VjcDyvwf4c5Vg+dxRpslosft+26iNIgQlximDCLWBTpRFSAdviIPYCEIKqe15Ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7PpHUnf1QWGzREEK74qSoQAh95FpMu5Wm8BOh1zkZj8=;
	b=w2uESvPlFhfKLoSFQslZ2y+9Z8ncs520F67Z15m2AluryyzAsZMfTsvlXCVk+qfbhGsA
	 5NQWX7f59gPb6hf0AAoFVz0Jjs/7JBYHT8Vs8MERmbfxWssMz/EzLopdMflTnfZ0EtlI3
	 c+e+djV4Kz2VHJg4U7nV0ksdRftV2UN+qeZMVdHGUy1fJEWGyAVsn3087g4DtuP0JrPFJ
	 tIaBXYZ1/wo/Z/BRPbFjP/R1Dhjv3rAxRpqxV8DFpajdojMYpYny3Rf7MNV6tyBwIjfaa
	 0Xu/6LxKLeFOnoIh3pJzYp5wzGeMnPGkLqE6ODFPjvgMv+yyFcn7V5qdMdIQaGCHwqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygA55dIo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538FC606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 19:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 538FC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygA55dIo
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so3912783a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 11:31:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794339075; cv=none;
        d=google.com; s=arc-20260327;
        b=odn9/tOoD/uSjxYE9NG+8Ttvzb9jL3o3540i2JRIUekbHQRchkuk05czOlJ9+SxXCm
         lPEcJO9MaCQLtTiWNCnaMm9vXnScGfPI7hQjkjxEpfBNIJmo50TJGBaAiSnyON3OPy8a
         qgjhQHvwh8343YuW9Nji8gniSXPR+x8P6CCdDQ2ZQWdqNS09ReaUeMrJaweSlhoHYzXx
         4TgfWNT5J3XKD9MKE7BFj7nsxQuJbGicF362NzMTWgSQN6EZ/AP/CXj0871CLAEaJ17F
         4LQQdmFld84XYs3NHAohoSiioNCjQj3KkRuu2SE3EUU/vF85QA9ccemIJS9ni8yAUE36
         5AwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7PpHUnf1QWGzREEK74qSoQAh95FpMu5Wm8BOh1zkZj8=;
        fh=a1EDK5J7yMX4AbNghztovYh8onpJpP2+jJUQ/8gEszY=;
        b=DE44mc4sXiNx3K1YfoEiw8LYJ9rdHw3yDA2f5dJYIGsT42sK4Ca0ShC4hLWi+/XMF/
         1OqbICZgCUUAMms86qsa9FuhwPF/8RmoHEEd2Zo7LOHFdo+lgK5ZQLq7RQtk6C+WrCDD
         LqzhYgIZyhP5CUdojOMPV8fJzERpQXxaukKvSIFhBeBnEAO8rUM9vvnKQotVaFxkbqGL
         VfoJ54xNpcEgnuVbGS7s2R9ir98KGwnj9t7/QZSICqpx1QIEN5zPUarTVJD9pJwq1isk
         NqA4jCtVei5CanPhpycT3oXMrJnsH7+4SRqxtWS5ejAPx96h9Jd4cmjtgZzqqfSo3iO+
         qEQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794339075; x=1794943875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7PpHUnf1QWGzREEK74qSoQAh95FpMu5Wm8BOh1zkZj8=;
        b=ygA55dIoz/6O4MxSokjKAYOAnTAUBuad/texw+fVpfWZq/9MB7Z84VndkLK8QIAqXU
         9MBui/Yo5n2BSvO3OClQ6fhIsD8wQ7G3jWmz6cdywYdqMY1bm/I+0AndVvZf7rva6T00
         ysgfJC+APM3chckN/eEMKFJeSEdUxCjJWXXwyhPziZxsdO3qDUVPxF/wKrF4y1Kdhw43
         yPO6PQEBCd6Svdh22LukN+Cha+0U985V65ONfS/l0syMDRV+/0W0TJb7C/oAoj1J9mXp
         p0bq1nVovvt7QUX+14kIP+gM0Pn6A6fLGHCfdd0Lm3JxE/gOBbzMx9hcD2gLU9bTGC0R
         M6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794339075; x=1794943875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PpHUnf1QWGzREEK74qSoQAh95FpMu5Wm8BOh1zkZj8=;
        b=vYRt2z40JJmmsq4DwEsik/QB3hVXz61ljnqYu/Yqwo9uZHHRdmnEW3C7fEqaXqfrXh
         NyfyYheSWWVubRie7k7OwCh5UVb9gspMNFOAXyZ8O1DN2tgCWUcyVeHz+lsM3zuNlevH
         cV6ea+CCpNmWdE5uX8Qa20Steo1DmGGcQLGJfBpNPK5LNAvme5H6AjJvhg9WtJgGrOto
         pTTwjYgBUpQf9H5z+1dxmQzOljwxA1iChj7ZbFor6J9b5u0qy5rzVmaeMrHN/RPeh0/X
         xbDb9M9wOJZPhZJyMCq4g+KPum9+HxvsZBVyZJ/T9bg9NnaBxudiWlhb9MMrgNnP4qSF
         I69Q==
X-Forwarded-Encrypted: i=1; AL+hErHkKL68nrL9syI2BxZPQpZhwDnX5lx/VfUjJ55ZqWz9VoCPX5/sfWBUP0GjcKtHn4yfh89+rDSu80/Fm4onQK/e@vger.kernel.org
X-Gm-Message-State: APuU4Z+So0ju50IDt6yOPjQd//57rUT4J3oJ74yoB+qbBwMaGDHj+mmK
	Eq23KExac+EH4Uy0tt0EgfXlNXn44qvjE6sm35oQVbQLaWLCN+YP6FLwCyFor80naO0AAQ4CUra
	MVzmlQva2Apx2dI41DdYxMRFmjetPAcs=
X-Gm-Gg: AYBFou0ceuUwVU6rqzPit9Vb7OI9nTGHQckgcGSDyHnVwfb4L6xS3uUMKFaHh31vw9j
	CB2D+vjyXVplYjciNKdm7v1EJrB8T+LJSDlvLQMVQeSNi15lH2AE603+fzZ8qwOOkzxUvSg87qR
	vmlXW2bSgjGxw2ZDDfR0imlRdQx6CqyIyJvDQl6rNzXh65PooyvBg96yOPQsmZ5kmKJvko2zvSe
	R1z/VvG3+fwisBA5cBcdIcHKzATNzjrigiblPx+I2/iV9W/fRNnonqZpMCdU13H5G6uAHwP0rG4
	h/JBMf8dkcsJaagwKSyIYDOfs7ruCMWKf7zxfNyQ4xhJu7WEvSuMHHPmcKHlqjrhLamw96XAZkz
	54MqwJlXEufJtGIHr3iOlrIdQqo50EU8u0xbPznl0Sa2QCnQAAoxq3UwM7NukpQPBRIxCGmv7ZO
	etK9kK7LaLZ794evS2xtCHw8HJx4jdGOMOOVOf1I0vL8gk
X-Received: by 2002:a05:6402:5416:b0:6b1:b9b0:dcfd with SMTP id
 4fb4d7f45d1cf-6b77707dcb9mr271933a12.0.1794339074327; Tue, 10 Nov 2026
 11:31:14 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
In-Reply-To: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 10 Nov 2026 20:31:02 +0100
X-Gm-Features: AclHuK_7HNzlokPAsBoIv_7fPp-EVtZiMe-LJK6KHz7D9VmXnxbP6S1wnm1WwT0
Message-ID: <CA+=Fv5RBKVAdGgq=BGPmLXpczcB3qvQcSw8aat7nB2ePXcG4yg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] perf alpha: Decode ProfileMe samples
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, Nov 4, 2026 at 7:53=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> The Alpha kernel series "alpha/perf: add ProfileMe sampling" adds
> ProfileMe sampling to the Alpha cpu PMU. Each ProfileMe sample carries
> the profiled instruction's PMPC and its I_STAT and PCTR_CTL status as
> PERF_SAMPLE_RAW data, which says whether the instruction retired,
> whether it trapped and why, whether it was a mispredicted branch,
> stalled before map, or was killed on a wrong path, and what PCTR1
> counted while it was in flight:
>
>   https://lore.kernel.org/r/20261104-alpha-profileme-v6-0-63362e9290a3@gm=
ail.com
>
> This series is the perf tool side. Patch 1 decodes the raw data in perf
> report -D and perf script -D, as is done for AMD IBS. It copies the new
> uapi header from the kernel series into tools/arch, so it should wait
> until that header is merged. Patch 2 adds a script that sums the status
> by symbol or by instruction, in the style of DCPI. Patch 3 gives perf
> mem a ProfileMe event, as the kernel series reports the DTB hits and
> misses of loads and stores in the data source.
>
> To try it, with the kernel series applied:
>
>   perf record -R -e cpu/instructions,profileme/ -- ./workload
>   tools/perf/python/alpha-profileme.py --pc
>
> I tested this on an AlphaServer ES47 (EV7). Sampling a loop whose
> branch tests random data reports that branch mispredicted in 21% of its
> samples, and 0% with sorted data. As a normal user, perf mem record on
> a loop that loads one word from each page reports the load's DTB hits
> and misses.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> Changes in v4:
> - Patches 1 and 2: ignore TRP, and MIS and the trap type with it, for
>   an instruction killed before it was mapped, as the kernel series
>   does. Thanks to Ian Rogers.
> - Patch 2: record cpu/instructions,profileme/ in the example, as a
>   precise event now samples only retired instructions, which leaves
>   the killed% and invalid% columns at 0. Thanks to Ian Rogers.
> - New patch 3: add a perf mem event for Alpha, cpu/cycles,profileme/.
>   Suggested by Ian Rogers.
> - Link to v3: https://patch.msgid.link/20261102-perf-alpha-profileme-v3-0=
-4bf6e1dda733@gmail.com
>
> Changes in v3:
> - Patch 1: silence -Wpacked around the uapi header, which breaks the
>   build where __u64 is 4-byte aligned, such as sh4.
> - Patch 2: only read raw data from cpu PMU events, as a tracepoint's
>   payload can pass for ProfileMe status. Thanks to Magnus Lindholm.
> - Patch 2: print a table for each thing PCTR1 can count, so that mixing
>   events no longer averages unrelated values. Thanks to Magnus Lindholm.
> - Link to v2: https://patch.msgid.link/20261030-perf-alpha-profileme-v2-0=
-9ce2f0b0e622@gmail.com
>
> Changes in v2:
> - Patch 1: copy the raw data out of the sample and convert it from
>   little endian, so that it decodes on strict-alignment and big-endian
>   hosts.
> - Patches 1 and 2: follow the new 28-byte struct alpha_profileme_sample
>   from kernel v2.
> - Link to v1: https://patch.msgid.link/20261028-perf-alpha-profileme-v1-0=
-f46c1938d001@gmail.com
>
> ---
> Matt Turner (3):
>       perf alpha: Decode ProfileMe raw samples
>       perf python: Add alpha-profileme.py
>       perf alpha: Add perf mem support
>
>  tools/arch/alpha/include/uapi/asm/perf_event.h |  31 +++++
>  tools/perf/Documentation/perf-mem.txt          |   3 +
>  tools/perf/arch/alpha/Build                    |   2 +-
>  tools/perf/arch/alpha/util/Build               |   2 +
>  tools/perf/arch/alpha/util/mem-events.c        |  17 +++
>  tools/perf/arch/alpha/util/mem-events.h        |   7 +
>  tools/perf/arch/alpha/util/pmu.c               |  11 ++
>  tools/perf/check-headers.sh                    |   1 +
>  tools/perf/python/alpha-profileme.py           | 178 +++++++++++++++++++=
++++++
>  tools/perf/util/Build                          |   1 +
>  tools/perf/util/alpha-sample-raw.c             | 156 +++++++++++++++++++=
+++
>  tools/perf/util/sample-raw.c                   |   2 +
>  tools/perf/util/sample-raw.h                   |   2 +
>  13 files changed, 412 insertions(+), 1 deletion(-)
> ---
> base-commit: 4626d370ae89b8af4d46a45372b269f926ec662d
> change-id: 20261028-perf-alpha-profileme-8010299be323
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>

My plan is to take this series through the Alpha tree alongside the
kernel ProfileMe support. Does that work for the perf maintainers?
An Acked-by would be appreciated.

Thanks,
Magnus
