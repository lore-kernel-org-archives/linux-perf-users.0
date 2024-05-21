Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F803D963;
	Tue, 21 May 2024 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716270179; cv=none; b=rEE53T2L4viQ+m/XuJ2P3LTcO+h8u4LlEhjGYtb3BM3QpDb7u9jk47NuL9hIeRp6QsXWkKFzq1hCY2WX6UWbEAKZVnHVDeJYtIQrm/RsNitPR2VUDdiMvBW5OyQrQGJjBtq9RnoJt+FCerhE7TOZ/HIENpntYbhhBClozGr9FRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716270179; c=relaxed/simple;
	bh=mLkKr0679cTjZUyHonnkd8nfg1EagC/Cj6HzW9J2yag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DluTI1MMeICFdCdGCg/K7HzjSCcHbKgT9us5KTti26xJydRyZA3CyEqZTuAEvyECFaxzp3X+XnvLxl9A5SPEShR5X5TSu8IPuMDpmVdmLdTCUr/bbF135NyMYMB0MdmtTE6uVPnxTno+Pq3v0ZBlymtHYt6bO1HPJ3i1GTf/pE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee5235f5c9so94832675ad.2;
        Mon, 20 May 2024 22:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716270177; x=1716874977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVAOkaAw+vGaYyHaagd8ofwfGPoFhRjOlI0G+tehJLA=;
        b=QO1sldbPvNPNriv1tsHriAv2nI9vb2YgPAto8rkRGoIx+HzLkHGBigHoveCIYijWgu
         mMubs8UiyCL0HRiAuoR2d5KMDBxnq/yJ9NOnsuAIAB14oxlR9WVnAS0P/R9BGBuNaisG
         g1ZTORnl90hJu172VX6MeqP5eMrENpMnhT4jxtt/0U7x7idXmJHw7aj21Qy0fM8QLrn0
         taiXftsJWoep5IhxImFRFtrYhIOkKVa/4fs0bZ31PwMZtavSmMN+jTL0CR0z8owmJWNH
         JSoNgiMtAc7gpM3PqhLoci2SoGShrD1mdh28hSfCrkBBlgRV4T8uvpUoQPu57qugZjRh
         1leg==
X-Forwarded-Encrypted: i=1; AJvYcCVKmesyqsTV95SStihc8m56g0F2MGbV8FqcfVEiZ6WZGEhChQXbW9+i7G9+31fOqEgDMMTgrrkTRVaGL2GlvhzxAsQRT3/lypE7gwwyEz/uSxtRBqQW9RUrYCLssb/gg5JC/s6zIMCPP91praOQ9A==
X-Gm-Message-State: AOJu0YzVQkzeO1fUYsZlJN0gyO/hrCKmk9S0fJCaJNg9YYLD6LkNjILW
	GW3VRQqBTcAtV76MPJqqZVM+381Ce9EcQgRBxu6CBM90AoBVU6fkD89oAMAMBumdQEAAbJby+yP
	2Gb1LLH74/3f4IkefTPnFmitc01g=
X-Google-Smtp-Source: AGHT+IGwfAoRk9fOi6nTtoKw9Gr80FbYKLsYQ88JI/KsXxzaO+JiXB8YYJr7c3FFPHUH5G0tppidF+fSYlEFMMABzwQ=
X-Received: by 2002:a17:90a:296:b0:2b3:463d:992b with SMTP id
 98e67ed59e1d1-2b6ccef6431mr27661939a91.42.1716270176705; Mon, 20 May 2024
 22:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com>
 <20240515054443.2824147-4-weilin.wang@intel.com> <CAM9d7cghtG-9rwy5Yg-oJDETO-J5OUzPt6=xMCwacKqfwo+sZA@mail.gmail.com>
 <CO6PR11MB563574C9C284744CD079C0D3EEEA2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB563574C9C284744CD079C0D3EEEA2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 20 May 2024 22:42:44 -0700
Message-ID: <CAM9d7ciOyp4AjTxR=-kq=B8b3-ium3wiG+_j6s3wfoH+DOLp8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 20, 2024 at 5:10=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Friday, May 17, 2024 2:43 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record =
when
> > perf stat needs to get retire latency value for a metric.
> >
> > On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > When retire_latency value is used in a metric formula, perf stat woul=
d fork a
> > > perf record process with "-e" and "-W" options. Perf record will coll=
ect
> > > required retire_latency values in parallel while perf stat is collect=
ing
> > > counting values.
> > >
> > > At the point of time that perf stat stops counting, it would send sig=
term
> > signal
> > > to perf record process and receiving sampling data back from perf rec=
ord
> > from a
> > > pipe. Perf stat will then process the received data to get retire lat=
ency data
> > > and calculate metric result.
> > >
> > > Another thread is required to synchronize between perf stat and perf =
record
> > > when we pass data through pipe.
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > ---
> > [SNIP]
> > > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tp=
ebs.c
> > > new file mode 100644
> > > index 000000000000..4b7a98794fae
> > > --- /dev/null
> > > +++ b/tools/perf/util/intel-tpebs.c
> > > @@ -0,0 +1,285 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * intel_pt.c: Intel Processor Trace support
> > > + * Copyright (c) 2013-2015, Intel Corporation.
> >
> > This needs some updates. :)
> >
> >
> > > + */
> > > +
> > > +
> > > +#include <sys/param.h>
> > > +#include <subcmd/run-command.h>
> > > +#include <thread.h>
> > > +#include "intel-tpebs.h"
> > > +#include <linux/list.h>
> > > +#include <linux/zalloc.h>
> > > +#include <linux/err.h>
> > > +#include "sample.h"
> > > +#include "debug.h"
> > > +#include "evlist.h"
> > > +#include "evsel.h"
> > > +#include "session.h"
> > > +#include "tool.h"
> > > +#include "metricgroup.h"
> > > +#include <sys/stat.h>
> > > +#include <sys/file.h>
> > > +
> > > +
> > > +
> > > +#define PERF_DATA              "-"
> > > +#define CONTROL                        "/tmp/control"
> > > +#define ACK                    "/tmp/ack"
> > > +pthread_t reader_thread;
> > > +struct child_process *cmd;
> > > +struct perf_stat_config *stat_config;
> >
> > static ?
> >
> > > +
> > > +static int get_perf_record_args(const char **record_argv)
> > > +{
> > > +       int i =3D 0;
> > > +       struct tpebs_retire_lat *e;
> > > +
> > > +       pr_debug("Prepare perf record for retire_latency\n");
> > > +
> > > +       record_argv[i++] =3D "perf";
> > > +       record_argv[i++] =3D "record";
> > > +       record_argv[i++] =3D "-W";
> > > +       record_argv[i++] =3D "--synth=3Dno";
> >
> > Unfortunately this still synthesizes MMAP records for the kernel
> > and modules.  As we don't care about them and just want to
> > minimize the overhead at the beginning, we can add
> > "--tail-synthesize" too.
>
> Hi Namhyung,
>
> I'm trying out the "--tail-synthesize" option but failed to get it work
> correctly. Could you please take a look at this command and let me
> know what's the problem?
>
> "perf record -e cycles:p --synth=3Dno --tail-synthesize -W -a -o - sleep =
1 | perf script -F retire_lat -i -".
>
> I got an error "0x40 [0x40]: failed to process type: 9" when run this com=
mand.
>
> If I run the command in two steps without pipe, they work fine.

Hmm... it may not work with pipes.  Let's go without the
tail-synthesize then.  Sorry for the noise.

Thanks,
Namhyung
