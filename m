Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247D3B47DA
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777643058; cv=pass; b=e9uyswuPvRZ4hH/XLLtNugBq76jpY8CgkeHRKMXLLXZGPoCsi3npvPzrYNgb0FSvTeHC1burQHjxDbNwatlOhokGQtojLZblGqYvj6+XSylBsPOMJixnKMg4dJBoqs9Z5XgpnBLW4+qOxYKp8y2Hq+iNKbheJktK/2eoTXb40lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777643058; c=relaxed/simple;
	bh=NmLWNg8pYE0nrqRfjLPX317p1dU1WFEtC4miG0Bzw2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cS8TXKd60hAgjPS9fVTxkAr0ZTrfNAaqhX/tJBEqOSWoKn1I6YO56ZvN6V21Ab93WAkzz0zfRQq3bm52dLmmm0kIxqOfBhAKP4Y/5Hx3lyeBEYcyGNmJZPUxhj7fqEjWTwA4g2PA6TuEV5TZfVJrAR+JjcE8nOW4MZPK3QOqgFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIu5uOS0; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIu5uOS0"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1270fc2bdf2so7795c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 06:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777643056; cv=none;
        d=google.com; s=arc-20240605;
        b=bZxi6crSvP+QNH0PdDvbOylGMVfQ4xuez71HPeuzE0Fgg4JnO2hyGs/V2g29xc54iw
         xQgQnU/V9pVmgzik9gB2VVeH6BPXzScvXd8u1BVpNxEbqwXBlNhD9ZV2FZdMRgkRtYTf
         EPb5b8fouyc2um4Ow7YTTqoJ3OjW1RijW+bLrZ+hL0Efn9IcyKy4XlPRAla7/wMMkJJF
         XTihLApELqIfLScNkT2MiQf6yY12Q/kwBLbFdnasDUEgLhE0MR6XQy9hwwnjaTSgRbWj
         CeptHPJhOaGe+63YJ5V/GISxFIokL0RPXdQdV2CF69SxtVYZIglHzLhBO45rDGWWrxe6
         B0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=671Se349esvkT76WjN1gqvD6meNw0o0/gv7gPNf6EW4=;
        fh=pJaC+2h9KvpTjs3Phs7zojqY3KxCRu9JG3ZTxJzD+ws=;
        b=K2LWr5xNA/b/n06C3CyCgsl0mQb8KnfoL1cfqLB+V4EW+rRwLkPkUxK415w8TuJzFA
         DPkDwnh0IiA1Pi6WiVzan4Li97mAEnSWkDjY2YUCVYTTUDuzBlzJ8tNWA7G2UZbAmi15
         oQMsIvINhJEJQGpcpnpD3oplX2WXdAlBXoFiAQWDVcLurkCvrspG/HhnOGgECLt1olOM
         tCpbXoaMJDzCCDysDS8i6j7fTr0nl6rVwAgqFm8myin3wDol4jTDSNVroVpdKLgkr/3R
         J24DDNLS2x3i8RAyYTnSIMMVH2+0DwFNOP+byFVHi6/YaWpisxoAmTcZttuhZg2UoSSC
         4fjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777643056; x=1778247856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=671Se349esvkT76WjN1gqvD6meNw0o0/gv7gPNf6EW4=;
        b=PIu5uOS0UsLDP24FSqern4SjXu/HEI7fPKPHtn9IK7nNyZD8HyhNqPFzcTQJsuFYCl
         zBnXNxnRXKPMrShu5Tkl3BZBN8rDeEMp/RIcQvUDmUjWIfi29Z0MiH0TamL4xWF4YKM5
         NQuIbhDwAxWbQtZhmYKOYcTHvxSqFD0pfnq7ljPf1yLxwwPsPrd2mJ2bIxgWo2mEfKKE
         W3r5yW9mifX9O+8nIVvf+Mcu5W71FWYmuiZiKqyKykaVoIxFlz3UQBVlcQFZlRegAW7B
         k9wdvlrBj0SjiJccwQiTj04fMr4lStteTo1cvees5dMx5bh5bgL/YUJhPdWXnJK2TG17
         XSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777643056; x=1778247856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=671Se349esvkT76WjN1gqvD6meNw0o0/gv7gPNf6EW4=;
        b=rgK0Q6LkQXpAbQ14P6sdXxxcJ3GiWYtRmZD4COG7hjCRKRI82vO0EuteuwbdMQ+pEC
         7PzeyFu39izqFCEaC5RGZI0xC9axAoZmZNCaHJatek0fis4AobS3jlSFYf5gI8FnxUn9
         LR93YYgWFsPwW033UypLsin6gVApq2GOwtSSD18G7f4jeAs6RoBLKa+AKMMJjMCrUbKF
         LWI6CCxVIeL/Je5tGBGYoZV0Yxrj/JBsiHuc922YfVtvY3Q/tji7xvRXjmWAcHFTm9Eu
         csbbosVWyRSWmI0vbSb3sOMvGim1PMuI65uQQPunrfVbo2t29Gvsi7pcWZwFnyK2RhZo
         cFUw==
