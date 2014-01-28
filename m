From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf not working for some commands?
Date: Tue, 28 Jan 2014 10:22:03 +0100
Message-ID: <20140128092203.GC1229@krava.brq.redhat.com>
References: <CACTzACVZLm00yVZag5Hf-c_u0tdH+cQT0=8B_XS8BrN5cT2mDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53605 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754473AbaA1JWN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 28 Jan 2014 04:22:13 -0500
Content-Disposition: inline
In-Reply-To: <CACTzACVZLm00yVZag5Hf-c_u0tdH+cQT0=8B_XS8BrN5cT2mDA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Li <android.wm.edu@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Mon, Jan 20, 2014 at 09:58:15PM -0500, David Li wrote:
> Hi everyone,
> I'd like to use perf to profile the monkey command on Android, but I
> got stuck with this.
> 
> Normally, when I run following:
> 
>       monkey -v -p com.google.android.youtube 500
> 
>       -it works (it generates 500 user events for youtube)
> 
> BUT, when I want to get the perf stat of it as follows:
> 
>       perf stat monkey -v -p com.google.android.youtube 500
> 
> I get:
> 
>      monkey: No such file or directory
>      Terminated
> 
> 
> monkey is a command, not a file nor a directory. Why am I getting
> this? Any help will be greatly appreciated!

perf calls execvp to run the command.. make sure
the program is within the PATH variable location

you can where perf searches by:

[jolsa@krava perf]$ strace -fo out ./perf stat krava
Workload failed: No such file or directory
[jolsa@krava perf]$ cat out | grep exec
5308  execve("./perf", ["./perf", "stat", "krava"], [/* 36 vars */]) = 0
5309  execve("/home/jolsa/libexec/perf-core/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/home/jolsa/kernel.org/linux-perf/tools/perf/./krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/usr/lib64/qt-3.3/bin/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/usr/local/bin/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/bin/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/usr/bin/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/usr/local/sbin/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/usr/sbin/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/opt/mocp/bin/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/home/jolsa/.local/bin/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/home/jolsa/bin/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)
5309  execve("/opt/mocp/bin/krava", ["krava"], [/* 37 vars */]) = -1 ENOENT (No such file or directory)

jirka
