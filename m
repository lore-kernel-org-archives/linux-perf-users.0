Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A334D3BE
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049975; cv=pass; b=rLNtq1/zPLLNkNvfSlCGFbVnspymGXaO7ULgqYQQmWxMAfyo40vs5+Ie9mrzLKTapM+Rn4uuLHtD/EsLn2e/Jgj9joHO6oFCxo132luDwYOV8ro74w0LfU4hJJHw2EUZcwlEKwhIVvFWoi76FKywDpRmxHeBWOgq9PTrop5UNB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049975; c=relaxed/simple;
	bh=GbXti6cMAencQ8vDKN47CgJiaiK63jg852bavVZHAr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OX+lqjXFSdH/5VQnZQg+TavZFAHmy3m1hFcpdXAr5TlfBnZn+bCSs57rBbsIqhjLMeIFZ5brd3OXZ8VoJ+pkN5RsyyvpPT0XULxTyj4G4UUcQZ7OqNcjQIQyoOYeUiQp6tmEAhU7W6iI5PXgQd+roe0y3PrGceJ5O7fNe6mbaik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RB76TRdB; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RB76TRdB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso49355ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 23:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778049970; cv=none;
        d=google.com; s=arc-20240605;
        b=NqeVEdGF9eHSYJ5IYSV/5ePotS/L9g0LXLNtZMMm4jak0g8pLgVhhlxVzEdcoDNzwV
         r9u4ESqE1bYuXQKwdRakdTbCBZorXlNjSomcSEonOJoFVEF/Bah2H1CN0P+kk2Zew70R
         IMATFOi4YaUgTIC7tB2FvkDmPYlQnJKZN2/LfQR3fR7E9yKsxOtKoDMo4kYXhTT69cP9
         NIE1YJshoPxKNNqfYEvEqbJfZAv3169IbkXobGUMw6BdMaAamC5xbT2nVMPpN5L5VR5v
         dWSbOAPekuOVNRElP/CcudF9VZAfBOblvZFTMx4GFzOCuBDsfBbqtNFexCsQzhK4ufUS
         dFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n2YIST+mAkt97t+ZQbbHfS1kx0rb4QcuwvFvAHo3Rpw=;
        fh=i1Hn3fl56fvG6r/yq4Gv3fT43rcJ8YTHRQZppJWZ4fs=;
        b=gh/nE89AUsq2GNr7wvGnL12kBAjdInkC7AfdE7+ZiMWCnqhp4yI+k6Y/q/7uGlzWlU
         ayHKBh2ewgihRxJ7OlhJ/E0KoBmzUviYJbd0wDE19OKPGixVXYPrD2p+cJdLZanJTKWj
         oa/syh4OplrIIF4BOhGSj/bN2HKgID22vwlgFBzDQcTgSDH7lNFNfhl/1RyrDIAxC3eg
         Zu1gML9sf0n7wiBzn9SRtzAW/BMEyJnPVeKAHAFgxdYno8IGEJlfOthkwGyoKkpcwsre
         o2nq8prUWbJT9KjqT13CNLjYWHcGzm410O9IhuI2UxD/lKc6C2HmfNVRd3eXfoRNKm95
         CZvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778049970; x=1778654770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2YIST+mAkt97t+ZQbbHfS1kx0rb4QcuwvFvAHo3Rpw=;
        b=RB76TRdBJIwHj6BJ+wzi2eWEsnbY8ipkLL4qCjHMfnFZE/HGKGqnE7R5ClNpJhCJV9
         H7yYHrIAaNh3PphW8pF403ZqOCxLcywy9DO4MOYlanXz7z7LpePlkLy+p0c8gq6JQF3F
         1/c2N2Dsh6zL+3bCAsKGU7pwjrZgxVbMXXPkVJKYYKwCVpn8PArPcAm56/fuPGVZxi9S
         Y3H/wuh1Wm9L1QSWi/PChOddRqL1Pf7kWquCeLaiPhdVKM2mo/+aZpqMw9lUkqgLs5Ef
         zqhip8nFZxGy2g4gHwx2r7MNBScO6aMCHClVxKG7mTbo5qAQ5y8ZL5jqjYsgwy4UJvQk
         VDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778049970; x=1778654770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2YIST+mAkt97t+ZQbbHfS1kx0rb4QcuwvFvAHo3Rpw=;
        b=nUNDU4h6LARYWqspQ1HE+jmpM/+iA0UFWMWYz2Xa0vfT2T1/UTmepRd8gowPIE/1Lc
         3J1/3iH0W9WhhgrnC7HhFKaRjH3KLj3MC59hVP9WA4ffp6mNHWJEgW9Pe8eyXeZGqH4q
         Gsm8TmD3/Fg9sWVvghuuigww1/XBuhOXu9S+Zeu/JWArbgOD+tEjFH1C5jJxBwbHJkQQ
         cFIYT4MdcuzHjjXJXlcpNVhs1/C2jL6FL3uLq0wYpbRjcxzGbcjs2ZFY2g3eGF1LEGXK
         fO9Ujci7nrE+omau48XGRrapOO8NylOGaxoJQ5u3H1Wz0Tslg98m0mjlwSV8O0vHO95C
         RlgQ==
