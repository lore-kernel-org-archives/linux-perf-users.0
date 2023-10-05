Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA07FA
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E044AF
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Oct 2023 21:49:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-278f0f565e2so368320a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Oct 2023 21:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696481342; x=1697086142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/0elhVnHuH4JwxYChH6LofsDVjpWks/dg3K2e8HBW8=;
        b=MZjC+kloe8ffInHTZZ66AAp/0v172/8vnT6cWspKSfetUSj6wpAeAOwWkIyPviWQtc
         vtngGBsGIFGN/bVzCdifJ9LYXnYRb+GDqSVByKhTxgbSR1H6ICS4nKlf/jyNomw3ptQR
         IfFBsxfjkloVIObct6DpEmCHh3mvH8kSRJvk/4dnjefSHD7NCl920hljc/YrbEY2iUTP
         0YMf6oEh78dV6XYWqwgWKXO/ZTZXJxb+wq7NrBC5GOcgHDUGiAiQ4J3TnQ8+orv40quT
         rA9bLOryIYnru77IXVvnLdur1+W3Nfk107y+hV9GPK+thTP/nWq+P7bZC4PHCKJSZAnw
         71+g==
X-Gm-Message-State: AOJu0YwpHMIPmnAkspfYFUQgPtn6WSzN4AniXX7Yl1pImrh0QzVJsNKU
	0NWZkBn4SqPjONPKY3QxtYAFmxg8OMes2x+dWG4=
X-Google-Smtp-Source: AGHT+IEz8lmgBXcMfjcNd1UsWF5kADnaxxKl4dV1186CcohRUDKjwVoPAZfcDz8EDFk4qdFZbj0D1k3T3LdG/SxGgqM=
X-Received: by 2002:a17:90b:1997:b0:26d:54de:b0d6 with SMTP id
 mv23-20020a17090b199700b0026d54deb0d6mr3979170pjb.20.1696481342132; Wed, 04
 Oct 2023 21:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003055440.111907-1-adityag@linux.ibm.com>
In-Reply-To: <20231003055440.111907-1-adityag@linux.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 4 Oct 2023 21:48:49 -0700
Message-ID: <CAM9d7cghSKFMOCSNb0NYEAp6ts_gvxqg4_R4ppnXbzwrApuXSw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Introduce perf check subcommand
To: acme@kernel.org, irogers@google.com
Cc: Aditya Gupta <adityag@linux.ibm.com>, jolsa@kernel.org, 
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, 
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Arnaldo, Ian and others,

Are you ok with this?

Thanks,
Namhyung


On Mon, Oct 2, 2023 at 10:54=E2=80=AFPM Aditya Gupta <adityag@linux.ibm.com=
> wrote:
>
> The Problem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
>
>     perf version --build-options | grep " on .* HAVE_FEATURE"
>
> Proposed solution
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> As suggested by contributors in:
> https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
>
> Introduce a subcommand "perf check --feature", with which
> scripts can test for presence of a feature, such as:
>
>     perf check --feature HAVE_LIBTRACEEVENT
>
>     or
>
>     perf check --feature libtraceevent
>
> The usage of "perf version --build-options | grep" has been replaced in t=
wo
> tests, with "perf check --feature" command
>
> Also, to not duplicate the same feature list at multiple places, a new gl=
obal
> 'supported_features' array has been introduced in builtin.h, so both comm=
ands
> 'perf check --feature' and 'perf version --build-options' use the same ar=
ray
>
> 'supported_features' feature is an array of 'struct feature_support', whi=
ch
> also has the name of the feature, macro used to test it's presence, and a
> is_builtin member, which will be 0 if feature not built-in, and 1 if buil=
t-in
>
> Architectures Tested
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * x86_64
> * ppc64le
>
> Git tree
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> Git tree with this patch series applied for testing:
> https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v5
>
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> V5
> + invert return value of 'has_support', but return value of perf check --=
feature
> according to shell convention
>
> V4
> + invert return value of perf check --feature
>
> V3
> + simplified has_support code in builtin-check.c (patch #1)
> + modified patch #3 and patch #4 according to change in return value in p=
atch #1
>
> V2
> + improved the patch series with suggestions from Namhyung
> + fix incorrect return value, added -q option, and moved array definition=
 to
>   perf-check.c
>
> V1
> + changed subcommand name to 'perf check --feature'
> + added documentation for perf check
> + support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceeven=
t) as
>   input to 'perf check --feature'
> + change subject and descriptions of all patch mentioning perf check inst=
ead of
>   perf build
>
> V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230=
825061125.24312-1-adityag@linux.ibm.com/
>
> Aditya Gupta (3):
>   perf check: introduce check subcommand
>   perf version: update --build-options to use 'supported_features' array
>   perf tests task_analyzer: use perf check for libtraceevent support
>
> Athira Rajeev (1):
>   tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
>     --feature
>
>  tools/perf/Build                              |   1 +
>  tools/perf/Documentation/perf-check.txt       |  59 +++++++++
>  tools/perf/builtin-check.c                    | 122 ++++++++++++++++++
>  tools/perf/builtin-version.c                  |  39 ++----
>  tools/perf/builtin.h                          |  18 +++
>  tools/perf/perf.c                             |   1 +
>  .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
>  .../shell/record+probe_libc_inet_pton.sh      |   5 +-
>  .../shell/record+script_probe_vfs_getname.sh  |   5 +-
>  tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
>  10 files changed, 221 insertions(+), 37 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-check.txt
>  create mode 100644 tools/perf/builtin-check.c
>
> --
> 2.41.0
>
