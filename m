Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408BC3BBE3;
	Wed, 31 Jul 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455089; cv=none; b=ZKIXfTTVz8HCVGSAkUntnqx/iHiSn7J6PSR3SUxqfrR4XwhRvBrP/T8KGCA550svsFc2jdddOjH+JYNcQxj2fWn/a/EI4F8TzqRkT7OSETs+s1K5wyqs221Hg30ZiQH20c6ZV9OZonSJKfLbs9ThaC+KfvHkbyx5xUBlkS6bJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455089; c=relaxed/simple;
	bh=n6OG3JGP8rbsblq6dHGstLE8UuPnfTGxS/ia+xm6fOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic1lNZBGEQ2qyEUnMonHDXlpPU13AhGVDaThHOS1ahbQW/f1vd/u8XhHiIgIJKKwJ8HRLKE/ig76WsqbswNp+Xx4opfMIR9T1mt/Xk/Q3WgmwLgeLlS0IhugczKv7mj4bFq+xVGlG1yoq90e/1pdzMT/G0aEjcMbisgyPRVVQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZBV4glP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZBV4glP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50466C4AF0B;
	Wed, 31 Jul 2024 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722455088;
	bh=n6OG3JGP8rbsblq6dHGstLE8UuPnfTGxS/ia+xm6fOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZBV4glP0RQl+VzMgxITBM4Z2+GWhzHJtekg9XdWla4Rnoq6ikLt30nZ24m4BpvvR
	 npl8jt3iKDxwHJP/mHKWAZJOJeyuyztLydv1bpultBPLSXo13Hri8+5o7cDOr3E/Aw
	 o2qw3PPdkXI4oC1U/7NCDrzdwjYlgowJ2ZRS+hjetFMIbtxuw6r9+LlZrI1Vy5+PV9
	 093ZqPh8Kydjx4bEXCgvrGuVFaQatp8VwXXbq5WwejpIAY94lKU9FVohZXNO07iz8j
	 58MAimThD0JoqqCZfPNcjrzao9a7i4lzlOutQDWaTvveBNPAtVg7UNHoKtoXScjVq5
	 qQMSltnHtlyTw==
Date: Wed, 31 Jul 2024 16:44:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Kajol Jain <kjain@linux.ibm.com>, namhyung@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	hbathini@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH] perf vendor events power10: Update JSON/events
Message-ID: <ZqqULZ5pSojnixUh@x1>
References: <20240723052154.96202-1-kjain@linux.ibm.com>
 <CAP-5=fWsQbA-h=_Y_q7z1E7GjCkHE3w-9h-OXu4jLBM3Fag6ag@mail.gmail.com>
 <ZqOt9G9e-AIN6hY-@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqOt9G9e-AIN6hY-@x1>

On Fri, Jul 26, 2024 at 11:08:55AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jul 23, 2024 at 09:02:23AM -0700, Ian Rogers wrote:
> > On Mon, Jul 22, 2024 at 10:27 PM Kajol Jain <kjain@linux.ibm.com> wrote:
> > >
> > > Update JSON/events for power10 platform with additional events.
> > > Also move PM_VECTOR_LD_CMPL event from others.json to
> > > frontend.json file.
> > >
> > > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks, applied to tmp.perf-tools-next,

This seems to be causing this:

Exception processing pmu-events/arch/powerpc/power10/others.json
Traceback (most recent call last):
  File "pmu-events/jevents.py", line 1309, in <module>
    main()
  File "pmu-events/jevents.py", line 1291, in main
    ftw(arch_path, [], preprocess_one_file)
  File "pmu-events/jevents.py", line 1241, in ftw
    ftw(item.path, parents + [item.name], action)
  File "pmu-events/jevents.py", line 1239, in ftw
    action(parents, item)
  File "pmu-events/jevents.py", line 623, in preprocess_one_file
    for event in read_json_events(item.path, topic):
  File "pmu-events/jevents.py", line 440, in read_json_events
    events = json.load(open(path), object_hook=JsonEvent)
  File "/usr/lib/python3.6/json/__init__.py", line 296, in load
  CC      /tmp/build/perf/bench/evlist-open-close.o
    return loads(fp.read(),
  File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
    return codecs.ascii_decode(input, self.errors)[0]
UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 9231: ordinal not in range(128)
pmu-events/Build:35: recipe for target '/tmp/build/perf/pmu-events/pmu-events.c' failed
make[3]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 1
make[3]: *** Deleting file '/tmp/build/perf/pmu-events/pmu-events.c'
Makefile.perf:763: recipe for target '/tmp/build/perf/pmu-events/pmu-events-in.o' failed
make[2]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf/tests/hists_cumulate.o
  CC      /tmp/build/perf/arch/powerpc/util/event.o
  CC      /tmp/build/perf/bench/breakpoint.o
  CC      /tmp/build/perf/builtin-data.o


This happened in the past, I'm now trying to figure this out :-\

This was in:

toolsbuilder@five:~$ cat dm.log/ubuntu:18.04-x-powerpc


So 32-bit powerpc, ubuntu 18.04

- Arnaldo
