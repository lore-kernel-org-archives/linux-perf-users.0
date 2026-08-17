Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C853CE083
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002603; cv=pass; b=lnr8mFMAb730OnYSGmlJPp7z9SIxbphtt4AaZTqAa9v0Mo+tG8fwb4ZflVyP8lCSuJIIUxDJO6l0Fl0WimwjyZspPd3eWt63HuGOHLF3ZrLvmsqRbfywG2X3MN3O49O7eQlxo+sQq2PNcSC5TycEwSKt1Yi8WG9wM+lH6MdQ6rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002603; c=relaxed/simple;
	bh=HhgELZydx3RmtYThTIS526zk+pxdnfWHCPqeMC9E4V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNOjWVRM/zQRvdSDFepMI9bB3tkTV8Ya3rqCNQXAP05dNpcsUiQptg1irACYKGwY7oo5wiQrsYrh7cRFI7IQcAJmo6EjtkMZ4PbxfvCaYtFVKFP/aCk+h/3AVZ4nhKRTnm1wPYV79XvFn6UuY2KnLSxOsDu9SeJQ7qIOMYuJUpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PcC+V3Pp; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcC+V3Pp"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c15a5b265so90721cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787002601; cv=none;
        d=google.com; s=arc-20260327;
        b=dRbX9j/9KTsUctN0aCODcxnLq49OavLW2SbOoEM+ba1TntRXOam6PgjakH08koEZMD
         ikaz3GZOV7xlaekMbtpbd+0A66+eX9DWnXi3Vrx6qWL+qwBx4XNxyWJVjqGSHsqHYpcI
         sIrCE+wliKe6M/ZxMfIoV19t7pjMY/qpT2BKriQS3CqiMBaTEurPjHzVMImEyskk13w8
         QE3XQZl6Zz3+h9Xx0QepEx8KNRhR2Q1i5IebbLDpBKospHrHH1H27OQzgcjpyFvRlc/r
         I7DllRGFcMuMBpswauNrw4w+Xk4/9BAb8cDrJAdL7NH2b9z+JZ3Rb4JkFELZfhmkOOCX
         Z1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mXawS8Mpb2sawnDq/jbFYbQWGi/tLbw+pkfiSSzGahs=;
        fh=7bwbERsnYF+rvfPqKztL51HTqC1Qik0GFCQfztKeSA4=;
        b=o/L2KpUJ4DBPokWCzckBuxMD0frRJHrxaB5/HuwDKs2xYr4UZg70zKwKViHuXcYW6P
         tcqkyWUvmeKneirDUxxF7F16IZDQPax9oi6tVc0KGhPi+ogyokXY84hRxrRa8aLjNvs/
         ZP9TCEDryISP4uV4ACxwegBtXzM/3Ql6fOU+4po9lYRPeVWYCiB0pDyi5svGQKFlVwPF
         uIZFRQdwN2XHnMFtPptSuKawik/7IZHkXpwmA3QRVRhacuy2vJWc94qBjJbvnQbxa3Ad
         YIATe9/jAiTFmeBgfpp+vEy6Nkgff+Avn2RLjkiRw9cZYWZUl/23JDLjQHOMiGOpywvQ
         Gmmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787002601; x=1787607401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mXawS8Mpb2sawnDq/jbFYbQWGi/tLbw+pkfiSSzGahs=;
        b=PcC+V3PplfGoIqSrXBtMdIuokCarto6UdkC8XGhEDfkFp0yEjRqwFNgVqBYi69uZgW
         yccd2qCe7+3/INZC460T75wUgeRhmkMp5xwhYPCnbo6G1Zu6oia1KHCtI/mUHPNBJmP9
         Fv2+8EAy6ALnPKpagkFgJIaAAbAY1RC0Dx1CaMRC50uN6J2Jh4elNDMdD/NuRD7RnGu/
         9PSdO8DDe9Md4OGr6fWicdFdLUlLgJyL5lD0tKrDA21wdmn1iFfFPaspsce341IuZYT0
         Fzq+crfGFvwOMlD0C1+JPL2eCDvaHdDXe3S6gSVFIbFbdFPMSHMn7Ih3ze388BfnvUXr
         x0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002601; x=1787607401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mXawS8Mpb2sawnDq/jbFYbQWGi/tLbw+pkfiSSzGahs=;
        b=VyEVu5jWthIe4w9USYKjgcYSp6/wyj60eoGLMgpDkBigs5hf2RO+KIEC35kNqckC9e
         8Y5+GZwY2ShLTObmX/FTRWZxYRPh6EWpwxlIME6Vr/TJ3eRl8Zbf127OifYSO+9UtB24
         OXb5DROtpruusNefDF5WZ8NdK5Zz5AqqHqg3m5JRSdnsKggu4yvsUWfsPdAUDpcYyxAh
         yhs+X3Q9NeRDBbTgUS9eNOqv6tjHa/CtclW0s++Bzp2MDpvj8YBq/04FY9UE6sB24q5E
         FbzXoiyu73AbQ6mUjNRc3+HeOZ7l5iErMoqVurYleF9jslCtl7P7p19nvImOFX3AkCYY
         49Pg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3OZc76KYWv4jeVMN9jHK842+RxcPhOWv9eYEUENlhdCci57zuJy8ptKV7g57qBhvv/6yISXC0RiM8lecCGW49@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAsnOR6viyzdNvmVMMdR7lTKyyOy01+UMWdpZOHaGSTj0D0Y9
	87mvANZWuqK/hyEEXDuMRjpz9w4egkH8dbz+YTBuzCG928QOmyC7fNLnCgvvWxuaYoCIuwZa3/4
	g0soHhrZSVN6+S56tc80Gug0dI4ZtfbGgk2Jgz073
