Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA73AB26E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450988; cv=pass; b=qGVeznSp5Gx89leMj2H+Qe5oss9VpGF1u/czicpRA5JSbheuI/zOIEvQ7fTvH+sUXsKQsqBFBMFYex5mRCMejX/ibCxSwePmbGTu/aThXmVOvlgqpN0fjFBNQlJtKRU7uzZRK11JKhC37ukvywlTobXTgROOOES2/aEmmyxrZOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450988; c=relaxed/simple;
	bh=EqNRQCc2ugxrOPUp7Ovatotqy8vCfTRyWxRiEnNz9TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLdrNmbUBE9kWvizZxwCsfc7wTUVrKgbavVfcjGnqLy5R7xzFedCXSQGhIzKOvYKh296cEZjFH5BPsiM0tU5G+WFC2Fo1oRA5CH7v66u7VOfZx+S7UQHXd5JJDslJtRJ65u6c5TzNXeqb79msRVj2EDl/uARTikopFoUG27Ak+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4ylQtAi; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4ylQtAi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aeab6ff148so81985ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 08:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774450986; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWwo6ghA+kkfwG/5yeZZcRbINJ0JP6eNH+t4zJv3n7qKxlQwcKfwN3jRZJ2XpnvZhb
         cjqsvpbzVLHajP4ohIOf9TgOfvy+beYjFyPwn5kcEMJ8a/NsJnIo/C/c7bwoTHN4H/zc
         grVcad4C4/uHwhT3Mc+zPLRJHkQpUoLkDiZ9udXB0Fbd5L6hdyxOBkVsdwNWfzk27TWr
         kBsXvzblr+bUVZzXU0T9GzwcXsGM83YVeUbutCQUzHB/mm4Sco4QjlGc+umRI7xNt5Us
         pMwLwE46HtNK3VkS8j05LED8jfkDLNIMOoF3Y33puZDRTW1S91Ms5d1X1eGIrvsg2Kz5
         4gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TEh1E2VhLIiH/OttMlumW/dAxmwoiue8mzYaXEmRKFs=;
        fh=hHTrZLkkf3Hdd4auBK945igE3C9vmdYVTCp9Q3TfMTQ=;
        b=hk9I6/D8n/EBn55euOw9ZC0SQVD9LkrBz56JXKxK4/inKD2vXSiVvaOj7WfVHXOW92
         A4Kzcbuz8XTRkwEY0Wm0hv4megrTtiNlYuYm+Bq/m2vLdUt0aQqpPn3xdvn0TyuX8ZGR
         6n/XlI9RbrrbF4O4axzZRv2xjiDVRndqUnil2K/f+8TIBjvRFcKxSIAlfRPAEL7jkXon
         0FMyDBwtGRQ+HRoYoYcyghNU/JZQGt3U11217m7ENmSlLq4u8XFAv5LggjVLW7ixijsz
         pUV7jsk9UG1eeQ24EfpWWusLFNudlM+dZkmtYVK4TsNZNajzHxc7qyliUKj5G+w0ahk2
         nIkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774450986; x=1775055786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEh1E2VhLIiH/OttMlumW/dAxmwoiue8mzYaXEmRKFs=;
        b=l4ylQtAi2/kii6vg3UzEeko2vLJk67J3Y35cSk+zHziI2hFoE8AcGKetMWobD1WOXA
         A5fjm5znTxrqs5j8tvVObZ4IVRtUsj8rlnGWIBMZmq/yh5KnHV3iSpO6wkSm7RFsqn6w
         lx1l8dT6qDkPhfeUwYuUxuO+Ga05Zxwgv/mOydipbGa2eQvAbJcxrszb/+JLAF0aoTSt
         3wRBODkv91Kks+mRBWalLHsaxksfEw8LUaZaXZwI5SEzWQ++Kzfpvgq91mOFxfR+7zub
         68RM0dBygHhVQDhxUDM4TFP0ko5CBTAoqCzEtRrzRsLsubW8DXT22BN1CT1td07bAXll
         vWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450986; x=1775055786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TEh1E2VhLIiH/OttMlumW/dAxmwoiue8mzYaXEmRKFs=;
        b=c5q1HsXXrmeY/VD0rACD7YkL9onQHQet+ti8TA3cWs9YW4vUPUg1890N6jXvuY07Mb
         zPIpID8ytsSsgB7AV2Liquu9ALmySAXkBTvujZe7o8x7pjCns1/37MNfjymO+Aet+/bo
         JRxUJh7OsXmAXYVonQimDnbgB+R3pxfe2bSKlx4CZ7YteLCUIKZIeB4/xE/hll5FXfCv
         d1qNrXzWZXfbG/rR9OhOspqyN/1ttt2j2vLSaT8qiwfg7rwGwvyVE5RBvmGHkGUzFTsj
         JH3sSnEy+m8r9HiVcVsbrtpIVwwUA9RPzDGHUSjAFWvrb/S71GD5Hkx2R61tG9bW62L5
         9wHg==
