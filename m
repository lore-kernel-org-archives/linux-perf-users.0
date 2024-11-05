Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76E3BBC9;
	Tue,  5 Nov 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828856; cv=none; b=N/iXsWKKLxqnhqFyLu7i9OYB0pZgZ+/sN9qlcFDPb8bJCxxhIzgAlG61VheSMl9rr6nDJgvw+rNvEZUpjUbgS8GOQxQ1HmBtL7/6zHzf0MfZiUFMD8M+eXi8IJSBw65Eee1UPMIrUNNwBHVmDXFSp3I8WukKKZ5w4ehwLOa13K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828856; c=relaxed/simple;
	bh=0Jt0LHum9ZUvkWFbUhThumM1bynS0WDCHlKZ399+5VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5WAhTd1LiDPn3LOPzhrowHeok7B7VMrWL9Q4ln6Bo1Vw0IvA89dIbUuGAB/ajnbL7KrREQ6QzuUiBZs975dIvcLbKENrzJlnDZJylA7NuhowWm5zLvtycQC1vEBFOY7jtUW9Pdwq0WZ/0smC4rGDfKEz82ra2BihaTH+Rt1Ec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzfXXK6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzfXXK6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C92C4CED4;
	Tue,  5 Nov 2024 17:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730828856;
	bh=0Jt0LHum9ZUvkWFbUhThumM1bynS0WDCHlKZ399+5VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzfXXK6KYnx7RsvivnAh9Q2PL4EqwB/HtT0MznLnYsJh2l3mfshyEsPaw9AAeHxYz
	 dnPSC3YOal7FjXbwf7DTSCEVAj4lc0PjF+2aP91Z1WAsy/zwJKOmzWG8Op3qq8vqR4
	 /TFJAea7gFyJkUQrcgqk6CxIgLvc5kFsr/Fex2j0Gk07M2M8n2j0JcGczuTdZW2sjD
	 dvUv2OK34/keLI/ewnwf1orLeoqB2mMnQMUBOIY9+aeWBq/ads2RJaSnmJvuYo6/d1
	 Fm5455r+P2YBj2dgYBIGuGoDjEXOlqIqL9p89GqwLR/Pok/mSFy/d1W2pn5nSE81FU
	 LegSqexdnypDg==
Date: Tue, 5 Nov 2024 14:47:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v2 6/6] perf tests: Enable tests disabled due to
 tracepoint parsing
Message-ID: <ZypaM8PoTDQXS61s@x1>
References: <20241102165400.75785-1-irogers@google.com>
 <20241102165400.75785-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102165400.75785-7-irogers@google.com>

On Sat, Nov 02, 2024 at 09:54:00AM -0700, Ian Rogers wrote:
> Tracepoint parsing required libtraceevent but no longer does. Remove
> the Build logic and #ifdefs that caused the tests not to be run. Test
> code that directly uses libtraceevent is still guarded.

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

root@x1:~# perf check feature libtraceevent
         libtraceevent: [ OFF ]  # HAVE_LIBTRACEEVENT
root@x1:~# perf test openat
  2: Detect openat syscall event                                     : Ok
  3: Detect openat syscall event on all cpus                         : Ok
root@x1:~# perf test -vv openat
  2: Detect openat syscall event:
--- start ---
test child forked, pid 820095
------------------------------------------------------------
perf_event_attr:
Using CPUID GenuineIntel-6-BA-3
  type                             2 (tracepoint)
  size                             136
  config                           0x2e6 (syscalls:sys_enter_openat)
  { sample_period, sample_freq }   1
  sample_type                      TIME|CPU|PERIOD|RAW
------------------------------------------------------------
sys_perf_event_open: pid 820095  cpu -1  group_fd -1  flags 0x8 = 3
---- end(0) ----
  2: Detect openat syscall event                                     : Ok
  3: Detect openat syscall event on all cpus:
--- start ---
test child forked, pid 820096
------------------------------------------------------------
perf_event_attr:
Using CPUID GenuineIntel-6-BA-3
  type                             2 (tracepoint)
  size                             136
  config                           0x2e6 (syscalls:sys_enter_openat)
  { sample_period, sample_freq }   1
  sample_type                      TIME|CPU|PERIOD|RAW
------------------------------------------------------------
sys_perf_event_open: pid 820096  cpu 0  group_fd -1  flags 0x8 = 8
sys_perf_event_open: pid 820096  cpu 1  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 820096  cpu 2  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 820096  cpu 3  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 820096  cpu 4  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid 820096  cpu 5  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid 820096  cpu 6  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid 820096  cpu 7  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid 820096  cpu 8  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid 820096  cpu 9  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid 820096  cpu 10  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid 820096  cpu 11  group_fd -1  flags 0x8 = 19
---- end(0) ----
  3: Detect openat syscall event on all cpus                         : Ok
root@x1:~#
