Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA310F6
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 00:29:49 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD95D1987
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 17:29:47 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-79fb78e297bso240555739f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 17:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695774587; x=1696379387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWH0z533esqpAC5VNc1MXkkMGiZG7WIhuL7G4xndyOw=;
        b=IPitUc1kAy0h0iR0TC0SyUZg0hcj4SyDuzamSyZ8Xhgzr42PwlM5+vJU08I9LAH7Ll
         YYPw5Q0wOvapWIIus6RX/C0Hdk9NyeikLbk+pNrzVgz72HqKhS6uxG68qzgm8OBEkGIx
         n22Fk7u90ogmEvtWRnGisW/ZCquO8ShxE1RTRHptwJjsT7QuO5grSmBXYOFd95re2pnn
         LUAf4KylUSA3yml6eLgXH0RNjrri8F0KlpjzRaw/iVcWpoUm7PG6h5RstbthbkVGds8p
         k+3uXdb/JQo2Mm/3Ki+E8w90orVhKWPUQipaIOatTzOI/mxrYKVF/am8tEuW9Smltwne
         EfYg==
X-Gm-Message-State: AOJu0YyyZ/vc72SuI7u7RRBqMl0peydXQ4kHR6RKDb4jgx6VLIVRCfmG
	CG7CMLY02Zpbo31NQdrnsRfmWeSctMduhJhNuSE=
X-Google-Smtp-Source: AGHT+IEKBOIRfeX+82zX1Q3yNZC0+5Lc8p8FgD5oG3u0a/EQJbmAorZ7NPITOJCAGJRS7EAgoaefjB3Vsvh3pssW5as=
X-Received: by 2002:a6b:da15:0:b0:794:e11c:d8c3 with SMTP id
 x21-20020a6bda15000000b00794e11cd8c3mr369986iob.16.1695774586629; Tue, 26 Sep
 2023 17:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920192847.975897-1-adityag@linux.ibm.com> <20230920192847.975897-2-adityag@linux.ibm.com>
In-Reply-To: <20230920192847.975897-2-adityag@linux.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 26 Sep 2023 17:29:35 -0700
Message-ID: <CAM9d7cihonpzY7pW1o9V1q5Ja2SAD+frcjVESBw=073LpuokLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf check: introduce check subcommand
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, 
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Wed, Sep 20, 2023 at 12:29=E2=80=AFPM Aditya Gupta <adityag@linux.ibm.co=
m> wrote:
>
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
>
>     perf version --build-options | grep " on .* HAVE_FEATURE"
>
> Instead of this, introduce a subcommand "perf check --feature", with whic=
h
> scripts can test for presence of a feature, such as:
>
>     perf check --feature HAVE_FEATURE
>
> 'perf check --feature' command is expected to have exit status of 1 if fe=
ature is
> built-in, and 0 if not, -2 if feature is not known.
>
> An array 'supported_features' has also been introduced that can be
> used by other commands like 'perf version --build-options', so that
> new features can be added in one place, with the array
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---

[SNIP]
> +/**
> + * check whether "feature" is built-in with perf
> + * returns:
> + *   -1: Feature not known
> + *    0: Built-in
> + *    1: NOT Built in

It seems not intuitive.  I'd return 1 if it's builtin.
Maybe we can return 0 for unknown ones too.

> + */
> +static int has_support(const char *feature)
> +{
> +       int res =3D -1;
> +
> +       for (int i =3D 0; supported_features[i].name; ++i) {
> +               if ((strcmp(feature, supported_features[i].name) =3D=3D 0=
) ||
> +                       (strcmp(feature, supported_features[i].macro) =3D=
=3D 0)) {

Please align it to the previous strcmp().


> +                       res =3D supported_features[i].is_builtin;
> +                       if (!quiet)
> +                               STATUS(supported_features[i]);
> +                       break;

Why not return right here?


> +               }
> +       }
> +
> +       if (res =3D=3D -1) {
> +               if (!quiet)
> +                       color_fprintf(stdout, PERF_COLOR_RED, "Feature no=
t known: %s", feature);
> +               return -1;
> +       }

Then you don't even need the 'res' variable.

> +
> +       return !res;
> +}
> +
> +int cmd_check(int argc, const char **argv)
> +{
> +       argc =3D parse_options(argc, argv, check_options, check_usage,
> +                            PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +       if (!quiet)
> +               printf("perf check %s\n", perf_version_string);
> +
> +       if (check.feature)
> +               return has_support(check.feature);
> +
> +       return 0;
> +}
> diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> index f2ab5bae2150..9f895981bc9e 100644
> --- a/tools/perf/builtin.h
> +++ b/tools/perf/builtin.h
> @@ -2,6 +2,23 @@
>  #ifndef BUILTIN_H
>  #define BUILTIN_H
>
> +#include <stddef.h>
> +#include <linux/compiler.h>
> +#include <tools/config.h>
> +
> +struct feature_support {
> +       const char *name;
> +       const char *macro;
> +       int is_builtin;
> +};
> +
> +#define FEATURE_SUPPORT(name_, macro_) { \
> +       .name =3D name_,                       \
> +       .macro =3D #macro_,                    \
> +       .is_builtin =3D IS_BUILTIN(macro_) }
> +
> +extern struct feature_support supported_features[];
> +
>  void list_common_cmds_help(void);
>  const char *help_unknown_cmd(const char *cmd);
>
> @@ -9,6 +26,7 @@ int cmd_annotate(int argc, const char **argv);
>  int cmd_bench(int argc, const char **argv);
>  int cmd_buildid_cache(int argc, const char **argv);
>  int cmd_buildid_list(int argc, const char **argv);
> +int cmd_check(int argc, const char **argv);
>  int cmd_config(int argc, const char **argv);
>  int cmd_c2c(int argc, const char **argv);
>  int cmd_diff(int argc, const char **argv);
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index d3fc8090413c..83dc0ac42fdb 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -50,6 +50,7 @@ static struct cmd_struct commands[] =3D {
>         { "archive",    NULL,   0 },
>         { "buildid-cache", cmd_buildid_cache, 0 },
>         { "buildid-list", cmd_buildid_list, 0 },
> +       { "check", cmd_check, 0 },

Please align this.

Thanks,
Namhyung


>         { "config",     cmd_config,     0 },
>         { "c2c",        cmd_c2c,        0 },
>         { "diff",       cmd_diff,       0 },
> --
> 2.41.0
>