X-Gm-Gg: AR+sD11AQEdTnBvIezA3vb2Ji+XHSCdC8wsmwkvIGmylWDQiGP3FmYBvqNXwsCVR1kG
	/OR9zqB8NiwM5tJUpvZlxiXD5HeFRmYMKbShVzimx0CuK6efvtoxsqEWD8moWh5ILOZ60/39O4g
	yjPLFSJAEbcuuDDDbKdE0xLXUvye4KPA7kpghOc/Z1zbS9SlbEARybhND4V02tmgADmkSyqJ0ZN
	iW1P1KYhh7xmuISWyBUNLTCaMebg9GPpccpo9+SK6aqu2DB+39+6MCypM96XpRGmKXmvhpZEu7h
	CnSbBOj/o2jvNucpgyjpbbKGa7UaEGLiS2438S2jgUSVNhUolpzEWkvYWgL1/DcUo/PU5aUJcuM
	=
X-Received: by 2002:a05:622a:2610:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52dc470e82cmr283731cf.1.1787002600273; Mon, 17 Aug 2026
 14:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811173340.96013-1-thomas.falcon@intel.com> <20260811173340.96013-6-thomas.falcon@intel.com>
In-Reply-To: <20260811173340.96013-6-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:36:28 -0700
X-Gm-Features: AcwNN1Vpdk-6ihBcjv1rdkMdZUfeg9Gobzr7N28xzX4hcNlqWsU2RUZUre3MXHw
Message-ID: <CAP-5=fVu02rzde-U2uoXiWa2Sbfp5X5fA8VKL+isA260t8aLew@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] perf tools: Show memory region in perf-script subcommand
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:34=E2=80=AFAM Thomas Falcon <thomas.falcon@intel=
.com> wrote:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Show the memory region in perf-script subcommand. Memory region is found
> in the mem_region field of the memory information data source. This
> field was included with the introduction of support for the Off-module
> Response facility (OMR) [1] in Intel's Diamond Rapids and Nova Lake
> Architectures.
>
> An example of perf-script output with the new memory region field is show=
n
> below:
>
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK=
 Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
> random    2411a68201042 |OP LOAD|LVL RAM hit|SNP Hit|TLB L1 or L2 hit|LCK=
 No|BLK  N/A|Region  Mem-1                          561de7f8910a
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK=
 Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
> random      20e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK=
 Yes|BLK  Data|Region  N/A                          7f32ae64a2d0
> random      20e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK=
 Yes|BLK  Data|Region  N/A                          7f32ae64a2d0
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK=
 Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK=
 Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK=
 Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
> random    2411a68201042 |OP LOAD|LVL RAM hit|SNP Hit|TLB L1 or L2 hit|LCK=
 No|BLK  N/A|Region  Mem-1                          561de7f8910a
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK=
 Yes|BLK  N/A|Region  N/A                           7f32ae64a2ec
> random      10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TLB L1 or L2 hit|LCK=
 Yes|BLK  N/A|Region  N/A                           7f32ae64a2d0
