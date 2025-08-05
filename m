Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1F2BDC37;
	Tue,  5 Aug 2025 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436350; cv=none; b=jKdPE2eI2Mlh747JbFHciutms8jSQs1iIo0F/LWimdzQ0LZEvyckwcCr9SH9OqSNCAwfOrwBmt0Yb40JaYeiDEQrrcZruh21s2E0VjLzYYMi1ZFuxBw6a4xVok/XXVIRIeLhqCwKCKjyCkLKzlOpnqs+RxfdIDmgT8xKwktT2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436350; c=relaxed/simple;
	bh=C65c+zzrN0XSxamvFIhvRx7t0j85ZHvgW94dLkvcamg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EspwryiG1lMx0D2HksbaK9h7aD1luEggh3lQlv6xuKt0VTWATHg9qzQwq3NXdpdEp53Yb+3vuRjD+GSRDupPg/f/oRP2oz4/sPkR+MuY00qu/OCxC8/gsziJb6Zvs16qIEf0V9dGTVL7DnV1o8DDI+Py2apy/xYkh3ax12vxcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2HJ3yF0; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2HJ3yF0"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8fdbd45e10so4596716276.1;
        Tue, 05 Aug 2025 16:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754436347; x=1755041147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C65c+zzrN0XSxamvFIhvRx7t0j85ZHvgW94dLkvcamg=;
        b=Y2HJ3yF0NMbl0xU+oPkU8YG+xu+cNwEyOjp6/jbKW6t0eiEp1HT7xPC17+W22d4eKj
         o9hoMetjZN3NxkdgWRmtAFF6Hy34b7UalKEgktGalaKmReylU8pl5v1Sfgw5OC1uMdJH
         SMg13KWcyUuMbofvmwR6p6YQvJ1xiNE20CDOJY4mSi0aroQ7e62WP/ftHX7mabOENfPQ
         77v9YWrl2BjtTpBi12x0VwgFp7FpELRGy2KJ8dekVay+9fQsm0uE+lPKeLDmzlQsDefo
         Mc5M9VBFCp+Ng2zWQtC6VJtzJoLjBrgrbrUKkPOQ27v24CYWveCv5EYpIX8oIAzX8fzc
         rbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754436347; x=1755041147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C65c+zzrN0XSxamvFIhvRx7t0j85ZHvgW94dLkvcamg=;
        b=MZkhGvG1eUWnet0rkKi7+eNwu1EKXnPDAiS+yrkswY3emzLK17g+g/FjNEauZXNJa1
         KMw+N5BjNKJeq3zi8an4YSy9IR9y8lkltv0zl7iny/6JKNiBHiELNPxbiZ6peudKszp3
         cfkFO/GLtubiK6H6TUU8t5iOS/Z3Nkw/MPFC0RrU0SPEW5Wl4gA1/HT6kODFkXnOpLoK
         4SaECXrJTL7I1REQUNPa6HRJsqYvM/Yp+eUKAFS+bxElvuVhccjpPjJCnJvsuaMAgF8G
         rF7LEzibYepM5TL1pz+weCKBsvkNFV6HlBDqrxLwi8hYRMCqJTgjoNM/ILJr8wOQnbus
         fdAg==
X-Forwarded-Encrypted: i=1; AJvYcCVcu9DKYyOgJM4G9a2PTDM/hFPVPGn0s8d8ClzgFvY3LGycO8iOJN4OeGcO1JU2vTG9J8jk14Adbxzk4Xe+yhkdNw==@vger.kernel.org, AJvYcCXKI2adHfNS2AOi1YZZJAPIka5jkp2AfNPe6+IsOrKl8xI0621JbWRJHELkuqm94Ah3bgqe4VvsJi1K9y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qgBSdN6PJjsic10fAkawv9y50B+axmKsa+03vRr7TVtdgo/t
	J9Jzbi/QapBzLh26Sit69JpXItAaFnibg6mBi4ZL2jC9Uuq4MTaFKSnkf4izCMbfzFF2zw3uEOb
	K1V5SSOygat7Hytkml6QGY0nebQh+858=
