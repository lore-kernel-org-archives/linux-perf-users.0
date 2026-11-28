Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795859600;
	b=1cCTSRfvC0HJPfYJWxTYjnxMyTV2J7FopiRxSfZU3VRkKdea45cBXn6p5HjzKhEN/jlU
	 xuOQSkyAcsc+TJo9hjmj1B+kNTBBtcVSITuhFrIVtXGrcFEbmb/kqrLrhDI/wcP8M7WPW
	 P8XIfn0aIJWQQWX1r49KPLY5zGo/4D4XE9BPZOp8wUc8Hj2Qdji9N9Po9wHBBC7f7b8hv
	 zsHt3n8oEl20Etgmmyoxm8L+KG2OuLIamofVmsxYAzQ9sQ3bR5Yf4sIv788RmDUS+vhwj
	 K6POYByOGcGQgPfd857Iy+NSLFWAhstgcih116fpW/Erm0egoJMudckyiEs7tcML5WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795859600;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kIJuoJOwMoYzuNResarcqS9CjqpI3LGQEHBMR89BkG8=;
	b=awZITbLcblyexF2IDJNDEgvwLfjTvP/jCcYTTeZCfoC+5zgf7wZ3YHhqqRC6m2U5jeP8
	 FBkt1peKxH5yQNIN28Dup/KaibG+0NnrEw53Rzij8PJTrBlTIOdljVTtfWvW1kXK1gmSa
	 /fXTfGBj7cvuYnOo6PKNS+4XlJaNKTGEG8g5y8yDrljGpJKtRUKN4gdvxboW5CV+2B1nB
	 rVO4w4QLbs9v02jTyThgWpr4a1mtf/Y+MtdjkpIJ0Ka5SXqXljwY4P8XHm2LOdnrFqvIu
	 lSXYMRrZPEqxoyNnCyM0zySQtpFZoWOvKJAlxjbpzMfF97fqg29amIiSUYC1jZasoRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aQQ4m+04;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B944606A695;
	Sat, 28 Nov 2026 09:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B944606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aQQ4m+04
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AS7N0Dd3647572;
	Sat, 28 Nov 2026 09:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kIJuoJ
	OwMoYzuNResarcqS9CjqpI3LGQEHBMR89BkG8=; b=aQQ4m+045jdohnmJM7LxVU
	8W59Ie9FJSJ+B77I5VPZnMsDELT+Q9LsOZ9mr7MruJE7sYEQ6ryk3nP/cJ3Az+Sx
	DnOwPs2H6km/wOiNsgZKOeWsfEWgtIYui/D7sFj8hZawufR6i3ySSK3Gd4RFPtUd
	1zE5Q6aew+jGXQ279fqcVvpLhshcXMwYf+TBu6q5G6Ev5hvGQtfQgVqhOyhCWn9Q
	FgOxWa7EbHT8OLt7JvXQp690xg6290pp5TyepQ+9hd6InOxCIdc/+ltrsdgQCFcI
	/w8eyoE/kl5UwtEVQ7juvN2TkwFphnZ9Kn1C0Nep8xzqM7KZ3YESGHUu2QfMlCDg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j7pmsrvcy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 09:52:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AS4JJhi4161019;
	Sat, 28 Nov 2026 09:52:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxxc3m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 09:52:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AS9qpF430671130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Nov 2026 09:52:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04E9720040;
	Sat, 28 Nov 2026 09:52:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D98C520049;
	Sat, 28 Nov 2026 09:52:48 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.39.18.169])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 28 Nov 2026 09:52:48 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v4 00/11] perf tools: Enhance namespace and chroot
 handling
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20261125212851.1792988-1-namhyung@kernel.org>
Date: Sat, 28 Nov 2026 15:22:33 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E48728A-861B-4045-9B43-79B61579328E@linux.ibm.com>
References: <20261125212851.1792988-1-namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: WBTCbfThBWqA3zvUpkNh9gopw2zorLkt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI4MDAzOCBTYWx0ZWRfX2f/P/V8P6VI+
 cUAeFJb0hfxYOYiVmyQBNb6iyk9jPhWxiRwcUZVlOCSO1uSzZX0kxubbY8tq7tIhWzdhEjVFijH
 SlxJcid2AtUwDOj3+7toV6R3vUaH3zjkyutHIfSqkrTC2W+ql8DYpkljOoccz7uNZw1vgcEsHFu
 k5FEg9mgX/H2edYnANGXUc/KJXgiDJR5uptPMjBUnMp6Evazt7bxXxFxDIF4XGjCCURtBoO0vzQ
 aN5KgS4kEVw/IigTXig5WRkzNJ1oFIYL9fCeZIemmAxXGiwhKCHrm2SYy06+aTv1Jb2XcPzVs4L
 B4UEBcG7BjSl13iOvFOlpXojx0SXmSaGqXShGBJCVigE1ybz6ZMH7hOAuG7PlKnXVstBBWrKjor
 XzNTktKx7RZUrGwZwDPi9CgnrPU4B8zaN5FnHnKR4C/s8q5Q2ieKcHn9R76lSdfMd6Kj2M5ZqYX
 3Xlf1EYbwGMEOliSgXw==
