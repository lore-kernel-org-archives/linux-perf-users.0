Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03A34F48F
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790918697; cv=pass; b=i5IsXOgISUidRkIE5sNBmG0whqAPYitFS27xHJE35Ct0O2imr7xPd6X9gC0EvuHUOXkP5FBpWk5ijhAO72MDY3Lw26FYlHUpigXOmu30SkKBhjitT2SnGx5EG3LYOXrxCjNyzrk5DdRoEKF+SdqHxtPwFkTseusV5NJIvsjKajo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790918697; c=relaxed/simple;
	bh=AgbjDsS5lsfyMARcwlscp79r02AMFNcwmrlRSUCHz2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6AxnzSIJ0ccufYJGosDf4HwYFf6ifQyaWSl52kqUhxDuKhaD2ry4HIXh2yhoAzaDOdh8HIr0Wnf8HGz4l4yPxMh6+JqxTw6bG5JQ+yzpwz5M4vGf/queZ/UtTjK9Cm12PjzUPGAODqaF2xSBOQjY0bKaPGPBA0K0grpnSullcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyzRReIj; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyzRReIj"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53113d72966so116411cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 22:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790918694; cv=none;
        d=google.com; s=arc-20260327;
        b=B8b0+BaHhkVGQ4URnOf9mmX1/mH4CudVg12bLLFtCbAtUPf2i23VmFmkEerL50Xrq8
         kwMybPdzo1yD7HnbQtET1z4tJ0RWM+nRpshfhplbInEgKsLiaZbN4s/Tx92DOGFOo52F
         oIqES22ih/9L11oGg6qDEC0hokJaD3v9jA6ZR3L/WHMBa00iAqasegkRP440ODeqfJLL
         1X3fSmrMhoN8c1o5IyMgioznFOccWR8WpeuMyQPXi7Tym5k7M6TZqxaLmmj7r75U0W/R
         QPp4vJocnfA3xSB+RoqRO3SNwAHH/fmXWGGFbdv9pueD46KrLZNtQQGyCGIMCaVBrHHF
         LQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Gmik/JH3KYpHeHcblH+j+Dkl3JiyUyYaTbyhIO5zOQ=;
        fh=UTu5OJuyc8ag4WpOwOzAKG6vZQjaUxAzUmAaSupAaM4=;
        b=TBwtl20pD8hpf0lc+XMa84zCxJkrCQPcs7Ys3HnS0mYCvMEmckfaopC7fsCCNJQA5B
         iGPDQ3fiM+LHTjjuIhA6mGqpJlRHoCiFkuoSL/a8GFXjNUruKtgSO2ct7zOVXFaImsM8
         W0Hppo12fh8gRnDhaSOtmIHkuKKCDaVJ15yJdQMXSkrc3vZWymB88iNgzKAh1VgLACJ0
         53hpbgTC30tqrbNcwmjqGfWsNkzdTRHve90+Wz2IRqhw5/waryeOz0iNEJmy2Nj5yOSd
         dMQxPCkMUa025LerNcL57Gcj08YnzdUtu4a6QLoDPhzKTktQtoQFFsHy8vpHwpjsTz+7
         CRtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790918694; x=1791523494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Gmik/JH3KYpHeHcblH+j+Dkl3JiyUyYaTbyhIO5zOQ=;
        b=cyzRReIj1f7iRpHdg8kV7YaayBQNi/mXhx0NkhTmlBgk82Fc9XPkzAsXQYMS4JPoLL
         f8ZWkmtHo1CnGT6q6nSciAr3kP2YSJ/cinAOoHidcJ999p4FpiOdsUzQz7c4AbEyYVYR
         TFpRXuVI/Ff5cPt5FJQ9AbD5nHhIbLMdEC6koBjzz1GsIAA9Koz2HhY72H8ZP7q0UQAc
         LA9VovtkL3/l67qNlENtPTuZYd0XEW76j+STqc8wf9bNf0kSsuH8IWLBkkKjS8iBxZ6U
         MAaKZdK2a8XS2T1gyAjF/JRQkwH94a3QLmKrZXGFn83TGZ31FueJuF5hiL4UPCOL9SXQ
         0yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790918694; x=1791523494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Gmik/JH3KYpHeHcblH+j+Dkl3JiyUyYaTbyhIO5zOQ=;
        b=ttGnGHKY2NbVS6S1DARAWeMbabZas2F/aAkJT14+wWx7oiQn2RwEpwnjqMIvHjW1mf
         uKrD1NAP+fImRn8mJ4+PudvGjdXBlggAyreXNuML5OWDCe2xijlPOpkFtMLBNx3ADkb8
         hk/Sa9RMaMs1xcbjuZTK45jg++caXu1gQS3Ab9yA51f4ROhivXZCZchYL9olEJ2qNF8Z
         Mh70HeX2XjpGAwH8oa/U3wUfkAJB6X4Dm1ucQRKoQE84KgDQLnwa17sQiAkkgIJklLer
         CGT0MNtD8wf1gzPaLchLrAl9XPWXyBEstrD5BUdLOpmlpYZEENKF3lL6HTmjEOl6s1BV
         qFDg==