X-Forwarded-Encrypted: i=1; AJvYcCVjlEC4mlOkqH3KWjK/4LN60LpXIThHhgIlzdWyl1F0YBDI8Hxcqhe31Y3FKHb2lb+0EwCWRZSiiiEUq+y+z+w8@vger.kernel.org
X-Gm-Message-State: AOJu0YzcxlT6mrvTADb1w7Zf24pR6dKLmtlnougNYPel44gD4PPnUCt+
	7YnzBqrgaJwch1kb/p/f5pErSs/yRPS4XX7YbG89E65SSncjWnSca3rFHUISDPXG90UypnUvh1s
	sAVyRlumStq9ph5FmVd/BuMTqCuuoVJu7l7JEvJ0U
X-Gm-Gg: ATEYQzzirj4QvolctrEA8FexTi4+ZDeDT5HDyotBxGNUWXcqyqRoH61p1A+Jkm7ALZ6
	tExPl41LmclG5NwdNIrYHmFxn4WeodrFx2+HQws/n3gO/HqaR1sp//I3ApFVsFdBFRN3Ols3+PT
	G5YO6u8GnP3P604L18IbVAhh7x2q5mDbSsA9xaJ5CZuatp9eojCljqRUVGOt7gmoCQyVxW9OB8u
	cFzEdMUwg7H6X+TnmdO+JrMwoez+ypjCj1RH0qUNEgMQTYZqL29XRQMk5nMGxgXzoNQtr0iNZUy
	C6WvoGY6VxeZOqMFVru0X59vMoUBQMp3dZhGGA==
X-Received: by 2002:a17:902:ef4d:b0:2b0:b0c9:96e2 with SMTP id
 d9443c01a7336-2b0b2a7f9eamr246935ad.21.1774450985756; Wed, 25 Mar 2026
 08:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325120627.1841175-1-tmricht@linux.ibm.com> <20260325120627.1841175-2-tmricht@linux.ibm.com>
