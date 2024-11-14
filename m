Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9B1AC88A;
	Thu, 14 Nov 2024 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617417; cv=none; b=lEtJH+jiOSwx5A9ruU8e4kAYZU3kvTmjqUIiU+g3scEClh5K5bLP5PmY40whon4/gtCqYSobTwp7Z03vrDPsvdGRnFdLNVVXLmuJUMtulMylPTFw+biQml5P586dNHKBpLv3P3UkDkfVN57tKBXlWk0UhH6wLMNI1JmIBJAQW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617417; c=relaxed/simple;
	bh=sV6IFGZijGhIv7ZE2nCehV0lyPR9/22ZR/Dm7DrXThE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2g/HxOrUV/l7MOJvI1S3ZJ44gJBcXY3zGiSDJobLEtRNFpVd6DsqQuxuvGvTft5TodfBznscaKZf8umspYWj2DsCI0GGc4tWNvsUHsn62GRDeovvyPas5EPTRj51EZl54KMW2z0vy5y5IUAUKFV9AfIhWZ24XIRij0hF2w0Oeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds4kDnaZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds4kDnaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D77C4CECD;
	Thu, 14 Nov 2024 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731617417;
	bh=sV6IFGZijGhIv7ZE2nCehV0lyPR9/22ZR/Dm7DrXThE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ds4kDnaZtsvwVp5UeQ0ktd6dFpvdc0wxyQtY1rA/zYJp+Km/eGyj4bamcwpq8aZjv
	 rRKHLK20ZokRAE0oO7H5w/HmNM6Cg5qt8HDytcP6N8sZ3Gw+NUt0kws9YtFW6H3nf2
	 5F73BF0I7YCsnP1gv6EH2JcbP8ZFhcy/vLx65qy9ay/+phj/QY1GEPde3P7W/dYJ/m
	 8+7RCFjcR78V7VI7HAE1RPBbwLDLEysbaEBN77ZUBAenFsN4Oh2UQGrOxo3IoQJBoq
	 4XP0D1wcayrvjxD11qOc+jMAovzja11vufmEvU4xblYUJ9SiquNIC9cnF861h6TDA+
	 sx0QVxsCQ35ew==
Date: Thu, 14 Nov 2024 17:50:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] perf tests: add test for trace output loss
Message-ID: <ZzZihs9AvoaJeerD@x1>
References: <20241106234518.115234-1-benjamin@engflow.com>
 <20241106234518.115234-2-benjamin@engflow.com>
 <ZzY1bPtoyRH-nRIV@x1>
 <ZzY20vZluj44w1Gt@x1>
 <CAEmfU+v8KR3Bd8w7kOX6ScGig106zh5gW9P5fwAw-BF3tmAp7A@mail.gmail.com>
 <ZzZY7U0AFk3245vy@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzZY7U0AFk3245vy@x1>

