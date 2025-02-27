Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39EE21B9DF;
	Thu, 27 Feb 2025 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635564; cv=none; b=Xv39iAp8Hm1R5Pww28xOunFBu9EW9jXz2s9i/K4M3Qlx1XMqs0qNFWX/kddqtMLOuLQtnaZeHU6aw9YpqBvhOhG2eFfiFFuC8fbe81OGuKA78nyvdYH/X6s4NTqTzv5K6mX9epIGJa/f0MVkG3+X3LEEC6OyHZP6NSe7LJY1VCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635564; c=relaxed/simple;
	bh=5kUCSRjj8mzmu241/npJGf8zZLqdKbzqiKxRylRa3+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usWaWs37lRX7i2k+D6adns6qBMXmOknzVl/zzQcGOjARyVpNx0zB0JrKu4e0j2yxe0O66iG7O8PLncrHFlYSurAVy2qixO9+zM97SdutG5tBnHVy4F/d2eTVdYcE5cVEm9YmBDHSWMSUxF/4yKomH315enHvkx13CbBX5LpJA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa9Q6Umr; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa9Q6Umr"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f7031ea11cso5689577b3.2;
        Wed, 26 Feb 2025 21:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740635562; x=1741240362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJwPD0GY10ii3LYE/rls6e/TlooHRevIC3/aFu3/vjI=;
        b=Xa9Q6Umr2mMJ2x5QGbr7zacBCmtM26V/9U6EKhFuAxxood9tjM8j9KA/ukx9dA0VwT
         FgKO6VNGxDdXO8KWNsOMYSRL9Ev3ebKTzHf+T8KUFgVDdNBKgf+geCFH5zb8Dp0XZ+ZM
         O2GwG7+RtCtwqUdm3HPPF1UmSmrlNU3j9GEP/IXDEme6wH+1x1c+1twxQV3v/A56jb9K
         M5skaDxe0vsoSOdNhouq49mKiy0gsx/7f04rOlxVnQLS0nh9rFaD+ylc/AG5nvo9/NNc
         IAI+NEHD8g5ZRSP9bIeNJ1vKSm79y6j6h33CIdOiODHm75o1awo+j+F73P2Za7FBGmuD
         ly0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740635562; x=1741240362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJwPD0GY10ii3LYE/rls6e/TlooHRevIC3/aFu3/vjI=;
        b=l4TIuJK0vXTvN12VjMJySgQhO2bDO/HBMvU9aW7DukanBo7yVCnH4O0K/QQv/Cd3Qp
         aow6sQ1YGAhbZGZrjBP1JBNIEAQvr7+jjqUU0vmkj8oumvUXKa8wkL0jwsf2rhAJZNG3
         YCTPBiHIZ7ypdIPEgg0R7pe63jtTpzV65hdoDz8XSYknO9XraH2EcvmMgR03HzczYeNt
         EpR7R1cl4qvISbDV3sKVJL+wJb8tQAQE0+aryhv1MuaHRd8LHn8NRjmk0DT7WEm5PuPr
         jHnDbgLLSX8z83IK9D4WHSLvPsfXR17P8mfibnMfswOPMwRLaNtq4c7qUJ/iNYKRQFsL
         RRDg==
X-Forwarded-Encrypted: i=1; AJvYcCV1aCAr5AsXTQ5FF8UYdBudjW8gwro6kYj5yjCiGc2oOXhQwK+2xL6ZYs3sMZEsDTfX58ZvkzCn6LAVGIE=@vger.kernel.org, AJvYcCWtWX8qDqOCPdwefpahdC9Dmhe942rie10WGj9gKchtWbqvK83DyYruQ969wjMuk/22LlqBoiHM6jeY5+14O5EP5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Nl236WfLMIlny7p5bpDrDK+knPckgik2tZX8xLcsTuQSUWOP
	Yjy0WBcHHxxdTo4S1RETT5lMUShb22wd1lT4ECPN/FcJu3Dt3viys6sB+RzpO/aK/C+tH0b9JbV
	ohqDRUjfX/MUX19InCL+1Chh8b+g=
X-Gm-Gg: ASbGncuVapOMJvo4G7KBm0RFhSrtHryRfc0cb+O2AVhgKq9ewtO4b2KqLb86UF/A+t1
	v4O5HcOzutWJVeyB6u5HnuFSf6MROS2aGgzFdBzWRGJvlHuNxQtNX8p+hTj4XE7dXfIRHDWVraH
	oiXcRSpw==
