Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB14346771;
	Tue, 17 Mar 2026 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778337; cv=none; b=NhUsharU/SCK2lucQjaDXehslvS2GHNoLNgxw2CFFcpE7RKzcM7Q9Ib5+AbR7kGHSg6XFHtzAbVsLUgJlxOVl4qMMwbV3wn3vr+bn7Th1a4fTsp1dhYbxhKSEvYhdN8yFUqZhxP6JBgpJsxPbeB6PFAa1cCUmqPaZuJ0j2cZnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778337; c=relaxed/simple;
	bh=OzqoCHEzqEfAFmh1X2n/by/RbUTPU+b/5zXaSdtpfEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jg9Kc1WG5pZ/5khMR9e04/BhDRYKnfx/wDhOeKreIiIbWTg8LmmG6/i+RTZkCCyyrXUAB0LJHP/H9IzQLizb6iUJYpQoSAjrb/+kg4WQ3v3ItrAl7IsfuFaKK4ohbfwa8K6ekPzguf/zPIpiGrMaX45jlqQGLqK5NgqzCIInhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdfF3u8+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdfF3u8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B52FC4CEF7;
	Tue, 17 Mar 2026 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773778336;
	bh=OzqoCHEzqEfAFmh1X2n/by/RbUTPU+b/5zXaSdtpfEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdfF3u8+RU7E+CqrpqpUL96t+3u7xHutn1dAxElP0SdB8xWc5GcoTKCDnyOqExHTv
	 Ga6v5Ct7hyjP3ZD7mHxXZAjdNkyHzaF8AYA2tqKKuNNy5g6/3twjR2/mmq9H/Abl1L
	 bT2j4HTItfMPlNUX4S4WQZ1z8uvU5E+g7qnKSTIs5NFn5xCQGZBF9U39wUhiwDbvrz
	 6vDSrDeRiV87VloNMQFoHTn9qdA+7r8uYeyZ9wNpX8kTGM8CS+M6oewDvUYAr9UY7N
	 kTnICccRBAHrGsdQ1165tN9shzJZ/4r3tQduxu2aRj0t5+PU4WZljurEHiP7uum6KN
	 T8/JUOqhW5S/g==
Date: Tue, 17 Mar 2026 17:12:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, Jan Polensky <japo@linux.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf stat issue with 7.0.0rc3
Message-ID: <abm1nR-2xjOUBroD@x1>
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
 <abQq79_ajs8zFeEI@x1>
 <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
 <abmt6FhLfWrzWGwU@x1>
 <abmyA5q9nXjagJIL@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abmyA5q9nXjagJIL@x1>

On Tue, Mar 17, 2026 at 04:56:51PM -0300, Arnaldo Carvalho de Melo wrote:
> It is not trying PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, is asking for
> PERF_COUNT_HW_STALLED_CYCLES_BACKEND instead...

If I instead ask just for stalled-cycles-frontend and
stalled-cycles-backend:

root@number:~# strace -e perf_event_open perf stat -e stalled-cycles-frontend,stalled-cycles-backend sleep 1
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0xa9, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 250619, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 250619, -1, -1, PERF_FLAG_FD_CLOEXEC) = -1 ENOENT (No such file or directory)
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=250619, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---

 Performance counter stats for 'sleep 1':

           409,276      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend

       1.000428804 seconds time elapsed

       0.000439000 seconds user
       0.000000000 seconds sys


--- SIGCHLD {si_signo=SIGCHLD, si_code=SI_USER, si_pid=250618, si_uid=0} ---
+++ exited with 0 +++
root@number:~#

It used type=PERF_TYPE_RAW, config=0xa9 for  stalled-cycles-frontend but
type=PERF_TYPE_HARDWARE, config=PERF_COUNT_HW_STALLED_CYCLES_BACKEND.

⬢ [acme@toolbx perf-tools]$ git grep stalled-cycles-frontend tools
tools/bpf/bpftool/link.c:       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = "stalled-cycles-frontend",
tools/perf/builtin-stat.c:     3,856,436,920 stalled-cycles-frontend   #   74.09% frontend cycles idle
tools/perf/pmu-events/arch/common/common/legacy-hardware.json:    "EventName": "stalled-cycles-frontend",
tools/perf/pmu-events/empty-pmu-events.c:/* offset=122795 */ "stalled-cycles-frontend\000legacy hardware\000Stalled cycles during issue [This event is an alias of idle-cycles-frontend]\000legacy-hardware-config=7\000\00000\000\000\000\000\000"
tools/perf/pmu-events/empty-pmu-events.c:/* offset=122945 */ "idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue [This event is an alias of stalled-cycles-frontend]\000legacy-hardware-config=7\000\00000\000\000\000\000\000"
tools/perf/pmu-events/empty-pmu-events.c:{ 122795 }, /* stalled-cycles-frontend\000legacy hardware\000Stalled cycles during issue [This event is an alias of idle-cycles-frontend]\000legacy-hardware-config=7\000\00000\000\000\000\000\000 */
tools/perf/tests/shell/stat+std_output.sh:event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
tools/perf/util/evsel.c:        "stalled-cycles-frontend",
⬢ [acme@toolbx perf-tools]$

This machine is:

⬢ [acme@toolbx perf-tools]$ grep -m1 "model name" /proc/cpuinfo
model name	: AMD Ryzen 9 9950X3D 16-Core Processor
⬢ [acme@toolbx perf-tools]

And doesn't have PERF_COUNT_HW_STALLED_CYCLES_BACKEND, but has
PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, that gets configured using
PERF_TYPE_RAW and 0xa9 because:

root@number:~# cat /sys/devices/cpu/events/stalled-cycles-frontend
event=0xa9
root@number:~#

But I couldn't so far explain why in the default case it is asking for
PERF_COUNT_HW_STALLED_CYCLES_BACKEND, when it should be asking for
PERF_COUNT_HW_STALLED_CYCLES_FRONTEND or PERF_TYPE_RAW+config=0xa9...

- Arnaldo