X-Gm-Gg: ASbGnctC0pcFWGz1vpfi/VvM52WiqUlqqhHnHaRXb+VMGFdnt6+Tbc1AGo9qiSEKRPY
	DZX6pG1YnKkm8lnTPMoU2U4yYO4+HN7+kAg1tjbiwHVzXaYzuclT0SVlPEHnOUdrGGIZ/jUIgFP
	T/moWjCvHXw8iNGo+DsIXEQFwHfsrdaaqaScrElHOxDOZLL9W/ieDvSrUntKIWST3CZUhui46Ne
	WottuTDiEqiYMOMRV0=
X-Google-Smtp-Source: AGHT+IEX101ADZuJOkZzh45cKclgEb+KcurGLnOOyjAvuwx2ZdewPfAY06vNJmOKs8uxGazfvKYQIcJGCK/87H2J5p0=
X-Received: by 2002:a05:690c:6107:b0:70e:2d30:43eb with SMTP id
 00721157ae682-71bc9716b8fmr14387547b3.12.1754436347573; Tue, 05 Aug 2025
 16:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 5 Aug 2025 16:25:36 -0700
X-Gm-Features: Ac12FXw1Sqf9yXJPja23W5inmdbX_gZuBK9K3Q3jPb0eTysr2xk8IAX7Y8pz4Ow
Message-ID: <CAH0uvojRALoYJ6QqhvK1f5naoxCyQ0LuC5WcGm7NDuCUnjd5_w@mail.gmail.com>
Subject: Re: [PATCH v9 00/16] New perf ilist app
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Fri, Jul 25, 2025 at 11:52=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> This patch series builds up to the addition of a new ilist app written
> in python using textual [1] for the UI. The app presents perf PMUs and
> events, displays the event information as in `perf list` while at the
> bottom of the console showing recent activity of the event in total
> and across all CPUs. It also displays metrics, placed in a tree
> through their metric group, again with counts being displayed in the
> bottom panel.
>
> The first ground work patches of fixes, cleanup and refactoring were
> separated into their own series here:
> https://lore.kernel.org/lkml/20250709214029.1769089-1-irogers@google.com/
>
> The second part of the patches adds event json for the software PMU
> and makes the tracepoint PMU support iteration of events and the
> like. Without these improvements the tracepoint and software PMUs will
> appear to have no events in the ilist app. As the software PMU moves
> parsing to json, the legacy hard coded parsing is removed. This has
> proven controversial for hardware events and so that cleanup isn't
> done here.
>
> The final patches expand the perf python APIs and add the ilist
> command. To run it you need the updated perf.cpython.so in your
> PYTHONPATH and then execute the script. Expanding PMUs and then
> selecting events will cause event informatin to be displayed in the
> top-right and the counters values to be displayed as sparklines and
> counts in the bottom half of the screen.
>
> [1] https://textual.textualize.io/
>

Methinks this is a great series that opens up a ton of possibilities.
Fwiw, here are my opinions:

1)
Hitting enter while searching directly activates the collection, I'd
rather hit enter twice for more control.

2)
steps to execution:
~~~
sudo -s
source /home/howard/venv/bin/activate
pip install textual
PYTHONPATH=3D/tmp/perf/python python/ilist.py
~~~
For me, it's a lot of commands--especially since I need to install the
textual package myself. If the process were simplified or
well-documented on the perf wiki, I would have no problem entering all
the commands.

I don't have any issue running ilist.py using shabam (#!/usr/bin/env
python3), but to improve it slightly, ilist.py should be renamed to
ilist, just like b4 and yum.

3)
It would be better if the TreeNode could expand to the full height in
the left window when not collecting events, but only show their event
names, their parent, and positions.

4)
It'd be nice if I can pause the event collection.

5)
Sparkline's height can be bigger.

6)
If this is an interactive command that collects the count of events
why not name it istat? ilist sounds like reading the menu without
placing an order.

I apologize for the delay.

Thanks,
Howard
