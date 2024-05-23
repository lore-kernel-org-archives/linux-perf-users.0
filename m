Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678A8249A;
	Thu, 23 May 2024 04:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438224; cv=none; b=qru4aL7FhkkE3JSFqJF8CwjFBGgXPlwE5XaEQgy9CxDKdLQUQK5lSrJKl5KG7tiBPXXBF1gZpyZgRRnJ74pQbrMrJmixDU9qgx5js8PEu5mcDdFGwJcro5K1PLxuUllLR0n3eTqrTSnb9uSsU0S3RNGPueAbXAn8EjOkf2DCcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438224; c=relaxed/simple;
	bh=G+Qbunxj/8AnnJWdmaF3UXDeltlfHoJSxjwp7hvWXp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmoDJFJaU7j+q0vK1cthcSRK86giLBBWpJRsvnioXx+XiSsibdkTxyRI5xcDv86Xk+okgx8+vRZ6Q66LRm/CkfEu+l/tqvIyL0he6kxkRuwIga70NpsTgRrB41/b40t9mi7sOXegE6fiaky2FFcmT97oAhzd48rYkS09KN8hwUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so3133829b3a.1;
        Wed, 22 May 2024 21:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716438222; x=1717043022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nbTyY0YiKMIFTBvGT1E/XGxZ2k7LnuzSV4xdZ3Jw7c=;
        b=tUZWfJfHZQfGJCOxbtr955et9E/F64wOEOow4joWTjC678tzT0xF9LR1tuhT6kQD2e
         qG+IzwNHEYw/nNb0EUXvLjwLMKXFS04RscEe+MUiR0GWPGt2nlHemP/oND73Xg1IWgGb
         41qCMUWkQFFi+0QCeZf1QMhfP1X6otyjGPGPB+ZV3P9DgncqPCNFiMd1ZoVDy57P6wbD
         boLQxfco0nfDTLEVfrS62q+Kap0KLEgZVX4OwxLzxQiJ0WKPm0+8VxNPA3Vs/SWFxPp2
         ekcRKpDYoNbDvnC0WRlo+OgkzGoPJVF7S9igvwyhZrHvxK5VGLHqhKdDLY32zr/k1FZA
         674g==
X-Forwarded-Encrypted: i=1; AJvYcCUVuRZ+U7dxNlYsjf90FJgI8ms99cQZAOJJieiPcaiXiuC/O7T9OjgFaTVlEqVImb6S9bOvxCSUGW5iJZu6mUp0poOkYjGRWdhNrMT17Y57vPKmWXL8uLSXW72pzvnuc+r4Bp2kKfP5AQ0X9Sq5UA==
X-Gm-Message-State: AOJu0YyCMZ1dbQ/iOirGr6dlQN3hSJXTHVprda7cN0ZFGv5nS1+lUx0q
	ugXcdTPWJp83Dw3opyGBuRyrD44mTT40xMYBnmiqjqcBW2WY21pw1B75ljb67aOO0MATTsSdT9h
	CVUnSQglbs8rmJsiJt+tpVQdzqRQ=
X-Google-Smtp-Source: AGHT+IGTRfQdIN7S23gX65Bq9HRt9VhqaDXWq/aYg25eV88Aqz9EEvuPB5pw8CBE6A8dowQ34jiDTbaTfIj4WkYrj7s=
X-Received: by 2002:a05:6a20:2586:b0:1b0:1bae:6a8c with SMTP id
 adf61e73a8af0-1b1f87923admr4529877637.21.1716438221948; Wed, 22 May 2024
 21:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515195252.75909-1-yskelg@gmail.com>
In-Reply-To: <20240515195252.75909-1-yskelg@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 22 May 2024 21:23:30 -0700
Message-ID: <CAM9d7ciFpGhQat3esWLBUDNc1pzAqVw+8d+oX-WJeN+KJfW8Ew@mail.gmail.com>
Subject: Re: [PATCH] buitin-kvm: Update cmd_kvm() to check perf_host value
To: yskelg@gmail.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 15, 2024 at 12:54=E2=80=AFPM <yskelg@gmail.com> wrote:
>
> From: Yunseong Kim <yskelg@gmail.com>
>
> According to perf-kvm.txt, the default operation is --guest, meaning
> perf_host should be set to false and perf_guest to true. Currently,
> the incorrect usage of --no-host and --no-guest still results in
> the default --guest operation.

Hmm, right.. This is not good.

>
> This patch updates the usage messages to include the --no-guest option
> for those who only want host data, as well as the --no-host and
> --no-guest case.

I'm not sure if it's worth mentioning the host-only use case which is
not expected for this command.  I think it's enough to warn the
no-host and no-guest use cases.

>
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>  tools/perf/builtin-kvm.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 71165036e4ca..654a07658cdd 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2129,7 +2129,7 @@ int cmd_kvm(int argc, const char **argv)
>                 OPT_BOOLEAN(0, "guest", &perf_guest,
>                             "Collect guest os data"),
>                 OPT_BOOLEAN(0, "host", &perf_host,
> -                           "Collect host os data"),
> +                          "Collect host os data. Host only with --host -=
-no-guest"),
>                 OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "dir=
ectory",
>                            "guest mount directory under which every guest=
 os"
>                            " instance has a subdir"),
> @@ -2150,16 +2150,23 @@ int cmd_kvm(int argc, const char **argv)
>                                                 "buildid-list", "stat", N=
ULL };
>         const char *kvm_usage[] =3D { NULL, NULL };
>
> -       perf_host  =3D 0;
> -       perf_guest =3D 1;
> +       /*
> +        * tools/perf/Documentation/perf-kvm.txt
> +        *
> +        *    Default('')         ->  perf.data.guest
> +        *    --host              ->  perf.data.kvm
> +        *    --guest             ->  perf.data.guest
> +        *    --host --guest      ->  perf.data.kvm
> +        *    --host --no-guest   ->  perf.data.host
> +        */
> +       perf_host =3D false;
> +       perf_guest =3D true;

Probably not needed.

>
>         argc =3D parse_options_subcommand(argc, argv, kvm_options, kvm_su=
bcommands, kvm_usage,
>                                         PARSE_OPT_STOP_AT_NON_OPTION);
> -       if (!argc)
> +       if (!argc || (!perf_host && !perf_guest))
>                 usage_with_options(kvm_usage, kvm_options);
>
> -       if (!perf_host)
> -               perf_guest =3D 1;

Instead of showing the whole usage, I think it's better to
print a specific message for this case.

Oh, I've realized that we have 'h' modifier for hypervisors
(on ARM64?)  Then maybe no-host + no-guest is a valid
combination.  Probably we need to add --hypervisor option
then.

Thanks,
Namhyung


>
>         if (!file_name) {
>                 file_name =3D get_filename_for_perf_kvm();
> --
> 2.34.1
>
