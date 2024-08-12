Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94B6CDBA;
	Mon, 12 Aug 2024 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482134; cv=none; b=S2xW6u4tSNIQs0e+51rBi079EGYL0+1u4VjU88PGzoIKNVR/K0XkJV4FQElfXSmF/rqpmBrjCEEoy2poGlK0zQ4KkgHvY2nf5r1mjtFnBoeLKnW2PxuJVts3/22+kg6uwAL+gRCgN47PdlcY2MppR3Qz2gcurMQbl+Cu+nZ7ulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482134; c=relaxed/simple;
	bh=LnvNoTAR8vjJ1LQByGVXDpVvDgNROHTS8ajYGW7bCaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sujGqJzSJdy2iitI9OmWD8joz28EjyfaS1dGRPW/GcW7BuKQD6+oV9aqwKlwOdcpZehnauSlJOO5rdspFOpt906bhpbFRzjgw8mliF1kwsjcTC75B0wEJzqfyLM5FvJ8KCnAFyuVecl6Gw0WFNOtoe/4Ywdjikv3U7ZfdhOcCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL9XYvoB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL9XYvoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595D3C4AF0F;
	Mon, 12 Aug 2024 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723482133;
	bh=LnvNoTAR8vjJ1LQByGVXDpVvDgNROHTS8ajYGW7bCaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DL9XYvoB4D52CaYOVnMuPXJJIlwQTSWd2DV7QJH2zL5jfeH0ytnnZ2C2rO6IBXz/A
	 IovGVTeRKrSUmqNPANX4WtEJ90V+dApqTym82IG1gjYKXx9WGywJPFH7R8VqyyT4yY
	 JEYWtab6BcNQMAOiOEsDQN/3zmYbBCh9AxGe3vq7ZDHaAOp3CuAUW7bx7ZaCqN+ECb
	 YKCnAqdmazSGSmsUruR3L/gNP2h0MwpDrGcwwk06RS8xXOG0lDBrpk5hejzXsClcdi
	 yw7eAkOMh8Zfory8uXA4qnqkNp24wYAv6qwG1l7JEuK+6GrEhgq1WzT1fLSLmGybsj
	 juJgUBi1iJrOg==
Date: Mon, 12 Aug 2024 14:02:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org,
	acme@redhat.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <ZrpAEnWa0M_HV1H3@x1>
References: <ZiqoWj3f-P3ChlWa@x1>
 <20240429085721.10122-1-vmolnaro@redhat.com>
 <alpine.LRH.2.20.2405211127360.4040@Diego>
 <ZroLGg6W9DKsexpp@x1>
 <ZroMXJoNXCsh2ghd@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZroMXJoNXCsh2ghd@x1>

On Mon, Aug 12, 2024 at 10:21:36AM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 12, 2024 at 10:16:10AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, May 21, 2024 at 11:27:56AM +0200, Michael Petlan wrote:
> > > On Mon, 29 Apr 2024, vmolnaro@redhat.com wrote:
> > > > From: Veronika Molnarova <vmolnaro@redhat.com>

> > > > Subtest for system-wide record with '--threads=cpu' option fails due
> > > > to a limit of open file descriptors on systems with 128 or more CPUs
> > > > as the default limit is set to 1024.

> > > > The number of open file descriptors should be slightly above
> > > > nmb_events*nmb_cpus + nmb_cpus(for perf.data.n) + 4*nmb_cpus(for pipes),
> > > > which equals 8*nmb_cpus. Therefore, temporarily raise the limit to
> > > > 16*nmb_cpus for the test.

> > > > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>

> > > Acked-by: Michael Petlan <mpetlan@redhat.com>

> > b4 got confused, I'll pick the rigth version manually...

Also please install ShellCheck, with it installed, as I do, you'll get
this warning, that we should address:

  CC      /tmp/build/perf-tools-next/util/synthetic-events.o

In tests/shell/record.sh line 24:
default_fd_limit=$(ulimit -n)
                          ^-- SC3045 (warning): In POSIX sh, ulimit -n is undefined.


In tests/shell/record.sh line 203:
if [[ $default_fd_limit -lt $min_fd_limit ]]; then
   ^-- SC3010 (warning): In POSIX sh, [[ ]] is undefined.


In tests/shell/record.sh line 204:
       ulimit -n $min_fd_limit
              ^-- SC3045 (warning): In POSIX sh, ulimit -n is undefined.


In tests/shell/record.sh line 214:
ulimit -n $default_fd_limit
       ^-- SC3045 (warning): In POSIX sh, ulimit -n is undefined.

For more information:
  https://www.shellcheck.net/wiki/SC3010 -- In POSIX sh, [[ ]] is undefined.
  https://www.shellcheck.net/wiki/SC3045 -- In POSIX sh, ulimit -n is undefin...
make[4]: *** [tests/Build:90: /tmp/build/perf-tools-next/tests/shell/record.sh.shellcheck_log] Error 1
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: tests] Error 2
make[2]: *** [Makefile.perf:777: /tmp/build/perf-tools-next/perf-test-in.o] Error 2
  CC      /tmp/build/perf-tools-next/util/data.o
make[2]: *** Waiting for unfinished jobs....

