Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1C2FF669
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764107; cv=pass; b=nYfa6gjYn6OMgwBeRwT9nVAQIYTx9i4IcovX5Nad+4iW9sOUJ7aSBNutXOxLu0d7EHq9NUluYJvm/n4t4Yr0s12+/V/upm3/SEiNNPjwhFDSPP9sbEhitgp5OmKfJf4T2IPHmobccyTqZraVy6Y2TrgO1wmMHaJ8E7hBKn7js24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764107; c=relaxed/simple;
	bh=ksL/gzafz0Efk1+ODiH4YSkxOunINzur9rUw2jnvYbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsysTvxI+An6FmNzdU6N0hljwcFz53gceT1R4ZnaiTyS1d3dxPgfWQusRlJgu1ODP0gmUFTEkInsiWdPNDpa0nyWQjopOaqZJYZGSwe/0EfoRMZ8bn6EKkBPbXHB2D2n7YDdyQln40MM5oLWaEe+eZGVx9W5TbZLbG1oYFFE+Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=keJJ01JT; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="keJJ01JT"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1270f10a774so11450c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 09:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773764105; cv=none;
        d=google.com; s=arc-20240605;
        b=FgZL0JViA2VXZ5LvO9wY5UmN19t+vO0FJ0reU/ntRsFnjayF20LYSMVPx1fTK2JyTJ
         AjNdttvAO+qS/QJmPaPZosZlWtb75dZ0xmKqAtpvjw+rFAAl5/flixAOYVe1rNJOR95c
         wIAR3IoQaATyxYDHdbzHu1AcvsCBucpdU6ddSzxKs/Mvj2cEaC3JVwT7vT6hGnVZi5nI
         nLGr2TTNwU61iNHvnCjpt/xiCMu1rKgNpjgiE/UwVUYlnRQM413XADEDl+QuGbJvlzDI
         nRU2KFLsa8iDhfEswuggM922c8U7ptF/00lKIxEf/wCf83UVlqeL38xygxZllGxG/2oO
         RNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n/2d8p4r0GobD3nDBEggZW6nAt9hS/t+4hlR37ueTqc=;
        fh=T93BtsS/SYwc4DVlDjDulFkKNBeNvrGhYKeG2oMJPzQ=;
        b=ZXAy/eNcpjrWUJNLmZSYuHYYwvP6nDzupRxi5G3J4bfnijPS4d45RaqxWwFK2BoCBT
         guS0gXbdWyDkAWFzR8CH4AF9euYNdfQI2g9T4Sph5dN/ul43FHmMzmwTnxu8YCaIwlGq
         9LDQctepzuqt+I4STb9kuAp1qWsBd3QFon1nek6HTYN0eTLJ8Sm9uFfkF5qZIAyxJwch
         lLwcTSd0DJ2/G+xURS6IiohuaC5BSL/cYDaprwRoidB0oQ7KikIbTupMEUcrAM5+P1+9
         /QkEWMJ7zMQUeBkiGbjj21eKkh418MJFNO3zt9XKnd8X/bWStP1EG0Fo6X1kdsNz2EW7
         a+qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773764105; x=1774368905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/2d8p4r0GobD3nDBEggZW6nAt9hS/t+4hlR37ueTqc=;
        b=keJJ01JTiJjsJ+DQ8vWFHomyNOo8Fo+udpWQ//c0CJtcORyjMkqQg2cqoTfYzifKCl
         4qO6bESVdhFFh7QSlxnL1iIHtNzSFx9jDN4/Hd6pIDrxGppKpOcN2B5GrzDGaT24Bc8a
         uLJKpVfZ53kPscxSMbkGaie1R/yYWrvqCqQ1hDkkv4TIts/dVhK4/bk07CeEYTO1awFu
         Te+liVU5E5/l8Ou0bO9Gi/A5uo+aDnffTbTNj8uaj5SYjILqhYeMS0q1KvPw5+2ISaIe
         67MUccCE8uDI3R4O3hLbJEna4xSRpDaJZdvGxPi9WgzSW839NTRNAuh9QXj1Qk5TP2Cz
         C+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773764105; x=1774368905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/2d8p4r0GobD3nDBEggZW6nAt9hS/t+4hlR37ueTqc=;
        b=Uo47nI02a215Gnx0Fbij2glXQ9sF6kYBY6Tp3KHFA6G64w4Cra7ScKIrFbLyozkF7v
         0zgJGrJp6H9x76Lz4gzHggXZ+lzQj0waHlRytz1Kdyt9G8mbtetIcHIw1n4iPRYIgYlA
         pisItY2Hjv8QAXcs35F9rMPptg4E7mg45CDFeyH+awM2KgBieQjhywUGrPr1xC+TPHVv
         7eQ5RxqBA4qLS/1JF0H/XalFzESL485DhA0H5UozZ5QrtICuNUn59RjH0aN7WnDPtpIN
         9nxUeyPpjLvvxyP+EPQWlYI2AFDyM3IPjhcw0rFwMvRtOT1CzibZEPRi+8Gd0ZL0a4JG
         qmTw==