X-Proofpoint-GUID: -2jZ29OoaXoUt99UoTSTzA3A8vrQKdA1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI4MDAzOCBTYWx0ZWRfX2TYHC0IyuZ8c
 KaNSqmyL8+VpCJnCGdTa29sNzLp9cVuJZhy4kg8c/rE/P/gKLggQZaDh/496LftY/fvSvea1AIY
 01Cyk7wXgbO62vGofF9kh28mk7mRqhQ=
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b0aa476 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4gGa7KWlnP353mt_FawA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-28_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611280038



> On 26 Nov 2026, at 2:58=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> Hello,
>=20
> This series improves namespace and chroot handling when perf accesses
> files from /proc.  It defers reading /proc until namespace info is
> actually needed, verifies thread liveness, matching boot IDs, and
> mount namespace inodes against PID/TID recycling, and avoids entering
> target mount namespaces for host-side files such as the build-id =
cache.
>=20

Hi Namhyung,

Tested on powerpc (ppc64le, 7.4.0-rc4-next-20261124+), with the series
applied on =
git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
and an unpatched perf as baseline.

Boot ID (patches 1, 2):
- perf record writes the boot ID and it matches
  /proc/sys/kernel/random/boot_id.
- perf inject keeps it, and perf inject on a file recorded by an older
  perf does not add one.

Test suite:
  75: Namespace and nsinfo tests
  75.1: boot_id                : Ok
  75.2: init_and_copy          : Ok
  75.3: proc_and_recycled_tid  : Ok
  75.4: thread_liveness        : Ok
  75.5: dso_needs_ns           : Ok
  75.6: mountns_and_chroot     : Ok
  (6 subtests passed, 0 failed)

Lazy nsinfo init (patch 5):
For perf report on a 2-second system-wide recording
(perf record -a -- sleep 2), the number of /proc/<pid>/{ns/mnt,status}
accesses (counted with strace) dropped from 520 to 0, and the report
output is identical.

Two boots (patches 2, 6, 7):
I recorded system-wide while a busy process ran in its own mount
namespace, rebooted, and ran perf report on the old file.
- The report output on the new boot is identical to the one from before
  the reboot, for both patched and unpatched perf.
- I then started a different process with the recorded pid in a private
  mount namespace (via ns_last_pid) and ran perf report again, counting
  with strace:
                                                    setns() calls   =
touches of that pid
    patched, different boot                0                       0
    unpatched, different boot            6                       4
- Control on the same boot with the process still alive:
    patched                                68                17
    unpatched                            30                 4
  so the patched perf still enters the namespace of a live process, and
  stops using /proc when the boot ID differs.


Tested-by: Athira Rajeev <atrajeev@linux.ibm.com>

Namhyung,

