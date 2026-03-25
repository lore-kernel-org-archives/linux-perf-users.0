Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349E34107F
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451137; cv=pass; b=V5/gwRTBmLTglI7LjkcOEClr7y92Z4Dl2JQaOI+6noPhe8rp3VE8ZTz5vEAh8FJytkSZYPMDoJBqwfXuW2C94tLnxKdfqf3/ykHaRgU4qNoFIZvrSJUIFL3gA1IRHVjwkj5DpOuY6yom7rIRI3UqnU6R4OLZwGl6mulItcFfqqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451137; c=relaxed/simple;
	bh=RiZ/P1j05T5iezJ42hkZoxCtyJ4MdUs+RpruqciR7qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8mD5BSgB0lYYbvRz9dn5vIKwO3JsMdzzrtPDSQhntdRmLt1y0tDxIPF3g66p2XV4uJuZgpmBWYlBmFIMNoFMi6wqAyCAzKOkAqjBgJPPXp3x0SEeldFqaY60y/kdkC69Ev10Bc9ydJN7uU+r0GW2xJsRz/j6Rg8HEHG+e7Rz7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXcWTBf2; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXcWTBf2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0b260d309so75575ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 08:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774451135; cv=none;
        d=google.com; s=arc-20240605;
        b=UPlFpMbvf5OJ4Q/A8/eePOln3gFXL329u7fnQD+vZR8PDIHxNTWcr3LNawaPcqamdb
         XfuHHHNOabNlrd59fhB3FWDW4jsnSJu/6ZnjyQQr8n9bcR13eCa59YqF5f0fDrhd4+Sb
         DKniAWZNCbM3ysw3UIgKdnJojs5l22+8tHJz6hqCWpXVE+YprNvC5iAF7OnItsaFggjd
         k2XHikP3c1VABuss/Rmwc3BzujB4vyg2vGe7etkluJ4RE1L67+Yi2HTPsoHh5dvIWOWG
         JZasHAtNNoxAQdhGuTCzyKDfF5upGYpY5Pvf3xFC3wRPzCMZzLB4wnEU7BCor9tbKBdV
         Dwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=76OabY+luJ+BcIbMsFlMiNmsKsf1afMlxhtAh6iR5WA=;
        fh=vBBzzLgD/v72Cv0n3ad1e/a/MXkTwF06bfr7ZFjCbMg=;
        b=koc7BAvHiDpoAUfJUa+a1Y4oKrS27os1mkEbG8cuEaubNPFTKC/qduCPfjHWE/65li
         YVrGr+Ouc9WSIufCEi6aAS0YLaV/hi3PHtGQ2KBsm40cANp4vctLqmed1EA5pjzPsHCS
         s4oBcD6gevR1SHhxRTcf0sw61Od0jTlApuH5/gm1Nrr3ZX6JKxLCcHjNSX25eCRZjVSx
         Csi/doL7LlaeYwYxscDApoXPOdJ100YSFNjlKHbTI0PMZticN6hpa/2LuGPkkB/kwv/t
         Su7f8CylgGBRnaUAuxRaVr7zOQ7v9ZTqOR1ZEFUcGIzNXBSfW60BxiMZpTr7IVmAaFD8
         HClQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774451135; x=1775055935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76OabY+luJ+BcIbMsFlMiNmsKsf1afMlxhtAh6iR5WA=;
        b=EXcWTBf2jClhw2sCM2swx8Pt0Ki7HKY1q5N0yS9CXW8gb2anlRC4HJ0YoYkFbnVb7C
         XPeGb89R01Hm3IGzOkeZZXo7AbxT5jXRD9tKbvVVC0XlV9cMBuo0GzIoDNko6XmZqnCg
         Y2van4Vdj/mqG8jMzruW65LtDfxwYRYzvb/g2p/maAYYLHMRyp7cWDW2gpxPFp+AOAvm
         f/ZsV9Yaz0CdZAgP9fOx7+B+pgOhBhTzfPcG8hAeAwhp6XHHh74aN9MspGZxcSdpAgJu
         C4TiZUtgiysDnDdiw7ZfApTv9NrKrY2RE+hho46lcTlgflTR14t1oC1lQ84NMcN2nZG/
         Ho9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451135; x=1775055935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=76OabY+luJ+BcIbMsFlMiNmsKsf1afMlxhtAh6iR5WA=;
        b=oFw1VRH6tF0VYDuDdIDR44LOhTpCkNdl2Byg+4tk45X/j3Q7h8eKPAYBH/MYY1lLLM
         wdA+Y/6/3DQDko4Rcx668FB3Fmy5Q9Wr5tJvcKgYqpyFwaev9b2Vci99s7pYEsn07TvJ
         G5748UdnqB1hEzaRW4Rqv09JA6aDPdXMYDjrx36MC6SpUWzZytiw3+UrUmJyGChIPQVW
         99h/AJG7iyMUSd5qn3Gyfw7QqymtQ75vvAg0WGOKOH0WBpmZVowiDU9DKcYa9lOMe8sk
         FkRntQ7g8CQWxboxdio7CP+oLDo7xJMBEsJ4vCmnvWe0vEosPOJGcc/gmyRhQgTlkzj5
         cdrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTuLyhPD801LbZ0MsQW5e04XzVOzYIt9bF6a7YL4I/ftqjOHJD8tcfhIoCDAsYX0r+HGwDVA2XWeC6A3/6l9HY@vger.kernel.org
X-Gm-Message-State: AOJu0YymCn7S3e2/dJ2dV2u92NtYg0GC8jYA8vJw0SpyoaPhoU43jldu
	++ByL3TmdVTnER/xN9bLId0FtkrlXku8i/i78GjGAznLA5HJIW8kgFYp+Lfpw1cyXcKW7ZEHVNw
	BajHzzk6T2VRaX1rDt+yM2s6/+z975JlLUvPCuule
