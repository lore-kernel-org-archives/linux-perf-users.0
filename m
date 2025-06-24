Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A42566FC
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809505; cv=none; b=YAsppqUjlckJ2L4ttmjEk1za5gyYLCjl8zxn8UPa5RrtcZK1jtaC/mCFf0osf4eabm25Hj9TFTLf+SiDGuwbA6NRgqzA0rDmNx4XNTf5HcLLPOrj8dqK9KrjSqaCDu3Up4qO0Nz0icqmqjE147DbCf4u73rn3Hj71hYk7I93f9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809505; c=relaxed/simple;
	bh=zONNn9pyWUemm1xt16gFXoqCjFkdMDuzLTIiiVYNUAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Li5Qx0IX4Ih9RXpPt/dRgXNaP33utPjVYxEF/8NrXXYi7jOqjUEOY3UEBNKKbFQUiygjghflJWWLW9ZEtUllBk8Spr8zapQNklqiViaAh0mDLuVYTW0vu02fSvV+DZgusA7UMzslrvqHH8AojG7Gab7O0+Sq5IK+W9LTxFF6lwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ber2peYh; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ber2peYh"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so79555ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750809503; x=1751414303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iG/Zv6yLvlO+K1c2AY5mxCu5YH7CkBhhNvJhoxePL8c=;
        b=ber2peYhDaDKfkfdD5GdYhY1EYBspzT9KlWUkkJjnkS7u/7hglsWjZ0ux3Tf+tDwqk
         6gpyRFyZIse3nvi0A/afkE2ZJPsPQjOUsQXEXlsjivawt3HBbv3eyV0wjDlNJqllJlRv
         2SdQTe4txWFMMSCqeIp4v6KNBLIjyh+IEbVMwKPxqvqiiIRWo6ragvm0K6JuXr1pE3NC
         JA9sHZN3pG5ih8+IVnfyPRGVBytUBXw/jNYGVNCT6s8sOjKNDyipsYNahAEvhKGKEE5K
         HMLewip/ESOK+Iu71SINDunW5g9TjUHV6AzHfT1mtTDeNSwqfZVCJ1zjAxjyzbE0Vwap
         ousw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750809503; x=1751414303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iG/Zv6yLvlO+K1c2AY5mxCu5YH7CkBhhNvJhoxePL8c=;
        b=MkNDGAKuv5bXXAaT1Z3gK+2bFS9a2PN+HLQT0F+Ilde+kTa5kH18sO58Sa816D2NbV
         4b9XhwrODvnqyVzOKOz+x3Ba/aVeo0d4GkIxwusc8nSXTb15lTyf69fCV9+Uy8bqCksZ
         cqpe+brnZZUfhfKkbsV78uZeq43ynnk6Rv7etJe10FxraIrB+MDDBHTVJqcoEvCrT7l8
         /ybPNc5bQrrXlz2AAe85DD50tqhr5+z+iMAPazFN9OWUmp9y+Elg7f3j/oxLACMhYBd1
         UlyYlKe9uVmpAhbxOOa2R0PXREe2F2UR+le1c/LcsG4oyHuatVyT+WZd995wm+6bv3sv
         k1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCURSNpuRyTH2SxS/xs4GEwtUqI3fRpdU6Qz+d6463pdi1SEYnKhqyZEQ+rl4kSWetQ0XAMfqR1iH/IIDZNQcBQs@vger.kernel.org
X-Gm-Message-State: AOJu0YzEaHERr/IlpSTskZhYa+Mp74KltM2z1x4md+N1Dfi7lo00etIe
	tOj0QT3UfHyRXBk01R2t/aJtTrHutlVH/9M+NCuOMkvPi6QuzOIis2geSJpQ8I+ROsB6F/AkEAf
	sebBek96OxEwHq2qzNBPLl9rxnGi8J0avVDt9Bm//
X-Gm-Gg: ASbGncvenzDLNk615V7pdFcJ8AVQ7D3kjrW4g7k2qbHnipkuZL5S8/o2vBcfyJxWPVc
	Ohz46aLGMCkiUWAHkbec/HPy+2lB6UpXY5oEaruC6sxZNdexq7YmHYzY0L4RHmwsBtH42oBHKZs
	ZAAdRGjtCrvhSoHQYoi0ZRY8MVqDrohO5CR6svqYWbNuvcRXQWiAfvpYp9nPlUYC8zsAHVqIfX