X-Forwarded-Encrypted: i=1; AFNElJ978BUgS/cdw72XBm4KX9y5WXSvikaFpArTPIeJOrTVgy+2N6he/3VeLtjYqJZO1aRQ43cmB0liFmFFaOU73JG6@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWVGuNnQxK66JySJ5ucZ95WghaURQeVqxgkj5AmyfKcvPUPIz
	aZgKbc6tU9p5wwV1opipUGYMP2dMfTSoNBGQLXnu6l/ODlbvT+cjMoXNKWLy+xZ/E014M5kGtXj
	IBwcZxKSA5ZOndJqYb+CcaqnIT1B9GpsiEK7mc9uh
X-Gm-Gg: AeBDieu5tvYqDugVLiU4HsZxyvH6RGwaMEyHRrx4jxv/CcMXlL02vAgi4+FgWdE35XR
	R01LHC0PiO8IqhTenU9R2mduOXq30/cIn64asizno3zfeI0gdeSaBRy0ImCjzu3PKWB2QfSdabb
	QIFSSSejxt5QWCQW8F9DuGw9wl/LafjNGapl/5nWYcLrCkPN21RNGIMkSx8Szd30EC4hu+sONva
	ly6gOBuz6/QGapR+Ji2HSIp0WXfoisVpfRXiOd9RhSUaxrqK13ktWVZ1PTmCb1IafJNeKS/vChF
	bk6HFY/27yEr8c3VxPUK0SEaFMxoGA==
X-Received: by 2002:a17:903:b83:b0:2b0:5c88:51e1 with SMTP id
 d9443c01a7336-2ba77b8abc8mr2814535ad.14.1778049969237; Tue, 05 May 2026
 23:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506000018.3113599-1-irogers@google.com> <20260506041004.3196084-1-irogers@google.com>
In-Reply-To: <20260506041004.3196084-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 May 2026 23:45:56 -0700
X-Gm-Features: AVHnY4JiFVpig0vwhgo_INZWyZS1h4uJBzxK6Dg1eUAWpNPHpnY87XcXEu0wRFs
Message-ID: <CAP-5=fUPdg3vu1orm_k9ZTQVgvs+vQa2Q-+gc-TkLPnqEjH7DQ@mail.gmail.com>
Subject: Re: [PATCH v4] perf sched stats: Fix segmentation faults, memory
 leaks, and stale pointers in diff mode
To: irogers@google.com, acme@kernel.org, atrajeev@linux.ibm.com, 
	james.clark@linaro.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	venkat88@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 9:10=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> The patch addresses multiple segmentation fault vectors, out-of-bounds