X-Forwarded-Encrypted: i=1; AFNElJ8MIRmoYmmNx1v7lXmNYElnlikzeQITgNAuRNy0S2joQ0r+yf0+qysYsO1qT3uHfY5biIvu/0KzAZ5HQ/Q5VQ+G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2WRfvbQdN/mcniW8uVh5gRedG14zp3bQ1WB6ec2aJf6GV8vfD
	oafUl/ihq8i4PtA7OrRcg1eRIgqD+MQgHB7VIn8t2HQTEDX+OjjZwwwrtk9KbWjgu4KPPoPLorR
	PQeae02O2XjAeythBcKTiCbOkeO0B2tGHrhdGti7D
X-Gm-Gg: AeBDietUdDpnJcAvYdzpGzZWsZ5GFGIZ8oDzJqgaYaBAf42xwOFDvRjXbBkpHofiDxQ
	1u7GJC/N6qC3c++O826w5aSyicl974+L7n5msGYIYznD8vyFUs6fIMfd56tw0WzRPeHmnL8oqL7
	NKb6lr4/rxFnwquCCG8j6Lj24gu+fx33VqP8oJgBWx4YUXY6Y6fkw1txDHRuk53ZDVj2jEuR+hI
	bVf5aCNLUKP/j1f3ZgL468JYFCkwtRo2bNUIFX9/oOpROuc1dauVXNWWzVgiSwWgCXeQAH0hIoq
	h84HH9Jw9LYCxtct965YeUpRwAQdyGAV66VOGYfw
X-Received: by 2002:a05:7022:ec07:b0:12c:33ba:e837 with SMTP id
 a92af1059eb24-12df84e691dmr85590c88.21.1777643055815; Fri, 01 May 2026
 06:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501043532.790711-1-ctshao@google.com>
In-Reply-To: <20260501043532.790711-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 May 2026 06:44:02 -0700
X-Gm-Features: AVHnY4IJuvRZ7o8yrpC2kPu11vgxjOouUdXj52sKDbzaB8cwpvhaFen1tvnDM10
Message-ID: <CAP-5=fVJPDyW4bUUm9yNU+qwfjJ9Gb-Ssxx4KHdsFz_0J8KMmQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Ensure event leader stays at head of evlist
 after sorting
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:35=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> From: Ian Rogers <irogers@google.com>
>
> For evlist of a certain event/metric, the HEAD should be the event
> leader. In some scenarios where uncore_xxx_0 does not exist, the event
> leader is not the first element after sorting. For example, on my test
> machine uncore_iio_0 does not exist, the event leader is uncore_iio_2.
>
> However, in `evlist__cmp`, it was reordered based on the PMU name, which
> makes uncore_iio_1 the HEAD of evlist, breaking the following merge
> logic in `evsel__merge_aliases`.
>
> The patch adds a loop at the end of
> `parse_events__sort_events_and_fix_groups` to make sure the first
> wildcard match is the earliest entry in the list, updating pointers
> accordingly without breaking reordering detection.
>
> Tested on DUT lacks uncore_iio_0, and `perf test` looks good.
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Fixes: 347c2f0a0988 ("perf parse-events: Sort and group parsed events")

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/parse-events.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 1497e1f2a08c..be825617321d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2251,6 +2251,33 @@ static int parse_events__sort_events_and_fix_group=
s(struct list_head *list)
>                 }
>                 last_event_was_forced_leader =3D (force_grouped_leader =
=3D=3D pos);
>         }
> +
> +       /*
> +        * Make sure the first wildcard match is the earliest entry in th=
e list.
> +        * Since list_sort might have reordered the aliases, the original=
 leader
> +        * might not be at the head of the list anymore. We find the firs=
t
> +        * alias in the sorted list and make it the new leader, and redir=
ect
> +        * all other aliases to it.
> +        */
> +       list_for_each_entry(pos, list, core.node) {
> +               struct evsel *l =3D pos->first_wildcard_match;
> +
> +               if (!l)
> +                       continue;
> +
> +               if (l->first_wildcard_match) {
> +                       /* Original leader was redirected to a new leader=
 */
> +                       pos->first_wildcard_match =3D l->first_wildcard_m=
atch;
> +               } else if (pos->core.idx < l->core.idx) {
> +                       /*
> +                        * We are earlier than the original leader in sor=
ted order,
> +                        * and no earlier alias has claimed leadership ye=
t.
> +                        */
> +                       l->first_wildcard_match =3D pos;
> +                       pos->first_wildcard_match =3D NULL;
> +               }
> +       }
> +
>         list_for_each_entry(pos, list, core.node) {
>                 struct evsel *pos_leader =3D evsel__leader(pos);
>
> --
> 2.54.0.545.g6539524ca2-goog
>