X-Forwarded-Encrypted: i=1; AJvYcCUU5BcNIT9HqjLxFWfwiiidsUHOYl2+dhSwOMfVqdF/vyrOpyTX1xhS7KH6UU6Xoqwu+BspJXRcOmh1F8rWAMxB@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHVyrDYz0t4reiVeBkHKW+VHJVWPw+TYdVSCPaEiTHBSzcRNU
	9yXNE8GHn95BwM5mihuF3yZjRlN0fLy2C1oJj3JAyDSXuXI28uRrzG4JzfM7y2jdO/NGbjhBY08
	FefMS90dNO/ltN4DzKc2xsBvFmuPjnPbD3GvmPypV
X-Gm-Gg: ATEYQzz5vw0dmkwcd7Scqkd+f7j3yrqpNJA6q8PPR+iStF6hlslYn8gDvnATKiFHvRB
	HBH4350umsG9FX+sHlV03GK7CfXHcJ4rZ3f6sCFuwESWkL3jQc+UHkC0D1y+M6OmfF3V8kd2GUP
	54Ks5ZOS1lQYDq1RfC8uIkAxYcYGv8q1qLzStrpwtsCZugSfSQSDFMDVpQueLC+99J1FKyz5G66
	nEF0nnj3TmHVFsBXYtekYCcchvv2W4Ih30pOtWYSQYmWObPtReH6AHGG1BpiD1cb1+9Lyyl2JXW
	4WHF6FuS
X-Received: by 2002:a05:7022:e1b:b0:11f:25fe:952f with SMTP id
 a92af1059eb24-1291799b8dcmr237485c88.8.1773764103882; Tue, 17 Mar 2026
 09:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316175631.3169955-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20260316175631.3169955-1-stephen.s.brennan@oracle.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 09:14:50 -0700
X-Gm-Features: AaiRm53d30iDwuPCR3h38qP6Km8zrsBGXiONIFYpqoRyeLAFgfIyYz6y7uj2mKc
Message-ID: <CAP-5=fWFrDaG7dCT2AcEAu28aAPKz6qMtpzmrG+4-vn1NLQ--Q@mail.gmail.com>
Subject: Re: [PATCH v2] tools: perf: add comm_ignore_digit column
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ricky Ringler <ricky.ringler@proton.me>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	Tianyou Li <tianyou.li@intel.com>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:56=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> The "comm" column allows grouping events by the process command. It is
> intended to group like programs, despite having different PIDs. But some
> workloads may adjust their own command, so that a unique identifier
> (e.g. a PID or some other numeric value) is part of the command name.
> This destroys the utility of "comm", forcing perf to place each unique
> process name into its own bucket, which can contribute to a
> combinatorial explosion of memory use in perf report.
>
> Create a less strict version of this column, which ignores digits when
> comparing command names. This allows "similar looking" processes to
> again be placed in the same bucket.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>
> Changes from v1:
> - Rebased on linux-tools-next. Resolved conflict with commit cbd41c6d4c26=
c
>   ("perf report: Update sort key state from -F option").
>
> v1: https://lore.kernel.org/linux-perf-users/20260305181847.3249498-1-ste=
phen.s.brennan@oracle.com/
>
>  tools/perf/util/hist.c |  1 +
>  tools/perf/util/hist.h |  1 +
>  tools/perf/util/sort.c | 92 +++++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/sort.h |  1 +
>  4 files changed, 94 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 7ffaa3d9851b4..a6e566dda3a15 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -110,6 +110,7 @@ void hists__calc_col_len(struct hists *hists, struct =
hist_entry *h)
>         len =3D thread__comm_len(h->thread);
>         if (hists__new_col_len(hists, HISTC_COMM, len))
>                 hists__set_col_len(hists, HISTC_THREAD, len + 8);
> +       hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len);

