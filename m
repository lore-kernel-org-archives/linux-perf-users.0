Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764A91B395F;
	Fri, 15 Nov 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683489; cv=none; b=rpmVVhoCHIhdfWwcIe7ATkdkTpnevKSG6039h9reUa+g0iXurbHjbeujuOees4nh5yUGrUA2Tlto8zSW3ALp2W5Q6wjb7GM1J5yvqUix8T7k1sZAjOKPzjhpbzxuCYYmcrQZi45NEbaCl405cg6J7Qu2/JOOecOKJulRj08d5yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683489; c=relaxed/simple;
	bh=if44ysNZmw/vKZZ6rIpvWKZdiZAVyyynGblPrzRYVCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmQpicc28LwmMVAuTjbZnqV5vR53DMhxY5i8FA539DT0EhGXq7wgVvKWotsCrhUTcHRTadqWngZzITpBWVnBdbpvINL2r8vDPKiFFcUbupXxqV5zsxIsgYnH0aPOI1wXfMAb42GWPt/wZ8JjzDe2DNPkpN8Zf0L9ZfpqldgF+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgazKs+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgazKs+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E99C4CECF;
	Fri, 15 Nov 2024 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731683489;
	bh=if44ysNZmw/vKZZ6rIpvWKZdiZAVyyynGblPrzRYVCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgazKs+q4c9f+hlscvjGUrCPlJYGHUU37ZQZb8YDgjCzdHEVdARJHgTfXJHXba8b5
	 EXfO4OMsQTMW/hQY9Mx8vJTHkt+VnkBFEO88YHFNtc9AESB+b/bJXAiFCA7mPlCaCP
	 8hHsEVbSP9mEMeBQcAghetLwunk3sg1LTkrA+5HGIBePQJMUQzkO52YUBkTxyyh3sL
	 9+DXfI8aIRoGj9X67jIB9l+o+p2laKmfdVpPDbYU8gc0vaZADlT8Cl/UHNYS4KJt92
	 cYGaKOrSiONSrC2HHBrvI9SxUbrxm/4Q340Sv8+lf7r3DE1q73d6fNVZljSrePw095
	 r52aL1IkaB4hA==
Date: Fri, 15 Nov 2024 12:11:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Benjamin Peterson <benjamin@engflow.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf tests shell trace_exit_race: Show what went
 wrong in verbose mode
Message-ID: <ZzdknoHqrJbojb6P@x1>
References: <ZzZpX5O053UsHmsV@x1>
 <CAH0uvohi_8_itv+jDjCEvrprakhp5w7=GvWw+hJG4gTLwJQjog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohi_8_itv+jDjCEvrprakhp5w7=GvWw+hJG4gTLwJQjog@mail.gmail.com>

On Fri, Nov 15, 2024 at 01:32:15AM -0800, Howard Chu wrote:
> On Thu, Nov 14, 2024 at 1:19 PM <arnaldo.melo@gmail.com> wrote:
> > This is in the tmp.perf-tools-next  branch at:

> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

> > I'll later add another patch adding the --no-comm to the 'perf trace'
> > command line and will adjust the regexp.

> > If it fails we need to check what was the reason, what were the lines
> > that didn't match the expected format, so:
> >
> >   root@number:~# perf test -v "trace exit race"
> >   --- start ---
> >   test child forked, pid 2028724
> >   Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$':
> >        0.000 :2028750/2028750 syscalls:sys_enter_exit_group()
 
> This output looks good but I got an empty grep -v:
 
