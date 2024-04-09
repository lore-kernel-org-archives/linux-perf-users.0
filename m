Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9D136E1D
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Apr 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677605; cv=none; b=uFuVK6KWo579SW5czHhnmpz8h5e6z3UzTOtxrsDpmDerYKmLBhuKUPvHoh6xR/W2zH82cxPTT8YE7m3KYlEloUXAHnzf2zGBmEoDior85AKUbJurwoomrmW2VrC/n90wWxAydlVrvIiIqabUEqSRqLU6THRqG9bpJuD16KvcoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677605; c=relaxed/simple;
	bh=ImqAvE5DqPsCmdddnql+7QuydKOmyUgd30+SWAWpb6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfUltLRSfnPf97CzroaQRTdwLSDQ8J37GfWOAqdgLnBgzlqv/BghEFzb4ogPAG6dFYgrqWolCdd1smPdF3zodvj57J286I8OHHt4QuR11qHaEvGvjaets7nNVUFSQjd2kzgWqaivh6ixKxnp7MDkF7/qaoU0FkzOaoR0r8dndrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knhlVV0a; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knhlVV0a"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36a267bb43aso94425ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Apr 2024 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712677603; x=1713282403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0puCatRq0DqyA1/imYz3YosP+4LfQJpZakwVvO0S4E=;
        b=knhlVV0ato9jox8yYj+LB9o1aM3GDjt+Hune3nawzFPLts2+747Ut/nIsL/6RfLrNn
         RLkU1mAZ5AbLg2H8/8T4W5hjAM7PWz3Yq4ARmtZ0ykaB+M6nCAhkMsNcmspKJ8p+FNaW
         PhstDOHW30yF+nM/uyZ8j4K1hH0JKYqH9uVvEnmRhY9AB2Jexj/FYYvPBx852pB8xmJQ
         4wYyTnNNcmm9fl/LaUQejmcPUnWtmZzK1T3ASowxk8gyio9Kh5LOgwAD8w1yY9UoCp8u
         36mpyu95CrCqzuEWMctdWhFXldsiruRQPlXKLqahKOKWG/eB25InyIx1AGyP56QuRpyt
         EkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712677603; x=1713282403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0puCatRq0DqyA1/imYz3YosP+4LfQJpZakwVvO0S4E=;
        b=RsLL4C9GR4jK8XxOAw0WnR2YkWl3hluRgEuab+/XxM1Sd97JDnroh3XHMTa6iN3coQ
         6CUJWgnK72R0oTet8kUJV7nJdbGwtpm1178LlE8Fe+fU4WOs07NYEeKf7Ax5AwkAIUoJ
         FOSQsIyaK78I1N0FA2akZ/H3BzBKU5ojweSK6dJn5sPMqfpDSheVbnr5ubdliFkyHLJC
         J7cTfQLw0POc7oo2ouKmG1MyL5XIg3MEI7dqL3rvhfztfAg0W0zG0VciHuFxMH4YhKcx
         mLUM1MSG6Rd+Epsz661sUEg8f9UTbc0zmSRZXVvL+3KWA56vUmeG6FyVLLYa9GkEjBd3
         gwZA==
X-Forwarded-Encrypted: i=1; AJvYcCWPlq8D9SGkDnUfOyWZBUxsc/TGvNG18e2IED3N9wr8vB+LMTXFRjqybUjexvEre7MycW3SwKZkbLd8eCtnW+hedDgu9ID3fZJTwf2ovrnN+g==
X-Gm-Message-State: AOJu0YxqbphugIoCiCE5LsFTxbQVEGS7MgdhWZrHN7btpGz5EVVUr/PT
	IhLb8pXOINLOK+IL671V7XhCwnErSSslJ9mVcHm0J9fflUAas6FlP1rEd6DK7onB7SDfjjYAwus
	D2kPDYd/rHXgy9uO0QUCs44QaG0JCHE8HZdBdZSksddPknZS6izpV8YM=
X-Google-Smtp-Source: AGHT+IE4MNU0jEp18FzZk97qTk/n3dSHqzgLpj63SE+bgTmWvUMttM0EQOKPZ9WtIcMPRFd7N6cTAlH4UqUwtCKzkYg=
X-Received: by 2002:a05:6e02:1d02:b0:369:eca2:1a43 with SMTP id
 i2-20020a056e021d0200b00369eca21a43mr307178ila.8.1712677602814; Tue, 09 Apr
 2024 08:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhVfc5jYLarnGzKa@x1> <ZhVf9rO-b3xTqZEK@x1>