X-Google-Smtp-Source: AGHT+IGBqq2uzi1iXRZYiBTgNWtXp4NXpQ5YSeoA1v+WUdjP028nu7XsYGjIbSuyWHcQ+JLQUkMm5iwUL8hxi6Ag8bY=
X-Received: by 2002:a05:6e02:1fc1:b0:3d9:6c99:5a83 with SMTP id
 e9e14a558f8ab-3df3433f75amr570055ab.8.1750809502689; Tue, 24 Jun 2025
 16:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624221545.1711008-1-ctshao@google.com>
In-Reply-To: <20250624221545.1711008-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Jun 2025 16:58:11 -0700
X-Gm-Features: AX0GCFuoGpMpf9ipUJhqwxJVMdNdmQT_mQvyEEJ5e0_dXLJmrONU2SNlI-1Vxoc
Message-ID: <CAP-5=fU+TN6FiRYc_g2etdBeXBujKtHA2z=NE3k3mBrz2bUS1Q@mail.gmail.com>
Subject: Re: [PATCH v3] perf stat: Fix uncore aggregation number
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, wy.shih90@gmail.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:15=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Follow up:
> lore.kernel.org/CAP-5=3DfVDF4-qYL1Lm7efgiHk7X=3D_nw_nEFMBZFMcsnOOJgX4Kg@m=
ail.gmail.com/
>
> The patch adds unit aggregation during evsel merge the aggregated uncore
> counters. Change the name of the column to `ctrs` and `counters` for
> json mode.
>
> Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
> cpumask=3D"0,120"
> Before:
>   perf stat -e clockticks -I 1000 --per-socket
>   #           time socket cpus             counts unit events
>        1.001085024 S0        1         9615386315      clockticks
>        1.001085024 S1        1         9614287448      clockticks
>   perf stat -e clockticks -I 1000 --per-node
>   #           time node   cpus             counts unit events
>        1.001029867 N0        1         3205726984      clockticks
>        1.001029867 N1        1         3205444421      clockticks
>        1.001029867 N2        1         3205234018      clockticks
>        1.001029867 N3        1         3205224660      clockticks
>        1.001029867 N4        1         3205207213      clockticks
>        1.001029867 N5        1         3205528246      clockticks
> After:
>   perf stat -e clockticks -I 1000 --per-socket
>   #           time socket ctrs             counts unit events
>        1.001026071 S0       12         9619677996      clockticks
>        1.001026071 S1       12         9618612614      clockticks
>   perf stat -e clockticks -I 1000 --per-node
>   #           time node   ctrs             counts unit events
>        1.001027449 N0        4         3207251859      clockticks
>        1.001027449 N1        4         3207315930      clockticks
>        1.001027449 N2        4         3206981828      clockticks
>        1.001027449 N3        4         3206566126      clockticks
>        1.001027449 N4        4         3206032609      clockticks
>        1.001027449 N5        4         3205651355      clockticks
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
> v3:
>   Rename the column to `ctrs` and `counters` in json mode.
>
> v2: https://lore.kernel.org/20250612225324.3315450-1-ctshao@google.com/
>   Rename the column to `aggr_nr`.
>   Remove unnecessary comment.
>
> v1: https://lore.kernel.org/20250611233239.3098064-1-ctshao@google.com/
>
>  tools/perf/util/stat-display.c | 34 +++++++++++++++++-----------------
>  tools/perf/util/stat.c         |  2 +-
>  2 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 729ad5cd52cb..9cb5245a92aa 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -50,15 +50,15 @@ static int aggr_header_lens[] =3D {
>  };
>
>  static const char *aggr_header_csv[] =3D {
> -       [AGGR_CORE]     =3D       "core,cpus,",
> -       [AGGR_CACHE]    =3D       "cache,cpus,",
> -       [AGGR_CLUSTER]  =3D       "cluster,cpus,",
> -       [AGGR_DIE]      =3D       "die,cpus,",
> -       [AGGR_SOCKET]   =3D       "socket,cpus,",
> -       [AGGR_NONE]     =3D       "cpu,",
> -       [AGGR_THREAD]   =3D       "comm-pid,",
> -       [AGGR_NODE]     =3D       "node,",
> -       [AGGR_GLOBAL]   =3D       ""
> +       [AGGR_CORE]     =3D       "core,ctrs,",
> +       [AGGR_CACHE]    =3D       "cache,ctrs,",
> +       [AGGR_CLUSTER]  =3D       "cluster,ctrs,",
> +       [AGGR_DIE]      =3D       "die,ctrs,",
> +       [AGGR_SOCKET]   =3D       "socket,ctrs,",
> +       [AGGR_NONE]     =3D       "cpu,",
> +       [AGGR_THREAD]   =3D       "comm-pid,",
> +       [AGGR_NODE]     =3D       "node,",
> +       [AGGR_GLOBAL]   =3D       ""
>  };
>
>  static const char *aggr_header_std[] =3D {
> @@ -304,7 +304,7 @@ static void print_aggr_id_std(struct perf_stat_config=
 *config,
>                 return;
>         }
>
> -       fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, 4, aggr_=
nr);
> +       fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, /*strlen=
("ctrs")*/ 4, aggr_nr);
>  }
>
>  static void print_aggr_id_csv(struct perf_stat_config *config,
> @@ -366,27 +366,27 @@ static void print_aggr_id_json(struct perf_stat_con=
fig *config, struct outstate
>  {
>         switch (config->aggr_mode) {
>         case AGGR_CORE:
> -               json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-num=
ber\" : %d",
> +               json_out(os, "\"core\" : \"S%d-D%d-C%d\", \"counters\" : =
%d",

Do we need to change the test?
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/lib/perf_json_output_lint.py?h=3Dperf-tools-n=
ext#n48
I think we can also document the value in the man page:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Documentation/perf-stat.txt?h=3Dperf-tools-next#n637
I think because it was ambiguous before we hadn't done this.

Thanks,
Ian

>                         id.socket, id.die, id.core, aggr_nr);
>                 break;
>         case AGGR_CACHE:
> -               json_out(os, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggrega=
te-number\" : %d",
> +               json_out(os, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"counter=
s\" : %d",
>                         id.socket, id.die, id.cache_lvl, id.cache, aggr_n=
r);
>                 break;
>         case AGGR_CLUSTER:
> -               json_out(os, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggregat=
e-number\" : %d",
> +               json_out(os, "\"cluster\" : \"S%d-D%d-CLS%d\", \"counters=
\" : %d",
>                         id.socket, id.die, id.cluster, aggr_nr);
>                 break;
>         case AGGR_DIE:
> -               json_out(os, "\"die\" : \"S%d-D%d\", \"aggregate-number\"=
 : %d",
> +               json_out(os, "\"die\" : \"S%d-D%d\", \"counters\" : %d",
>                         id.socket, id.die, aggr_nr);
>                 break;
>         case AGGR_SOCKET:
> -               json_out(os, "\"socket\" : \"S%d\", \"aggregate-number\" =
: %d",
> +               json_out(os, "\"socket\" : \"S%d\", \"counters\" : %d",
>                         id.socket, aggr_nr);
>                 break;
>         case AGGR_NODE:
> -               json_out(os, "\"node\" : \"N%d\", \"aggregate-number\" : =
%d",
> +               json_out(os, "\"node\" : \"N%d\", \"counters\" : %d",
>                         id.node, aggr_nr);
>                 break;
>         case AGGR_NONE:
> @@ -1317,7 +1317,7 @@ static void print_header_interval_std(struct perf_s=
tat_config *config,
>         case AGGR_CLUSTER:
>         case AGGR_CACHE:
>         case AGGR_CORE:
> -               fprintf(output, "#%*s %-*s cpus",
> +               fprintf(output, "#%*s %-*s ctrs",
>                         INTERVAL_LEN - 1, "time",
>                         aggr_header_lens[config->aggr_mode],
>                         aggr_header_std[config->aggr_mode]);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 355a7d5c8ab8..b0205e99a4c9 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -526,7 +526,7 @@ static int evsel__merge_aggr_counters(struct evsel *e=
vsel, struct evsel *alias)
>                 struct perf_counts_values *aggr_counts_a =3D &ps_a->aggr[=
i].counts;
>                 struct perf_counts_values *aggr_counts_b =3D &ps_b->aggr[=
i].counts;
>
> -               /* NB: don't increase aggr.nr for aliases */
> +               ps_a->aggr[i].nr +=3D ps_b->aggr[i].nr;
>
>                 aggr_counts_a->val +=3D aggr_counts_b->val;
>                 aggr_counts_a->ena +=3D aggr_counts_b->ena;
> --
> 2.50.0.714.g196bf9f422-goog
>
