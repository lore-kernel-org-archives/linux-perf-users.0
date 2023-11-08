Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC1374D5;
	Wed,  8 Nov 2023 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPbQ2L6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD49C433C9;
	Wed,  8 Nov 2023 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699477841;
	bh=4V4gwYzW6WrEDZYZ4cGclrG2pSCRVMcxcKoOTJdlYiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPbQ2L6OVN3Ugh1UvF/H67QH7+FycLOWs+ctKmBklhhpSfhBqyuEFwYzWWjMKtQQo
	 Tzl44I0vyemwrrjjUFb4WBeyJlEIYkjHrr9ftY1+w2vYFANt2rtBY+6wLI7SXBBN0V
	 6d6naAvdvhub7WNzYSzwn+42X8cfXuMFdrK4E6ukABCncwLaxMng+aSGeAIVHwzu9A
	 arfzO5BLqIft0lbRAnaAD9BF96qMbyvkI3cJtBvbVQ3H7s109BundsBBz0eA2N0IRB
	 iQ7oUNRgltKt1HgdxfflWfEMO38hR4YxwMOvtFFVlWzdLj/QoSUnwQ1Q9SMu2gs9N4
	 yFz7kOQtx8ogg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 2260B40094; Wed,  8 Nov 2023 18:10:39 -0300 (-03)
Date: Wed, 8 Nov 2023 18:10:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Yonghong Song <yhs@fb.com>,
	Fangrui Song <maskray@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] perf test: Add support for setting objdump binary
 via perf config
Message-ID: <ZUv5T0moQara4CId@kernel.org>
References: <20231106151051.129440-1-james.clark@arm.com>
 <20231106151051.129440-3-james.clark@arm.com>
 <ZUv1TgveArYdvTsl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUv1TgveArYdvTsl@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 08, 2023 at 05:53:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 06, 2023 at 03:10:49PM +0000, James Clark escreveu:
> > Add a perf config variable that does the same thing as "perf test
> > --objdump <x>".
> > 
> > Also update the man page.
> 
> That is ok, if one wants to change objdump just for testing, as a
> followup improvement it may be interesting to allow that for the other
> tools that have --objdump as well as to add this as a global option,
> that affects all tools, no?
> 
> Anyway, applied both patches.

And added this to the last one:

Committer testing:

  # perf config test.objdump
  # perf test "object code reading"
   26: Object code reading                                             : Ok
  # perf config test.objdump=blah
  # perf config test.objdump
  test.objdump=blah
  # perf test "object code reading"
   26: Object code reading                                             : FAILED!
  # perf test -v "object code reading"
   26: Object code reading                                             :
  --- start ---
  test child forked, pid 600599
  Looking at the vmlinux_path (8 entries long)
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
  Parsing event 'cycles'
  Using CPUID AuthenticAMD-25-21-0
  mmap size 528384B
  Reading object code for memory address: 0x4d9a02
  File is: /home/acme/bin/perf
  On file address is: 0xd9a02
  Objdump command is: blah -z -d --start-address=0x4d9a02 --stop-address=0x4d9a82 /home/acme/bin/perf
  objdump read too few bytes: 128
  Bytes read differ from those read by objdump
  buf1 (dso):
  0x48 0x85 0xff 0x74 0x29 0xe8 0x94 0xdf 0x07 0x00 0x8b 0x73 0x1c 0x48 0x8b 0x43 
  0x08 0xeb 0xa5 0x0f 0x1f 0x00 0x48 0x8b 0x45 0xe8 0x64 0x48 0x2b 0x04 0x25 0x28 
  0x00 0x00 0x00 0x75 0x0f 0x48 0x8b 0x5d 0xf8 0xc9 0xc3 0x0f 0x1f 0x00 0x48 0x8b 
  0x43 0x08 0xeb 0x84 0xe8 0xc5 0x3e 0xf3 0xff 0x0f 0x1f 0x44 0x00 0x00 0x55 0x48 
  0x89 0xe5 0x41 0x56 0x41 0x55 0x49 0x89 0xd5 0x41 0x54 0x49 0x89 0xfc 0x53 0x48 
  0x89 0xf3 0x48 0x83 0xec 0x30 0x48 0x8b 0x7e 0x20 0x64 0x48 0x8b 0x04 0x25 0x28 
  0x00 0x00 0x00 0x48 0x89 0x45 0xd8 0x31 0xc0 0x48 0x89 0x75 0xb0 0x48 0xc7 0x45 
  0xb8 0x00 0x00 0x00 0x00 0x48 0xc7 0x45 0xc0 0x00 0x00 0x00 0x00 0xe8 0xad 0xfa 
  
  buf2 (objdump):
  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
  
  test child finished with -1
  ---- end ----
  Object code reading: FAILED!
  # perf config test.objdump=/usr/bin/objdump
  # perf config test.objdump
  test.objdump=/usr/bin/objdump
  # perf test "object code reading"
   26: Object code reading                                             : Ok
  #

Signed-off-by: James Clark <james.clark@arm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