X-Forwarded-Encrypted: i=1; AKwUvBz9HA/cOsGelLyj48AL0P7kmuVmKH93OgbRdAdRC6py5/CoyJbjDWruaujSA7gZ7Ym9r1KgGKFBloMsMqNT3muU@vger.kernel.org
X-Gm-Message-State: AFuF++mNGnglwkUPkQpvV9imhiVHeeNJjcWsGpncgiaQ6PEKPjosCPU6
	XUcptdIi4SW2kuq7Y7XmRirbxnpiITF2GPhmiz9ZFVHMuxcWXb1HzOg7JRqPqWjitxiOrWpXMEN
	4iyL0C50/2WZSjuh6yGk/UwpDT0ud5ApJQYKMJB/Tk+KlviE8xezIQ62v
X-Gm-Gg: AYBFou1OhUcehKJO3Drm3I2HQCgMNQeZjtm47+L/kCgAld/aHM8hAQ2G9sdgUW9NGAW
	ChallD0wGVI9fDH8xfbIMDU4jci3KDeNgDHdKMQXSHgj60QnXlZItxiicko8/+MzpiRux5yWuTZ
	M+EY9fHnnatcZFEnwsO/QY/m4g2lnm+pUNyjnNqCU61JfXUd+jjIkF1l0DOoJVljK74PbkYkAer
	EggsLhJOuw4XTWgzDxQXSWRwrniJF9nwIBZq+6CAtkCwGJfdaahP6bhHPvrA0fnFz+t7zyNfKu5
	y6tq/6YHOo6ziLLdvRnYN13qkwKhwrpqG0WJf9JqPUGtYuAmkaYTAdSB
X-Received: by 2002:a05:622a:a589:b0:532:9003:35b1 with SMTP id
 d75a77b69052e-53415907a70mr7003641cf.2.1790918693454; Thu, 01 Oct 2026
 22:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001182004.1160406-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20261001182004.1160406-1-stephen.s.brennan@oracle.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Oct 2026 22:24:41 -0700
X-Gm-Features: AclHuK8mubcw7BhJ75MV7VJWnxC4pQdcA1lTTatey5BiecspBFY39lU4gOqswrA
Message-ID: <CAP-5=fVkoy6ZJ_3Y3E2s=7ccdQd3aUz_g-e6ivX68=aHBsmnkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf script flamegraph: Fix input file name errors
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Alice <alice.mei.rogers@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:20=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> The flamegraph.py script has a "-i" option which it uses in an attempt to
> know the input file name for the data it is processing. But perf itself i=
s
> using that flag and not forwarding its value to the script, so the entire
> strategy won't work. It's further complicated by how the option processin=
g
> is handled in the flamegraph-report script -- details in patch 2.
>
> This series introduces a helper to allow python scripts to see the input
> file name, and then fixes flamegraph.py. Testing with a variety of option=
s
> like below shows that it is using the correct input files in most use cas=
es
> I can think of:
>
> $ export PERF_EXEC_PATH=3D$(pwd)/tools/perf
>
> $ sudo -E tools/perf/perf script flamegraph -a -F999 -- sleep 1
> dumping data to flamegraph.html
>
> $ sudo -E tools/perf/perf script record flamegraph \
>                           -o myfile.data -a -F999 -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 2.891 MB myfile.data (1832 samples) ]
>
> $ sudo -E tools/perf/perf script report flamegraph -i myfile.data \
>                                  -- -o myfile.html
> dumping data to myfile.html
>
> $ sudo -E tools/perf/perf script \
>        -s tools/perf/scripts/python/flamegraph.py -i myfile.data
> dumping data to flamegraph.html
>
> $ sudo -E tools/perf/perf script record flamegraph \
>        -o - -a -F999 -- sleep 1 \
>     | tools/perf/perf script report flamegraph -i - -- -o manual.html
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 2.936 MB - ]
> dumping data to manual.html

Hi Stephen,

Thank you for the contribution! Unfortunately we recently deleted all
of this code in this series:
https://lore.kernel.org/linux-perf-users/20260926062029.800743-1-irogers@go=
ogle.com/
You can find the latest code in the perf-tools-next branch:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/
The flamegraph code that now uses perf's python module is here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/python/flamegraph.py?h=3Dperf-tools-next
and we even have some tests now:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/test_flamegraph_python.sh?h=3Dperf-tools-next

You may also like to play with the console flamegraph that is part of trepo=
rt:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/python/treport.py?h=3Dperf-tools-next

Thanks,
Ian


> Stephen Brennan (2):
>   tools: perf: add perf_input_name() helper
>   tools: perf: flamegraph.py: fix "Error reading report header"
>
>  .../perf/Documentation/perf-script-python.txt |  1 +
>  .../scripts/python/Perf-Trace-Util/Context.c  | 16 ++++++++++++++
>  tools/perf/scripts/python/flamegraph.py       | 22 +++++++++----------
>  3 files changed, 27 insertions(+), 12 deletions(-)
>
> --
> 2.52.0
>
