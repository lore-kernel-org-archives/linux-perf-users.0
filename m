Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0819ADBA;
	Fri, 20 Dec 2024 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724239; cv=none; b=bJgpvRvNSrJXK/GVvpTaUmpN6sbBzFGa++ie2Vgt7v0K9QNgzRwxpS+ChaE4KnHDfvCoXRoH9olOgv+dESVXsHpnpcS+Of7AAi40W36UX1ZO+QAFB5XLIzwxmiCj55eWXHm+d+v66u7RcNA5Xhy0SdCxiOLhrOSmjkMeaLzCp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724239; c=relaxed/simple;
	bh=4UJqoNY5D6ZCpVOoV2UYkOxH9SQTMt/Qd2bBgqZQcEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzUycksda0lkp4w2YRSVgT6vbekMWwUNLtewZ6I7zFWNnvc+hIeGF5uMPDVJfi9kREH1qIw02zDZpVIFTguHJiC7Ne8QksW2G3YF11+DSGhhrqa55wLT3TdlPv69Dc6upP2bhesesN6fwCoKilte6hEO4UQDcOaYZtZg44+5jWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLJNjeBV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLJNjeBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D22C4CECD;
	Fri, 20 Dec 2024 19:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734724239;
	bh=4UJqoNY5D6ZCpVOoV2UYkOxH9SQTMt/Qd2bBgqZQcEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLJNjeBV64bzDX2EA6Ze0TX4wWEjCrBQxwJibH4BYAB93QSwxsu4qLISfjxqzQpzU
	 mCrtd1U1a7z5TDPGu7UJZapP9yoE8cFVINYkml4W27PGhwHChNWsx77K2e5eONyd9x
	 ZSbutRquNPSAvddDVzjHTWc81AVWhaRjUu91iC9UZDNxNUYHjdRLxbjH0+AfGDPyFv
	 mOP+x0Eg9Wa3VefJJfiSkT8O//1UxExggmpF6YNRh1bKA1Ds8TjsdaD877MBya59Is
	 HokM/nMuuS7gQZhmDSMwt2ZW43k4ebS8tsqqPVpBZj5g7/FS5p6amLgJUJ2C95BgsG
	 BEOs1zBLkEEGw==
Date: Fri, 20 Dec 2024 16:50:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Chen Ni <nichen@iscas.ac.cn>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] perf annotate: Prefer passing evsel to
 evsel->core.idx
Message-ID: <Z2XKjPau1uPgKqro@x1>
References: <20241114230713.330701-1-irogers@google.com>
 <20241114230713.330701-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114230713.330701-4-irogers@google.com>

On Thu, Nov 14, 2024 at 03:07:13PM -0800, Ian Rogers wrote:
> An evsel idx may not be stable due to sorting, evlist removal,
> etc. Try to reduce it being part of APIs by explicitly passing the
> evsel in annotate code. Internally the code just reads evsel->core.idx
> so behavior is unchanged.

I think this is where this comes into play, are you running 'make -C
tools/perf tools-build' before submitting?

I'll have to stop now, but will fix this if you don´t have time for a
v2.

- Arnaldo

ui/gtk/annotate.c: In function ‘perf_gtk__get_percent’:
ui/gtk/annotate.c:45:48: error: passing argument 2 of ‘annotation__histogram’ makes pointer from integer without a cast [-Wint-conversion]
   45 |         symhist = annotation__histogram(notes, evidx);
      |                                                ^~~~~
      |                                                |
      |                                                int
In file included from ui/gtk/annotate.c:5:
/home/acme/git/perf-tools-next/tools/perf/util/annotate.h:383:74: note: expected ‘const struct evsel *’ but argument is of type ‘int’
  383 |                                                      const struct evsel *evsel)
      |                                                      ~~~~~~~~~~~~~~~~~~~~^~~~~
ui/gtk/annotate.c:46:58: error: passing argument 2 of ‘annotated_source__hist_entry’ makes pointer from integer without a cast [-Wint-conversion]
   46 |         entry = annotated_source__hist_entry(notes->src, evidx, dl->al.offset);
      |                                                          ^~~~~
      |                                                          |
      |                                                          int
/home/acme/git/perf-tools-next/tools/perf/util/annotate.h:389:80: note: expected ‘const struct evsel *’ but argument is of type ‘int’
  389 | annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset)
      |                                                            ~~~~~~~~~~~~~~~~~~~~^~~~~
  TEST    tests/shell/test_task_analyzer.sh.shellcheck_log
make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: ui/gtk/annotate.o] Error 1
  TEST    tests/shell/test_uprobe_from_different_cu.sh.shellcheck_log
  CC      util/session.o
make[5]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: ui/gtk] Error 2
make[4]: *** [Makefile.perf:802: gtk-in.o] Error 2
make[4]: *** Waiting for unfinished jobs....
  CC      util/tool.o

