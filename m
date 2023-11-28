Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798636C
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBtQ9xbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A4FC433C8;
	Tue, 28 Nov 2023 00:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701132484;
	bh=rWkxJ6IcyviVAp9PF8CpLDKPseHgpWh9B3/hZ3BcgVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBtQ9xbg4WqeloNr38BAuZF/FrWncf/3bkKiVz61Lcf3INQgqpn8l0gHrphNVcnS1
	 FqLq7/UgqIJCB2LtKqdzjSpHYFsTIr+uaRmFYXscaW/2Su1kRNeUux6naUuWNiT1N3
	 7SyHKRKgwv48E4qM0JGOWzdg+jwpXRMHvhsoA48Sq1E6Xc8HmPe9roJZ65f9JDdPS6
	 9pOaXFZ3plP+E6OBW+irLzNzaIdUn9MtHBiuY0bY+DVvh4Q8ci2yOiUYriQ3Pjk/yb
	 VY0lslPMvHCcIx3uYPaJ1aElh/1ark1fBThHAdFffZej7rfBSvrlU8ZQH9vMkyYOuw
	 6IKs1LrhVB6Pg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id BF97540094; Mon, 27 Nov 2023 21:48:01 -0300 (-03)
Date: Mon, 27 Nov 2023 21:48:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ming Wang <wangming01@loongson.cn>,
	James Clark <james.clark@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Leo Yan <leo.yan@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	German Gomez <german.gomez@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
	Sandipan Das <sandipan.das@amd.com>,
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 01/53] perf comm: Use regular mutex
Message-ID: <ZWU4wZcMj77p8tyz@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-2-irogers@google.com>
 <CAM9d7cgbPGzgc=QG8dStvq1iX8snGyeKTJDrg2XBjX0pCX9Qtg@mail.gmail.com>
 <ZWUPz6ETFEBsrDkZ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWUPz6ETFEBsrDkZ@kernel.org>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 27, 2023 at 06:53:19PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Nov 05, 2023 at 09:31:47AM -0800, Namhyung Kim escreveu:
> > Hi Ian,
> > 
> > On Thu, Nov 2, 2023 at 10:58 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > The rwsem is only after used for writing so switch to a mutex that has
> > > better error checking.
> > 
> > Hmm.. ok.  It doesn't make sense to use rwsem without readers.
> 
> Well, the only reader is a findnew method, that will primarily read,
> but possibly write if it doesn't find it there, so converting to a
> regular mutex seems sensible.

To be fixed tomorrow:

   3    32.71 alpine:3.15                   : FAIL gcc version 10.3.1 20211027 (Alpine 10.3.1_git20211027)
    util/comm.c:20:46: error: 'PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP' undeclared here (not in a function)
       20 | static struct mutex comm_str_lock = {.lock = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,};
          |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2
   4    32.17 alpine:3.16                   : FAIL gcc version 11.2.1 20220219 (Alpine 11.2.1_git20220219)
    util/comm.c:20:46: error: 'PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP' undeclared here (not in a function)
       20 | static struct mutex comm_str_lock = {.lock = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,};
          |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2
   5    25.82 alpine:3.17                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4)
    util/comm.c:20:46: error: 'PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP' undeclared here (not in a function)
       20 | static struct mutex comm_str_lock = {.lock = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,};
          |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2
   6    26.64 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10)
    util/comm.c:20:46: error: 'PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP' undeclared here (not in a function)
       20 | static struct mutex comm_str_lock = {.lock = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,};
          |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2
   7    29.66 alpine:edge                   : FAIL gcc version 13.1.1 20230722 (Alpine 13.1.1_git20230722)
    util/comm.c:20:46: error: 'PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP' undeclared here (not in a function)
       20 | static struct mutex comm_str_lock = {.lock = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,};
          |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2


 I.e. doesn't play well with musl libc.

 - Arnaldo