FWIW, on the same boot with live processes in other mount namespaces the
patched perf enters the namespace about 2.5x as often as the unpatched
one (70 vs 28 enters, 140 vs 56 setns() calls on a 7844-sample
system-wide recording). It does the same 134 traced openat/stat calls
inside the namespaces, split across more enters, and the trace also
shows extra opens of /proc and reads of /proc/<pid>/task/<tid>/status
(patch 6). No setns() failed and the report output is identical. Is the
increase expected?

How I measured it (./perf is patched, ./save_1/perf is unpatched):

  # a busy process in its own mount namespace, then record system-wide
  unshare -m sh -c 'mount -t tmpfs none /mnt && cp /usr/bin/yes =
/mnt/myyes &&
                    exec /mnt/myyes > /dev/null' &
  pid=3D$!; sleep 1
  ./perf record -a -e cycles:u -o ctl.data -- sleep 3
  kill $pid

  # trace the same file with each binary
strace -f -e trace=3Dsetns,openat,stat,newfstatat -o /tmp/c.new ./perf =
report -i ctl.data --stdio --sort comm,dso,sym
strace -f -e trace=3Dsetns,openat,stat,newfstatat -o /tmp/c.old =
./save_1/perf report -i ctl.data --stdio --sort comm,dso,sym


grep -c 'setns(' /tmp/c.new
grep 'setns(' /tmp/c.new
awk '/setns\(/{ if (inside) { if (cnt=3D=3D0) empty++; inside=3D0 }
                    else { inside=3D1; cnt=3D0; enters++ } next }
         inside { cnt++; total++ }
         END { printf "enters=3D%d empty_enters=3D%d lines_inside=3D%d\n",=

                      enters, empty, total }' /tmp/c.new

grep -c 'setns(' /tmp/c.old
grep 'setns(' /tmp/c.old
awk '/setns\(/{ if (inside) { if (cnt=3D=3D0) empty++; inside=3D0 }
                    else { inside=3D1; cnt=3D0; enters++ } next }
         inside { cnt++; total++ }
         END { printf "enters=3D%d empty_enters=3D%d lines_inside=3D%d\n",=

                      enters, empty, total }' /tmp/c.old

Result:
                       setns  failed  enters  empty  lines inside
  patched       140       0        70          6            134
  unpatched    56       0        28          0             134

  The report output is identical for both.
 The report output is identical for both:
    ./perf report -i ctl.data --stdio --sort comm,dso,sym 2>&1 | grep -v =
'^#' > /tmp/r.new
    ./save_1/perf report -i ctl.data --stdio --sort comm,dso,sym 2>&1 | =
grep -v '^#' > /tmp/r.old
    diff /tmp/r.new /tmp/r.old        # no output

Thanks
Athira