On Thu, Nov 14, 2024 at 05:09:17PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 14, 2024 at 09:44:56AM -0800, Benjamin Peterson wrote:
> > > On Thu, Nov 14, 2024 at 02:37:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > > diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
> > > index 8b70324bc5b4fb4c..c37ed6bb9f7e8fab 100755
> > > --- a/tools/perf/tests/shell/trace_exit_race.sh
> > > +++ b/tools/perf/tests/shell/trace_exit_race.sh
> > > @@ -12,10 +12,10 @@
> > >  skip_if_no_perf_trace || exit 2
> 
> > >  trace_shutdown_race() {
> > > -       for i in $(seq 100); do
> > > +       for _ in $(seq 100); do
> > >                 perf trace -e syscalls:sys_enter_exit_group true 2>>$file
> > >         done
> > > -       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$" $file) = "100" ]
> > > +       [ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' $file)" = "100" ]
> > >  }
>  
> > This all looks okay.
> 
> The test is failing for me as there is garbage in the output of perf
> trace even with Namhyung having already applied your previous patch:
> 
> ⬢ [acme@toolbox perf-tools-next]$ git log --oneline --author benjamin@engflow.com
> 12bd434f68ea45c7 (HEAD -> perf-tools-next) perf tests: Add test for 'perf trace' output loss
> efbcd2cd7eac10a9 perf trace: Do not lose last events in a race
> 5fb8e56542a3cf46 (perf-tools-next/tmp.perf-tools-next) perf trace: avoid garbage when not printing a trace event's arguments
> ⬢ [acme@toolbox perf-tools-next]$
> 
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982428 syscalls:sys_enter_exit_group( k?m)
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982430 syscalls:sys_enter_exit_group()
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982432 syscalls:sys_enter_exit_group()
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982434 syscalls:sys_enter_exit_group()
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982437 syscalls:sys_enter_exit_group( k�)
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982439 syscalls:sys_enter_exit_group(, loads 8��1)
> root@number:~#
> 
> So we don't _miss_ the events, which I was noticing and brought me to
> test your latest 2 patches, which I applied and added a Tested-by, now
> tryint to figure out this garbage...

So, I fixed it with this simple patch:

And then, after adding this patch to the 'perf test' for the exit race
that you contributed:

⬢ [acme@toolbox perf-tools-next]$ git diff tools/perf/tests/
diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
index c37ed6bb9f7e8fab..2eb39abaadffc344 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -11,11 +11,17 @@
 
 skip_if_no_perf_trace || exit 2
 
+if [ "$1" = "-v" ]; then
+        verbose="1"
+fi
+
+regexp=" +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$"
+
 trace_shutdown_race() {
        for _ in $(seq 100); do
                perf trace -e syscalls:sys_enter_exit_group true 2>>$file
        done
-       [ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' $file)" = "100" ]
+       [ "$(grep -c -E '$regexp' $file)" = "100" ]
 }
 
 
@@ -27,5 +33,11 @@ export PERF_CONFIG=/dev/null
 
 trace_shutdown_race
 err=$?
+
+if [ $err != 0 ] && [ "${verbose}" = "1" ]; then
+       echo "Lines not matching the expected regexp: '$regexp':"
+       grep -v -E "$regexp" $file
+fi
+
 rm -f ${file}
 exit $err
⬢ [acme@toolbox perf-tools-next]

⬢ [acme@toolbox perf-tools-next]$ git diff tools/perf/builtin-trace.c
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ca5c3f5d6c389427..0834a11940c18f05 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2405,6 +2405,9 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
                }
        }
 
+       if (printed == 0)
+               bf[0] = '\0';
+
        return printed;
 }
 
⬢ [acme@toolbox perf-tools-next]$

The test still fails but for another reason:

root@number:~# perf test -v "trace exit race"
--- start ---
test child forked, pid 2002298
Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$':
     0.000 :2002317/2002317 syscalls:sys_enter_exit_group()
     0.000 :2002319/2002319 syscalls:sys_enter_exit_group()
     0.000 :2002353/2002353 syscalls:sys_enter_exit_group()
     0.000 :2002357/2002357 syscalls:sys_enter_exit_group()
     0.000 :2002376/2002376 syscalls:sys_enter_exit_group()
     0.000 :2002378/2002378 syscalls:sys_enter_exit_group()
     0.000 :2002393/2002393 syscalls:sys_enter_exit_group()
     0.000 :2002444/2002444 syscalls:sys_enter_exit_group()
     0.000 :2002491/2002491 syscalls:sys_enter_exit_group()
     0.000 :2002503/2002503 syscalls:sys_enter_exit_group()
---- end(-1) ----
110: perf trace exit race                                            : FAILED!
root@number:~# 

Somehow we're missing the PERF_RECORD_COMM or racing to get it from
/proc for those processes and thus we end up printing just the pid/ppid

Since what we are testing here is garbage when printing the argument
list, we can just disable comm printing and get consistent results:

root@number:~# perf trace --no-comm -e syscalls:sys_enter_exit_group true
     0.000 2003312 syscalls:sys_enter_exit_group()
root@number:~#

I'll take this route and sent a patch series.

- Arnaldo
