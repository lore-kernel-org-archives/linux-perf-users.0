Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2262586C7
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Oct 2025 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760915071; cv=none; b=FyYj2ZFeEZcSr+hWdbHna8cMKVDkIfRdcMjQw1vWVFwu9LdycbtLYPRfz6zcNjkNOWeE78d0X8G2MSbocYyhAudDoda9WgMEc7rdU3a0CW4q+6bIWowDnMCqMQVDeH1p07PcBYfx8VY//aAfpabgwRBOg+gIN7n9avQVXKwn9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760915071; c=relaxed/simple;
	bh=e9xtSDiNYg+DNrvVVti65ywV5UyHZvvlWtLFm7e5TE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCY964ZXmvtAOUZ11TotX/3ugHZMz57y45j60qA/VTtIzOC5UDe5Uhf3itHvxO4IByUdwMFbZSctNYCkn41tnwxeRZFN5CX/DcDSWA2+Ayh2CGuWrlGAIAwZo7LdZUiLFjz9CCNWKqaqalvT1k3EkjjFobAuLLcs2yN75Y8TTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3dqTKHG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3dqTKHG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d67abd215so245545ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Oct 2025 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760915069; x=1761519869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtIwbbtQZ22ksMvGjX6G4k0g6OAJbt4lX9wIiRbTpkY=;
        b=t3dqTKHGuj/v1xo75SDLUHys/xFMVQgfhPaHq4ikR1tkDOJD1nPF/lF0ej4JnGkI7Z
         5kVqVRoRFaEIFUFazDfpZWD0skK7RECeUnjz1ODsnHJGjsOAslQ1H2xv8qGXjqUcyY2J
         ROPcU5LQCd1WwoVuzDnH4y9otW2dCD2avLUa7HcwXQuuTw8zBO6R7jps3TyuXzjrWGMP
         YRXwmkQaCSE/WVNDILCAz2Dfi2ly71Qu8nm5+aaCIInlGjQcMyLUHcJnGLfq79lHXeBo
         FwzPUrdkhgc5iclHJsCeBk1Y7rEpz0Wtzli8HkNTq/gdoTzK+U9rMUypK8ntX5ScbKns
         hMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760915069; x=1761519869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtIwbbtQZ22ksMvGjX6G4k0g6OAJbt4lX9wIiRbTpkY=;
        b=gkRMjFfyKA/xTImR5imnGWrkWC/3EE/43jsqIlxGld8M24jT7cMIujuzf2zwB+dqJY
         DXZQvg2DjuQ4CaChIwlpTZi2xOr3dXeFlvs1Knkk9en7yoatamid1+3EIjqTNMFIk5RP
         cMuASd+9ugEn2ufa/5POWSKBirg3E7iohU+77liMQZxBrrwUQB23fxt1+Bc2K79nlEFv
         U8IgsiJXBx7xoDi15diNlBw3Ohg8dFtJQ8jPNE+i4UNm4DWZ/y2Up6qiks8xu01Wotiq
         fo1piTB8nFl40j4b+v0G9035Jd/frwTxW/gfQFaQ308fri0viiWBW9mLK2w4VGnzOTXB
         HkFg==
X-Forwarded-Encrypted: i=1; AJvYcCXvrkOKDMXoe3fgYUkc/68zLkNL2JpqhxKzMRzynQPqkfgysL3nIYcb5L1kh7SPz/miwNj6E7Xrcn4M5dTSNPw0@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzpGQooF1HsfW+KiYtdYdBZ4+qdOW2EK2meSZB6/WR1j9v0Uq
	nB2HAwt2X2fwKKed8VjVq03dWwDBEJQuKs2C2lJjHeJS3QQU2v8XV/Ih1vM9Nu4eqXhUEQu/3Qz
	C7fSAsMX3Q2OexrhGfv6c0TqEtHIpodytmrRCz8A2
