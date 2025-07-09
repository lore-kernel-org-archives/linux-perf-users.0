Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155CD241CA2
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094975; cv=none; b=KvlDOMTKHLWw4AgKswvva6t9gF9JmcEN6j7ih47HCME61h1xd1TKDHwQJ1JUsGv0GC4/ZwXJj0aKsFOFDDn/aRlY0l3rI90WyjNr+4x6Jq9U+eBIp14Ch3cTb3ah8je8V3wAvUkpcT9EdwkuMVbIqS+UAMG34C75EFgPW6f5ATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094975; c=relaxed/simple;
	bh=t+SGEA6oFuVdECPxoV6loo1YkTFudIBsqOlaod4L+j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNUnMTgOoegfmHwYzt+0D+Q15QaasboiqL2c7oJq1MoD/JunFRW4TnuiN+tdm46pSQ1N6vH2kHe3VB2eLiqkapex5/yvWZVQKdBuZMwzyyTPRJ0hnC8iHF8hD9iFgD/z3UvSNBaUeRAAmzw+rcQWAS5NoHC4jXSfaTb+DiP+IsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8UMI3sz; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8UMI3sz"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3df371e1d29so29815ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752094972; x=1752699772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGQrTOT/xhr3Yb3s9WztwAhfACqpB6++/b5+NXVjWt0=;
        b=j8UMI3sznoCYD6eLkK0wOPm6AVfNphn2n54mf2hO98Qp+qHlExdTiKO2+vSXw8InHA
         E4FFTAoDSkjg9Y1SBbHEsRq0wCj9WbV4EdrbCMgxILHmWN8MKeOeqreuWRO6Jnu6a/2M
         yd1nkTIuTBEWAxOdMXaZJqjrZSn1awqmxSqDRnkaqh9IGLwh3PzIJU+zb2f917SZre/B
         rA4q2nLrKdMj/VGnR/5XlvBscOLBIGvQEEf6vCTpJdIcWMG33c28TST1OgOJkMiY5L1O
         lZxz6k0DzVJ2N4UsMDNz+fhDrcaQz/xsPcMy6wO0w0LWN0BMI1qUdzoX5pd/uB87c9yI
         QeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094972; x=1752699772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGQrTOT/xhr3Yb3s9WztwAhfACqpB6++/b5+NXVjWt0=;
        b=UBNtjZKcGJJ2HMTNn3lhNPNqH6DgRm2mWLdaVIidog/xN83PFBcJWyM2rTSaHxTw7d
         kPpAoUxFiHV4VhURA2Id7VYWSWjdgCrYM4Q2oJz97strzSkWoWjFEcBCFAioJYrsltPU
         0QQtv3VwOyrswJQ3h5GnJaUI/IYMqvI5ohhut6+aTNGd/0jSCQfqj0d7YTX9wiGM30B7
         iJxssYSlU8D4VzTePyIRw6AWmlpqlsP6LlvgjPEy9Kf2VQDZvAA+uCj2tdtc0ZyfSWkD
         WG3FI0Npj9u4uLpIuQRdXO82UX2BrQ9GG7JV8FISsV5gHTaCd3VkjCGVUST414TdF/qD
         ZkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUssjUQc+D003BBYSTOMxDAJbT9xwlFxn7RwCW4TRRmVyfwuVlyyY+gS3C5yhRBCq6dgssJsA9Si8JnT0QCN7yt@vger.kernel.org
X-Gm-Message-State: AOJu0YwV5bXHErj9bFmiFz02EjQYjwDH0U8fUYzXM07KgNbhr2jAQK4S
	YMGMm97vVLtBF5jTHqj+D9xttt9NxpMPlYThpbN+JLSq/g4fmvySbLt46J74M8uDKgC1efWevx5
	wxW/iTTIVcQIW8DL78BjFUBMZRydvqAtEeXrUrTdv
X-Gm-Gg: ASbGncvVPnEGB6QnlHkn25z7EsMJaKdm8sD1oke0+cFjbbS9GmuZK2srAOdpYLX4UXw
	E11aZ/pqYrpjMvXRqZcmX0rOhDQeIbVXvuu9YauK6/TBRzEc5y/DxIya7DJSQLmv2qSmKTtEtZW
	Wuubu29l0WT767wT/o0DraBbyE0TqF/S9b/TWwnNTGqvaxsEvaM6yos/25gjN0KHjV81T3TUEIl
	igUJSzP3waD
X-Google-Smtp-Source: AGHT+IHecPZrvx+ydDC+IAxNKi8SNP9C+RAVx2p99q3fMrLmcL0/qWQwMlMr7ZZITggGGmPm3jNhrxGE/BOqjl4BPKA=
X-Received: by 2002:a05:6e02:2703:b0:3de:215d:c9bd with SMTP id
 e9e14a558f8ab-3e2452b197emr963225ab.20.1752094971674; Wed, 09 Jul 2025
 14:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com> <20250605233934.1881839-5-blakejones@google.com>