Thanks for working on this! Sashiko is noting some nits in its review:
https://sashiko.dev/#/patchset/20260316175631.3169955-1-stephen.s.brennan%4=
0oracle.com

Because hist_entry__comm_ignore_digit_snprintf() replaces consecutive digit=
s
with the 3-character string <N>, the formatted string is often longer than
the original string (e.g., a command named worker_1 expands from 8 to 10
characters: worker_<N>).

Since the snprintf logic strictly bounds the output to the calculated width=
,
will the expanded output be prematurely truncated in reports?

>
>         if (h->ms.map) {
>                 len =3D dso__name_len(map__dso(h->ms.map));
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 1d5ea632ca4e1..ae7e98bd9e46d 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -44,6 +44,7 @@ enum hist_column {
>         HISTC_THREAD,
>         HISTC_TGID,
>         HISTC_COMM,
> +       HISTC_COMM_IGNORE_DIGIT,
>         HISTC_CGROUP_ID,
>         HISTC_CGROUP,
>         HISTC_PARENT,
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 42d5cd7ef4e23..45662302ed5ba 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <ctype.h>
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <regex.h>
> @@ -265,6 +266,93 @@ struct sort_entry sort_comm =3D {
>         .se_width_idx   =3D HISTC_COMM,
>  };
>
> +/* --sort comm_ignore_digit */
> +
> +static int64_t strcmp_nodigit(const char *left, const char *right)
> +{
> +       for (;;) {
> +               while (*left && isdigit(*left))
> +                       left++;
> +               while (*right && isdigit(*right))
> +                       right++;
> +               if (*left =3D=3D *right && !*left) {
> +                       return 0;
> +               } else if (*left =3D=3D *right) {
> +                       left++;
> +                       right++;
> +               } else {
> +                       return (int64_t)*left - (int64_t)*right;
> +               }
> +       }
> +}

Sashiko also notes what's below, but I sent out a patch to make all
chars unsigned (like the kernel):
https://lore.kernel.org/lkml/20260306191908.2065682-1-irogers@google.com/
but it has no reviews.

Process command strings can contain arbitrary non-ASCII bytes (e.g., UTF-8
characters). On architectures where char is signed, these bytes evaluate as
negative integers.

Passing a negative value (other than EOF) to ctype.h's isdigit() causes
undefined behavior. In glibc, it results in an out-of-bounds read on the
__ctype_b_loc array, which can lead to a segmentation fault.

Additionally, if char is signed, returning (int64_t)*left - (int64_t)*right
means non-ASCII characters will mathematically sort before ASCII characters=
.

Does this code need to cast the characters to unsigned char before passing
them to isdigit() and subtracting them?

Thanks,
Ian


> +
> +static int64_t
> +sort__comm_ignore_digit_cmp(struct hist_entry *left, struct hist_entry *=
right)
> +{
> +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->com=
m));
> +}
> +
> +static int64_t
> +sort__comm_ignore_digit_collapse(struct hist_entry *left, struct hist_en=
try *right)
> +{
> +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->com=
m));
> +}
> +
> +static int64_t
> +sort__comm_ignore_digit_sort(struct hist_entry *left, struct hist_entry =
*right)
> +{
> +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->com=
m));
> +}
> +
> +static int hist_entry__comm_ignore_digit_snprintf(struct hist_entry *he,=
 char *bf,
> +                                               size_t size, unsigned int=
 width)
