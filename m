Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AFC17799F;
	Thu, 19 Dec 2024 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644613; cv=none; b=XEhh1xxyBTv1Uw508BJAi1LDYC2oT3UF2/Uvks+0AA/6JbwBoGb9yyWsEr5udzJgUfkGE4SY/rCYJwYF65ECN2ZXayKdtRzoBKUylbxm5TvadBq0zySiiydc33kCmCdCqt9fj3jANzwY4lLGr5/CJZDCAjNrKiwxxXIJhftm1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644613; c=relaxed/simple;
	bh=weeODoNx4xsZOFMi7h8qbuiVjsP+sm5nfIcQUHWqF9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t6IC3GG+C/6bFqiTZpCvyp3v4aUzL+UlOaLs7SE4B+zl5xaxEhHsnlBk1+JuM11BLI+2S6ccJObd7m+O2cbn6af3d2fgLAFVpVIFyQfMKUZjN5ZUl8JqdTRQ00WnzNxvClz2VLPFazjdLGqHP3JOigpLGpbJuszGugXW+JoLjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFfDm7T4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFfDm7T4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D873DC4CED0;
	Thu, 19 Dec 2024 21:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734644613;
	bh=weeODoNx4xsZOFMi7h8qbuiVjsP+sm5nfIcQUHWqF9Q=;
	h=Date:From:To:Cc:Subject:From;
	b=tFfDm7T4Frx5F1TWggzo1sJB1XEkrnMBe/ycUdEb1cQumANOtN8DNdvGsIOMO3iba
	 R+cedahbogj/qeO5P+5jaM7JmehYfSs3t2za0/fEn4UT1Rb5S+jcOrhqSTHUAew6Zv
	 8mu9Lmwhexb/OVsKYK66g6OvCODJTSLhW+LXMuU1xPYDrDzssLNaAosSR9yp83sg7u
	 jINQN6NHAPyGVVEl74Dyivdtfd5ga0wFi0mkLdVCs8HCqDZi7EL5WPMZPejQwWJm5A
	 QzIh0jU8S/+qRan+mFDIIxs0P/TfyypvdIT0NO9gH2eQ3uQ4ZZ6AmwMDS4zsd0d3oV
	 wf/lddJ3+pPBw==
Date: Thu, 19 Dec 2024 13:43:31 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [BUG] perf trace: Unaligned access in timespec
Message-ID: <Z2STgyD1p456Qqhg@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I found perf trace is getting core dump due to illegal instruction by
misaligned pointer access.  It seems to come with the new clang changes
and I got this UBsan message.

  $ sudo ./perf trace -a sleep 1
  ...
  tools/perf/trace/beauty/timespec.c:10:64: runtime error: member access within misaligned address
  					  0x7f57636105e4 for type 'struct augmented_arg',
  					  which requires 8 byte alignment
  0x7f57636105e4: note: pointer points here
    ad 7f 00 00 10 00 00 00  00 00 00 00 01 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
                ^ 
      #0 0x5637d68d0ed7 in syscall_arg__scnprintf_augmented_timespec tools/perf/trace/beauty/timespec.c:10:64
      #1 0x5637d68d0ed7 in syscall_arg__scnprintf_timespec tools/perf/trace/beauty/timespec.c:18:10
      #2 0x5637d688dfef in syscall_arg_fmt__scnprintf_val tools/perf/builtin-trace.c:2316:10
      #3 0x5637d688dfef in syscall__scnprintf_args tools/perf/builtin-trace.c:2394:15
      #4 0x5637d68838ee in trace__sys_enter tools/perf/builtin-trace.c:2675:13
      #5 0x5637d688ec8c in trace__handle_event tools/perf/builtin-trace.c:3495:3
      #6 0x5637d688ec8c in __trace__deliver_event tools/perf/builtin-trace.c:4045:3
      #7 0x5637d6886841 in trace__deliver_event tools/perf/builtin-trace.c:4072:10
      #8 0x5637d6886841 in trace__run tools/perf/builtin-trace.c:4432:10
      #9 0x5637d688112b in cmd_trace tools/perf/builtin-trace.c:5521:9
      #10 0x5637d67af002 in run_builtin tools/perf/perf.c:351:11
      #11 0x5637d67aee36 in handle_internal_command tools/perf/perf.c:404:8
      #12 0x5637d67ae76e in run_argv tools/perf/perf.c:448:2
      #13 0x5637d67ae76e in main tools/perf/perf.c:562:3
      #14 0x7f576498a3d3 in __libc_start_main (/usr/lib64/libc.so.6+0x613d3)
      #15 0x5637d6793f69 in _start /usr/src/csu/../sysdeps/x86_64/start.S:120
  
  SUMMARY: UndefinedBehaviorSanitizer: misaligned-pointer-use tools/perf/trace/beauty/timespec.c:10:64

Thanks,
Namhyung

