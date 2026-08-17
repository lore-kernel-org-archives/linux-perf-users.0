Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC135383993
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002559; cv=pass; b=VH8pKM5NufAJDH13aYO0fAvNioh0uPPeHLCCGfl1grsJ1mRkqQqX8NvAMJadwGaJ41Sy1fjNKwdptISmIGg5jqBqAWCKg2Zou/Yhbky2WyPiiwIfA9ADBr97+iPbqu8W25a5/SbQ2mCDoDmJMVL92kLx73Gl0bBdpGGOfmHyrWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002559; c=relaxed/simple;
	bh=WC58p4IPqj0+vZWIHolWQ11EZJmZTl3ABsnPOPSnO3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bV2McyePN5vHwUJVkmnw6orAs9fESJgGI9rB1C/MLKQIk8c88un/zOogpOO9yxV1GFGfvFhpkQc1IZ5HOS/btksiEby19+tx6SaSMoVvJGqF5UMXgcdhkHhO+dix3Y4d5rxE0kfga2TbM9VzlWj5TFrF1qk2VtntA/XxL18xL8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JY4NhrY1; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JY4NhrY1"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c15a5b265so90521cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787002557; cv=none;
        d=google.com; s=arc-20260327;
        b=rQY7OKto8wwItp5aEkE9XKh8Usr7WWysNSmxbQpaI4j3ormLjiQjh4ahdcl4MaMKmL
         xOMvbaexfRjkDsB3cziGr76plSZAoq4rFzOgDsiFDHwLPdwly3J80XttRZ/PQU5BxU3P
         MrqQMoikAWpd/C99EvR83YdNByKKCFt3rws186ASxrX9VqyXoFHkNRNhLagLXRYqpnHa
         3KUc+aPaqJmQRU8/jKZ3aXqQGnSKas4EP0uDfyKBuDMkdB2piFQVGTyrl2Ti5bCvLjoE
         AsSM7BbHsvp3ttinPOWCr0s2QXb2N0DiM2+RGLdapK7W7mvvNABgoIjgvKNAOCxy/gTS
         wK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AhCV5MCDRiANiY7+toBixnkAMI2Q+FnanhCshjd69yg=;
        fh=eHswFpmvd/0MhjeGeNKGce0JYQCk5BXB8E/GFqIMwUU=;
        b=dZJli4kRSw7jffksSIizc2xMe3dLqJNm8rAVIVV/KmI3ppJT6s993xrPOSLGoCfQK4
         LSoyVohNHFEpnFVy/s6UkWGqRYCyUXGF7mz+sPXS7/38F3LMmIRWwmkl21KyUTC6/FKh
         TZQWTTFCaeUORG8H195OuCcu6IyMOY7P+QG+73s8xt2twqgEy6awj7kpB+CMgQ5fdtFU
         HUe3FI4Bluuhc+6gDKMze1SATaZDrdUwPd4fQ26B4WoT4zDNKtUAX+QgcOhrOWccQO/4
         CBWsVnz9DHYD2QfpoNQFTqYl27SPN2rKP3MfxusWEEf7vEcgTv1CLqj+od2xF41GJ+LR
         uzBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787002557; x=1787607357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AhCV5MCDRiANiY7+toBixnkAMI2Q+FnanhCshjd69yg=;
        b=JY4NhrY1WfqaR2XFUEzbEbh2zL6v47XPH98mUwyMQOzJxZ8FqG3bVMoNpadZujP+zr
         Yj+7+2BLP4jowCQ/RPDr58qJ312V4bFS2TT/jH1ERIFdnyCf3Bkm9KsziIKrZ4dL56rB
         f7lBZilSWRAtOtcczmDDJvEobD2b/gO6IIZcZ6SGoBiC1R+A6CUIYBp+BJFuQS/hE2y5
         +C1mN9Yih1IgTeu1N50fOAkh8LWXAqy/kiA0KU9QOsfR8CcVRSxhuijNOACUdevngCGg
         VX7vYk5zr5Pgf7p0ZBzYBKLHvU1vbuBqCjgCiLNQRJ+26nl1zS6YkOG8LC0Rot18qXP2
         qKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002557; x=1787607357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhCV5MCDRiANiY7+toBixnkAMI2Q+FnanhCshjd69yg=;
        b=IkEHyHyU9n2VZMsQauBhwXfnUtOBL2f/9+FMIMcx1qNntPdWj7Gf5s6hKHMOmfC0mC
         aOjueC/0TbeG3Kf/5Ri2Kn4x1E6kBju7VdPvskQGso0H5rYCCGapJqyZS3Rbu91uIlSc
         DH8oAwkMK5AmuShxdR9V/W6LeEnXHioMvKts+vMT62yjLUcWwXkhLwVaKmTo/FTY5YwX
         v6VnEMLG0hRmP4HsAB6nFZblHKVrIXmqha4l7qAVW2OMC4zVUozxnW2OHF+2VvZUpsrk
         Y+pbmo+Glh5g8LmxVlxGlT6fJ60b7tM0rop4aZquqWSPKouAOiOByv5qcuGf8w76J8mA
         nPWw==
