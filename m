Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D48BA45;
	Tue, 10 Sep 2024 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999885; cv=none; b=hqJxB0SaXpWylLKSYlWNz1gweVktnOjR8CK5ciwD4KyogEzmINAoYJpCjI5UnOujUXfN9/HTNIh2FoS5OemjJwZ+TSvH2G3R++JcYMjF3SNYGQeMTMfzldGr9mW+mco9FRVzBYQoATykLh/K7FzYYdlFKlWuaUtRtTeBg0Pl/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999885; c=relaxed/simple;
	bh=H/452oiqSmDz8a2IpeILUC/AnUUnSvtrWbH1Rskmm3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt3s7X6qvqNqwt2EKtDvDrIZcR78No85ezu3kFDT67Y98i8XVqy2f4MCSSbnwnuhFH85nzmWMW8mdDk97SC0/difS3l0CPhrgpFbraWUpW3y1n0xlGiQM/2+K9f2fuf2Dk0FNfGK++BuXUcbu2XTm3rhDVPnnD7VGEB76dqJVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJbsDur/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJbsDur/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697BAC4CEC3;
	Tue, 10 Sep 2024 20:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725999884;
	bh=H/452oiqSmDz8a2IpeILUC/AnUUnSvtrWbH1Rskmm3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJbsDur/hR3fmPyaD8IMYtQHD10aCIshAuDCVJGFmeyTgH/KCqZxrnlDdd+VDBy7j
	 yqTtuW5kR0dV63XGwx3TurmU/FUgTUir892B1tz8auisAKaz1RlMRJoiEUcexcoFNf
	 MfFXzXWqVmCT/W5MIIr0bVe8yK4zJWu4qMKv8vWg4zad9ytmmVqI7TdxE0iaumdHcx
	 e4qkjmvI9wBu8JWxXrllQURXI9m8ZWL87IoS/vq/O9xMLQ/Hr+ASTIeUXFUIG8CWnS
	 vdtlV4u1dVv07SyE7/cqZJqf7/koM+zkMvhA8dL3ZxRWgnhckA+HhKTgHlIfNUPM+u
	 E20NFYROekQUA==
Date: Tue, 10 Sep 2024 17:24:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: Linux next breaks s390 test cases perf test vfs_getname
Message-ID: <ZuCrCRfUi6QiRV_3@x1>
References: <3f5eeb1b-6679-4ff5-8046-0cbe1b6e4ba8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f5eeb1b-6679-4ff5-8046-0cbe1b6e4ba8@linux.ibm.com>

On Tue, Sep 10, 2024 at 02:05:42PM +0200, Thomas Richter wrote:
> Arnaldo,
> 
> On linux-next
> commit a68080e1a21b ("perf test vfs_getname: Look for alternative line where to collect the pathname")
> breaks the following tests on s390:
> 
>  # perf test vfs_getname
>  85: Add vfs_getname probe to get syscall args filenames             : FAILED!
>  87: Use vfs_getname probe to get syscall args filenames             : FAILED!
> 120: Check open filename arg using perf trace + vfs_getname          : FAILED!
> 
> I used the linux next kernel from yesterdays build on s390 and the corresponding
> perf tools also built from that kernel repository:
>  # uname -a
>  Linux a35lp62.lnxne.boe 6.11.0-20240909.rc7.git205.100cc857359b.300.fc40.s390x+next #1 SMP Mon Sep  9 20:05:44 CEST 2024 s390x GNU/Linux
>  # perf -v
>  perf version 6.11.0-20240909.rc7.git205.100cc857359b.300.fc40.s390x+next
>  #
> 
> The root cause is a changed regular expression. Before the change the command
> extracts this line and strips everything after the line number:
>  # perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;'
>  79     result->uptr = filename;
>  # perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;' | \
>          sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/'
>  79
>  # perf probe -q "vfs_getname=getname_flags:79 pathname=result->name:string"
>  # echo $?
>  0
>  # perf probe -l
>   probe:vfs_getname    (on getname_flags:79@fs/namei.c with pathname)
>  # perf probe -d '*'
>  Removed event: probe:vfs_getname
>  #
> 
> With your changes the result is slightly different. The first part still matches the
> same line:
>  #perf probe -L getname_flags| grep -E '[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*='
>  79     result->uptr = filename;
> but the sed command does not return the proper line number:
>  # perf probe -L getname_flags| grep -E '[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*=' | \
>         sed -r "s/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*=/\1/"
>  79 filename;
>  #
> The filename; is not stripped and the perf probe command looks like
>  # perf probe -q "vfs_getname=getname_flags:79 filename; pathname=result->name:string"
>  # echo $?
>  254
>  # perf probe -l
>  # perf probe  "vfs_getname=getname_flags:79 filename; pathname=result->name:string"
>  Failed to find the location of the 'filename;' variable at this address.
>  Perhaps it has been optimized out.
>  Use -V with the --range option to show 'filename;' location range.
>   Error: Failed to add events.
>  # 
> 
> 
> The issue is that trailing equal sign (=) in the regular expression:
>  + result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
>  + line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re=" | \
>                  sed -r "s/$result_filename_re=/\1/")
>                                               ^--------here-----
> which prevents word filename; from being stripped away.
> I wonder if this works on x86_64 platforms and if we need a archtecture specific