> It's assisted by LLM.
>=20
> v4 changes:
>=20
> * Fix a potential struct thread reference leak on failure in
>   test__nsinfo_thread_liveness().
> * Rebase onto the latest tmp.perf-tools-next (preserving chroot
>   tracking for --lazy-load-symbols in dso__load()).
>=20
> v3: =
https://lore.kernel.org/r/20261123232025.1406560-1-namhyung@kernel.org
>=20
> * Guard evlist before calling evlist__session() in write_boot_id().
> * Repipe PERF_RECORD_HEADER_FEATURE events in perf-inject pipe mode
>   and add a boot ID pipe-injection shell test and unit test.
> * Pin a reference-counted host /proc descriptor across
>   nsinfo__mountns_enter()/exit(), access relative /proc paths via
>   stack-buffered nsinfo__proc_{open,stat,readlink}() helpers instead =
of
>   heap-allocating mntns_path, and handle ENOENT/ESRCH on ns/mnt stat.
> * Skip filename_with_chroot() chroot resolution when
>   nsinfo__need_setns() is set.
> * Add compiler context-analysis lock annotations (__guarded_by,
>   __must_hold, __returns_ctx_lock) for struct nsinfo, host_proc_lock,
>   thread->nsinfo, and __thread__reset_nsinfo(), plus locked accessors.
> * Expand mount namespace tests to verify overmounted /proc during
>   nsinfo__mountns_enter() and own a private mount namespace in
>   enter_private_userns() for clean nsinfo__mountns_exit() restoration.
>=20
> v2: =
https://lore.kernel.org/r/20261116055731.707164-1-namhyung@kernel.org
>=20
> * Keep dso__filename_with_chroot() (guarded by nsinfo__check_proc())
>   instead of calling chroot() inside nsinfo__mountns_enter().
> * Add a mutex lock to struct nsinfo and replace thread->nsinfo safely =
on
>   exec/namespace events rather than mutating shared instances in =
place.
> * Mark offline sessions explicitly, propagate exit on fork replacement
>   and perf_event__exit_del_thread(), and guard sub-thread fallback in
>   thread__e_machine_endian().
> * Gate mount namespace entry for debuginfo/binary probing callers,
>   include distro debuginfo types, and handle build-id lookups in
>   symbol-minimal's dso__load_sym().
> * Add unit and shell tests for namespace, nsinfo, chroot, and boot ID
>   handling.
>=20
> v1: =
https://lore.kernel.org/r/20261023071141.134149-1-namhyung@kernel.org
>=20
> Thanks,
> Namhyung
>=20
>=20
> Namhyung Kim (11):
>  perf tools: Add HEADER_BOOT_ID feature
>  perf tools: Add perf_env__is_same_boot()
>  perf tools: Add nsinfo__new_thread() to track tid
>  perf tools: Add lock to struct nsinfo
>  perf tools: Defer /proc lookup until nsinfo is used
>  perf tools: Verify thread status and mount namespace inode
>  perf tools: Check thread liveness when accessing /proc
>  perf tools: Export filename__read_build_id_ns()
>  perf tools: Only enter mount namespace if necessary
>  perf tools: Scope mount namespace entry in dso__load()
>  perf tests: Add namespace, nsinfo, and boot ID tests
>=20
> .../Documentation/perf.data-file-format.txt   |    5 +
> tools/perf/builtin-inject.c                   |   29 +-
> tools/perf/builtin-trace.c                    |    2 +-
> tools/perf/tests/Build                        |    1 +
> tools/perf/tests/builtin-test.c               |    1 +
> tools/perf/tests/namespaces.c                 | 1189 +++++++++++++++++
> tools/perf/tests/shell/header.sh              |    9 +
> tools/perf/tests/shell/pipe_test.sh           |   21 +
> tools/perf/tests/tests.h                      |    1 +
> tools/perf/util/build-id.c                    |   15 +-
> tools/perf/util/capstone.c                    |    8 +-
> tools/perf/util/debuginfo.c                   |   19 +-
> tools/perf/util/disasm.c                      |    8 +-
> tools/perf/util/dso.c                         |   58 +-
> tools/perf/util/dso.h                         |   34 +
> tools/perf/util/dsos.c                        |   17 +-
> tools/perf/util/env.c                         |   69 +
> tools/perf/util/env.h                         |    4 +
> tools/perf/util/event.c                       |    1 +
> tools/perf/util/header.c                      |   28 +
> tools/perf/util/header.h                      |    1 +
> tools/perf/util/jitdump.c                     |    2 +-
> tools/perf/util/machine.c                     |   16 +-
> tools/perf/util/map.c                         |    2 +-
> tools/perf/util/namespaces.c                  |  439 +++++-
> tools/perf/util/namespaces.h                  |   23 +-
> tools/perf/util/session.c                     |    1 +
> tools/perf/util/symbol-minimal.c              |    4 +-
> tools/perf/util/symbol.c                      |   45 +-
> tools/perf/util/symbol.h                      |    3 +
> tools/perf/util/thread.c                      |   97 +-
> tools/perf/util/thread.h                      |   15 +-
> tools/perf/util/util.c                        |    7 +-
> 33 files changed, 1999 insertions(+), 175 deletions(-)
> create mode 100644 tools/perf/tests/namespaces.c
>=20
> --=20
> 2.56.1.831.g720f3f5937-goog
>=20
>=20

