Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F441FF7DB
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353139; cv=none; b=Ey2UGZqOj6rxL7ePUsBaFSg30hq4an+qMsb0B8YkOkuqRQxShImGseQEvhdS4bm6l828d1Nen9e3Vi2R1yygCe8SXfnkOK/4yaADTJWGc7bf7q9HDPy6uYs3Eahx6gGtz/oA3LFWrrXpqxldMbhOh08ATXQLU3tJsjjbmuNm2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353139; c=relaxed/simple;
	bh=rAYDpkGk+xHME9aBN86mUG3KPXZeVYF9+qzze1bwF9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jD8W7kqt1OLpQNCxkjp0RNFjA/41Ugt7GdVa+VUaj8dGC44niMdGag9sqd7eT1r1csdELRR/TfSwzAixTXwBjz+e0lS1THcl/TQywgb2/QS5LZ+4yCR/JXMOJ7xWqLuHBwqGDzIN7hwZmMBfzOBhfKlSNIjMU5thb4XNpmWc7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UGQiRFEJ; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGQiRFEJ"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso141085ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 08:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736353137; x=1736957937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc7dJyw4DuWagBS4xeWHwj6Y6reqNDnebcGOLTdsYoo=;
        b=UGQiRFEJYxlEse6GbGbpUwGappPY9UgCGw8q6jDO0+9Esmh/fa9l1sOIU9JzTPql42
         2mjwJVftwFHmTQQWhYRnDMP/f5/xvZDXvIKzzKqA95dHsQrfy3Mn95pCaR+jrATUNYWZ
         Gj4BpdOObWZm/9YlCyXqBHCnvODpX4Japc3VMWWK44195cYkS3NhE9mAR+0V1xrADQNW
         YBaF3SIWatHPIS81k8W7OI7ol/U8E0N4Fyk+wrR0PYpPMDOAL4cHnygQLJkd4TlSdjUm
         UJJkzVtPwkFXNp0u0KH/sAPYNJ1t1t3gfoH7REmN+IUhL5V4wbz5eZEBqDiU3TDk+ELf
         JPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353137; x=1736957937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tc7dJyw4DuWagBS4xeWHwj6Y6reqNDnebcGOLTdsYoo=;
        b=ZowA/ztN0xDjNHLZpUzIkY7qF1Cvbh8v1YbBK1W3KuIES63ge6jWot2mtiQoqfMgR6
         9znVjnlsA1xwYBj2BtTmTp80yfbhOcmWwF8AKeCIZ6NUDTpReHprAYgq1FEFOwSOhQ6h
         n6bLtxciRM8KUqdlsEzIj8Y0cLQT7yW8UXozjMRsrArv/dbedqfGbRxV6KTWeT/7QnLt
         CXqE+9/Oe1tq756g4WflArrYt/bkpFP/g9qMLwAFXagMXZhhHKIdaMD8A5Lympaeuk7T
         +xUu6DQ59wpPZb15qbY9BqEgFTVo2bCIJlrwJp08iGgVexHgrcEMvCYc5swfPSfiqn/x
         VO+w==
X-Forwarded-Encrypted: i=1; AJvYcCVo8Su87WF9XDAkOMPco+7tTYf5An8aVrMEZmO9/Ax0MIityP3/lKg5DezIs5kBdgJCFBFJ1AgxKXrvf7bfQdNz@vger.kernel.org
X-Gm-Message-State: AOJu0YwIHjag1IpCWi2b0OEgVXPUjZ3VnbAxm8UJBkGVT3ICAoRkKGNn
	9xQRXnAZTJTjzl4GiW1dyX3wBM3eGUJJ/I/NRsogarfk36NqJHgUIkWQjiHbIFQlnES/0JVKSHS
	XZdTok1joKiGgPmgMsrx8CwJoZkZG8lbp6bdr
X-Gm-Gg: ASbGncsPE6mS4fF9Cw52JLkx1YVELUd2VPAaolwejw1yE1MAKRqy5HIYPw+9jTWd1bt
	LevfjkS5CvnaR4nqGx8HWNoAIOSIhPZ8lveT54jhxvCd3K6nlTAr5gSa1ZeXCicWhtZoiJg==
X-Google-Smtp-Source: AGHT+IGq/GdzqwxlxOTgPvExGz7VgTnWdROiL8lVMNr6AKOXlBcq6O9wZ9nVx4DXc9SK+J08lg2kyZ/cj24AiCgJDos=
X-Received: by 2002:a92:cd86:0:b0:3ce:39a5:3ebf with SMTP id
 e9e14a558f8ab-3ce3af37ae9mr4324765ab.8.1736353137158; Wed, 08 Jan 2025
 08:18:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209222800.296000-1-irogers@google.com> <20241209222800.296000-2-irogers@google.com>
 <Z36Q5yGApnfCKsBq@x1>
