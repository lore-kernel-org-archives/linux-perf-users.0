From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC 0/6] perf probe: Attempt to improve C++ probing
Date: Mon, 14 May 2018 13:11:54 -0300
Message-ID: <20180514161154.GU13491@kernel.org>
References: <20180513110617.91669-1-automatic+kernel@freyther.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180513110617.91669-1-automatic+kernel@freyther.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Holger Freyther <automatic+kernel@freyther.de>
Cc: linux-perf-users@vger.kernel.org, Holger Hans Peter Freyther <holgar+kernel@google.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Wang Nan <wangnan0@huawei.com>, Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Sun, May 13, 2018 at 07:06:11PM +0800, Holger Freyther escreveu:
> From: Holger Hans Peter Freyther <holgar+kernel@google.com>
 
> Currently perf probe -x app --funcs will list and demangle C++ functions
> but the other probe actions can't work with them. When asking probe to not
> demangle it will not list any of the application symbols creating the
> impression that there are no symbols at all.
 
> Make --funcs --no-demangle list all C++ functions and modify the handling
> for listing code, variables and adding the uprobe work with the demangled
> C++ function name.
 
> I tried to keep this as minimal as possible but having to keep the dso in
> the debuginfo and passing it everywhere to be able to demangle the linkage
> name isn't pretty (and for C++ demangling the struct dso is not of much
> use. Maybe having a static "empty" dso could avoid a lot of the changes).
 
> Maybe the easiest first patch is to default to --no-demangle and change
> the DEFAULT_FUNC_FILTER to not include mangled C++ symbols. The remaining
> tooling would work then.
 
> My test set includes:
 
>  ./perf probe -x . -L "std::vector<int, std::allocator<int> >::at"
>  ./perf probe -x . -L "std::vector<int, std::allocator<int> >::at:2-3"
> 
>  ./perf probe -x . -V "std::vector<int, std::allocator<int> >::at"
>  ./perf probe -x . -V "std::vector<int, std::allocator<int> >::at:2"
>  ./perf probe -x . -V "std::vector<int, std::allocator<int> >::size%return"

Great stuff! Masami already gave his Acked-by, please address Namhyung's
concerns and consider adding a 'perf test' entry for C++ symbols found
in libstdc++, placing some probe in place and then running some program
that uses that function, then parsing the output of some tool using that
probe, something like you'll find in "perf test inet_pton", see:

[acme@jouet perf]$ ls -la tools/perf/tests/shell/
total 28
drwxrwxr-x. 3 acme acme 4096 May 11 11:53 .
drwxrwxr-x. 4 acme acme 4096 May 11 11:53 ..
drwxrwxr-x. 2 acme acme 4096 Apr 12 14:48 lib
-rwxrwxr-x. 1 acme acme  302 Apr 12 14:48 probe_vfs_getname.sh
-rwxrwxr-x. 1 acme acme 2050 May 11 11:53 record+probe_libc_inet_pton.sh
-rwxrwxr-x. 1 acme acme 1185 Apr 12 14:48 record+script_probe_vfs_getname.sh
-rwxrwxr-x. 1 acme acme 1176 Apr 12 14:48 trace+probe_vfs_getname.sh
[acme@jouet perf]$ 

[root@jouet ~]# perf test inet_pton
64: probe libc's inet_pton & backtrace it with ping       : Ok
[root@jouet ~]# perf test -v inet_pton
64: probe libc's inet_pton & backtrace it with ping       :
--- start ---
test child forked, pid 2441
ping 2478 0 143807.377533: probe_libc:inet_pton: (7f7259040e40)
113e40 __GI___inet_pton (/usr/lib64/libc-2.26.so)
e02b4 getaddrinfo (/usr/lib64/libc-2.26.so)
2f40 [unknown] (/usr/bin/ping)
test child finished with 0
---- end ----
probe libc's inet_pton & backtrace it with ping: Ok
[root@jouet ~]#

- Arnaldo