In-Reply-To: <20250605233934.1881839-5-blakejones@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Jul 2025 14:02:40 -0700
X-Gm-Features: Ac12FXwkqrAs48pbGnnVnOa3S51JWJ2GVvtDL0V_3XeIUQKWbqkiHpT5CXzHi-U
Message-ID: <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
To: Blake Jones <blakejones@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 4:39=E2=80=AFPM Blake Jones <blakejones@google.com> =
wrote:
>
> This is an end-to-end test for the PERF_RECORD_BPF_METADATA support.
> It adds a new "bpf_metadata_perf_version" variable to perf's BPF programs=
,
> so that when they are loaded, there will be at least one BPF program with
> some metadata to parse. The test invokes "perf record" in a way that load=
s
> one of those BPF programs, and then sifts through the output to find its
> BPF metadata.
>
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  tools/perf/Makefile.perf                    |  3 +-
>  tools/perf/tests/shell/test_bpf_metadata.sh | 76 +++++++++++++++++++++
>  tools/perf/util/bpf_skel/perf_version.h     | 17 +++++
>  3 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100755 tools/perf/tests/shell/test_bpf_metadata.sh
>  create mode 100644 tools/perf/util/bpf_skel/perf_version.h
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d4c7031b01a7..4f292edeca5a 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1250,8 +1250,9 @@ else
>         $(Q)cp "$(VMLINUX_H)" $@
>  endif
>
> -$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vml=
inux.h | $(SKEL_TMP_OUT)
> +$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(OUTPUT)PERF-VERSION-FIL=
E util/bpf_skel/perf_version.h $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP=
_OUT)
>         $(QUIET_CLANG)$(CLANG) -g -O2 --target=3Dbpf $(CLANG_OPTIONS) $(B=
PF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> +         -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf=
_version.h \
>           -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
>
>  $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
> diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tes=
ts/shell/test_bpf_metadata.sh
> new file mode 100755
> index 000000000000..11df592fb661
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> @@ -0,0 +1,76 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0

The 2nd line in a shell test script is taken to be the name of the test, so
```
$ perf test list 108
108: SPDX-License-Identifier: GPL-2.0
```

> +#
> +# BPF metadata collection test.

This should be on line 2 instead.

Thanks,
Ian

> +
> +set -e
> +
> +err=3D0
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +cleanup() {
> +       rm -f "${perfdata}"
> +       rm -f "${perfdata}".old
> +       trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +       cleanup
> +       exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +test_bpf_metadata() {
> +       echo "Checking BPF metadata collection"
> +
> +       if ! perf check -q feature libbpf-strings ; then
> +               echo "Basic BPF metadata test [skipping - not supported]"
> +               err=3D0
> +               return
> +       fi
> +
> +       # This is a basic invocation of perf record
> +       # that invokes the perf_sample_filter BPF program.
> +       if ! perf record -e task-clock --filter 'ip > 0' \
> +                        -o "${perfdata}" sleep 1 2> /dev/null
> +       then
> +               echo "Basic BPF metadata test [Failed record]"
> +               err=3D1
> +               return
> +       fi
> +
> +       # The BPF programs that ship with "perf" all have the following
> +       # variable defined at compile time:
> +       #
> +       #   const char bpf_metadata_perf_version[] SEC(".rodata") =3D <..=
.>;
> +       #
> +       # This invocation looks for a PERF_RECORD_BPF_METADATA event,
> +       # and checks that its content contains the string given by
> +       # "perf version".
> +       VERS=3D$(perf version | awk '{print $NF}')
> +       if ! perf script --show-bpf-events -i "${perfdata}" | awk '
> +               /PERF_RECORD_BPF_METADATA.*perf_sample_filter/ {
> +                       header =3D 1;
> +               }
> +               /^ *entry/ {
> +                       if (header) { header =3D 0; entry =3D 1; }
> +               }
> +               $0 !~ /^ *entry/ {
> +                       entry =3D 0;
> +               }
> +               /perf_version/ {
> +                       if (entry) print $NF;
> +               }
> +       ' | egrep "$VERS" > /dev/null
> +       then
> +               echo "Basic BPF metadata test [Failed invalid output]"
> +               err=3D1
> +               return
> +       fi
> +       echo "Basic BPF metadata test [Success]"
> +}
> +
> +test_bpf_metadata
> +
> +cleanup
> +exit $err
> diff --git a/tools/perf/util/bpf_skel/perf_version.h b/tools/perf/util/bp=
f_skel/perf_version.h
> new file mode 100644
> index 000000000000..1ed5b2e59bf5
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/perf_version.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef __PERF_VERSION_H__
> +#define __PERF_VERSION_H__
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +/*
> + * This is used by tests/shell/record_bpf_metadata.sh
> + * to verify that BPF metadata generation works.
> + *
> + * PERF_VERSION is defined by a build rule at compile time.
> + */
> +const char bpf_metadata_perf_version[] SEC(".rodata") =3D PERF_VERSION;
> +
> +#endif /* __PERF_VERSION_H__ */
> --
> 2.50.0.rc0.604.gd4ff7b7c86-goog
>