>
> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux=
.intel.com/
>
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Assisted-by: GitHub-Copilot:claude-opus-4-8
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linu=
x.intel.com/

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v4: Drop the global show-region flag; pass perf_session to
>     perf_script__meminfo_scnprintf() and gate the Region field
>     on the feature bit, with a pipe-mode fallback
>
> v3: make memory region reporting conditional on feature bit
> ---
>  tools/perf/builtin-script.c                   | 13 +--
>  tools/perf/util/mem-events.c                  | 86 ++++++++++++++++++-
>  tools/perf/util/mem-events.h                  |  4 +-
>  .../scripting-engines/trace-event-python.c    |  5 +-
>  4 files changed, 98 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index f91d8b1fbd01..410ccad56f99 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2078,11 +2078,12 @@ static int evlist__max_name_len(struct evlist *ev=
list)
>         return max;
>  }
>
> -static int data_src__fprintf(u64 data_src, FILE *fp)
> +static int data_src__fprintf(struct perf_session *session,
> +                            u64 data_src, FILE *fp)
>  {
>         struct mem_info *mi =3D mem_info__new();
> -       char decode[100];
> -       char out[100];
> +       char decode[200];
> +       char out[200];
>         static int maxlen;
>         int len;
>
> @@ -2090,10 +2091,10 @@ static int data_src__fprintf(u64 data_src, FILE *=
fp)
>                 return -ENOMEM;
>
>         mem_info__data_src(mi)->val =3D data_src;
> -       perf_script__meminfo_scnprintf(decode, 100, mi);
> +       perf_script__meminfo_scnprintf(decode, 200, mi, session);
>         mem_info__put(mi);
>
> -       len =3D scnprintf(out, 100, "%16" PRIx64 " %s", data_src, decode)=
;
> +       len =3D scnprintf(out, 200, "%16" PRIx64 " %s", data_src, decode)=
;
>         if (maxlen < len)
>                 maxlen =3D len;
>
> @@ -2487,7 +2488,7 @@ static void process_event(struct perf_script *scrip=
t,
>                 perf_sample__fprintf_addr(sample, thread, evsel, fp);
>
>         if (PRINT_FIELD(DATA_SRC))
> -               data_src__fprintf(sample->data_src, fp);
> +               data_src__fprintf(evsel__session(evsel), sample->data_src=
, fp);
>
>         if (PRINT_FIELD(WEIGHT))
>                 fprintf(fp, "%16" PRIu64, sample->weight);
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 4fd48fd20055..8ce4996cad8d 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -604,8 +604,77 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, co=
nst struct mem_info *mem_inf
>         return l;
>  }
>
> -int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct me=
m_info *mem_info)
> +static int perf_mem__region_scnprintf(char *out, size_t sz, const struct=
 mem_info *mem_info)
