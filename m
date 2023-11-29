Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TMt+sY1y"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22751A6
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 09:21:25 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bc4eeeadaso3273e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 09:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701278484; x=1701883284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0WD7fcwZghshT6pQtqRNF+fU/TfXoDz5lmg+dpWNqY=;
        b=TMt+sY1y0gZU98aS5T7VlQsd23rxE+ppDeECKYGoJN88+nSkZ/Iva8lT/EEY6PGJc2
         flCcS4hEzb893NaRl8kMKbFKBzlKRORw3EL3VwoT0vGVYRLyAzci87KPSVhfcz6jgt8n
         4glOp4uU6GC3MWEvF311MlN28e8xkJLJU/h12BHcJQ/RwjtuhdNV6MKwgMj9jk+gigja
         UOnhvTZ6QdneXlt8Dbwxvi12mLX/BRR9Y9igWyUYlb8yN3g8417t3SLwaQK1Bdly4DYC
         6qCL4IcmO1dE5DVunck6Oeq4p98mUUHdJQPAuE0r4ApuMo13YWwLGmzUK/1uYaOtDLny
         T35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278484; x=1701883284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0WD7fcwZghshT6pQtqRNF+fU/TfXoDz5lmg+dpWNqY=;
        b=SWfRQbLPE6/QosvcLsOWVcW/URwJPWru30RGMIrc191eJ8W8N9knk/L7Rgw4+sYtC3
         qXMjdLUGLvaT90j3H3eZN+AbW3G2qpKFH/li6w05tB1wtaKFZVFacMkDgH/lqBapbXKX
         L3kowW2iwU/ZbTSh9LFCMhrieod5AshKAcUKHXNE2+/ElxlwN1NWrCkSpAA2+a6jADEh
         UWqX5OSNRPRBDlJji3Br5PpTmV3WKx8HmqYhw/rGHU0GsSNf137HgQbzDG8JeK3i+IML
         oi4c1RXA4INH2zmuWOkbshJKYqdYGyyNcroq+6cZokw+B/iPsUI9lTUuBmDcWRcb0Cu7
         USBA==
X-Gm-Message-State: AOJu0Yx7/GcG1yCu0BJFOip24aIa4feU1NbsmtUoTWo3Cs93T0ELakbs
	tqtCTNlk8W7Cf8U2UAPqiTD7l+eVLRYFwyXrBdcypA==
X-Google-Smtp-Source: AGHT+IGVV1TGIDxwnNXLYTa0rh72NULVQOapS8AJzg1O7PwjPII7qvDdW/qTKXFLUpdv3kJ9T/l+ukXpSPWQFHaF/DQ=
X-Received: by 2002:a19:ad43:0:b0:504:7b50:ec9a with SMTP id
 s3-20020a19ad43000000b005047b50ec9amr536638lfd.1.1701278483956; Wed, 29 Nov
 2023 09:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129081004.1918096-1-irogers@google.com> <20231129081004.1918096-2-irogers@google.com>
 <a54d0a93-aacd-4c69-a34c-8628b0e18ee7@intel.com> <03b314c6-ed6d-ae17-5bc5-0170139f7feb@arm.com>
In-Reply-To: <03b314c6-ed6d-ae17-5bc5-0170139f7feb@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Nov 2023 09:21:12 -0800
Message-ID: <CAP-5=fX7UQGCXp3rqk8bKdevPUH6bnP2hxZ_jktj17YDzkuUDA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test: Add basic list test
To: James Clark <james.clark@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 1:27=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 29/11/2023 09:00, Adrian Hunter wrote:
> > On 29/11/23 10:10, Ian Rogers wrote:
> >> Test that json output produces valid json.
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >> ---
> >>  tools/perf/tests/shell/list.sh | 29 +++++++++++++++++++++++++++++
> >>  1 file changed, 29 insertions(+)
> >>  create mode 100755 tools/perf/tests/shell/list.sh
> >>
> >> diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/l=
ist.sh
> >> new file mode 100755
> >> index 000000000000..286879a9837a
> >> --- /dev/null
> >> +++ b/tools/perf/tests/shell/list.sh
> >> @@ -0,0 +1,29 @@
> >> +#!/bin/sh
> >> +# perf list tests
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +
> >> +set -e
> >> +err=3D0
> >> +
> >> +if [ "x$PYTHON" =3D=3D "x" ]
> >> +then
> >> +    if which python3 > /dev/null
> >
> > 'which' isn't always present.  Maybe
> >
> > python3 --version >/dev/null 2>&1 && PYTHON=3Dpython3
> >
>
> Now that we have shellcheck integrated into the build, we could enable
> the POSIX mode test which would warn against this usage of which and
> suggest the alternative.
>
> At the moment though there are several other usages of which already in
> the tests. And probably enabling POSIX mode would come with hundreds of
> other warnings to fix.
>
> I'm not saying we shouldn't change this instance though, just adding the
> info for the discussion.

Sounds good to me. Fwiw, the instance where I lifted this code was:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/stat+json_output.sh?h=3Dperf-tools-next#n12

With this change:
```
diff --git a/tools/perf/tests/Makefile.tests b/tools/perf/tests/Makefile.te=
sts
index fdaca5f7a946..06de6d3f4842 100644
--- a/tools/perf/tests/Makefile.tests
+++ b/tools/perf/tests/Makefile.tests
@@ -1,7 +1,7 @@
# SPDX-License-Identifier: GPL-2.0
# Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 2023

-PROGS :=3D $(shell find tests/shell -perm -o=3Dx -type f -name '*.sh')
+PROGS :=3D $(shell find tests/shell -executable -type f -name '*.sh')
FILE_NAME :=3D $(notdir $(PROGS))
FILE_NAME :=3D $(FILE_NAME:%=3D.%)
LOGS :=3D $(join $(dir $(PROGS)),$(FILE_NAME))
```

shellcheck now runs for me. I'll try adding the posix check into the
patch series, as well as fixing other instances I can see.

Thanks,
Ian



> >> +    then
> >> +            PYTHON=3Dpython3
> >> +    elif which python > /dev/null
> >> +    then
> >> +            PYTHON=3Dpython
> >> +    else
> >> +            echo Skipping test, python not detected please set enviro=
nment variable PYTHON.
> >> +            exit 2
> >> +    fi
> >> +fi
> >> +
> >> +test_list_json() {
> >> +  echo "Json output test"
> >> +  perf list -j | $PYTHON -m json.tool
> >> +  echo "Json output test [Success]"
> >> +}
> >> +
> >> +test_list_json
> >> +exit $err
> >
> >