X-Forwarded-Encrypted: i=1; AHgh+RrPpE8KjcTVikNHNsIwHh3IJRMhpV751hLKQIl+dC2N4/fUMY+4sV1uab+XANCARxXkxAeS9T8He9r9AKrLV6iu@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCIQ9mEFLTb5A1LOcMbkHIqQC2zxkaUQCPsXMqLzB17QHUr1v
	9G1JJazd2wQa2vZnmd0ykyf4Vj5Pb7RFwV8BEdo+XCaGC5O4u1mw4QHl4eivD+gcgpwTTbKVeFG
	IBndCkTOwnOr3QBm2A7Cx/xq0E/KzS7PLEKBfUU4s
X-Gm-Gg: AR+sD10Ee6s55nQk469JPQHggmPKtcnIr9DJFOWxx9etXAnN13QPLBVO2P0PuFF5enr
	Qup5BaEEAhVRXtZHMTp3PLJfCvDtXf+EiXol8d49rRC+SE2inocHueWXGzz/IRFR0OPHkQoKJgc
	eT8iV5onhGGT9kUuNpxO9dH9vM4PO1bzp/J6VVubYbL6JM3u1sDFbeylwL3fW5nlC6Kge1Y4CNJ
	NQl8mUIzndahXALJDxREQeuzQeeVHDMY13I/D4b76Lb+zceG4MHHtb+V20DP3+fmxe8rwg7VnJ3
	xkOkEfavUvdU9GIj59FFMNQWjPGy5o+a7erQGyWUW6oe7DQMi9UG/8Bfk9OckSkOCXk2qcwrUvm
	3MCjQf5/3pQ==
X-Received: by 2002:a05:622a:2b07:b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-52dc47ed5d5mr213451cf.7.1787002555962; Mon, 17 Aug 2026
 14:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811173340.96013-1-thomas.falcon@intel.com> <20260811173340.96013-5-thomas.falcon@intel.com>