root@x1:~# perf test getname
 91: Add vfs_getname probe to get syscall args filenames             : Ok
 93: Use vfs_getname probe to get syscall args filenames             : FAILED!
126: Check open filename arg using perf trace + vfs_getname          : Ok
root@x1:~#
root@x1:~# uname -a
Linux x1 6.10.8-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Sep  4 21:41:11 UTC 2024 x86_64 GNU/Linux
root@x1:~#

I forgot to mention the kernel version wher I did that a68080e1a21b
patch, but IIRC it was a recent, locally built kernel (not a distro
kernel, but with the fedora, probably 39, config):

kernel="/boot/vmlinuz-6.11.0-rc5+"

But even with the distro kernel I'm getting the same results:

root@x1:~# perf test getname
 91: Add vfs_getname probe to get syscall args filenames             : Ok
 93: Use vfs_getname probe to get syscall args filenames             : FAILED!
126: Check open filename arg using perf trace + vfs_getname          : Ok
root@x1:~# perf test getname
 91: Add vfs_getname probe to get syscall args filenames             : Ok
 93: Use vfs_getname probe to get syscall args filenames             : FAILED!
126: Check open filename arg using perf trace + vfs_getname          : Ok
root@x1:~# perf test getname
 91: Add vfs_getname probe to get syscall args filenames             : Ok
 93: Use vfs_getname probe to get syscall args filenames             : FAILED!
126: Check open filename arg using perf trace + vfs_getname          : Ok
root@x1:~# perf test getname
 91: Add vfs_getname probe to get syscall args filenames             : Ok
 93: Use vfs_getname probe to get syscall args filenames             : FAILED!
126: Check open filename arg using perf trace + vfs_getname          : Ok
root@x1:~# perf test getname
 91: Add vfs_getname probe to get syscall args filenames             : Ok
 93: Use vfs_getname probe to get syscall args filenames             : FAILED!
126: Check open filename arg using perf trace + vfs_getname          : Ok
root@x1:~# 

With my changes, i.e. what is in perf-tools-next now:

root@x1:~# perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;'
         	result->uptr = filename;
root@x1:~#

So no line number to be found:

root@x1:~# perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;'
perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/'
         	result->uptr = filename;
root@x1:~#

Then, with the change in place:

The first part continues not to find the info:

root@x1:~# perf probe -L getname_flags| grep -E '[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*='
root@x1:~#

Then it falls back to the new way of finding where to put the probe:

root@x1:~# perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re=" 
root@x1:~# perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" 
     73  	result->aname = NULL;
root@x1:~#

Yeah, that = shouldn't be there

root@x1:~# perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/"
73
root@x1:~# line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
root@x1:~# echo $line
73
root@x1:~#

Can you try with the patch below, that ending '=' is noise :-\

- Arnaldo

From 9ccaf9a0ebcff9b4c45c34d92ca97be9926da636 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 10 Sep 2024 17:18:26 -0300
Subject: [PATCH 1/1] perf test shell probe_vfs_getname: Remove extraneous '='
 from probe line number regex

Thomas reported the vfs_getname perf tests failing on s/390, it seems it
was just to some extraneous '=' somehow getting into the regexp, remove
it, now:

  root@x1:~# perf test getname
   91: Add vfs_getname probe to get syscall args filenames             : Ok
   93: Use vfs_getname probe to get syscall args filenames             : FAILED!
  126: Check open filename arg using perf trace + vfs_getname          : Ok
  root@x1:~#

Second one remains a mistery, have to take some time to nail it down.

Testing it:
  
  root@x1:~# uname -a
  Linux x1 6.10.8-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Sep  4 21:41:11 UTC 2024 x86_64 GNU/Linux
  root@x1:~# result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
  root@x1:~# perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/"
  73
  root@x1:~# perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re"
       73       result->aname = NULL;
  root@x1:~# line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
  eroot@x1:~#
  root@x1:~# echo $line
  73
  root@x1:~#

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 0606e693eb59c5e9..5c33ec7a5a63bdb3 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -14,10 +14,10 @@ add_probe_vfs_getname() {
 	add_probe_verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
 		result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
-		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re=" | sed -r "s/$result_filename_re=/\1/")
+		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re" | sed -r "s/$result_filename_re/\1/")
 		if [ -z "$line" ] ; then
 			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
-			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re=" | sed -r "s/$result_aname_re=/\1/")
+			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
 		fi
 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
 		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
-- 
2.46.0