> +{
> +       int ret =3D 0;
> +       unsigned int print_len, printed =3D 0, start =3D 0, end =3D 0;
> +       bool in_digit;
> +       const char *comm =3D comm__str(he->comm), *print;
> +
> +       while (printed < width && printed < size && comm[start]) {
> +               in_digit =3D !!isdigit(comm[start]);
> +               end =3D start + 1;
> +               while (comm[end] && !!isdigit(comm[end]) =3D=3D in_digit)
> +                       end++;
> +               if (in_digit) {
> +                       print_len =3D 3; /* <N> */
> +                       print =3D "<N>";
> +               } else {
> +                       print_len =3D end - start;
> +                       print =3D &comm[start];
> +               }
> +               print_len =3D min(print_len, width - printed);
> +               ret =3D repsep_snprintf(bf + printed, size - printed, "%-=
.*s",
> +                                       print_len, print);
> +               if (ret < 0)
> +                       return ret;
> +               start =3D end;
> +               printed +=3D ret;
> +       }
> +       /* Pad to width if necessary */
> +       if (printed < width && printed < size) {
> +               ret =3D repsep_snprintf(bf + printed, size - printed, "%-=
*.*s",
> +                                      width - printed, width - printed, =
"");
> +               if (ret < 0)
> +                       return ret;
> +               printed +=3D ret;
> +       }
> +       return printed;
> +}
> +
> +struct sort_entry sort_comm_ignore_digit =3D {
> +       .se_header      =3D "CommandIgnoreDigit",
> +       .se_cmp         =3D sort__comm_ignore_digit_cmp,
> +       .se_collapse    =3D sort__comm_ignore_digit_collapse,
> +       .se_sort        =3D sort__comm_ignore_digit_sort,
> +       .se_snprintf    =3D hist_entry__comm_ignore_digit_snprintf,
> +       .se_filter      =3D hist_entry__thread_filter,
> +       .se_width_idx   =3D HISTC_COMM_IGNORE_DIGIT,
> +};
> +
>  /* --sort dso */
>
>  static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
> @@ -2583,6 +2671,7 @@ static struct sort_dimension common_sort_dimensions=
[] =3D {
>         DIM(SORT_PID, "pid", sort_thread),
>         DIM(SORT_TGID, "tgid", sort_tgid),
>         DIM(SORT_COMM, "comm", sort_comm),
> +       DIM(SORT_COMM_IGNORE_DIGIT, "comm_ignore_digit", sort_comm_ignore=
_digit),
>         DIM(SORT_DSO, "dso", sort_dso),
>         DIM(SORT_SYM, "symbol", sort_sym),
>         DIM(SORT_PARENT, "parent", sort_parent),
> @@ -3577,7 +3666,7 @@ static int __sort_dimension__update(struct sort_dim=
ension *sd,
>                 list->socket =3D 1;
>         } else if (sd->entry =3D=3D &sort_thread) {
>                 list->thread =3D 1;
> -       } else if (sd->entry =3D=3D &sort_comm) {
> +       } else if (sd->entry =3D=3D &sort_comm || sd->entry =3D=3D &sort_=
comm_ignore_digit) {
>                 list->comm =3D 1;
>         } else if (sd->entry =3D=3D &sort_type_offset) {
>                 symbol_conf.annotate_data_member =3D true;
> @@ -4040,6 +4129,7 @@ static bool get_elide(int idx, FILE *output)
>         case HISTC_DSO:
>                 return __get_elide(symbol_conf.dso_list, "dso", output);
>         case HISTC_COMM:
> +       case HISTC_COMM_IGNORE_DIGIT:
>                 return __get_elide(symbol_conf.comm_list, "comm", output)=
;
>         default:
>                 break;
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index d7787958e06b9..6819934b4d48a 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -43,6 +43,7 @@ enum sort_type {
>         /* common sort keys */
>         SORT_PID,
>         SORT_COMM,
> +       SORT_COMM_IGNORE_DIGIT,
>         SORT_DSO,
>         SORT_SYM,
>         SORT_PARENT,
> --
> 2.47.3
>