> perf $ ./perf test 110 -v
> 110: perf trace exit race                                            :
> Running (1
> --- start ---
> test child forked, pid 3865874
> Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+
> syscalls:sys_enter_exit_group\(\)$':
> ---- end(-1) ----
> 110: perf trace exit race                                            : FAILED!
 
> In temp file:
> 0.000 true/3867219 syscalls:sys_enter_exit_group()
> 0.000 true/3867221 syscalls:sys_enter_exit_group()
> 0.000 true/3867223 syscalls:sys_enter_exit_group()
> 0.000 true/3867226 syscalls:sys_enter_exit_group()
> 0.000 true/3867250 syscalls:sys_enter_exit_group()
> 0.000 true/3867252 syscalls:sys_enter_exit_group()
> 0.000 true/3867255 syscalls:sys_enter_exit_group()
> 0.000 true/3867257 syscalls:sys_enter_exit_group()
> 0.000 true/3867259 syscalls:sys_enter_exit_group()
> 0.000 true/3867262 syscalls:sys_enter_exit_group()
> 
> There are 10 lines of output which match the regex (I got the comm
> instead of pid), but it still falls into error, and inverse regex got
> nothing because they are all right.

You're right, I got confused with the other problem, namely in my case
some failures due to non-COMM resolution which ended up showing a few
that are not matching, so I thought it was about that.

Also at some point ShellCheck complained about some quoting and I ended
up adding that thinko, well spotted!

So with:

⬢ [acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
index ce05d4e6e7133cd1..2e5581f550c50d16 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -21,7 +21,7 @@ trace_shutdown_race() {
        for _ in $(seq 10); do
                perf trace -e syscalls:sys_enter_exit_group true 2>>$file
        done
-       [ "$(grep -c -E '$regexp' $file)" = "10" ]
+       [ "$(grep -c -E "$regexp" $file)" = "10" ]
 }
 
 
@@ -39,5 +39,5 @@ if [ $err != 0 ] && [ "${verbose}" = "1" ]; then
        grep -v -E "$regexp" $file
 fi
 
-rm -f ${file}
+echo rm -f ${file}
 exit $err
⬢ [acme@toolbox perf-tools-next]$

I'm getting what you're getting:

root@number:~# perf test -v "trace exit race"
--- start ---
test child forked, pid 12139
Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$':
     0.000 :12161/12161 syscalls:sys_enter_exit_group()
     0.000 :12167/12167 syscalls:sys_enter_exit_group()
rm -f /tmp/temporary_file.v7REF
---- end(-1) ----
110: perf trace exit race                                            : FAILED!
root@number:~# cat /tmp/temporary_file.v7REF
     0.000 true/12147 syscalls:sys_enter_exit_group()
     0.000 true/12151 syscalls:sys_enter_exit_group()
     0.000 true/12153 syscalls:sys_enter_exit_group()
     0.000 true/12155 syscalls:sys_enter_exit_group()
     0.000 true/12157 syscalls:sys_enter_exit_group()
     0.000 true/12159 syscalls:sys_enter_exit_group()
     0.000 :12161/12161 syscalls:sys_enter_exit_group()
     0.000 true/12163 syscalls:sys_enter_exit_group()
     0.000 true/12165 syscalls:sys_enter_exit_group()
     0.000 :12167/12167 syscalls:sys_enter_exit_group()
root@number:~# grep -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' /tmp/temporary_file.v7REF
     0.000 true/12147 syscalls:sys_enter_exit_group()
     0.000 true/12151 syscalls:sys_enter_exit_group()
     0.000 true/12153 syscalls:sys_enter_exit_group()
     0.000 true/12155 syscalls:sys_enter_exit_group()
     0.000 true/12157 syscalls:sys_enter_exit_group()
     0.000 true/12159 syscalls:sys_enter_exit_group()
     0.000 true/12163 syscalls:sys_enter_exit_group()
     0.000 true/12165 syscalls:sys_enter_exit_group()
root@number:~# grep -v -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' /tmp/temporary_file.v7REF
     0.000 :12161/12161 syscalls:sys_enter_exit_group()
     0.000 :12167/12167 syscalls:sys_enter_exit_group()
root@number:~# git difroot@number:~# perf test -v "trace exit race"
--- start ---
test child forked, pid 12139
Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$':
     0.000 :12161/12161 syscalls:sys_enter_exit_group()
     0.000 :12167/12167 syscalls:sys_enter_exit_group()
rm -f /tmp/temporary_file.v7REF
---- end(-1) ----
110: perf trace exit race                                            : FAILED!
root@number:~# cat /tmp/temporary_file.v7REF
     0.000 true/12147 syscalls:sys_enter_exit_group()
     0.000 true/12151 syscalls:sys_enter_exit_group()
     0.000 true/12153 syscalls:sys_enter_exit_group()
     0.000 true/12155 syscalls:sys_enter_exit_group()
     0.000 true/12157 syscalls:sys_enter_exit_group()
     0.000 true/12159 syscalls:sys_enter_exit_group()
     0.000 :12161/12161 syscalls:sys_enter_exit_group()
     0.000 true/12163 syscalls:sys_enter_exit_group()
     0.000 true/12165 syscalls:sys_enter_exit_group()
     0.000 :12167/12167 syscalls:sys_enter_exit_group()
root@number:~# grep -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' /tmp/temporary_file.v7REF
     0.000 true/12147 syscalls:sys_enter_exit_group()
     0.000 true/12151 syscalls:sys_enter_exit_group()
     0.000 true/12153 syscalls:sys_enter_exit_group()
     0.000 true/12155 syscalls:sys_enter_exit_group()
     0.000 true/12157 syscalls:sys_enter_exit_group()
     0.000 true/12159 syscalls:sys_enter_exit_group()
     0.000 true/12163 syscalls:sys_enter_exit_group()
     0.000 true/12165 syscalls:sys_enter_exit_group()
root@number:~# grep -v -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' /tmp/temporary_file.v7REF
     0.000 :12161/12161 syscalls:sys_enter_exit_group()
     0.000 :12167/12167 syscalls:sys_enter_exit_group()
root@number:~# git diff
 
> >   ---- end(-1) ----
> >   110: perf trace exit race                                            : FAILED!
> >   root@number:~#
> >
> > In this case we're not resolving the process COMM for some reason and
> > fallback to printing just the pid/tid, this will be fixed in a followup
> > patch.
> > -       [ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' $file)" = "10" ]
> > +       [ "$(grep -c -E '$regexp' $file)" = "10" ]
> 
> shouldn't this be
> [ "$(grep -c -E "$regexp" $file)" = "10" ]
> ?
> 
> In shell script single quote doesn't interpolate, in this case you are
> literally grepping the string "$regexp". After changing this to double
> quotes it works for me.

Right, see above.
 
> >  err=$?
> > +
> > +if [ $err != 0 ] && [ "${verbose}" = "1" ]; then
> > +       echo "Lines not matching the expected regexp: '$regexp':"
 
> Also, I think there is a case, where $err != 0 can come from not
> having 10 matches, say 4 (because of racing), and these 4 can all be
> correct, the inverse grep -v won't match anything, results in an empty
> output as above:

Right again,
 
> Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+
> syscalls:sys_enter_exit_group\(\)$':
> ---- end(-1) ----
> 
> > +       grep -v -E "$regexp" $file
> > +fi
> > +
> >  rm -f ${file}
> >  exit $err
> > --
> > 2.47.0
> >
> 
> Maybe this? (based on your test)
> 
> +++ b/tools/perf/tests/shell/trace_exit_race.sh
> @@ -16,12 +16,15 @@ if [ "$1" = "-v" ]; then
>  fi
> 
>  regexp=" +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$"
> +iter=15
> 
>  trace_shutdown_race() {
> -        for _ in $(seq 10); do
> +        for _ in $(seq $iter); do
>                  perf trace -e syscalls:sys_enter_exit_group true 2>>$file
>          done
> -        [ "$(grep -c -E '$regexp' $file)" = "10" ]
> +
> +        result="$(grep -c -E "$regexp" $file)"
> +        [ $result = $iter ]
>  }
> 
> 
> @@ -35,8 +38,12 @@ trace_shutdown_race
>  err=$?
> 
>  if [ $err != 0 ] && [ "${verbose}" = "1" ]; then
> -        echo "Lines not matching the expected regexp: '$regexp':"
> -        grep -v -E "$regexp" $file
> +        if grep -q -v -E "$regexp" $file; then
> +                echo "Lines not matching the expected regexp: '$regexp':"
> +                grep -v -E "$regexp" $file
> +        else
> +                echo "Missing output, expected $iter but only got $result"
> +        fi
>  fi
> 
>  rm -f ${file}
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>

Please see if you keep it, I ended up applying the slight variation
below, to avoid an repeating the last inverse grep.

Thanks a lot for reviewing and spotting that st00pid problem and
suggesting the improvement for the inverse grep!

- Arnaldo

diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
index ce05d4e6e7133cd1..8ea24f4256bc8f5e 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -15,13 +15,15 @@ if [ "$1" = "-v" ]; then
 	verbose="1"
 fi
 
+iter=10
 regexp=" +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$"
 
 trace_shutdown_race() {
-	for _ in $(seq 10); do
+	for _ in $(seq $iter); do
 		perf trace -e syscalls:sys_enter_exit_group true 2>>$file
 	done
-	[ "$(grep -c -E '$regexp' $file)" = "10" ]
+	result="$(grep -c -E "$regexp" $file)"
+	[ $result = $iter ]
 }
 
 
@@ -35,8 +37,14 @@ trace_shutdown_race
 err=$?
 
 if [ $err != 0 ] && [ "${verbose}" = "1" ]; then
-	echo "Lines not matching the expected regexp: '$regexp':"
-	grep -v -E "$regexp" $file
+	lines_not_matching=$(mktemp /tmp/temporary_file.XXXXX)
+	if grep -v -E "$regexp" $file > $lines_not_matching ; then
+		echo "Lines not matching the expected regexp: '$regexp':"
+		cat $lines_not_matching
+	else
+		echo "Missing output, expected $iter but only got $result"
+	fi
+	rm -f $lines_not_matching
 fi
 
 rm -f ${file}