X-Gm-Gg: ASbGncsUPfrJEoyDNmoy7YgDiWSzH3bFc84rmbkk7qzwLvVMbNumQ05j41Dtq7DyII1
	9nqeZBH96rb8rMHD1+Z5aUKXpWRiQISyKyoydyKgkatb8x44Ka+1+r1beCvjCH43tyou/ajV9OL
	v4AwM4VhDzrzF1rwkfRz3Ux0+fOVwEDOrs4yIeamp6FFIDyr5r6Oan2QveB2SjHJN0dBsxjFFYI
	aabqa+ovFUkHN3KT80lKIPRLGwLuKqOmoMlkTJtnu+CKxHdebbCDMErwvmrzWzdIKE69ig=
X-Google-Smtp-Source: AGHT+IF9yBT/ZwnpY3KzH5KBTz6AKdIa/kZ/Sj5ndS3FHOcw0TJENKL1Nucn1cYklbiHJR/s6+zUFaChmGa8DfjFiEE=
X-Received: by 2002:a17:903:388c:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-2908790f0c5mr22070155ad.4.1760915069394; Sun, 19 Oct 2025
 16:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016222228.2926870-1-irogers@google.com> <aPRTQLcOBtHiTGms@google.com>
 <CAH0uvohtoVR=iXNwJWYXXgnt4LLWCMheSt66Hnx5hq=QB0KU3w@mail.gmail.com>
In-Reply-To: <CAH0uvohtoVR=iXNwJWYXXgnt4LLWCMheSt66Hnx5hq=QB0KU3w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 19 Oct 2025 16:04:17 -0700
X-Gm-Features: AS18NWDEC7Vnh7xzfyEGkb8GoYCR5suU_v90J29I9PtusCfj_VaIEJaCEohdgZw
Message-ID: <CAP-5=fWDqE8SYfOLZkg_0=4Ayx6E7O+h7uUp4NDeCFkiN4b7-w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf ilist: Don't display deprecated events
To: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Gautam Menghani <gautam@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 11:50=E2=80=AFPM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> Hi Namhyung,
>
> On Sat, Oct 18, 2025 at 7:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hi Ian,
> >
> > On Thu, Oct 16, 2025 at 03:22:26PM -0700, Ian Rogers wrote:
> > > Unsupported legacy events are flagged as deprecated. Don't display
> > > these events in ilist as they won't open and there are over 1,000
> > > legacy cache events.
> >
> > Off-topic, any chance to integrate this into a perf command?
> > It'd be convenient if we can call this like `perf list --interactive`
> > or some other way.
>
> You have my vote, user-friendliness is important.
> I think Ian mentioned that the major drawback is the difficulty of
> forwarding arguments passed to the ilist.py program. A random thought:
> perf is known for binding everything under a single command, but to
> make scripting more flexible, perhaps some Bash scripts added to
> .bashrc could be considered. After all, perf is fundamentally a
> command-line tool.

Thanks Howard and Namhyung,

I think Arnaldo also raised this in the past.  My thought on how to do
this is to build in to `perf script`:

1) `perf script` currently uses libpython and then exposes a
trace_start, trace_end and process_event method. When building the
flamegraph work the only place that textual can run is in trace_end as
it needs to run on the main python thread. This means we can't do
incremental loading of data files while textual is showing the data as
perf wants to be the main thread. So step 1 is to create a python
version of the trace_start, trace_end and process_event callbacks. To
do this something like the session API needs wrapping or writing in
python. I'm not sure I'd keep the API the same as the C one. It'd be
interesting to think of async file processing. It'd be nice to make
the generation of strings.. in the event lazier. We could start with
the existing API though, and then migrate to something more complex
later.

2) Once we have a session like API in python we can convert the
existing `perf script` commands to be standalone tools similar to
ilist. So we can convert all the existing tools to be standalone.

3) Once we have standalone versions of the `perf script` scripts then
we can have `perf script` just exec the commands. The install step can
install the scripts like it currently does and we can move ilist into
the scripts location.

4) Once we run python things as tools in their own right we can
deprecate the libpython stuff, probably make it a build opt-in thing,
etc. It seems hard to delete unused features, like libbfd, from the
codebase. We did merge a patch deprecating libperl as a step in this
direction.

Thanks,
Ian
