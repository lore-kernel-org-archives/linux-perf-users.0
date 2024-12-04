Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F662119;
	Wed,  4 Dec 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348649; cv=none; b=Im/GfhkYYLrKnEIbrYx59CqXE1KNxpjiLVoCUWWbM5yBI6L4crWxtb5Zhd1C+VuXew1iO9H8Y/td9XKQ8XMP+ImcRWFNzDbZZJRPBAghMue3bkoHYlulZwivzXFiwWAtG2j1ArhFZ05HYL0UxtbhndIWQZe9eUdBHTGy+BeXGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348649; c=relaxed/simple;
	bh=stKQ7fcojg34li0rOLarPjl4Anxwtj3iQSIz+P329ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2tQnq8sot2/jzENJaBO92LhASVdOzUF9r9cbMOAd1XelH96ejuL9QzV5q1H4XkdYxxB7+0B31ENVy/2j0zzvVl4gLsWsSkvRcdooLBXbOSYuJtKlUJsaV0GAuci21T2h+oKe8LxD/rFx4BZBCucFmlBDBT5yiWAjEjVnxLOLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juZMzVzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juZMzVzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79DDC4CED1;
	Wed,  4 Dec 2024 21:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733348648;
	bh=stKQ7fcojg34li0rOLarPjl4Anxwtj3iQSIz+P329ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juZMzVzYnSVSBGCqozInVaum7QWNhmhTIs1HSUyguByEg0TQqqmcZYk5r8/GIzAp1
	 YGLN15PpwDo5FxmxHTpFJqmeJafuYKGELsGZ/4XgUI+R3a+08G+LGYRqXlpAJM0IK6
	 gbfR9goh7UquxzPm7YfgoPm6PWlFSeI4c8/kXs4L9FMRC71e222I1UP3TsKJ0wFqSW
	 8qpDSDkUEjXhIhGXz3KoPpm3brd3WyrcWzpRH/C1wbAvdfJU2eIsyeI9ONEH/CIrJh
	 rspKsq6NNokLMVOTHP7NoiOZAjXxdnf2XYknCjJDFDjC9mkSosSqItE68gWR16ksTy
	 XxDIirpMCMhaA==
Date: Wed, 4 Dec 2024 13:44:06 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Mingwei Zhang <mizhang@google.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [linus:master] [perf tools]  af954f76ee:
 perf-sanity-tests.Test_data_symbol.fail
Message-ID: <Z1DNJpDzCIBFrIZT@google.com>
References: <202411301431.799e5531-lkp@intel.com>
 <Z04ZUHaGdsBapIEL@google.com>
 <Z1BhfpYWpUQ0p+qR@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1BhfpYWpUQ0p+qR@xsang-OptiPlex-9020>

On Wed, Dec 04, 2024 at 10:04:46PM +0800, Oliver Sang wrote:
> hi, Namhyung Kim,
> 
> On Mon, Dec 02, 2024 at 12:32:16PM -0800, Namhyung Kim wrote:
> > Hello,
> > 
> > On Sat, Nov 30, 2024 at 03:03:10PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "perf-sanity-tests.Test_data_symbol.fail" on:
> > > 
> > > commit: af954f76eea56453713ae657f6812d4063f9bc57 ("perf tools: Check fallback error and order")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > [test failed on linus/master      7af08b57bcb9ebf78675c50069c54125c0a8b795]
> > > [test failed on linux-next/master f486c8aa16b8172f63bddc70116a0c897a7f3f02]
> > > 
> > > in testcase: perf-sanity-tests
> > > version: 
> > > with following parameters:
> > > 
> > > 	perf_compiler: gcc
> > > 
> > > 
> > > 
> > > config: x86_64-rhel-8.3-bpf
> > > compiler: gcc-12
> > > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > 
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202411301431.799e5531-lkp@intel.com
> > > 
> > > 
> > > 
> > > 2024-11-28 08:31:19 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-af954f76eea56453713ae657f6812d4063f9bc57/tools/perf/perf test 121
> > > 121: Test data symbol                                                : FAILED!
> > 
> > Thanks for the report.  But I have a request.
> > 
> > Can you please run the perf test with -v option so that we can see the
> > detailed error messages when it failed?
> 
> below is the log with '-v'
> 
> 2024-12-03 11:20:32 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-af954f76eea56453713ae657f6812d4063f9bc57/tools/perf/perf test 121 -v
> 121: Test data symbol:
> --- start ---
> test child forked, pid 143127
>  294e400-294e439 l buf1
> perf does have symbol 'buf1'
> Recording workload...
> Waiting for "perf record has started" message
> /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-af954f76eea56453713ae657f6812d4063f9bc57/tools/perf/tests/shell/test_data_symbol.sh: line 74: kill: (143139) - No such process
> Cleaning up files...
> ---- end(-1) ----
> 121: Test data symbol                                                : FAILED!

Thanks for the log.  I think it failed to run perf mem record at all.

I've set up a Sapphire Rapids and run the test.  It said:

  # perf mem record -avv -C0 true
  DEBUGINFOD_URLS=
  nr_cblocks: 0
  affinity: SYS
  mmap flush: 1
  comp level: 0
  ------------------------------------------------------------
  perf_event_attr:
    type                             4 (cpu)
    size                             136
    config                           0x8203 (mem-loads-aux)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT
    read_format                      ID|LOST
    disabled                         1
    freq                             1
    precise_ip                       3
    sample_id_all                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
  ------------------------------------------------------------
  perf_event_attr:
    type                             4 (cpu)
    size                             136
    config                           0x1cd (mem-loads)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT
    read_format                      ID|LOST
    freq                             1
    precise_ip                       3
    sample_id_all                    1
    { bp_addr, config1 }             0x1f
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
  sys_perf_event_open failed, error -22
  Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu/mem-loads,ldlat=30/).
  "dmesg | grep -i perf" may provide additional information.

There's an issue with fallback on the inherit bit with the sample read.
I'll take a look.

Thanks,
Namhyung

