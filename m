Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420F1DED60
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560913; cv=none; b=O7TmrEU2lpDwI8eXhxx1Meii++U1K+cfHd4koE021ZPF/Ls13UhADcCvG6RDiT5Hl8vHhfNtUAS2QOwdOafmDNWZvOkcpeSmkycnxUFlbtkgLGzZTL2I99CZDQGLBACtQjj97dWdaSzr2ZcLHe71FUDO9iYRTUmGkQjvaPNaAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560913; c=relaxed/simple;
	bh=afIIIx1i3n9WMn66pOmFMd9JP7vGAvAmrSUmZwWaRzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDy9JwyD/xNg6qUmdf1ZMTuktwCPeQt+8JhTPIakL7ajF2SsBGH8NldbbQ1r7pXoiIB3VQ9fXNMtU56qQs4/ZE/kznTKxVIRTsJewcYDXzMXffll0BjOBrZs6waIz2gjP36PfFoC6XSXq/hceadZRWEUCrcAiFcDcEnKlWHdPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nt2AUS4u; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nt2AUS4u"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d44cb27ef4so40905ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 May 2025 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746560911; x=1747165711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+5EcfYFnWWjpo1NpjkXHEYi4iVGCXA+w8EhD5ednbo=;
        b=nt2AUS4uVVacrg10aCiOl0mkdTGZUBQz7NyWM2AP6s0S0bbxFzWUFRL5sSrCxqjlNs
         ULHPy2E2fKRRrNK+TUKW0ls4rrn+U4l2/U8tqYixZk0HwOsctuuegTOc0AQaNFEsp9LV
         rJfRoljFhD0UF97q91llwD8YufKOLrqncfz9d2xT01mrBAyboTsVM/tAUIBaElLbmeAF
         Akmgy3pQr1ysQia/Xc160DyH0Bcvfg1M3UDKpq71Kw9L5EY/I5SorgnjXp3MeM5m19xB
         Mik8bfA52sxsm/mov6cx2I0mw5bNOoYLcGiNcj+NcQZ0CNNiVPcMwSpm/wZZ0PgyPxOM
         HN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560911; x=1747165711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+5EcfYFnWWjpo1NpjkXHEYi4iVGCXA+w8EhD5ednbo=;
        b=awONSZqwd2ItH8w2OX4z0RuEi0L+u0nPnBomznIyEu348+0mXTVGIqYTGyl1LReCyX
         9zpZ3S41CuFcThNMhb0NV/Ltzl8xmEf8Iee7VisWbKLwHhnACn1DpVv/Hg5p+CPTvxlN
         bVmQB/1q9U5XJ80qBxxJEv6AwXrCo5YenU7QJYHcbdN1T2K+tj1E4kNNhB/Nk718mYPT
         IqX82LdCr20NHAC2fPRJOgfifh/ns/9VDtKHvTjMR/2Xp52R5H5inLNSyaEJmpDCB0l+
         g4H8aqCpT7Bgzpdcl3ioEpk3fBqp0ZUoM5dMHhmEPs2zeAaaIx5v5mnmEV0YBgKw4Pg8
         oYsw==
X-Forwarded-Encrypted: i=1; AJvYcCXHKiIXzmEio5I1sAgJNF37oPmcXqCPjtghtFvOXCyuiGtDQ1MMYAQpc1nVC+fp/zS6PwOZf0Y9UDC4SPSyk3UX@vger.kernel.org
X-Gm-Message-State: AOJu0YxoYLa8cDQemJ0g18f4GuKsJUa2GrnLMDHd5FC6NnXeZv55AF0g
	ydQy0w9SDAE+Y6m1WYaEVDnoY2h5fZz2WVhwjo7GIy4rzUwYa/Y8W5JRw6TL6HmoRq3/dcSP1NE
	7Ce0Cd0j7TasQMrdKQlkt6z8wbAHAixzyoZFy
X-Gm-Gg: ASbGncsFE2OATd4L6Oz82QT17w6DfbcaI2FIC9kW/hHy7C8lCvV6YN61O4kM3k5iJjC
	ujZan4hYmOOgR1oMQsS8fetzY2nioPIGCOcJRw6ElZrEuXcALKORu8zPDEDAodFe/TiwIJzeqts
	zQrAjZCMwgxF8QPh2YjlUvDLYPXyLriQLDCSN0+AzZg7g7JjZFNg==
X-Google-Smtp-Source: AGHT+IEmWlxjc1obM/2bq0YIRAsoBKqq56tlW+1CYyZLopTUiCaCmFsLFNH4E9SXNopnembNmtIG/9dN2a8JMvgpzwg=
X-Received: by 2002:a05:6e02:17c9:b0:3d5:e202:6f05 with SMTP id
 e9e14a558f8ab-3da7390f68cmr522635ab.18.1746560910764; Tue, 06 May 2025
 12:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501022809.449767-1-howardchu95@gmail.com> <aBjfrUqFe444h_CF@x1>
In-Reply-To: <aBjfrUqFe444h_CF@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 6 May 2025 12:48:19 -0700
X-Gm-Features: ATxdqUF-fVkA9dgsHZ5k89fcfEUgZDncXr7cSG9ixwZi9_0p52yiUtIGroRkZoU
Message-ID: <CAP-5=fXMwyGm5KUecSS4pUhgBB_py=R_c0LqEYfnjyRrf4bcMQ@mail.gmail.com>
Subject: Re: [PATCH v16 00/10] perf record --off-cpu: Dump off-cpu samples directly
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gautam@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:56=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, Apr 30, 2025 at 07:27:58PM -0700, Howard Chu wrote:
> > Changes in v16:
> >  - Add Tested-by from Gautam and Acked-by from Namhyung.
> >  - Rebase on the perf-tools-next branch.
> >  - Edit the commit message of patch 10.
> >  - Fix a bug caused by the type change of struct perf_cpu.
> >  - Rename test_offcpu_over_thresh() to test_offcpu_above_thresh().
>
> Please take a look at the tmp.perf-tools-next branch at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
>
> I added some Committer testing with some extra steps to describe how to
> reproduce the results and there is one point that I have to retest,
> where there is a FIXME in the Committer testing notes, perhaps I made a
> mistake or that fix should be moved to after or before some patch,
> unsure.

Hi Arnaldo,

so I tried out the tree, perf tests pass as usual, etc. I tried to dig
into your FIXME issue. Initially I thought I had a reproduction but
now I think it was a user error. So I wrote a little script where
we're setting the off CPU threshold to 10 seconds and then looking for
off CPU events that took less than than:
```
for i in $(seq 1 100)
do
  echo -n "Iteration $i of 100 "
  sudo /tmp/perf/perf record --off-cpu --off-cpu-thresh 10000 -a sleep
11 2> /dev/null
  if sudo /tmp/perf/perf script -D |grep -P '.* [0-9]{1,10} offcpu.*'
  then
    echo "BAD"
  else
    echo "GOOD"
  fi
done
```
To remove the BPF map generated events I added:
```
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8898357325cf..6c23b2cf8b66 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2841,7 +2841,7 @@ static int __cmd_record(struct record *rec, int
argc, const char **argv)
       } else
               status =3D err;

-       if (rec->off_cpu)
+       if (rec->off_cpu && false)
               rec->bytes_written +=3D off_cpu_write(rec->session);

       record__read_lost_samples(rec);
```
Anyway, running the script for nearly 20 minutes, I couldn't get a
sample below the threshold. Hand testing things also look correct.

Thanks,
Ian
