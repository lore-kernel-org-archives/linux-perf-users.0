Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDAB667;
	Mon,  2 Dec 2024 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171538; cv=none; b=tP68ez5fyby7oIxSpLEjw4s31BTE0DrVXHOEF3Fi3B6AlMkLOGWa2D7WFVZJ+gfLV16Re7oJDEZJYcAql8uWRr1cmIVujjMCM1pCVAN9cOA22GzMbz9HP6IC0p4sbGvdnhY8C0DvKN46s8EmYPJLtbx00kO9tqw6PkDnioAlFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171538; c=relaxed/simple;
	bh=hjvqc3c12KRn51rb3VdSmYWNcmRjrZOff4t1bjmP+C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQtofRZ1xBzkOHip8NdXw/g9/ZZsbufS1CaZ2dMEhLOyd2k3K2/ubYq60wCGHSHfkcs54/hSJEhzDHL9Y0GoKAfeP399vSv1MWRL8WxbWIgYTJObMg/VpMxg4bDJ7hSgys43Ils7wDGPcsXetktQOvV78gHAm713Q5Pf6b6aaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFLIYKBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFLIYKBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC93C4CED1;
	Mon,  2 Dec 2024 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733171538;
	bh=hjvqc3c12KRn51rb3VdSmYWNcmRjrZOff4t1bjmP+C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFLIYKBug64GubPQJJRCwotXqXP0UGsKjb79n0IbeZUh/mAHv5p63raN4JpNlme+s
	 l+2kHEk0IN5pofJ12g9kiv9CMoqHG4AhKDghlvoRWIE7lSJjh9D/xAyXHIJxZUtYRx
	 gxD/sjZXpfvpns4hmdhdCgHGNpwn9JLcvlRGE1cypPDWjGhjQBVr9NdlIz3RF9SKjE
	 TCZFqscG6cEQB/3RQR6TJRqfZ0QpTTytTklQdmEcgkulzUeTZYHNCEMrskre9GrY0I
	 7OtIieewQSCPNArJUqLZagBdK4qXn58DHFzt7fagglB3ZPTsgfubroiHadm++sk/2g
	 keDxTKq0ULn8g==
Date: Mon, 2 Dec 2024 12:32:16 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
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
Message-ID: <Z04ZUHaGdsBapIEL@google.com>
References: <202411301431.799e5531-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202411301431.799e5531-lkp@intel.com>

Hello,

On Sat, Nov 30, 2024 at 03:03:10PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "perf-sanity-tests.Test_data_symbol.fail" on:
> 
> commit: af954f76eea56453713ae657f6812d4063f9bc57 ("perf tools: Check fallback error and order")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      7af08b57bcb9ebf78675c50069c54125c0a8b795]
> [test failed on linux-next/master f486c8aa16b8172f63bddc70116a0c897a7f3f02]
> 
> in testcase: perf-sanity-tests
> version: 
> with following parameters:
> 
> 	perf_compiler: gcc
> 
> 
> 
> config: x86_64-rhel-8.3-bpf
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202411301431.799e5531-lkp@intel.com
> 
> 
> 
> 2024-11-28 08:31:19 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-af954f76eea56453713ae657f6812d4063f9bc57/tools/perf/perf test 121
> 121: Test data symbol                                                : FAILED!

Thanks for the report.  But I have a request.

Can you please run the perf test with -v option so that we can see the
detailed error messages when it failed?

Thanks,
Namhyung

> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241130/202411301431.799e5531-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
