Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8538DC8;
	Tue,  3 Sep 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373498; cv=none; b=iI6QGtAfQJ/ryBz/PEqMYEtporzEV/TTRFU650nOKRq18vHgsVrn+FnujKxhBUIFILo+qIU1vVAPCaLouidTSLyr6l34iSRl3eN3vRWSjmExO69Uu2qdWbZLKdoFHRxKEBspOgqo48pjMfGgcecucXayo6o+iHF5BL+6NERgxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373498; c=relaxed/simple;
	bh=lxtQMSDCNV97wtJ76fkig2XFoSSsFkh8jb0VAzcF+JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toDF3+JTLKUITftM6cARZBLYwO6OJL8YcG9P04pNgLkcuXN1vJU5Ij21HdUqbuVBYYByk9KWYA70SbUScQC1aBbFdxMy6CC0Rm41bkodxmwo/ySfr9LOE7auRpM4DZTfZINNPsv5CwofeOS+mpaqmEJyrCSzeTyqMrv54AYmdpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCKo6DGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCKo6DGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F25C4CEC7;
	Tue,  3 Sep 2024 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373498;
	bh=lxtQMSDCNV97wtJ76fkig2XFoSSsFkh8jb0VAzcF+JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCKo6DGBjbRIg275y5P7WN9pXlCv2hdo4L0xHv9auv7rAOMY2LqrgVxbgScv6VAL6
	 B+bT2Uq97cGtvHMhaCm9WCO44eYIJWACxrYJk8iwqCO+rrBkAbnzyPQxsaQs4aCeSP
	 THDbO5edcmQoqF4eAVStxPeegjWbUSb10AHUW/8G7+NeHOmEKwwhGjm4PrpKYcdsBB
	 rrjU0+Oif/OF7eIyXIDInaQceKqQyWjI2zYeja7o4xl0nw773zfaZP2NYeDeX8NxOu
	 Zd/2GnAV4X7hJhlIOvsDgrKZ+KBf574j/duFK2tbSuEB/oEqwti+J2PpaTA+sOAAUH
	 WQXB4kz01mYYA==
Date: Tue, 3 Sep 2024 11:24:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Junhao He <hejunhao3@huawei.com>,
	David Ahern <dsa@cumulusnetworks.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/6] perf parse-events: Vary default_breakpoint_len on
 i386 and arm64
Message-ID: <ZtccNpePJAM24nA7@x1>
References: <20240831070415.506194-1-irogers@google.com>
 <20240831070415.506194-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240831070415.506194-6-irogers@google.com>

On Sat, Aug 31, 2024 at 12:04:14AM -0700, Ian Rogers wrote:
> On arm64 the breakpoint length should be 4-bytes but 8-bytes is
> tolerated as perf passes that as sizeof(long). Just pass the correct
> value.
> 
> On i386 the sizeof(long) check in the kernel needs to match the
> kernel's long size. Check using an environment (uname checks) whether
> 4 or 8 bytes needs to be passed. Cache the value in a static.

⬢[acme@toolbox perf-tools-next]$ gcc --version
gcc (GCC) 14.2.1 20240801 (Red Hat 14.2.1-1)
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

⬢[acme@toolbox perf-tools-next]$ gcc --version
gcc (GCC) 14.2.1 20240801 (Red Hat 14.2.1-1)
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

⬢[acme@toolbox perf-tools-next]$ uname -a
Linux toolbox 6.10.4-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Aug 11 15:32:50 UTC 2024 x86_64 GNU/Linux
⬢[acme@toolbox perf-tools-next]$ head /etc/os-release 
NAME="Fedora Linux"
VERSION="40 (Toolbx Container Image)"
ID=fedora
VERSION_ID=40
VERSION_CODENAME=""
PLATFORM_ID="platform:f40"
PRETTY_NAME="Fedora Linux 40 (Toolbx Container Image)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:40"
⬢[acme@toolbox perf-tools-next]$

 CC      /tmp/build/perf-tools-next/tests/bp_signal_overflow.o
tests/bp_signal.c: In function ‘__event’:
tests/bp_signal.c:115:28: error: operand of ‘?:’ changes signedness from ‘int’ to ‘long unsigned int’ due to unsignedness of other operand [-Werror=sign-compare]
  115 |         pe.bp_len = is_x ? default_breakpoint_len() : sizeof(long);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~
  LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o
cc1: all warnings being treated as errors
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/build/perf-tools-next/tests/bp_signal.o] Error 1
  CC      /tmp/build/perf-tools-next/builtin-mem.o
make[4]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf-tools-next/util/symbol.o
  CC      /tmp/build/perf-tools-next/builtin-version.o
  AR      /tmp/build/perf-tools-next/libpmu-events.a
  CC      /tmp/build/perf-tools-next/util/metricgroup.o
  CC      /tmp/build/perf-tools-next/builtin-c2c.o
  CC      /tmp/build/perf-tools-next/util/header.o
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: tests] Error 2
make[2]: *** [Makefile.perf:777: /tmp/build/perf-tools-next/perf-test-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....

