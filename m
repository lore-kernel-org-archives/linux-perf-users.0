Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EDF173;
	Tue,  5 Aug 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754434684; cv=none; b=oOzH4JxPP9MgAQiyMf2swZYWJhT3Lgi5bTV/8EhmYffpOQ8RWwGoxLhB5sKDGaJ35ht2XptWDdj+YDTlCqsg1x3pGbOwSVhHPUSrwIPd/pY9XP0/zEVk4pLcumqXXNTFFqYMDHgJ94jzFC8bb07v475nZQ3bk29hhbdF6ak2fl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754434684; c=relaxed/simple;
	bh=WdsnEcCFtlgxL/5iLPAEyDQ17lKNhewf1+1opIG6qmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKVmmI+sY9AMYq7wTXjLELbwaPAvLbiAxhI5tZFe7BpOKn7tk/Ri/L5eMJ8T8eCBAgnCzW9ey/zo0vfdQw+ThBKMvVhlj45Zzma2H5Wys8ijMgW5Qs+aRzGJyqYuFl4xPJ+A6uWM8WIdPTwAthnVGA2+lDPu9OLGJUtFJXAsnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niSjNKge; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niSjNKge"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71a4742d81aso46100457b3.2;
        Tue, 05 Aug 2025 15:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754434682; x=1755039482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YW7FPgz1nGvqM+oNOjV2TNVUJqQjfQ7ik+2JJJtM64o=;
        b=niSjNKgese0n0KHab9xiBaPbk8ZCyEx2U20Cx9TWXRekpaHyA26KilA8F6oZh0sOC9
         v6Cm/OHhNJ2hQROVjQKGRHqYytjKHCOw/z6VY5CZOv0axN4zyJbXmBeK6al9U5AKCJ8J
         JJgDxlAYYrECjJdnkDSpdRV9+2v2LyF5MEyVO7xZX8YHAL9UUYPMn1AHZaTeBZIITp84
         ZoF6oVTas4nR8gUEyYuIIacCUCTU9Sz45plUrPNxHxtq0MBFNY86/wWn5JIITXWP5+Yi
         0zMEZRJLwNfK5FhQCW+/wCd9b+JfJXm2j36F5NCGSma6KnIjSz0JNIlwXlUYQ0gbHYad
         kcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754434682; x=1755039482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YW7FPgz1nGvqM+oNOjV2TNVUJqQjfQ7ik+2JJJtM64o=;
        b=w7Y7ZWkKxSy1kr3l6zdgYM85llFbWrqW1BftX+iidF8f4ykC6hNHSTIAQCs6qdaZTU
         ZIcIOtigVIo72LQNe++2oI2Jh/Jo4Lp5yfFpXnZMoVf7sRqOSUnG0zVfNkED7owrqlJI
         yvR1346u9qwAxKj2dnV7B6mO83j4JBvw5EfbWsZzRsLBe6zQTRDwRwA4oogcqUTo2/Aa
         0V3DYxCrRXzOWU9acgrOJX2QFiBaCzhEtGTIywzzF+TdJKdyY1L6Izlpnadkx4/KMlOy
         C6oOlh79juivxDsldH/A86NXgyVCB/yq02KQtblbzRRx+xarUvJDUmZT9DhUhWBE1JGE
         tNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW85yl/eDTaxcvolB8O/eTLHqBxxhXIfIj3swQBiIC9icEsi8UE2+AzcPmBIxaVRGlts3SosEyGRaJYHEs=@vger.kernel.org, AJvYcCWCPHflwpk6Cs3bnUlBJY3GYxvbh0IGiZ9zkrpz8KvpzKsaDHOySlGOInHVJzMlzZWkkrY8YkiVI1q+nXf46+gbFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMx8LDlWotnSQjiS+nbTyi54uC/Uc7JpiqHATooc+CR93TPjv
	0zCvmTqEEDw7CXzN8x8Ux4aTmu588e7v7PDVPW89ubx9auU0oKeXsnhw8wG7i4YtKa10P280qXa
	IxOe5socdR1CIhvUFnUIQGnwW6oEZe0M=