>  {
> +       size_t l =3D 0;
> +       u64 mem =3D PERF_MEM_REGION_NA;
> +
> +       sz -=3D 1; /* -1 for null termination */
> +       out[0] =3D '\0';
> +
> +       if (mem_info)
> +               mem =3D mem_info__const_data_src(mem_info)->mem_region;
> +
> +       switch (mem) {
> +       case PERF_MEM_REGION_NA:
> +       case PERF_MEM_REGION_RSVD:
> +               l +=3D scnprintf(out + l, sz - l, "N/A");
> +               break;
> +       case PERF_MEM_REGION_L_SHARE:
> +               l +=3D scnprintf(out + l, sz - l, "Local-shared-cache");
> +               break;
> +       case PERF_MEM_REGION_L_NON_SHARE:
> +               l +=3D scnprintf(out + l, sz - l, "Local-non-shared-cache=
");
> +               break;
> +       case PERF_MEM_REGION_O_IO:
> +               l +=3D scnprintf(out + l, sz - l, "Other-IO");
> +               break;
> +       case PERF_MEM_REGION_O_SHARE:
> +               l +=3D scnprintf(out + l, sz - l, "Other-shared-cache");
> +               break;
> +       case PERF_MEM_REGION_O_NON_SHARE:
> +               l +=3D scnprintf(out + l, sz - l, "Other-non-shared-cache=
");
> +               break;
> +       case PERF_MEM_REGION_MMIO:
> +               l +=3D scnprintf(out + l, sz - l, "MMIO");
> +               break;
> +       case PERF_MEM_REGION_MEM0:
> +               l +=3D scnprintf(out + l, sz - l, "Mem-0");
> +               break;
> +       case PERF_MEM_REGION_MEM1:
> +               l +=3D scnprintf(out + l, sz - l, "Mem-1");
> +               break;
> +       case PERF_MEM_REGION_MEM2:
> +               l +=3D scnprintf(out + l, sz - l, "Mem-2");
> +               break;
> +       case PERF_MEM_REGION_MEM3:
> +               l +=3D scnprintf(out + l, sz - l, "Mem-3");
> +               break;
> +       case PERF_MEM_REGION_MEM4:
> +               l +=3D scnprintf(out + l, sz - l, "Mem-4");
> +               break;
> +       case PERF_MEM_REGION_MEM5:
> +               l +=3D scnprintf(out + l, sz - l, "Mem-5");
> +               break;
> +       case PERF_MEM_REGION_MEM6:
> +               l +=3D scnprintf(out + l, sz - l, "Mem-6");
> +               break;
> +       case PERF_MEM_REGION_MEM7:
> +               l +=3D scnprintf(out + l, sz - l, "Mem-7");
> +               break;
> +       default:
> +               l +=3D scnprintf(out + l, sz - l, "N/A");
> +               break;
> +       }
> +
> +       return l;
> +}
> +
> +int perf_script__meminfo_scnprintf(char *out, size_t sz,
> +                                  const struct mem_info *mem_info,
> +                                  struct perf_session *session)
> +{
> +       struct perf_env *env;
>         int i =3D 0;
>
>         i +=3D scnprintf(out, sz, "|OP ");
> @@ -620,6 +689,21 @@ int perf_script__meminfo_scnprintf(char *out, size_t=
 sz, const struct mem_info *
>         i +=3D perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
>         i +=3D scnprintf(out + i, sz - i, "|BLK ");
>         i +=3D perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
> +       if (session) {
> +               /*
> +                * In case the feature bits are not available, as in
> +                * pipe mode, fallback to checking for the existence of
> +                * memory ranges
> +                */
> +               env =3D perf_session__env(session);
> +               if ((env && session->data->is_pipe && env->nr_memory_rang=
es) ||
> +                   perf_header__has_feat(&session->header,
> +                                         HEADER_MEMORY_RANGES)) {
> +                       i +=3D scnprintf(out + i, sz - i, "|Region ");
> +                       i +=3D perf_mem__region_scnprintf(out + i, sz - i=
,
> +                                                       mem_info);
> +               }
> +       }
>
>         return i;
>  }
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index daa22748f9fe..4ebb8109fc3c 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -4,6 +4,7 @@
>
>  #include <stdbool.h>
>  #include <linux/types.h>
> +#include "session.h"
>
>  struct perf_mem_event {
>         bool            supported;
> @@ -47,7 +48,8 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, const=
 struct mem_info *mem_inf
>  int perf_mem__lck_scnprintf(char *out, size_t sz, const struct mem_info =
*mem_info);
>  int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info =
*mem_info);
>
> -int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct m=
em_info *mem_info);
> +int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct m=
em_info *mem_info,
> +                                  struct perf_session *session);
>
>  struct c2c_stats {
>         u32     nr_entries;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/too=
ls/perf/util/scripting-engines/trace-event-python.c
> index 8f832ae316ca..e359fe529586 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -694,8 +694,9 @@ static void set_sample_read_in_dict(PyObject *dict_sa=
mple, struct perf_sample *s
>  static void set_sample_datasrc_in_dict(PyObject *dict,
>                                       struct perf_sample *sample)
>  {
> +       struct perf_session *session =3D evsel__session(sample->evsel);
>         struct mem_info *mi =3D mem_info__new();
> -       char decode[100];
> +       char decode[200];
>
>         if (!mi)
>                 Py_FatalError("couldn't create mem-info");
> @@ -704,7 +705,7 @@ static void set_sample_datasrc_in_dict(PyObject *dict=
,
>                         PyLong_FromUnsignedLongLong(sample->data_src));
>
>         mem_info__data_src(mi)->val =3D sample->data_src;
> -       perf_script__meminfo_scnprintf(decode, 100, mi);
> +       perf_script__meminfo_scnprintf(decode, 200, mi, session);
>         mem_info__put(mi);
>
>         pydict_set_item_string_decref(dict, "datasrc_decode",
> --
> 2.55.0
>