> reads, and memory leaks in perf sched stats by adding bounds checks,
> NULL checks, proper error propagation, and robust memory cleanup.
>
> 1. In get_all_cpu_stats(), added assert(!list_empty(head)) to prevent
>    unsafe list_first_entry() calls on empty lists, added a missing NULL
>    check for summary_head->cpu_data allocation, and implemented a cleanup
>    ladder using a temporary list to prevent memory leaks on error paths.
> 2. In free_schedstat(), fixed memory leaks by ensuring internal domain_da=
ta
>    and cpu_data pointers are freed.
> 3. In show_schedstat_data(), fixed a stale pointer issue where ds2 retain=
ed
>    its value from a previous iteration when dptr2 became NULL, and added
>    proper propagation of errors from get_all_cpu_stats().
> 4. Propagated show_schedstat_data() errors up to perf_sched__schedstat_di=
ff()
>    and perf_sched__schedstat_live() to prevent output corruption on failu=
re.
> 5. In show_schedstat_data(), added NULL checks for cd_map1 and cd_map2
>    to gracefully handle invalid or empty data files.
> 6. Added parallel iteration termination checks using list_is_last() in
>    show_schedstat_data() for both domain and CPU lists to safely terminat=
e
>    at the end of each list when files contain a different number of CPUs
>    or domains.
> 7. Added CPU bounds checks (cs1->cpu >=3D nr1 and cs2->cpu >=3D nr2) in
>    show_schedstat_data() to prevent out-of-bounds reads from cd_map1 and
>    cd_map2 when comparing files from machines with different CPU counts.
> 8. Added NULL checks for cd_info1 and cd_info2 to prevent crashes when
>    a CPU has data samples but no corresponding domain info in the header.
> 9. Added domain bounds checks (ds1->domain >=3D cd_info1->nr_domains and
>    ds2->domain >=3D cd_info2->nr_domains) to prevent out-of-bounds array
>    accesses in the domains array.
> 10. Added NULL checks for dinfo1 and dinfo2 in show_schedstat_data()
>     to prevent crashes when a domain has no corresponding domain info.
> 11. Zero-initialized the perf_data array in perf_sched__schedstat_diff()
>     to prevent stack garbage from causing perf_data_file__fd() to attempt
>     to use a NULL fptr when use_stdio happened to be non-zero.
>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>

This version passes sashiko's scrutiny:
https://sashiko.dev/#/patchset/20260506041004.3196084-1-irogers%40google.co=
m

Thanks,
Ian

> ---
> v4:
> Address further sashiko feedback:
>  - Fix memory leaks of global cpu_head list when perf_session__process_ev=
ents() fails.
>  - Fix resource leak of second session by correcting cleanup order when f=
irst session's data is empty.
>
> v3:
> Address sashiko feedback:
>  - Fix memory leaks in free_schedstat() by freeing internal data.
>  - Fix missing NULL check for summary_head->cpu_data in get_all_cpu_stats=
().
>  - Fix memory leaks in get_all_cpu_stats() on error paths using a tempora=
ry cleanup list.
>  - Fix stale ds2 pointer comparison in show_schedstat_data() by resetting=
 it to NULL.