In-Reply-To: <ZhVf9rO-b3xTqZEK@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Apr 2024 08:46:31 -0700
Message-ID: <CAP-5=fVbkj74K3w0cOfpbKe2=9wK1AJYkGQmbHLD4SKzc=dVBw@mail.gmail.com>
Subject: Re: BISECTED: perf test 'Miscellaneous Intel PT' failing on Intel
 hybrid machines
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 8:34=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Apr 09, 2024 at 12:32:06PM -0300, Arnaldo Carvalho de Melo wrote:
> > root@x1:~# perf test "Miscellaneous Intel PT testing"
> > 112: Miscellaneous Intel PT testing                                  : =
FAILED!
> > root@x1:~#
> >
> > then I revert:
> >
> > commit 642e1ac96aaa12aeb41402e68eac7faf5917a67a (HEAD -> perf-tools-nex=
t)
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Tue Apr 9 12:28:49 2024 -0300
> >
> >     Revert "perf pmus: Check if we can encode the PMU number in perf_ev=
ent_attr.type"
> >
> >     This reverts commit 82fe2e45cdb00de4fa648050ae33bdadf9b3294a.
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > It works now:
> >
> > root@x1:~# perf -v
> > perf version 6.8.g642e1ac96aaa
> > root@x1:~# perf test "Miscellaneous Intel PT testing"
> > 117: Miscellaneous Intel PT testing                                  : =
Ok
> > root@x1:~#
> >
> > Investigating, if you come up with ideas, lemme know.
>
> Some more context:
>
> When this patch was implemented/tested I had access only to an ARM64
> hybrid machine, now my notebook is a Rocket Lake lenovo (13th gen), that
> is hybrid and the test is failing with:
>
> root@x1:~# perf test -v "Miscellaneous Intel PT testing"
> 112: Miscellaneous Intel PT testing                                  :
> --- start ---
> test child forked, pid 304355
> --- Test system-wide sideband ---
> Checking for CPU-wide recording on CPU 0
> OK
> Checking for CPU-wide recording on CPU 1
> OK
> Linux
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.934 MB /tmp/perf-test-intel-pt-sh.xAC=
V6V7Hn4/test-perf.data ]
> OK
> --- Test per-thread recording ---
> Workload PIDs are 304377 and 304378
> perf PID is 304389
> Waiting for "perf record has started" message
> OK
> pid 0 cpu -1 fd 5 : sys_perf_event_open: pid 0  cpu -1  group_fd -1  flag=
s 0x8 =3D 5
> pid 0 cpu -1 fd 6 : sys_perf_event_open: pid 0  cpu -1  group_fd -1  flag=
s 0x8 =3D 6
> pid 304377 cpu -1 fd 7 : sys_perf_event_open: pid 304377  cpu -1  group_f=
d -1  flags 0x8 =3D 7
> pid 304380 cpu -1 fd 8 : sys_perf_event_open: pid 304380  cpu -1  group_f=
d -1  flags 0x8 =3D 8
> pid 304378 cpu -1 fd 9 : sys_perf_event_open: pid 304378  cpu -1  group_f=
d -1  flags 0x8 =3D 9
> pid 304381 cpu -1 fd 10 : sys_perf_event_open: pid 304381  cpu -1  group_=
fd -1  flags 0x8 =3D 10
> pid 304377 cpu -1 fd 11 : sys_perf_event_open: pid 304377  cpu -1  group_=
fd -1  flags 0x8 =3D 11
> pid 304380 cpu -1 fd 12 : sys_perf_event_open: pid 304380  cpu -1  group_=
fd -1  flags 0x8 =3D 12
> pid 304378 cpu -1 fd 13 : sys_perf_event_open: pid 304378  cpu -1  group_=
fd -1  flags 0x8 =3D 13
> pid 304381 cpu -1 fd 14 : sys_perf_event_open: pid 304381  cpu -1  group_=
fd -1  flags 0x8 =3D 14
> fd 7 : idx 0: mmapping fd 7
> fd 11 fd_to 7 : idx 0: set output fd 11 -> 7
> fd 8 : idx 1: mmapping fd 8
> fd 12 fd_to 8 : idx 1: set output fd 12 -> 8
> fd 9 : idx 2: mmapping fd 9
> fd 13 fd_to 9 : idx 2: set output fd 13 -> 9
> fd 10 : idx 3: mmapping fd 10
> fd 14 fd_to 10 : idx 3: set output fd 14 -> 10
> Checking 10 fds
> No mmap for fd 5

Thanks Arnaldo, so the reverted change is:
```
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -4,6 +4,7 @@
#include <subcmd/pager.h>
#include <sys/types.h>
#include <dirent.h>
+#include <pthread.h>
#include <string.h>
#include <unistd.h>
#include "debug.h"
@@ -492,9 +493,35 @@ int perf_pmus__num_core_pmus(void)
       return count;
}

+static bool __perf_pmus__supports_extended_type(void)
+{
+       struct perf_pmu *pmu =3D NULL;
+
+       if (perf_pmus__num_core_pmus() <=3D 1)
+               return false;
+
+       while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
+               if (!is_event_supported(PERF_TYPE_HARDWARE,
PERF_COUNT_HW_CPU_CYCLES | ((__u64)pmu->
type << PERF_PMU_TYPE_SHIFT)))
+                       return false;
+       }
+
+       return true;
+}
+
+static bool perf_pmus__do_support_extended_type;
+
+static void perf_pmus__init_supports_extended_type(void)
+{
+       perf_pmus__do_support_extended_type =3D
__perf_pmus__supports_extended_type();
+}
+
bool perf_pmus__supports_extended_type(void)
{
-       return perf_pmus__num_core_pmus() > 1;
+       static pthread_once_t extended_type_once =3D PTHREAD_ONCE_INIT;
+
+       pthread_once(&extended_type_once,
perf_pmus__init_supports_extended_type);
+
+       return perf_pmus__do_support_extended_type;
}

struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
```
On your Intel this should have previously returned true as
"perf_pmus__num_core_pmus() > 1", and with the new code presumably
is_event_supported is returning false. Could you dump the PMU's name
at that point? Is cpu_core or cpu_atom looking like it doesn't support
the event? Is the test failing when run as root (ie is
is_event_supported failing to have expected fallback paths)?

Thanks,
Ian
