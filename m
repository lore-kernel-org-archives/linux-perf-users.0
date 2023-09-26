Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5B11731
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 22:51:02 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A3130F4;
	Tue, 26 Sep 2023 15:51:01 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-79f909071c3so338416739f.0;
        Tue, 26 Sep 2023 15:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695768661; x=1696373461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMSNODbnTzc8NG4Obsca/eh0AcJKSmcVBO5ZoBkDCVs=;
        b=vxkNqdG4zjfFAwoujHV/uzzu3fx2PHx4fFYcl9Ui1KYmw4mQZn1QcW8dKRrgOUiTm/
         a4Dvn3nYnuCzDpB8CgPsd5WW5HsOGl844QEC6vxGvWU6llYoYo7jHBtgsVkGZze7oi/0
         ly1nxR34n6T+/8M1rKQKUKnLWnfVTgtac5VU8qIdDDZzv+uR+dq49l2PS0H7QAEYXHEA
         v4DzlJdW4IVu0TRCfw2YuQQoNm7yt6/jEpObEQ4wLN+Bmx6Hcp9SJS2zMDXYqTDA5kR7
         g3LK4603p/gjDIGa91SoNf56r6Yg3K/EWnJ+vZsJWRC7qp2dEy9TvdaoxE0oboSuKlUC
         irJA==
X-Gm-Message-State: AOJu0Yzog/4epxMhQbDjVTPEvlty+uIAWCnMNARz/GVZzJxGOTBK4Adf
	bsX9ibf9h78o4qBdX4DCtV16D4VQ1YBXjhXEL54=
X-Google-Smtp-Source: AGHT+IH5z0cIf1tgL48BTkyxH1ivIX/Ej7zh4R5TKal+7CzVPIXDxjjZXsS1sscz0C5v64AQejxeYMG+tOZyWwwzuII=
X-Received: by 2002:a6b:d002:0:b0:792:9ace:f7ba with SMTP id
 x2-20020a6bd002000000b007929acef7bamr172374ioa.11.1695768660792; Tue, 26 Sep
 2023 15:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920122349.418673-1-wyes.karny@amd.com> <CAP-5=fUe-972h3+Cwegb6u8ZOxo2k_jHQ3i5gNPoUq_TR_AWDQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUe-972h3+Cwegb6u8ZOxo2k_jHQ3i5gNPoUq_TR_AWDQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 26 Sep 2023 15:50:49 -0700
Message-ID: <CAM9d7cjH_YR9W_Ab-AuJR983GYn3s+ScwexCWid3Q6a+GzWDVg@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Fix perf stat output with correct scale and unit
To: Ian Rogers <irogers@google.com>
Cc: Wyes Karny <wyes.karny@amd.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sandipan.das@amd.com, ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 9:02=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Sep 20, 2023 at 5:24=E2=80=AFAM Wyes Karny <wyes.karny@amd.com> w=
rote:
> >
> > The perf_pmu__parse_* functions for the sysfs files of pmu event=E2=80=
=99s
> > scale, unit, per-pkg and snapshot were updated in commit 7b723dbb96e8
> > ("perf pmu: Be lazy about loading event info files from sysfs").
> > However, the paths for these sysfs files were incorrect. This resulted
> > in perf stat reporting values with wrong scaling and missing units. Thi=
s
> > is fixed by correcting the paths for these sysfs files.
> >
> > Before this fix:
> >
> >  $sudo perf stat -e power/energy-pkg/ -- sleep 2
> >
> >  Performance counter stats for 'system wide':
> >
> >    351,217,188,864      power/energy-pkg/
> >
> >           2.004127961 seconds time elapsed
> >
> > After this fix:
> >
> >  $sudo perf stat -e power/energy-pkg/ -- sleep 2
> >
> >  Performance counter stats for 'system wide':
> >
> >              80.58 Joules power/energy-pkg/
> >
> >              2.004009749 seconds time elapsed
> >
> > Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files =
from sysfs")
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