>  - Add error propagation from get_all_cpu_stats() and show_schedstat_data=
().
>  - Correct commit message to remove inaccurate claim about uninitialized =
variable 'ret'.
>  - Add forward declaration for free_schedstat() to fix compilation error.
>
> v2: Had tested-by Athira Rajeev and reviewed-by James Clark, removed
>     from v3 given the number of changes.
> https://lore.kernel.org/linux-perf-users/20260429173931.2700115-1-irogers=
@google.com/
> ---
>  tools/perf/builtin-sched.c | 175 +++++++++++++++++++++++++++++--------
>  1 file changed, 138 insertions(+), 37 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..fd679b106582 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3947,6 +3947,8 @@ static struct schedstat_domain *domain_second_pass;
>  static bool after_workload_flag;
>  static bool verbose_field;
>
> +static void free_schedstat(struct list_head *head);
> +
>  static void store_schedstat_cpu_diff(struct schedstat_cpu *after_workloa=
d)
>  {
>         struct perf_record_schedstat_cpu *before =3D cpu_second_pass->cpu=
_data;
> @@ -4170,37 +4172,50 @@ static void summarize_schedstat_domain(struct sch=
edstat_domain *summary_domain,
>   */
>  static int get_all_cpu_stats(struct list_head *head)
>  {
> -       struct schedstat_cpu *cptr =3D list_first_entry(head, struct sche=
dstat_cpu, cpu_list);
> -       struct schedstat_cpu *summary_head =3D NULL;
> -       struct perf_record_schedstat_domain *ds;
> -       struct perf_record_schedstat_cpu *cs;
> +       struct schedstat_cpu *cptr, *summary_head =3D NULL;
>         struct schedstat_domain *dptr, *tdptr;
>         bool is_last =3D false;
>         int cnt =3D 1;
>         int ret =3D 0;
> +       struct list_head tmp_cleanup_list;
>
> -       if (cptr) {
> -               summary_head =3D zalloc(sizeof(*summary_head));
> -               if (!summary_head)
> -                       return -ENOMEM;
> +       assert(!list_empty(head));
> +       cptr =3D list_first_entry(head, struct schedstat_cpu, cpu_list);
>
> -               summary_head->cpu_data =3D zalloc(sizeof(*cs));
> -               memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs=
));
> +       INIT_LIST_HEAD(&tmp_cleanup_list);
>
> -               INIT_LIST_HEAD(&summary_head->domain_head);
> +       summary_head =3D zalloc(sizeof(*summary_head));
> +       if (!summary_head)
> +               return -ENOMEM;
>
> -               list_for_each_entry(dptr, &cptr->domain_head, domain_list=
) {
> -                       tdptr =3D zalloc(sizeof(*tdptr));
> -                       if (!tdptr)
> -                               return -ENOMEM;
> +       INIT_LIST_HEAD(&summary_head->domain_head);
> +       INIT_LIST_HEAD(&summary_head->cpu_list);
> +       list_add(&summary_head->cpu_list, &tmp_cleanup_list);
>
> -                       tdptr->domain_data =3D zalloc(sizeof(*ds));
> -                       if (!tdptr->domain_data)
> -                               return -ENOMEM;
> +       summary_head->cpu_data =3D zalloc(sizeof(*summary_head->cpu_data)=
);
> +       if (!summary_head->cpu_data) {
> +               ret =3D -ENOMEM;
> +               goto out_cleanup;
> +       }
> +       memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*summary_he=
ad->cpu_data));
> +
> +       list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
> +               tdptr =3D zalloc(sizeof(*tdptr));
> +               if (!tdptr) {
> +                       ret =3D -ENOMEM;
> +                       goto out_cleanup;
> +               }
> +               INIT_LIST_HEAD(&tdptr->domain_list);
>
> -                       memcpy(tdptr->domain_data, dptr->domain_data, siz=
eof(*ds));
> -                       list_add_tail(&tdptr->domain_list, &summary_head-=
>domain_head);
> +               tdptr->domain_data =3D zalloc(sizeof(*tdptr->domain_data)=
);
> +               if (!tdptr->domain_data) {
> +                       free(tdptr);
> +                       ret =3D -ENOMEM;
> +                       goto out_cleanup;
>                 }
> +
> +               memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*tdp=
tr->domain_data));
> +               list_add_tail(&tdptr->domain_list, &summary_head->domain_=
head);
>         }
>
>         list_for_each_entry(cptr, head, cpu_list) {
> @@ -4212,32 +4227,52 @@ static int get_all_cpu_stats(struct list_head *he=
ad)
>
>                 cnt++;
>                 summarize_schedstat_cpu(summary_head, cptr, cnt, is_last)=
;
> +               if (list_empty(&summary_head->domain_head))
> +                       continue;
> +
>                 tdptr =3D list_first_entry(&summary_head->domain_head, st=
ruct schedstat_domain,
>                                          domain_list);
>
>                 list_for_each_entry(dptr, &cptr->domain_head, domain_list=
) {
>                         summarize_schedstat_domain(tdptr, dptr, cnt, is_l=
ast);
> +                       if (list_is_last(&tdptr->domain_list, &summary_he=
ad->domain_head)) {
> +                               tdptr =3D NULL;
> +                               break;
> +                       }
>                         tdptr =3D list_next_entry(tdptr, domain_list);
>                 }
>         }
>
> +       list_del_init(&summary_head->cpu_list);
>         list_add(&summary_head->cpu_list, head);
> +       return 0;
> +
> +out_cleanup:
> +       free_schedstat(&tmp_cleanup_list);
>         return ret;
>  }
>
> -static int show_schedstat_data(struct list_head *head1, struct cpu_domai=
n_map **cd_map1,
> -                              struct list_head *head2, struct cpu_domain=
_map **cd_map2,
> +static int show_schedstat_data(struct list_head *head1, struct cpu_domai=
n_map **cd_map1, int nr1,
> +                              struct list_head *head2, struct cpu_domain=
_map **cd_map2, int nr2,
>                                bool summary_only)
>  {
>         struct schedstat_cpu *cptr1 =3D list_first_entry(head1, struct sc=
hedstat_cpu, cpu_list);
>         struct perf_record_schedstat_domain *ds1 =3D NULL, *ds2 =3D NULL;
> -       struct perf_record_schedstat_cpu *cs1 =3D NULL, *cs2 =3D NULL;
>         struct schedstat_domain *dptr1 =3D NULL, *dptr2 =3D NULL;
>         struct schedstat_cpu *cptr2 =3D NULL;
>         __u64 jiffies1 =3D 0, jiffies2 =3D 0;
>         bool is_summary =3D true;
>         int ret =3D 0;
>
> +       if (!cd_map1) {
> +               pr_err("Error: CPU domain map 1 is missing.\n");
> +               return -1;
> +       }
> +       if (head2 && !cd_map2) {
> +               pr_err("Error: CPU domain map 2 is missing.\n");
> +               return -1;
> +       }
> +
>         printf("Description\n");
>         print_separator2(SEP_LEN, "", 0);
>         printf("%-30s-> %s\n", "DESC", "Description of the field");
> @@ -4260,21 +4295,47 @@ static int show_schedstat_data(struct list_head *=
head1, struct cpu_domain_map **
>         printf("\n");
>
>         ret =3D get_all_cpu_stats(head1);
> +       if (ret)
> +               return ret;
>         if (cptr2) {
>                 ret =3D get_all_cpu_stats(head2);
> +               if (ret)
> +                       return ret;
>                 cptr2 =3D list_first_entry(head2, struct schedstat_cpu, c=
pu_list);
>         }
>
>         list_for_each_entry(cptr1, head1, cpu_list) {
>                 struct cpu_domain_map *cd_info1 =3D NULL, *cd_info2 =3D N=
ULL;
> +               struct perf_record_schedstat_cpu *cs1 =3D cptr1->cpu_data=
;
> +               struct perf_record_schedstat_cpu *cs2 =3D NULL;
>
> -               cs1 =3D cptr1->cpu_data;
> +               dptr2 =3D NULL;
> +               if (cs1->cpu >=3D (u32)nr1) {
> +                       pr_err("Error: CPU %d exceeds domain map size %d\=
n", cs1->cpu, nr1);
> +                       return -1;
> +               }
>                 cd_info1 =3D cd_map1[cs1->cpu];
> +               if (!cd_info1) {
> +                       pr_err("Error: CPU %d domain info is missing in m=
ap 1.\n",
> +                              cs1->cpu);
> +                       return -1;
> +               }
>                 if (cptr2) {
>                         cs2 =3D cptr2->cpu_data;
> +                       if (cs2->cpu >=3D (u32)nr2) {
> +                               pr_err("Error: CPU %d exceeds domain map =
size %d\n", cs2->cpu, nr2);
> +                               return -1;
> +                       }
>                         cd_info2 =3D cd_map2[cs2->cpu];
> -                       dptr2 =3D list_first_entry(&cptr2->domain_head, s=
truct schedstat_domain,
> -                                                domain_list);
> +                       if (!cd_info2) {
> +                               pr_err("Error: CPU %d domain info is miss=
ing in map 2.\n",
> +                                      cs2->cpu);
> +                               return -1;
> +                       }
> +                       if (!list_empty(&cptr2->domain_head))
> +                               dptr2 =3D list_first_entry(&cptr2->domain=
_head,
> +                                                        struct schedstat=
_domain,
> +                                                        domain_list);
>                 }
>
>                 if (cs2 && cs1->cpu !=3D cs2->cpu) {
> @@ -4302,10 +4363,31 @@ static int show_schedstat_data(struct list_head *=
head1, struct cpu_domain_map **
>                         struct domain_info *dinfo1 =3D NULL, *dinfo2 =3D =
NULL;
>
>                         ds1 =3D dptr1->domain_data;
> +                       ds2 =3D NULL;
> +                       if (ds1->domain >=3D cd_info1->nr_domains) {
> +                               pr_err("Error: Domain %d exceeds max doma=
ins %d for CPU %d in map 1.\n",
> +                                      ds1->domain, cd_info1->nr_domains,=
 cs1->cpu);
> +                               return -1;
> +                       }
>                         dinfo1 =3D cd_info1->domains[ds1->domain];
> +                       if (!dinfo1) {
> +                               pr_err("Error: Domain %d info is missing =
for CPU %d in map 1.\n",
> +                                      ds1->domain, cs1->cpu);
> +                               return -1;
> +                       }
>                         if (dptr2) {
>                                 ds2 =3D dptr2->domain_data;
> +                               if (ds2->domain >=3D cd_info2->nr_domains=
) {
> +                                       pr_err("Error: Domain %d exceeds =
max domains %d for CPU %d in map 2.\n",
> +                                              ds2->domain, cd_info2->nr_=
domains, cs2->cpu);
> +                                       return -1;
> +                               }
>                                 dinfo2 =3D cd_info2->domains[ds2->domain]=
;
> +                               if (!dinfo2) {
> +                                       pr_err("Error: Domain %d info is =
missing for CPU %d in map 2.\n",
> +                                              ds2->domain, cs2->cpu);
> +                                       return -1;
> +                               }
>                         }
>
>                         if (dinfo2 && dinfo1->domain !=3D dinfo2->domain)=
 {
> @@ -4334,14 +4416,22 @@ static int show_schedstat_data(struct list_head *=
head1, struct cpu_domain_map **
>                         print_domain_stats(ds1, ds2, jiffies1, jiffies2);
>                         print_separator2(SEP_LEN, "", 0);
>
> -                       if (dptr2)
> -                               dptr2 =3D list_next_entry(dptr2, domain_l=
ist);
> +                       if (dptr2) {
> +                               if (list_is_last(&dptr2->domain_list, &cp=
tr2->domain_head))
> +                                       dptr2 =3D NULL;
> +                               else
> +                                       dptr2 =3D list_next_entry(dptr2, =
domain_list);
> +                       }
>                 }
>                 if (summary_only)
>                         break;
>
> -               if (cptr2)
> -                       cptr2 =3D list_next_entry(cptr2, cpu_list);
> +               if (cptr2) {
> +                       if (list_is_last(&cptr2->cpu_list, head2))
> +                               cptr2 =3D NULL;
> +                       else
> +                               cptr2 =3D list_next_entry(cptr2, cpu_list=
);
> +               }
>
>                 is_summary =3D false;
>         }
> @@ -4473,9 +4563,11 @@ static void free_schedstat(struct list_head *head)
>         list_for_each_entry_safe(cptr, n2, head, cpu_list) {
>                 list_for_each_entry_safe(dptr, n1, &cptr->domain_head, do=
main_list) {
>                         list_del_init(&dptr->domain_list);
> +                       free(dptr->domain_data);
>                         free(dptr);
>                 }
>                 list_del_init(&cptr->cpu_list);
> +               free(cptr->cpu_data);
>                 free(cptr);
>         }
>  }
> @@ -4523,7 +4615,9 @@ static int perf_sched__schedstat_report(struct perf=
_sched *sched)
>                 }
>
>                 cd_map =3D session->header.env.cpu_domain;
> -               err =3D show_schedstat_data(&cpu_head, cd_map, NULL, NULL=
, false);
> +               err =3D show_schedstat_data(&cpu_head, cd_map,
> +                                         session->header.env.nr_cpus_ava=
il,
> +                                         NULL, NULL, 0, false);
>         }
>
>  out:
> @@ -4538,7 +4632,7 @@ static int perf_sched__schedstat_diff(struct perf_s=
ched *sched,
>         struct cpu_domain_map **cd_map0 =3D NULL, **cd_map1 =3D NULL;
>         struct list_head cpu_head_ses0, cpu_head_ses1;
>         struct perf_session *session[2];
> -       struct perf_data data[2];
> +       struct perf_data data[2] =3D {0};
>         int ret =3D 0, err =3D 0;
>         static const char *defaults[] =3D {
>                 "perf.data.old",
> @@ -4573,8 +4667,10 @@ static int perf_sched__schedstat_diff(struct perf_=
sched *sched,
>         }
>
>         err =3D perf_session__process_events(session[0]);
> -       if (err)
> +       if (err) {
> +               free_schedstat(&cpu_head);
>                 goto out_delete_ses0;
> +       }
>
>         cd_map0 =3D session[0]->header.env.cpu_domain;
>         list_replace_init(&cpu_head, &cpu_head_ses0);
> @@ -4590,8 +4686,10 @@ static int perf_sched__schedstat_diff(struct perf_=
sched *sched,
>         }
>
>         err =3D perf_session__process_events(session[1]);
> -       if (err)
> +       if (err) {
> +               free_schedstat(&cpu_head);
>                 goto out_delete_ses1;
> +       }
>
>         cd_map1 =3D session[1]->header.env.cpu_domain;
>         list_replace_init(&cpu_head, &cpu_head_ses1);
> @@ -4607,10 +4705,13 @@ static int perf_sched__schedstat_diff(struct perf=
_sched *sched,
>         if (list_empty(&cpu_head_ses0)) {
>                 pr_err("Data is not available\n");
>                 ret =3D -1;
> -               goto out_delete_ses0;
> +               goto out_delete_ses1;
>         }
>
> -       show_schedstat_data(&cpu_head_ses0, cd_map0, &cpu_head_ses1, cd_m=
ap1, true);
> +       ret =3D show_schedstat_data(&cpu_head_ses0, cd_map0, session[0]->=
header.env.nr_cpus_avail,
> +                                 &cpu_head_ses1, cd_map1, session[1]->he=
ader.env.nr_cpus_avail, true);
> +       if (ret)
> +               goto out_delete_ses1;
>
>  out_delete_ses1:
>         free_schedstat(&cpu_head_ses1);
> @@ -4720,7 +4821,7 @@ static int perf_sched__schedstat_live(struct perf_s=
ched *sched,
>                 goto out;
>         }
>
> -       show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
> +       err =3D show_schedstat_data(&cpu_head, cd_map, nr, NULL, NULL, 0,=
 false);
>         free_cpu_domain_info(cd_map, sv, nr);
>  out:
>         free_schedstat(&cpu_head);
> --
> 2.54.0.545.g6539524ca2-goog
>