X-Gm-Gg: ASbGncvZn4KlR//abKYTO+JT77zJKWajyM4vAvBylfSDCXgFPJE0q6lDn00ErdAd2bW
	E8Ag3m2yfbgxJYbbC04uGx1JuM8zWWGh1yrgYraqBCOt17ZbHx+Ri2Z+1CJSQBrGyzBOr/OxxzC
	dAAd1prJBQ/ctqUT46kmCJ5qcq6sPiegecw53Ed1GmVeR47r1YMzUMSEXvMHdrTIKtO2aZqadbg
	4AOrM6eWYioYsWJ2NY=
X-Google-Smtp-Source: AGHT+IHM+xh1QsyoxdXgiyKgk2jbiCFgBBnT2tLYN63igqT8GhKmIhWxeGHxhNgtP/hWv5xoWFMFmox0VEdNxXZJzDg=
X-Received: by 2002:a05:690c:2701:b0:71a:51f:81a7 with SMTP id
 00721157ae682-71bcc82c74amr3159567b3.26.1754434682274; Tue, 05 Aug 2025
 15:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com> <20250725185202.68671-5-irogers@google.com>
In-Reply-To: <20250725185202.68671-5-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 5 Aug 2025 15:57:51 -0700
X-Gm-Features: Ac12FXwjhsT7kUibSskEewgvrknlXOMLvC9y39dd1apFH2jY0QK9Ru8nmw98ylg
Message-ID: <CAH0uvohOy4GzV6Cezp1NKb57sD-H=ywFN51AaZg2BnVoczrJ-w@mail.gmail.com>
Subject: Re: [PATCH v9 04/16] perf tp_pmu: Factor existing tracepoint logic to
 new file
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Fri, Jul 25, 2025 at 11:52=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Start the creation of a tracepoint PMU abstraction. Tracepoint events
> don't follow the regular sysfs perf conventions. Eventually the new
> PMU abstraction will bridge the gap so tracepoint events look more
> like regular perf ones.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

<SNIP>

> +       while (!ret && (evt_ent =3D io_dir__readdir(&evt_dir))) {
> +               if (!strcmp(evt_ent->d_name, ".")
> +                   || !strcmp(evt_ent->d_name, "..")
> +                   || !strcmp(evt_ent->d_name, "enable")
> +                   || !strcmp(evt_ent->d_name, "filter"))
> +                       continue;
> +
> +               ret =3D cb(state, sys, evt_ent->d_name);
> +               if (ret)
> +                       break;

Don't think this breakage is needed.

> +       }
> +       close(evt_dir.dirfd);
> +       return ret;
> +}
> +
> +int tp_pmu__for_each_tp_sys(void *state, tp_sys_callback cb)
> +{
> +       struct io_dirent64 *events_ent;
> +       struct io_dir events_dir;
> +       int ret =3D 0;
> +       char *events_dir_path =3D get_tracing_file("events");
> +
> +       if (!events_dir_path)
> +               return -errno;
> +
> +       io_dir__init(&events_dir, open(events_dir_path, O_CLOEXEC | O_DIR=
ECTORY | O_RDONLY));
> +       if (events_dir.dirfd < 0) {
> +               ret =3D -errno;
> +               put_events_file(events_dir_path);
> +               return ret;
> +       }
> +       put_events_file(events_dir_path);
> +
> +       while (!ret && (events_ent =3D io_dir__readdir(&events_dir))) {
> +               if (!strcmp(events_ent->d_name, ".") ||
> +                   !strcmp(events_ent->d_name, "..") ||
> +                   !strcmp(events_ent->d_name, "enable") ||
> +                   !strcmp(events_ent->d_name, "header_event") ||
> +                   !strcmp(events_ent->d_name, "header_page"))
> +                       continue;
> +
> +               ret =3D cb(state, events_ent->d_name);
> +               if (ret)
> +                       break;

Here as well.

Thanks,
Howard