X-Gm-Gg: ATEYQzy/3v/MOGTSEy0rOCQElajExqBP4a+WplbBNZ2jyC+8LZR3G46Q7jpJetlKVKN
	O3f0L2ssBh9M8bmhsKozdy003Jdvyczvm/y6xD81zSZXyjGsSslIDSDLsgt7s4uGu+Nbd/pb3N/
	qaw+3ShnkaMU9Z5UkVPhaMu387wFj67kYb7RzRLF2HAKuFh0e1KSDeglZRyIGWm5OCcTeZxHHfj
	hrDTBtnneTuQmF+R2yEh01kdkYNt05QDs2RihntBmZni09GJjy9kSV27jWRA5Kn2yBFzUTw8F/+
	IPrVjZyAsD1EblbtFOP8o6AYnyxiNWM2o1WgHQ==
X-Received: by 2002:a17:902:ecc4:b0:2ae:575f:3755 with SMTP id
 d9443c01a7336-2b0b1622bf8mr3148215ad.20.1774451134653; Wed, 25 Mar 2026
 08:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325120627.1841175-1-tmricht@linux.ibm.com> <20260325120627.1841175-4-tmricht@linux.ibm.com>
In-Reply-To: <20260325120627.1841175-4-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Mar 2026 08:05:22 -0700
X-Gm-Features: AaiRm51aCCTjGP10v807adh0JZjzR1DHeVdYkImq6BkMDIeW29lO9Fx36OI7nR8
Message-ID: <CAP-5=fV+Xn_7Q1DZmO43MBrOAHZv6YUu8wwF8jyy7Stwo=BNRQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf addr2line: Remove global variable addr2line_timeout_ms
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 5:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Remove global variable addr2line_timeout_ms and add is as member
> to symbol_conf structure. No functional change.
>
> Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implement=
ations")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

I'm a bit curious about the no functional change and the Fixes tag :-)
I think the trend for addr2line is to use libdw. The forking of both
objdump and addr2line is quite brittle and slow.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/addr2line.c   | 8 ++++----
>  tools/perf/util/addr2line.h   | 2 --
>  tools/perf/util/config.c      | 3 +--
>  tools/perf/util/symbol_conf.h | 1 +
>  4 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
> index e9f084db0802..1b7f66ece570 100644
> --- a/tools/perf/util/addr2line.c
> +++ b/tools/perf/util/addr2line.c
> @@ -18,9 +18,6 @@
>
>  #define MAX_INLINE_NEST 1024
>
> -/* If addr2line doesn't return data for 5 seconds then timeout. */
> -int addr2line_timeout_ms =3D 5 * 1000;
> -
>  static int filename_split(char *filename, unsigned int *line_nr)
>  {
>         char *sep;
> @@ -87,6 +84,9 @@ static struct child_process *addr2line_subprocess_init(=
const char *addr2line_pat
>                 return NULL;
>         }
>
> +       if (!symbol_conf.addr2line_timeout_ms)
> +               symbol_conf.addr2line_timeout_ms =3D 5 * 1000;
> +
>         return a2l;
>  }
>
> @@ -335,7 +335,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>                 goto out;
>         }
>         io__init(&io, a2l->out, buf, sizeof(buf));
> -       io.timeout_ms =3D addr2line_timeout_ms;
> +       io.timeout_ms =3D symbol_conf.addr2line_timeout_ms;
>         switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr,=
 /*first=3D*/true,
>                                       &record_function, &record_filename,=
 &record_line_nr)) {
>         case -1:
> diff --git a/tools/perf/util/addr2line.h b/tools/perf/util/addr2line.h
> index d35a47ba8dab..75989a92f16b 100644
> --- a/tools/perf/util/addr2line.h
> +++ b/tools/perf/util/addr2line.h
> @@ -8,8 +8,6 @@ struct dso;
>  struct inline_node;
>  struct symbol;
>
> -extern int addr2line_timeout_ms;
> -
>  int cmd__addr2line(const char *dso_name, u64 addr,
>                    char **file, unsigned int *line_nr,
>                    struct dso *dso,
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 31541e03aab7..573b3a3f5999 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -19,7 +19,6 @@
>  #include "util/hist.h"  /* perf_hist_config */
>  #include "util/stat.h"  /* perf_stat__set_big_num */
>  #include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
> -#include "util/addr2line.h"  /* addr2line_timeout_ms */
>  #include "srcline.h"
>  #include "build-id.h"
>  #include "debug.h"
> @@ -459,7 +458,7 @@ static int perf_default_core_config(const char *var, =
const char *value)
>                 proc_map_timeout =3D strtoul(value, NULL, 10);
>
>         if (!strcmp(var, "core.addr2line-timeout"))
> -               addr2line_timeout_ms =3D strtoul(value, NULL, 10);
> +               symbol_conf.addr2line_timeout_ms =3D strtoul(value, NULL,=
 10);
>
>         if (!strcmp(var, "core.addr2line-disable-warn"))
>                 symbol_conf.addr2line_disable_warn =3D strtoul(value, NUL=
L, 10);
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.=
h
> index ff229942fbb1..c86f4c0ca46b 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -80,6 +80,7 @@ struct symbol_conf {
>                         *bt_stop_list_str;
>         const char              *addr2line_path;
>         enum a2l_style  addr2line_style[MAX_A2L_STYLE];
> +       int             addr2line_timeout_ms;
>         unsigned long   time_quantum;
>         struct strlist  *dso_list,
>                         *comm_list,
> --
> 2.53.0
>
