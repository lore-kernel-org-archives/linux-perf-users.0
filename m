Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F749433A9
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896126; cv=none; b=I7xN7RO+znnWJNBo2lXYfhXH6nX3/hpu2lLKRB+WGIvx7vg4l+c+qg+aGxQmtXcb6sFtgXIwD4/WPY5xQineaUyi8IOVQtuGwFa7iJX6koWCoPzdpfuWfxqQjgRrzwPdmVItxzVoJoBUk3aXNrEcZTfBv8h5O1fOaIfzr1c5icI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896126; c=relaxed/simple;
	bh=SHFh9QfE3vgBGpp/tJnVYiBlZT4O0u5vSCYlWOFgh0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djqATXtBHn2QU8VbBO0qtNkOTLofBEWnSidUGYHQt6sU44K6QI0sRFvAXHLMC8o6O73aMVAzJDXLNjCIcwsn4+IW5KGVtCiKZc68Rfa55oVv7uEXxuyq63Sc/kfLrkbCMcWuyLH0JtFfmQsCXdrYvz2jG0N9b6RJRsOGw7d3yXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuqd5Xrf; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuqd5Xrf"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so23925ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Oct 2024 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727896124; x=1728500924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UoGbZ+09ZCt3tvdSvaR+iY1YkvoCfJxElQ2jgIBo00=;
        b=wuqd5XrfpXezcZdxSn4fE5d10S4b4VKCVRxJ4swcqusJDRUCeWQgco/AB44RzvxVx6
         +N4cwcEourXFmBdROLx7z4b+kFWmTQxCnma7pkTpA6nJ/V1QoEpWtgToegeB+aUG2hgD
         GgP0dM+6Gx4yeoamHN6lEoH4tNOwAob0AoxDGDTJtJ5vslOcfMmsIysnFGv3hdzgtz5U
         9+YTNXVh1s17VEIK7MRKk2bR8D6jhtmyFWGCcoD6CimeOD2DQOFC/SUFxCsn/CU00quG
         U24AAWt81PrpIm9CKqdFe6uXfGwJn3BPF4hA3WvFENR4+GHaqC4D5Duxe3Wg/5pzY4RM
         fuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727896124; x=1728500924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UoGbZ+09ZCt3tvdSvaR+iY1YkvoCfJxElQ2jgIBo00=;
        b=AsKFsgu9JRt0PiOXJw7lp0OySYk5y2l1dujhu1q/lpL9+FXsfNpPqBxu0bjZ/9pQga
         hKBkPhItj6rorthlMUxuLFWbaM3HlyvuBHNJ31utB/QU+UytcOHumvGFHWps2gvp6qDp
         rHdYHDVgZW9zvq+j1qNCFRYOkmHJtABv08wOxQ7oiNuB4OTUfxjIIUTGvtQrpNlVwQJw
         imH9DHPVgr8Wlao6jDzv/4GA3Y7JT3+JhO23Bkz5Vg4lYU3UwH01lZ5sAzBc4ng8BWXE
         7Q1Z+hIPxqMEOz2TBneeEwVovwYZj/wf//uGvdsMUTXN5vULtEJ3r6S09KAbu8kaSgyN
         E4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUBW0E/rA0aAnLqqx17cZJRWZn/jihIdiofGb2Qj8GQsu8irEMtzrZWJRWXbLsihbvscEC/839x78ruNsuRF1ka@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkn+DAlkwhTgnrp7wxHNhnSee9jHu/kHFqnwpubaced4B49afo
	Vnnt73VkTghB1cux5q3mOiu0VOTeaerhbF0XDOiYWncWSkM15PBVL9DU399mZi/fED0217H1J0K
	qPsUCrd5+59nQO1xmxS37bAeG8axCZ+AwMNg2
X-Google-Smtp-Source: AGHT+IFU9NblRdEX0BaXE3U4WZrlmCXDu888JX3jzETGPENFixK9suXbfcxGpqOQeO0J/TJ9TmY1+LgjhIDYZ0IcLLE=
X-Received: by 2002:a05:6e02:1a6d:b0:3a0:9e83:21ea with SMTP id
 e9e14a558f8ab-3a36ee882cfmr397195ab.17.1727896124326; Wed, 02 Oct 2024
 12:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924003720.617258-1-irogers@google.com> <20240924003720.617258-3-irogers@google.com>
 <CAM9d7cjDeGF6rO8+DJQdG+tELO2ueqqvkFU-rCFETQm9KJ4JmA@mail.gmail.com>
In-Reply-To: <CAM9d7cjDeGF6rO8+DJQdG+tELO2ueqqvkFU-rCFETQm9KJ4JmA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Oct 2024 12:08:30 -0700
Message-ID: <CAP-5=fWgounnfvSQtOiqZQdpkg00yvT3E-rGNFUKKb8ZksPhjg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf probe: Fix libdw memory leak
To: Namhyung Kim <namhyung@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:44=E2=80=AFAM Namhyung Kim <namhyung@gmail.com> w=
rote:
>
> On Mon, Sep 23, 2024 at 5:37=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Add missing dwarf_cfi_end to free memory associated with probe_finder
> > cfi_eh or cfi_dbg. This addresses leak sanitizer issues seen in:
> > tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> >
> > Fixes: 270bde1e76f4 ("perf probe: Search both .eh_frame and .debug_fram=
e sections for probe location")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/probe-finder.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-fin=
der.c
> > index 630e16c54ed5..78f34fa0c391 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -1379,6 +1379,11 @@ int debuginfo__find_trace_events(struct debuginf=
o *dbg,
> >         if (ret >=3D 0 && tf.pf.skip_empty_arg)
> >                 ret =3D fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
> >
> > +#if _ELFUTILS_PREREQ(0, 142)
> > +       dwarf_cfi_end(tf.pf.cfi_eh);
> > +       dwarf_cfi_end(tf.pf.cfi_dbg);
> > +#endif
>
> This is causing another problem.  Now vfs_getname tests are
> failing because perf probe aborts.

I wasn't able to reproduce but largely as the test skips. The variable
is out of scope after the function so I'm struggling to see what the
issue is.

Thanks,
Ian