In-Reply-To: <20260325120627.1841175-2-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Mar 2026 08:02:53 -0700
X-Gm-Features: AaiRm50lZIlNjnCB5rKHqTebxoxD2qMsZ2sUdhqBdRfwcHc3PS-44RLQmndEO10
Message-ID: <CAP-5=fXBoKMp1COEHVtSiu_kRvELqBpFDZ7_m05y=MFqDhk0yA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf config: Rename symbol_conf::disable_add2line_warn
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
> Rename member symbol_conf::disable_add2line_warn to
> symbol_conf::addr2line_disable_warn to make it consistent with other
> addr2line_xxx constants.
> No functional change.
>
> Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implement=
ations")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-diff.c     |  4 ++--
>  tools/perf/util/addr2line.c   | 12 ++++++------
>  tools/perf/util/block-info.c  |  2 +-
>  tools/perf/util/libbfd.c      |  2 +-
>  tools/perf/util/symbol_conf.h |  2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 59bf1f72d12e..8a93e56f4a7e 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1353,7 +1353,7 @@ static int cycles_printf(struct hist_entry *he, str=
uct hist_entry *pair,
>         /*
>          * Avoid printing the warning "addr2line_init failed for ..."
>          */
> -       symbol_conf.disable_add2line_warn =3D true;
> +       symbol_conf.addr2line_disable_warn =3D true;
>
>         bi =3D block_he->block_info;
>
> @@ -1987,7 +1987,7 @@ int cmd_diff(int argc, const char **argv)
>
>         if (compute =3D=3D COMPUTE_STREAM) {
>                 symbol_conf.show_branchflag_count =3D true;
> -               symbol_conf.disable_add2line_warn =3D true;
> +               symbol_conf.addr2line_disable_warn =3D true;
>                 callchain_param.mode =3D CHAIN_FLAT;
>                 callchain_param.key =3D CCKEY_SRCLINE;
>                 callchain_param.branch_callstack =3D 1;
> diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
> index 31c0391fffa3..e9f084db0802 100644
> --- a/tools/perf/util/addr2line.c
> +++ b/tools/perf/util/addr2line.c
> @@ -123,7 +123,7 @@ static enum cmd_a2l_style cmd_addr2line_configure(str=
uct child_process *a2l, con
>                         lines =3D 3;
>                         pr_debug3("Detected binutils addr2line style\n");
>                 } else {
> -                       if (!symbol_conf.disable_add2line_warn) {
> +                       if (!symbol_conf.addr2line_disable_warn) {
>                                 char *output =3D NULL;
>                                 size_t output_len;
>
> @@ -310,7 +310,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>         }
>
>         if (a2l =3D=3D NULL) {
> -               if (!symbol_conf.disable_add2line_warn)
> +               if (!symbol_conf.addr2line_disable_warn)
>                         pr_warning("%s %s: addr2line_subprocess_init fail=
ed\n", __func__, dso_name);
>                 goto out;
>         }
> @@ -330,7 +330,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>         len =3D snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
>         written =3D len > 0 ? write(a2l->in, buf, len) : -1;
>         if (written !=3D len) {
> -               if (!symbol_conf.disable_add2line_warn)
> +               if (!symbol_conf.addr2line_disable_warn)
>                         pr_warning("%s %s: could not send request\n", __f=
unc__, dso_name);
>                 goto out;
>         }
> @@ -339,7 +339,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>         switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr,=
 /*first=3D*/true,
>                                       &record_function, &record_filename,=
 &record_line_nr)) {
>         case -1:
> -               if (!symbol_conf.disable_add2line_warn)
> +               if (!symbol_conf.addr2line_disable_warn)
>                         pr_warning("%s %s: could not read first record\n"=
, __func__, dso_name);
>                 goto out;
>         case 0:
> @@ -355,7 +355,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>                                               /*addr=3D*/1, /*first=3D*/t=
rue,
>                                               NULL, NULL, NULL)) {
>                 case -1:
> -                       if (!symbol_conf.disable_add2line_warn)
> +                       if (!symbol_conf.addr2line_disable_warn)
>                                 pr_warning("%s %s: could not read sentine=
l record\n",
>                                            __func__, dso_name);
>                         break;
> @@ -363,7 +363,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
>                         /* The sentinel as expected. */
>                         break;
>                 default:
> -                       if (!symbol_conf.disable_add2line_warn)
> +                       if (!symbol_conf.addr2line_disable_warn)
>                                 pr_warning("%s %s: unexpected record inst=
ead of sentinel",
>                                            __func__, dso_name);
>                         break;
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index 649392bee7ed..8d3a9a661f26 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -303,7 +303,7 @@ static int block_range_entry(struct perf_hpp_fmt *fmt=
, struct perf_hpp *hpp,
>         char buf[128];
>         char *start_line, *end_line;
>
> -       symbol_conf.disable_add2line_warn =3D true;
> +       symbol_conf.addr2line_disable_warn =3D true;
>
>         start_line =3D map__srcline(he->ms.map, bi->sym->start + bi->star=
t,
>                                   he->ms.sym);
> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index 63ea3fb53e77..c1c12308cc12 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -233,7 +233,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
>         }
>
>         if (a2l =3D=3D NULL) {
> -               if (!symbol_conf.disable_add2line_warn)
> +               if (!symbol_conf.addr2line_disable_warn)
>                         pr_warning("addr2line_init failed for %s\n", dso_=
name);
>                 return 0;
>         }
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.=
h
> index 71bb17372a6c..ff229942fbb1 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -51,7 +51,7 @@ struct symbol_conf {
>                         report_block,
>                         report_individual_block,
>                         inline_name,
> -                       disable_add2line_warn,
> +                       addr2line_disable_warn,
>                         no_buildid_mmap2,
>                         guest_code,
>                         lazy_load_kernel_maps,
> --
> 2.53.0
>