In-Reply-To: <20260811173340.96013-5-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:35:44 -0700
X-Gm-Features: AcwNN1WsyJ9ilqPJn8oOgY2EoM3yLNAfX92IsEk_DNng9TUKSIGypUFz5qkaavw
Message-ID: <CAP-5=fX8fG6LUZUjHWKYqFeAhRW3XWmwuBUc=jqpAxde5mC2fQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] perf tools: Show memory region in perf-c2c subcommand
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
> Add memory region field to the cacheline list view to help users
> identify the memory region to which the cacheline belongs. The memory
> region field was included with the introduction of support for the
> Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
> Nova Lake architectures.
>
> An example of the new perf c2c output including the memory region
> field is shown below:
>
> Shared Data Cache Line Table     (112 entries, sorted on Total HITMs)
>        --------------- Cacheline --------------      Tot  ------- Load Hi=
tm -------    Total    Total    Total
> Index             Address  Region  Node  PA cnt     Hitm    Total  LclHit=
m  RmtHitm  records    Loads   Stores
>     0  0xff1b7032a1e8c5c0  N/A        1      47    2.25%       50       4=
4        6     1024     1023        1
>     1  0xff1b6ff3255bb880  N/A        0      11    1.62%       36       3=
4        2       96       93        4
>     2  0xff1b70328e3b9880  N/A        1      13    1.49%       33       3=
3        0      100       91        9
>     3  0xff1b70328b023800  N/A        1       1    1.40%       31       1=
4       17       52       48        4
>     4  0xff1b70328e3b9c00  N/A        1       1    1.31%       29       2=
7        2       67       33       34
>     5  0xff1b70328b0237c0  N/A        1       1    1.26%       28       1=
0       18      154      150        4
>     6  0xff1b6ff3255bbc00  N/A        0       1    1.13%       25       2=
5        0       48       25       23
>     7  0xff1b6ff3255bba40  N/A        0       1    0.99%       22       2=
2        0       46       23       23
>     8  0xff3ab9ba50255c80  N/A      N/A       0    0.77%       17       1=
5        2       35       35        0
>     9  0xff3ab9ba503e3040  N/A      N/A       0    0.77%       17       1=
1        6       37       37        1
>    10  0xff1b703289e88f40  N/A        1      33    0.72%       16        =
9        7       69       63        6
>    11  0xff1b70328e3b9a40  N/A        1       1    0.68%       15       1=
5        0       43       17       26
>    12  0xff1b7032c9fd6a40  N/A        1      15    0.68%       15       1=
5        0       57       54        4
>    13  0xff1b7032a1e8c980  N/A        1      27    0.54%       12       1=
1        1      761      761        0
>    14  0xff1b70727ffd57c0  N/A        1       7    0.54%       12       1=
2        0      219      218        1
>    15  0xffffffffaefe2380  N/A        1       1    0.50%       11        =
8        3       14       14        0
>
> Note: DMR simics does not support memory regions. Since the output is
> captured on SPR, the memory region field shows "N/A" for all cachelines.
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
> v4: correctly handle output_str memory allocation failure
>
> v3: make memory region reporting conditional on feature bit
> ---
>  tools/perf/builtin-c2c.c | 93 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 83 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c9584dbedf77..8cd90524fe49 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -74,6 +74,7 @@ struct c2c_hist_entry {
>         unsigned long           *nodeset;
>         struct c2c_stats        *node_stats;
>         unsigned int             cacheline_idx;
> +       unsigned int             mem_region;
>
>         struct compute_stats     cstats;
>
> @@ -281,6 +282,18 @@ static void c2c_he__set_node(struct c2c_hist_entry *=
c2c_he,
>         }
>  }
>
> +static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
> +                                  unsigned int mem_region)
> +{
> +       if (WARN_ONCE(mem_region > PERF_MEM_REGION_MEM7,
> +                     "WARNING: invalid memory region ID\n"))
> +               return;
> +
> +       /* Update mem_region only if it really accesses memory */
> +       if (mem_region >=3D PERF_MEM_REGION_MMIO)
> +               c2c_he->mem_region =3D mem_region;
> +}
> +
>  static void compute_stats(struct c2c_hist_entry *c2c_he,
>                           struct c2c_stats *stats,
>                           u64 weight)
> @@ -339,6 +352,7 @@ static int process_sample_event(const struct perf_too=
l *tool __maybe_unused,
>         struct addr_location al;
>         struct mem_info *mi =3D NULL;
>         struct callchain_cursor *cursor;
> +       unsigned int mem_region;
>         int ret;
>
>         addr_location__init(&al);
> @@ -366,6 +380,7 @@ static int process_sample_event(const struct perf_too=
l *tool __maybe_unused,
>         }
>
>         c2c_decode_stats(&stats, mi);
> +       mem_region =3D mem_info__data_src(mi)->mem_region;
>
>         he =3D hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
>                                   &al, NULL, NULL, mi, NULL,
> @@ -382,6 +397,7 @@ static int process_sample_event(const struct perf_too=
l *tool __maybe_unused,
>         c2c_he__set_cpu(c2c_he, sample);
>         c2c_he__set_node(c2c_he, sample);
>         c2c_he__set_evsel(c2c_he, evsel);
> +       c2c_he__set_mem_region(c2c_he, mem_region);
>
>         hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>
> @@ -435,6 +451,7 @@ static int process_sample_event(const struct perf_too=
l *tool __maybe_unused,
>                 c2c_he__set_cpu(c2c_he, sample);
>                 c2c_he__set_node(c2c_he, sample);
>                 c2c_he__set_evsel(c2c_he, evsel);
> +               c2c_he__set_mem_region(c2c_he, mem_region);
>
>                 hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>                 ret =3D hist_entry__append_callchain(he, sample);
> @@ -603,6 +620,30 @@ dcacheline_node_count(struct perf_hpp_fmt *fmt, stru=
ct perf_hpp *hpp,
>         return scnprintf(hpp->buf, hpp->size, "%*lu", width, c2c_he->padd=
r_cnt);
>  }
>
> +static int
> +dcacheline_node_mem_region(struct perf_hpp_fmt *fmt, struct perf_hpp *hp=
p,
> +                          struct hist_entry *he)
> +{
> +       int width =3D c2c_width(fmt, hpp, he->hists);
> +       struct c2c_hist_entry *c2c_he;
> +       unsigned int mem_region;
> +       char buf[20];
> +
> +       c2c_he =3D container_of(he, struct c2c_hist_entry, he);
> +       mem_region =3D c2c_he->mem_region;
> +
> +       if (mem_region =3D=3D PERF_MEM_REGION_NA)
> +               scnprintf(buf, sizeof(buf),  "N/A");
> +       /* mem_region could only be >=3D PERF_MEM_REGION_MMIO */
> +       else if (mem_region =3D=3D PERF_MEM_REGION_MMIO)
> +               scnprintf(buf, sizeof(buf), "MMIO");
> +       else
> +               scnprintf(buf, sizeof(buf), "0x%x",
> +                         mem_region - PERF_MEM_REGION_MEM0);
> +
> +       return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
> +}
> +
>  static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>                         struct hist_entry *he)
>  {
> @@ -1425,7 +1466,7 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct=
 perf_hpp *hpp,
>         }
>
>  static struct c2c_dimension dim_dcacheline =3D {
> -       .header         =3D HEADER_SPAN("--- Cacheline ----", "Address", =
2),
> +       .header         =3D HEADER_SPAN("--- Cacheline ----", "Address", =
3),
>         .name           =3D "dcacheline",
>         .cmp            =3D dcacheline_cmp,
>         .entry          =3D dcacheline_entry,
> @@ -1440,6 +1481,14 @@ static struct c2c_dimension dim_dcacheline_node =
=3D {
>         .width          =3D 4,
>  };
>
> +static struct c2c_dimension dim_dcacheline_mem_region =3D {
> +       .header         =3D HEADER_LOW("Region"),
> +       .name           =3D "dcacheline_mem_region",
> +       .cmp            =3D empty_cmp,
> +       .entry          =3D dcacheline_node_mem_region,
> +       .width          =3D 6,
> +};
> +
>  static struct c2c_dimension dim_dcacheline_count =3D {
>         .header         =3D HEADER_LOW("PA cnt"),
>         .name           =3D "dcacheline_count",
> @@ -1871,6 +1920,7 @@ static struct c2c_dimension dim_dcacheline_num_empt=
y =3D {
>
>  static struct c2c_dimension *dimensions[] =3D {
>         &dim_dcacheline,
> +       &dim_dcacheline_mem_region,
>         &dim_dcacheline_node,
>         &dim_dcacheline_count,
>         &dim_offset,
> @@ -2898,8 +2948,9 @@ static int ui_quirks(void)
>         /* Fix the zero line for dcacheline column. */
>         buf =3D fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline=
",
>                                 dim_dcacheline.width +
> +                               dim_dcacheline_mem_region.width +
>                                 dim_dcacheline_node.width +
> -                               dim_dcacheline_count.width + 4);
> +                               dim_dcacheline_count.width + 6);
>         if (!buf)
>                 return -ENOMEM;
>
> @@ -3151,8 +3202,10 @@ static int perf_c2c__report(int argc, const char *=
*argv)
>         OPT_END()
>         };
>         int err =3D 0;
> -       const char *output_str, *sort_str =3D NULL;
> +       const char *sort_str =3D NULL;
> +       char *output_str =3D NULL;
>         struct perf_env *env;
> +       bool has_mem_regions;
>
>         annotation_options__init();
>
> @@ -3316,9 +3369,14 @@ static int perf_c2c__report(int argc, const char *=
*argv)
>                 goto out_mem2node;
>         }
>
> -       if (c2c.display !=3D DISPLAY_SNP_PEER)
> -               output_str =3D "cl_idx,"
> +       has_mem_regions =3D perf_header__has_feat(&session->header,
> +                                               HEADER_MEMORY_RANGES);
> +
> +       if (c2c.display !=3D DISPLAY_SNP_PEER) {
> +               if (asprintf(&output_str,
> +                            "cl_idx,"
>                              "dcacheline,"
> +                            "%s"
>                              "dcacheline_node,"
>                              "dcacheline_count,"
>                              "percent_costly_snoop,"
> @@ -3330,10 +3388,17 @@ static int perf_c2c__report(int argc, const char =
**argv)
>                              "ld_fbhit,ld_l1hit,ld_l2hit,"
>                              "ld_lclhit,lcl_hitm,"
>                              "ld_rmthit,rmt_hitm,"
> -                            "dram_lcl,dram_rmt";
> -       else
> -               output_str =3D "cl_idx,"
> +                            "dram_lcl,dram_rmt",
> +                            has_mem_regions ?
> +                            "dcacheline_mem_region," : "") < 0) {
> +                       err =3D -ENOMEM;
> +                       goto out_mem2node;
> +               }
> +       } else {
> +               if (asprintf(&output_str,
> +                            "cl_idx,"
>                              "dcacheline,"
> +                            "%s"
>                              "dcacheline_node,"
>                              "dcacheline_count,"
>                              "percent_costly_snoop,"
> @@ -3345,7 +3410,13 @@ static int perf_c2c__report(int argc, const char *=
*argv)
>                              "ld_fbhit,ld_l1hit,ld_l2hit,"
>                              "ld_lclhit,lcl_hitm,"
>                              "ld_rmthit,rmt_hitm,"
> -                            "dram_lcl,dram_rmt";
> +                            "dram_lcl,dram_rmt",
> +                            has_mem_regions ?
> +                            "dcacheline_mem_region," : "") < 0) {
> +                       err =3D -ENOMEM;
> +                       goto out_mem2node;
> +               }
> +       }
>
>         if (c2c.display =3D=3D DISPLAY_TOT_HITM)
>                 sort_str =3D "tot_hitm";
> @@ -3368,11 +3439,13 @@ static int perf_c2c__report(int argc, const char =
**argv)
>
>         if (ui_quirks()) {
>                 pr_err("failed to setup UI\n");
> -               goto out_mem2node;
> +               goto out_str;
>         }
>
>         perf_c2c_display(session);
>
> +out_str:
> +       free(output_str);
>  out_mem2node:
>         mem2node__exit(&c2c.mem2node);
>  out_session:
> --
> 2.55.0
>