X-Google-Smtp-Source: AGHT+IHS78ZW5nm+9erUSispKEExb5S+uKkFxV0D6ujXZqiQLgGFSzQVMrF5FC6WoV8hh5RFYlM9XG5+zw/rYPeL98o=
X-Received: by 2002:a05:690c:48c7:b0:6ef:4ed2:7dfe with SMTP id
 00721157ae682-6fd220a6bf0mr72839567b3.31.1740635561779; Wed, 26 Feb 2025
 21:52:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 26 Feb 2025 21:52:29 -0800
X-Gm-Features: AQ5f1Jq1WDZtkGyh8E-boBPV8jmme5AIxUpwIWRVTv-_do-pKDaXLFHAOEOaXqY
Message-ID: <CAH0uvogzOruUpPCNXtNReSCtjQUm0AZFrMwjQvQDmym4PmfZhg@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Python improvements for a real use of parse_events
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

Sorry for the late reply=E2=80=94I just recovered from a nasty flu.

perf $ git log --oneline | head -n 11
0c1d18794589 perf python tracepoint: Switch to using parse_events
94dc6574ff24 perf python: Add evlist.config to set up record options
ebc33f96a37d perf python: Add evlist all_cpus accessor
c1ff82e366ee perf python: Avoid duplicated code in get_tracepoint_field
5293474151de perf python: Update ungrouped evsel leader in clone
47f66c784109 perf python: Add optional cpus and threads arguments to
parse_events
d4f592ec635e perf python: Add member access to a number of evsel variables
f4a3006a2c87 perf python: Add evlist enable and disable methods
2e040a422d0a perf evsel: tp_format accessing improvements
d79fd699f99a perf evlist: Add success path to evlist__create_syswide_maps
054b63706989 perf debug: Avoid stack overflow in recursive error message


perf $ sudo python python/tracepoint.py
libperf: mmap_per_cpu: nr cpu values 4 nr threads 1
libperf: idx 0: mmapping fd 3
libperf: idx 1: mmapping fd 4
libperf: idx 2: mmapping fd 5
libperf: idx 3: mmapping fd 6
time 35749194145330 prev_comm=3Dpython prev_pid=3D233668 prev_prio=3D120
prev_state=3D0x100 =3D=3D> next_comm=3Dmigration/0 next_pid=3D20 next_prio=
=3D0
time 35749196508397 prev_comm=3Dpython prev_pid=3D233668 prev_prio=3D120
prev_state=3D0x100 =3D=3D> next_comm=3Dmigration/1 next_pid=3D25 next_prio=
=3D0
time 35749196575872 prev_comm=3Dpython prev_pid=3D233668 prev_prio=3D120
prev_state=3D0x100 =3D=3D> next_comm=3Dmigration/2 next_pid=3D31 next_prio=
=3D0
time 35749194158623 prev_comm=3Dmigration/0 prev_pid=3D20 prev_prio=3D0
prev_state=3D0x1 =3D=3D> next_comm=3Dswapper/0 next_pid=3D0 next_prio=3D120

Worked very well.

On Wed, Jan 8, 2025 at 11:51=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> While parse_events access in python was added, it wasn't used by any
> python script. In enabling this for the tracepoint.py script a number
> of latent bugs and necessary improvements were discovered.
>
> Ian Rogers (11):
>   perf debug: Avoid stack overflow in recursive error message
>   perf evlist: Add success path to evlist__create_syswide_maps
>   perf evsel: tp_format accessing improvements
>   perf python: Add evlist enable and disable methods
>   perf python: Add member access to a number of evsel variables
>   perf python: Add optional cpus and threads arguments to parse_events
>   perf python: Update ungrouped evsel leader in clone
>   perf python: Avoid duplicated code in get_tracepoint_field
>   perf python: Add evlist all_cpus accessor
>   perf python: Add evlist.config to set up record options
>   perf python tracepoint: Switch to using parse_events

Not an expert in this but:

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
>
>  tools/perf/python/tracepoint.py |  23 +++---
>  tools/perf/util/debug.c         |   2 +-
>  tools/perf/util/evlist.c        |  13 ++--
>  tools/perf/util/evsel.c         |  16 +++-
>  tools/perf/util/python.c        | 127 ++++++++++++++++++++++++++++----
>  5 files changed, 145 insertions(+), 36 deletions(-)
>
> --
> 2.47.1.613.gc27f4b7a9f-goog
>