In-Reply-To: <Z36Q5yGApnfCKsBq@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Jan 2025 08:18:45 -0800
X-Gm-Features: AbW1kvb8v22qLskAEulmEw2sJBThFUHqhwJ5dR6b77w6YW4FtRkA7WfjHZ951WM
Message-ID: <CAP-5=fWGrzsO15kszYvTGBus+ojxJg3bQMntJrcsfhpAAjiBmA@mail.gmail.com>
Subject: Re: [PATCH v1 01/22] perf vendor events: Update Alderlake events/metrics
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Caleb Biggers <caleb.biggers@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 6:51=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Mon, Dec 09, 2024 at 02:27:38PM -0800, Ian Rogers wrote:
> > Update events from v1.27 to v1.28.
> > Update TMA metrics from 4.8 to 5.01.
> >
> > Bring in the event updates v1.28:
> > https://github.com/intel/perfmon/commit/801f43f22ec6bd23fbb5d18860f395d=
61e7f4081
> >
> > The TMA 5.01 update is from (with subsequent fixes):
> > https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aae=
c5c22d782
>
> On my workstation this patch is causing:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ perf stat sleep 1
> event syntax error: '..ED.L3_HIT/,cpu/DTLB_LOAD_MISSES.STLB_HIT,cmask=3D0=
x1,metric-id=3Dcpu!3DTLB_LOAD_MISSES.STLB_HIT!0cmask!20x1!3/,topdown-mem-bo=
und/metric-id=3Dtopdown!1mem!1bound/,cpu/UOPS_..'
>                                   \___ Bad event or PMU
>
> Unable to find PMU or event on a PMU of 'cpu'
>
>  Performance counter stats for 'sleep 1':
>
>               0.79 msec task-clock:u                     #    0.001 CPUs =
utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 68      page-faults:u                    #   86.026 K/sec
>            381,023      cpu_atom/instructions/u          #    0.36  insn =
per cycle              (60.24%)
>             92,367      cpu_core/instructions/u          #    0.44  insn =
per cycle              (39.76%)
>          1,064,063      cpu_atom/cycles/u                #    1.346 GHz  =
                       (60.24%)
>            209,521      cpu_core/cycles/u                #    0.265 GHz  =
                       (39.76%)
>             82,585      cpu_atom/branches/u              #  104.477 M/sec=
                       (60.24%)
>             19,921      cpu_core/branches/u              #   25.202 M/sec=
                       (39.76%)
>              6,049      cpu_atom/branch-misses/u         #    7.32% of al=
l branches             (60.24%)
>              1,685      cpu_core/branch-misses/u         #    8.46% of al=
l branches             (39.76%)
>
>        1.001365193 seconds time elapsed
>
>        0.000000000 seconds user
>        0.001284000 seconds sys
>
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ grep -m1 'model name' /proc/cpu=
info
> model name      : Intel(R) Core(TM) i7-14700K
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> And on the notebook, that is also hybrid:
>
> acme@x1:~$ grep -m1 'model name' /proc/cpuinfo
> model name      : 13th Gen Intel(R) Core(TM) i7-1365U
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ perf stat sleep 0.1
> event syntax error: '..ED.L3_HIT/,cpu/DTLB_LOAD_MISSES.STLB_HIT,cmask=3D0=
x1,metric-id=3Dcpu!3DTLB_LOAD_MISSES.STLB_HIT!0cmask!20x1!3/,topdown-mem-bo=
und/metric-id=3Dtopdown!1mem!1bound/,cpu/UOPS_..'
>                                   \___ Bad event or PMU
>
> Unable to find PMU or event on a PMU of 'cpu'
>
>  Performance counter stats for 'sleep 0.1':
>
>               0.94 msec task-clock:u                     #    0.009 CPUs =
utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 66      page-faults:u                    #   70.334 K/sec
>            308,869      cpu_atom/instructions/u          #    0.50  insn =
per cycle              (51.07%)
>            209,685      cpu_core/instructions/u          #    0.75  insn =
per cycle              (48.93%)
>            616,738      cpu_atom/cycles/u                #    0.657 GHz  =
                       (51.07%)
>            281,210      cpu_core/cycles/u                #    0.300 GHz  =
                       (48.93%)
>             63,094      cpu_atom/branches/u              #   67.237 M/sec=
                       (51.07%)
>             48,598      cpu_core/branches/u              #   51.789 M/sec=
                       (48.93%)
>              5,086      cpu_atom/branch-misses/u         #    8.06% of al=
l branches             (51.07%)
>              2,653      cpu_core/branch-misses/u         #    5.46% of al=
l branches             (48.93%)
>
>        0.102117022 seconds time elapsed
>
>        0.001682000 seconds user
>        0.000000000 seconds sys
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$

Thanks Arnaldo, it looks like this problem exists on all the hybrid
metrics which are sourced from the following (look for cpu@ that
should be cpu_core@):
https://github.com/intel/perfmon/blob/main/ADL/metrics/perf/alderlake_metri=
cs_goldencove_core_perf.json
https://github.com/intel/perfmon/blob/main/ARL/metrics/perf/arrowlake_metri=
cs_lioncove_core_perf.json
https://github.com/intel/perfmon/blob/main/LNL/metrics/perf/lunarlake_metri=
cs_lioncove_core_perf.json
https://github.com/intel/perfmon/blob/main/MTL/metrics/perf/meteorlake_metr=
ics_redwoodcove_core_perf.json
I'll need Caleb to do a new version of these metrics before I can send
out the updated version.

Thanks,
Ian
