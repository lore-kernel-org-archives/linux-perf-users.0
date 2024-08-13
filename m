Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D571AB501;
	Tue, 13 Aug 2024 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587943; cv=none; b=kQAc/k3ibur1UXJ8a+sbUr2alaITE4KSqtY6weJvj4Z34usoTsHx2JW1oc8U7s1Q1IRPn+mf/V36fElpd+uerU0wL1mpQ+fF9SmnVLKMp5QTFNd2Uc6oWXsiRnsRyNt8miiL4VITjkQqtROcFNkk3O7TWb7Dk/NSldXlatf3SAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587943; c=relaxed/simple;
	bh=7wq5gLfK4IB/xjONTqnamdgL1z1dkr5pbPijAsZHsjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nezr2zFE0zX2UMdcs8dQ3ev5I09WNOPeTmt8k797jGvOzlOgO32MSi4LZZ2UGn2CiGIE4MDTLL10LZTRMIPgw6AYh4GeYzUQs9sgSQ/0YlsY0u9QvQecsCE4uJ9Irvj/Bev6j4mynNZUcILGX6kXchwsA4FViiNVaqHboQ94A2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb52e2cb33so3979251a91.0;
        Tue, 13 Aug 2024 15:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723587941; x=1724192741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wq5gLfK4IB/xjONTqnamdgL1z1dkr5pbPijAsZHsjM=;
        b=GM/XpTvgtYSNAyjOz5pYE9LZpJaNg0JwQQxacAffQ38cV3Xh2g4mRQNcIprRD6xfbT
         Z255uRL0ws6J3FZBQR97TYSrunkY2nzmlXGd5odO+HpfPItHvvoFG8c8sm5LeBHDTTbA
         heKiP25tl6JBqvCoxAXIk7xs53myStDesccH3nK3OXs4xywCboI6IQT5wIhrzmG+I57b
         i789YgEM4lM0aqQywUfCda5o5RP7eTE78MMtwC+oOiwpKGmRJaZUVhtYDhkh/Z3b9v8k
         MpH05t0VqnfONJoheNvUupNRwnynA7yY97EaYBhT1K5rKVuYn2512GCCeGa5LvdWIJU2
         jnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAWlYwxm0wjmDctWUjghN0iPiBBaaMRbPIcxuh2jPXRqbNuk3oU8JclAlcodiZAMJOm9OnckcxBe6BnJDLc9KPGKBqMbEQ9a74GKVbAh1DI5XAI1dKkHZP/csF8D7+9jSUHMqY+3ydSHGiuXLfPA==
X-Gm-Message-State: AOJu0YyqyCgkSnlcBRLRtReOus2dppJBs+Jb00Tqvs00zObiEZf6OXwQ
	/SaDj5HmW3IMKJh/xoQjx+CZ21+k0pm+z2qk4f4Eb8yUxuF2QcvqvPj4/xZWVdmvQfByIcnlShv
	+a3ITUFcdDiGa6V+FFJOhTex286E=
X-Google-Smtp-Source: AGHT+IGQoGjKm2LiV9QvLIAVRkvBCME+pT9Cy7oJ1hnCzwqF972+q00209OQi+lfQtzSB5Y70fVyh4Iu+lDmguZKHm8=
X-Received: by 2002:a17:90a:a617:b0:2c7:e46e:f8b7 with SMTP id
 98e67ed59e1d1-2d3aaa71696mr1105839a91.4.1723587940460; Tue, 13 Aug 2024
 15:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813040613.882075-1-irogers@google.com> <ZrtzTTHim_vGX1ma@x1>
 <CAP-5=fUA8T9B2RvXg-Hpj_fHXmwB18ah6Krm3qm5ULH-M04Lqw@mail.gmail.com>
 <ZruhsN4i6xtc59nJ@x1> <CAP-5=fXVrhanvW6vrUJsubuWUC4jBM5v_NOFp40cqTsqdHHNaw@mail.gmail.com>
In-Reply-To: <CAP-5=fXVrhanvW6vrUJsubuWUC4jBM5v_NOFp40cqTsqdHHNaw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 13 Aug 2024 15:25:29 -0700
Message-ID: <CAM9d7cgGgXTyTQNPDyVuKWM=Gxt3=J6QZ6FiYDXZRWASgKPskA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Tue, Aug 13, 2024 at 12:11=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Tue, Aug 13, 2024 at 11:11=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Aug 13, 2024 at 09:04:57AM -0700, Ian Rogers wrote:
> > > On Tue, Aug 13, 2024 at 7:53=E2=80=AFAM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 12, 2024 at 09:06:12PM -0700, Ian Rogers wrote:
> > > > > lock__parse calls disasm_line__parse passing
> > > > > &ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
> > > > > lock__delete.
> > > > >
> > > > > Found with lock/leak sanitizer.
> > >
> > > Ooops, I meant address/leak sanitizer.
> > >
> > > > Applied both patches to perf-tools-next.
> > >
> > > Thanks, could you fix the commit message.
> >
> > Sure,
>
> Also, it'd be good if maybe Namhyung could take a look. I did things
> this way as it made sense to me, but we have nested things going on
> and potentially the free would be more natural in ins_ops__delete.

Looks good to me.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
