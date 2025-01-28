Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F31DC9BE;
	Tue, 28 Jan 2025 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087309; cv=none; b=AmMk2ar3GsHw27cPBygUT3bdYNGzmAuRT+r34IRnY6jnlTdNW1mDT9P0jh+eEyBFfeWeK4NsFpN8ui6dR2BmFj2f152d9r8Q5T62/l39RRySYzS2b44hxmW3HZCR9iTHGtSOvOEN0YqEK91xe6XFODHK0FEVUrL48gZICn1Jj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087309; c=relaxed/simple;
	bh=Kci2aTC+u4P3mWfTrxCfq2pDPZGYJ+hsRCt7DgJM07I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0g4TqJptGpss6Fm4iBMIn/IzmmUjFjcnGm8YaRurcGJIZIAFWq9znyFrQjracMORo1SenMGQ1HTiy0B9SAbhXMVqsfae6Y32u7EBM3fC+HejCWAM6XzPGqZE1vxDvRO1zQ2hzolWpgQk5ol4gaWdMX1L8k5g+1qooZE6QC4Vz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEGv/4dC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEGv/4dC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB705C4CED3;
	Tue, 28 Jan 2025 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738087309;
	bh=Kci2aTC+u4P3mWfTrxCfq2pDPZGYJ+hsRCt7DgJM07I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEGv/4dCd65pBPla3oeUNdtH6M6VSn3TbrdI1qi/UykIpHc8IwFQUu0nSOaTOKaJH
	 Y/3Q+UVrg15YcOVRtZYBrCxurnzVc6Yisjcq1O7hYeNx+PJx3Tl8xpZoCqozPk19uS
	 ytJXjHAw69m0adcQSR5iib2xTAPESsG7l+ahhDIDsuCb+puklxuU86miNm0wLiE105
	 QTZtoASQxKzLDl5OROJLYffyWt+h3so+B+rQJ07vvlbFLWC+CoOdSGO26T2NKD7bEL
	 0Kquu1XwS7d8K73xYrutpzwy3RkRNSZ5gW7LqmjO8Pk4jdoJnWi1NnJ3v/EGPbJ8t+
	 5pUjoZ8+6k6Xw==
Date: Tue, 28 Jan 2025 10:01:47 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>, acme@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix failing test case Session Topology
Message-ID: <Z5kbi0w5rH414jI_@google.com>
References: <20250128130647.4029185-1-tmricht@linux.ibm.com>
 <CAP-5=fVbZGnRcRbAc+kQyKn5aKdpWkSzVemERpiV2kncxnQ6pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVbZGnRcRbAc+kQyKn5aKdpWkSzVemERpiV2kncxnQ6pg@mail.gmail.com>

Hello,

On Tue, Jan 28, 2025 at 09:07:22AM -0800, Ian Rogers wrote:
> On Tue, Jan 28, 2025 at 5:07 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Test case 37 Session topology fails on s390. I bisected this to
> >
> > commit 05be17eed774 ("tool api fs: Correctly encode errno for read/write open failures")
> >
> > When perf tool is invoked, it builds the perf.data file using the
> > following function sequence:
> >
> >   #0  has_die_topology () at util/cputopo.c:223
> >   #1  cpu_topology__new () at util/cputopo.c:302
> >   ....
> >   #9  0x00000000012a5c7a in perf_session__write_header (...)
> >         at util/header.c:3774
> >   #10 0x00000000011ccd64 in session_write_header (...)
> >         at tests/topology.c:53
> >   #11 0x00000000011cde9c in test__session_topology (...)
> >         at tests/topology.c:215
> >   #12 0x0000000001190276 in start_test (...)
> >
> > The function has_die_topology() checks for existence of sys file
> > /sys/devices/system/cpu/cpu0/topology/die_cpus_list
> > which does not exist on s390. This function returns false and
> > information for all CPU dies is omitted in the
> > perf data file section HEADER_CPU_TOPOLOGY.
> >
> > Later on the test case reads the perf.data file back using
> > functions.
> >
> >   check_cpu_topology()
> >   +--> perf_session__new()
> >
> > the missing CPU die information in the HEADER_CPU_TOPOLOGY section
> > causes the id_die field set to 0 in the session->header.env.cpu[0].
> >
> > Later on when the test case result is verified, the functions
> >
> >   test__session_topology()
> >   +--> check_cpu_topology()
> >        +--> aggr_cpu_id__cpu()
> >             +--> aggr_cpu_id__core()
> >                  +--> aggr_cpu_id__cluster()
> >                       +--> aggr_cpu_id__die()
> >                            +--> cpu__get_topology_int()
> >                                 +--> sysfs__read_int()
> >
> > Function aggr_cpu_id__die() reads the die_id from the CPU's
> > /sys/devices/system/cpu/cpu0/topology/die_id file entry.
> > This file does not exist and function
> > sysfs__read_int() now returns error number -2 (ENOENT).
> > Structure member id.die has value of -2.
> >
> > This new return value of -2 bypasses this check in function
> > aggr_cpu_id__die():
> >
> >         /* There is no die_id on legacy system. */
> >         if (die == -1)
> >                 die = 0;
> > and the test verification fails in:
> >
> >   TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
> >         session->header.env.cpu[cpu.cpu].die_id == id.die)
> >
> > Output before:
> >  # ./perf test -F 37
> >  37: Session topology               : FAILED!
> >  #
> >
> > Output after:
> >  # ./perf test -F 37
> >  37: Session topology               : Ok
> >  #
> >
> > Fixes: 05be17eed774 ("tool api fs: Correctly encode errno for read/write open failures")
> > Cc: Ian Rogers <irogers@google.com>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> Thanks Thomas, there is also James' patch which I think is equivalent:
> https://lore.kernel.org/linux-perf-users/20241218115552.912517-1-james.clark@linaro.org/

Oh, I thought it's already merged.  Will add it to perf-tools soon.


> and my longer series:
> https://lore.kernel.org/lkml/20241216232459.427642-1-irogers@google.com/
> which is what I'm carrying in Googe's tree, although James suggested
> corrections.

Please send a new verion with updates.

Thanks,
Namhyung

